Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v6 3/5] bnep: Add bnep_new and bnep_free api's
Date: Thu, 19 Dec 2013 16:39:41 +0200
Message-Id: <1387463983-6373-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387463983-6373-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387463983-6373-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refacoring connect and disconnect mechanisms. It would be more
convinient for caller to maintain just bnep connection reference
and delete whenever it is not required.
---
 profiles/network/bnep.c | 35 +++++++++++++++++++++++++++++++++++
 profiles/network/bnep.h |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 02e2647..d09f369 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -73,6 +73,7 @@ struct bnep {
 	uint16_t	dst;
 	guint	attempts;
 	guint	setup_to;
+	guint	watch;
 	void	*data;
 	bnep_connect_cb	conn_cb;
 };
@@ -377,6 +378,40 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 	return FALSE;
 }
 
+struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role)
+{
+	struct bnep *b;
+
+	b = g_new0(struct bnep, 1);
+	b->io = g_io_channel_unix_new(sk);
+	b->src = local_role;
+	b->dst = remote_role;
+
+	b->watch = g_io_add_watch_full(b->io, G_PRIORITY_LOW,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) bnep_setup_cb, b, NULL);
+
+	return b;
+}
+
+void bnep_free(struct bnep *b)
+{
+	if (!b)
+		return;
+
+	if (b->io) {
+		g_io_channel_unref(b->io);
+		b->io = NULL;
+	}
+
+	if (b->watch > 0) {
+		g_source_remove(b->watch);
+		b->watch = 0;
+	}
+
+	g_free(b);
+}
+
 int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 								void *data)
 {
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index dd22c40..091a7f2 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -21,6 +21,8 @@
  *
  */
 
+struct bnep;
+
 int bnep_init(void);
 int bnep_cleanup(void);
 
@@ -28,6 +30,8 @@ uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
+struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role);
+void bnep_free(struct bnep *b);
 int bnep_connadd(int sk, uint16_t role, char *dev);
 int bnep_conndel(const bdaddr_t *dst);
 int bnep_if_up(const char *devname);
-- 
1.8.3.2

