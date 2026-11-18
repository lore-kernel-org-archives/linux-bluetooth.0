Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017559;
	b=VpnwKKzEIJBFKd7WD2+fCcoPSBK2yfjjY1DGR5RkSVSPxQBC5ssV/Zbl55T4NsWEXiqk
	 5L9E71J8cl89OmJ/1srEsGPpRqrEq/xo5TXTeSevD4cpf11ovemsMDSvyFaJBIv5jn7C5
	 bC1xcVwb4yKDSQmxZ8gpwMV1RucIX9VfJMyp9z22xQhJWh9Fu/+yFI9TEpxalhuy7rL24
	 Rh/vyfdjdq//PkrFAsH1Ybf63lnMsNKxJfOxq2G6CeWHzeJBY0FM+LKMUZBTUarr1MJXF
	 Oraiu0CTgo7XvpMrpZ16/zE3ktywNXRps6rR8njE80fJjPK/LZN9X0EXWayBujD6+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
	b=cAIkS7+pkwKqiuOmuH5KHB53G7qhdxMqQC4Sem6vlF+3GBdkgrZXHYY1sg+ywybCuSSc
	 BTylwtae4Lr6DmvBRjren1vaNGgBPgXI0AJNzNy6Mg4jlFyAhGKrqW+VFywrXVg+drlXD
	 VC/dB5f2lKFIP2c6vjmxYbGGo26TghgkziRnIiptN+elEu1pvBFwJs07Ir74vbTijtXMC
	 ofZtG8ufuxuTY67St/xw4CiWFC8KID7TUOgmIAipz189PeVqkcLjOBIVqFJjIHRglSMV5
	 wksWaR2EucInG9InBv+8nFpVJqcA8iSpjDugc4jmV/bKgdXzEeEE5oaexNAoW6pJR2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TsDR+tPx;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291C606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5291C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TsDR+tPx
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9950a7530d9so554460241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017558; x=1795622358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=TsDR+tPxy9k+a63q2zl3vdkrborTCCj9NV4QAfeosnpGLQ//bUrOJhFm4IKWQNXuZn
         0wabAAUMe80s8nLPF+bmQgw9rGz6qVdz21DpvOpJnzlrcVxRQeDJSp16VJkhOM9R2FYV
         XdaxHtOuct8lPNQ5gq68enKNIQP5CbnlY0nWf737hNAoRVKgc7/L4hDP+V22AbdL7MB/
         2S8v4OSJ8kH0OgsDWTbrarG313eJk23lg4nKFx3mz61m+DVATOQ503ZLYbT7gVnecs4l
         clsHFp4GEciMWVIXxvFvvz+gX9TeFgNRO8LrMkzj9R8rScoq61heCcYWDFdcdvTMFFUR
         Mn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017558; x=1795622358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=j3OXeZ8OtFYw9SqLimVw8pwpDpHOV+ti7VI+HgdHpSt3zCZPVr38qrgeD4FeySGkuV
         cBRKXmD0o2p7zTWmUpbM2TJKc2BfZt4RcHAEbgfrY0GGcebx12D1EsIQ3blGxoTuEd9u
         N4k248EMzMYfcVPIAXBaOtswDkTRr7nF9XEqutgxMF2tg99xmlMKyAvS1kFq5UQK7n8I
         rGK8eLtMX8uwDQI8fWWVd8XbucsVx2IVRL1w+5ntXrGyZmqNZPWzMbCQh51A9r0sdOro
         Qm1l04NXOR8L1u3oHThxMOUKzLRc3CDeL3W5YlJbxsP3+sdED3b+KrX4qmqOWEBol5fb
         btKg==
X-Gm-Message-State: APuU4Z8mwugoAyYMhzcRZcyUxz3/Twp9EiOZAko/LxEL8SzUHGUua35u
	kGogrR7gjEVMwgBCAR+E/cpY76SZhsL0/m32b8kno8DQBegUMbrhNna1Cozaa+xl
X-Gm-Gg: AZFdTZcdLoHTLNZHV0MkIZqH2MvpiHx5FqNQMedoJm7QFO3Eo/097RKtrTCcxMCBV5E
	YRvO4CxSu4z6RXTeZ6BoR+PzF4VfTp5d4PBRlJDcduYRp/TPNpsuZa9/MKWo75aj722Zr+gl/A8
	80RyPX/eHshiLxEzNuH45Ci8pNu/Mgm4N4IK1ZZJ0OOWTJzyDLuf4dNfNMfjSc0CzfsgQbFkTkU
	pmgb/85/UzG9AgISseVXTFT2b2ok/6pmTxsjFzw0gWO/aXDQfG1UQ2OYyBWBVfpDmz/2Wa6rfET
	amavwfBmfpMHmND7X7CqfVO5vJTE2b/9LmLx6viY7rR0Qeg+YgHJPbVJM0/+NNHPDuPl5uSDsAo
	WM8b/vZ3mprM7P3q/GI93gPp/eRK/IGG2xdxOGlr6OAwrZhgxcWI9khtBCj6Vm9qyhNIMfMRLYp
	sR9nGdmPkihBDd7b3hPMkQI60oIZ23VbIf+FSD+SzXisyHl7cBQSR7/jIVM//7OEOMNd0zl9OOk
	JfqjF8TQtXb6Az4iwNUFuuuJl2inNDt51T7gD3GCcx1ox+U+quPFlokvUSSehVJMB8sbbl4x3Bd
	5gcyHMHzNxWwLfHbHb5XH1zdb5IR5qFBd/yMfbh1wOd48/Tn3P5eTPUfnPuwMwYvJXY/mxt0HVR
	lfsrd1t8GLscgdVh5OhnNQWPVD8GjJQk14kM+62SbLOrCh8+8gXYNfCwsHwt2DEuZDeME+Bp32l
	sAahc=
X-Received: by 2002:a05:6122:218e:b0:5ee:19bb:f8ad with SMTP id 71dfb90a1353d-5ee64717427mr1556717e0c.17.1795017558102;
        Wed, 18 Nov 2026 07:59:18 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 02/17] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
Date: Wed, 18 Nov 2026 10:58:59 -0500
Message-ID: <20261118155914.178050-3-luiz.dentz@gmail.com>
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

