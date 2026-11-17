Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946840;
	b=SvhCTiT9Zl/+K++WPJWK6p14wgZVRFBlIFBQdh2qzskc/NiEsTl20FCc5vpBE9oBrpmi
	 eL9g7gOCLVWLW6jplM3b4zdF2DYpqc9GZ73D5f2M7PLaEvAiKiK+kmBWua3cYTB+2MaQD
	 yXO/UCKjtYx2DI+OdS+0rJ+pQIq06WlSqBTaUE+9pHyXUxuHpz/ge4KdnzmxgEfKW5G9P
	 qhjANSL0IWKt1WgzcfEfJ5aKhgQnfk0xxuJ7zm+w7JCtq54C43iKHpQB8NxCxsYu004hk
	 c3U0a3ibELkvlfU7q7pYjCxbL8cDJYRBdUg+2hybLF24v0YJtVHAIii/f8qfdQzHNow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
	b=eE2uVrobcKLVZ3qsQ/Pqp1oMxh04v31eb/TEqPtB7QnkJ7cr/hVIh3LXJ6Gt7LWmp9Pe
	 G/m26H5Vue5DzNxaPdD72VAmLsRIJ/2+64HcU/oOTR5DCVSAlkdwvWqDE1LLf14IWX1In
	 /eGsRalIr1JWnhu6DVgfZJnDq6UfQmDiGieaJsg/68QtKcuYiR0fjf8SNi+CJtDbXScks
	 /5mYgKCQarJ9PtrhowWz1jC681/BpiXuqhNUaI6ORgBVNsF5cH9h3vc5apYOEqI914SNM
	 yB0ekFTaLx7OPUKUQKvVgnb6GOmpbpzG3VKEAn/z1XQqppG3x9SNqVWclJidIn0vKTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GNGWh3A2;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDC606A330
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBFDC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GNGWh3A2
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9905d61449cso77188241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946839; x=1795551639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=GNGWh3A2NauzzlzRh4udT68n6u3ymN/iCQtTnuNKBmmCrdH1HeU5+e/YVU1ix5O9jU
         lVVExK0oNeyGcfS44o8GMRjSskyqDIeh60+kx88wEDX9+Bb3vaHmvy7kvvHRJjniQm1D
         1cxFVrWk/YsA+9PhGtjz50bZk4FhCjJ/Bf2Am+ET7+VRdnuqd565oM5hJdAw/+Ag23Or
         wQNHRBYq/RMz8Qn6Uo2SH6gSBXGFn2LgjEwTWvjRL7nhdhmjmBB2oTDfWiEjsZ3ja6OQ
         Cs2q0ACimq1StY9OjQ3QXlnvorzlJ4mZUc/b+X7Pm6jJz36vFxkLPGEDnVmVWqM+0Oi3
         nJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946839; x=1795551639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=J6DBcC1Eveafw/LMKaqYuySnMSCmWvlzXnCZmBGZaEwVRy7h60MHeGBEU5nM5tl9ks
         PLcH3ZfiDhrpomwxnSZqH3ooUo8CKiaC10EqZCglNqNj87ZfH6xE763njCMuvewPyJyr
         lOv56mKNsb3qJElUPX3nqfBI+5yAYpeT4ys/sGFjIWU7Pw7rXH/Ljs4ITGv+/aM0IkvP
         g1zUUFsUk+HInB0edvfyTxI6BC6GsEr1SQqseRuP7mP9jZ5PNi4vuy6LC0LfbqEKlscw
         FUIOILpy7Tfzs64ywKvFlpn637zWVhOFeqLbN/kaUVG+xG2rnq1mAbiwIkTZ2nXbZ5wV
         z+Ug==
X-Gm-Message-State: APuU4Z8iVRqdDXndmWHzTz90AKye+egAq+hR8quhKh9tArWg0iYMSCU5
	72j1NBDtGlUDjgNmvbiZ2Bvf4rGch/UyE19Lt7ng9i+TNSQZBaYcyrcC2Z6Umg==
X-Gm-Gg: AYBFou0Xb2omC+8eZH0+tN0SXr+v06Ib5vJaZwyIfaMob1jP3cjZmVjD8np40kfy6nQ
	byYRBe0QPDxEv58FbeONZidKrECi3gdMjicFmApTxk6CO0DtpZdT+bYgilgHo2lpmXMP2e3CdGO
	wnXjP4NTVC4ZUruo6920VrzPIlen1bNEzHw8QR/xL87bdFkCfsUgiVpbS1YBNThFeCpbntfFcT1
	FgIvgHdVNx/XRu7rGSnusxtGH40z7XiYlDIPr0psL2hy6jw4x3qyksBFLTdinSiQEikUCKO/Ufr
	mjuKSUVUhRxyepSBVJbeaFRbT0Z1qRdPsaf4/JxbCxo+OjWku5g+X8aRuNTnr6G53OyEo7YTRKC
	SSjg82rehuXjH7kVgX4GY1eVjR3TDD/2vL9HP59ihgQTFzA4VYCnka1n98642Qj/5VB4txfrWMw
	CHCHu9HgxqBb8i+B5+2GFfZM+Rh5Na1Yl4NyUzrvZii81ewjdKwqUUvhLP2ZIaOL32Go59lyrcu
	A9azCYWPf5jWd0CHhSr05AHnovL/5mDJhQUH2IBK6Gd07rgQDG6RrvBkKXQs4K7ltYd5B9HZ3GZ
	Tj4+Zp2WIPM8VrE0gfSJaY5Ys/FKXrEF2S0b41/szxVHYZqLRsrsS3b6PBgSZeflF0OqMnhv+Iy
	THJabXMB1XM9jnIGZQVZiFMHC/lL+bJWOdB6oyMd28NPYKmGuCbESu9k1FqqWgmZc3JXNvoZli5
	3H+VY=
X-Received: by 2002:a05:6102:f0a:b0:7d6:56d3:f179 with SMTP id ada2fe7eead31-7d6ba1c6bf2mr65462137.5.1794946838682;
        Tue, 17 Nov 2026 12:20:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
Date: Tue, 17 Nov 2026 15:20:19 -0500
Message-ID: <20261117202032.3848411-5-luiz.dentz@gmail.com>
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

The advertising instance returned by hci_find_adv_instance() was
dereferenced without hdev->lock and could be freed concurrently.

Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9cbf2e3009ac..a1f272c14a1e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2207,9 +2207,13 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (hdev->adv_instance_timeout)
 		return -EBUSY;
 
+	hci_dev_lock(hdev);
+
 	adv = hci_find_adv_instance(hdev, instance);
-	if (!adv)
+	if (!adv) {
+		hci_dev_unlock(hdev);
 		return -ENOENT;
+	}
 
 	/* A zero timeout means unlimited advertising. As long as there is
 	 * only one instance, duration should be ignored. We still set a timeout
@@ -2239,6 +2243,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					       secs_to_jiffies(timeout));
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If we're just re-scheduling the same instance again then do not
 	 * execute any HCI commands. This happens when a single instance is
 	 * being advertised.
-- 
2.56.0

