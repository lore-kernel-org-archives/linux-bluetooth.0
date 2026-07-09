Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83E40242D;
	Thu,  9 Jul 2026 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588717; cv=none; b=DcI8H3MRsrwnAJLD4gv0dZ+FDTI0hb12n8KhRra8m0GfZqUVt+8oJA7vN+8kIcWGNT/04B1z/otJSKWfxZjHz/3TYWk6iSu8+PrQDFoilkZcyujXxqCjaHZh6uQrZK4JJh+cf2kxB1CvRAzo4X0OCnbB1ydWmYVSWYegxB8951E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588717; c=relaxed/simple;
	bh=zSb2qTXstNSO4+tg5smeErLlaavovFWajf+p3/s4dTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFvhT/oioFUUCaMuJQZXjlkp16LMNaKzth8evDLjotmaJ/NVhoAWVHTIgtccbOVpP6B6T60GuQ2s/OgXTTk+M/p9utmOUDBqF/NgRsyojESh1zey4YpQmKZmZ9KIlXkRK8WuS3cnRpq1U5bMZWxpNPGn+lfykjpHqIqNXASMBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhHGF524; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhHGF524"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67FDDC2BCF7;
	Thu,  9 Jul 2026 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783588716;
	bh=zSb2qTXstNSO4+tg5smeErLlaavovFWajf+p3/s4dTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EhHGF524qyJVcpmoOh/GAZ3WcOV8gy34/ARxzufm/LSLKRLAn0BPbTjWgdAmB6/X0
	 55JkmOv3xZX4AkHbW+5nmAO8DEURtBzOl+KO8w/lUwcIC+w7MrMHQzMVtAWtc3TgBB
	 zgZZCkU8SNHk1x+Fn8p+IIMbzk5RQV/2KezkaGhcX1W4avhLtm4ILOayd25tpHaOpF
	 D0G7JMDQjiUwamVGVENaefqaEX328XX7uqxtoUgvR6B2sAu2wHsKva09C7cFA3DxSy
	 iDvpF3RYMz0nUg8u5O8UORt1lG97Rqe6JFWs6g6ettlPEfyTUkS8c3tnD0+F4X9M9p
	 4VRGkG8SXzdnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A93CC44501;
	Thu,  9 Jul 2026 09:18:36 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 09 Jul 2026 13:18:28 +0400
Subject: [PATCH v5 2/6] Bluetooth: btqca: Add IPQ5018 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ipq5018-bluetooth-v5-2-e476c41f03b8@outlook.com>
References: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
In-Reply-To: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783588713; l=2878;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=qc8c/Yy1ZkHuPR/drWQrBMtWnyaqgtWj4Gk+5ass+zE=;
 b=/v5zO0whsAkNyt9TgUc+SglI5cJliQW02KXgAkz9Is3OfxuZZKD+cGI7ZBFDBIWMRCr4Jv5JJ
 uVx9J4umom/BlB+JkUOolaeRA4rwB8C+L0cQOGHZEkJiMJ0T3+WCSIL
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add the IPQ5018 SoC type and support for loading its firmware.

The firmware tested has been taken from GPL sources of various router
boards. Firmware files needed are:
- qca/bt_fw_patch.mbn
- qca/mpnv10.bin

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/bluetooth/btqca.c | 16 ++++++++++++++++
 drivers/bluetooth/btqca.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 08600b0fc041..eed30a4480e0 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -361,6 +361,9 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 		break;
 
 	case TLV_TYPE_NVM:
+		if (soc_type == QCA_IPQ5018)
+			break;
+
 		if (fw_size < sizeof(struct tlv_type_hdr))
 			return -EINVAL;
 
@@ -778,6 +781,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	else
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 
+	if (soc_type == QCA_IPQ5018)
+		goto download_nvm;
+
 	if (soc_type == QCA_WCN6750)
 		qca_send_patch_config_cmd(hdev);
 
@@ -865,6 +871,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
 		qca_read_fw_board_id(hdev, &boardid);
 
+download_nvm:
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name) {
@@ -878,6 +885,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		}
 	} else {
 		switch (soc_type) {
+		case QCA_IPQ5018:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/mpnv%02x.bin", rom_ver);
+			break;
 		case QCA_QCA2066:
 			qca_get_nvm_name_by_board(config.fwname,
 						  sizeof(config.fwname),
@@ -942,7 +953,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		return err;
 	}
 
+	if (soc_type == QCA_IPQ5018)
+		msleep(NVM_READY_DELAY_MS);
+
 	switch (soc_type) {
+	case QCA_IPQ5018:
 	case QCA_QCA2066:
 	case QCA_QCA6390:
 	case QCA_WCN3991:
@@ -982,6 +997,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	bt_dev_dbg(hdev, "QCA HCI_RESET succeed");
 
 	switch (soc_type) {
+	case QCA_IPQ5018:
 	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 8f3c1b1c77b3..343cd62d1137 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -54,6 +54,8 @@
 #define QCA_HSP_GF_SOC_ID		0x1200
 #define QCA_HSP_GF_SOC_MASK		0x0000ff00
 
+#define NVM_READY_DELAY_MS		1500
+
 enum qca_baudrate {
 	QCA_BAUDRATE_115200	= 0,
 	QCA_BAUDRATE_57600,
@@ -158,6 +160,7 @@ enum qca_btsoc_type {
 	QCA_WCN6750,
 	QCA_WCN6855,
 	QCA_WCN7850,
+	QCA_IPQ5018,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)

-- 
2.53.0


