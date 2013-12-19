Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 3/5] bnep: Add bnep_new and bnep_free api's
Date: Thu, 19 Dec 2013 10:48:51 +0200
Message-Id: <1387442933-20681-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refacoring connect and disconnect mechanisms. It would be more
convinient for caller to maintain just bnep connection reference
and delete whenever it is not required.
---
 profiles/network/bnep.c | 25 +++++++++++++++++++++++++
 profiles/network/bnep.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 02e2647..f3ed63b 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -246,6 +246,31 @@ int bnep_if_down(const char *devname)
 	return 0;
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
+	g_free(b);
+}
+
 static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
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

