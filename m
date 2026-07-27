Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E541D642;
	Mon, 27 Jul 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167879; cv=none; b=CXRlmnLa94+UAggqTiI+fJPhqMfMXR/NPRaQzaW9W9vR+qve7I2g6PPCow/ER85DDfYqVUIOClQRBHpT8Lqlr55UC0GAZPrIx/3jeLeMy+P+TCuBLc+c3uJ/hdqTYP5KiPz8aLjQSxwzA6ou9YJ88StQ3kN2hxM/FLGlKszVwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167879; c=relaxed/simple;
	bh=RfSGy3SFZrNvKfzOWBIBrPmFWR8ue5Jmkzn/tto97KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmGxjHuVXkckwQ4QYUyJc+UdySUFockKwW7xYrsQrQUxwwe7NRO/cLgkOKXG4pO0bHM9g4iJ5UicnDSic+A1ri4wfmhw0TAybPh1xWbuQfDv3atUVSoqzADXWFxM3TJO1qvLLT4Da2W8TdQYi8JSejfpupS8bAnSfcwIUxBS0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGgsa3tD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGgsa3tD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831651F000E9;
	Mon, 27 Jul 2026 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785167878;
	bh=7ege+sKJf2mgRs8jm58Qsbm/wxb1PRT2Fb/Td0betCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZGgsa3tD9tcD26jgZQhWpNCNokSk0UEAXgUiLg5iD5vOkzDfyhcg/qy82gqqZf0y5
	 86XZMiw3mApU58K5d/NEwYVileGvzrHRRIg3S3WQvTGn+V+xjw5SELmKWS+Yszxagx
	 icoJOCHZ7h+nY4RzLN8NcRSygc6tXSty7+uRkC84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 17:57:33 +0200
Subject: [PATCH 2/3] Bluetooth: btmtk: Fix short read errors in
 btmtk_usb_reg_read()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bt-ctrl-v1-2-2e8650e9df01@linuxfoundation.org>
References: <20260727-bt-ctrl-v1-0-2e8650e9df01@linuxfoundation.org>
In-Reply-To: <20260727-bt-ctrl-v1-0-2e8650e9df01@linuxfoundation.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=3078;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=RfSGy3SFZrNvKfzOWBIBrPmFWR8ue5Jmkzn/tto97KA=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFnp9V9Krs2yONUZsa3/ffQHrbeSy620WvRrz6/6bH9DS
 q/+6MrYjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjITH2GeTqn9/IIKs9U13w1
 eVP9424u/g3bTBgWTJrtYZurc/383pZIFon1DKtjm7/tAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

If btmtk_usb_reg_read() gets a "short" read from a device, it will
accidentally treat that as a "real" read and populate the returned value
with some unknown and probably totally invalid data.

Fix this logic error up by calling usb_control_msg_recv() which
guarantees a "full" read happens, and then simplify the error checking
for when btmtk_usb_reg_read() is called (it's really just
btmtk_usb_id_get() that calls btmtk_usb_reg_read(), so fix up those
return sites.

Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btmtk.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6f060e4433db..66b346761043 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -827,27 +827,21 @@ static int btmtk_usb_uhw_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
 static int btmtk_usb_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
 {
 	struct btmtk_data *data = hci_get_priv(hdev);
-	int pipe, err, size = sizeof(u32);
-	void *buf;
+	u8 buf[sizeof(u32)];
+	int err;
 
-	buf = kzalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x63,
-			      USB_TYPE_VENDOR | USB_DIR_IN,
-			      reg >> 16, reg & 0xffff,
-			      buf, size, USB_CTRL_GET_TIMEOUT);
+	*val = 0;
+	err = usb_control_msg_recv(data->udev, 0, 0x63,
+				   USB_TYPE_VENDOR | USB_DIR_IN,
+				   reg >> 16, reg & 0xffff,
+				   buf, sizeof(buf), USB_CTRL_GET_TIMEOUT,
+				   GFP_KERNEL);
 	if (err < 0)
-		goto err_free_buf;
+		return err;
 
 	*val = get_unaligned_le32(buf);
 
-err_free_buf:
-	kfree(buf);
-
-	return err;
+	return 0;
 }
 
 static int btmtk_usb_id_get(struct hci_dev *hdev, u32 reg, u32 *id)
@@ -974,7 +968,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	}
 
 	err = btmtk_usb_id_get(hdev, 0x70010200, &val);
-	if (err < 0 || (!val && dev_id != 0x6639))
+	if (err || (!val && dev_id != 0x6639))
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
 
 	return err;
@@ -1318,24 +1312,24 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	calltime = ktime_get();
 
 	err = btmtk_usb_id_get(hdev, 0x80000008, &dev_id);
-	if (err < 0) {
+	if (err) {
 		bt_dev_err(hdev, "Failed to get device id (%d)", err);
 		return err;
 	}
 
 	if (!dev_id || dev_id != 0x7663) {
 		err = btmtk_usb_id_get(hdev, 0x70010200, &dev_id);
-		if (err < 0) {
+		if (err) {
 			bt_dev_err(hdev, "Failed to get device id (%d)", err);
 			return err;
 		}
 		err = btmtk_usb_id_get(hdev, 0x80021004, &fw_version);
-		if (err < 0) {
+		if (err) {
 			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
 			return err;
 		}
 		err = btmtk_usb_id_get(hdev, 0x70010020, &fw_flavor);
-		if (err < 0) {
+		if (err) {
 			bt_dev_err(hdev, "Failed to get fw flavor (%d)", err);
 			return err;
 		}

-- 
2.55.0

