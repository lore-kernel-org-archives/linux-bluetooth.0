Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v2] HDP: reject MDL reconnection with different MTU
Date: Fri, 14 Jan 2011 09:50:08 -0200
Message-Id: <1295005808-9885-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Elvis Pfutzenreuter <epx@signove.com>

This patch implements refusal of a MDL reconnection if the new L2CAP
connection presents a different MTU. Accordingly to HDP spec. item 3.5.

It aims to pass the TC_SNK_HCT_BV_07_C PTS test. (It does not pass yet
because PTS itself seems to have issues. See tickets 7212, 7214 and
7244 for details.)
---
 health/hdp.c       |   21 +++++++++++++++++++--
 health/hdp_types.h |    2 ++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index dc1f803..278db68 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -874,6 +874,7 @@ static gboolean check_channel_conf(struct hdp_channel *chan)
 	GError *err = NULL;
 	GIOChannel *io;
 	uint8_t mode;
+	uint16_t imtu, omtu;
 	int fd;
 
 	fd = mcap_mdl_get_fd(chan->mdl);
@@ -883,6 +884,8 @@ static gboolean check_channel_conf(struct hdp_channel *chan)
 
 	if (!bt_io_get(io, BT_IO_L2CAP, &err,
 			BT_IO_OPT_MODE, &mode,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
 			BT_IO_OPT_INVALID)) {
 		error("Error: %s", err->message);
 		g_io_channel_unref(io);
@@ -894,13 +897,27 @@ static gboolean check_channel_conf(struct hdp_channel *chan)
 
 	switch (chan->config) {
 	case HDP_RELIABLE_DC:
-		return mode == L2CAP_MODE_ERTM;
+		if (mode != L2CAP_MODE_ERTM)
+			return FALSE;
+		break;
 	case HDP_STREAMING_DC:
-		return mode == L2CAP_MODE_STREAMING;
+		if (mode != L2CAP_MODE_STREAMING)
+			return FALSE;
+		break;
 	default:
 		error("Error: Connected with unknown configuration");
 		return FALSE;
 	}
+
+	DBG("MDL imtu %d omtu %d Channel imtu %d omtu %d", imtu, omtu,
+						chan->imtu, chan->omtu);
+
+	if (!chan->imtu)
+		chan->imtu = imtu;
+	if (!chan->omtu)
+		chan->omtu = omtu;
+
+	return chan->imtu == imtu && chan->omtu == omtu;
 }
 
 static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
diff --git a/health/hdp_types.h b/health/hdp_types.h
index fffdb32..7d23293 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -120,6 +120,8 @@ struct hdp_channel {
 	uint8_t			config;		/* Channel configuration */
 	uint8_t			mdep;		/* Remote MDEP */
 	uint16_t		mdlid;		/* Data channel Id */
+	uint16_t		imtu;		/* Channel incoming MTU */
+	uint16_t		omtu;		/* Channel outgoing MTU */
 	struct hdp_echo_data	*edata;		/* private data used by echo channels */
 	gint			ref;		/* Reference counter */
 };
-- 
1.7.0.4

