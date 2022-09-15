Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB55EECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 09:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIOJ52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIOJ47 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 05:56:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769E9D13C
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663235561; x=1694771561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ht6nn4WcjjYgyhJ/X9moFdKrEdk9j0FtChwAwCGQYEs=;
  b=axgQ4KPefpm0j4p1fsdVFUtu25RY1xFD/7tjEwb1Z2pGXkmzg3PSKO3i
   FWOROGnIQFd1hqa+9U7X2xSpiula2plFVTxQZejYYPL9OA30aYTjauJNd
   kjQFNHUfw22SA20vfQCCLYtXRX3sGQbxhsDyFhroxhu6NiZNCBAsGtkXm
   EMpQfEJ0SR1yQxtvsJ4B0vDaOO/dtQpXqxJzR7h7e4FXB9r1aTq2sq0VG
   OxohBtDRBRgwnUziAzGCULj5VTFXHu0qRUyOYPx79aXcU0LpePAhUcbYv
   6bodKc8vs66K4/dbWDXss89bfFxlm8FhWhq9HLZILzNap3p3LRndRdl2Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285709653"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="285709653"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 02:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="945885985"
Received: from bsblt022.iind.intel.com ([10.224.186.21])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 02:52:37 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v2 1/4] lib/uuid: Add VCS UUIDs
Date:   Thu, 15 Sep 2022 15:24:09 +0530
Message-Id: <20220915095412.462210-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds Volume Control Service UUIDs which will be used by
Volume Control Profile.
---
 lib/uuid.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index cb9294be8c6e..f667a74b9b73 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -164,6 +164,13 @@ extern "C" {
 #define ASE_SOURCE_UUID					0x2bc5
 #define ASE_CP_UUID					0x2bc6
 
+#define VCS_UUID					0x1844
+#define VOL_OFFSET_CS_UUID				0x1845
+#define AUDIO_INPUT_CS_UUID				0x1843
+#define VOL_STATE_CHRC_UUID				0x2B7D
+#define VOL_CP_CHRC_UUID				0x2B7E
+#define VOL_FLAG_CHRC_UUID				0x2B7F
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.25.1

