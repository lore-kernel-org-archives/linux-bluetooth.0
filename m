Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307533;
	b=mleeb/6wOwKdW1bFdudc3Y0/b5KEC+rG+fosPK/ikz1xMxslO5YRwT+dashL8Y6eoJn7
	 NoDrlQLonLaocP9tXQAxs/swzq7BnSp3JcoUtpEaIjDcCnLlnJibdggL1JacUn0y7Z3md
	 nxJTvgkCZB4wSJ2gnVVzzAIkPwk/BiLId6Fr2cfEl269BurALtMQALA0jrcZTYd+QZKmq
	 wG6LRFcj6/0aHwlZXNLdnoFeEA3deh71tHMWLWO8xg3gvh30Wy72teA9OlldUcdzZipH6
	 k2CsX7+sF70Fy1gTyKW9DTstlaLGVPCW2rIfte0+3Meays8b+WcvO0ApgdOpndPklCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307533;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=HrMlYBbbynqgvCHdPKNrs5C5AuqUGckRtZfKo3QYVjs=;
	b=KUPqr9xqQhnWplqIdnV1RCaBvBI/Gy+Wfz2PcjHRzUBl3gm1AbFGw4mmPJQFUejOP96s
	 mzXL7noa77W48xnjT6D4x83NBq6fy4BjzIr82daTa8Rps/EgLdnXDsbr1+l8gk7sxGNc0
	 JQBCgrYErQ4iPNxhwgGvKB4LE4RPj5GMQdwpbqACm7WDlkPuLXTNCPho4T8PcoosAK/p4
	 b5LW+fMIlcZ20pAVKCA+mCWm9gc7yDtMDPEhzeN4I2ygjBA6imffJIBbxBFhVuWMiowA7
	 RCZKlllDvfBe4atEs/yUM9HKZ71wTfgtm6ZoxRCCFvKt9YMj06E9jSVNd4bmS9iOT+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mU+O2oa1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A904606A32E;
	Tue, 10 Nov 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mU+O2oa1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7F01F0089F;
	Tue, 10 Nov 2026 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307533;
	bh=HrMlYBbbynqgvCHdPKNrs5C5AuqUGckRtZfKo3QYVjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mU+O2oa1hLjZSNShZ/C8LwS+hAvd+C2RUJrmlY8lxFGr1naUCq5ZJkpxmxcMfLHAx
	 LoAQz2QxaDz7veqtcar4GQ/sqYw5IIwUhmw8LJjOsFyqnGlRb6zOcElNyCTYvGNO+0
	 BWqzQiU6d8h0upCAihxShXH9jtn5IDxW+fPiEtYRbcupLJDWieri3NcfmZnnHtEu50
	 qO1Vb/9Cl7XRpY22HQ7fNtn5Snu7xaSQrEXLgU5Sb94izPqypNdXePStjfdqVjsPs0
	 eqrxa3/ImLxFrs9VGi5rijVhDJXzRtX+XxYE+wTLkhof4EWFv0JpEyVWXgYV4e0EGb
	 ApUtnctKe8MfA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 11:45:27 +0100
Subject: [PATCH 2/2] Bluetooth: hci_bcm: Prefer a valid platform BD address
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-brcm-bcmbt-mac-v1-2-c68003a06f64@kernel.org>
References: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
In-Reply-To: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

Samsung phones with BCM4334B0 store the assigned Bluetooth address in
persistent EFS storage. The bootloader can supply that address through
local-bd-address even when the controller reports a non-default address.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index e70b9f3fd968..1f62a8c2fb38 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -584,6 +584,7 @@ static int bcm_setup(struct hci_uart *hu)
 	bool fw_load_done = false;
 	bool use_autobaud_mode = (bcm->dev ? bcm->dev->use_autobaud_mode : 0);
 	unsigned int speed;
+	bdaddr_t bdaddr;
 	int err;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
@@ -595,6 +596,13 @@ static int bcm_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
+	/* Prefer a valid platform address, even if the controller has one. */
+	if (!device_property_read_u8_array(hu->hdev->dev.parent,
+					   "local-bd-address", bdaddr.b,
+					   sizeof(bdaddr.b)) &&
+	    bacmp(&bdaddr, BDADDR_ANY))
+		hci_set_quirk(hu->hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+
 	if (!fw_load_done)
 		return 0;
 

-- 
2.56.0

