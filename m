Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91672C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 16:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2Qpy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2Qpx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 12:45:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B305A2C1
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667061948; x=1698597948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDUiQKWLMuJ8wiXnQ5eHYa42vErpnH09Jr6v/qUFvbw=;
  b=RyjWUHSFZMHhbF4YOrpwKCwQc3TUhHC6L5GHatZxjj5oQx5cab3mdtlt
   x1oQNbFk5O8evNzLbi29AYOCK6G/zBGYkDFi1oja9HJgE4jdp05qgM5xQ
   7hHPWXgF21nfid0f8bGqq9WYOHrffOvuzNapxGwsrxS4C+uXFaEHUHnp1
   /uVJ+2yoSTvDhaIbRINxG3EI+zi1mz7i9aN34mq+U1hZ8B4n07ailSnPB
   rwZEcXPzM6ZG5t4RCLam4oAYnMDmh2l+8TRCUOqV33bpMtpXocQjrR3h9
   6oglpwWFUoKopBcMLVOW9P7146DKJvEeANEFGBLm+4RfHf6sgRlHjRtqp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289074310"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289074310"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 09:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="666399480"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="666399480"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2022 09:45:46 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 2/5] shared/bap: Add support to set stream metadata
Date:   Sat, 29 Oct 2022 22:34:05 +0530
Message-Id: <20221029170408.175533-3-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>

This adds new API to set stream metadata.
---
 src/shared/bap.c | 20 ++++++++++++++++----
 src/shared/bap.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0ae0eba33..cc89d65a3 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2787,7 +2787,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		struct bt_pac *p;
 		struct bt_ltv *cc;
 		struct bt_pac_metadata *meta;
-		struct iovec data, metadata;
+		struct iovec data, *metadata = NULL;
 
 		p = iov_pull_mem(&iov, sizeof(*p));
 		if (!p) {
@@ -2816,13 +2816,16 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		data.iov_len = p->cc_len;
 		data.iov_base = cc;
 
-		metadata.iov_len = meta->len;
-		metadata.iov_base = meta->data;
+		if (meta->len) {
+			metadata = new0(struct iovec, 1);
+			metadata->iov_len = meta->len;
+			metadata->iov_base = meta->data;
+		}
 
 		iov_pull_mem(&iov, meta->len);
 
 		pac = bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL, &data,
-								&metadata);
+								metadata);
 		if (!pac)
 			continue;
 
@@ -4567,6 +4570,15 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream)
 	return &stream->qos;
 }
 
+void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
+				struct iovec *meta)
+{
+	if (!stream)
+		return;
+
+	stream->meta = meta;
+}
+
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 923669f32..0c83726da 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -249,6 +249,8 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream);
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream);
 struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
+void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
+					struct iovec *meta);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
-- 
2.25.1

