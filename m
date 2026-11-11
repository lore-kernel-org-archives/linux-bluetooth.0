Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429468;
	b=T3rs6R81uSrFu7c5JtGlWA4/vOJAyop6K/1QU3FIPQokCfY7tkDqXVMXEPVD1GOHl71B
	 h++UOrFp6yIdglgRgeZnFdcfmRw0SvsKMRr8XXnubd5/p4/GsB+wchDZbmWUVXaXy1OKo
	 Bu40vgeSHuh0ZZLO2Iqr/NOs0YtRUTcnFPFgkuf6HynGyMwDGrgMqragXiAZ51R0KYug0
	 f8W6QcJpeJp5E473jn0esYFhm3/KQN+9wl9DFo/8fsGSFcYA8inzJpYQiKvi0RFbihIQ3
	 Ws+dQllhCDanF2w/2cSTW+0+ob2Hzg5jsr0VlOmVCeMkVCDrhqsjKdGFPxSaEj753Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o9qmg2RqYElBRu3JKpcJe0VP5NQ1tOZdw77hufv8gfo=;
	b=hh3koIyYz6isCV4JLL1acQK3r4FiukXIJLSwfjgj1dyAlaugPv3kn5dBwpH7bfFKH32Z
	 BPWAZaGyrJquZe+rb/qtKT7yzb3gVbiAbV5PlcoMkyroFZj1FWK4zIMw1aqLUWhCmjgIT
	 4AWHzPgoIpBXmfW+0AB52VdMSo9oSCuZa3nC/g+U1TaRU/8QPnpy9DVWafipTc/5fztdM
	 pcorIDONN8FW1Sb0x4oVXMEmCmhnGur4yS3pOvOr0BtwNXJVzWXjTLcIsuOOp2MU0bWl5
	 JgZwA5q9gQM6r3MYm5vAsHImxpyGaofrbDypkpHaan/IdLJPtnImilamgpR0hKt/C2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WhUSjFKB;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE647606A8B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE647606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WhUSjFKB
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9903fde8db8so955582241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429466; x=1795034266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o9qmg2RqYElBRu3JKpcJe0VP5NQ1tOZdw77hufv8gfo=;
        b=WhUSjFKBKSRkQuxtYorPS2AqwZR5gNy0QzL2cEIUX9KbCh3EOG4kcLPRkJhqFiiRUy
         HYuNVnKOrKn0Xjf4sKZ7/1z1kiUKyKtyIHNN/UoPsIkKEcXFUlDvUB5xhLGnotTyZ09+
         rL+d9X5doS/g+1FYvAqqBgbn9k7Eu5dWWr2wiILBKiEzeqXHmrtiHHmR/3wY8lxo72wb
         LavX94Nk90ll3+sWf/U4mvDcRjd4jsbERi82AUZWqKWbHQmW+1So1zN0tN/PeKMuo31/
         L8OnDWxXw51kJWhLQoSOTi03nyIeHEFmyDSRD3ENttvyere11+qi7OehZV3KfCy+5KKA
         Tk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429466; x=1795034266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o9qmg2RqYElBRu3JKpcJe0VP5NQ1tOZdw77hufv8gfo=;
        b=R1Cb8KSqJIzGq7l8xg/DOXVJTKQN/9E0+oMPgu7aHVBMLVT8F/Vqr3I71ZO/zJDX1C
         BP4noepr0Llg5yz2CcUx03ziIm65benhHdxT+dRLYwXZws/vQd8xvCMhxGnj5wZQ+DB0
         u3oZVZsxWjdkfahg/6vUmLZLtbpq4ln0wrBVDltb0I3qD+j3S3mJOn4mxIKaDVeOjZvp
         mVV1onspMq29lFpk3vM+7pb/ZnAS/uhWtbQqmRVqAPz/L57Ni6LnMDm/g0nybEb7xCp0
         jZt68f4onMCoFOjegxEdGho8m9eaJuBfrsfeqXkOSHh5TCqAYwtCf6udNuPips4PacVh
         EsMg==
X-Gm-Message-State: APuU4Z9HMuujrrSe49m0DL5sasWDgstlyWhRV2+KYilj0ctf6bpV9vx1
	mSFBCfHmjEt7elz+Av1kol1JLcUZ58TpMaJ4RXNbkBGId37WiQvGZ1UXCf7h+Q==
X-Gm-Gg: AYBFou1th1pGfVVl1SyplQuvGkFP96BXCBh9dg033etZRLGzgHfSwQEKFWXTms1HXCx
	iqc+DVc9gM0RfC5PvYBym9sqWPrQSDbqbgm0H4W3i5SyIyoUXgiXxz4MQ9ij9pXdL5+U/jPyIyL
	/CGsqjIUxVSFkmHsAlotONWzwV3NGg4TZFMLoPCO33QPW8ZD8SrohbPK/s/j7al3GbJ4iFLxPSq
	CM+yKjSgBlRqle25d5hAKLjUATxq/U9wAx01noi37ahYGpFBkhWevwdsqg+EfZXcIOBdpIZITm4
	2G6oTRfvfDhVwwMe638E3kyiVjai1ijGZ9iNLfSKzXk1YIf/Ah6WEKW+VFuH/upaMeLt+SrKKZR
	i6uhkAqyacMzgNsZyMkFNrke8Ah88tu0K0rxcqdoKs8UcTSfH3SoZXmWSyemUU4+huthiRXgUbS
	lQVDbm+I3cy7bfaLCZkN3Rub6lIGOoH/+2RAD9VDjHE3Ey7JKZ7Y77+E/TAZtS+5/ViP1DdrLiV
	W9epC80Mgkw7WztkKS7BRsc8bt56eeJFJGTJTqHwl9+6q40+2zRshtJxsSv9W0abtGqwI99iGBa
	YZaLOrxEO5Fb/jh4NDYNCrWehNJ3NZ1x4tDemI7QnrEDsNGknm04NSl3Z5R1UYzJEb5IomM0SUO
	HHtCt+0gsCPmmh0SE7cgBAPywGcJ2HpAzs8e8rTfk7lGpBBJZIp0RT0w28iZ74P1DKK3/U8a1UH
	3UW/s=
X-Received: by 2002:a05:6102:8097:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d50613ab82mr1432911137.34.1794429466595;
        Wed, 11 Nov 2026 12:37:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] shared/bap: Hold the IO of a link when using it
Date: Wed, 11 Nov 2026 15:37:23 -0500
Message-ID: <545f614066bde3e411f796df3f4ff3f14119da9b.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

An ASE enabled again over the CIS its link kept uses the IO of the link
without holding a reference of its own, so disabling the link, its last
other user, freed the CIS while the ASE was still streaming over it.
Hold the IO when taking it from a link.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 37d14bd77c90..5b892f370936 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2794,6 +2794,13 @@ static struct bt_bap_stream_io *bap_ucast_get_io(struct bt_bap_stream *stream)
 
 	queue_foreach(stream->links, stream_find_io, &io);
 
+	/* The stream uses the IO of its link, e.g. when enabled again over the
+	 * CIS its link kept, so it has to hold it as well, as the link may be
+	 * its last other user.
+	 */
+	if (io)
+		stream->io = stream_io_ref(io);
+
 	return io;
 }
 
-- 
2.56.0

