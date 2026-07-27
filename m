Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC141DE0F;
	Mon, 27 Jul 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167882; cv=none; b=sykmmCQu0vzoAVvE6Q3CtqOWxILqEdjezVCWm7B9rL75MLsSEXw+W2Zi1F9GIY7+VLxxzdMp00Clzat7JEvO+wuWQ2Ru+ae6jIcFVbTxg1H7Z9O7rpuCjoM60h0rRg72ud8T9QpWzNuIzekyxU4njNu469YopjOVba+wx9d6uNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167882; c=relaxed/simple;
	bh=pDUtJiZTQ+4/Vfe0oEjXwhbfECdLzuCVl2652OtoVtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUO1sJ+ssO0QM8/neczUF9i6gNESrtQGeZYyzGlLNZ+ami13mTdR35NcbS22RgatDpVenBxxF+j/W50aSJ7X5vhgicecLJiOEeKoCo48MLwtUIS2cnIUR9oR2llHx4ozeAblPKkudxH+QM6KQZ1br0A4lji9M++rUFUfD0nCIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i0lXoSmb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i0lXoSmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48ABA1F000E9;
	Mon, 27 Jul 2026 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785167880;
	bh=5J/lI+qKpb41LhO6P0bEinWE6eJQ7l4VbAa1CfSBN88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i0lXoSmbJaa4b23UJKZu4c648gyjtRjADW29TxW2G0oGcqH0LVfNP6+A+7lDryhoc
	 DJakAi8Pwn547CPJzaZxRZ0w9Rpn5nxcTxUbHuCZPAn2UKRhoVWvcGupJBG0BNtQOy
	 XL/uF6p595xXYOGdznuXrMT8NVUckAgk+L+IVOLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 17:57:34 +0200
Subject: [PATCH 3/3] Bluetooth: btusb: Fix short read errors in
 btusb_qca_send_vendor_req()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bt-ctrl-v1-3-2e8650e9df01@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2899;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=pDUtJiZTQ+4/Vfe0oEjXwhbfECdLzuCVl2652OtoVtc=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFnp9V+CNHLuqodG7WH5rCcmU2fzI1gqfE/632PO2u+n/
 Q3/Wf62I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZi1MMwP5GZ9eibzyK/RVie
 Gn+8vyLo7FvnRoYFGzpSzWe3OjjVCnvb/W2JbPWL/pgCAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

If btusb_qca_send_vendor_req() gets a "short" read from a device, it
will accidentally treat that as a "real" read and populate the returned
value with some unknown and probably totally invalid data.

Fix this logic error up by calling usb_control_msg_recv() which
guarantees a "full" read happens, and then simplify the error checking
for when btusb_qca_send_vendor_req() is called.

Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f7ed469cac6..184e95c1625e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3424,28 +3424,16 @@ static const char *qca_get_fw_subdirectory(const struct qca_version *ver)
 static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
 				     void *data, u16 size)
 {
-	int pipe, err;
-	u8 *buf;
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	int err;
 
 	/* Found some of USB hosts have IOT issues with ours so that we should
 	 * not wait until HCI layer is ready.
 	 */
-	pipe = usb_rcvctrlpipe(udev, 0);
-	err = usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN,
-			      0, 0, buf, size, USB_CTRL_GET_TIMEOUT);
-	if (err < 0) {
+	err = usb_control_msg_recv(udev, 0, request, USB_TYPE_VENDOR | USB_DIR_IN,
+				   0, 0, data, size, USB_CTRL_GET_TIMEOUT,
+				   GFP_KERNEL);
+	if (err)
 		dev_err(&udev->dev, "Failed to access otp area (%d)", err);
-		goto done;
-	}
-
-	memcpy(data, buf, size);
-
-done:
-	kfree(buf);
 
 	return err;
 }
@@ -3652,7 +3640,7 @@ static bool btusb_qca_need_patch(struct usb_device *udev)
 	struct qca_version ver;
 
 	if (btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ver,
-				      sizeof(ver)) < 0)
+				      sizeof(ver)))
 		return false;
 	/* only low ROM versions need patches */
 	return !(le32_to_cpu(ver.rom_version) & ~0xffffU);
@@ -3670,7 +3658,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 
 	err = btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ver,
 					sizeof(ver));
-	if (err < 0)
+	if (err)
 		return err;
 
 	ver_rom = le32_to_cpu(ver.rom_version);
@@ -3693,7 +3681,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 
 	err = btusb_qca_send_vendor_req(udev, QCA_CHECK_STATUS, &status,
 					sizeof(status));
-	if (err < 0)
+	if (err)
 		return err;
 
 	if (!(status & QCA_PATCH_UPDATED)) {
@@ -3704,7 +3692,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 
 	err = btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ver,
 					sizeof(ver));
-	if (err < 0)
+	if (err)
 		return err;
 
 	btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);

-- 
2.55.0

