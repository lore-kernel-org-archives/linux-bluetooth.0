Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/6] bnep: Add bnep_new and bnep_free api's
Date: Tue, 17 Dec 2013 00:05:13 +0200
Message-Id: <1387231516-4127-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refacoring connect and disconnect mechanisms. It would be more
convinient for caller to maintain just bnep connection reference
and delete whenever it is not required.
---
 profiles/network/bnep.c | 37 +++++++++++++++++++++++++++++++++++++
 profiles/network/bnep.h |  5 +++++
 2 files changed, 42 insertions(+)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 08037e6..d7d8832 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -71,6 +71,7 @@ struct bnep_conn {
 	GIOChannel	*io;
 	uint16_t	src;
 	uint16_t	dst;
+	bdaddr_t	dst_addr;
 	guint	attempts;
 	guint	setup_to;
 	void	*data;
@@ -246,6 +247,42 @@ int bnep_if_down(const char *devname)
 	return 0;
 }
 
+struct bnep_conn *bnep_new(uint16_t src, uint16_t dst,
+						const bdaddr_t *dst_addr)
+{
+	struct bnep_conn *bc;
+
+	DBG("");
+
+	if (!dst_addr)
+		return NULL;
+
+	bc = g_new0(struct bnep_conn, 1);
+	if (!bc)
+		return NULL;
+
+	bc->src = src;
+	bc->dst = dst;
+	bacpy(&bc->dst_addr, dst_addr);
+
+	return bc;
+}
+
+void bnep_free(struct bnep_conn *bc)
+{
+	DBG("");
+
+	if (!bc)
+		return;
+
+	if (bc->io) {
+		g_io_channel_unref(bc->io);
+		bc->io = NULL;
+	}
+
+	g_free(bc);
+}
+
 static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index dd22c40..9c28899 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -21,6 +21,8 @@
  *
  */
 
+struct bnep_conn;
+
 int bnep_init(void);
 int bnep_cleanup(void);
 
@@ -28,6 +30,9 @@ uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
+struct bnep_conn *bnep_new(uint16_t src, uint16_t dst,
+						const bdaddr_t *dst_addr);
+void bnep_free(struct bnep_conn *bnep);
 int bnep_connadd(int sk, uint16_t role, char *dev);
 int bnep_conndel(const bdaddr_t *dst);
 int bnep_if_up(const char *devname);
-- 
1.8.3.2

