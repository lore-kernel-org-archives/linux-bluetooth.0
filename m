Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v7 3/5] bnep: Add bnep_disconnect and bnep_set_disconnect apis
Date: Fri, 20 Dec 2013 13:40:51 +0200
Message-Id: <1387539653-7271-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387539653-7271-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387539653-7271-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set disconnect call and callback will be triggered by I/O event on
bnep channel. Call bnep_disconnect, it will delete bnep connection
and down the interface, if interface is not up and running do not
use this api, simply call bnep_free.
---
 profiles/network/bnep.c | 35 +++++++++++++++++++++++++++++++++++
 profiles/network/bnep.h |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 304b9da..4bc08d9 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -71,11 +71,15 @@ struct bnep {
 	GIOChannel	*io;
 	uint16_t	src;
 	uint16_t	dst;
+	bdaddr_t	dst_addr;
+	char	iface[16];
 	guint	attempts;
 	guint	setup_to;
 	guint	watch;
 	void	*data;
 	bnep_connect_cb	conn_cb;
+	bnep_disconnect_cb disconn_cb;
+	void	*disconn_data;
 };
 
 static void free_bnep_connect(struct bnep *session)
@@ -447,6 +451,37 @@ int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 	return 0;
 }
 
+void bnep_disconnect(struct bnep *session)
+{
+	if (!session)
+		return;
+
+	if (session->watch > 0) {
+		g_source_remove(session->watch);
+		session->watch = 0;
+	}
+
+	if (session->io) {
+		g_io_channel_unref(session->io);
+		session->io = NULL;
+	}
+
+	bnep_if_down(session->iface);
+	bnep_conndel(&session->dst_addr);
+}
+
+void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
+								void *data)
+{
+	if (!session || !disconn_cb)
+		return;
+
+	if (!session->disconn_cb && !session->disconn_data) {
+		session->disconn_cb = disconn_cb;
+		session->disconn_data = data;
+	}
+}
+
 int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 91ca622..d3c5c1b 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -44,6 +44,10 @@ typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
 								void *data);
 int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 								void *data);
+typedef void (*bnep_disconnect_cb) (void *data);
+void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
+								void *data);
+void bnep_disconnect(struct bnep *session);
 
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
 uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
-- 
1.8.3.2

