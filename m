Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3975C04FE2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 06:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHBG4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjHBG4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 02:56:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76271FF3
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 23:56:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c1f6f3884so352785266b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1690959393; x=1691564193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+R28WS7x8LspJqq60i9Q86zeOEpZyy8YfhBlD3WQG8=;
        b=gWkTSl/pFKyx+EnVrXabCQyFPJxVutxQJerCJVUEALNi6bw3pApK4YY9vpTSEKz46T
         /UVC5v+DWiVsYhstexuEnMNgY224Uz1AkT6b1GV4yx1g5tSDzKfM4RD+vatf7L050i7S
         p1LVfpFppJmlQHbhjSYnKbdYONJFvIRXJZlMW8O8FsGg3iRvtV5/3tfK/DK+bZPox4ft
         8P5AaX7CrvWB7GXUKXtB4CriNAgmZv6D5y9o/CE3xHHfc4cnZjJ5h1P2v2qrkDFRbjHS
         gOBfcbmygiaMsxZoFxYTMaHNs6KW0sKYzcvjL556oL1VPfA9Di/YZkDzvMQA+wJXFWnw
         thaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959393; x=1691564193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+R28WS7x8LspJqq60i9Q86zeOEpZyy8YfhBlD3WQG8=;
        b=AWdeQ/r4dapPV4P9yTVjjJH2jy0OT8FsaLgHN5uECpDcyq0+s8gAVrX2EcEIdcGr/C
         AMhhWVeTju4CxLsjeLkdshhRLi3zBnEgOqovxzkFlyMwozAZNcIS2E5f5Z8ovsgwrf3P
         X8DJ3S9bGSLiQPXthvmEHaSF0jnnNV822gXrslk/sGAwV+lHnaQRGZZwu/YU7kp0y0uN
         tPYv/KkA/nVq/+SFTn8jK4kKQUr/c06l/dTAPoTOvPvnQ9me22hh0tRLzkcShY0Pm1Yt
         Uxa/QK/goFpqwizDDaThtN6r97ovwcBMCIO+KakDjqVDWzBOzrN+an1JaR0fPmWnEqs9
         Aflg==
X-Gm-Message-State: ABy/qLaXzRNjomQK64cw6AU2v3R7p+yimXM9z3AwajpU4TObVNVBzozi
        etgmE0Nj+XsT8P612coVGkFbYw==
X-Google-Smtp-Source: APBJJlFD+WPkkuECCxNhDWViglYWKxur4TnTo98/G0KkvQ2U5k16njzWWmmXzFzolzwsPOgtoAkE0A==
X-Received: by 2002:a17:907:a058:b0:99b:bc51:8ca3 with SMTP id gz24-20020a170907a05800b0099bbc518ca3mr3779046ejc.1.1690959393270;
        Tue, 01 Aug 2023 23:56:33 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0099bd5b72d93sm8567400ejh.43.2023.08.01.23.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:56:33 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Wed, 02 Aug 2023 08:56:29 +0200
Subject: [PATCH v3 2/2] Bluetooth: btqca: Add WCN3988 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-fp4-bluetooth-v3-2-7c9e7a6e624b@fairphone.com>
References: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
In-Reply-To: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for the Bluetooth chip codenamed APACHE which is part of
WCN3988.

The firmware for this chip has a slightly different naming scheme
compared to most others. For ROM Version 0x0200 we need to use
apbtfw10.tlv + apnv10.bin and for ROM version 0x201 apbtfw11.tlv +
apnv11.bin

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/bluetooth/btqca.c   | 13 +++++++++++--
 drivers/bluetooth/btqca.h   | 12 ++++++++++--
 drivers/bluetooth/hci_qca.c | 12 ++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index e7e58a956d15..6f2187fab55f 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -594,14 +594,20 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Firmware files to download are based on ROM version.
 	 * ROM version is derived from last two bytes of soc_ver.
 	 */
-	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
+	if (soc_type == QCA_WCN3988)
+		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
+	else
+		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 
 	if (soc_type == QCA_WCN6750)
 		qca_send_patch_config_cmd(hdev);
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
-	if (qca_is_wcn399x(soc_type)) {
+	if (soc_type == QCA_WCN3988) {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/apbtfw%02x.tlv", rom_ver);
+	} else if (qca_is_wcn399x(soc_type)) {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crbtfw%02x.tlv", rom_ver);
 	} else if (soc_type == QCA_QCA6390) {
@@ -636,6 +642,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	if (firmware_name)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/%s", firmware_name);
+	else if (soc_type == QCA_WCN3988)
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/apnv%02x.bin", rom_ver);
 	else if (qca_is_wcn399x(soc_type)) {
 		if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
 			snprintf(config.fwname, sizeof(config.fwname),
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index b884095bcd9d..fc6cf314eb0e 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -142,6 +142,7 @@ enum qca_btsoc_type {
 	QCA_INVALID = -1,
 	QCA_AR3002,
 	QCA_ROME,
+	QCA_WCN3988,
 	QCA_WCN3990,
 	QCA_WCN3998,
 	QCA_WCN3991,
@@ -162,8 +163,15 @@ int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_send_pre_shutdown_cmd(struct hci_dev *hdev);
 static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
 {
-	return soc_type == QCA_WCN3990 || soc_type == QCA_WCN3991 ||
-	       soc_type == QCA_WCN3998;
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		return true;
+	default:
+		return false;
+	}
 }
 static inline bool qca_is_wcn6750(enum qca_btsoc_type soc_type)
 {
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9b785c947d96..011822519602 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1874,6 +1874,17 @@ static const struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static const struct qca_device_data qca_soc_data_wcn3988 __maybe_unused = {
+	.soc_type = QCA_WCN3988,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 15000  },
+		{ "vddxo", 80000  },
+		{ "vddrf", 300000 },
+		{ "vddch0", 450000 },
+	},
+	.num_vregs = 4,
+};
+
 static const struct qca_device_data qca_soc_data_wcn3990 __maybe_unused = {
 	.soc_type = QCA_WCN3990,
 	.vregs = (struct qca_vreg []) {
@@ -2398,6 +2409,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
 	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
 	{ .compatible = "qcom,qca9377-bt" },
+	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},

-- 
2.41.0

