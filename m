Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 04:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJREir (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 00:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJREiq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 00:38:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023BA027F
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 21:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666067925; x=1697603925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4gQTTSH4nkFIZi1ot0slnrsUZrrSz9zYNk8jIRhslQ=;
  b=fO6XuLaYIexAY7oCLfKLCfb+tn4KeOYen7gzGNeMiZkOcwQm+ekqTWWp
   50QXMGlISAS4Jm3E4ZupGuxBoLBsDaBOk9GH2p+dLYRGYz8h4nrJfA6mD
   xU2oCU6pcyeVEcyLMaa52UK7A645h0qahvgHUmNervIuE2pwGVcAQQxab
   W4xv1Rc+Qm7k9pBnv3DYrvAIfBvxWaSH0/ftJSJ/QGwDb8B1SkBy4cImJ
   zbVGWZBZOUKccZZzLP3/fdo/kD0+92b1jDTfH1Fjqnuo3VKjwTh4KhKtz
   v/1433OEAKol1bCbOb29DAzg7RIfvGrmCO+GIrRVyDOyaU89vDBGKT5e1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307079217"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307079217"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 21:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957608028"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="957608028"
Received: from bsbdt.iind.intel.com ([10.224.186.26])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 21:38:44 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v3 1/4] lib/uuid: Add GMCS UUIDs
Date:   Tue, 18 Oct 2022 10:08:28 +0530
Message-Id: <20221018043831.342821-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018043831.342821-1-abhay.maheshbhai.maheta@intel.com>
References: <20221018043831.342821-1-abhay.maheshbhai.maheta@intel.com>
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

