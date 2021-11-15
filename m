Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27578C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED39C61A89
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhKOJil (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:38:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:13725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhKOJif (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:38:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230870751"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="230870751"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="734781808"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2021 01:35:39 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/5] avdtp: Add support for offload msft start command
Date:   Mon, 15 Nov 2021 15:11:06 +0530
Message-Id: <20211115094108.24331-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115094108.24331-1-kiran.k@intel.com>
References: <20211115094108.24331-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Send MSFT avdtp start command to trigger a2dp offload
streaming after sending remote AVDTP start command.
---
 lib/bluetooth.h        |  1 +
 profiles/audio/avdtp.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 59ef178a563a..32a3b5f0c2b9 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -159,6 +159,7 @@ struct bt_codecs {
 } __attribute__((packed));
 
 #define BT_MSFT_OPEN	20
+#define BT_MSFT_START	21
 #define BT_MSFT_CLOSE	23
 
 /* Connection and socket states */
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1cd4b4472b08..1ae96e3e8a07 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2910,6 +2910,21 @@ static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stre
 	return TRUE;
 }
 
+static gboolean avdtp_offload_start(struct avdtp_stream *stream)
+{
+	int sock;
+
+	if (!stream->io)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(stream->io);
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_MSFT_START, 0, 0))
+		return FALSE;
+
+	return TRUE;
+}
+
 static gboolean avdtp_start_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
 					struct seid_rej *resp, int size)
@@ -2924,6 +2939,9 @@ static gboolean avdtp_start_resp(struct avdtp *session,
 	if (sep->state != AVDTP_STATE_STREAMING)
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_STREAMING);
 
+	if (session->use_offload)
+		avdtp_offload_start(stream);
+
 	return TRUE;
 }
 
-- 
2.17.1

