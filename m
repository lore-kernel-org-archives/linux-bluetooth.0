Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13B372B2C;
	Mon, 30 Mar 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863714; cv=none; b=aS8YlPn5XmAUCeopZrdtnSXjVpeEaNyUmAGg95E4QGbSV+CVCKib35FIx8Z3UECz3dqvsA1BTwAQfyN1p1YCnn5BbFADa0ewTgIfptLxaQabO/fvIUrp8lcE3cDm2w1dskQPon/1M39IMVfq/WqlvNYsDwLY05V6EWMC3mwugE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863714; c=relaxed/simple;
	bh=+mg7k89wr5gXl+f+rGLkpurQUyy9pTfq58JAgHgEgPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu+oXHr1ynoquhGE8ceas4X5LaIZ1ZID2Eh2NLRjuAznM2q8L2hTYykfQYPuWRBc1cWP+slAU6lajrcx8Vx8PMk60x5hFtHbaViipTtgi+DbCepdJIdWpQvWgkI034JGYaNIP7TrEW6ywRgamYLO5iEwTVQuTveTOav3FhyzYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4KHP57t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4KHP57t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16CFC4CEF7;
	Mon, 30 Mar 2026 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863713;
	bh=+mg7k89wr5gXl+f+rGLkpurQUyy9pTfq58JAgHgEgPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4KHP57tOUq6RHif9Jdjb0/V9Lvzzt9Cja4xrCJuRvNMKU4ehQ7joyO+QYbUQu61Q
	 bbA1OpkrvMH9/vo0xBXrmv3GOhda2bmROn0fbtBFQ3GsuTomfd8RNyM8mmRStkBrKM
	 chsRi+Z6Hdsj2i2jeXfcInzEHguIouvM+ALx1EDFKd7T60SWU2vuOoon3QZK9nDj62
	 hZwLFDqucq6qWRp70Td8xtD6pqd3EH1DdF1PeznHJeactJrKdZ7MQ2W3ZL11gxSi46
	 EGdYnDNDpnDUfXn3iDDLsS6bPOyKxfzkMaU9SYmEeWcXi9dciCTmVvvTayv5nkEme/
	 EmMuL86+6i4Lg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7983-00000006oAP-3A7Z;
	Mon, 30 Mar 2026 11:41:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] Bluetooth: btmtk: refactor endpoint lookup
Date: Mon, 30 Mar 2026 11:41:34 +0200
Message-ID: <20260330094134.1622788-3-johan@kernel.org>
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
 drivers/bluetooth/btmtk.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index fa7533578f85..ccea160da7ac 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -983,7 +983,7 @@ static int __set_mtk_intr_interface(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 	struct usb_interface *intf = btmtk_data->isopkt_intf;
-	int i, err;
+	int err;
 
 	if (!btmtk_data->isopkt_intf)
 		return -ENODEV;
@@ -994,29 +994,10 @@ static int __set_mtk_intr_interface(struct hci_dev *hdev)
 		return err;
 	}
 
-	btmtk_data->isopkt_tx_ep = NULL;
-	btmtk_data->isopkt_rx_ep = NULL;
-
-	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
-		struct usb_endpoint_descriptor *ep_desc;
-
-		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
-
-		if (!btmtk_data->isopkt_tx_ep &&
-		    usb_endpoint_is_int_out(ep_desc)) {
-			btmtk_data->isopkt_tx_ep = ep_desc;
-			continue;
-		}
-
-		if (!btmtk_data->isopkt_rx_ep &&
-		    usb_endpoint_is_int_in(ep_desc)) {
-			btmtk_data->isopkt_rx_ep = ep_desc;
-			continue;
-		}
-	}
-
-	if (!btmtk_data->isopkt_tx_ep ||
-	    !btmtk_data->isopkt_rx_ep) {
+	err = usb_find_common_endpoints(intf->cur_altsetting, NULL, NULL,
+					&btmtk_data->isopkt_rx_ep,
+					&btmtk_data->isopkt_tx_ep);
+	if (err) {
 		bt_dev_err(hdev, "invalid interrupt descriptors");
 		return -ENODEV;
 	}
-- 
2.52.0

