Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739F7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D28C61B04
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhKSJkM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:62588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhKSJkL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297804849"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="297804849"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="594179396"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 01:37:08 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 6/9] avdtp: Add support for offload MSFT open command
Date:   Fri, 19 Nov 2021 15:12:32 +0530
Message-Id: <20211119094235.2432-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp offload use case, controller needs to be sent
MSFT avdtp command after opening media transport channel
---
 lib/bluetooth.h        |  7 +++++++
 profiles/audio/avdtp.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 0fcf412c6c6b..b4bbe1373403 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -158,6 +158,13 @@ struct bt_codecs {
 	struct bt_codec codecs[];
 } __attribute__((packed));
 
+#define BT_MSFT		20
+struct bt_msft {
+	uint8_t sub_opcode;
+	uint8_t len;
+	uint8_t data[];
+} __attribute__((packed));
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 58d419fb3148..6a56bd4507c4 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2352,6 +2352,47 @@ static uint16_t get_version(struct avdtp *session)
 	return ver;
 }
 
+static gboolean msft_avdtp_open(struct avdtp_stream *stream)
+{
+	int sock;
+	struct avdtp_service_capability *caps = NULL;
+	struct bt_msft *cmd;
+	GSList *l;
+
+	if (!stream->io)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(stream->io);
+
+	for (l = stream->caps; l ; l = g_slist_next(l)) {
+		caps = l->data;
+
+		if (caps->category != AVDTP_MEDIA_CODEC) {
+			caps = NULL;
+			continue;
+		}
+		break;
+	}
+
+	if (!caps)
+		return FALSE;
+
+	cmd = g_malloc0(sizeof(*cmd) + sizeof(*caps) + caps->length);
+	cmd->sub_opcode = 0x08;
+	cmd->len = sizeof(*caps) + caps->length;
+	memcpy(cmd->data, caps, cmd->len);
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_MSFT, cmd,
+		       sizeof(*cmd) + cmd->len)) {
+		g_free(cmd);
+		return FALSE;
+	}
+
+	g_free(cmd);
+
+	return TRUE;
+}
+
 static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct avdtp *session = user_data;
@@ -2385,6 +2426,11 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 			session->pending_open ? "transport" : "signaling",
 			address);
 
+	if (session->pending_open && session->use_offload) {
+		if (!msft_avdtp_open(session->pending_open))
+			goto failed;
+	}
+
 	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
 		DBG("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
 
-- 
2.17.1

