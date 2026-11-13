Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608434;
	b=m32qiSKa9J+WRouQ0kFhbKctjJuIFLQXNvqlRebA0/tT6rC7H5x3aYVch9waS9/yFUlm
	 RIxxUSZec1iFKHW5nDNpm7HcvV2GCobQtT96J2LQ212a+owwROAj1jU4j9A0JHBawRF8K
	 TaOsfQOfvu7bMKj9OuG83EOe/98X6BbAShQss5RXd1wzOc4PjyX1pvtsERRTllxC/2cEE
	 Px51ZECQDyjILCmuHOjOTinXM3YiGArdfvtL7PNBVs7876vjdCmc7RRfcB5rqE33Okiy0
	 WrwMc5rSj08kJZadO2yVEJ/PhI8Dbo3I/wliW2hKwi0RR9NGrEh7SG0Ao9Uxmof91LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608434;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PHBShBfXhNBaJWujZSQWjunFT7rAYje//FUsVRKdOAI=;
	b=uLQLWfaHasGYqlOwd29iLj2VfOvp12yH5OYVa0/Z++EsJkMxj3dAK/L1pUyq9JoOfPdz
	 uqTLtWENAyctrcfw0oJ8mkzsxDkrJsRwk+lLtjpmpnefR/e0Wns9VzHJmnqg62I/2nnhX
	 TPSypqKpKVKBHSrLudjo/K5+4W+FWwtFFTktNMDdcjXwDeXewdSzDUqb8w34xu2gIeF+s
	 IkGtxVi+H1YgvzT7a2Yhg2/8/zCXDPl0c59iEGBR9GaMF7dgZk6a2lO5Aa6rx5X2UO/2R
	 dzHLDhARlATbk51EayQ1u9eSok51e9jg/vAZIoTE0CPQWAm7svPY07NbHgLVYOlaWMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=DkSluW8A;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D509606A329;
	Fri, 13 Nov 2026 22:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D509606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=DkSluW8A
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1794608427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PHBShBfXhNBaJWujZSQWjunFT7rAYje//FUsVRKdOAI=;
	b=DkSluW8Aq6Db6sY9UUKvBlx+8DRyl5SF/bKMBw31X83q+0H9Q/6zWQmtwvztJWSyRZ8sT0
	sO7G7jZYERM5Hy19wIoZ7NhXC5kJ5B8VBpOu70Rerk0OLXTZuvN+JA4ZgUjLiaJgRvDfeS
	ci+Ir374oUFj03DnAyEzkk5lQaO+b5WmghJXXf58ckrqW31R7Fo3KeypT6CKuE/87KkOqB
	xwPdycSvuC7fdLB/pbNr1dNUH/O92g/bNbUjrqoJuAyEtvEGGwsAaq9PCWQ5Mt2V2lyPHi
	+mS92KdouGtZkdASFpjDIt3zKE2zpmUAH+Ghu72btekxK5D5oN+o1JMQTu+6LA==
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Don't log unsupported debug features as an error
Date: Fri, 13 Nov 2026 14:20:24 -0800
Message-ID: <20261113222024.1123279-1-hex@freenixos.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit af395330abed ("Bluetooth: btintel: Add Intel devcoredump
support"), setup sends Read Supported Features (0xfca6) to decide
whether to register devcoredump. Older controllers such as the 8260
and 8265 reject it with Command Disallowed, so every probe logs:

  Bluetooth: hci0: Reading supported features failed (-16)
  Bluetooth: hci0: Error reading debug features

This is harmless: it happens after the firmware is loaded and only
means devcoredump is not registered.

Log the failure at debug level there, and keep the error in
btintel_set_quality_report(), where the user asked for the feature.

Tested on an 8265 (8087:0a2b): the messages are gone and Bluetooth
works as before.

AI was used to help write and test this patch.

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219387
Signed-off-by: Hex Lindqvist <hex@freenixos.com>
---
 drivers/bluetooth/btintel.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a0aa110f4cdd..31dec65d3327 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1532,11 +1532,8 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 	 */
 	skb = __hci_cmd_sync(hdev, 0xfca6, sizeof(page_no), &page_no,
 			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading supported features failed (%ld)",
-			   PTR_ERR(skb));
+	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-	}
 
 	if (skb->len != (sizeof(features->page1) + 3)) {
 		bt_dev_err(hdev, "Supported features event size mismatch");
@@ -1653,8 +1650,10 @@ int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 	 * supported, need to load the additional DDC config to enable.
 	 */
 	err = btintel_read_debug_features(hdev, &features);
-	if (err)
+	if (err) {
+		bt_dev_err(hdev, "Reading supported features failed (%d)", err);
 		return err;
+	}
 
 	/* Set or reset the debug features. */
 	if (enable)
@@ -1705,7 +1704,7 @@ static int btintel_register_devcoredump_support(struct hci_dev *hdev)
 
 	err = btintel_read_debug_features(hdev, &features);
 	if (err) {
-		bt_dev_info(hdev, "Error reading debug features");
+		bt_dev_dbg(hdev, "Reading supported features failed (%d)", err);
 		return err;
 	}
 

base-commit: da3cc02587c629420603df4395179ec82955c941
-- 
2.56.0

