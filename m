Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B476C3DA79
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 15:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiL2P51 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiL2P45 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 10:56:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814112A9F
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672329346; x=1703865346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjNhLk0KwQL7XbqrPwxNQiHvdWZal/clrXuYISFHnf4=;
  b=Hcld1ZzpFkYoXRDYNqX2cx/MiFFcsolhL3UdEECBmZQNIW5MiFIkMmdh
   77fFCR7frajTHQp7PJELZn1T8N9u06gANGPzXLOzzCE6PiqcO3XKe9em1
   2T+E4FlKfoAc7a09iFmOA1mWc1WNUXLDKSjBqKF2BypcHkge/gUWbSNhL
   O4oOAG1MLOZLpw/FSGdRw+G20LjdALlbrapAYrFC6Hs19f58GN8H5/lGG
   fahgZ8tibEkGKHH3SzoWjAu8eteLDO5SnRin5MzV9KWLpsvrU9b4vvb7f
   Yx9+J2SWsueQVPDFevJr8ByBrVEUPZTxz87pDKR/Ig8ToETIvbYz3/fjV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="321139593"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="321139593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 07:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686024508"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="686024508"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 07:55:38 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>,
        Abhay Maheta <mabhay125@gmail.com>
Subject: [PATCH BlueZ v3 4/6] media-api: Add CompanyID, VendorCodecID, Metadata
Date:   Thu, 29 Dec 2022 21:23:01 +0530
Message-Id: <20221229155257.341327-5-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds CompanyID, VendorCodecID, Metadata for RegisterEndpoint method
---
 doc/media-api.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 847f8bee7..7bfa8a52b 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -34,11 +34,29 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 					match the profile specification which
 					is indicated by the UUID.
 
+				uint16_t CompanyID [BAP only]:
+
+					Assigned number of Company ID that the
+					endpoint implements. It should be set to
+					appropriate value when Vendor Specific
+					Codec is used.
+
+				uint16_t VendorCodecID [BAP only]:
+
+					Vendor-specific codec ID that the endpoint
+					implements. It should be set to appropriate
+					value when Vendor Specific Codec is used.
+
 				array{byte} Capabilities:
 
 					Capabilities blob, it is used as it is
 					so the size and byte order must match.
 
+				array{byte} Metadata [BAP only]:
+
+					Metadata blob, it is used as it is
+					so the size and byte order must match.
+
 			Possible Errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotSupported - emitted
 					 when interface for the end-point is
-- 
2.25.1

