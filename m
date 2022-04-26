Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 23:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355995AbiDZXHD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355993AbiDZXHB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 19:07:01 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812F8BF7C
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z18so172056iob.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EYpkBNMgdqUzGGcbORl6WvByS0U8NcW87VYkbwsCJVs=;
        b=TuMJKK4OdXhF94IGZ06HE97cFtluxOi/PGUdEvylqPLjiIWaVo58AWziQZ2MGKRMo6
         zkCs5tCndooQVza5qJQ4i4FFsVB5hdiNx6niYHS8MTQxbKLKMBbXgwoogbE5cChF55Gq
         Ws9Tne8MywFkU1b86kvgihVti+ZcYunn6vD3pHX9lWXXnfXLPbpZ5Qqyj2sE2ruhmiDF
         h2GXDzI0+RPUgYoGKmoz11k6JT0rYTJMByL0YA9QL7LoSVM1syeYxMrwUFZTLPvygWXo
         0YElggKYAyRCawGDcE+3vW0RERpPG5ACSL+FnV56xQ7Dpl5a7zB4V95kfjZdkTf9M6sa
         XZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYpkBNMgdqUzGGcbORl6WvByS0U8NcW87VYkbwsCJVs=;
        b=LXTDlxeGOLwfj75Pslp1DkgWDQDna+dMOvNBmH9NmcxHh7Hp8shNvfdQDTwKEnEd8Z
         KmSwcoYpWNtCt/Twcr7itsAPZtaCB4oSnuK8/kQMbSHMOWybFDMMy5QE6E2REyn4ZGQY
         X/ipbeUDxX8c1F6Jn1HMJBSZH1k8mCVlzm6ANAg+vAXaLMJuzZvrOuDbd4OJI8rWFsxx
         qqeYebZq00PVzahk8wz6vgBycXwAr94UHiZGzAxjebUDpWYucy15xzv51L5nbEuW51td
         0Vr0aklbZcEDqKgMh/FNishLqUBhNE1JaYKX3kGHZy/tpekq3yNAcHzEJkYuyJhcSalC
         aoWA==
X-Gm-Message-State: AOAM530rKJuiGX6Z1xpnF0nKZU9JglTOlcsE8gqaZXPZNUmXiY7ACl37
        0HcUijZxW3p3pCU755zXRnlpfyo1ESY=
X-Google-Smtp-Source: ABdhPJwjm1/efhiMw8zqBoULTQ4/iFJU/blk1v1TxZrwPfNtG7sFb2MyKik8iFJitNoK7gy1zYQXig==
X-Received: by 2002:a05:6638:3397:b0:32a:8ab7:3f0 with SMTP id h23-20020a056638339700b0032a8ab703f0mr10463808jav.260.1651014230678;
        Tue, 26 Apr 2022 16:03:50 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a056e020df000b002ccc1d58ca5sm8437194ilj.54.2022.04.26.16.03.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:03:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] btmon: Add support for decoding Basic Audio Annoucements
Date:   Tue, 26 Apr 2022 16:03:46 -0700
Message-Id: <20220426230347.857783-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426230347.857783-1-luiz.dentz@gmail.com>
References: <20220426230347.857783-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding Basic Audio Announcements as shown
on:

Basic Audio Profile / Profile Specification
Page 36 of 146

Table 3.15: Format of BASE used in Basic Audio Announcements

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 36
        Handle: 0
        Operation: Complete ext advertising data (0x03)
        Data length: 0x21
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: Reserved (0x06)
            Codec Specific Configuration: 010101020403010000020428
            Metadata: 020202
              BIS #0:
              Index: 1
              Codec Specific Configuration:
---
 monitor/bt.h     |  28 +++++++++++++
 monitor/packet.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index e9f72de36..644c97c98 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3517,6 +3517,34 @@ struct bt_hci_evt_le_per_sync_established {
 	uint8_t  clock_accuracy;
 } __attribute__ ((packed));
 
+struct bt_hci_le_pa_base_codec {
+	uint8_t  id;
+	uint16_t cid;
+	uint16_t vid;
+} __attribute__ ((packed));
+
+struct bt_hci_lv_data {
+	uint8_t  len;
+	uint8_t  data[];
+} __attribute__ ((packed));
+
+struct bt_hci_le_pa_base_bis {
+	uint8_t  index;
+	struct bt_hci_lv_data codec_cfg[];
+} __attribute__ ((packed));
+
+struct bt_hci_le_pa_base_subgroup {
+	uint8_t  num_bis;
+	struct bt_hci_le_pa_base_codec codec;
+	uint8_t  data[];
+} __attribute__ ((packed));
+
+struct bt_hci_le_pa_base_data {
+	uint8_t  pd[3];
+	uint8_t  num_subgroups;
+	struct bt_hci_le_pa_base_subgroup subgroups[];
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_PA_REPORT			0x0f
 struct bt_hci_le_pa_report {
 	uint16_t handle;
diff --git a/monitor/packet.c b/monitor/packet.c
index b376d5a8b..9d7677bb1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3301,6 +3301,111 @@ static void print_uuid128_list(const char *label, const void *data,
 	}
 }
 
+static void *iov_pull(struct iovec *iov, size_t len)
+{
+	void *data;
+
+	if (iov->iov_len < len)
+		return NULL;
+
+	data = iov->iov_base;
+	iov->iov_base += len;
+	iov->iov_len -= len;
+
+	return data;
+}
+
+static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
+{
+	struct iovec iov;
+	struct bt_hci_le_pa_base_data *base_data;
+	uint8_t i;
+
+	iov.iov_base = (void *) data;
+	iov.iov_len = data_len;
+
+	base_data = iov_pull(&iov, sizeof(*base_data));
+	if (!base_data)
+		goto done;
+
+	/* Level 1 - BASE */
+	print_field("  Presetation Delay: %u", get_le24(base_data->pd));
+	print_field("  Number of Subgroups: %u", base_data->num_subgroups);
+
+	/* Level 2 - Subgroups*/
+	for (i = 0; i < base_data->num_subgroups; i++) {
+		struct bt_hci_le_pa_base_subgroup *subgroup;
+		struct bt_hci_lv_data *codec_cfg;
+		struct bt_hci_lv_data *metadata;
+		uint8_t j;
+
+		print_field("    Subgroup #%u:", i);
+
+		subgroup = iov_pull(&iov, sizeof(*subgroup));
+		if (!subgroup)
+			goto done;
+
+		print_field("    Number of BIS(s): %u", subgroup->num_bis);
+		print_codec_id("    Codec", subgroup->codec.id);
+
+		if (subgroup->codec.id == 0xff) {
+			uint16_t id;
+
+			id = le16_to_cpu(subgroup->codec.vid);
+			print_field("    Codec Company ID: %s (0x%04x)",
+						bt_compidtostr(id), id);
+			print_field("    Codec Vendor ID: 0x%04x",
+						subgroup->codec.vid);
+		}
+
+		codec_cfg = iov_pull(&iov, sizeof(*codec_cfg));
+		if (!codec_cfg)
+			goto done;
+
+		if (!iov_pull(&iov, codec_cfg->len))
+			goto done;
+
+		print_hex_field("    Codec Specific Configuration",
+					codec_cfg->data, codec_cfg->len);
+
+		metadata = iov_pull(&iov, sizeof(*metadata));
+		if (!metadata)
+			goto done;
+
+		if (!iov_pull(&iov, metadata->len))
+			goto done;
+
+		print_hex_field("    Metadata", metadata->data, metadata->len);
+
+		/* Level 3 - BIS(s)*/
+		for (j = 0; j < subgroup->num_bis; j++) {
+			struct bt_hci_le_pa_base_bis *bis;
+
+			print_field("      BIS #%u:", j);
+
+			bis = iov_pull(&iov, sizeof(*bis));
+			if (!bis)
+				goto done;
+
+			print_field("      Index: %u", bis->index);
+
+			codec_cfg = iov_pull(&iov, sizeof(*codec_cfg));
+			if (!codec_cfg)
+				goto done;
+
+			if (!iov_pull(&iov, codec_cfg->len))
+				goto done;
+
+			print_hex_field("      Codec Specific Configuration",
+					codec_cfg->data, codec_cfg->len);
+		}
+	}
+
+done:
+	if (iov.iov_len)
+		print_hex_field("  Data", iov.iov_base, iov.iov_len);
+}
+
 static void print_broadcast_annoucement(const uint8_t *data, uint8_t data_len)
 {
 	uint32_t bid;
@@ -3318,6 +3423,7 @@ static const struct service_data_decoder {
 	uint16_t uuid;
 	void (*func)(const uint8_t *data, uint8_t data_len);
 } service_data_decoders[] = {
+	{ 0x1851, print_base_annoucement },
 	{ 0x1852, print_broadcast_annoucement }
 };
 
-- 
2.35.1

