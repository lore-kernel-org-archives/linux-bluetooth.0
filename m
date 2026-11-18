Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029084;
	b=IGbvCwxA2AxkAWxL50tf49lipuGY9nJ/RF5ZC9YrSzQbmnLYUGX/j8d78rovuW78xCOo
	 0j+WZVFBPZUWRbnLL61hFzW0pRKjQi5liVDtCXGaL6xV0QD2FRhiiTWRZmBXi/kVT8PZv
	 mH42jnm+Z4Z85zPvcxPV0Y01/mnPqc4rKbkp7S0zK0h3ZJpoi1vf0Ky0l37fM+imA+AFq
	 RYERvy8xOeYkNuyP9EPDHkHoXn8TagbmLN7eKLAuKjTAq4G76iXptQOuPLuM8rMewmP30
	 4LyBa9GjrjDJ+SOiomevcdyorwyX+Y/dsRxNcsTE8UwTX5Sw+Cw4M1I1H5cKqYG81tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
	b=zFGafGSCZvC+pvXdjWl3bUhXxKUOwI2R0pZeys7ZOAM9XL2b3lTEizBtaWOs8B6jqemq
	 jXuGnS2/RR0r4jlZfQgcB6m/JZP6/YW11lcsTyebn5LNFBDAG92V2wL5TEDzu3aw6Vek7
	 XpNntz6PF59/tuWaZx0nqjhkZ8/46Lix+zGfr9rI2mJnO5ImEQBmmyFMtfD7ESqN7GJ3n
	 NcI4xVWQpGIiZon2VJd7673UcVkISptojlYXAix8jmTaSBcGvLqMRbTVBt+k7ac65Y/PH
	 seCLP4NtAas+wS2d2R78WkTrzRoRwCoLgeQC0kFToLQdfj4tUbDbdDHBcbB3+WyeGJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohf10sYL;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E2606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 664E2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohf10sYL
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ece6c1d1cbso450777e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029083; x=1795633883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=ohf10sYLLourmRr/2T8UL/a/gCGBPtZVmkNL08EaD4sAONz8B/S1DqfsVgWQEoa8Bt
         lU0kHHx+ZO5HirB26zWyO7i4CBjiocpttMfMjZfP5eBpqzODPofFKz5HrzOkriGPy1us
         66l5NlhH7PMkCjeyP9xJ/jFIuXy961mIDCp+3+q4yL8OzkKcRrQ8PSB9aIJ9VXIj95yy
         X1TxI1i8w8cnYGFBdL9W6EgEWr4XAzPVeratGPFyx9ulLPpBhs/o2dYPUoYogawiOOhQ
         T3bQc3su2mP1JQrzrgvZmGvgI7iHyiR/z/6qgIsUTU+TreJO/nqPWnHnYK5HKGpFYv+E
         QI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029083; x=1795633883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=rGQ26MYkTO1wZjvK6s3GYu/MgbLqBsXk13Fhc2EHYGByAkdBxGeVs7j08Z/VqZ6Is1
         eFCLft0uQ8RbV4vVFoArrQN9itk5oD9eFaVy+fV/QgIzpsUDDK1C/zsutnayCCfmGn8B
         WdN6QtwAx5mAFUEcz77pJ5ihUyoXuWNjW0DWQtqU7Bp/xriTzKu0rw+BNGWxytvvZqNx
         NzcQgDN2MdFeLA4D7V9Fyx++/y7SbrZoGWG4EJH7ujwkO6TSCPaC9e8HVGlPpyF/a07E
         IMYj9eRp7zIUbuZjCsMy8q5qFzQObV9eJ7D9SfACrWxw8HNYGZVxndRlLbJayZKlO5RW
         h8hQ==
X-Gm-Message-State: APuU4Z/kpkLwD3xt81qeJlfg02+el9YmyWAj3MseDZhJdt/LkRstQNnN
	/AqL4QtsQr/p5I0RqWuoQKwQpTHyBFV/0FphGDKCBtMLTkeTSf2xdrOZQOAnv7r+
X-Gm-Gg: AYBFou0Xb54voxFOVvOxsfGoiuvxk99doeQeIK2zquaq25ElgRrS9q2c1Lc2qcoARJk
	lpLmagEu/0ql4lwcokpag9DH1BPGYFT38oBdDAlw/el+OkLz39IXCNR6tacsOFI0j6DAlIyPZ3L
	4Xs9iQvhZ9PCvkPA1dQZ/KpqmOUp+JoFn4RWuw1N5g8hoXmCFfJ3xs/oLzYH6gk016p4T9L5cLf
	bm2napNkCT4j8NZgjqwtS3ZyJcH5InVTRCU2IBrl0CQBIyr9EvQEOkCVKCvi59jOgM6YxAStIGc
	2hjc56kBn5D7h6AIIc5YGsooCdJ4ZZyAow2XekNvSENYyhLOYNYMLBF21ObNUoivoMf+c7ZaOqh
	ATl192cnAyKEP8BDbsu07Ty+2pJJT7aXjj0j4elLvMKjyw2tVU0G4/zeNyluiUJe1G+FrjSpR1W
	7p2wTnhclWMslqZ6k92kJUAQxDwi30Z6H4dkJ+WCf1CTNXzWgk+VGIXws44h0Kv0yENfojAk4GQ
	jAtS84Y1cC3StSklj0Kj7cgmwgzPdjDK3Jr0UvdoJhB5RJm1y8fLO/pr4ttWPZ75IclpMMbuaLI
	WjuW41Jzx/RRxqep6spLF7PktyjokDUip9QrR/uhmoJ9KTMd3m6Jg3+7tk+GN8QBNqj6JbNyq9d
	ihWcd5Mr67LBD2eD8g/W+1B7XfkSAKjzvLrSlAQ69+wIWU3D3OdQdmNYSvkAiZWFfaURrQwR5Oz
	gLCf22FwMCatXJ+WkhlQRxxOfh
X-Received: by 2002:a05:6122:e202:b0:5ee:5b43:215c with SMTP id 71dfb90a1353d-5ee64729368mr1754076e0c.20.1795029083376;
        Wed, 18 Nov 2026 11:11:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 02/17] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
Date: Wed, 18 Nov 2026 14:11:03 -0500
Message-ID: <20261118191118.318779-3-luiz.dentz@gmail.com>
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

hci_powered_update_sync() issues synchronous HCI commands but was called
without hci_req_sync_lock(), racing with other request users.

Reported-by: sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)
Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0c0180a616d1..9acfee486be0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1010,7 +1010,9 @@ static void hci_power_on(struct work_struct *work)
 	    hci_dev_test_flag(hdev, HCI_MGMT) &&
 	    hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
 		cancel_delayed_work(&hdev->power_off);
+		hci_req_sync_lock(hdev);
 		err = hci_powered_update_sync(hdev);
+		hci_req_sync_unlock(hdev);
 		mgmt_power_on(hdev, err);
 		return;
 	}
-- 
2.56.0

