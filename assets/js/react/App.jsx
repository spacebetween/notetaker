import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";
import { ApolloClient, InMemoryCache } from '@apollo/client';
import { ApolloProvider } from '@apollo/client/react';
import List from "./components/list.jsx";

const client = new ApolloClient({
  uri: '/graphql',
  cache: new InMemoryCache()
});

const App = () => {
  return (
    <ApolloProvider client={client}>
      <Router basename="/notes">
        <Switch>
          <Route path="/" component={List} />
        </Switch>
      </Router>
    </ApolloProvider>
  )
}

export default App;
