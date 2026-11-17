Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941871;
	b=U+clE1wLyDsJy3MI80qUBanjw2Omq5QeXgOxOOHiDvLxbRixDdwc30pMkAicZJTH5ZoB
	 afhDe0YVS8DvCB0ulF51R4IZkOVjOKS9wLkmCy5eXAsiActV9W/CaLripFiVb0EVv6dLF
	 1PSHGWcw5fkakMOUp353THgeeP1Vo0RwIQuaCWlBgBJTDb+s8cnHT6/070On9i1fi8Cex
	 D6JP2t9o6tcQ1S1JSGTBX9OOyUPGECtm5V4LcrMv30DvKywGVPMvLa28BWaCnkb+SrFA+
	 E/LvWVRF94mdeDmEkEfMvH+cnxnI+bHE8msX7RpjdlwDIhfP8WQjK/E8EM0mEfpMlJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
	b=pmRGOf6On7C+5W8ijlsH+Zy74zHuvEkOyBYRO8XsQ6R2YiX8oHvkpXVLsBmD64N3v8JO
	 DL8Od2WllT+hf4OWmKRvVyhfTHP89/4dZ0T0xcCKv/y2EnUv5l9BUTFEe2PEgcHdV6DDI
	 NYESPKvJRdPIrZrnlXRzsqIyGxgEf8zkG0Qv4z7j/E8aBNTubgH34BjHMXZIGHdijElVb
	 FQtbt6xz/2GkXFkayUFXFbcd60Z8qKwL4TF72R1/OaUeIBYEl6ciKRcvmjHeg/pGwSC1q
	 pb4X1JQcXckobpUXCvmGo+a7pDKl0KjrNdxBT9pdIlwhBfsI+QFwoKpeSsHJkWfu7rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ArlXbe7M;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF9606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCF9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ArlXbe7M
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-99e1babd683so73311241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941870; x=1795546670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=ArlXbe7M2vrpirThsuyArKAF6R/xhD5dhuE08FknVrIKCdVuBHYTMSYZO8X9idcl2g
         mAXfGwMvEqlFSvL1TXt5l4H0lGIWLLezQBOsifEsvwIrIhYGHDuaBAI2yFofvudhJsh5
         SRi1ji9CnUaL4ZZE0Z15KA83ND+k3aTVbMEGeAWZLGzYxz7xXlBQw1dB0JlqLq7Drqg+
         lsCjewny4yKFH5Wt03dYt/ohoqJ1mHJNjgOeRpS/DRJSF7JeuydpTGS+QukbQb0RcvMl
         pNqptB/XBJOgOl6g7vXkW4flaXkH5gCEP1ssulQ0Od/cKAbO+0KgY8KURYG2R+/+ai0B
         1iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941870; x=1795546670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=eR3WRNM4P6Ij0nIOryzAp8iHSlAgj8joIJ2HYjMgF4USLnVO7CsaFLaBY8z/mdqX4Z
         2tkk/bg0i9Uh9VRrDAXi+IQRw9kUqgHFInXqucNk9Mf41XnCeSZYcNuETJmlSI4hboXr
         2/yR+OkoUhlQHHW/CAc2i6c1uyMIQLd1fIuqq9SaNYCjzR11jPuiaJEgFCTYS7A8cMqH
         5jSIEUnXW4bPMtzeOPih4Grm1gQXEz4/PNA5xI723BKN+UVwlLm+qxXnhYOK4IVSCslQ
         uB1A5mVFVYknR/Ifa3dDdYWitTL4z0/oxMG1fU/ci5+9ab98pHvexPw4U5na/HWJqE9Y
         jLPw==
X-Gm-Message-State: APuU4Z+A4Tw/yCZaOBi7fMgy7f40YMDFsT+Qy0u1I/X4ezAbITbQfO1z
	iKs9lDoM14WaU7Q+4BqMWwZOPRfDRLMrW7ywfKDkIkbqZvKxGVve/18BhqQJuA==
X-Gm-Gg: AYBFou0zrsy46jzzBPyG94wg9nN0bEtsf0iKh76+pnSKDJ5h2wpoKH3cZgE4j53D0mR
	ppVFKE+NwT6itIbWSBlD5t3VsNhLobS5noM9KxcyR9EQv39cxQi/Y1TwV2qogvVkuFISJFGYh+w
	VcBCjwI1MZF271Yk6jojeTyG4960jZ1gO/NJVZI9ToKf6ZwNRE9ybdUJY16dHPANkeRs/XigGQm
	33+S+UBA0y8FtFMv+G7+0+VspcpSblq+iN3eelbWzXue9Z9N3qVbQXldEQOGrSLn1Vx7J4yp8ht
	LyC2xraTf8LI9DewQO4SOTssJsxgadFFUDI3g2Hh4kRq8BPTS4X4aMDACLJujJVaf8VXollVxdJ
	B0Xp/QHJmrUYiatTJMG6TZja3ZWvJ/CFrndpnsb12+QFfqbjatHEon+zqtjvTtizqhxz+AFzLyj
	zV+l508i63hvVxb7sQhUSAORaCG0U0sGfVi9nKs8rfb3+l167wjExSDbze2H5+pGUMWFSL6a0d4
	UbADSsNttsCHge96YJDraXSppZfSJni2YKCAPgh1sOEGmL4ZSsVO2AmuoHaDkrYhOeM0VfYDjHG
	gWcuz4z1GzM6jMy8I8Y+dMmYSNawPyrvY1J9bxTQANTXgKBgVE8mZXcHUkYNSeznnipX9J0eRaR
	8DofbtvmLIXmNc9mYF10YEk8GvwMR6Bv/a1I60xExiqKWbous67pyCwVpSnN9jnOZLHiyf1Fe3o
	yxpnc=
X-Received: by 2002:a05:6102:604f:b0:7c3:7286:c291 with SMTP id ada2fe7eead31-7d64d7a95d0mr4779625137.19.1794941870413;
        Tue, 17 Nov 2026 10:57:50 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 13/16] Bluetooth: MSFT: Protect the event prefix with hdev->lock
Date: Tue, 17 Nov 2026 13:57:34 -0500
Message-ID: <20261117185737.3758255-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

msft_vendor_evt() read msft->evt_prefix_len and compared evt_prefix before
taking hdev->lock, while msft_do_open() (and the supported features
reply) free and reallocate the prefix without it, so an event received
while the controller is being opened could access freed memory. Take
hdev->lock for the whole event processing and while updating the prefix.

Reported-by: sashiko.dev (linux-246df501-f32c-46fd-8779-7fa755ed7f9d)
Fixes: 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/msft.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 2559c5b1bef0..ab63fee3ef59 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -170,11 +170,16 @@ static bool read_supported_features(struct hci_dev *hdev,
 		goto failed;
 	}
 
+	/* The event prefix is used by msft_vendor_evt() with hdev->lock held */
+	hci_dev_lock(hdev);
+
 	if (rp->evt_prefix_len > 0) {
 		msft->evt_prefix = kmemdup(rp->evt_prefix, rp->evt_prefix_len,
 					   GFP_KERNEL);
-		if (!msft->evt_prefix)
+		if (!msft->evt_prefix) {
+			hci_dev_unlock(hdev);
 			goto failed;
+		}
 	}
 
 	msft->evt_prefix_len = rp->evt_prefix_len;
@@ -183,6 +188,8 @@ static bool read_supported_features(struct hci_dev *hdev,
 	if (msft->features & MSFT_FEATURE_MASK_CURVE_VALIDITY)
 		hdev->msft_curve_validity = true;
 
+	hci_dev_unlock(hdev);
+
 	kfree_skb(skb);
 	return true;
 
@@ -648,10 +655,12 @@ void msft_do_open(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "Initialize MSFT extension");
 
 	/* Reset existing MSFT data before re-reading */
+	hci_dev_lock(hdev);
 	kfree(msft->evt_prefix);
 	msft->evt_prefix = NULL;
 	msft->evt_prefix_len = 0;
 	msft->features = 0;
+	hci_dev_unlock(hdev);
 
 	if (!read_supported_features(hdev, msft)) {
 		hci_dev_lock(hdev);
@@ -1078,12 +1087,15 @@ static void msft_monitor_device_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 {
-	struct msft_data *msft = hdev->msft_data;
+	struct msft_data *msft;
 	u8 *evt_prefix;
 	u8 *evt;
 
+	hci_dev_lock(hdev);
+
+	msft = hdev->msft_data;
 	if (!msft)
-		return;
+		goto unlock;
 
 	/* When the extension has defined an event prefix, check that it
 	 * matches, and otherwise just return.
@@ -1091,23 +1103,21 @@ void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 	if (msft->evt_prefix_len > 0) {
 		evt_prefix = msft_skb_pull(hdev, skb, 0, msft->evt_prefix_len);
 		if (!evt_prefix)
-			return;
+			goto unlock;
 
 		if (memcmp(evt_prefix, msft->evt_prefix, msft->evt_prefix_len))
-			return;
+			goto unlock;
 	}
 
 	/* Every event starts at least with an event code and the rest of
 	 * the data is variable and depends on the event code.
 	 */
 	if (skb->len < 1)
-		return;
+		goto unlock;
 
 	evt = msft_skb_pull(hdev, skb, 0, sizeof(*evt));
 	if (!evt)
-		return;
-
-	hci_dev_lock(hdev);
+		goto unlock;
 
 	switch (*evt) {
 	case MSFT_EV_LE_MONITOR_DEVICE:
@@ -1121,6 +1131,7 @@ void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 		break;
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.56.0

