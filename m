Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D57C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E34961ABD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhKOJij (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:38:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:13725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhKOJie (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:38:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230870747"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="230870747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="734781795"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2021 01:35:37 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/5] avdtp: Add support for offload msft open command
Date:   Mon, 15 Nov 2021 15:11:05 +0530
Message-Id: <20211115094108.24331-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115094108.24331-1-kiran.k@intel.com>
References: <20211115094108.24331-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp offload use case, controller needs to be sent
MSFT avdtp command after opening media transport channel
---
 lib/bluetooth.h        |  3 +++
 profiles/audio/avdtp.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 0fcf412c6c6b..59ef178a563a 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -158,6 +158,9 @@ struct bt_codecs {
 	struct bt_codec codecs[];
 } __attribute__((packed));
 
+#define BT_MSFT_OPEN	20
+#define BT_MSFT_CLOSE	23
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b6feac0ba4d5..1cd4b4472b08 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2352,6 +2352,47 @@ static uint16_t get_version(struct avdtp *session)
 	return ver;
 }
 
+static gboolean avdtp_offload_open(struct avdtp_stream *stream)
+{
+	int sock;
+	struct avdtp_service_capability *cap;
+	GSList *l;
+
+	if (!stream->io)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(stream->io);
+
+	for (l = stream->caps; l ; l = g_slist_next(l)) {
+		cap = l->data;
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+		break;
+	}
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_MSFT_OPEN, cap,
+		       sizeof(*cap) + cap->length))
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean avdtp_offload_close(struct avdtp_stream *stream)
+{
+	int sock;
+
+	if (!stream->io)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(stream->io);
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_MSFT_CLOSE, 0, 0))
+		return FALSE;
+
+	return TRUE;
+}
+
 static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct avdtp *session = user_data;
@@ -2385,6 +2426,13 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 			session->pending_open ? "transport" : "signaling",
 			address);
 
+	if (session->pending_open && session->use_offload) {
+		if (!avdtp_offload_open(session->pending_open)) {
+			avdtp_offload_close(session->pending_open);
+			goto failed;
+		}
+	}
+
 	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
 		DBG("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
 
-- 
2.17.1

