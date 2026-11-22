Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795361624;
	b=X1eEzttsQod2RowRNhZP2IGxlAW+L/3M38bvERYSP3gQ2jtBenHNwI42lbKEVUKdPaGW
	 ucC+eIcReGyKuFlqumIOe0uOWvfGuAREx4fYHZBZQQsIrq+EPRMDh6tQculvYWfaSvOJ2
	 J1z+VERxNomisciVrqvSe7OZI1v3TmozIro23q8jtSDm+s86aPV+KxFaiedVZXHQBRQDJ
	 OvNqYpmVVKAtduOc88zDhrvLiE3ZRS3Ese6tAPOjo5t+6pyT4894STfGx+wz8ZG38DxSf
	 JgSTKrA3H4TNctA6avEIvjdguZMNEh81+oEVGFbDYMmz1ybHLuYDYO86MSVK6k/aO/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VNhrLeMQi1G8zIKhHumRyKLFuM94ixnQkExzmGiNI+Y=;
	b=odsEUZTvgt94fKhFSobUFyW1NI50BMEiSrvPpvhOgpCt1VmrXWEsn9OUk6qtBK99csNM
	 KpB4GNuZpTPwUss5WcE3e4qyOQKyWbW9fhoVFm5F62b8WLTT1wTVVXg+O20Ki+X+aUZRm
	 2SPYgEzM8LzqHLuDGpN2LUF4q6U/C9QomAV43NOuMkEZfzxKCcFerJ53phqZmDmu57leW
	 9XXIEavU5EFZiWad1oF2Dw4gD4aiVqvrZ/MrgdkjIb41IcA+Z+vwkcZexyJE9jptRVYjs
	 RFihDmwWfB7h9RKYducJXcW8/cU6f3bWiNYaWRA5sPo6vCZ++4eNRCkvet9QZHc9jxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dIvPbp8j;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69A606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA69A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dIvPbp8j
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb606491faso13376655e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 07:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795361622; x=1795966422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VNhrLeMQi1G8zIKhHumRyKLFuM94ixnQkExzmGiNI+Y=;
        b=dIvPbp8jir2dz1Ep5APnJ8oSCRLvhSdSyJj6uell7EeWRQ1W3/UkTthopDC2sX1UpN
         /U5rUtUv7Vk+iu/ZBx0dihMakrXmMYnodhJ18ooH4ewOzOM/8ZkpZtouXk9yTNszUC06
         jMCdogGUeY5WfQndAMB/aw7uQTjcAoI9ZASUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795361622; x=1795966422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VNhrLeMQi1G8zIKhHumRyKLFuM94ixnQkExzmGiNI+Y=;
        b=waG9EEZWyXWdI/BBQ8D6hmVGFVtaPhpPNwg8rKdpS8ZOUj848s6CtajmjpdbGoXfX9
         aeXyI6pk3qR+O+SwRkiQxNfvsvTCba6k+J7/AqtU3OozXAI3W0NQltl1mLCI1XEcJxGC
         kIMy2qQ/ZeV9yswZal5kPKhjyw/adhhSkhnEp7UPr810oFld25b1h/6ygHewEZJGBMTw
         j6Qd0L0gHDup6XiKVlVY7HKRWmFHDVXHMIa3Hpfrz0WBb9/A13I/xuzh2YvU1uhWGOL8
         rqqK+8c+vyDqUevHtfZhuTSGoxhoGdHTMvzwySe748n49r85xc6/1rdd6mtYJszx7aaP
         hJWA==
X-Gm-Message-State: APuU4Z89i58DHlQLQVvlCrW1pq6nontvzZspGkpjC3/91ZyA5yiSNU1z
	orO0Qta5oKXYPQgBLhMU8UUAJZqZ9KR1zDv3LjeDqPxWl9wENFEeTOT44KJw6euUycpq5EMTuOh
	9lt0A
X-Gm-Gg: AZFdTZej4VoAaXHZv0C6Ev3428ysHgkf5QIL31qAD9qavSa0dqE2PiazgQ7zVHnCqLS
	/RYFHD9SaUO2xvSbaaPG9x1bZSxY53wu/eDvwrG0zQd3TI+OLaAuEgyH4dBoSCMz8cmvnaBtlqB
	e6SFQBypE6o/dLAuec36PlqsuxAteIPY30IMW5yrcjQleKZvHVsXL5zCqbif2JKVpu4HPxCcvKE
	hjFL1lHc9aN/C8gYWIvLBOYFdkoT2lMuX19LcBYZxcVEjrQbisSPd98zjOCAVda1rgB0mQ2S4hc
	P6d/N05XakL+6Ks0J818xbb9n7/LvT9Qgz9HX9VRXRaKBQ0IOCu5awBE5uEkpuZmpwAdHOfqRub
	1vLDEnG5cm0TI7/MnGj5+mD/RbcjnN1hMLkLSgfwxHGJnhHDZ2Chn75yWgLlE7ND+UJfvvFPESk
	cSOIoJJxhfuqe/Cy3DJdJix78FwGveWL8foONtQS5kTYiw3ZRHKdhAop65u4IOaCQVHuxeHU9Eq
	SEF+tZRhfLwbElbfiyiZxcLlD926P5eF+8ztFdRS3Vh49voNu9wg7lXrmOGwHZQVO6e9szZwYcv
	l5SRXiGymw7839HzWtP1G8kc8OY4U9OZUh/Ys4dP04lpcFn3Gw==
X-Received: by 2002:a05:600c:5309:b0:4bb:62d5:4ab1 with SMTP id 5b1f17b1804b1-4bb88924a5bmr196948905e9.33.1795361622401;
        Sun, 22 Nov 2026 07:33:42 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906e4ce6sm117081995e9.4.2026.11.22.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:33:42 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: SMP: Check the key size against le_min_key_size
Date: Sun, 22 Nov 2026 16:33:36 +0100
Message-ID: <20261122153336.1527432-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

The minimum LE encryption key size can be raised through the
le_min_key_size debugfs entry, but pairing still checks the peer's
maximum key size against SMP_MIN_ENC_KEY_SIZE, so the setting has no
effect and a shorter key is accepted.

Check against le_min_key_size. PTS test GAP/SEC/SEM/BI-10-C needs the
minimum raised this way.

Fixes: b1f663c91c9d ("Bluetooth: Add debugfs support for min LE encryption key size")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2538096cae06..3d914da84d6f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -714,7 +714,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 		return SMP_ENC_KEY_SIZE;
 
 	if (max_key_size > hdev->le_max_key_size ||
-	    max_key_size < SMP_MIN_ENC_KEY_SIZE)
+	    max_key_size < hdev->le_min_key_size)
 		return SMP_ENC_KEY_SIZE;
 
 	smp->enc_key_size = max_key_size;

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

