Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B262383C79;
	Mon, 30 Mar 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863714; cv=none; b=D7+XCJxRqvY6eKoEJqNmIONV/1Yy4LflF7e5LNiWvAyr0T448vD7vfE7GW6+YIYYTYLRpzUcQbZlY8cw9oHKwADv21NUpqqjBJyAn8TBJfw0q6D/qAkPQ/sm/eXmq9s1+qinfR6ytWHhCl60KJidL4aymJZ/p7HS5+Ha/tIrftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863714; c=relaxed/simple;
	bh=Y0DfqdZy9IyiB4EpS87Mu3xsHF8DMVc7705I9tT5oVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7LqSpKYoTiGPbdL/0Kufs/O+lGuduwDKq+JYLTOGRzO8Ib8zF6BtOV3ZbIGjRWeyXeJEYcoVEsYZ8qWUwbqHWBYTpmJ1cyym/b0/sczuuF4naPvX+vyVO9YGq1Z5lkNTA99HSpRKh80GLyGBH9sPq41SihA4kfv9u+1GHguGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi9SbXU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi9SbXU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17F1C4AF09;
	Mon, 30 Mar 2026 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863713;
	bh=Y0DfqdZy9IyiB4EpS87Mu3xsHF8DMVc7705I9tT5oVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qi9SbXU9EjKOCPAOgLhJdmSqc2g8PNVxJ3PlSJF4rhYjVHW3hZqdhxC81t9Pi7m+s
	 fZH1cb8nLi8nYr2lLI2PR1ZyW5w5+MKN0rOzHeF7SydjUftsrhsUMORyzpr4gs8Rlm
	 IJ1kG9lVyQNPMZ1XHSXqgWAml9H2qh3cBz8uvGlEfS5Fzruhb7RHyuPJ1YGXa+Kl2I
	 tNkhmqlL4+BFrrGqeusGxHCJLWC/EyoEnjBs/es9U2Rs/MOniqRv8B4qn95UKMkwlf
	 YqpeGDQyrg+VGShKJV9ZqNT1/8RKeMTmQvsQsVn3M7ZW9iA3xerSlhiYJSc2xRs/bd
	 aG/ORvBJTSsJw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7983-00000006oAN-37qT;
	Mon, 30 Mar 2026 11:41:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] Bluetooth: btusb: refactor endpoint lookup
Date: Mon, 30 Mar 2026 11:41:33 +0200
Message-ID: <20260330094134.1622788-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330094134.1622788-1-johan@kernel.org>
References: <20260330094134.1622788-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 51 ++++++---------------------------------
 1 file changed, 8 insertions(+), 43 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c5344ce16c1..c4aee8e761b6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3674,31 +3674,14 @@ static inline int __set_diag_interface(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct usb_interface *intf = data->diag;
-	int i;
+	int ret;
 
 	if (!data->diag)
 		return -ENODEV;
 
-	data->diag_tx_ep = NULL;
-	data->diag_rx_ep = NULL;
-
-	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
-		struct usb_endpoint_descriptor *ep_desc;
-
-		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
-
-		if (!data->diag_tx_ep && usb_endpoint_is_bulk_out(ep_desc)) {
-			data->diag_tx_ep = ep_desc;
-			continue;
-		}
-
-		if (!data->diag_rx_ep && usb_endpoint_is_bulk_in(ep_desc)) {
-			data->diag_rx_ep = ep_desc;
-			continue;
-		}
-	}
-
-	if (!data->diag_tx_ep || !data->diag_rx_ep) {
+	ret = usb_find_common_endpoints(intf->cur_altsetting, &data->diag_rx_ep,
+					&data->diag_tx_ep, NULL, NULL);
+	if (ret) {
 		bt_dev_err(hdev, "invalid diagnostic descriptors");
 		return -ENODEV;
 	}
@@ -4024,12 +4007,11 @@ static struct hci_drv btusb_hci_drv = {
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
-	struct usb_endpoint_descriptor *ep_desc;
 	struct gpio_desc *reset_gpio;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
-	int i, err, priv_size;
+	int err, priv_size;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -4066,26 +4048,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!data)
 		return -ENOMEM;
 
-	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
-		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
-
-		if (!data->intr_ep && usb_endpoint_is_int_in(ep_desc)) {
-			data->intr_ep = ep_desc;
-			continue;
-		}
-
-		if (!data->bulk_tx_ep && usb_endpoint_is_bulk_out(ep_desc)) {
-			data->bulk_tx_ep = ep_desc;
-			continue;
-		}
-
-		if (!data->bulk_rx_ep && usb_endpoint_is_bulk_in(ep_desc)) {
-			data->bulk_rx_ep = ep_desc;
-			continue;
-		}
-	}
-
-	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
+	err = usb_find_common_endpoints(intf->cur_altsetting, &data->bulk_rx_ep,
+					&data->bulk_tx_ep, &data->intr_ep, NULL);
+	if (err) {
 		kfree(data);
 		return -ENODEV;
 	}
-- 
2.52.0

