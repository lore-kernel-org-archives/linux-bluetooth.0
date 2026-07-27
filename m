Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911213B6370;
	Mon, 27 Jul 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167876; cv=none; b=r4rtrfqhhXHOr+4s5bEPz6mEadPL/2u6ZWIswLpDRbwtiXSq+aZwRYwSNeLPYfAGCUBqTrFc61e+/BZG1VRuzJMvN/3EDWd0TabjsPsEOHegVyQRaneYzXFWxkT3dd4573A8PU3/bD5nytkVO/9FLNS9wBllcIOrauVEAERZ080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167876; c=relaxed/simple;
	bh=SoyA4nOlRFhlH/AHoEWo0VWjF2oSA1bsA5ThcHquX9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZraOsABVXLzvlbuAYAgg9CH1SBSW6VUMbOOt/bnhmdt7h8QcDD0Cd2NyRGmaUzoDvR0x80J9ih/xu5vJMBYyK6tIlKuugvsp5mnEhgQ+vQiieWFF7UsbNrcW8yUiCAisUCHup1wZBT968c8kaSBgcXPSLJWGQJKPZluxaQ+f0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VH/8F1xq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VH/8F1xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E961F000E9;
	Mon, 27 Jul 2026 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785167875;
	bh=/h0F9JQcOZnW/l+lW9zTE+yA6il3JmCeYtsEMG8oz4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VH/8F1xqvYUL0W5Q9TE/o8PquZGAlzrNDY3zy2uJbJ4w+PuUxqy2jdwka4mbP5duq
	 iqYglzghGUXY3QWtQzrzv/DZ8iOEM/c/3baQgI95/eYuaQ3g0q8ynkFDwHjVXFPsjw
	 QOenB53crvwR6u3OqTiXZIdEh0IVxKwFPrcA1ySQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 17:57:32 +0200
Subject: [PATCH 1/3] Bluetooth: btmtk: Fix short read errors in
 btmtk_usb_uhw_reg_read()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bt-ctrl-v1-1-2e8650e9df01@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5211;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=SoyA4nOlRFhlH/AHoEWo0VWjF2oSA1bsA5ThcHquX9c=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFnp9V8KmP43r09sPFe319qrZl6E1JblQrHNL+b3mM7zW
 6l1pnF5RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkjy/DfIeOZ6Lz4m6bHmPq
 DCk4EeJ/VefmEoYFLVK/MkVVda7KsfpJmltILzy570IEAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

If btmtk_usb_uhw_reg_read() gets a "short" read from a device, it will
accidentally treat that as a "real" read and populate the returned value
with some unknown and probably totally invalid data.

Fix this logic error up by calling usb_control_msg_recv() which
guarantees a "full" read happens, and then simplify the error checking
for when btmtk_usb_uhw_reg_read() is called.

Note, one caller of btmtk_usb_uhw_reg_read() does not check the return
value, but as we pre-initialize the return value as 0, an incorrect read
will not do anything wrong.

Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btmtk.c | 50 +++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 02a96342e964..6f060e4433db 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -804,30 +804,24 @@ static int btmtk_usb_uhw_reg_write(struct hci_dev *hdev, u32 reg, u32 val)
 static int btmtk_usb_uhw_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
 {
 	struct btmtk_data *data = hci_get_priv(hdev);
-	int pipe, err;
-	void *buf;
+	u8 buf[sizeof(u32)];
+	int err;
 
-	buf = kzalloc(4, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x01,
-			      0xDE,
-			      reg >> 16, reg & 0xffff,
-			      buf, 4, USB_CTRL_GET_TIMEOUT);
-	if (err < 0) {
+	*val = 0;
+	err = usb_control_msg_recv(data->udev, 0, 0x01,
+				   0xDE,
+				   reg >> 16, reg & 0xffff,
+				   buf, sizeof(buf), USB_CTRL_GET_TIMEOUT,
+				   GFP_KERNEL);
+	if (err) {
 		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
-		goto err_free_buf;
+		return err;
 	}
 
 	*val = get_unaligned_le32(buf);
 	bt_dev_dbg(hdev, "reg=%x, value=0x%08x", reg, *val);
 
-err_free_buf:
-	kfree(buf);
-
-	return err;
+	return 0;
 }
 
 static int btmtk_usb_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
@@ -877,7 +871,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 
 	if (dev_id == 0x7922) {
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		val |= 0x00002020;
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, val);
@@ -887,7 +881,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		val |= BIT(0);
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, val);
@@ -896,14 +890,14 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		msleep(100);
 	} else if (dev_id == 0x7925 || dev_id == 0x6639) {
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		val |= (1 << 5);
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		val &= 0xFFFF00FF;
 		val |= (1 << 13);
@@ -914,7 +908,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		val |= (1 << 0);
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
@@ -924,13 +918,13 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT1, 0x000000FF);
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT1, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		msleep(100);
 	} else {
@@ -940,7 +934,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_WDT_STATUS, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		/* Reset the bluetooth chip via USB interface. */
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, 1);
@@ -950,13 +944,13 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT1, 0x000000FF);
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT1, &val);
-		if (err < 0)
+		if (err)
 			return err;
 		/* MT7921 need to delay 20ms between toggle reset bit */
 		msleep(20);
@@ -964,7 +958,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
+		if (err)
 			return err;
 	}
 

-- 
2.55.0

