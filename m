Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154323C8BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797318; cv=none; b=YdCk0vu0XHEKAuihdNdnxu6J3+LszQV+/Xenv/XtF0Sg1d3GGfNfeDT/MJBIQfQ62YkKpcek2/PrbmsM3LggdfJrr+zUxODgzcZsCzMoS7cWq5oywi++ROLfcriFeSzueXV44OodaLSOo7tNfsgChz7RkIJKs6Ig1LefadKwbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797318; c=relaxed/simple;
	bh=Q/fG209eNuB+Casr6IgvFERAVtHxO70cTH56MpOen7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c6OEqWa98fM1bGkfGvQJ8O3fSIW710EouEN7FJlTR+JcspSnhYRdc7IJa6jB7sMnxgBvlGSbgXvkq+cUse9G2s9mKz9GIvJEww5McqbD38MOeUoMx+pXbwk/ro5R6UR746ZpQJVslN0o2Q7Gkk1gd4qCWC+AGeQZElHPeKjLpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAXnWb0b; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAXnWb0b"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af5268afde2so2426791a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 02:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744797316; x=1745402116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cbsZaizYYjMn2IR75g90YcbvfZG1vzwMBJAxeW8a18=;
        b=iAXnWb0b2Bef6CV1El833EucMhq9WWie41S3tvf+X4IA7eI9lwWvBuLZQ17d9Ihw3w
         vCUiE9jBP75XjiflSNb7z6FDpStQOnI/dWDvN3nJaWiETWROZvUviehyMJX+mGIX+bG7
         XxJjXljFscQIhqAQBiOpxrXbXXEFSZL+wlHqbjrf+txVbQYMhO2C8nTZOBHMoE6gMIMk
         tF9Xb44ApHYVqlgv1NYNTI4h1dQeKcAzoxRLu2qJhjYrIXZigRgDrt/UWrfCvij+9w4P
         /QQ5ZUOO4zGO7misuogxcjJao2G8F2/Yhe9Txp0q41ILLfngev3xJ3fulMdwq4D6xjzS
         9Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797316; x=1745402116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cbsZaizYYjMn2IR75g90YcbvfZG1vzwMBJAxeW8a18=;
        b=v0n5DT+YeLgyIN6wL3gwO7o9YBrQP7jxc/ByzLAd9T7ap/SXUAnkJlMb8mzMnYRU+s
         xt4yp90lJEu3Btop5DzAyOIOEvAvXDozLEgPsFHOnHwgkBc3IN2cT5g3KCwQOxwjcwSo
         lQ2QaxArzkooLQlWXqWXG2kJrCMHl9aVnjFlovJhk4iytY88YxPZyr6mPqllff2JrkPh
         3Qubf0zjpoPj0SFt/wuf0IRG4CBVa1F4ZeaX15ubfMC0FZlyqeyqTudYkbR+C+3G3Tze
         /62L+DLxAl/1aMh7CCXDnys3t+K2ez+H77cO1tdtRLTr4ZccRRPkDkj+BFMVVkcDhlbr
         CQmA==
X-Forwarded-Encrypted: i=1; AJvYcCW9EujMMviwXczK20ykW0zzz29bnDva4tiHafJWlxw/r6rczeW05RH99KcA6p/B7iJEA3bceNkUXdlzQEuSDLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFc3DR+shPRrsRqlDyGIW3DuaQwGoTBiXHcovejQlg2XD0m7Y
	q9evtYEJxPQre/hDz1l/1JwJpqKc8OoD2xzXhMZTczxwPmQsZ9YtN4vEU9GqSY2pzv2mCZsZlg2
	kujB3ww==
X-Google-Smtp-Source: AGHT+IGHdOXWpRx/2gH+PSEoKzapftvACepuMrouELQ7bjggHGK1cr1jCowF5FKfUpJR59JdUdLUPzfU1iaT
X-Received: from plsb2.prod.google.com ([2002:a17:902:b602:b0:224:2ae9:b271])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f705:b0:21a:8300:b9d5
 with SMTP id d9443c01a7336-22c358e7b70mr21660775ad.23.1744797316070; Wed, 16
 Apr 2025 02:55:16 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:53:36 +0000
In-Reply-To: <20250416095505.769906-1-chharry@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416095505.769906-1-chharry@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416095505.769906-2-chharry@google.com>
Subject: [PATCH v2 2/4] Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
From: Hsin-chen Chuang <chharry@google.com>
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
SCO data through USB Bluetooth chips, it's observed that with the patch
HFP is flaky on most of the existing USB Bluetooth controllers: Intel
chips sometimes send out no packet for Transparent codec; MTK chips may
generate SCO data with a wrong handle for CVSD codec; RTK could split
the data with a wrong packet size for Transparent codec; ... etc.

To address the issue above one needs to reset the altsetting back to
zero when there is no active SCO connection, which is the same as the
BlueZ behavior, and another benefit is the bus doesn't need to reserve
bandwidth when no SCO connection.

This patch adds "Supported Altsettings" and "Switch Altsetting" commands
that allow the user space program to configure the altsetting freely.

This patch is tested on ChromeOS devices. The USB Bluetooth models
(CVSD, TRANS alt3, and TRANS alt6) could pass the stress HFP test narrow
band speech and wide band speech.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btusb.c | 72 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79a944cdb662..a16ca3128ac7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3755,12 +3755,31 @@ static ssize_t isoc_alt_store(struct device *dev,
 
 static DEVICE_ATTR_RW(isoc_alt);
 
+#define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS \
+		hci_opcode_pack(HCI_DRV_OGF_DRIVER_SPECIFIC, 0x0000)
+#define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE	0
+struct btusb_hci_drv_rp_supported_altsettings {
+	__u8	num_supported_altsettings;
+	__u8	supported_altsettings[];
+} __packed;
+
+#define BTUSB_HCI_DRV_OP_SWITCH_ALTSETTING \
+		hci_opcode_pack(HCI_DRV_OGF_DRIVER_SPECIFIC, 0x0001)
+#define BTUSB_HCI_DRV_SWITCH_ALTSETTING_SIZE		1
+struct btusb_hci_drv_cmd_switch_altsetting {
+	__u8	new_altsetting;
+} __packed;
+
 static const struct {
 	u16 opcode;
 	const char *desc;
 } btusb_hci_drv_supported_commands[] = {
 	/* Common commands */
 	{ HCI_DRV_OP_READ_INFO, "Read Info" },
+
+	/* Driver specific commands */
+	{ BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS, "Supported Altsettings" },
+	{ BTUSB_HCI_DRV_OP_SWITCH_ALTSETTING,     "Switch Altsetting" },
 };
 static int btusb_hci_drv_read_info(struct hci_dev *hdev, void *data,
 				   u16 data_len)
@@ -3797,11 +3816,62 @@ static int btusb_hci_drv_read_info(struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int btusb_hci_drv_supported_altsettings(struct hci_dev *hdev, void *data,
+					       u16 data_len)
+{
+	struct btusb_data *drvdata = hci_get_drvdata(hdev);
+	struct btusb_hci_drv_rp_supported_altsettings *rp;
+	size_t rp_size;
+	int err;
+	u8 i;
+
+	/* There are at most 7 alt (0 - 6) */
+	rp = kmalloc(sizeof(*rp) + 7, GFP_KERNEL);
+
+	rp->num_supported_altsettings = 0;
+	if (drvdata->isoc)
+		for (i = 0; i <= 6; i++)
+			if (btusb_find_altsetting(drvdata, i))
+				rp->supported_altsettings[
+					rp->num_supported_altsettings++] = i;
+
+	rp_size = sizeof(*rp) + rp->num_supported_altsettings;
+
+	err = hci_drv_cmd_complete(hdev, BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS,
+				   HCI_DRV_STATUS_SUCCESS, rp, rp_size);
+	kfree(rp);
+	return err;
+}
+
+static int btusb_hci_drv_switch_altsetting(struct hci_dev *hdev, void *data,
+					   u16 data_len)
+{
+	struct btusb_hci_drv_cmd_switch_altsetting *cmd = data;
+	u8 status;
+
+	if (cmd->new_altsetting > 6) {
+		status = HCI_DRV_STATUS_INVALID_PARAMETERS;
+	} else {
+		if (btusb_switch_alt_setting(hdev, cmd->new_altsetting))
+			status = HCI_DRV_STATUS_UNSPECIFIED_ERROR;
+		else
+			status = HCI_DRV_STATUS_SUCCESS;
+	}
+
+	return hci_drv_cmd_status(hdev, BTUSB_HCI_DRV_OP_SWITCH_ALTSETTING,
+				  status);
+}
+
 static const struct hci_drv_handler btusb_hci_drv_common_handlers[] = {
 	{ btusb_hci_drv_read_info,	HCI_DRV_READ_INFO_SIZE },
 };
 
-static const struct hci_drv_handler btusb_hci_drv_specific_handlers[] = {};
+static const struct hci_drv_handler btusb_hci_drv_specific_handlers[] = {
+	{ btusb_hci_drv_supported_altsettings,
+				BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE },
+	{ btusb_hci_drv_switch_altsetting,
+				BTUSB_HCI_DRV_SWITCH_ALTSETTING_SIZE },
+};
 
 static struct hci_drv btusb_hci_drv = {
 	.common_handler_count	= ARRAY_SIZE(btusb_hci_drv_common_handlers),
-- 
2.49.0.604.gff1f9ca942-goog

