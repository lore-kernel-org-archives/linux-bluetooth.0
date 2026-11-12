Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443873;
	b=NXcAVZ1EMWL2+8gkg9wy/y1gW94i29h+NT59ztVrM+aIyckt9r/maBGAQQzuAoyZXHKP
	 q52FrOQIdJRjfYFr0kQrCRA7XqSrg1tuDwBxUZh0cAeS9HJJlBH7otI7P8IdqMK3E1yz5
	 9QIo+wG6x/IwDq8zMbFZHfteS0TUlCo5VhBktfYrPyIkiYMRGzC7CCsssnimEu3yV6HuK
	 lnjGEK9eptm1XsRzdAmUop4KAW9nQPeygRu7ssFPiXW9pcLYhRB3qf3dtng3rZeQG4yQr
	 DroU5p5nFMS4nEJn2dbcqOimUNsNJikVToZ3cm503DVIOwGr9rZNgns4Kg2Y3BFd4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ol63YfyO8DZtQrd6m6wcKreCNbKege3vtcgskM5PoLo=;
	b=yACfmxGdg+TeqD58md82L5ZVyUZLACf/uqJz+oz6ED+3oDL0ZfWG0WGXYav+dBhRnkCi
	 Bt1TuwODosbMcKkP4nqaydQVRQBX0U0ZCfkCGZm7QY183aFN8Ah1mrYKix3OUsCwC0sAm
	 DQTI+WWc6r81m1/IybLJQlszaAHkqQ19R6Q0spHfgGfe+Vz4QeIQN8OG7cXnTdrD7IrSC
	 KwgO27QnQ17xkYSbBYv3KdsIrSr6dOm+grH4+zt9tjospGLQa7jrt8TGnG25wCD/dDOw3
	 VqcaKgJI+rKzSvtBDPRbz+9QiTrSwbYMjdCTuBa7UB9Fu4idOUanFNZgaV6NAUHrZFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sA8fk1c6;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3E606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sA8fk1c6
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1784309a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443872; x=1795048672; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ol63YfyO8DZtQrd6m6wcKreCNbKege3vtcgskM5PoLo=;
        b=sA8fk1c6EOUgUEuzBWqsheFmGgDY55vbZy+gfSyAirp98idLCn2u07heCLM6A2wnzA
         4fczTGxqXG06TsQOv5rahv9yKhCbkBDFhtaBH+ajkWObO+fQKmfnYZYIgqI/odwtdR6E
         2Fz+EsqGycgSy30VMgWoHKnTKDdLsu4lmQaYgC7jHTZrwm+KyOLzdjLnsYL3ea7kHMn8
         8aW5sPUn//50Cgk1LqC/sdBe3HA+rPg3T5j2JzZIZbcwcjtE9PjaCXfuKYMMmqup4Fbf
         DEfKdC0jXshdOMRZPXkHuLMCV3uTFfOC/M14LYHrSfOyT6fU2z4Vc/KAtOfl0XOPsPdw
         +M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443872; x=1795048672;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ol63YfyO8DZtQrd6m6wcKreCNbKege3vtcgskM5PoLo=;
        b=hEpquKv6VXFKm5gj/VKouTCPkMnogcUmCr23D633wZHfDv6duVnqWg5O1Zh7OK57Fc
         GvrQ7Fglg6G+xznfo09xzOvI8X0r9BbFKVLNcECGL+cVE+VSgpuGyTc7Z5SqhPIyeQM+
         FLAPEsi7kRtacBTzjLhN9XVDYANybmR7z/5cLsb27sJqBZ/L5xGHDGtGZU/oxXxlxuQk
         gkadazRuqCQKKh8994rtsmTJS2hByTzBMQ6VXYdSxcaiowL5z/Ra2z66MSFQTfGgoTC8
         u256m8mU1M0SU7WTrHdoMMdAFcqxvyjWWz7I58zj1AyerJCf2E/JYw1lhfTbN4PCkE2W
         nh5g==
X-Gm-Message-State: APuU4Z/ni+OmIahb6u4EaSuN/CizkPAu1zHg+PLV5qx0FimdTY15JRmH
	MOIdOQpbmnFn4j4wquJNx0B+Knn+h8jCb2eymweKzL3O6U+YOOukco4YZI9OIriE
X-Gm-Gg: AYBFou2wIdN3VMLpySx3TH2R+TpPla1OxUXI/Isrd7eq0JCJrRx7UJXqn1vmJgMgfiW
	rDSdnxVRmwKjJOEe3VJ976xxPZq82Egu7er9QIzudznoUh0m/rnO0CDZEU2LUsHljmci1/EHE2c
	sFlnnl4bRm7NxqpIaZFHtTAb8uZT8u5Yd5AiVAgE+bHPGw20C3T/2DXAGJw6apyIpD2KwTUs42c
	RVaZNV/5SWGEcmB8EQBHo+NjfwAVZvsTkjijtF8RXn41ZA9KCRIT2TCpYVF2DRmZdUQqn734jYz
	SFXrRRH+7JqHAPIn0Q+GIDuDSwFmEuzDaHMDA3YI7qDpaa+uZbLjIQSihPKA3XCP2DIetCI86yu
	csyZSTj3oO/EyyeKj8FK4AJDzgLMbIVWAWC4hgMdFkpWJNBgkaaEG8OoVOvgx4KGoqAPp20LE1r
	cCvZWdVD9BK7BGiTsSiBqunXHM05TncFNRcPJkcmbhbIbzdKdNMsKjStrFOVtw5aR9iJ1sweQ26
	tU87L3utfgm8L1UWDdg91E3CQUciARXCVzL6xWw7W27tTKHXSPmdRxAPGj8SzA=
X-Received: by 2002:a17:90b:224b:b0:3ac:403d:6239 with SMTP id 98e67ed59e1d1-3b182f45135mr3460292a91.43.1794443872232;
        Wed, 11 Nov 2026 16:37:52 -0800 (PST)
Received: from [172.17.0.2] ([20.64.175.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm1497276a91.14.2026.11.11.16.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:37:51 -0800 (PST)
Message-ID: <6af50a5f.1b57c0c8.3d2c22.6657@mx.google.com>
Date: Wed, 11 Nov 2026 16:37:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1175267859970743506=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,4/8] transport: Don't hand the owner over while releasing
In-Reply-To: <07eac67b88248b126fcec9d784db800a69ac3e0c.1794428234.git.luiz.von.dentz@intel.com>
References: <07eac67b88248b126fcec9d784db800a69ac3e0c.1794428234.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1175267859970743506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/transport.c:2459
error: profiles/audio/transport.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1175267859970743506==--
