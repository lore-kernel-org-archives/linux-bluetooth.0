Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946847;
	b=onxIvzjICPmKs7erO/ti0UMkfVe8h3NF6i+ZQi7iOXGQ+PqcEyjdcZWPRHWYj1vztv8g
	 XzCQZyKb8soxZT2It/B4FOgiL0wcLeB5Yxbsh5uSV7tWD6+1jcgSQf7xF2JEVBi6U94Zm
	 gEh7MGSKdlKLry8ow6fmHnDjs6+cmihHWiQry7XPfiJTkV1QHus74BgwIfG+gy1lHzkCY
	 xAchYZi+ENQj2KJBwZdBVvIroFqu4/rddbwc4OJsC8THeTVqscnWpEsnouCiw10qFwLtf
	 M9lA4P7xy7VrU9G9I4CamxwQA5bPNIBV6n0lgTwvb+8xhlCEpRsLuAl74ocs8dkpHsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
	b=vd4yHiBkef3u8s+VomzNnjcj7XynFkCRrigpNPyUF2DtM8mUOMNZur3S3n7D84mKNX+z
	 WgWYOjC/p6DIm3hWZmFWEksEZhcifoHHiKN0xCdUD3pKcR+wAX3Yzi8nCLj9u1SVSOH5h
	 ioI77qex3OfowLRB24MtCaT0CJagwVZJXqsMx8mM/vN+q/JFMt9as9th8sibLsu3Zqtni
	 6Pe3URISKMRF5cgM6bdKox3Hm2fV5KjdSurP8GpSN+pusSTA1aawlglNZZlTOXlmw0Enr
	 v8CXp5wV526w/dztDaJvkx4VODUvBV2qQ/w7+ca+OJZrL+5rK3ZRSo4TCUZEfhtyn2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAfB4ugG;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4681606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4681606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAfB4ugG
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc013095d4so79839137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946846; x=1795551646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=lAfB4ugGJrNknf5aPzCvTo+T870ZFXtWSA8i1cPqS/fJM1rghkOZjeKk+4k6G/atrg
         tmHHojhwJfTRwgfDk1ZttJTaH68bQUyfPzq5k6WKXePaqn1VJGouTUXKERFD0+XMbm+6
         3l6SntZn9Mft32N9FMVt7IBm7zVY2rFfdA8S1yL7zmdY8xitHL2PLYwLBWK0mYb66DjU
         bBRPNAXjP6+4PH1Ga1SkY5Yca8E8VCavWmILhwAKXqF7FYHXCu99tkBdYLrX1VO3WyDr
         bVJ+R3uKxbCGRKq5PFx/wwhf3AOjhxdSIsBIz0KZn/kQDb3QHWT/CVgXvtOyoqkzb8dO
         6+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946846; x=1795551646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=PnC07CTSjlanwMg/ythI65GaH+ABzXKeZpnQoR3M/Wz7oyFLsufcC0o6XBU85Scbge
         jGhUxof0t+QMaZhGL4idGQ7GC491qK8ZFjrLQfCr3D4e6pc7WP8ICxHv7en9IW42vHgo
         XnW4XwoEmqlekJmvUoReX1W83jK72UbXirUrSjxwI6Rqz8HyBJe8pm73ASqYIt/Sxomr
         Xmvj7eqhTxNUEJJaUI+buqk1BvVAO1NHKWXtYzkgyUN4DCg16JXkzla6fOhPjhh/634o
         NGaS0vkTwGsUO79+SbfGHDG2oLQ8ES8yKQhcLncGK/V/nCeKs7eCFxPs/cWMD3Bjw1te
         YKCw==
X-Gm-Message-State: APuU4Z9fn0qJOqFgH+xrTavDqrvlnkKH+D4ghVqnaS7glSBn28D6OzIx
	QfsvzZJCrHqu3NyzlTdAc01pAaTJmlXavkED3XTyZiIkv2TNdEFdD6juQd6K+g==
X-Gm-Gg: AYBFou3wqVTEsWK7tuL1VOYVMjSMjVvIiEpJ8cNWGGmRy9GsTSoHQ+3C+DGoBqcIhwa
	bUdC1oI19ZLNRQVFFYHtuliCaMD7NTS1tCP+nk3UuluBQwvXJLa8rnPt6mvpWvEz0x0fNNFdszz
	PvjzPymUKAbNWKLgmhHbvUDa/YzXVgKeCMMucUrqYBDqwXgfvkuUkJWx/4C3PLZaoX2K8/2fGOH
	KAZjpEsAyvRWneBUa4U3tbImbBNleVAK0tJIGsXvbNQ3dlPm2Dbq4LP+VvwzyRGVcb8GHLNuY+v
	MMDDeoH7+XXSrOo36WUqwOmsKbA9oM16AETJSoe030czvas1bZigDvCu69zSiOGGRIdE6HeXm0R
	qJ7YkuLPdDrqURWqqrRl0DoBYcc+/HcViIUG3DteBrCcrWomLdy0SpUSZ17sCx5ngOlA8K+/d3J
	Eoi1CmdBm0/D8JIAjoLsN4m1/e/s/U+9Or1eqxaQsb2joZDycSoxX7PZxoy9/FhkDHXHZD8A3Vt
	YcLNCiX+/WOxYjbt4vVfi3LWNjJKKo8AMd+gU7S8UxluMYjlb/bl78MsSbCSviaMp/XgEPZHIl6
	KGYEN+fIpmTdBH9A8IAS1DEhRG0q+WhIm27hZoaP9bGHL5K5drOVRLVOzXNYS5Lb90KtBww6Gf1
	Xhv+suGsPdATSqMgVMTZWRm0T7SNGxlsOQM3WATmdKU/WudIKarbM5KAOIQc6/CiucPPOZrf23v
	Z2BhI=
X-Received: by 2002:a05:6102:6897:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d6ba4dedcbmr46652137.36.1794946845676;
        Tue, 17 Nov 2026 12:20:45 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/17] Bluetooth: MSFT: Protect the event prefix with hdev->lock
Date: Tue, 17 Nov 2026 15:20:28 -0500
Message-ID: <20261117202032.3848411-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

