Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D082C10F06
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1F2206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 14:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="j8NCVfKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfCKOfU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:35:20 -0400
Received: from aer-iport-2.cisco.com ([173.38.203.52]:36164 "EHLO
        aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOfU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 10:35:20 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 10:35:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=620; q=dns/txt; s=iport;
  t=1552314920; x=1553524520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CXssYjzlnQgrgIrYqdUbOa0t8nKWK/sIj+Ff9TDzauI=;
  b=j8NCVfKl80s8iTa4MxHU1SBBVDlFtFcsHuous1mRsMEM/pNNubcl/g48
   99YiF197X1K3m+zGfotu5LEpvipUKELlwB5dgsp6FWrvGuMvBWxNukbRt
   UOc+F0BM2BNPvJzF/VLPKvK1xt58Ljxq/z7UiUQ02puqf4i41/QfuKIUP
   0=;
X-IronPort-AV: E=Sophos;i="5.58,468,1544486400"; 
   d="scan'208";a="10672559"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:25:40 +0000
Received: from pwaago-threadripper.rd.cisco.com ([10.47.79.134])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id x2BEPdTX023678;
        Mon, 11 Mar 2019 14:25:40 GMT
From:   =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
Subject: [PATCH] sbc: Fix off-by-one error in index check when unpacking frame
Date:   Mon, 11 Mar 2019 15:25:35 +0100
Message-Id: <20190311142535.92501-1-pwaago@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.134, [10.47.79.134]
X-Outbound-Node: aer-core-1.cisco.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If trying to parse or decode a stream with a truncated packet, the
first byte past the provided data stream would be read.
---
 sbc/sbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7f1efaa..0f21481 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -499,7 +499,7 @@ static int sbc_unpack_frame_internal(const uint8_t *data,
 
 				audio_sample = 0;
 				for (bit = 0; bit < bits[ch][sb]; bit++) {
-					if (consumed > len * 8)
+					if (consumed >= len * 8)
 						return -1;
 
 					if ((data[consumed >> 3] >> (7 - (consumed & 0x7))) & 0x01)
-- 
2.19.1

