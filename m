Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010723;
	b=Gz7SBwq/+hmtAc/EtTWpdNzlh/WpXCacZJ26etZCb3d1v8dpVf9bMcUAM55HiDv8FoL2
	 seS3Y/SDNsrF8Mm9V6e4vhQNU/FdkYa4zk4I9FJoAvAeKc/aSN9U3c7ygsRifY/mgaHvu
	 LLZ27Y5Oyic+s73p5RvtgoDxIAHqxrCpN/twxAYdkXbaomKYYydf7vRpe21oztjigWuJ3
	 2Bxx5sj9+ezALVjoawEgthf5FHHT9Q19pfKn8sobCjk9P5nFcU3i257s3rgZ75Tiydg4D
	 eVHle+4OIsDcbDyNIlakZq7PqUlsMHaWy0A75D2FCZMCy7pBetl6g3vBlST3ihHdxlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
	b=ZA3Vn5tEySQ9PWVjlCzUwtjHNaHnJOWCjIo40iaOXtPpctmHdlMMaZFBl8R0rZghp8Yg
	 A4RhIatYv/cDnh+kWzjgueNQYfK/LhJeRSJR730mm8jJ1MycUjjLkHdwajjOzMcWxxPvL
	 Q1AFcp/gPwWhz2MUItz/+0zjcXr1QUiY3PHVb2t8u7JTfWw1js/Z/4+v8LLO1wHV8sB3X
	 OnvvM3TPvPwwBQVITCINRZtXd+fPMQA+JEHto73PdzK4GdRDIpcb+AnCCi4rfURAj4w4K
	 obCqK7lJkkqMq2aWiRSCADeOn7iS02YQmgfMbjKQkiCq5yV5r58Z+w9qw96JiShlFLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQZrJPum;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224060A2607
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6224060A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQZrJPum
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99e0082c434so276057241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010722; x=1795615522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=RQZrJPumIFuq2KOicIXk1o8Fb3VllUOu2JfWDfW4ix78bd5AaXs9cmC44xZYRGcD4H
         2FVauRRsfnqDtn/G/XcL4ROe7c4+w9+duqtstx5OfOgAo2jmBHs6/2UgF4gINl8K3E1i
         baf97dI08Sz2vuE8AG/y2xYRplO1TWL8LKVQX+nesVB6+aPsfNTNWwOIj620qMqQz77k
         Q2rMH7pZlg+0dtVsJZPunERZ4qUqy2PDMXUZ6WqIVlvQWBoPUfS92zxTR80jUwVf1Od7
         tTuAmop9M4fKQNSoLGKlB4z6dT49r+uSWEcM8/8jA3LUAlbUqcOBJyvw4UWzM9o66yZ2
         54CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010722; x=1795615522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=Sodp8kQrn1xNFcd/1Vpq1qChScTLabB7Kz4+jUAvfSL/4TRlrPaI00Qj5BLDF6q99w
         uTd53sVeWaYDWrZcMKKfUiGoDyeXjWwYZ/HvQh/+HXPqvHE4SsYSGtwlO3aAHlfko+Vm
         sqKplT+IrcyzZ9Jkkz5SAwzRKVwNouhMpsiOnupazEV4H22sAwyrmUWVeWxDvfodNIri
         /+0vVYUAeAMzxM1uKMfB6UeS0F7D3wdrCvG+H4odZ7tQcwah3WDxnMEkK/7iCwpZG51D
         bNOvnKRYYSLq/5M+4n7gEjTN62k1iRYKFjJIdzqnj4nTN9WCfqZFX+jKTaK5bst7ij8E
         2EAQ==
X-Gm-Message-State: APuU4Z94B8BnhYVojft9IjXmS8oOJbuxz+8bIYoNi9o1bKapGBuz0NFt
	9da0LSAYiAkgCbfI/wRzej8ayfYBE8H7mJiXULBzv/LAdvZN+Ic8O6HK8IXNXxpS
X-Gm-Gg: AYBFou0kDogqTOtHjGgx0RF8VxObIrLbqlfgUcIZEkbNJgyTeX/72g3dVrdlXSWsXmj
	J/WKEz9jZ9F8k82ur2bbnksp0iyWNsXBZS2pS96sPGejjNLLnC5D4PVIP3Af2mZtW8NaMRGnFAH
	xfyxOoqYoiCvxI3tzMQEAM1jusq2EyjQh+58aSgzzTw6MyldU1gIdhv5UohHQ9jDnZbDNq2Lb0/
	XESmi+6cVwMkuweFmoet2JtDEK5DuggvdWWyRI3cTRKJ98JIkLmismedL4peCAhL+qm9yiPECJd
	2+yxvByzfztM2qTrcMvRzBWLlX68Ht49i2ZCshV7ssIgyVQRqGP6jGKretYoTvSvuBGwm5nFSzy
	K9f857VmUHyb2ZCZGxZvy+qy8YxBJn7ZmLljVEaeTk8BA0e5a1JCDvaXoVH37/Yg5iezVa3Or36
	DFx5Ku1wqz73LEE5tzvdjycOOIHI8aceRJRgFSDd0RWwLKdcnQIOdodc6dzPTxy56mkKZOXBuZQ
	uRHt4qSoU0G1ulchSd2dVv6YPTjlqU6W+7zq3rmXF4DrB1OO0VxS77Ur8DBBM6+ZvnJTskKhMOk
	66AAm6QPnO/I8YM2HkZWynZO0kAgGlY5qLc5piBnfbbfcD2l00j/4pC6VdVcExkWfq3tmjaKaBD
	LSk+Sk9Y5BlVgScvC/DI/57zjQvoHvP8d0ajdz3uER027V4wyI1TREQ/2epV3GlGo/uMnaeWxAP
	KIFUY=
X-Received: by 2002:a05:6102:54a2:b0:7d0:3ed0:c61d with SMTP id ada2fe7eead31-7d6ba198374mr732923137.2.1795010722181;
        Wed, 18 Nov 2026 06:05:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/17] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
Date: Wed, 18 Nov 2026 09:05:03 -0500
Message-ID: <20261118140518.59878-3-luiz.dentz@gmail.com>
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

