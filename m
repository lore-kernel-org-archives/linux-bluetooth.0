Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A565EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 00:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjG2Arh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjG2Arg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 20:47:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4446B9
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:47:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so4647582e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690591557; x=1691196357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taXIayWUYn7caj+vvRUEtm9WjZHqMH5PPGsEOt5zeXc=;
        b=y5wNExmkKxSfp9XAUZDsXMZJ50qwIz+rw34Cs1//zZqm5xBhpOwUhh+BQb6EalPdkg
         mgWhswqiOZW2VNR92tYD3w9qaqImayj2zHM21RzsKagXq2Ef74u6JhXDzWHsC30EaOxA
         IHDgDm0mFzZ+hKB/sLyX0Jlgw30S8eJTfaw/OUC1Gfx72FGPPrYiTbpavolaKaNiD6Co
         aBruVi1wrp+1BD/qtLjj/7zdRPSfbjc4YHNhmJMt+bV3YRn6AxH1pU1NoXrhMkSDgLyz
         YDr8E5ZqZYFByJ+7ZmwHuL1gJW/GwK8sVg8gCr5XyfFqLXKrjc7dhNuit2PyLiuZUJGT
         6Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591557; x=1691196357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taXIayWUYn7caj+vvRUEtm9WjZHqMH5PPGsEOt5zeXc=;
        b=aY+77yrtwn6dgfOFH4hw3U9vd0Thbr9nqOmOfOx1lJve03Grkr1Vo0eWo3Flp2fKA8
         ZvZd3iCLxW4H/oeIfJNLNYTDz1Ss+qpYrG4pYyWkTMVJgDtdjSqEncqGB25g98xYyNFE
         5lCfy4DnBg3AWFMH3zpaTJmvet/J/1YW6/0AY9/hTrims9dgFoh/PawR20dOBuQ3hDRT
         ZbZRfP+RnvhlAtdnhh0+in0fUsA9iyrADNgPW6tXnTk7j7xzruJZRGvB+Dqssh2fSPel
         BNRyvdC78TjmO2JlpyZbbCybvQR8C8a1e7RykdzCEcMXKyX32w5EjnyjEw0ry/TSA/iQ
         aseQ==
X-Gm-Message-State: ABy/qLYUVPLg1rl0Na+OSOzaNYVooXTvCr1cABpuvxu8nFpCTwgqxAEP
        vvW9KLUxXFg8vl6sDLJJrKnIuu9w4sXFOM9W2Ls=
X-Google-Smtp-Source: APBJJlGCFFzrZYFm9G90+xOa/NJYZq2KLWeQ0Mh+R7GUpcoH0CpkDrrz3/y+1BEd313bTQTsrpQK+g==
X-Received: by 2002:a05:6512:290:b0:4fd:fef7:95ae with SMTP id j16-20020a056512029000b004fdfef795aemr2778155lfp.9.1690591557787;
        Fri, 28 Jul 2023 17:45:57 -0700 (PDT)
Received: from rymek.localdomain (217.96.255.138.ipv4.supernova.orange.pl. [217.96.255.138])
        by smtp.gmail.com with ESMTPSA id r25-20020ac24d19000000b004fe1f1c0ee4sm617746lfi.82.2023.07.28.17.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:45:57 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 4/5] monitor: Add support to decode le read ISO link quality
Date:   Sat, 29 Jul 2023 02:45:51 +0200
Message-Id: <20230729004552.1422547-5-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

btmon: Add parsing LE Read ISO link quality

    > HCI Event: Command Complete (0x0e) plen 34                                                                              #14 24.982811
          LE Read ISO link quality (0x08|0x0075) ncmd 1
            Status: Success (0x00)
            Handle: 98
            TX unacked packets 0
            TX flushed packets 257602
            TX last subevent packets 0
            TX retrnansmitted packets 0
            TX crc error packets 2594
            RX unreceived packets 0
            Duplicated packets 0
---
 monitor/bt.h     | 18 ++++++++++++++++++
 monitor/packet.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 4482e6e2c..dca2dc8b8 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2914,6 +2914,24 @@ struct bt_hci_cmd_le_set_host_feature {
 	uint8_t  bit_value;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_ISO_LINK_QUALITY	0x2075
+#define BT_HCI_BIT_LE_READ_ISO_LINK_QUALITY	BT_HCI_CMD_BIT(45, 1)
+struct bt_hci_cmd_le_read_iso_link_quality {
+	uint16_t handle;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_read_iso_link_quality {
+	uint8_t  status;
+	uint16_t handle;
+	uint32_t tx_unacked_packets;
+	uint32_t tx_flushed_packets;
+	uint32_t tx_last_subevent_packets;
+	uint32_t retransmitted_packets;
+	uint32_t crc_error_packets;
+	uint32_t rx_unreceived_packets;
+	uint32_t duplicated_packets;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index fd8df7a8b..3031b028f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8946,6 +8946,34 @@ static void le_set_host_feature_cmd(uint16_t index, const void *data,
 	print_field("Bit Value: %u", cmd->bit_value);
 }
 
+static void le_read_iso_link_quality_cmd(uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_iso_link_quality *cmd = data;
+
+	print_field("Handle: %d", le16_to_cpu(cmd->handle));
+}
+
+static void status_le_read_iso_link_quality_rsp(uint16_t index,  const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_iso_link_quality *rsp = data;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("Handle: %d", le16_to_cpu(rsp->handle));
+	print_field("TX unacked packets %d", rsp->tx_unacked_packets);
+	print_field("TX flushed packets %d", rsp->tx_flushed_packets);
+	print_field("TX last subevent packets %d",
+					rsp->tx_last_subevent_packets);
+	print_field("TX retransmitted packets %d",
+						rsp->retransmitted_packets);
+	print_field("TX crc error packets %d", rsp->crc_error_packets);
+	print_field("RX unreceived packets %d", rsp->rx_unreceived_packets);
+	print_field("Duplicated packets %d", rsp->duplicated_packets);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -9895,6 +9923,16 @@ static const struct opcode_data opcode_table[] = {
 				"LE Set Host Feature", le_set_host_feature_cmd,
 				sizeof(struct bt_hci_cmd_le_set_host_feature),
 				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_READ_ISO_LINK_QUALITY,
+				BT_HCI_BIT_LE_READ_ISO_LINK_QUALITY,
+				"LE Read ISO link quality",
+				le_read_iso_link_quality_cmd,
+				sizeof(
+				struct bt_hci_cmd_le_read_iso_link_quality),
+				true, status_le_read_iso_link_quality_rsp,
+				sizeof(
+				struct bt_hci_rsp_le_read_iso_link_quality),
+				true },
 	{ }
 };
 
-- 
2.34.1

