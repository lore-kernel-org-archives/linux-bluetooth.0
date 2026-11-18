Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017568;
	b=fnWb5OeKAB4cLv5764zf8w7OBJf6L2ATod6KVd7d+DkxBRRsHpujzVej6hLEWExL+XwK
	 XBKF1Ba2tymv1vucilx9HobZfcTXAVJ+Kg39hdPHrGB6TuZi9p1dDhymuXBLh2lswoorg
	 lMkets9ocVY7SHzQiRpZQteAtZFmpOkJ/3M7EGXdKM/Svf3299r1laFBxBZdEjjGhWoz9
	 yxOtcD9Ucqh5rS7OkODqc9gJ+bDygaakHuBMcQaI8RS4wf+VmBZ51I7j4CdmMtTmu7kA+
	 rVSiZgd+FnEolvOi20s0xgx9H4TGazKj9SfwbbVJOQehoL3hcVZFPgO5AuoPS89l5vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
	b=45A1SUVrxwmwdjzYo90CcDNBt1BUAGyN4akN+oKnot1MmpeFy4B538wFUR1aUQOOWis3
	 iNVACbH1Su0cQ4PRtc4nqzm5PChrPwAHW+zgOmERLQYc9cZr/Ha3apZjOgaJh3XY2LW5b
	 6CDk/FZNloJFfpRI//8F4U4KUohJoQ3JyLX8fPYnYCrxTFDuIPLgjbDsRFaiOfB/VryFl
	 4ZhOEH/MAF0Kqe88FG13pFVMzWBBU1fLkjV9hX6u4j/IsNGl9IOocqdwd4WmhKudsm1VC
	 SmhsIN+QFRjJGUrqEeRpW4MtTRioKTtCDbnUoRNYmhwG6XNv9l4sfV+GiAQ0Wy71aXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8JgSyPR;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39174606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39174606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8JgSyPR
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso397480e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017567; x=1795622367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=B8JgSyPRA8j/kU6G7Myp3obirrXS+UoORfZ0mQMgr2Es5axZur2Wg+hzL/V42wANZA
         Vyy4vByM8vZoVO+Z+NZ2sdXHpb+AdoH9pI9YK4ugsPVSQRNK8rmMPLs3TPqK/xJGIW1/
         ZG77X2dSnFPJ0vwJln2948iX4TdpmYrfWGWi53Qs/iSWJK/SL4I5G6b0pRts9hT0yirT
         omi16zIdMPj+4Mv0y/+Z5bbeV88m05rp50VPBkCMvuKpWpcfvC/ro+z3l0AVH1yxAvM/
         llXV7CY4NKScYPPxzVW/7s6ztd3t6k/JEFCZe6vVtYiRvgPJrsWmJUSUe60DG+6mlBNf
         oatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017567; x=1795622367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=lLsW40cH++0kmgwIl1+wZDf8cYYr1hwdl3aAVr/UgpQy4A7NekfyTigOSB+GDZbPZR
         3jJYjhYzx9qmX2YwitWoZKS5Fcnc38IA8mmFOoykNcxIOStD101YM6qoUjKhQc9wTWOn
         /i1q9t0bj6ftRL1gPejySa8f7ya6AMTahJdeqbv6a8WIkZX7Je7CPBxYKA1cXY3uFln3
         EvwW6l7+9mFlR7SJ2l56UOOy+/CpQ+23vomKKDqD9tmUNBgbHR44eRCTA7iSC8Vwnjb5
         RStRIzAXI2nFlorfq9wRwET3oqXsj2zGq52ov+fhGFCz2R+sGX00TaNWmqPA19jGuUoI
         sExg==
X-Gm-Message-State: APuU4Z+j1/c5+TzBRCd1jaPgHDYXeGHW0j+LjW54uMXh/4HlTaE8dvqW
	qBzgudDo8ATPP2QqwU+AYn+dG/r3BP0K2syWt6wxqe1lh/AvxEz+gPi0MDzJ8jhg
X-Gm-Gg: AYBFou0idE2tI5rhwx0U7GWjhMg4R0UXdc7RouifGuyykKJG5d8lE1vw/wiPJpwHTAj
	+leolb7r1cm6tLH0Ukd48H4/dvmEDxS7KwdPFQsRDVsDtz5FUeKmhvuo3Z6oYhlbrL1KA+o2AyC
	RhHch8d/+sy+EDKvER0ycaL7HyfGlJQvb7bEjEMC5WMR/K1WIYkFAid/zzgEjbt0e5/t8+9fa/m
	kFC+Z7Mg0i/XZJqLpmNWrQGRJIH+66KlfZAeTrttbXHN7/hgFDhmBCNIxwspJM03yPGZ5eLNPJC
	eZE+4Nrpkfb5Xmq3yuWz37s5Spfpl8H2oG9mI6/sFhluzP3dvDq0jL1ZXg/DwPzd9SNq08N7m3H
	W5PTr2JpO6L7MOMTzsagz24yUpWMtUX2JLIbry99LbNGN3t64c0LdHl6ZPk3409+/Kysd001JZK
	lEcPz+Ei4EqiP0riHpEZwI+KFBT1tgcHTxrAk2uGBrPWXxAmHvaZNuatTFtlCEXZmMfiQkz6tkx
	n5jkWqdQ4lD+OM5eLoUrOQPaOqNdso4OI88YQyZb3zG9rXFL2CrZAyeqi2m7XfRnWz5Bg7ye5Vi
	B0uE/tomyk33cIxhMfZRi30QRvlL2wtfG+D29AZOjV/L6ZNJQZr58ol88GNU+T1NdiEnpUYddPA
	FTEwfZoH10ErcXHDr4PRdYZtVOOF7QnC28xmm5kmCGPg3X7aMfMZnw1u6nDA0GqQe8W9XYkxNTm
	Wa17M=
X-Received: by 2002:a05:6122:1da1:b0:5df:682a:5d14 with SMTP id 71dfb90a1353d-5ee6468f6acmr1432861e0c.4.1795017566930;
        Wed, 18 Nov 2026 07:59:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 13/17] Bluetooth: MSFT: Protect the event prefix with hdev->lock
Date: Wed, 18 Nov 2026 10:59:10 -0500
Message-ID: <20261118155914.178050-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
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

