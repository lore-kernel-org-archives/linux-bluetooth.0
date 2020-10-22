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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF235C4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D11A21481
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/uHaqjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894831AbgJVITQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443979AbgJVITP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 04:19:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167FC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t22so549243plr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wiNgrnZtCuvQcb5zEd4xakXVaM2f+04392e0eDjTsuY=;
        b=U/uHaqjvtQ5GugBE0/xgJv0UnnDKE24y/giRqg6kYooOXfTj80ZIUmj/EwlymUBKi/
         59fUBl2qscvvb3UhmbudDuSXF69ZxmFDg9Js7KOnggHRu0rribzitnVp+ovmkd6IzPGp
         tbDDiKKmA+fWraRMO3LDqNzTP6jMbWUaii7yB4jMhuqYFvUOpsyTBaM6QfEswK9RLZYm
         kYoRDwrW9L7hrpEeCG5ifCYqang3KGbSAu6oorIlHzAiHEZIgkkG9ud4kSWJOij0xNtP
         7w4qtwLfMc8ARUtZkU7UtuK+bumCE1isJXNU5RPP+UluHTQZKOk9W0MzpFtL5ky5FChX
         7Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wiNgrnZtCuvQcb5zEd4xakXVaM2f+04392e0eDjTsuY=;
        b=KsdVkv91U49RWsr6c+MjbUSW8XSLYYLyEjsJtXFEOhwBpBwhaLeg5gflcR++wByuot
         KND2ePmUPES8PIHF8iz1vJ9hnFPrZudsoQixSNwT7BFSUZLloHVrC/sKhC1HFbnSTPsg
         V7SCKfySXdJ6EZeQlMuOFoxNZ39Xak8o+4DyBEIHoh66nbhpu52PRsxyFzZxPrSS8Q+6
         sJPdMm15cl2zCbw9uAtJgMaB4Pvx7NedjoioyW8DhAEDzMuDa7uA0cGmQgZW228/mlWy
         kWnk2JYsdDGqANDg11mmVnElZ4pqlL8nDbvuI+izmdAk0x5h7cs2vWk6Zeg6iRVTimO3
         qhsQ==
X-Gm-Message-State: AOAM530lqNeOnnySKWAZGyn/63QSPe6HS7Vr8SR6HA8yFPYtgnlPewWi
        fFwdm+oHRDdl4RusLAderMpDsFpgE+8ixl+8
X-Google-Smtp-Source: ABdhPJyxPIOTEwBQ8HbDdM/2S+AcYUZJrbXS97h4pd9HLdDItjeItwPhuVsEacKP+yWL4GryMGJtWA==
X-Received: by 2002:a17:902:5581:b029:d5:ff8e:18e5 with SMTP id g1-20020a1709025581b02900d5ff8e18e5mr1442718pli.36.1603354753485;
        Thu, 22 Oct 2020 01:19:13 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id j5sm1179514pjb.56.2020.10.22.01.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:19:13 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 2/3] Bluetooth: btintel: Introducing new btintel read version
Date:   Thu, 22 Oct 2020 13:54:34 +0530
Message-Id: <20201022082435.31831-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022082435.31831-1-sathish.narasimman@intel.com>
References: <20201022082435.31831-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The new btintel read version supports the latest intel read version
command and also supports the TLV structure parsing. It still
handles the legacy read version

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 drivers/bluetooth/btintel.c | 51 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h | 15 +++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cc8e6c4e3205..ddd3c4bbdd6f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -476,6 +476,57 @@ static void btintel_parse_tlv(struct sk_buff *skb,
 	}
 }
 
+int btintel_read_version_new(struct hci_dev *hdev, struct btintel_version *ver)
+{
+	struct sk_buff *skb;
+	struct intel_version *version = &ver->ver;
+	const u8 param[1] = { 0xFF };
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version info failed (%ld)",
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
+	/* The new Intel read version is backward compatible for Thp and CcP
+	 * type cards. when the controller is in bootloader mode the controller
+	 * response remains same as old intel_read version. For ThP/CcP cards
+	 * TLV stucture supports only during the Operation Mode. The best way
+	 * to differentiate the read_version response is to check the length
+	 * parameter and first byte of the payload, which is a fixed value.
+	 * After the status parameter if the payload starts with 0x37(This is
+	 * a fixed value) and length of the payload is 10 then it is identified
+	 * as legacy struct intel_version. In the latest firmweare the support
+	 * of TLV structure is added during Operational Firmware.
+	 */
+	if (skb->len == sizeof(*version) && skb->data[1] == 0x37) {
+		memcpy(version, skb->data, sizeof(*version));
+		ver->tlv_format = false;
+		goto finish;
+	}
+
+	/* Consume Command Complete Status field */
+	skb_pull(skb, 1);
+
+	ver->tlv_format = true;
+
+	bt_dev_info(hdev, "Parsing TLV Supported intel read version");
+	btintel_parse_tlv(skb, &ver->ver_tlv);
+
+finish:
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_read_version_new);
+
 int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
 {
 	struct sk_buff *skb;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 09346ae308eb..08406ef935a3 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,14 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+struct btintel_version {
+	bool tlv_format;
+	union {
+		struct intel_version ver; /*Legacy Intel read version*/
+		struct intel_version_tlv ver_tlv;
+	};
+};
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
@@ -151,6 +159,7 @@ int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
 int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
 int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver);
+int btintel_read_version_new(struct hci_dev *hdev, struct btintel_version *ver);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
@@ -248,6 +257,12 @@ static inline int btintel_read_version_tlv(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_read_version_new(struct hci_dev *hdev,
+					   struct btintel_version *ver)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
 						 u16 opcode_read,
 						 u16 opcode_write)
-- 
2.17.1

