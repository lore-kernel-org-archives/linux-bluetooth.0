Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v7 2/5] bnep: Add bnep_new and bnep_free api's
Date: Fri, 20 Dec 2013 13:40:50 +0200
Message-Id: <1387539653-7271-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387539653-7271-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387539653-7271-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactoring connect and disconnect mechanisms. It would be more
convinient for caller to maintain just bnep connection reference
and delete whenever it is not required.
---
 profiles/network/bnep.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 profiles/network/bnep.h |  5 +++++
 2 files changed, 47 insertions(+)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index edf258b..304b9da 100644
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
@@ -377,6 +378,47 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 	return FALSE;
 }
 
+struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role)
+{
+	struct bnep *session;
+	int dup_fd;
+
+	dup_fd = dup(sk);
+	if (dup_fd < 0)
+		return NULL;
+
+	session = g_new0(struct bnep, 1);
+	session->io = g_io_channel_unix_new(dup_fd);
+	session->src = local_role;
+	session->dst = remote_role;
+
+	g_io_channel_set_close_on_unref(session->io, TRUE);
+	session->watch = g_io_add_watch(session->io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) bnep_setup_cb, session);
+
+	return session;
+}
+
+void bnep_free(struct bnep *session)
+{
+	if (!session)
+		return;
+
+	if (session->io) {
+		g_io_channel_shutdown(session->io, FALSE, NULL);
+		g_io_channel_unref(session->io);
+		session->io = NULL;
+	}
+
+	if (session->watch > 0) {
+		g_source_remove(session->watch);
+		session->watch = 0;
+	}
+
+	g_free(session);
+}
+
 int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 								void *data)
 {
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index dd22c40..91ca622 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -21,6 +21,8 @@
  *
  */
 
+struct bnep;
+
 int bnep_init(void);
 int bnep_cleanup(void);
 
@@ -28,6 +30,9 @@ uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
+struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role);
+void bnep_free(struct bnep *session);
+
 int bnep_connadd(int sk, uint16_t role, char *dev);
 int bnep_conndel(const bdaddr_t *dst);
 int bnep_if_up(const char *devname);
-- 
1.8.3.2

