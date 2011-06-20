Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <openobex-users@lists.sourceforge.net>,
	Nami <nami.li@atheros.com>
Subject: [PATCH openobex 1/3] Add transport format member in fdobex_data struct. Support STREAM and SEQPACKET transport format.
Date: Mon, 20 Jun 2011 13:47:27 +0800
Message-ID: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 include/openobex/obex_const.h |    4 ++++
 lib/fdobex.h                  |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/openobex/obex_const.h b/include/openobex/obex_const.h
index cb7afeb..8acee91 100644
--- a/include/openobex/obex_const.h
+++ b/include/openobex/obex_const.h
@@ -302,6 +302,10 @@ enum obex_rsp_mode {
   OBEX_RSP_MODE_SINGLE = 1, /**< single response mode (SRM) */
 };

+enum fdobex_transport_format{
+	 FDOBEX_MT_STREAM ,
+	 FDOBEX_MT_SEQPACKET
+};
 /* Min, Max and default transport MTU */
 #define OBEX_DEFAULT_MTU	1024
 #define OBEX_MINIMUM_MTU	255
diff --git a/lib/fdobex.h b/lib/fdobex.h
index 07e33ab..6839e77 100644
--- a/lib/fdobex.h
+++ b/lib/fdobex.h
@@ -6,5 +6,6 @@ void fdobex_get_ops(struct obex_transport_ops* ops);

 struct fdobex_data {
 	socket_t writefd; /* write descriptor */
+	enum fdobex_transport_format fmt;
 };
 #endif
--
1.7.1

