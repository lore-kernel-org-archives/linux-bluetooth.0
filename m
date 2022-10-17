Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C52C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 13:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJQNfE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJQNfD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 09:35:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A91233A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666013702; x=1697549702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4gQTTSH4nkFIZi1ot0slnrsUZrrSz9zYNk8jIRhslQ=;
  b=c8cHm4wbvqIFQUwZPm7qduLBLN9JBXARHONmqeDKbWWfncHL/DjiJIdr
   7zQ9QBT0in89m1Scw6KtUP63naHuB6ozRjVjzU47l2MTtnufhCJW9V7Fm
   QHWl3W5aCQQ9lCyy84q7b15e6B1s/XoLxk60Sg9aH9HFbWVcCoo5I8WoB
   5LUS5N13wEearu6O8nGo6S8yGEg3RUuDg796FSFSU6+RQaf2MAlZ13ETP
   pKJZV+CNUMMGjYggukpeNWtOR1uIoIvhdCuGM/86jRyOn8pNv1tjQ9YfF
   GiUAvv8FmI+KbJgkhZFO/u7uhpggENFfpnMuxwCl1IP/TY5t1SUM5xVFy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="285522178"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="285522178"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 06:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957336362"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="957336362"
Received: from bsbdt.iind.intel.com ([10.224.186.26])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 06:35:01 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v2 1/4] lib/uuid: Add GMCS UUIDs
Date:   Mon, 17 Oct 2022 19:04:37 +0530
Message-Id: <20221017133440.321139-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017133440.321139-1-abhay.maheshbhai.maheta@intel.com>
References: <20221017133440.321139-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds GMCS UUIDs which will be used by Media Control Profile.
---
 lib/uuid.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index f667a74b9..d5e5665e4 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -171,6 +171,21 @@ extern "C" {
 #define VOL_CP_CHRC_UUID				0x2B7E
 #define VOL_FLAG_CHRC_UUID				0x2B7F
 
+#define GMCS_UUID                               0x1849
+#define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
+#define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
+#define MEDIA_TRACK_TITLE_CHRC_UUID             0x2b97
+#define MEDIA_TRACK_DURATION_CHRC_UUID          0x2b98
+#define MEDIA_TRACK_POSTION_CHRC_UUID           0x2b99
+#define MEDIA_PLAYBACK_SPEED_CHRC_UUID          0x2b9a
+#define MEDIA_SEEKING_SPEED_CHRC_UUID           0x2b9b
+#define MEDIA_PLAYING_ORDER_CHRC_UUID           0x2ba1
+#define MEDIA_PLAY_ORDER_SUPPRTD_CHRC_UUID      0x2ba2
+#define MEDIA_STATE_CHRC_UUID                   0x2ba3
+#define MEDIA_CP_CHRC_UUID                      0x2ba4
+#define MEDIA_CP_OP_SUPPORTED_CHRC_UUID         0x2ba5
+#define MEDIA_CONTENT_CONTROL_ID_CHRC_UUID      0x2bba
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.25.1

