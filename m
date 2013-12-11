Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 01/10] bnep: Rename bnep_kill_connection to bnep_conndel
Date: Wed, 11 Dec 2013 12:13:36 +0200
Message-Id: <1386756825-934-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Renaming bnep_kill_connection to bnep_conndel to maintain
consistency with bnep_connadd function name.
---
 android/pan.c                 | 2 +-
 profiles/network/bnep.c       | 2 +-
 profiles/network/bnep.h       | 3 +--
 profiles/network/connection.c | 2 +-
 profiles/network/server.c     | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 6b098b2..f74f1a7 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -288,7 +288,7 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	}
 
 	bnep_if_down(dev->iface);
-	bnep_kill_connection(&dst);
+	bnep_conndel(&dst);
 
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 	pan_device_free(dev);
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 912c0c2..aa980a2 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -160,7 +160,7 @@ int bnep_cleanup(void)
 	return 0;
 }
 
-int bnep_kill_connection(const bdaddr_t *dst)
+int bnep_conndel(const bdaddr_t *dst)
 {
 	struct bnep_conndel_req req;
 
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 9043e46..1905a98 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -28,9 +28,8 @@ uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
-int bnep_kill_connection(const bdaddr_t *dst);
-
 int bnep_connadd(int sk, uint16_t role, char *dev);
+int bnep_conndel(const bdaddr_t *dst);
 int bnep_if_up(const char *devname);
 int bnep_if_down(const char *devname);
 int bnep_add_to_bridge(const char *devname, const char *bridge);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 9aff319..fb3e1ce 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -171,7 +171,7 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
 
 	if (nc->state == CONNECTED) {
 		bnep_if_down(nc->dev);
-		bnep_kill_connection(device_get_address(nc->peer->device));
+		bnep_conndel(device_get_address(nc->peer->device));
 	} else if (nc->io)
 		cancel_connection(nc, -EIO);
 }
diff --git a/profiles/network/server.c b/profiles/network/server.c
index b3aab11..c777cc1 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -608,7 +608,7 @@ static void server_remove_sessions(struct network_server *ns)
 		bnep_del_from_bridge(session->dev, ns->bridge);
 		bnep_if_down(session->dev);
 
-		bnep_kill_connection(&session->dst);
+		bnep_conndel(&session->dst);
 	}
 
 	g_slist_free_full(ns->sessions, session_free);
-- 
1.8.3.2

