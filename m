Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3537C4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E92223BF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckfR5Pes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894828AbgJVITL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443979AbgJVITK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 04:19:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EAC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e15so673526pfh.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8KtUk2kpQBYZMeYj1ttnbvvxz0iE7tmEcQp0BtrQMwE=;
        b=ckfR5Pes2q9avYh0mft+9TKeu11CRpJQrxPnAJmAft2gx37eVFn+i+rA3dWrw+llZY
         BuypZ8kt8XjUWUwaEbk6EcIVeDFw5zz6tNoosUIMwivOcaUzOTS4OTsO7vLDj4U1Ovs7
         +8QT4eZco7716tBtlQ6kwCwjBHIfR05cFL7dWSkI74a3+SIahVT29im8PHB0XFeb59x0
         gkqlkgg/hcA4NV7ZPG8h0dCNRnc39waB8GmeEsKWGPLtuHJipcsKiNOpKadCRX93XIV+
         wbZPaULQ0vT/9MDZG19l/JCwH5BhK1FhaUEe9626rIHdYExIGMuPiX/+/vzHfKBF9Qrt
         2EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8KtUk2kpQBYZMeYj1ttnbvvxz0iE7tmEcQp0BtrQMwE=;
        b=B5McAXODpqrXe2iBmFy8qaDAnCkT5u/7oASUs+2RfmDuXhaSQWX52i8s9Km2hH7zRy
         6BJgwlN4Wv6yWMBwae1J/HcJVI6mA9LE29+al0t2nx6H2G4AOwOO/SEyhmZ0YMZnP2V6
         PyRv+MpN0h1dw1oBLXHa5hMBdQB2gCoX69nA9JF7Oy1bZPJ8FqXILMtaGqtnf3Ujmxv9
         Nngin30XSBo3mT/btEkY64z6CIV9KHVFJiCQvbfAAG74cy6edrHClGui3OGZRTlLem2U
         X8iCxSjNacN9/OhEI/lq2+rNsrqd6Yy4f+9HywoNf9uPx1GulDcgB+sK5Cb3VK59ryQK
         r6rQ==
X-Gm-Message-State: AOAM530IkLRHpetHLrk/iRE2rJ0VYU9kOEQjAZG0DSoiQSnZNwO1YJN3
        KDUrhylAjrkMzjIwMWP2wJwVj/4UJqLChcaI
X-Google-Smtp-Source: ABdhPJz2X+Q1N6t4fYJq8EYCcy0ZGhHrnY+mM2YLesoIQdGxQt/1xnUelGdoq9xzc0UyMry7nZsSuw==
X-Received: by 2002:a62:b417:0:b029:142:2501:35dc with SMTP id h23-20020a62b4170000b0290142250135dcmr1519045pfn.60.1603354749670;
        Thu, 22 Oct 2020 01:19:09 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id j5sm1179514pjb.56.2020.10.22.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:19:09 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 1/3] Bluetooth: btintel: seperated TLV parsing as new function
Date:   Thu, 22 Oct 2020 13:54:33 +0530
Message-Id: <20201022082435.31831-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022082435.31831-1-sathish.narasimman@intel.com>
References: <20201022082435.31831-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Create a seperate TLV parse function to read btintel TLV
structure.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 drivers/bluetooth/btintel.c | 54 ++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0ffc4b..cc8e6c4e3205 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -401,31 +401,9 @@ void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ve
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
-int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+static void btintel_parse_tlv(struct sk_buff *skb,
+			      struct intel_version_tlv *version)
 {
-	struct sk_buff *skb;
-	const u8 param[1] = { 0xFF };
-
-	if (!version)
-		return -EINVAL;
-
-	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
-			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->data[0]) {
-		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
-			   skb->data[0]);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	/* Consume Command Complete Status field */
-	skb_pull(skb, 1);
-
 	/* Event parameters contatin multiple TLVs. Read each of them
 	 * and only keep the required data. Also, it use existing legacy
 	 * version field like hw_platform, hw_variant, and fw_variant
@@ -496,6 +474,34 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 		/* consume the current tlv and move to next*/
 		skb_pull(skb, tlv->len + sizeof(*tlv));
 	}
+}
+
+int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+{
+	struct sk_buff *skb;
+	const u8 param[1] = { 0xFF };
+
+	if (!version)
+		return -EINVAL;
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->data[0]) {
+		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
+			   skb->data[0]);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	/* Consume Command Complete Status field */
+	skb_pull(skb, 1);
+
+	btintel_parse_tlv(skb, version);
 
 	kfree_skb(skb);
 	return 0;
-- 
2.17.1

