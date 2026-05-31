Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEF1E492D
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780253640; cv=none; b=up+HCgyR7h9Slinc9cRHDem+31D2FIdvgOHJV9K8MYOAbzYvK+/JDxKvxlEo3l/AYFHYEpdQd1ZdYx6v48Je3oU+Qr5++4RucySyl3DCh/pmMnwQfaKjoSCh84pITjqqYf9kgVP8IbwgIekOsPtCKnRso6e/kEtcTOpcWsxEBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780253640; c=relaxed/simple;
	bh=tlVMrBxRS+UJLeASwMVg94vHLb/S8hmVDe1PiOuwpnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USElnGjLHbFTEZCykr5aJFeaaW2O5m8SoZVOOreEhOue6CpySTdJdWoKh5+TbFFvuKi+nSIb3t7C0xR+GiqgYNImkZv+gy99MTafrXmfqTCvaYI0SrWkIBE/9Xl9DkRbE3whtk980ALGOkhqwX69ru0TLvhndWalRU/adaKwd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO3nQjZv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO3nQjZv"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso2898510a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780253639; x=1780858439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCfnDp4TVil5GLFtV2CJjvE4FzB7iM9xNBhhS1ttWQs=;
        b=hO3nQjZvbcLcGpz2b73SVTnAw1aFawAdjyNvCVrgFb2O2rJCVmsPaipbeeTjhUCSGZ
         UQVI+3eOGeaEh+hk3j7e2lPyaf4N0Wep/CSMaEoKVrlXy+avmh/wKZQjlQBmnjPlHQJ9
         9KKaRUzIxYm0cZFiN0wwuiSCfTEg7VyznoKNpIu6ez+R9k33yxMlzpNR1JF7qWCYWG2f
         ePa8Ogkq8GzhaVmYS0MmjGCpcoD27akcdisqpmp8nZWwrifgRSgu+52Eadcmn18l28St
         Fydl3OB4rMbu4aqglrRNCOcfg7sgjkPlyWZs7NoLE7bCPIvaYM7Snk5Imr1xJSuO9gzy
         vRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780253639; x=1780858439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCfnDp4TVil5GLFtV2CJjvE4FzB7iM9xNBhhS1ttWQs=;
        b=mKlhHzysur0u7iUudO21QyW7xsLhf75Uz8A+TRt0TcV6uZJXuEPhnjWKUuAmvObEbR
         8Gs4ZRdgho9yq3dnGImduWc/Ft+mE9kb0qatR/kTNIDZ9K2m8mR9W4IHgzBZ2AkWilZ/
         UH99q9feQ4KCNdTeMMzcuxhs/YcmIt2y/J1jqbMcllkcm9JNeQNqKFR/NHPSRrAh+Fnx
         p0yDw74HwtYL0zeQbFUTWJlPJOPNeJgXgxGHLiyiV3ExCrLZDj/KCPP1j9eSVBANAGxZ
         9HemrPhfclMjvEplQ82myP1YVbtRvcIS+yXv4lQ9UraPwXIZEEotxtub7SbXXIykVSXU
         skuQ==
X-Gm-Message-State: AOJu0Yw9dMTTLKYlC9C4K/jmt9gXz8pRiEERE1BUFcLpY2tNLIXOSc08
	SJVPQz1zBMIjmJaSYfsm/HrCF5+GEAf9ivbu32KP6Xmt+0TSc2rvGhHJ
X-Gm-Gg: Acq92OFZXloweaTx6FlmLhX8StIOaSDJ/rshLn21R/j/VObPZs9HWADKOF1EBYMMSq0
	PaRRLs6ve3Z3oGjgyS9j6JFfFiEycObOdAFj093S9+SD3EdYO3HRkz2dPUWm3SReJoLJDmW4W8x
	4nCXYF3SsWffFRIfR9H4pT6QXF4Sq6D6eDOB7vBn4UW4c9EaD4f42RLr7SVlV8wEBfOBQXF22Ju
	5nBAWeH1owUTOmStVoJTXp7NMqg+7Zre5k0rVR9McjHWz38/4Nxm5IFsd2R5rQKeSf7PZw5Ufkg
	v1+rfeOqS62sOwk42Y8grQmxEPzDfvt6NgJic3Af1v/clUlRqFjQ+j6MuMp88KyD+pn1ALUgQN2
	zRl7K2bCC1b3IU/AlRGhMCYg9XR+C/ERYvPs3Qj1bMyt0apN+Arh0pn+V6Imj2hLlNAEq6VR/7e
	SuD0OIecttA2oKN/xwH4gUWBZUCHgi5PivYaDOFoxakjJ79MhWEiFGgMqmB69DUP6rHiElR620K
	lAKLTVkkPHaTzIVz6nP5H5mK0FVow==
X-Received: by 2002:a17:90b:35c2:b0:36b:8873:d96d with SMTP id 98e67ed59e1d1-36c4ff65291mr7107251a91.11.1780253638891;
        Sun, 31 May 2026 11:53:58 -0700 (PDT)
Received: from rustle-HP-Pavilion-Laptop-14-dv2xxx.. ([49.205.241.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36d654999a0sm5839594a91.0.2026.05.31.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:53:58 -0700 (PDT)
From: Bharath Reddy <kbreddy.rpbc@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Bharath Reddy <kbreddy.rpbc@gmail.com>,
	syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Subject: [PATCH v4] Bluetooth: fix memory leak in error path of hci_alloc_dev()
Date: Mon,  1 Jun 2026 00:23:39 +0530
Message-Id: <20260531185339.107188-1-kbreddy.rpbc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Early failures in Bluetooth HCI UART configuration leak SRCU percpu
memory.

When device initialization fails before hci_register_dev() completes,
the HCI_UNREGISTER flag is never set. As a result, when the device
reference count reaches zero, bt_host_release() evaluates this flag as
false and falls back to a direct kfree(hdev).

Because hci_release_dev() is bypassed, the SRCU struct initialized
early in hci_alloc_dev() is never cleaned up, resulting in a leak of
percpu memory.

Fix the leak by explicitly calling cleanup_srcu_struct() in the
fallback (unregistered) branch of bt_host_release() before freeing
the device.

Reported-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=535ecc844591e50588a5
Tested-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Fixes: 1d6123102e9f ("Bluetooth: hci_core: Fix use-after-free in vhci_flush()")
Signed-off-by: Bharath Reddy <kbreddy.rpbc@gmail.com>
---
Changes in v4:
 - Include patch version history.

Changes in v3:
 - Added missing curly braces to the if/else block in bt_host_release() 
   to resolve a checkpatch.pl warning.
 - Added Fixes and Closes tags.

Changes in v2:
 - Fixed a NULL pointer dereference caused by v1. 
 - Moved cleanup_srcu_struct() to the fallback (unregistered) branch 
   of bt_host_release() instead of unconditionally calling hci_release_dev().

Changes in v1:
 - Initial patch (failed because it bypassed the HCI_UNREGISTER check).

 net/bluetooth/hci_sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..8957ce7c21b7 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -83,10 +83,12 @@ static void bt_host_release(struct device *dev)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		hci_release_dev(hdev);
-	else
+	} else {
+		cleanup_srcu_struct(&hdev->srcu);
 		kfree(hdev);
+	}
 	module_put(THIS_MODULE);
 }
 
-- 
2.34.1

