Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946839;
	b=msR0XBF4kdfAiWPAOVQVqNhEKWRL+Bz4pFu4Qh+gY1dIZWTl5qs5tNxPw+s9NhlkIHC+
	 UITMowhn+JQIjWgFhxjdtx+6effR6EzJk8K8zuQP6HeiMNnx7DCpRdRg5EUmbvSdKk6Iu
	 IS4aElkWnK43McQRuexxBnKNus+M8MpEN5IjEpybVy23/rxxxMkjaZph38piuviXf12iY
	 NPAH19yuO/jtKeduVUJa1Tu0ogLcrWjOfeGtMueJj4anyQte3ASvdXBhUT7TWYGgUjBPg
	 rWVpAWleXLV9veWgaN/X9AeqDNlxKsAxMfKnil5ZgC8Q1tA1wWEr36/wYFEgOqh+t+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
	b=zR1oA03i3LCOhoEnag4c2mCON/63lDODEhLEC8yb3aSwQJqXbNmS/SW1OIrs+Bl+J9DQ
	 liD/6wXHn9yeH6XSKYOSqi7IUg1QlEpXsGcOb/O/rtR4ruokQh1b61RwdeCo8gFrQ102y
	 D74GLzDgvEYpORMVULF/ryCIejAeFClOCPOaUfS/Gdv2zXDoeyWTvzuQYms7ngGK9t5ZO
	 z0boC0w/jrlMkzzjxIqAHRiNBZH6djmQ1vhPHyl7HxkoBeBTMCWFOGtmC1sBZ+Ex1hHEH
	 VB9DkKXRP13eEjD2e5lrTLT54V3vS9UUCynxtdtlqqzUQqn3Br8Na8V0T7jpVdqUMpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H5PTOanU;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E3606A339
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB2E3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H5PTOanU
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so135002241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946838; x=1795551638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=H5PTOanUbDPszqx2PZhxuFZENvhVS45DLuPYE4vED3V29UuZenVsYEKoFIlR961E4C
         HNwUXVjT76NxNGvQDy8zAG1yjuBNbEF4NDBnNjzEdUnDycvXf3yECfgzEuNrJ3rSDkub
         GHAetm7nEBG6rjQxCw5Bb3EqJeNKuzrHAdQm+lkmkqaQF9CblKkLFG/DGRwV8Qr8zTmH
         9E/fbhipVUsU4gQzkRF0CgKeJK8mgRlKsU4h3oXPR8RVS52/YUk0iEFEkQLeYrursq2Q
         2uqRkmqojFZ/0m2CAXo5qJCALe0NfI/ezpddYhKebDj8xOlSDrQ0bJ/x70nzmPNI+peS
         +OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946838; x=1795551638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=rRRm8x+enuRe/ib3D2++V6aJhJkoBseNWfgvKDWwxY+Zp7u7lappvT1AYIMghZaI8R
         DJgjm+sx6vbmqjCec0glaLAtPpXDF3EsdqQ4KF5yJWZqghl4w6241vEDrcqN2dxCIq3u
         NDsNdLjxDK8zBFjyW3u+ZOQSnFHthJHkMYKgQqQ1oeN19sKeWMDNeFd0tWeWABS1q9wI
         AQivGsrtFCe5vVX5CGMrRIzQ0eSJdLWedQPidwjeeV4/WiSB0qr3jkhcR9+/XRsXVrL4
         RSM8uO8mAXklrEA2XTkhr1LVjo6VqskNEeaGuy3C8Xpvxn0pxWyaFk6hPJ9R2Y+6hkaq
         22/g==
X-Gm-Message-State: APuU4Z82Onh8htkR4tqHNFxuTE6NP80sFUWLU+oPS2Hq/DGVHkXv2IgS
	BA1JWn8WndP3wikk/uvy+BHAOUsO0pX9u3VGifJu50fi5hpWimdEbztsz16ydA==
X-Gm-Gg: AYBFou3x+yMZ2sUHqC+VyY8sw14Ua9osi/H7MD/R1oZgnBjI3GQLBMhAXo+tLzrwXgm
	ef6vE9V+lm/utYID7KeYo0r0ZRnDZ+ULYmm4XTpzGe0GIsDlKof/dkeeiEHrsT/eluQqXLij3ib
	ecuwOup4GZC2RuCrI36LzM7w1znaWbz2lt6gBBjNDmyVG+MDt9npLPajPfhXNQ9EBdqMQ7fIdDW
	Jem67/9wLpvxBmuledamSo6uxvZcVPNHICdAFSPJC/wimKcMaXUq0cN3Vgtv0/w8DaTRIUcK9ZB
	xmyipJixnKI8ete88zGQ9JysGRu0DiZSrjfWd0YQz4GKTTyxvTAr8x3H+vZV/VnmoHtDWk8Hwqy
	brxsW3G3OudZtPfNUFdUrr9BJXPalAQUBZlHdafKVRjUZJmbEz09JgD7FR1jMsr1j5N8u98muMg
	5lVWjKrG+1fJArd+WG0yRPRhnImUvXuTRPcCj/o++7Z4aijaMPWQgy+UH18h9qh6SM7FJBB5r8B
	7c0apUkSbSUMk3smH1FY5ofSlrKbA3XHp3EbRPSp970He8/z+d7jotU5ev9YGe/mO1h5WjGol8b
	s/LGitALczt/WbuqsgiPHs28Nn+KRZzyfyDOA8vOu+lw3UrQ5WkV2hWaAqqWLKn0FNDLgBiNIDB
	VdEcMUJoA0jdaSii4+sXHsxVIjspFyGE5bFIyjUckHQSnREdSnaHpmvY8D34If+NKwwSJO69p+e
	eGw1w=
X-Received: by 2002:a05:6102:f8a:b0:7cc:174b:f7d8 with SMTP id ada2fe7eead31-7d6ba19a74cmr78827137.1.1794946837883;
        Tue, 17 Nov 2026 12:20:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
Date: Tue, 17 Nov 2026 15:20:18 -0500
Message-ID: <20261117202032.3848411-4-luiz.dentz@gmail.com>
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

