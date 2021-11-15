Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778F6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8C961BFE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKOJim (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:38:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:13725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhKOJih (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:38:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230870760"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="230870760"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="734781814"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2021 01:35:41 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 4/5] avdtp: Add support for offload msft suspend command
Date:   Mon, 15 Nov 2021 15:11:07 +0530
Message-Id: <20211115094108.24331-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115094108.24331-1-kiran.k@intel.com>
References: <20211115094108.24331-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp offload use case, send MSFT avdtp suspend command
followed by remote AVDTP suspend command.
---
 lib/bluetooth.h        |  1 +
 profiles/audio/avdtp.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 32a3b5f0c2b9..2bd253aeeed4 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -160,6 +160,7 @@ struct bt_codecs {
 
 #define BT_MSFT_OPEN	20
 #define BT_MSFT_START	21
+#define BT_MSFT_SUSPEND 22
 #define BT_MSFT_CLOSE	23
 
 /* Connection and socket states */
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1ae96e3e8a07..d5e8c7856be3 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2958,6 +2958,21 @@ static gboolean avdtp_close_resp(struct avdtp *session,
 	return TRUE;
 }
 
+static gboolean avdtp_offload_suspend(struct avdtp_stream *stream)
+{
+	int sock;
+
+	if (!stream->io)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(stream->io);
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_MSFT_SUSPEND, 0, 0))
+		return FALSE;
+
+	return TRUE;
+}
+
 static gboolean avdtp_suspend_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
 					void *data, int size)
@@ -2969,6 +2984,9 @@ static gboolean avdtp_suspend_resp(struct avdtp *session,
 	if (sep->cfm && sep->cfm->suspend)
 		sep->cfm->suspend(session, sep, stream, NULL, sep->user_data);
 
+	if (session->use_offload)
+		avdtp_offload_suspend(stream);
+
 	return TRUE;
 }
 
-- 
2.17.1

