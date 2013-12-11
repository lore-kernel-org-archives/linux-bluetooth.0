Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 02/10] bnep: Rename send ctrl_rsp and make it global
Date: Wed, 11 Dec 2013 12:13:37 +0200
Message-Id: <1386756825-934-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Renaming send_bnep_ctrl_rsp to bnep_send_ctrl_rsp and moving
to bnep.h. It is required in android/*.
---
 profiles/network/bnep.c   | 11 +++++++++++
 profiles/network/bnep.h   |  2 ++
 profiles/network/server.c | 13 +------------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index aa980a2..57dfbf9 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -464,3 +464,14 @@ int bnep_del_from_bridge(const char *devname, const char *bridge)
 
 	return 0;
 }
+
+ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
+{
+	struct bnep_control_rsp rsp;
+
+	rsp.type = type;
+	rsp.ctrl = ctrl;
+	rsp.resp = htons(resp);
+
+	return send(sk, &rsp, sizeof(rsp), 0);
+}
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 1905a98..dea0319 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -39,3 +39,5 @@ typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
 								void *data);
 int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 								void *data);
+
+ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
\ No newline at end of file
diff --git a/profiles/network/server.c b/profiles/network/server.c
index c777cc1..296ddd8 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -251,17 +251,6 @@ static sdp_record_t *server_record_new(const char *name, uint16_t id)
 	return record;
 }
 
-static ssize_t send_bnep_ctrl_rsp(int sk, uint16_t val)
-{
-	struct bnep_control_rsp rsp;
-
-	rsp.type = BNEP_CONTROL;
-	rsp.ctrl = BNEP_SETUP_CONN_RSP;
-	rsp.resp = htons(val);
-
-	return send(sk, &rsp, sizeof(rsp), 0);
-}
-
 static int server_connadd(struct network_server *ns,
 				struct network_session *session,
 				uint16_t dst_role)
@@ -462,7 +451,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 	rsp = BNEP_SUCCESS;
 
 reply:
-	send_bnep_ctrl_rsp(sk, rsp);
+	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
 
 	return FALSE;
 }
-- 
1.8.3.2

