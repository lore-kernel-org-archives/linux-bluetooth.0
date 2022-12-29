Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C43C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 12:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiL2MKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiL2MKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 07:10:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE712620
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 04:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672315801; x=1703851801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=haZ63aeQDXjvGiKaqek1vC51gPQbXGUp5JwCERsunkY=;
  b=kdFGi9xwKhPlaZ+DKCk1h9IAunAZ51/0Mua2C+KUCyGEgQL9qar6jeby
   XOEAOJWoubeve6XAhmMoV/iBXnZT1IaluPwTpOTVIyUWId9ES3/cPMyM7
   XGiHCJMvpX5m8ZyPHwvdsGGncaPC+LdE2GfXxQaBgyY6TGvA8qefncJb4
   gj84r1DRSVSgu2+y74En++hfyANwsLfmo0F2YV8w9j3qeHDfJneU0CSrW
   h2idwYbPJa7qD3JVBrwIZRDV1nv60JyxKI1Mcg99VhMpChKEBzVIbsn8o
   WtSZlhX3aJGjg+UxXCOtac7iUbXZECMiMg+i2qpqrRXLm2jFuEfQF/Ghu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="319744714"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="319744714"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777680079"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777680079"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:09:59 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v2 1/6] shared/bap: Fix handling for Company ID and Vendor Codec ID
Date:   Thu, 29 Dec 2022 17:58:18 +0530
Message-Id: <20221229122821.340073-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds fixes for handing for Company ID and Vendor Codec ID
while adding PAC record to database and responding to Attribute
Read Request for Sink/Source PAC Characteristics.
---
 src/shared/bap.c | 5 +++++
 src/shared/bap.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 2919f243f..0cafb75e6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -344,6 +344,8 @@ static void pac_foreach(void *data, void *user_data)
 
 	p = util_iov_push(iov, sizeof(*p));
 	p->codec.id = pac->codec.id;
+	p->codec.cid = pac->codec.cid;
+	p->codec.vid = pac->codec.vid;
 
 	if (pac->data) {
 		p->cc_len = pac->data->iov_len;
@@ -2383,6 +2385,9 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	if (!bdb)
 		return NULL;
 
+	if ((id != 0xff) && ((cid != 0U)  || (vid != 0U)))
+		return NULL;
+
 	codec.id = id;
 	codec.cid = cid;
 	codec.vid = vid;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 3558d0445..47a15636c 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -39,8 +39,8 @@ struct bt_bap_stream;
 
 struct bt_bap_codec {
 	uint8_t  id;
-	uint16_t vid;
 	uint16_t cid;
+	uint16_t vid;
 } __packed;
 
 struct bt_ltv {
-- 
2.25.1

