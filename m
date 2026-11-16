Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846395;
	b=m49UYPpYN9hVs9sdND/BDXsMitsEVZ6fxg7fg5kiX/xPieNIXvBKFrLm61QWCSUp7N5I
	 8i3whWpgjHpPUpip5tm7bHCK/z3gqV4r/QsJ/u3gjx0C9PzFCdBV9Q1fmsr8cmY+wUXkb
	 JZNAnjDb4k0UTCc1HBdF+N6x0CIg2cquYSRL08Abnxe11+iEQYhF2KHbe7k4GFcukz/EO
	 Aa0Qz6wZ7CEGTrpdSaBelmFpUDc0ENSB9PModOENwKDvpNVH0/T69liOMqFl0z8cVoXUt
	 /4huPLhSemB/r8piaCrj1CrFV4EG6nhuddfyRuw+avEx5i8QxiQd7Drf731b+dxB0EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846395;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vMf+Yb0CsLok2gkRTe5LcYjNsttCLqgkVtGLQgQa3n8=;
	b=wW/Nz89c9lrlwFcACxCNyExptEllff8rKFNr4ecX3ZgrFrtUrAzoEsFRHPzHRDtq7AfV
	 2l96C6be7A/XKGuiNkzB6Bv9IBy4s78x1bEm8eyKs/s4uR8+LmLZOf0+iOHRicgifWVVK
	 nK7Yv5Tcsi320Fd0gVS5zGdt8zXc9zsPeisprMBYlW7ZUMVJkkB+3TTtnGjKzshHma/+a
	 F43z0IEFyIyColNKN9D4RgCKFiMsfC89fv4yTyIm/5HHFZ2XG4dBAnsxpucvkES01fRSB
	 eErFFrzwHVTMWUovz6aOA/xjAbhxlPzdz5SMRVcPB8MZrgs6jsyzMtd35r4qzXRr5rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=Adnreco9;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C2606A329
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 16:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55C2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=Adnreco9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794846392; x=1795105592;
	bh=vMf+Yb0CsLok2gkRTe5LcYjNsttCLqgkVtGLQgQa3n8=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Adnreco9kgzlamRHjFAAu2NOLhNARO1duSFqjommQESa1VqFeW8uYbNNFrMVoNJnH
	 QNkSywu/7ZaIfUxTAiLTv3hizKIMd2suHIVz4gBPQHfpTC5wBn6TBUl0osRWGVsyXx
	 zBQSgrCJ3uBw7GHqnPRboFGiLq9t9ROqy9kWzPpn0QIKkSLcffalEA1OM2Wesn9ziP
	 41tKzpZ26LhW02W1M7M1Hqy0IdGlO9peqtiurMNnUwdWlUJlVxgB+ngoUwkbpGyFRL
	 tr1zelDi7KFljps3Tf8jnzbbBAPGExTPdqb0JNrrKDM7Jgv0imY+UkvvdbXgEdaZje
	 eiM8SDKAr/hBw==
X-Pm-Submission-Id: 4jStXk53pVz1DF5P
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com, enderaoelyther@gmail.com
Date: Mon, 16 Nov 2026 16:26:21 +0000
Subject: [PATCH v3 1/5] Bluetooth: hci_serdev: Unregister HCI before freeing
 the TX buffer
Message-ID: <179484638195.54009.16928291772826938293.wcn3950-poweroff-v3-1@michaelmcallister.org>
In-Reply-To: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Unregister frees hu->tx_skb before hci_unregister_dev() waits for an
in-flight HCI close or reset. That path can still flush the same frame,
causing a use-after-free or double free.

Unregister HCI first, before clearing protocol readiness and cancelling
write_work. Skip the HCI flush and close callbacks during unregister;
the transport teardown frees the frame and closes the protocol and port
once setup and HCI close have finished.

Fixes: 21139b3ac62a ("Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_serdev.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index d2c48df34..e0e969228 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -97,6 +97,9 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p serdev %p", hdev, hu->serdev);
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
@@ -144,6 +147,9 @@ static int hci_uart_close(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p", hdev);
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		return 0;
 
@@ -402,6 +408,10 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	/* Wait for init_ready to finish to prevent registration races */
 	cancel_work_sync(&hu->init_ready);
 
+	/* Drain HCI setup before clearing protocol readiness. */
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+		hci_unregister_dev(hdev);
+
 	proto_ready = test_bit(HCI_UART_PROTO_READY, &hu->flags);
 	if (proto_ready) {
 		/* Clear HCI_UART_PROTO_READY under the write lock so a
@@ -423,17 +433,14 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	cancel_work_sync(&hu->write_work);
 
 	/* Free any partially transmitted frame left over by write_work now
-	 * that the transmit path is fully quiesced. hci_uart_close() would
-	 * skip hci_uart_flush() because HCI_UART_PROTO_READY is cleared.
+	 * that the transmit path is fully quiesced. The HCI close and flush
+	 * callbacks leave transport teardown to us during unregister.
 	 */
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb);
 		hu->tx_skb = NULL;
 	}
 
-	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-		hci_unregister_dev(hdev);
-
 	/* Close the protocol before freeing hdev (intrinsically purges queues).
 	 * Some protocol close handlers (e.g. qca_close) may still access the
 	 * serdev device, so keep the serdev port open until this completes.
-- 
2.39.5

