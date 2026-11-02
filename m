Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643184;
	b=E1rvtqdObiZHoXH3iDiqDO61SyNDORSQYaAt1VHIL4SEQ5m/qBU6KFAeecADAyQ6sm6r
	 5WcGKc9IsqwBBTs8En3tMPuviQ0jAMWyd4D/Iu9hXllmuUa3ZghP+u4owTOxi9g28LIg8
	 YgkutC14myaHut0Zf5ORi+ebpYGnGN4vtfJ0TjX4u2aPb+LQOXiVFPnuMIlCmgBgeFXHf
	 c8GprFToTILttkjaSFHlJOisOP3ExdlILeHr3R+Zevz/CpAbTqYk/SCDl2zIR3J+DRV5d
	 8xcAx+MdrScVTyPjd4gaRj4RyNfMGABY4wSbRGEO60CXS3pz3P8pAtAUh9XsMnL5XPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iKChSJcCH8kDi8fprfSf3ufg9YgZMyeze+5SvKdpAEA=;
	b=x1SsmKjM2sLfm15xjJeNA0X/Zjz2xwAgIIy7TsPnSYGiNokwOgUG3z+5BerOt/YFypmG
	 nNzqLFUd4M8OPnZtupruubgSWSAcRXzcJxCFG0jly54Lvms3QqQ87MqkQUxIU3JhPjgio
	 kKb/SZdkZ2bcBf01Mx667k4h4CPSxa0DR0g07EA/tOSp3bDM0w8VDV7iJrOlSU16w1fhr
	 duJ8CLHHVrWoO1eVWQRJ03zNV67gWew9XygUZEynpARRonoZijn3WcclRQYz1tCouy3Z1
	 jh+URYJR+d7OkJus8Ta6fcgREKZIV2rgf+IlHZY2iNYNi7dp+0GnbvM06WJNf04uGrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TaLqyutu;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E56606D807
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 18:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E56606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TaLqyutu
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ec6f271883so2159907e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 10:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643183; x=1794247983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iKChSJcCH8kDi8fprfSf3ufg9YgZMyeze+5SvKdpAEA=;
        b=TaLqyutu3ZsWjViS0DaYsdNqePQSZ0K8hzdc1b/jnW7L5Gn00KKPvr3lKTTv6qgPQB
         97nnxfGG1k2ezy/HTdqwusOdZ4+wisaNJidB5XGTtYORlHu4tKOK0L2eDa18+PlWGxax
         UJdK0pkGCaH9OX2o3wGNvLBrO7Xbckd40N4YV4pUWN2ViRTao3aigMUPyKc1A6Ogco5j
         aKWuMhDxFDM/8AoSrASoC/w5yzb30TFEA90nsxXnsPTyqDXWtjsAXPNNPyx2ZTOT/iKU
         r5mlK2fsc54xThvPtIAaRgKGzkyRMhFhTQeD2TV4pbEFElEwXdPfBTDZ9lhCbwnEyKaX
         5PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643183; x=1794247983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iKChSJcCH8kDi8fprfSf3ufg9YgZMyeze+5SvKdpAEA=;
        b=ZAEbMhi+vCIvzPMBnO64giymBX68N4rzB1OsuaJXpJssJtJC+BJ0ynkDuWW1VzYQwr
         6alIVih5eSRdtpAWdgBXWpBGZZg9ozCReTDfkY6t2098ZN789ERSJqpD3tKExzBUqKto
         I8QUrdpIslRXrAyL5pYAIBl94nULDwQEMBYwr9bN2SItHyW+JI+xCQZfh2qKKp4Ea3Wi
         dxWWHqbLxwdUUwrlklMw3sTPgXUtZYTipLBTso8u62QVz+7K9qtxEew7J1eLhEHOB5rB
         +VYT9zKPGnckfDOBtq1meV32lMAW1pYuS5GFSN+4EM4JbNOUklbpYw6cvVGYFwKDGKTg
         n51w==
X-Gm-Message-State: APuU4Z8KdEVDgzFp6onoXchOnltTDbayLGzh7aWVFmVd2lRUf5/4MDyt
	qJNTIc7whPf6TXsSP0FfHw8zBD30m7A1/6TYZ1Lm15DjcB7GlWLgSvOh2l/Y+LMS
X-Gm-Gg: AYBFou0kfLerdxWclmT/i1HL/BGe5DpKxgJ0Ck+GFqAPcE3TXpGupLoF1lWyI3niI2m
	zyttwOfqnymOiEV1ogIaa2EtXxj3NvSRfjEMqiV9s6pF0IJ8FWt7gKCVV/mtkiAHKeUKAj/yZEB
	7f61e2dg1cgKG1SWcvYR7E8qJHibkOlVvhbvGNgGxXntwqrvmBnmaBqR1rvCOpkg9GMqFFi9sBO
	6zRJUQtnUnxC/Ne78tkbbJlIz+9zFb68phnxX38+fsMAJGmk02Z8ozZxHIHMZvcquiHx7l97h0o
	EE+97/3Tivu6shmS+JIcPvfo8w+X+oCirxdsvObnYDfW7+qZ4JrsM9CJPkNMbqvgdi7v0RsklE3
	/fKGsWWBdNU0Kdv55rlZnygfidkeoBftA+5CpX6DOx+LMl0DzFtsZhbgcPW6SaxuK6S5yzqUM+9
	922onn5P4Q+IubA/Va1nI0T/JKg57oXUlK96+eVFkyo+zTc7eQjgQYH7/U4iKJF23aeOFXpHqvK
	3KAp0gN+CyUuccMuwz/+/sJSqTrjAoZb7qRMuUjNwX0t3xm+ViKiwn4pLoI6u8XbvD5/k0NwxX6
	GBOvLSFXd6GIgX8eXqSvgJFxeDafSv4Y52aQThJ1sYOn1kQYsHYM1KDNp6E7kp12Czg1XBLuf4O
	PXlAoiYnZI0rsgR4sw9mOVHDnx+dgojbddtywPRsdXZukpoZwZYhpM5j5uJfBiBz1c6gPE81s+h
	jQyOQM5A8NDcRkQyCHbXqlYTGtyQ==
X-Received: by 2002:a05:6122:3b83:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5ec689bf92cmr4393670e0c.22.1793643183456;
        Mon, 02 Nov 2026 10:13:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm10300208e0c.7.2026.11.02.10.13.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:13:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/6] transport: Don't disable desynchronized links on release
Date: Mon,  2 Nov 2026 13:12:56 -0500
Message-ID: <20261102181256.2321329-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102181256.2321329-1-luiz.dentz@gmail.com>
References: <20261102181256.2321329-1-luiz.dentz@gmail.com>
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

Releasing a desynchronized transport also disabled its links, which
are acquired and released on their own, so the other direction of a
CIS stopped while still acquired.

Only disable the links along with the stream when they are
synchronized, as is done when enabling them.

Fixes: 1db06505df5a ("audio: Add ability to desynchronized linked transport")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c6b675f0b6ec..285db0d37554 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2277,10 +2277,10 @@ static guint transport_bap_suspend(struct media_transport *transport,
 
 	bap_update_links(transport);
 
-	/* Don't disable links acquired on their own, they are disabled
-	 * when they are released.
+	/* Don't disable links that are desynchronized or acquired on their
+	 * own, they are disabled when they are released.
 	 */
-	disable_links = bap->linked &&
+	disable_links = bap->linked && !bap->desync &&
 			!queue_find(links, match_link_independent, owner);
 
 	id = bt_bap_stream_disable(bap->stream, disable_links, func, owner);
-- 
2.56.0

