Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0C9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 15:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiL2P5J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiL2P4l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 10:56:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956D15720
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672329301; x=1703865301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L4BwPiUV6sLj1GRzmplOf9fFjekMwUzdJJjfwiebKPQ=;
  b=PLhqkukLeDBdEZ64m0PyBniNmL51gYQHCP/5lkbtYdFwTOPi+TkFxrVO
   N61SgyI21YD6+lA/0DBudUWO9NIFYOmGXg4CpyvpJcpkxJ7F8rsYMKYnm
   t2eMnAK4yv16eeXYBS2fj+5Tp4HzWjzCrUoWd82RQToJcqa+iWmv64Z1J
   8nL9Rz7953Dk+lN09leMU4UseP2BVr3Au050vJh/qYGxiNKuVQl1aIPqo
   YvJjrbmq3Fjk6WW8TsyLeAHi28p348vEAjTcbdVMJD4Nwrx/hoUwPNlri
   7yIT5F+LqqF1Sa899OCGqrT6ctRebgQ+oJ29fWwx2IF5KvZFJGRSUKKz+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="321139372"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="321139372"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 07:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686024380"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="686024380"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 07:54:59 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>,
        Abhay Maheta <mabhay125@gmail.com>
Subject: [PATCH BlueZ v3 2/6] shared/bap: Add support to set stream metadata
Date:   Thu, 29 Dec 2022 21:22:57 +0530
Message-Id: <20221229155257.341327-3-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds new API to set stream metadata.
---
 src/shared/bap.c | 30 +++++++++++++++++++++++-------
 src/shared/bap.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0cafb75e6..b3c65283e 100644
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
 
@@ -4591,6 +4598,15 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream)
 	return &stream->qos;
 }
 
+void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
+				struct iovec *meta)
+{
+	if (!stream)
+		return;
+
+	stream_metadata(stream, meta, NULL);
+}
+
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 47a15636c..bcf830ceb 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -248,6 +248,8 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream);
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream);
 struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
+void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
+					struct iovec *meta);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
-- 
2.25.1

