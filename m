Return-Path: <SRS0=LYTB=C7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C74DC4363D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 04:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DC320739
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 04:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5QYFQjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgIVEAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Sep 2020 00:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIVEAj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Sep 2020 00:00:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957CCC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 21:00:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so32017pgi.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 21:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WcyHzFEGyqBLAySN0HYRdtNWlWJxR0ZmcbFLUbUq37s=;
        b=e5QYFQjousD7sregzqOzTp6sl2MlVVya7HAb9l3FbKb7EFWRHYIdHmA8igtmtEyTDq
         Uq0XXFufe64WhMrvei8p4WetHdDiwnNLVqW81H5oG0kqEUdJfOC5iAY9Yl7yw4O84NHn
         ssjsGB2gK9mit647y7u7LxnE6PVQXcY0RLHwT4vMxSeyqdbDMddvwIm+kKIJICenbKPB
         O1RvgAcKacrTEUBqcTYastbG+xwrHgxGSXRvJ2VEzdExgOIhSyNUwUF9QvLI103zhdME
         77g7rxr+/chjdJZItjUqkVkZtIvmoDt77kkNcb5PaidKk6nEuevZcOOIGtMXZ5DDDq12
         VWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WcyHzFEGyqBLAySN0HYRdtNWlWJxR0ZmcbFLUbUq37s=;
        b=VyY3dByelLRMK070AM9K3o9HbiTTU2BT0bZodyyd+HSLPJZeIKTLU5ox4wB01SDGx1
         aAp2DgPiJVJB2em31uQiYfPMTkN8LRvjmDYD0qiVF+JykSaTEohWrWCDzmbvJTkDvDt8
         h0SeiRH0lSaeJKfRJ1twSVzFsLRSb9hKS9G2E2AdaLq1M3qMsaH4xkd1Z9SJcMgyksAZ
         YNqaAa6R4RIuUKcxf0IpbsAJoFPBun4Ib3a3luTc3gP+uxJHnYdSG+NVI3W7Jy1p2bL1
         J67aH70/sPzSN+eev2VY5bdBH+pqlI9LdPnq+eZi+3EblhkkHPKVp0NGQZ2DcWj4BeGx
         vFZg==
X-Gm-Message-State: AOAM530q098xHziUw8eIrOe+S6Dej5JDieh84Upocxd0JnXmfQ9Pa202
        PZnDXS7CGfqmecj1Ag29FnF6dkJkamA=
X-Google-Smtp-Source: ABdhPJxi605/Q5q6cSKrHK+Jdmu0NehmEhVzKL9XLPzpm5xei5XeZg69DG317lkGt5OKkTb17bHrvg==
X-Received: by 2002:a62:6444:0:b029:13e:d13d:a12d with SMTP id y65-20020a6264440000b029013ed13da12dmr2569002pfb.21.1600747238429;
        Mon, 21 Sep 2020 21:00:38 -0700 (PDT)
Received: from localhost.localdomain ([122.179.23.229])
        by smtp.gmail.com with ESMTPSA id w19sm13637324pfq.60.2020.09.21.21.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 21:00:37 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        dan.carpenter@oracle.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fix issue reported by static analysis tool
Date:   Tue, 22 Sep 2020 09:30:19 +0530
Message-Id: <1600747219-11626-1-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Smatch tool reported the below issue:

drivers/bluetooth/btintel.c:490 btintel_read_version_tlv()
error: 'tlv->len' from user is not capped properly

Additional details in the below link
https://www.spinics.net/lists/linux-bluetooth/msg87786.html

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0..47f2b3d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -431,62 +431,99 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 	 * version field like hw_platform, hw_variant, and fw_variant
 	 * to keep the existing setup flow
 	 */
-	while (skb->len) {
+	while (skb->len >= sizeof(struct intel_tlv)) {
 		struct intel_tlv *tlv;
 
 		tlv = (struct intel_tlv *)skb->data;
+		if (struct_size(tlv, val, tlv->len) > skb->len)
+			goto failed;
+
 		switch (tlv->type) {
 		case INTEL_TLV_CNVI_TOP:
+			if (tlv->len < sizeof(u32))
+				goto failed;
 			version->cnvi_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_TOP:
+			if (tlv->len < sizeof(u32))
+				goto failed;
 			version->cnvr_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVI_BT:
+			if (tlv->len < sizeof(u32))
+				goto failed;
 			version->cnvi_bt = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_BT:
+			if (tlv->len < sizeof(u32))
+				goto failed;
 			version->cnvr_bt = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_DEV_REV_ID:
+			if (tlv->len < sizeof(u16))
+				goto failed;
 			version->dev_rev_id = get_unaligned_le16(tlv->val);
 			break;
 		case INTEL_TLV_IMAGE_TYPE:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->img_type = tlv->val[0];
 			break;
 		case INTEL_TLV_TIME_STAMP:
+			if (tlv->len < sizeof(u16))
+				goto failed;
 			version->timestamp = get_unaligned_le16(tlv->val);
 			break;
 		case INTEL_TLV_BUILD_TYPE:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->build_type = tlv->val[0];
 			break;
 		case INTEL_TLV_BUILD_NUM:
+			if (tlv->len < sizeof(u32))
+				goto failed;
 			version->build_num = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_SECURE_BOOT:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->secure_boot = tlv->val[0];
 			break;
 		case INTEL_TLV_OTP_LOCK:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->otp_lock = tlv->val[0];
 			break;
 		case INTEL_TLV_API_LOCK:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->api_lock = tlv->val[0];
 			break;
 		case INTEL_TLV_DEBUG_LOCK:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->debug_lock = tlv->val[0];
 			break;
 		case INTEL_TLV_MIN_FW:
+			if (tlv->len < 3)
+				goto failed;
 			version->min_fw_build_nn = tlv->val[0];
 			version->min_fw_build_cw = tlv->val[1];
 			version->min_fw_build_yy = tlv->val[2];
 			break;
 		case INTEL_TLV_LIMITED_CCE:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->limited_cce = tlv->val[0];
 			break;
 		case INTEL_TLV_SBE_TYPE:
+			if (tlv->len < sizeof(u8))
+				goto failed;
 			version->sbe_type = tlv->val[0];
 			break;
 		case INTEL_TLV_OTP_BDADDR:
+			if (tlv->len != sizeof(version->otp_bd_addr))
+				goto failed;
 			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
 			break;
 		default:
@@ -499,6 +536,10 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 
 	kfree_skb(skb);
 	return 0;
+
+failed:
+	kfree_skb(skb);
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
 
-- 
2.7.4

