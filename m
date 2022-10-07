Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468B7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 14:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJGOkw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJGOkv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 10:40:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80736C13D
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665153649; x=1696689649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jwd0dT8DgPzOyvb0ouzJt1hKZ4xUfTiNsDMLr0rJhNk=;
  b=nrTb+bKJWK0BaLMNOzn+sHbMOOJoug2JmDPmnm9v3kt4BrzEaq5Yo1s1
   GMZajKsodcJFUwu7a3iD//UOSWmRHov2S6hdvKvdw+x2vDD/DvLW0QCmK
   Uju1us3Eod/eLFhyT4Vu69v0aVtzaDLoa6NsLYYhB7d3mYK64zWU0fdOH
   RyfRBHQVlhLK8np9+w/xixLHuI6Yf1v8QCi8YUd9LIAvoX2IWhdiOhBqF
   c8pdoP6mAjzevrQGLiEETmIyUwnDBTLuc85nm3NX8rI9hxkvjoGWtSiz2
   nCeRnNuw2s1lb+9wh1I2UAOMsBTWRWA3HZwa4pwUO2nKxN5h3mCdThSes
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="302470069"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="302470069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 07:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="714294751"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="714294751"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2022 07:40:48 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 1/1] shared/bap: Fix handling memory overwrite during ASE Enable Operation
Date:   Fri,  7 Oct 2022 20:29:20 +0530
Message-Id: <20221007145920.20966-2-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221007145920.20966-1-abhay.maheshbhai.maheta@intel.com>
References: <20221007145920.20966-1-abhay.maheshbhai.maheta@intel.com>
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

