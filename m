Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029086;
	b=4zzVD6hmI83oF4LMinUxibgS+FmJTVLbJ7aSZ3ebpygV6m10EfvgYRCVfA9/JVEd+5lV
	 vJSDFNVDPfUWGyUHdoVFYP7r8POexOVMgjJ9bNnIUVeZp9kaAd7iroal1TBt+SyiTIrej
	 kFmmPmoNoSoOYPeZ/is/3UBavJDw/rrV4iiyoAaT+m4TymDldY5UvyyJ7EOUBI3lzejZc
	 Pbz/iKgYxlEG8WXicXKrso4RbWQ8puGFB6ORz4CTGCvy+246J2vF6hqQQbuYscI+iR674
	 ncH+938Gjg5gAiL99HXX83vwcLNwxzqKhIVkARP3dV6pSS5VV8EKePsWFPtPfoTzQNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
	b=JBXq2qK3JbRlA729dOMxQpCH6cU/et5H2EEcdjWzSPJMQSrmTyAdMPweV0Gfkb7ZeKl9
	 2rLwDFGRbTcEChHSpTo+S5scfH8fIn4UxxC9d1HES9srhiLTijwz72LLSCV8BrbBE8vnz
	 a8HQaasTCmTbAnEHsmFgBgzdX78DLSvsG4POnErKoFuUXbOMUV0R+Iwi2CHD5yoU5iMIZ
	 4v9tPJ5W/rVFA+dEd5PyGZnsf7pnCnKdqNlsG+ZAUPspw20FZ7AiQF4cNubBflgvUgP7w
	 ph67bXIXdtyiizUpbz3bWs6yD7P/L8a2atIKV18fsS2SI4w7Lw7QzSmF1y46Edk82dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rKhK/mB3";
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3C606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2F3C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rKhK/mB3
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ecda93627eso408950e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029084; x=1795633884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=rKhK/mB3SKRmaaWjBg+VXNLmHbpyE0nMN0vNKX7wdPFw8keDJadFQTy94CGWSEl8xx
         Yh+78EJ1bL1lmK4Bjn+KU7qjPlicncaDSDRWEcQU90dsKyvBcndxzvnLS3nkUrnprrbO
         M6Ot/vwDxwrDkZ+f0tb8uze97LQdlGOwk8YnI2PLOtsnp5aBop9mWLHUGe47YnudwwKe
         xUig+ggsfgbACG/R45ayg39BKH7OuNKJA8F+TdTy5GTIey9ejEvF8T4UDzI3qa6ewNYB
         +F+SG2h5j5Du+5EmAyEXhP9i4AXPejMfHEVU2B6gFme5UQME4X8lzGncwdGr7duQJ3I9
         dL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029084; x=1795633884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=lZlEAyXZ58FbZKpaG1AHkWONRIEcsCC45pTFU507LewDroPlXJkQRS1PtF9xiSYX4g
         ggEshnmxMtkZt2zDbjgoBVZUKIQBhgoQNpHROcGMS3PX37nNv+EkxL0Y3MuzV+bMWBnI
         lr7H1JI7I38NGooSj+ucw/r8pP93X8reGiXrMP1Qbm0iXLd1WMAdnjJY6/cz4L2xITWM
         JPmkzIppsCazJjl+23V8BswGQshVV/ALGB0SDlXiVmaNDjRQ1yvJ6qTpWFsGkxtBHjC8
         XweHo4H2pm7eXOTEPlPaLuKgfnNat3nJJc05NdGD0hJy6X98WOgJWN4q2zGDtPPdd2FT
         LdOw==
X-Gm-Message-State: APuU4Z/SlK9NJTBXT69AxhzWG4w9j59ukg4khyLLBznNk1McelWO77tc
	HENMqpSIR+fgp8d5KkXzuHEubyHPmB6PVJ+d0aUvi+dmzhlIl73YCcINlpwECP4Z
X-Gm-Gg: AYBFou0QkPzW1aMavTIwAXVUORuqVcm5r9sgfewiSuCM7yfGfiCXQUOmRQnDv5hZ2Qs
	iXHebxQ479qqYbc5Oqsou39xHeH1y2NxaZCT7UxBwDTBlKB9KHYhzTy1B9/AjKU021n/8ev6nuK
	4YnTkFqk/o1QDVWGyIK7/gt64BVTggx2ahXOxCkrjOPMmyhJJ3AQ/cgajuoZzlyXQbWC29rqwEL
	BPqYLOv6bLX4dvArp5w68ErrmEBafK43yVLHIyzRRhdfQkTdUMjfAzsG8XSTUQfsNJya4IChiRD
	gOU8XDdEBniYV1Jhm8ZoxryT4tRdurFem9nGYaILo0389vscJP2TC25eSonQe1UslJMPw+FLCM6
	Q9RplfOieTURsPW82EdxoyDynUBLIQQmsUyTuf3e2Xju4I3kgZp9bxgGheC9+KcBUZZMBLzCau2
	yVYpufKeOJmCyXSdawC8NDG3xxICaS9QF1YHlQOJPS+/t986kRYpjPQBKJ/LQ4G4b4M1lFgpuer
	AqC7MWoR6mbkB4aHI4D/Z4iq2k4NA2JEmABGNjahnDTb8Uyjov2mr3JaNYrVt1qI3o4GaGgC4th
	W2I+iTyf/vKSaDkUnWL1N8GkKXF2kHwhS2Lttxjw4Im+TM2m4ydTpyLCcsRfcAI4Me5SgI8qWUQ
	mHaKaBdLsFsUXjArvWcFeLFpfcmlFsZdyfCLfEhFB3Lxv7TwrbJxSHzvijG0p7zkqs5vP7wT9YQ
	0BVg4=
X-Received: by 2002:a05:6122:62a6:b0:5d0:e3b7:334f with SMTP id 71dfb90a1353d-5ee64742a68mr1706481e0c.18.1795029084579;
        Wed, 18 Nov 2026 11:11:24 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
Date: Wed, 18 Nov 2026 14:11:04 -0500
Message-ID: <20261118191118.318779-4-luiz.dentz@gmail.com>
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

hci_disable_ext_adv_instance_sync() calls hci_find_adv_instance() and
dereferences the instance without hdev->lock, racing with the removal of
the instance. Look the instance up under the lock and only use the values
copied while it is held.

Reported-by: sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3fe179d649d0..9cbf2e3009ac 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1226,16 +1226,26 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
-	struct adv_info *adv = NULL;
+	u8 handle = instance;
 
 	/* If request specifies an instance that doesn't exist, fail */
 	if (instance > 0) {
+		struct adv_info *adv;
+		bool enabled = false;
+
+		hci_dev_lock(hdev);
 		adv = hci_find_adv_instance(hdev, instance);
+		if (adv) {
+			enabled = adv->enabled;
+			handle = adv->handle;
+		}
+		hci_dev_unlock(hdev);
+
 		if (!adv)
 			return -EINVAL;
 
 		/* If not enabled there is nothing to do */
-		if (!adv->enabled)
+		if (!enabled)
 			return 0;
 	}
 
@@ -1248,7 +1258,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = adv ? adv->handle : instance;
+	set->handle = handle;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
-- 
2.56.0

