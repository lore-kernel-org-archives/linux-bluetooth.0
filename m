Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Fix crash on error in agent_request_reply
Date: Fri, 28 Oct 2011 12:21:31 +0200
Message-Id: <1319797291-12248-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes regression introduced by
63becff48820dc50a30ae495e286e858a886d9dd, causing obex-client to crash
in cases of e.g. remote site rejecting pushed file.

The req->function set by user of agent API may request agent object
deletion. This in turn checks if agent->pending is set and if it is,
it tries to cancel the pending call and frees pending call data. As at
this point we are already handling call response and we are going to
free this pending call data, agent->pending can be set to NULL prior to
calling req->function, thus preventing premature freeing of later
dereferenced req.
---
 client/agent.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index aa93db3..929a05f 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -114,11 +114,12 @@ static void agent_request_reply(DBusPendingCall *call, void *user_data)
 	struct obc_agent *agent = user_data;
 	struct pending_request *req = agent->pending;
 
+	agent->pending = NULL;
+
 	if (req->function)
 		req->function(call, req->data);
 
 	pending_request_free(req);
-	agent->pending = NULL;
 }
 
 int obc_agent_request(struct obc_agent *agent, const char *path,
-- 
1.7.4.1

