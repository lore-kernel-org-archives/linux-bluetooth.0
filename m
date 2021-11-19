Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A426C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5207761B1E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhKSJkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:62588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234325AbhKSJkR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297804865"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="297804865"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="594179432"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 01:37:14 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 9/9] avdtp: Add support for MSFT offload close command
Date:   Fri, 19 Nov 2021 15:12:35 +0530
Message-Id: <20211119094235.2432-9-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp offload use case, send MSFT avdtp close
command followed by remote AVDTP close command.
---
 profiles/audio/avdtp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index c0217f272b2c..7619c167e6cf 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2945,6 +2945,24 @@ static gboolean avdtp_start_resp(struct avdtp *session,
 	return TRUE;
 }
 
+static gboolean msft_avdtp_close(struct avdtp_stream *stream)
+{
+	int sock;
+	struct bt_msft cmd;
+
+	if (!stream->io)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(stream->io);
+
+	cmd.sub_opcode = 0x0b;
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_MSFT, &cmd, 1))
+		return FALSE;
+
+	return TRUE;
+}
+
 static gboolean avdtp_close_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
 					struct seid_rej *resp, int size)
@@ -2953,6 +2971,9 @@ static gboolean avdtp_close_resp(struct avdtp *session,
 
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
 
+	if (session->use_offload)
+		msft_avdtp_close(stream);
+
 	close_stream(stream);
 
 	return TRUE;
-- 
2.17.1

