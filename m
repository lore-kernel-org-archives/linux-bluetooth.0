Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
Date: Tue, 21 Jun 2011 11:35:42 +0800
Message-ID: <1308627344-8757-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Cc: Nami <nami.li@atheros.com>, openobex-users@lists.sourceforge.net,
	haijun@qca.qualcomm.com, hongfan@qca.qualcomm.com
Subject: [openobex-users] [PATCH v2 openobex 1/3] Add transport format
	member in fdobex_data struct.
Reply-To: openobex-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openobex-users>,
	<mailto:openobex-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openobex-users>
List-Post: <mailto:openobex-users@lists.sourceforge.net>
List-Help: <mailto:openobex-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openobex-users>,
	<mailto:openobex-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: openobex-users-bounces@lists.sourceforge.net
List-ID: <linux-bluetooth.vger.kernel.org>

---
 include/openobex/obex_const.h |    5 +++++
 lib/fdobex.c                  |    1 +
 lib/fdobex.h                  |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/openobex/obex_const.h b/include/openobex/obex_const.h
index cb7afeb..700bacb 100644
--- a/include/openobex/obex_const.h
+++ b/include/openobex/obex_const.h
@@ -302,6 +302,11 @@ enum obex_rsp_mode {
   OBEX_RSP_MODE_SINGLE = 1, /**< single response mode (SRM) */
 };

+enum fdobex_transport_format {
+  FDOBEX_MT_STREAM    = 0, /**< stream transport format */
+  FDOBEX_MT_SEQPACKET = 1, /**< seqpacket transport format */
+};
+
 /* Min, Max and default transport MTU */
 #define OBEX_DEFAULT_MTU	1024
 #define OBEX_MINIMUM_MTU	255
diff --git a/lib/fdobex.c b/lib/fdobex.c
index 45c56ff..7fa4a21 100644
--- a/lib/fdobex.c
+++ b/lib/fdobex.c
@@ -14,6 +14,7 @@
 static int fdobex_init(obex_t *self)
 {
 	self->trans.data.fd.writefd = INVALID_SOCKET;
+	self->trans.data.fd.fmt = FDOBEX_MT_STREAM;

 	return 0;
 }
diff --git a/lib/fdobex.h b/lib/fdobex.h
index 07e33ab..01741c8 100644
--- a/lib/fdobex.h
+++ b/lib/fdobex.h
@@ -6,5 +6,6 @@ void fdobex_get_ops(struct obex_transport_ops* ops);

 struct fdobex_data {
 	socket_t writefd; /* write descriptor */
+	enum fdobex_transport_format fmt;  /* transport format */
 };
 #endif
--
1.7.1


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Openobex-users mailing list
Openobex-users@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/openobex-users
