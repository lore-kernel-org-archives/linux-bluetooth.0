Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D6402BB0
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815005; cv=none; b=iMHgb8RjLGZyLgBVORBs1xIV94aLbri18ShOP7wbzBYCnBqxvc4dlqaC84JM+EazztyE+VhN5kIkIO1kb0AqWHhMOP5HVDyTWapGmriLM+0kKvt5wrbmhsZE/K84ocs+Tcy3pdHVfXyBUzFxCRylbDFMxv24IGHZtaIB4VrPbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815005; c=relaxed/simple;
	bh=dd78etAQqz5hjC9CGJC1A/A9NzWdPk6BmX70qi1ie8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEvsCi5kkNNwipO12gMtHIlbD13cSKE6QzjBKZ5ZRdnt5SFpXvi7iZYiRBhC0SVIbfYYXrUJ/VRwx6oa1pyjjYtyTYh6cuy4lkyOTBptmS0swEm+31xcg9lO5DRTQvW3804Wo1fF2O6MWbOjsuDlESNA25OyM2FSZ+XdqQtu75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUkkqaEW; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUkkqaEW"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9568bae58f7so7247763241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779815001; x=1780419801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf13rR6jaI8wruZQKovSg5s6dxleIAE/w7hkWZuQxVU=;
        b=QUkkqaEW/qY2TsykmvOzZCySIDaenst61obzPFJ2L7u/oL79vuybT/e1iE5k55Uekg
         2E/IDkoYwLJ+ZJU1DX9LOng+YwJtcMRXCBorcPZt1gtR6zVkqWT9+wvAwjYYSPba2LPA
         sAZazY8rtXzFldAsU138k92Goh3oUZRYKX586lTtdGldDCmzpvcEvVFqft1R9h48nRKH
         TN601TQn270HngxWsIEbd8kSSICl43Kuy14HOH6Zde8iIOuhP3oREf7B2fctj8IMox/N
         9AeBmIch3G0XjecsqemLZUbxUPGG1cTnYCcLm58YTwOpuM0MdZ3PhHc0djls2FBf/MRk
         yJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815001; x=1780419801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yf13rR6jaI8wruZQKovSg5s6dxleIAE/w7hkWZuQxVU=;
        b=qg6caCoaiqEgHWzmzRM0LcamADoBv6YrGIDezoqWjhSy8svw3vsJMtfOrLVXhpgFmB
         bBHkWBg81bRSN/ijJQUbu3VH1jDjnxZnuIC/hWt1c0M8P9/btKQAEyv8ZFX+4BvXA29M
         2K7/IOrAeB0Fkybg4S2hstetPRclENv7rUg1zQLpe4H2YRw8WomSPQStKhidkBIg1j73
         YC7kz81o4/dlDilvN7Rt+d3sgVobYSIc40aklerxF5zZZWJ14RFg1slDq/FMbaBoP0yk
         ogZnM8pLAepKjqes7+BYjNP6zeOUuRAD32G+G5CiC4Eo+M040igLgz3PG24MJnuVvMMb
         A5vw==
X-Gm-Message-State: AOJu0YwizzLpzKT/nHYGwRULp7exE8BQtDBAVIr/b7duKkGf2+dnNIoK
	gewNblSaIDILR5m/Neyu0p8JH48Q4BgpbgdWe1pXyt/J57h5I5Ae+QVnZFzTkQ==
X-Gm-Gg: Acq92OFfJkKgN8J2qLMm1ZabeefNW66DRg/NuTEHDdS15EMsbhWn+T6le5hlPHEMO9G
	pS3kLbC3RWd7d0bT4ufX4xrAIJpxBhhborkEqgthVUDAtNAOy7USDgTEtIn4GfYgTQOOVvRiron
	Acb2pQaxlyowIOT6+xTfd7cC52sNAdN9btET4F5eV7P6valr/roby6NoD+baNsuQ1uDMnQ1nNa4
	TTftDABsVBzoSDkZqRhNVQEJXRpddjIDFWvm9HyoVLx+SlTA7hUsfgMmzxJN60KvHt+8TMYhmcH
	ArtMVvlO7/8f5wZF2qgcEN74+6wDmTyq8pyhb4s+TOUP062Dv5/wvog0MJYrTWDK3IHbNXRK22O
	3TVJ0f9BWgF9x9X/UIgwhAIYp0Et2AO13j/CTesglrP266G7OaAOuCtJR+gL7RDj255/mfUYFyM
	VjxLZSBknG8ae4uSyN/FsfHi7FcyI9H2UqGo+mvTWTFpvvxmgKEZdB7iqiWs4uiLRHTJdZ9zuEF
	H8OIaaMZpYjt3MuCg==
X-Received: by 2002:a05:6122:e250:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-5865fc0355cmr10176187e0c.5.1779815000765;
        Tue, 26 May 2026 10:03:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-588c129cba5sm14603504e0c.14.2026.05.26.10.03.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:03:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] monitor: Add decoding support for LE Set Host Feature V2
Date: Tue, 26 May 2026 13:03:09 -0400
Message-ID: <20260526170309.3529062-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526170309.3529062-1-luiz.dentz@gmail.com>
References: <20260526170309.3529062-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add decoding support for LE Set Host Feature V2 (0x2097) command
which uses a 16-bit bit_number field to support extended LE feature
pages:

< HCI Command: LE Set Host F.. (0x08|0x0097) plen 3
        Bit Number: 32
        Features[0/0][8]:
        00 00 00 00 01 00 00 00                          ........
          Connected Isochronous Stream (Host Support)
        Bit Value: 1
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Host Feature V2 (0x08|0x0097) ncmd 1
        Status: Success (0x00)

Assisted-by: OpenCode:claude-opus-4.6
---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index a849c18a96b5..6efccb27e758 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3186,6 +3186,13 @@ struct bt_hci_rsp_le_cs_test {
 #define BT_HCI_CMD_LE_CS_TEST_END		0x2096
 #define BT_HCI_BIT_LE_CS_TEST_END		BT_HCI_CMD_BIT(23, 4)
 
+#define BT_HCI_CMD_LE_SET_HOST_FEATURE_V2	0x2097
+#define BT_HCI_BIT_LE_SET_HOST_FEATURE_V2	BT_HCI_CMD_BIT(47, 4)
+struct bt_hci_cmd_le_set_host_feature_v2 {
+	uint16_t bit_number;
+	uint8_t  bit_value;
+} __attribute__ ((packed));
+
 #define BT_HCI_CMD_LE_FSU			0x209d
 #define BT_HCI_BIT_LE_FSU			BT_HCI_CMD_BIT(48, 1)
 struct bt_hci_cmd_le_fsu {
diff --git a/monitor/packet.c b/monitor/packet.c
index 41f0226c39f8..dcb067ce874f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9820,6 +9820,33 @@ static void le_cs_test_cmd(uint16_t index, const void *data, uint8_t size)
 		cmd->override_parameters_length);
 }
 
+static void le_set_host_feature_v2_cmd(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_host_feature_v2 *cmd = data;
+	uint8_t page;
+	uint8_t features[24] = {};
+	uint16_t bit_number = le16_to_cpu(cmd->bit_number);
+
+	print_field("Bit Number: %u", bit_number);
+
+	if (bit_number < 64) {
+		features[bit_number / 8] |= (1 << (bit_number % 8));
+		print_features(0, features, 0x01);
+	} else {
+		uint16_t bit;
+
+		page = (bit_number - 64) / 24 + 1;
+		/* Adjust the bit number to be relative to the page */
+		bit = (bit_number - 64) % 24;
+		/* Set the bit in the features array */
+		features[bit / 8] |= (1 << ((bit % 8)));
+		print_features(page, features, 0x01);
+	}
+
+	print_field("Bit Value: %u", cmd->bit_value);
+}
+
 static void le_cs_test_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_le_cs_test *rsp = data;
@@ -11013,6 +11040,11 @@ static const struct opcode_data opcode_table[] = {
 				true},
 	{ BT_HCI_CMD_LE_CS_TEST_END, BT_HCI_BIT_LE_CS_TEST_END,
 				"LE CS Test End" },
+	{ BT_HCI_CMD_LE_SET_HOST_FEATURE_V2, BT_HCI_BIT_LE_SET_HOST_FEATURE_V2,
+			"LE Set Host Feature V2",
+			le_set_host_feature_v2_cmd,
+			sizeof(struct bt_hci_cmd_le_set_host_feature_v2),
+			true, status_rsp, 1, true },
 	{ BT_HCI_CMD_LE_FSU, BT_HCI_BIT_LE_FSU,
 				"LE Frame Space Update", le_fsu_cmd,
 				sizeof(struct bt_hci_cmd_le_fsu),
-- 
2.53.0

