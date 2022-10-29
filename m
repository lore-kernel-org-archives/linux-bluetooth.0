Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78DBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 16:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ2Qp4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJ2Qpy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 12:45:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD25A3FD
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667061951; x=1698597951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6W9gi56VXuiTb15do5GFmvkHf+XTDSXokzqw3YtTp20=;
  b=RSLlGEJzFU3uDniuy0vaoP9sGevjpI9djWm006qw8C6uJgQhsSdbWgM2
   ySEOn+vEF5zig9zHbMXl5ViUviLJM2fy+pd52Yd5YQG+XBGqmle7Xzb9N
   NJAKIO5WRRLtWRsBlkOYYmdluhklsvc+zWxa+e4gSsmE5JqtcwBo60A+p
   si/toRMVp2AoMmn2JZBqNTqgiwnjQIFs53yKY3HF2BxrcxpTlHPz1XjPT
   9Szr6KVXxgn+CyTeh1Sqn7aGMxFvLa7eg6E1mOGAEdxtwnkNFwFFQT1ll
   URAkTqXxLw3DqfrToGDfiM97qZmeAGb+CvVSV7+ffUk5NU1xTLJpI1Yv9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289074313"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289074313"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 09:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="666399491"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="666399491"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2022 09:45:49 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 4/5] media-api: Add CompanyID, VendorCodecID, Metadata
Date:   Sat, 29 Oct 2022 22:34:07 +0530
Message-Id: <20221029170408.175533-5-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>

This adds CompanyID, VendorCodecID, Metadata for RegisterEndpoint method
---
 doc/media-api.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 847f8bee7..ce2b74e53 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -34,11 +34,29 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 					match the profile specification which
 					is indicated by the UUID.
 
+				uint16_t CompanyID:
+
+					Assigned number of Company ID that the
+					endpoint implements. It should be set to
+					appropriate value when Vendor Specific
+					Codec is used.
+
+				uint16_t VendorCodecID:
+
+					Vendor-specific codec ID that the endpoint
+					implements. It should be set to appropriate
+					value when Vendor Specific Codec is used.
+
 				array{byte} Capabilities:
 
 					Capabilities blob, it is used as it is
 					so the size and byte order must match.
 
+				array{byte} Metadata:
+
+					Metadata blob, it is used as it is
+					so the size and byte order must match.
+
 			Possible Errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotSupported - emitted
 					 when interface for the end-point is
-- 
2.25.1

