Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 5/5] bnep: Refactored bnep server apis for bridge addition and deletion
Date: Thu, 19 Dec 2013 10:48:53 +0200
Message-Id: <1387442933-20681-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To simplify bnep server realted bridge creation and deletion calls
provided extra apis and moved existing apis to static.
---
 profiles/network/bnep.c   | 50 +++++++++++++++++++++++++++++++++++++++++------
 profiles/network/bnep.h   |  9 +++------
 profiles/network/server.c | 37 +++--------------------------------
 3 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index b7c3835..90728d3 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -151,7 +151,7 @@ int bnep_cleanup(void)
 	return 0;
 }
 
-int bnep_conndel(const bdaddr_t *dst)
+static int bnep_conndel(const bdaddr_t *dst)
 {
 	struct bnep_conndel_req req;
 
@@ -167,7 +167,7 @@ int bnep_conndel(const bdaddr_t *dst)
 	return 0;
 }
 
-int bnep_connadd(int sk, uint16_t role, char *dev)
+static int bnep_connadd(int sk, uint16_t role, char *dev)
 {
 	struct bnep_connadd_req req;
 
@@ -187,7 +187,7 @@ int bnep_connadd(int sk, uint16_t role, char *dev)
 	return 0;
 }
 
-int bnep_if_up(const char *devname)
+static int bnep_if_up(const char *devname)
 {
 	struct ifreq ifr;
 	int sk, err;
@@ -212,7 +212,7 @@ int bnep_if_up(const char *devname)
 	return 0;
 }
 
-int bnep_if_down(const char *devname)
+static int bnep_if_down(const char *devname)
 {
 	struct ifreq ifr;
 	int sk, err;
@@ -455,7 +455,7 @@ guint bnep_set_watchdog(struct bnep *b, GIOFunc watchdog, void *data)
 	return ret;
 }
 
-int bnep_add_to_bridge(const char *devname, const char *bridge)
+static int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
 	struct ifreq ifr;
@@ -486,7 +486,7 @@ int bnep_add_to_bridge(const char *devname, const char *bridge)
 	return 0;
 }
 
-int bnep_del_from_bridge(const char *devname, const char *bridge)
+static int bnep_del_from_bridge(const char *devname, const char *bridge)
 {
 	int ifindex = if_nametoindex(devname);
 	struct ifreq ifr;
@@ -592,3 +592,41 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 
 	return BNEP_SUCCESS;
 }
+
+int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
+						const bdaddr_t *addr)
+{
+	if (!bridge || !bridge || !iface || !addr)
+		return -EINVAL;
+
+	if (bnep_connadd(sk, dst, iface) < 0) {
+		error("Can't add connection to the bridge %s: %s(%d)",
+						bridge, strerror(errno), errno);
+		return -errno;
+	}
+
+	if (bnep_add_to_bridge(iface, bridge) < 0) {
+		error("Can't add %s to the bridge %s: %s(%d)",
+					iface, bridge, strerror(errno), errno);
+		bnep_conndel(addr);
+		return -errno;
+	}
+
+	if (bnep_if_up(iface) < 0) {
+		error("Can't up the interface %s: %s(%d)",
+						iface, strerror(errno), errno);
+		return -errno;
+	}
+
+	return 0;
+}
+
+void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
+{
+	if (!bridge || !iface || !addr)
+		return;
+
+	bnep_del_from_bridge(iface, bridge);
+	bnep_if_down(iface);
+	bnep_conndel(addr);
+}
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 46199df..3447f6e 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -32,12 +32,6 @@ const char *bnep_name(uint16_t id);
 
 struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role);
 void bnep_free(struct bnep *b);
-int bnep_connadd(int sk, uint16_t role, char *dev);
-int bnep_conndel(const bdaddr_t *dst);
-int bnep_if_up(const char *devname);
-int bnep_if_down(const char *devname);
-int bnep_add_to_bridge(const char *devname, const char *bridge);
-int bnep_del_from_bridge(const char *devname, const char *bridge);
 
 typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
 int bnep_connect(struct bnep *b, bnep_connect_cb conn_cb, void *data);
@@ -48,3 +42,6 @@ ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
 uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
 uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 								uint16_t *src);
+int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
+							const bdaddr_t *addr);
+void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 73741ec..7cb5a1e 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -251,35 +251,6 @@ static sdp_record_t *server_record_new(const char *name, uint16_t id)
 	return record;
 }
 
-static int server_connadd(struct network_server *ns,
-				struct network_session *session,
-				uint16_t dst_role)
-{
-	char devname[16];
-	int err, nsk;
-
-	nsk = g_io_channel_unix_get_fd(session->io);
-	err = bnep_connadd(nsk, dst_role, devname);
-	if (err < 0)
-		return err;
-
-	info("Added new connection: %s", devname);
-
-	if (bnep_add_to_bridge(devname, ns->bridge) < 0) {
-		error("Can't add %s to the bridge %s: %s(%d)",
-				devname, ns->bridge, strerror(errno), errno);
-		return -EPERM;
-	}
-
-	bnep_if_up(devname);
-
-	strncpy(session->dev, devname, sizeof(devname));
-
-	ns->sessions = g_slist_append(ns->sessions, session);
-
-	return 0;
-}
-
 static void session_free(void *data)
 {
 	struct network_session *session = data;
@@ -377,7 +348,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 		goto reply;
 	}
 
-	if (server_connadd(ns, na->setup, dst_role) < 0)
+	if (bnep_server_add(sk, dst_role, ns->bridge, na->setup->dev,
+							&na->setup->dst) < 0)
 		goto reply;
 
 	na->setup = NULL;
@@ -524,10 +496,7 @@ static void server_remove_sessions(struct network_server *ns)
 		if (*session->dev == '\0')
 			continue;
 
-		bnep_del_from_bridge(session->dev, ns->bridge);
-		bnep_if_down(session->dev);
-
-		bnep_conndel(&session->dst);
+		bnep_server_delete(ns->bridge, session->dev, &session->dst);
 	}
 
 	g_slist_free_full(ns->sessions, session_free);
-- 
1.8.3.2

