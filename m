Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941867;
	b=1orT6Q7BRQG3e5zjQMA+qwPeA6tUXModwfhqecmK59METXmsa7v6HRWBoPp/vYhVP7Jt
	 VNoBa1aobhZJjV716K23qlX9AdvrOAIedP/DwcQ9d74m4BRd1gj8oiDsyGByO7n2dYwY+
	 f3Wr4dHp6SH38wgXyBFDmWmDjZt55uRE5T6bg11minH6a70uXgLDmNVrtJsAhkbwBSJXx
	 kKLBYaIuKwRyt9DeLgHo/Q2Q6sXdPWrV/EG66Rz9dBcvEnlbyoEdHU2tXBeVgKGRBkQ6y
	 mzhHBPwdZ9vgj8vlGYg+NcXBwH5Eba2Ck4ApwVLYh8gUXn9fPQvF6W8Th/y+2xSQgcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5oaps8XOr2d5p81j0gcZ44MNI7SHF4fDpiTmWLxNSso=;
	b=QQcMWTmyWlyOterY7FI8B8rIDdQI5BkxF/OsCRFviM+dy3NweFJQJ+2TOQpzo3YVrSN5
	 pL8KJ7y4Nm7u7j+b2Ntezoz+EJAbjRVqWNTzDb4Z7t8+4NbDxhd3eWfgQfK9wf3GNP4k4
	 yZzA7h84DS4jkPOurn2X5Dstmem7X18AP7wLwd4R/zbpEzh8HLZq2M9IzKoKowvthLW8O
	 ZcTcQgRQxonuj83JoXDd1cwTGVOfsUo7kV3qiSz1XOjjKenvCePMIuo39D435W/+mbHJq
	 6yVnqNvMg6sSdpPLaOrCEIySJ1OUbmzP18G2LmIjbINTjscQLCB8jIPFzo2SHsTBhbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZizj5yr;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972FC606A895
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 972FC606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZizj5yr
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-77bf892b496so52668137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941865; x=1795546665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5oaps8XOr2d5p81j0gcZ44MNI7SHF4fDpiTmWLxNSso=;
        b=XZizj5yrZKxZ3fac8qyvDY7SWUQdE07RoAJjWW2pF+yLh7ouEmpIw8q1NHjJFgDbz7
         tBBrx/qmpuEGIdZmklUgTBV8nR76djVZ+axfZl0V3un9zqNqaN/6jZvYC1BEqNjAwo+A
         kpowyjEa4H81QRztOZeKiGHweXDBEG0c/CkTWZBPEo5mg+wGqir4/Vv6Y+7/CUh00L+a
         PxVJ7modj29eGFeW2r2Xo1TNzBD6viH5jawNdeigq/RUbCrpS8o4ouuGS3kgAhiKEH0V
         19TGxW/L9HLHSCSW6wxJTVcVNzO1Fbf1PGc4k6HeQ7homVGCISGAOxjOVdk6MvlMoTBP
         wyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941865; x=1795546665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5oaps8XOr2d5p81j0gcZ44MNI7SHF4fDpiTmWLxNSso=;
        b=gFrpk1mQ/MI5/RkI+0J0Eqn8Aj7kNhJ6tfs0b4E+Raoslec/+wC3CKlyWNFN2pwaFK
         vEU8+EbhnY9q4i9GYchr3fAzHaA5+H15PjJCK9k6kcfTy+0WznGnjSXipDQbeV/xv4dV
         KgXxa8SHreVe+6kDcYn1yIuuzfYsg3ph7v2HBQuBaGVzByzdNQzaeJEa0LL7R9C99gSc
         i/kpLdZt/KZUAV5D4R/rSy+l+k0q4kzcUy8YRUoyqiJ6N2NyKQgvRcbGrC4F3xGBB0dr
         /bGTS5iKfNvxe/euNGF977lCebXv10MRJXuPbRN4TCR8Oy0/PixOlAdDHJ/wPVSNx+ve
         jXCA==
X-Gm-Message-State: APuU4Z9mXYnY/YCkfw7X96xm80+06Als7UonAWg2tr2jDD6SfvMWNrYk
	1edbRwd1QSs5MOhuzF//gK96CcOszNQKzgLky+h4xist+hSYfKgxTeaWARASRw==
X-Gm-Gg: AYBFou1fiirMNMMyXqWd1PDbsceH2MN/sfgaL71B2gtP8HFN3fdRjGWZVWAE/CcHD6f
	Ls+WP2WLYmgiPllQBfEIkrMtnCl4ZHCC7rbQJTtM4JTHAjJfHTn0t5FdlX8OLZSGdY9xMh23nYu
	QzDli0OZm+QVIPCfYjls0+Z4RySxgmVs1fh1NCxrf0Wa1k2tiq5RCa4Cl5qUflcC3qdRR5CdJvF
	ujd4Ff3ocXSrHIPI/a5mSWu32REKhUlMHHgeuqAtmua8XywotCjjGtcv8zqK+/IJ440HGAbDwEq
	IjNEuqzLjUXfoZcNcDpsAsRjbI+2qwx1eWvnkX5ywRsa80t+SzG8RjvWiUJbmQBD5UuV12jsHtd
	U4BzreVZA1fAoHCfbWjjukWjSEHU6OCPvVgdyX4O82vr8PlWWufU6//0bxAsRVmF+MFGjqyB1nR
	pZbL8DUneV8EsXrfj2jSH14a/N97oPsohyye0RQayrG8306cVgb+S7+yBCwfCz7I3tkkXRrXdM8
	TIzM1n3tKLm/2ko9cBRGnPlJnrP4HDAeN4/2dyBWzRNbgExUmOqKQ9EvSbPRjD1D34sCCUoj18i
	eIlTvfJgyL+NilNHpOg7wdNemndLuMH+QdcMGTxtWD0f6ebtSIILS7REGMZkv/CZRn3E5jLQ++C
	RQDq9BGoYkxBs0PmmT1bYjNIzHd/HXTrS+O62ZphN87PUiMznPuo0YF5nlf0D5pD4JKch8a/+NS
	3bnVvEEEuCmOb3oTrHAU63ECQD
X-Received: by 2002:a05:6102:3e8e:b0:7d2:76af:fcce with SMTP id ada2fe7eead31-7d64d69dd48mr4408931137.9.1794941865465;
        Tue, 17 Nov 2026 10:57:45 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 07/16] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
Date: Tue, 17 Nov 2026 13:57:28 -0500
Message-ID: <20261117185737.3758255-8-luiz.dentz@gmail.com>
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

smp_force_bredr() created a BR/EDR SMP channel even when the controller
was powered off or not LE capable, leaving a stale channel that
smp_register() later warns about and leaks. Only create it when SMP is
registered and guard the removal; smp_register() creates it on power on
if the flag is set.

Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)
Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

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

