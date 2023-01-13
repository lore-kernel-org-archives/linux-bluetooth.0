Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3DDC54EBE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 05:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjAMFGT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 00:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAMFGP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 00:06:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4F13CC0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 21:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673586373; x=1705122373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xibHF4Rx49aQDlgxbf/eboSogVxmbrDDbEEj2z5HdmA=;
  b=gd9FtTTqfy+Sq2yTARIk5P9pioNWDz8gmXBSwCj3u8d+W7cFR8LyFFb5
   aVlS8cQLPUev14vv5F5RkkA7UjDqoKPPF/RjX/GJUNFyuo8snA5MPNLgi
   iZRp7OIwBE6wIRSKkGxp7vJnJt9U7OtyrbMnQHEjJ0GQzulY7qPa8yC16
   O8HYVd8BUQoute0DA4hKWAW6hlJgj5LKVywll0U1PbVJuAnIP2tDe0Nv8
   lGQAsa711o2gUMLG5GjHwREJsiGJ/oUoPqBhY6q9ixLu7DnndFH5WO7a9
   zFdQaZHZPvKaOIr/zIE6ngtZLbDdOzyaOGuEIBdka7Yupl+Z+4+5qT41y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325973927"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="325973927"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 21:06:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690386027"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690386027"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga001.jf.intel.com with ESMTP; 12 Jan 2023 21:06:11 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>,
        Abhay Maheta <mabhay125@gmail.com>
Subject: [PATCH BlueZ v3] shared/bap: Fixing Company ID, Vendor ID and Metadata handling
Date:   Fri, 13 Jan 2023 10:36:05 +0530
Message-Id: <20230113050604.71398-1-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes Company ID, Vendor Codec ID and metadata storing
PAC record.
---
 src/shared/bap.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0cafb75e6..463cdb7a6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -344,8 +344,10 @@ static void pac_foreach(void *data, void *user_data)
 
 	p = util_iov_push(iov, sizeof(*p));
 	p->codec.id = pac->codec.id;
-	p->codec.cid = pac->codec.cid;
-	p->codec.vid = pac->codec.vid;
+	if (p->codec.id == 0xff) {
+		p->codec.cid = cpu_to_le16(pac->codec.cid);
+		p->codec.vid = cpu_to_le16(pac->codec.vid);
+	}
 
 	if (pac->data) {
 		p->cc_len = pac->data->iov_len;
@@ -2773,7 +2775,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		struct bt_pac *p;
 		struct bt_ltv *cc;
 		struct bt_pac_metadata *meta;
-		struct iovec data, metadata;
+		struct iovec data, *metadata = NULL;
 
 		p = util_iov_pull_mem(&iov, sizeof(*p));
 		if (!p) {
@@ -2802,8 +2804,11 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		data.iov_len = p->cc_len;
 		data.iov_base = cc;
 
-		metadata.iov_len = meta->len;
-		metadata.iov_base = meta->data;
+		if (meta->len) {
+			metadata = new0(struct iovec, 1);
+			metadata->iov_len = meta->len;
+			metadata->iov_base = meta->data;
+		}
 
 		util_iov_pull_mem(&iov, meta->len);
 
@@ -2813,12 +2818,14 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		/* Check if there is already a PAC record for the codec */
 		pac = bap_pac_find(bap->rdb, type, &p->codec);
 		if (pac) {
-			bap_pac_merge(pac, &data, &metadata);
+			bap_pac_merge(pac, &data, metadata);
+			free(metadata);
 			continue;
 		}
 
 		pac = bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL, &data,
-								&metadata);
+								metadata);
+		free(metadata);
 		if (!pac)
 			continue;
 
-- 
2.25.1

