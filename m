Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47191C3DA79
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 15:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiL2P5E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiL2P4g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 10:56:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571513F8C
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 07:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672329284; x=1703865284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=haZ63aeQDXjvGiKaqek1vC51gPQbXGUp5JwCERsunkY=;
  b=dy+TnMdk4aXJD3zHXzd+hwqWGPU9pyDNGWWOoeYbPdGxhrxNWNeKPxYB
   YMU47c4Djk/tryvtSE1yYz9TTWiKhD8oVq2WRLGc1tDWBaM5KbjDWQ/IX
   OHqGcSfUp1wedFc/S2jlzaJg5QL9BMSLJNIml7KC6kLEHbEB33fa//g5v
   v/6/4YA7BwaZnoNgU5n9jYY5hsiEi73CfjZWqnpMN2BbkDtD0tudZ//Yr
   DjaE3XdNtTpPxKihBJGFEKwY/j58ROD4g0+je8YVoPxgzxkH9AgWBLP5+
   4uz3SK7mXfShPYZNrQBn/8Ha34wZ5ZdreMKF+Pw5mYprkj8c3B3wtCCAB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="321139290"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="321139290"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 07:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686024317"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="686024317"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 07:54:42 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>,
        Abhay Maheta <mabhay125@gmail.com>
Subject: [PATCH BlueZ v3 1/6] shared/bap: Fix handling for Company ID and Vendor Codec ID
Date:   Thu, 29 Dec 2022 21:22:55 +0530
Message-Id: <20221229155257.341327-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
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

