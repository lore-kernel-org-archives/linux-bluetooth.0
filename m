Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029089;
	b=mt9v6SNHq9pJMJ9nbpi2LJFy1KDo9i9QUrJM+vdYrK1Y9EK/R8A7g/4UlHvTz1d9ZUjK
	 GZb8vDvxXHctDKr6cdumXNRxzypfT5UbuDKHcywDbgmbwDGdlUgXoYVNZlc9TvW75uYXH
	 NhSh+xF2KtuLUw+Fb5xum1OMzzNeIWob9GIc0iapNQR8Yn5YZkGXn30zDm2PwcMLnk+1g
	 fQFzj0kud6bWxTAZujrCm/7akzhivVBx1oHnXpqfjtXmZAGJuTilO3cSNovoQA02iOJQ0
	 AhMQOKNHlyftqiHLsSZP3kPJptx35v1D/vwWiGevAIToh5hiVZlCYzvkJxl2GpHPTXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
	b=tpLLh37/G4pACSui57WYPnjg65lpfD3r3GNXw7IBRCFZVF5NCmHYw0sn57HN/N0tPh8f
	 tnYV/URMbRMOxYc+TOXXroISMckQ2cu+Efq7yYu6iv+sYbnzTZnjicSIFXrYeZ8jHbl8o
	 qXCJ0mL/tC1eMZSsxxuo0TBb/iYD80aZelrthzMZVDm1I8OhIyYB1HPZmyBcJwjc9RTN5
	 PInFvjVWjbw3gKgXqOfFG4N+eHcj+4rWaPKmOwgqXD76d+HBEdrmO2cSDq02iRFM1IhXB
	 Ts+aAE/NyL3NKhfAWQ2T6TQ7bsBViTczE6Jl1mYOyRjahg7bFtUfQ4xKY/uZE0R6+3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K72Y7Rbb;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FB606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K72Y7Rbb
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9907a58f14dso425362241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029088; x=1795633888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=K72Y7RbbBvMXbhiv92w40M3EWln0w5HK9V9ORu/JkpF8G48aFkodHUCM84NniedVHb
         Bfwj2UqbYS86VIkrr2ggiia9KS/4pQ7vCSePr+Dt690eAMhzHfuyhSWU8rdC/+nhA/zb
         HEY79PZ+KlrvQ7QlIFDD/6b97lk/xQ1m3QRLGt5idbu5wS6ETVizc6VMbnmfplVHCjmN
         avsXmA4XIUNb47zzIzvK7jbse9yig0qVX577H3384wcSqx4vfci3CEh+wSHTGMQdepXE
         sR+U2aisyFFBYN41eXNUFUtU+R9LhgQDlW5lKGeFTji8Wf86zfReP/bqoWOBNptns5Yi
         v9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029088; x=1795633888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=VkGOGkZ+JzSZNZFaw/lQs0UCnmTf9yUGPoOexp2H8if9Kr/UmPfmYASS+zPV2JOMWR
         5I1twLc0nw1rededEleB71q615lg57zrTmSp+MQSQRz5H0xqreuYHyWgBPrZHINc09A4
         CqVUJ+64KVt8aIsqHoY/L1Nr80x+YwpB/mlUlihIwnlv8ublj3CTmM9f+JDrtOT+JbhU
         R0IMvsEq3OrUJbTLRTBzjhBhXDT7O+gjbcqh/QomnE2CKMYpcl9llzGXhvr89SOyHEha
         zWGXomvgJvTuXNu5ZV5ER/oSmZcEXMHTVilnmS9Kq2tp3IA4fWf4j8gKUMAFqvRGSfV7
         /PiA==
X-Gm-Message-State: APuU4Z+YDB9B+q37VizWgOA1th0hjcOTRHiEzwuKI9xtPjQsAMdS+Tzy
	SPpcqssuy8P96pmYh3lIwFNNhvB5r543qPaAzhFJgXet2sRbSIL4bHsbmfT/IwJe
X-Gm-Gg: AYBFou2KKgjUy5Y1yrDWQIzqfqwLy//14jq0NxFOUlbtn1LDffPeC0X0p1Tf4APszMF
	O+aifb1AkcZlVKfzIjykscGSeu2FpsYN9vpONCZART7AEEJtQvm9CI627zDcbY4q70wTbmt5Ohf
	zi2WYDNtUAU1mw+v4pOoKFaoth2QvDEqsU+5Ji8SwTtWBaQFWMRaEGH+JfCLzI7g6dYsImSyKGp
	EZvA0r/ojChPDzFkUaFePtsfVQxSsttFxG8UEslRudCuIaAShQShXJ1YDE/vTM8c2xHyn/h51YC
	X+Qq0rDb+ToOLj1CiO98ghP0/+4OQttfOxwkdq2JuxZZ1+PQEypc8ehZmqHdKst8GNP/lswOurL
	lSBl+ptJxNmuiV+iwcbDMwa0PmBzlx+RHv3Zvm6dnphkRrQsWeakk5nVuUSbXhwri7kRV5HdAVy
	JlUKYBYR4i0EBdQZBY1e552s00+TFJKzP44yWsBt1ft2WtbkxtZ30cn44OvsuRlWNZthdzZWajU
	thsLikgydACQKz/yltx0wufiFm+MdxHQEd6lzXXJ04iQPXh4+s9O8TdmraxIVHhOw5Hr5dSOkJ3
	uq4VJbE0Kw8HDfSLvy/AxFD5ccEmZimqE1OeXx5hPUDk4C7/Cl06gWHi202pJxsBxMoSVpqTpnO
	aQrFVnTWTGVKlTLu+Pd0dIkji8STV2oHATOJgzMvarTyCqWFdjmvos6GsOxsd3u5rfYjqJIA/4S
	KXaEg=
X-Received: by 2002:a05:6102:508b:b0:7c3:9a36:bbda with SMTP id ada2fe7eead31-7d6ba22a9e6mr1433040137.5.1795029088397;
        Wed, 18 Nov 2026 11:11:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 07/17] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
Date: Wed, 18 Nov 2026 14:11:08 -0500
Message-ID: <20261118191118.318779-8-luiz.dentz@gmail.com>
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

smp_force_bredr() created a BR/EDR SMP channel even when the controller
was powered off or not LE capable, leaving a stale channel that
smp_register() later warns about and leaks. Only create it when SMP is
registered and guard the removal; smp_register() creates it on power on
if the flag is set. Since smp_unregister() runs with hdev->lock take it
around smp_register() as well so they can't race with each other nor with
smp_force_bredr().

Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)
Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c |  2 ++
 net/bluetooth/smp.c      | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a1f272c14a1e..b1925153c2c7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3892,7 +3892,9 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	 * registration is required so that LE SMP can clearly decide if
 	 * the public address or static address is used.
 	 */
+	hci_dev_lock(hdev);
 	smp_register(hdev);
+	hci_dev_unlock(hdev);
 
 	err = hci_write_ssp_mode_sync(hdev, 0x01);
 	if (err)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7e0be869cc74..1c315c9ee7dd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3441,20 +3441,28 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return -EALREADY;
 
+	/* The channels are only registered while the controller is powered
+	 * and LE capable. Otherwise just record the flag, smp_register() will
+	 * create the BR/EDR channel on the next power on.
+	 */
 	if (enable) {
 		struct l2cap_chan *chan;
 
-		chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
-		if (IS_ERR(chan))
-			return PTR_ERR(chan);
+		if (hdev->smp_data && !hdev->smp_bredr_data) {
+			chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
+			if (IS_ERR(chan))
+				return PTR_ERR(chan);
 
-		hdev->smp_bredr_data = chan;
+			hdev->smp_bredr_data = chan;
+		}
 	} else {
 		struct l2cap_chan *chan;
 
 		chan = hdev->smp_bredr_data;
-		hdev->smp_bredr_data = NULL;
-		smp_del_chan(chan);
+		if (chan) {
+			hdev->smp_bredr_data = NULL;
+			smp_del_chan(chan);
+		}
 	}
 
 	hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
-- 
2.56.0

