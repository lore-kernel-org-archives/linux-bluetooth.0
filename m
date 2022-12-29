Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08937C3DA7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 12:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiL2MKQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiL2MKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 07:10:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17080E0FA
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 04:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672315812; x=1703851812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjNhLk0KwQL7XbqrPwxNQiHvdWZal/clrXuYISFHnf4=;
  b=I7IlLpKrSSTZRZxrm9aX/EuxrKXhANDfOy5jR9bPr1467SkEp7k1gbwv
   q8r0f9RfzXVj6nK4kaybC6nq60qA3U2mG0NGGEUC01NZ5LzlA7WVC5g4J
   7vC0epmVv4WJgGGvejf6+yR6zZq/IHf747vEiWShKuGl9ECFEXf1umSih
   UY3K8SIm+2c+I40qeXpl3EAYeMVgj1xWYD5PZwVm0blr3nnO0Z1XLcQgR
   OR8mZPzfHrEGHqfqxzgumNsseO/iGUgV31GMWXg8u+UOadFSvn6EptxH2
   AesZGEStmPeCQdMHN5IDwnP+0FWC4BCAB0jDwzZ/QhgtDoTCl3ujjw+gX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="319744734"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="319744734"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777680154"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777680154"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:10:10 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v2 4/6] media-api: Add CompanyID, VendorCodecID, Metadata
Date:   Thu, 29 Dec 2022 17:58:21 +0530
Message-Id: <20221229122821.340073-5-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
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

