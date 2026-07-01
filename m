Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274C49551A
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921985; cv=none; b=fDIr7VKJOA8QB/k3lZfIl4EkoVXt9wWrU/FvHsN4OmuDcQsnKGOB7PAeMB4FDWFQqgcDhCb0eQVFWhEZXw+eBxlH6upKiZ8mFcslhp9opaHbS7yPiu2UoS3xnwKcdYtUN88f2XjOxICQNNgmqQTH8gwrGVH3yk2SzdxMZjzUdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921985; c=relaxed/simple;
	bh=k9YU0uRFlXA0oidy33CuvTF7ZPRER5CGiH6JKlyKV8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NszVjbbTiDlrP1/yqk5/GsEY9VfoQkPYfJNXaDUk3kXQ3AB3cHL+mzwTp/FOr0yiag0vq6VMcWbBlFc0q+IDpl0jsmMbDu7hFc4NM4xIk8WT21fExFVD+f1RavLMQEs9S/y8PeqSuCvL7R0rKrWy72H0XNP2gO8K554lQ062+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJagG2CZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJagG2CZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso554843a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782921984; x=1783526784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgct0ZCS2MUNuZl9/eMGE3dNWMAQfIbPDyhKfsqkttQ=;
        b=NJagG2CZuvDUjXBcCs+yR8RmgW/xVU01ocAf2OUD+1e7omdZJuEPWnkUmVa6X23bxq
         rbOXYMQ9PCVnLou/s1VwwfbymbhB9SrBQqJ2rQcbqBGPNV4+PaDIsOnY7V8Oe9QCSyZm
         WCwYw6BJgzVy/h+ex5e+gQkK68cD2GUkYUaIBnt1UHhevClhZuk4hzpgcPTzWJjyMT14
         JSLkjMFlyf2pSzk7MUBQm3RnEqdvmma5luXX8My7TSMNwJYmy39QauA+Rl+dIC8WxjEt
         pF8LA8vQCeyABTr6AYz+RFpKv/0Nif+iONfOja8yE5zsIJB6ra42rfznah59O5mkVIhD
         9riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921984; x=1783526784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgct0ZCS2MUNuZl9/eMGE3dNWMAQfIbPDyhKfsqkttQ=;
        b=JiCeIv2bcE8l1n+aC7nIT62IcwKhCFnPJOjuVGA5eEE86360tYEDNZ1M2266x/2QD2
         WzENXFFDN/qmHuvsjqrWjrkdZ+Xa8hQDYTtNHYb2rDNGH48g0NvrlW/mH6+dtX9p1kWA
         rFhsicFk4vsEZoO3J68seW1FK++CQOqY6ZqB69qtYt6Fot8N89sJ7Umx7u8L8qEifFDa
         DsKO5EvLnJqtbhDFD4pty9uMgiFy5MRyKOBnrR7QQ4mVZZSSN52hXNfOfVcuI2pgtelr
         6Zs9FDMVmlQqaMEOxBl7OIRBOd9ueifCPlfLsgkRa4xPsWJNHFcqpTYGnjj+jKJaLy5G
         EklQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/pJw5vanMgvQDLt3QFA4I0YOpwwa9A8ahlP9YxioI2i45ACQELAID649yc2PKrle9HfGW/BGH16gYhSoaDpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnd6GfiVnd6D3IOYcGdSojRn5TYFZaLsnHk2aGp5k0HgLvjdDG
	R5CczXSO/hV4NuG90bHUVSG21/mlIqCTTFTrCrxiZvSsqLluuA06ThT5
X-Gm-Gg: AfdE7cntOd+h01700u9o+DJ2dfjP09ioJ98OyhXR6HuG4KTwgsS+pZrxZa02eOXzzu3
	t0p/tah4iUSRdR+a8RXvlLW0Y+Ry/yCm231iYKF8rhigARwbamX6QwqxjHZWR1wgeCNYyuCeHlE
	/fI0pKmw1NCnbQQuI8PRiwVIKWidkr7sBW3wd8SpkBSKHjY/aTWE3TB3z51xPWHAJTcvma2lLlQ
	K25oCfPqe9HN+QQXNuMExp+twi7lLvBhXvzVYtygYaTnHwFqXSvCEFZ6Q2OdZWndHI78h5sRVPk
	c35kPwihb8hSuabLGieDkZip8i8kaH4D6ieukp/AWk6EZe/hzMbPNYhmx3HK8AmEVdaAXa+t+07
	ADw4oHnDI2La0rQgCrQjTA4Cx+MvjGwrRcMmvwWZD4jiLPSA0fSUZcP1/nnVkyYpxD4FwKG3HsZ
	wlqyjpZx7X6zVT8FyazSn9y9BW0HWlCNOVC/S0Nkvitef7eoVl1OSa6Wcx7Q==
X-Received: by 2002:a17:90b:3c0e:b0:380:15fa:c5b2 with SMTP id 98e67ed59e1d1-380ba8d5584mr1379487a91.18.1782921983676;
        Wed, 01 Jul 2026 09:06:23 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ef2688b6esm12535397eec.30.2026.07.01.09.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:06:23 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v2] Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()
Date: Wed,  1 Jul 2026 09:06:14 -0700
Message-ID: <20260701160614.3160448-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpa10x_setup() sends the vendor command 0xfc0e and passes the response
to bt_dev_info() and hci_set_fw_info() as a "%s" string starting at
skb->data + 1, without checking the length:

	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
	hci_set_fw_info(hdev, "%s", skb->data + 1);

A device that returns a one-byte response (status only) leaves
skb->data + 1 past the end of the data, and the %s walk reads adjacent
slab memory until it meets a NUL. The same happens when the payload is
not NUL-terminated within skb->len. The out-of-bounds bytes end up in
the kernel log and the firmware-info debugfs file.

Print the revision string with a bounded "%.*s" limited to skb->len - 1
instead. This keeps the string readable for well-behaved devices while
never reading past the received data, and does not fail setup, so a
device returning a short or unterminated response keeps working.

Fixes: ddd68ec8f484 ("Bluetooth: bpa10x: Read revision information in setup stage")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2: use bounded "%.*s" instead of failing setup with -EILSEQ (Pauli)
 drivers/bluetooth/bpa10x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 2ae38a321c4b..e63d1af250ec 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -255,9 +255,13 @@ static int bpa10x_setup(struct hci_dev *hdev)
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
+	/* Bounded print: the device controls skb->len. */
+	if (skb->len > 1) {
+		int len = skb->len - 1;
 
-	hci_set_fw_info(hdev, "%s", skb->data + 1);
+		bt_dev_info(hdev, "%.*s", len, (char *)(skb->data + 1));
+		hci_set_fw_info(hdev, "%.*s", len, skb->data + 1);
+	}
 
 	kfree_skb(skb);
 	return 0;
-- 
2.43.0

