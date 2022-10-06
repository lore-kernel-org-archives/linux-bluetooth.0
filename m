Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94992C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 14:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJFOfZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJFOfX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:35:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F61B80BEE
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665066922; x=1696602922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4gQTTSH4nkFIZi1ot0slnrsUZrrSz9zYNk8jIRhslQ=;
  b=g/LUoXcYAR/oUpM0Ycs18rEkNv12eq3clfo7n3G092TuKtu3OM2GfzLn
   Lb5uCiGAdHWM1G7kqUyIk5eRIGYoWFUL1uz+gIcvfsecsLR4P8elDcOi+
   4kwvuPH8+Q9vhlHkHuyQqjvY2SZANgAvUrDVcHav7iVQsaRx3VBMbse82
   rl0Q0nG19yYvkSpM/oYSKniEf/zYgzl5q0kezPQxwCh1yQW9lB59h2MS9
   m93B6nVRHUmEoRBIkCfa+mhyaz76UYMFOjkoC2yBHvmxntiRJFqqkrEJT
   wNaXbAG9AKaOZ0xVLxQwHL0AaccpkMP7ZTKYf337B6vDhnoXAH+lLCkji
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="305039100"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="305039100"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 07:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693373389"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="693373389"
Received: from bsbdt.iind.intel.com ([10.224.186.26])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2022 07:35:04 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 1/4] lib/uuid: Add GMCS UUIDs
Date:   Thu,  6 Oct 2022 20:03:40 +0530
Message-Id: <20221006143343.199055-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006143343.199055-1-abhay.maheshbhai.maheta@intel.com>
References: <20221006143343.199055-1-abhay.maheshbhai.maheta@intel.com>
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

