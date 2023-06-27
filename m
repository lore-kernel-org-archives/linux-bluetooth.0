Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020DEEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 08:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjF0IQ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjF0IQP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 04:16:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F3269E
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:16:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso17843205e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687853767; x=1690445767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWdGMHLUvI4jnIJq0D49VO5apiLGxS8QLHrwxd5EI0k=;
        b=b9tREru0OD/ZHc7wlr9MYzwp6KHclZOHl9cGkXqmwB20s4PVu14KV5GrpAyk+B6I80
         4xcjxRCI2e5KWvP6mzL6l7aZxZ5dIrSOjFAxLhNbB9GJPfrN3AFHKr2gD1qQOf0U4dKI
         Qm5bL1elVbe9iOhC0ksYCFkNMSWXVrry5XkbutjC9LRs8J5FSHiVGlf5yaLGf5cdAUJw
         AGTO7rqSRnsCE21aZwPj7xwShEpsZwpUUxOMvqY7Qb5pjFeLczfzHhQ7OX5buEAlOOXH
         e+gEWPVYWj1bjOHU6F7eXPzEgDQgPDaORbhOG/bIO7/mv8WTF2TM0Abu3nFftWD0GIzz
         3odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853767; x=1690445767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWdGMHLUvI4jnIJq0D49VO5apiLGxS8QLHrwxd5EI0k=;
        b=RbvEfb9HAONz4oxQNFWVc+Y6QzyXiRTpsAPublaThH67yqMtjaL6aZjyoNFVJuK264
         bEhWBZ4p6HK0dS1+KR1e9OCqng3n2SjSkWsQEJ3wtfeGMY4JeXPqNyAxlMzGj1BCDTGQ
         LxPBxZX7RwztVk+vbXcIb5J+Bg1BDsY7+WQv3Mt8Cpb9ko/k2+Bux68mDM1xWfTpCyL2
         HFPYZqyziWph4xiYkPsAX+Whle940Argxq3ieI8xnWwu7VHUSg6/HeBhvjjp3TGZc9mK
         Cl031V7hpgpJt6vrpEupI/zaMSlF9TrThbGnNttCjbx/hfv68ZPECHc0szjws7eQ/YQP
         mnvw==
X-Gm-Message-State: AC+VfDzVgkp1iz2t5GKzxzWeIJaNy90NX3MYjtUgGIgMfd89QnuxmKtb
        gB4z2gJBBdZVj+lMgF1XSD2MTA==
X-Google-Smtp-Source: ACHHUZ4kGnp8U6sxDru0a2geUBjkD1c58Xcnbj33TGo1J+B3ZAaadGUZCgbFN6V/N0GEc/7YwZJP4w==
X-Received: by 2002:a05:600c:3659:b0:3f7:aee8:c23a with SMTP id y25-20020a05600c365900b003f7aee8c23amr32960366wmq.19.1687853767426;
        Tue, 27 Jun 2023 01:16:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm3922480wmi.46.2023.06.27.01.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:16:07 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 27 Jun 2023 10:15:56 +0200
Subject: [PATCH v2 3/5] bluetooth: qca: add support for WCN7850
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v2-3-98b0043d31a4@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KswRj5emfBNXe1IRUfaPUDmnZUwBAdKIfly6cedeEo8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkmprBGt2ivxjqvRQvptRv21FllNol2Y8bN3HMhcZX
 wTO+ytiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJqawQAKCRB33NvayMhJ0ZjjD/
 97QNDheEQj5KkRINVM3j/XAiWIvsgcOsNmpFK0KFFEmUFqBoIwaaiVDHwXCbXXGAOwzlWkdfr+/svW
 +VFe3DInEH5YR2vGywy4+wj2YzpI8Ygx+T+hN0zID44ZqaSVNemUR1Y55NYE0lVZgWwnV76+mi05bM
 WuJMHNM9Aq2IH1rpkZh1DW+mBxR7DRFLMlpKrJkwIComNCZn/tPCauaguZ3g/bziGpJ5EVBSExk/U/
 533IE319KR0YYFdUJDJ1fVxWuzW3QPchqWv7lv6W80VSuix0B85kIyoEtL/iM5hkV1GeN+u0cjUFyO
 hCVmj0Swi93pxMv6W0hrIH1oCWEaGK/UC7bE67IThf7TfcgirLoaiyEr1zJDZATi9+OEaUYDlOLtcg
 sa0JCTCAkaagrWSRod4V8sCWmpHV2rA6Sx7VVf5y7qgBaZVkMGJ282kalUGpIHuExQB5LV8ZNosa3R
 xXMBuF1c3ZsFqsYD7u4LZiTmUY9xsnsuErTeLXFs87T/jxLNUJ870O8bKi24TJLr1sQGUkJNvwy9AO
 mWmQkQyW/HAcPC6BQpmBn8o0Bzdr+XNgZ8iSGH68Z59vRLJYG7BJKCt/6KmhzYB3f9mj4L7PfvEfab
 uV2BfbReKH5gt3PW4rwxkL/iqbQet7MFfJPAHb8CmRKpPFC6WWUVTG6l8HQQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for the WCN7850 Bluetooth chipset.

Tested on the SM8550 QRD platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/bluetooth/btqca.c   | 10 ++++++++++
 drivers/bluetooth/btqca.h   |  1 +
 drivers/bluetooth/hci_qca.c | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 13820cebe5ba..982ce94d7350 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -624,6 +624,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hpbtfw%02x.tlv", rom_ver);
 		break;
+	case QCA_WCN7850:
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hmtbtfw%02x.tlv", rom_ver);
+		break;
 	default:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/rampatch_%08x.bin", soc_ver);
@@ -668,6 +672,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/hpnv%02x.bin", rom_ver);
 			break;
+		case QCA_WCN7850:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/hmtnv%02x.bin", rom_ver);
+			break;
 
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
@@ -686,6 +694,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_QCA6390:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		err = qca_disable_soc_logging(hdev);
 		if (err < 0)
 			return err;
@@ -719,6 +728,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		/* get fw build info */
 		err = qca_read_fw_build_info(hdev);
 		if (err < 0)
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index e7d50a821bb7..34f507bcbfca 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -148,6 +148,7 @@ enum qca_btsoc_type {
 	QCA_QCA6390,
 	QCA_WCN6750,
 	QCA_WCN6855,
+	QCA_WCN7850,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 25f1eeb605b6..792ddf692bc4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1330,6 +1330,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		usleep_range(1000, 10000);
 		break;
 
@@ -1414,6 +1415,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1454,6 +1456,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN3998:
 		case QCA_WCN6750:
 		case QCA_WCN6855:
+		case QCA_WCN7850:
 			hci_uart_set_flow_control(hu, true);
 			break;
 
@@ -1486,6 +1489,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN3998:
 		case QCA_WCN6750:
 		case QCA_WCN6855:
+		case QCA_WCN7850:
 			hci_uart_set_flow_control(hu, false);
 			break;
 
@@ -1750,6 +1754,7 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		ret = qca_regulator_init(hu);
 		break;
 
@@ -1806,6 +1811,10 @@ static int qca_setup(struct hci_uart *hu)
 		soc_name = "wcn6855";
 		break;
 
+	case QCA_WCN7850:
+		soc_name = "wcn7850";
+		break;
+
 	default:
 		soc_name = "ROME/QCA6390";
 	}
@@ -1826,6 +1835,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
 
@@ -1854,6 +1864,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		break;
 
 	default:
@@ -1996,6 +2007,20 @@ static const struct qca_device_data qca_soc_data_wcn6855 __maybe_unused = {
 	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
+static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unused = {
+	.soc_type = QCA_WCN7850,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 5000 },
+		{ "vddaon", 26000 },
+		{ "vdddig", 126000 },
+		{ "vddrfa0p8", 102000 },
+		{ "vddrfa1p2", 257000 },
+		{ "vddrfa1p9", 302000 },
+	},
+	.num_vregs = 6,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+};
+
 static void qca_power_shutdown(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
@@ -2177,6 +2202,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2206,7 +2232,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 					       GPIOD_IN);
 		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
-		     data->soc_type == QCA_WCN6855))
+		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_WCN7850))
 			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
@@ -2284,6 +2311,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		if (power->vregs_on) {
 			qca_power_shutdown(&qcadev->serdev_hu);
 			break;
@@ -2475,6 +2503,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
 	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
+	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);

-- 
2.34.1

