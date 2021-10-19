Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D02C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 12:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFD160FD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 12:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhJSMJh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbhJSMJh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 08:09:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80613C061746
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 05:07:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c4so12092553pgv.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 05:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVmaGFLR4mR+Ps4pLiOUdexGniIqHe1BvZrlKrHaafw=;
        b=eZ7KME3dVRwV8n9OV2vvqLBIROV+94NVObD5NDO4Lhj7Jv/pqGAU1wPs/oI3IFve9o
         gUE4M1IcaNHA7xIlqYVnoWxSre4z04Nipz8AI9+onKgcehSrlmJwggrjSD/9IbkGRdjC
         VwZPy2+IxjiGYW1XvHKXcEkDS8p0v0u3MCBvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVmaGFLR4mR+Ps4pLiOUdexGniIqHe1BvZrlKrHaafw=;
        b=d2m+TPCm905MVtvLeIlPC5ABtXy6/BP3ZpHWqcDqtjF/feBpD7ITCgtXzf+C0hu8JN
         X7acRLhUzqsnUM84aFD9KGzxtTCKLhkhjSt33uB5Xj9WtmSuYSAW6jr5uv01HuLdDYbu
         u+xFLENDprcstIk8tV/ELxIc3MfW+OuFwzRa+Xqu/oI6xYUjUv984fNvXOjage40LAU9
         Ke0pbayVpn4AU++p7PB4p0CBL6easeBM58rQgnfkad9O9kads/Gyxpuz0PqFdW1dnXJ7
         JiEI7p6Tcnkg8q0UI0YMwtrdPq44kjwDueK12gcL8OyU9c96T8SD0CiN87LJsodEoBl1
         J3Tg==
X-Gm-Message-State: AOAM532TlSEVI+am+oeYhlnJsU5eK35QCdusol3mWmvHoYcQMlhtc3e6
        Me/ZAGHxXxQew2/o/FX3oUoFXfb6RqaPaQ==
X-Google-Smtp-Source: ABdhPJxbeLhQNzOykO63gRBryXeRsr3j7bGN9ONO4ZIzhlpFISunCXW/AT4+ox/cL8ZWTwO20/48zQ==
X-Received: by 2002:aa7:8b1a:0:b0:44d:37c7:dbb6 with SMTP id f26-20020aa78b1a000000b0044d37c7dbb6mr35215726pfd.11.1634645243631;
        Tue, 19 Oct 2021 05:07:23 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:1d7c:b745:dee:c8a4])
        by smtp.gmail.com with ESMTPSA id k16sm5236160pgt.57.2021.10.19.05.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:07:22 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 1/3] Bluetooth: Add struct of reading AOSP vendor capabilities
Date:   Tue, 19 Oct 2021 20:07:13 +0800
Message-Id: <20211019200701.v5.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the struct of reading AOSP vendor capabilities.
New capabilities are added incrementally. Note that the
version_supported octets will be used to determine whether a
capability has been defined for the version.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>

---

Changes in v5:
- This is a new patch.
- Add struct aosp_rp_le_get_vendor_capabilities so that next patch
  can determine whether a particular capability is supported or not.

 net/bluetooth/aosp.c | 45 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/aosp.c b/net/bluetooth/aosp.c
index a1b7762335a5..3f0ea57a68de 100644
--- a/net/bluetooth/aosp.c
+++ b/net/bluetooth/aosp.c
@@ -8,9 +8,32 @@
 
 #include "aosp.h"
 
+#define AOSP_OP_LE_GET_VENDOR_CAPABILITIES	0x153
+struct aosp_rp_le_get_vendor_capabilities {
+	__u8	status;
+	__u8	max_advt_instances;
+	__u8	offloaded_resolution_of_private_address;
+	__u16	total_scan_results_storage;
+	__u8	max_irk_list_sz;
+	__u8	filtering_support;
+	__u8	max_filter;
+	__u8	activity_energy_info_support;
+	__u16	version_supported;
+	__u16	total_num_of_advt_tracked;
+	__u8	extended_scan_support;
+	__u8	debug_logging_supported;
+	__u8	le_address_generation_offloading_support;
+	__u32	a2dp_source_offload_capability_mask;
+	__u8	bluetooth_quality_report_support;
+	__u32	dynamic_audio_buffer_support;
+} __packed;
+
 void aosp_do_open(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	struct aosp_rp_le_get_vendor_capabilities *rp;
+	u16 opcode;
+	u16 version_supported;
 
 	if (!hdev->aosp_capable)
 		return;
@@ -18,10 +41,26 @@ void aosp_do_open(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "Initialize AOSP extension");
 
 	/* LE Get Vendor Capabilities Command */
-	skb = __hci_cmd_sync(hdev, hci_opcode_pack(0x3f, 0x153), 0, NULL,
-			     HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
+	opcode = hci_opcode_pack(0x3f, AOSP_OP_LE_GET_VENDOR_CAPABILITIES);
+	skb = __hci_cmd_sync(hdev, opcode, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "AOSP get vendor capabilities (%ld)",
+			    PTR_ERR(skb));
+		return;
+	}
+
+	bt_dev_info(hdev, "aosp le vendor capabilities length %d", skb->len);
+
+	rp = (struct aosp_rp_le_get_vendor_capabilities *)skb->data;
+
+	if (rp->status) {
+		bt_dev_err(hdev, "AOSP LE Get Vendor Capabilities status %d",
+			   rp->status);
 		return;
+	}
+
+	version_supported = le16_to_cpu(rp->version_supported);
+	bt_dev_info(hdev, "AOSP version 0x%4.4x", version_supported);
 
 	kfree_skb(skb);
 }
-- 
2.33.0.1079.g6e70778dc9-goog

