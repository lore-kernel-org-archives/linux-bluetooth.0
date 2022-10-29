Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6010C38A02
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ2Qpu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2Qpr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 12:45:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1005A2C2
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667061946; x=1698597946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWQLAf+e+U4adhoGXmTv5r9mQJyc3gg/FNsqP8tZL5Y=;
  b=Ccmo04d8dSFy2fLF7NwvzH89YpmQWQ18VTVKvEma5Z5hfxFEkgkuvByW
   e12yTfDNqaySbdXXM9P6ln6YO3dzCbPJDYeE5S95M7QjwMKpDL5pRsbaN
   cakgkfcTj3MiZdZNGpw3yFcjdVNsZ9uQWfG+MNAar/YkuJi7Xh9qrSYIN
   idOOE+neoLUgqhJR1y1VbdAZLJ2mSOb1z/9G47K8zD19mLk8Ecg+O72YE
   8/JcawuFw1MEg0BI4Ca4PGJguye6gbWyoPp5OjNHYhbauNsGAWjq21lnB
   w8p7wbUq2zz7pLXHijEQ1t3hAHCrZ8/EIO1Mk5LluyizIkI5AhG5LIwFJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289074309"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289074309"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 09:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="666399476"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="666399476"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2022 09:45:45 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 1/5] shared/bap: Fix handling for Company ID and Vendor Codec ID
Date:   Sat, 29 Oct 2022 22:34:04 +0530
Message-Id: <20221029170408.175533-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
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
index c3c0d596f..0ae0eba33 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -416,6 +416,8 @@ static void pac_foreach(void *data, void *user_data)
 
 	p = iov_add(iov, sizeof(*p));
 	p->codec.id = pac->codec.id;
+	p->codec.cid = pac->codec.cid;
+	p->codec.vid = pac->codec.vid;
 
 	if (pac->data) {
 		p->cc_len = pac->data->iov_len;
@@ -2415,6 +2417,9 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	if (!bdb)
 		return NULL;
 
+	if ((id != 0xff) && ((cid != 0U)  || (vid != 0U)))
+		return NULL;
+
 	codec.id = id;
 	codec.cid = cid;
 	codec.vid = vid;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 7b9f88c83..923669f32 100644
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

