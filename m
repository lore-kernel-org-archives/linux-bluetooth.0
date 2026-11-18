Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010732;
	b=JESA86nUPU1YbZgP77hyaURRfQowwMmoTI4ZiQO2b3kIvhA7x3jFfWydbRzDKQKj07D+
	 XCzfobsB9pXYSiva5HCzQCrqYhMtCt5o0CVB0TIZ85qs8uHzh2MrRlnBVju5kxUPryWe6
	 qmDsWmE/C1AASDQt5acvLyAxFtO3hjrVVj2UzpZIUQmP26mn4cyqQtC6aI5sfI682F3r9
	 VDR1G2FVkoRGqHieUpGjfB2AJcnT2ZXbNFay5oxrxNjsqUQ9MklJlxRLrDoztXDl6Ptaw
	 1q9/9WreXZM0OD097vUfGybsfC6CEOoKHSHamaRfHxXbo2BNsBrHIowZPTw1rSlhdBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
	b=INC/rSKaojxxajk5npbPDIV0o27xszBItzqOiuCDz5EoGen2t64L53UWbajtGt0m+u2M
	 4RL1CeL+XZNx0g2xmVhS6SbjCgPSJRA+FDJXdADtZDbOG9rtV+veQ9Q49kdF9wuZts2Bl
	 VkPl0dY6XaIGQrcjO8pto/TLSBEAc2TdczgJLij8PPFvddP0vjCcZX9Y7S7cPZLVG22yt
	 n2v/cOLakQ/46k7ZekcJXQFQdtzR0OihiCXObYBURtH1Qqh7v5LoOZhiiCEzuYosFQml8
	 7xzz+mCkZoVfxk7GlGpsTEi89H5oGjftRA6bYPiLh0Zi8fn0IKO0sh6n/bTLfI4HJMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfUNu8wr;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DC60A382B
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 280DC60A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfUNu8wr
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d2da166818so548655137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010731; x=1795615531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=mfUNu8wr/gETrYgdecf5zJsYbgQGZIVEws92jr/Xo4U2Wtp2Xr4ixzYA/sVXAo2gHT
         UWUSWALUVgD4ffNwnu4WL+BgjcVyGbYV7L/PMa2NMB5ZwaXB3JoU6tg9gV0+hGT3Sw/s
         fXQio+sf1n/RLgleqerIQo1EB85YLRjVB5+oPl7vUI11bsVdhd4LqyZgklnbWvVL08MK
         3y8ufbDe0LCLOzKqD4Db3V5D/bJW6CFmj2Q86pXR0m83DujXXsESp+X8bCP9ij45GQop
         42hIGjGG8plMO1zKz2oqveeZjFBLbFce2lV3Cy2b5NBitRqq5v8fK4ShfbgIepG1fGQD
         oQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010731; x=1795615531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=ITeg6xECoM5WqaPegOY3KjrqUsNM6gjqgnpJaooGQFI6BLmBG6xG5UzHzP0D+hKfb/
         9Pcusdt3VU9lHYAWI4ixo7m7ax6xDh41st9h5qwIxa17hMdPevjmcmkR95Y+aFT2UFZK
         WClk7MIolpLGJV6NFVZe1wB8oMCJrOJickOdh1sz0OzXUuFK7VaeIIXxc9xnGbqiTU8c
         D0Ky/TUoDw3lUJaSjYQ2Zh7EvxeCijNUBnq+UzAtgFFARd0mfHHQxWwu7OYVdc+Pt2Hp
         YCkiR3BlRMMcIEzBPReF6M9/oODeXopbi0YMLvVspiwbopti51GWPRzYQ6WJGu2scJXQ
         2/LQ==
X-Gm-Message-State: APuU4Z8uB/ZK7L/qxJHYLvwHPtRFRe+kncThuD9J4UWwRVC688JPIgdx
	8lEaB1SpEaeumWI4vDHwvRBEcyJNnvUVTau3T8EJRZ+AfB6iAA0JKCMj09VmXN/b
X-Gm-Gg: AYBFou0wj2ahjj4ipS2DdSSc/ig4gxA9WLY8MKd9egZSrmEUuQ2zBOqeYm+lmZs5gMR
	ewhI7nismWkBo6iEDK399aW+NHrjDDZ9JqZrTz4tyqtwxhxTZ4Ur+iPI4bkXBHOsxzPkzZlzcsv
	VbSkqWApIaG+e/tPtspukTVGkTBznXXtRRqe1FJY3Bkwx0QuMNAJPMCHYqm65rylT9eaY4KD5ER
	5R+OT2YtLeIgHftsgrUyIwSpkX5vgppNnO+ZwI/b3DGeQlS+PYkOy7T5t2Ih7DHR7AUthqIi4ra
	wm/+Hc7S6/dM4KscCkNQzFiJGEY5vAtzct1L+P7J0L63hEpR9xJTF0EzK3Bhm2DQ4UxuxoPf3Jl
	/TwnkfTV2TGWT+372Foe7ImHJGTvxyfFYm5IKFmQ7yfUeExcFVW1lovsTskb+iKcT4yy2dtzjmb
	O2y0g/8d46LW5wtAUw5OiVRB5gWoizmkEqnnaT4oazhbQSRO71i/sRxncpwmg1iCMZ4ZdIwLPY6
	C60nPO7TVFbZZ1NGszsBEhndr45pLzHwyprFtL4UX0qVymqSaWwXq5ab4Irx/CPYknb64O7IWKW
	oG/fPrZzM5KhdikfV2CYjcYqp0a+2TMlLrGGXrDWW4cw5dHBW3HDuRaHSgSO43pFO8EuRY1Z+qu
	DIAWgp2ZkWZvfs84NTCGqM7Irt2ZHDwmtOQDq5BHdeUZcxniuKu7OLXshmzjZUeAX6P85uJQ5ey
	26pJI=
X-Received: by 2002:a05:6102:6444:b0:7d2:7654:86ac with SMTP id ada2fe7eead31-7d6ba175e2dmr944034137.4.1795010731077;
        Wed, 18 Nov 2026 06:05:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 13/17] Bluetooth: MSFT: Protect the event prefix with hdev->lock
Date: Wed, 18 Nov 2026 09:05:14 -0500
Message-ID: <20261118140518.59878-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

