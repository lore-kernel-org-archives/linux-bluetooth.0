Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH 5/5] network: Remove sessions from server on DBus call Unregister
Date: Tue, 21 Aug 2012 13:45:55 +0300
Message-Id: <1345545955-13144-6-git-send-email-tomasz.bursztyka@linux.intel.com>
In-Reply-To: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
References: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/server.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 1b9989d..cfad893 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -611,6 +611,8 @@ static void server_disconnect(DBusConnection *conn, void *user_data)
 {
 	struct network_server *ns = user_data;
 
+	server_remove_sessions(ns);
+
 	ns->watch_id = 0;
 
 	if (ns->record_id) {
-- 
1.7.8.6

