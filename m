Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029094;
	b=eDBIHNmtjOwJEVFlUjV0p3PB3qcwu2/kAGH97wAQK0M/NC504tA/IzRs4/kPBG/ESTWT
	 LMychbMIWcLVQMulyX/YEs0G9IePu1HoY9TKvG+EoHShE0X+yajqQejAIqPCcL2c3x+tm
	 Eic2aXAoxMOrkn9xfu/a6juRsBgdDo977yQCwxA9s0A0yQ64Zi9hBz4J5N1SNR7z9fWS8
	 cHo0OR+KJjq/yDKNzM3Aw2LmbEbu3C4uOvam+cKkzGXQedT50pM6mdfMjG4Z8m/wfNSNs
	 wLCr2mHzQxMoq18wJfNZpV3n5OQI99KXR255zeDf1P4usl2TbmlOxpSlMOMXd5GdJbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
	b=y3mr30FqCDTUAL8de5oLKRNnDYxdMlkbE4mgYZRuGaSXfRtPVZrK7TTXs/HDrbSofFnB
	 PE78acCYXUJ3VjDO9YFuSNg3BFE32iBnFCF5xVB4NlYi/baYgmMzC6kA1pfg39WodAvpS
	 xQQgKQl5L2WNgQM5W43n0gC0liuYi9zwXZBP3OSBRlDcZEJpUJ6FqCQue/USu/se8AX3M
	 o3SU+uXKcKV786UO+HAZPjCXWhZCVwvdPHFADdwdfgk1CNgH1snL/4tz+NXImkC/3f39C
	 mowgK6X6nFpqzJOPQy3LVjiTqQ1K6SU58PYKUvY/GNb9RBM/AVAD3g2jDVgh32pvNzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIkVHK9b;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E6606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 851E6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIkVHK9b
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ed2f163a2fso389394e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029093; x=1795633893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=bIkVHK9bBee0vM/+5pUISAz4ccLbqaVAFV1OQ740hBS3VtYYb8sxbx5YB65FZVBIN5
         rLRAr0jLF/x0IfMdD6RuZlhichBybj+ttAAuvjo62J8FnHIjoADFo66YlCts4U0euXTM
         0yp1ROzYLfAQcb43089hHk+nxjjMozaViA5lOdG6zuqXAOOD3b4vDSN5xViJtuE5vh5L
         sWVKPSJHp3sRpLYWaZxhmogQc22ovwlau35m6jhoUqWFU4Xg233AP06/i0pBL3KY+XnW
         P8elTj84xgRKDErJRxN//nCQ4XuqunReQOw9wn71TtpttmJod3f6E2JwA7Ch5avbTkat
         wBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029093; x=1795633893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AIzgNC9ZqBB9vI7kV0tGdGLWimQoDYCdfioHgH2gHuQ=;
        b=o6UI59u9DPq7C14T/l4nCOkPy2Jhz53e7hzxdYNJbPRnaRg4r1OFxeHnY2+JP4IY8r
         MFLCXIeO03zPvm1ufkiEkrMhYYJjyjhpTZetRKHjRMOizhyHIbecjbRAjaEcDR2RHeck
         FRVRm3j4mofJjAe36w/LG7TipEUVQDwVHg8RPfBuSILCywqrTO7mwCqey/RfyCEw5taR
         VU3SZwIKzX82Wz2w4QqzIDpIF8x9YeTn2yKINW3fMNnVFqaFYnuBJGTj3OzZPsGuJpqa
         sFJlbE63C9BPLnxc/xsFZh7uLe4b2rcaNT9gP9cVSAzcaLvdw+cUJ25N+BroShwcybKa
         J8IQ==
X-Gm-Message-State: APuU4Z/JYiBbb7WEa6mS337eqCKCbFme/gw/59i2Y8bH8HgHcihDBvMN
	Rb1rLhV3JY75CHnz5Zhq+lCqYZwXRRB8cFFe4ur9ZT5satvh4UCNoU3C2Tl1pLrC
X-Gm-Gg: AYBFou1n+HxbG6fs1mqSPc62Dd6Pp6+ZSwF/P9zO3yro02+YmR6tdzSRYzUksRyGZxz
	wsTjwYnRElC+06xahpiGsr4nJ1k/emvkhHkMjAWwYLT6z18Wgl/Ig9dJ89CFgyL2Uo8L5nz3Pgr
	d64aV145TKanRlGwn+nVNy8ozmSEY7adAkYBPWh570kpLW+N3L6+ek+Dkrbf431Zi2mfRsBevYu
	WMDWgKmJpu3hwsfk/km9FmK026Fk9rz3bfQvKpsstNfr1p4K0F8R0zMPU5g4QwyyeqEtDC7VQgd
	I/ohIcavxf4ZzekedT1FQek60LOYwTpnsHIuhNW/K1jn1reVEfGmL5pzyekb0LXN8GrNNmdd8Cg
	yoMJocruFTwT9StMRQcUKeGrY9V1UaupZ1/VHx853hdy2zAHpxwIF+c/QCzb231KPrrscf7EBLL
	LXAzAGMTmCPTeIcYAX9vxRc+TFGx/3KrngXvttyGDOReNDwzeOS/JF/b2yci6JjSvql0fjnnC7m
	m4CgP3XmwaIn22I3W64WE7625qTH2mybssbb8ZvN4nv3LGxUjOqiOniGTR6bk6ZcKlH3/VzxYgT
	IxtkEW+Sy/toUmxH9PBjlyscHvWXNrihEMbairLYFQpdNCvCSS4BrBxgD8FEc0ltwnqBoO2rvcs
	DjAFnwgrXgdOt6pmlLaur1ZFA9QNtv69wd3efX73SMu4Y+C1F9RbB6itVmyWxRGl6cvG/AGgz+7
	5CJ7M=
X-Received: by 2002:a05:6123:12d:b0:5e9:5e79:ab3 with SMTP id 71dfb90a1353d-5ee64779783mr1767545e0c.21.1795029093464;
        Wed, 18 Nov 2026 11:11:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 13/17] Bluetooth: MSFT: Protect the event prefix with hdev->lock
Date: Wed, 18 Nov 2026 14:11:14 -0500
Message-ID: <20261118191118.318779-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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

