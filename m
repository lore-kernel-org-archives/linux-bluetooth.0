Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010728;
	b=KEVH/T4Y7Dkq4uEOg2HWHAzjGDkJfyzWt6eKjuwTgbhV+CFEwj9HUZAs0B6oVfnDrOdI
	 tIDGHWLJkA84VXA5fQ+rZ5GD3dhROA4ishVIDC9so0E/zt/zImGlMZa8Aohk9Bese/NwH
	 XbR5wPdskH8wuQkPV3CHrTVUqHytH5cQ4LzlL7x14hstD0w9ukQdfzC4T1x/NHtyOCf4t
	 eKsPveN9pauCt6rNrv+gt6acin/D+nZEzU/Y9dtQ5FEMIMIXDVHyr1TxqPczUDC8d05Sc
	 GGl/rwVOx/LbJsoTofmguBxLfQ6tjCK3lYG6uyFJnqu1E2TIcR4EfB43wVi6gPRlNnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
	b=tUgM4dImeoAU9Rw5Yj8jv43zmW6I/qsSak0FrpMwpVLg2plb0WQ1IfhQYxeIjTMBv4cH
	 tTw5C23HFM0ys0e5U02kZ1G7jr0VHHotbwrlXtQExkpyWu2MhJr+eQP69mcvwcii8VdQ8
	 ceK2nOr91T/8ko7YscA2vT4kJs6CtBxcRIliwR0gquawBpwHVc2JgPrQ9b/1lhsMSriII
	 LHSmEDQGGxN7JbKlJOq/gWx4+43YKmpGCD4ZNsJqZcuWwVhdCRHZLgnJ/yaE/O0GRsClJ
	 lWYhBjBurGb+T3GKiZiHdoUSyQVt/YEC3xcaanh0d4xOsQOLbsn7rE8/X9WdCwF+g4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gqd+LMMe;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFD60A262D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5CFD60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gqd+LMMe
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d6554d96d3so540491137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010727; x=1795615527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=gqd+LMMezcf4NyOL63JlAPE1Z+nPj836u/awfeNlVg6wpz3LyjqUFGeH6cZrZopae3
         b/2NSPLgdZvApLE/5wwn2KmU1N7MkbhjPhxMleIXN5siiWVOFYAdWNhet+loRzmulcgN
         aASpZRvh5mHz3UmbDzti87rkgv7L9/P2IkogFbVwHDzAn09/vxWOqKHb1OjmQyvmPevS
         uokj6R4NUovbpfx31SHvDihQERm/rgzezsVXx3xxcBBkXEUHoXZeP73Gwng7jaHiSXHZ
         s4xQnERPvdqo2WoFOAu/VdXzQvXZhBqtNoEefMNWpzYKriUcLtXqwnBy8PDaz7RgxN23
         n5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010727; x=1795615527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=ih9PcEaNmV9acw3+BqmnHv465dEL26F2Z7kX+Sxo+w6OpZJWHBF2h0U7mJ4Ss/B0BP
         dNsZM0IcdXXi83G3YxLHHUydgGsVTFrCM8cqiLADrEeAaPN0FRHWA4ge1Tx0hAXragA8
         yvf+ZCRLpnJP60tx+hkQ1pVxKw/EhH1CJruDK0w/QEqlDhEUYhy4VAfc70OCeqTW6zgW
         eDTMb6WIYmozzMIG23zdy3KP01NfV08nu8cj2D/+uYF9klCBBiDuQdoafCU8jDi9vYul
         d2gLQBI3LxK8z3qm6VYo9scS2T6lqc9j3+s0DgZz62Mff+JjKdbB0o2fW/vJ2xWFmSXn
         xpfw==
X-Gm-Message-State: APuU4Z+ITcngrtQrcHLQLV9V8mvl6ZCc54wzO6SkWUUsBx+omuCtSOjo
	lJK1Cd7nIjl5+JD8EFORM9M6QsmMNDM+BW88L4TYb+5mu3/WRHOkPzBrY3/SOUaL
X-Gm-Gg: AYBFou0g502UtkTJswtM4Mm2V5yiy9TW1apX2hEVyOi0dnXRhL/AC489YBqXZExT8mm
	kENq/lDkeRF7/RW6tE0gxHznZ51d97aVIf1PJOreLgDILmX1kD5HvGpY5UI7xTvufgEcV3zgXmQ
	VchS/Wl2oE95IX/GLckCYZ9PLcBOIHycur9jfs0JcXOCexkH9NzG8/hzQym2VTBltr9FjJNGN29
	mhNOuHITNTNRguom5LFJjjwOkyfnpfJA6M0tm8O1bi7EQeda4gYP+cHOcly1yy5tWhf+dZZFbCs
	ZJXRwgCNADfjzR2vquBaBXzriJVg8utWIbrfu6HeCixgtYRkftG64Maz7PVXOBT+wLk6ogLrhGA
	OyN55Bu87WOrlnkNfbmPLfTCovY5koZ9/icFT9eIXgS0fAqE0wA08ASiBQ5L1pNWHNrZaAIgs8Z
	l4nSw41bmhS9+6o2WH5T3OacPCmejH05zmdnAKj5lvSCvny80GPbGh6QowCxNvWTZvenbGt9H3Z
	3r+xO9cPlBi1NuOuTMxX6wxGXY/nizq+TRcakmkkH2yahBKcX/yzGKmcLsOx4/d2IJXPEu/JQC7
	0+7RpAKePc1PueQGxD5lAWgvM2U4ULTrmurKG2YTNjQVKAd1kOzcgLtoxzc0FyXQiOMuPuF7PVi
	InuRbAZIA5GGPA7TtkYsmccdYzs/EDtBK5D/QcW+KPhJEHdObuQ+gzK5WaeSSpWNap8slMV04mt
	RzwlU=
X-Received: by 2002:a05:6102:160c:b0:7d2:cf82:1a5f with SMTP id ada2fe7eead31-7d6ba495b05mr1019987137.24.1795010726492;
        Wed, 18 Nov 2026 06:05:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/17] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
Date: Wed, 18 Nov 2026 09:05:08 -0500
Message-ID: <20261118140518.59878-8-luiz.dentz@gmail.com>
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

