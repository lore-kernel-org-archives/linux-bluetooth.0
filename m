Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8DD61A89
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhKOJio (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:38:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:13725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhKOJij (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:38:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230870763"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="230870763"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:35:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="734781819"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2021 01:35:43 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 5/5] avdtp: Add support for offload msft close command
Date:   Mon, 15 Nov 2021 15:11:08 +0530
Message-Id: <20211115094108.24331-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115094108.24331-1-kiran.k@intel.com>
References: <20211115094108.24331-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp offload use case, send MSFT avdtp close
command followed by remote AVDTP close command.
---
 profiles/audio/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d5e8c7856be3..3ee5f30967f0 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2953,6 +2953,9 @@ static gboolean avdtp_close_resp(struct avdtp *session,
 
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
 
+	if (session->use_offload)
+		avdtp_offload_close(stream);
+
 	close_stream(stream);
 
 	return TRUE;
-- 
2.17.1

