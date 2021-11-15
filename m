Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C8CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050ED61A89
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhKOJig (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:38:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:13725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhKOJid (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:38:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230870743"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="230870743"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="734781772"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2021 01:35:35 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/5] avdtp: Add a flag in struct avdtp to control a2dp offload
Date:   Mon, 15 Nov 2021 15:11:04 +0530
Message-Id: <20211115094108.24331-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a flag in struct avdtp and set it based on
the definition of env variable USE_OFFLOAD
---
 profiles/audio/avdtp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d3dfbf96dda3..b6feac0ba4d5 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -409,6 +409,9 @@ struct avdtp {
 
 	/* Attempt stream setup instead of disconnecting */
 	gboolean stream_setup;
+
+	/* use offload for transport */
+	gboolean use_offload;
 };
 
 static GSList *state_callbacks = NULL;
@@ -2425,6 +2428,7 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 							struct queue *lseps)
 {
 	struct avdtp *session;
+	char *use_offload;
 
 	session = g_new0(struct avdtp, 1);
 
@@ -2436,6 +2440,10 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 
 	session->version = get_version(session);
 
+	use_offload = getenv("USE_OFFLOAD");
+	if (use_offload && !strncmp(use_offload, "1", 1))
+		session->use_offload = TRUE;
+
 	if (!chan)
 		return session;
 
-- 
2.17.1

