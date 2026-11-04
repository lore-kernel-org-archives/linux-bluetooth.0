Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830800;
	b=UtT/cf3MPfKIUPd/kEHU3nRraSfFPqxNtwrarOXl5GSvFC9lI0gLBavimRNfDg2nMVwa
	 tI4KzzKOdp/bbuUOU1L4qJ6Qem0vmpsfx9/ISoHJ2bKOtCijsCV3/8krmIiiqxAk4ElZH
	 vPqmYbs5MkMepP41z8dfibbzKldhXGLRzjiTuEgOLK4tAn/XCJTN/HS20YRi2vg76a2w+
	 YiiBL7SBq2hcmnG/T809KbFevh1fwUO2Da12fiKHSHgbtQfU8HlJXKtrP7Yz8h8bDB6N6
	 Xh55V/LKdwkxJdzC7Th+gKUgoZANMok++scqeL7MpYxepRkry97mDidfzuhNFjtXoig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cUPsugNSnIajBNJdltGay+cLFmUxWSRJCWHU5EPa4zc=;
	b=Udhvdj1TbV2pmhkU8d+rZu0aJ8elW/qoxVPaY9KzseZLk5fAzpgYYeS/wxGq/lX0ydJB
	 Hkry1r/md3YHYMUFDw4SWAPLLErFhnjWWyVJZPNVqDkJJAP5h8ltQJDPPZzuP/swmjGzk
	 J7lRu30C3/r00slwEvTAHtMm1DlNG5Zp7p0RgcTOilOnTgezWVKlfClD8RBXgpe0bvItI
	 yOcvDzdMlbIOgr+FonrZlaQgKn7w2bkb5JTMOHEiSrsR+wLGMdLTtkg2HZv55ZzTyI1vm
	 RfrNz4k59Te2TYG/5+YrKROH7ZuXKDWgJK4fNxelYx/vuGG+fvGLcd7KZtES7fAiuNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hue+Qlws;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFD606AB3A
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BFD606AB3A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hue+Qlws
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so214029e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830799; x=1794435599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cUPsugNSnIajBNJdltGay+cLFmUxWSRJCWHU5EPa4zc=;
        b=Hue+QlwsuKODm3FGwabeLSyCqBEbgQosKLD7WWRGW1oElmUqoI6GWeRux42Q2YuJLK
         odxm6Mj2Oh0xaGW1zRa4PnQtILOSrIDdrhlF+NP6m2zUYCKp2ael/fxr7zMuJullADQ+
         YxPNYrKjK7XQuJUcjnN2GL2JAohBCUJGLaZZPJA95cLNvzp1gtCXjBsuho8THihaPi3i
         b8KUahoRdAfRGO2bqMIClwYl8XJDi4LWs1dLrRLzRMMrYDR3Vyiizte+ueeJdAcZm4nj
         sjrRgR92NkCLwZy63eXECiA3dMCMoHeBA/8t2aDylIW9Y8oGBEi+3GaAIdKUc+WUkxzp
         Cc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830799; x=1794435599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cUPsugNSnIajBNJdltGay+cLFmUxWSRJCWHU5EPa4zc=;
        b=UImkm3G8O/Vib9M1jnDgFXJWlI43nhTLro5Jf59LeQmAOi9b1FvQQMG+DW3LcPi1Ne
         0qDbr3ye3SQE0khNyzX+7sRDcrV+CpXp1v1dwsbDN4hbZVt215uRpKGiFhPu7+Bq7l2O
         lUID5l2arimClyR4jtBcO/Dx8roVJvoOwXC5o2ZsoAzLsUdBTnpkovvmKbIrxWalrD7/
         OkRdpT1i9wezWgyFwI+8fsPECKkE9wxceKwGkzzn6Qqd2PAnBVLz/UsyY68O5zAZD6lm
         AouOkWF9AvHePPKDXtxf8WrrY0w8DIGJYmkjsDFghUNnBGlbU6R+y7B/lItUhIptQJBH
         Z9pQ==
X-Gm-Message-State: APuU4Z+gqaV0Kb9xlDV4Lovmgn5YCYp7cmvcE0gy6ac8xls7xse9MpNH
	V6Kgo5CYlO2kx7fzkaWdPM15/jhMQXiN2A+rcaP3qucAqlvkUfFdWGcJ8oyKqQ==
X-Gm-Gg: AYBFou3vbAFvWhus/5wcHNcK7ooCVHs0CjEU9tY+oeB0LXli7rkBdeHqsO8VM3QKJFT
	9rHMS9IjLdv3zD23Ej0ZMIoc2NquV9DcbqQE4qqy5nKsFx/czpCVstY7ovKgbU1JPyV8jiUdTsk
	vPEPN9wZXnGTYoSVvirtf6krcqpolwSvzMk1gFKg/NflXOhOFi25OIusyyU1VwF8lbY2swJqybr
	DUFRigaH7WfbIQ/Z3NtC0jQCKvRpieMYqxxNXkRXOsRHSOPnmF8mPWnD2POM4JsdO7Ou6wku88x
	MXfsxdZkQ91WUNyX95ZWb+LkRhOrBkmj4x7MjG3J4637XMVXJD2WRtojIsAiR1PqIsVIrjrzbVH
	tcgqAVK3yiX/lYf6pERQsi4EK/+cAsx6WD4nTrRI6gULdjeM45muuw326k+cqAqAQKPVoDlg5yh
	FW48dyYYnXOOEdmG1+6LaBuSW0B0DeQiP/O+aX/Q4khkcvSebLozgP8qrE7w3ZU8it2YmC/K93k
	epIV3u2R6BVJguUHKlfbmMkSguYeWgcSfqbl6Px1k+yuGVIsaUHEWb/HteeJg1D+031pvgs10QG
	ruErzwok4vtHunb3vhP8PB/qPQ6KGrKeKqegW4wcmsMawioIQ7uaacceknlbF7EaMA4nGsC6/UK
	xz1Wyd7664eLeyvwnDPhQIciwDgRxnU/5Gt6WwH7Mh+FaKmJSxKRg00M6WxuhQlChUbjif1lbf2
	pKk8c=
X-Received: by 2002:a05:6122:6081:b0:5ea:c6c8:7985 with SMTP id 71dfb90a1353d-5ec6851faaamr8137345e0c.3.1793830798780;
        Wed, 04 Nov 2026 14:19:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d7780fsm2775751e0c.3.2026.11.04.14.19.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:19:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Fix not updating of hdev->commands[] after reset
Date: Wed,  4 Nov 2026 17:19:56 -0500
Message-ID: <20261104221956.1207025-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Read Local Supported Commands was only read once during the INIT/SETUP
flow, but the supported commands bits may change at runtime, for
example after a firmware change applied with vendor commands, so update
hdev->commands[] every time the response is received.

Fixes: 6a070e6e81ad ("Bluetooth: Store supported commands only during setup procedure")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a52574003e4f..5e6b25eb5053 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -816,9 +816,7 @@ static u8 hci_cc_read_local_commands(struct hci_dev *hdev, void *data,
 	if (rp->status)
 		return rp->status;
 
-	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    hci_dev_test_flag(hdev, HCI_CONFIG))
-		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
+	memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 
 	return rp->status;
 }
-- 
2.56.0

