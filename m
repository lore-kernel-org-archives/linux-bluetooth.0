Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4902C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJGR1R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJGR1Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 13:27:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ED5CC838
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665163635; x=1696699635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jwd0dT8DgPzOyvb0ouzJt1hKZ4xUfTiNsDMLr0rJhNk=;
  b=URtXsXcJ19UGnV3zDceCsYmfHcH0hz6VYHzxbFNctq/j5IP3GOldAg6U
   VNsINJXJhMmb1122bh48k5WeQ9RlUAcnQ4oj0cCEURx3eQL7wjYWV+WfW
   AuHqVvKrFnxFp/EGH4mS9jvMdNiGTVGXxi+lG5TcNeCkMkGO32kBX42yX
   LgTbWb7TL28ElVB9ONdTLXpU7SAPT6G5DP4yC30PgKzBD+c84b58bvr6L
   Pj6H0hN0xrM20yiWmDWYsFUZulL5S4EvWxLFeVMYZtmVbgaE/azN6dmLV
   aA439bFdxa3TuJ11pAodyoAUfY19A1TS6laYFCEjlexC2Ihymw7qDkS3J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="301388888"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="301388888"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 10:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="658410268"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="658410268"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2022 10:27:13 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 1/1] shared/bap: Fix handling memory overwrite during ASE Enable Operation
Date:   Fri,  7 Oct 2022 23:15:16 +0530
Message-Id: <20221007174516.22335-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221007174516.22335-1-abhay.maheshbhai.maheta@intel.com>
References: <20221007174516.22335-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes memory overwrite during ASE Enable operation handling.
It avoids crashing of bluetoothd if metadata of more than sizeo of
size_t is received.

This also fixes storing metadata to stream structure.
---
 src/shared/bap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 178407387..c3c0d596f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -958,10 +958,14 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 	struct bt_ascs_ase_status *status;
 	struct bt_ascs_ase_status_metadata *meta;
 	size_t len;
+	size_t meta_len = 0;
 
 	DBG(stream->bap, "stream %p", stream);
 
-	len = sizeof(*status) + sizeof(*meta) + sizeof(stream->meta->iov_len);
+	if (stream->meta)
+		meta_len = stream->meta->iov_len;
+
+	len = sizeof(*status) + sizeof(*meta) + meta_len;
 	status = malloc(len);
 
 	memset(status, 0, len);
@@ -1743,7 +1747,7 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		return 0;
 	}
 
-	return stream_enable(ep->stream, iov, rsp);
+	return stream_enable(ep->stream, &meta, rsp);
 }
 
 static uint8_t ascs_enable(struct bt_ascs *ascs, struct bt_bap *bap,
-- 
2.25.1

