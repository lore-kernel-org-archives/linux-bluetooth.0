Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49BEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 21:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiKPVSm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiKPVSl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 16:18:41 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAACE6A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 13:18:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so3590155pji.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkc/lBm/VlErz/YrB5ul2/3MtI870A7/6Dj0PqnvpAI=;
        b=iXNj+5wGQb2UH+e5KJQ53bGQ2FgfSbvhGOXWwzP8j25iWr/ysJkFTNKu710XnbeVxg
         Qc2jYEW/xM9kwsd2RVUviN+Rgo7AdoacKnYd6tzyEGan5lk7KAMLy5aC0+y2K8FTowZt
         n1rlCk7RncsfXC6biwvZJIQOhaY/9bBIZFX9APdXlIqW3z6O7YbLf18wseQQcPSSprFk
         Hl6Mz2hqpYeP36qMwOHi12fvEiVxbwJ2Nmt+EQfHCYvaSj+3vVyYl7ZG/MxJ4zRGhTY+
         3fhC7WwhrDM1+ADnXYRBzcrIP8sALrL4VJTZuY6bXq77PSnnf9kv06cd3+suN39xKdFn
         H8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkc/lBm/VlErz/YrB5ul2/3MtI870A7/6Dj0PqnvpAI=;
        b=SJVoYAEMIEcstjHYJQiYLQUikQswTzO853EKp+Hn5LlaTSR0Cly/LgklYFlrJYgR/B
         9gUlkZkR/L2VoTZ/BzxpJGiQE9gZ/1G+GxcNPqP3YolzCCSDkv3WJs2MrgiLAUDkFdfN
         IljBAtFY3dE/ftzIt2M2xtTY/0aWttG1WvGijsdyL0rR6SnQSbX/weGc5Wd2LoKb41IU
         vhQ65FRCk/OVJSCM2Ub0i7Uy3hPYfxPj7TGAqjB4Wlc+F8rvhCEpCpoKMz5CyWmoEFAg
         OPR/Hl0kePOMcWDF9j6QklhxWIodRudvfUDm8uVSwnTq3dI1HFnegL6oO/SZhy9PN0we
         XydQ==
X-Gm-Message-State: ANoB5plNpEhsgCfzV8DZOKPbCvJ4IbVM2qAwlMrCjmlibemF7vItGgeQ
        qFG6aFA0bUCR39xJZWVJ92A4ZBk8RRw=
X-Google-Smtp-Source: AA0mqf6Qv1Yd8vad9E7UAqZDYs3HRoTDdir/csQRG52IkKQvk37Jdx8id4RnNG2CWffSpmhP5zz4kQ==
X-Received: by 2002:a17:902:e0d1:b0:186:738e:5703 with SMTP id e17-20020a170902e0d100b00186738e5703mr10508016pla.136.1668633518162;
        Wed, 16 Nov 2022 13:18:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00176b3c9693esm12738145plf.299.2022.11.16.13.18.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:18:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
Date:   Wed, 16 Nov 2022 13:18:36 -0800
Message-Id: <20221116211836.2671441-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to decode the vendor codecs includec in the response of
BT_HCI_CMD_READ_LOCAL_CODECS_V2.
---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 7aa016a0e2a8..97501c7dc939 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -1787,6 +1787,12 @@ struct bt_hci_rsp_read_local_pairing_options {
 #define BT_HCI_LOCAL_CODEC_LE_CIS		BIT(2)
 #define BT_HCI_LOCAL_CODEC_LE_BIS		BIT(3)
 
+struct bt_hci_vnd_codec_v2 {
+	uint16_t cid;
+	uint16_t vid;
+	uint8_t  transport;
+} __attribute__ ((packed));
+
 struct bt_hci_vnd_codec {
 	uint8_t  id;
 	uint16_t cid;
diff --git a/monitor/packet.c b/monitor/packet.c
index dae763e22e61..134cf398a66f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6384,6 +6384,20 @@ static void print_list(const void *data, uint8_t size, int num_items,
 		print_hex_field("", data, size);
 }
 
+static void print_vnd_codecs_v2(const void *data, int i)
+{
+	const struct bt_hci_vnd_codec_v2 *codec = data;
+	uint8_t mask;
+
+	packet_print_company("  Company ID", le16_to_cpu(codec->cid));
+	print_field("  Vendor Codec ID: 0x%4.4x", le16_to_cpu(codec->vid));
+	print_field("  Logical Transport Type: 0x%02x", codec->transport);
+	mask = print_bitfield(4, codec->transport, codec_transport_table);
+	if (mask)
+		print_text(COLOR_UNKNOWN_SERVICE_CLASS,
+				"  Unknown transport (0x%2.2x)", mask);
+}
+
 static void read_local_codecs_rsp_v2(uint16_t index, const void *data,
 							uint8_t size)
 {
@@ -6417,7 +6431,18 @@ static void read_local_codecs_rsp_v2(uint16_t index, const void *data,
 
 	num_vnd_codecs = rsp->codec[rsp->num_codecs].id;
 
+	size -= 1;
+
 	print_field("Number of vendor codecs: %d", num_vnd_codecs);
+
+	if (size < num_vnd_codecs * sizeof(*rsp->codec)) {
+		print_field("Invalid number of vendor codecs.");
+		return;
+	}
+
+	print_list(&rsp->codec[rsp->num_codecs] + 1, size, num_vnd_codecs,
+			sizeof(struct bt_hci_vnd_codec_v2),
+			print_vnd_codecs_v2);
 }
 
 static void print_path_direction(const char *prefix, uint8_t dir)
-- 
2.37.3

