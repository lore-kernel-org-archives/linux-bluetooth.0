Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414351;
	b=zQqmpQ2aH1V1MuIVofc+em6NCr7MTqxHr+Wntq905NWdM4U3VeW9y2fP0Q6mY5hs2axj
	 kQ1Rsb5H+8aIGlgWzjBLp/wPKf8c15N2bT1XKk+aK/jn2maT5gzsjgQJfmRrIH4JeUH/p
	 uWUQSuQ8FynhLjonUXV8IxWDckkeZrqx3C2nRrpoRHC0ysWl03o1hwDKmEuNvoSS5Uom1
	 O6PmUwuSmhMEqdMkk49tMDuaCvluA9Fimv1dvej4a2HBPlpXLXW+xPS7xo5CxDkZiz3QS
	 e70PQXODq67wPfaj1DrEh/U2PkFARYGLC/rL69JS2Cdb6xloE08ZYfjK/v+UhZOuDfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=brRSxRDWu0lHEtkG2KexmmIY0op/Qj7rAzVn66FknF4=;
	b=moYMIKdTor1zpackXxB37GAiaUuDYbwitEuIcv1x7JPNweTdRy0ciJ+txVfADVcbONbi
	 sZNJOZkOWOi2hQW4VYbaPgqBgylgs05/VaHVjX1ONj+JlKdlNEPPfiN0G479qYKo2nrvx
	 rV5GZn/HBQSee2S3jOEoaEopW08/0HuOPC2RHaGxg3G9W5iCdtW/S2aYPsUhvkRM0Jve+
	 /V3ypkq+K2DnjA8apJ25SbsF0P/3oaMsH5AhHeUiz9rBzOioBHQxs6GIr7+MTkD0zM4p+
	 JO9TVUvpbnPKxqHy0s+6z9X5+3xlaG0OEtlBpEzfMbhAE3/bnnQcPvGjXKsQ4bNoE8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rg4JyU0w;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C4606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8C4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rg4JyU0w
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2d1b4a83aso1019838137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414350; x=1795019150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=brRSxRDWu0lHEtkG2KexmmIY0op/Qj7rAzVn66FknF4=;
        b=Rg4JyU0wNh4ssNrs7uK2bRQuHhG/K/gdAUtMP2BD/ZvIrxwIIm40VllAdnc3ie0GAZ
         omd1dRbn2Ytlr1HlmDdvWjXipzvCd3UvfQVSk6PMXitXVAVnVqqWvtTTxTAtZ33H+iS4
         mtYO1b9L894l7Fus5fjxdKnLLortH0M4jWqHoEN7xGK/VoRi+OPfMRjyYjErA91ITgiT
         StkHBi/kp22mYM7OXkbkkS6CB43T38CPH/7xBp6kn+M1YGftrx1nB8jSJO37rRqcg+2+
         T3uv/xv2JTxTmkl/ML3/MT8lPlOvFYNpEges5VADnTvbbOMQMnf4bXTCadDDNc9WARg+
         pSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414350; x=1795019150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=brRSxRDWu0lHEtkG2KexmmIY0op/Qj7rAzVn66FknF4=;
        b=oC+tkjJwcl433xHdwSmDOOW0P9zf+WcFQ0NXObhz6pdaJuRAPjHhPJ1BgpsDUHSHdp
         FBTda1fKnQn1egUz/pL6I3R8i2C6LMKNO/vpi7Mj3Pnt3B5YOo54t/GudoRBGVO3enpr
         w/kLNwVfhXSwyJSy7dLDdcm7Hn/JX7ICshRvIil7Bjczk8NDTt5ZQcvVUn+6qOjC61/0
         tu01yjxTrxNeiqACG+VXxiJ7PaveH61AY8k7bYX5vkXHwmanYiysoQicuUcGlFSLzNvT
         YcV7JZuQQ9CG4MEtISVrfiOolNelKfNUnvueNZ8l+pAdIWuggAhN5v1mhd65eMtJs02g
         oegA==
X-Gm-Message-State: APuU4Z8j5aeYSvE/FCzIC6F78XYX1UaiTh63I7TTMdL2790XvFUOXljI
	hwDfSReIaxirR1JfoenQZhbf6WaJ2cKbll8MpFSMZOh/+gVrjn6dMTp7xriRKw==
X-Gm-Gg: AYBFou3JFdvZF4/If8v/90kLodC9Ba+NdVTXigTFaLxn2O7XttUQyjv3bD7mqd9Z0vQ
	C/PUebXBdS0GYx9f128G0OjgUWbP+mSNNnIltxKPb6S2BodZ9wqgwuc7ho12di/1SsYge/+Qmbf
	/dMEvX+RofWetNgrabe8f9GAyGp+H6dLjdvlO+a4W/emN+kXgGIl80w+1Y8oEA0ljp0zu9/n8x9
	v5W9u1owKRVbXe+RdG8x0S6K0j2L6oXYQ8nSQFJkxwcYnG66jv8vdKrlXYKoxFiNxqTlLnQ1+Ms
	dO29yiv1qLJX2D3JZKm1TZ0JQggitzi68/VIDPj/DHktQPi6Szpk7TeKUv7bQLjCoALANguI0er
	5FcTt1Z6sAGVzuXjdsr6EibZihQmwOjnUo0spqQTTVIr9xAP7XEUofMVG1ckxuuPO2t2ol2FqEu
	A3V66+IAabtbWkZMAjTSBI5SGvcMCmZKTiobUpA6/JBoBDxX7FxWXrXxjpFciw2T8WrhQMitIPC
	uM20B0IGfPLG4eUSBoV7JqXkagSd86LcxEFp0/b1aEmH/bOnfk3WQdDf4U7uiQcpirOZ9mMgBmy
	rsJs8noNq8hJJDdFKgbOV1RLt3KvdEY2/AbHy3tjxpXwnRoFuwlrqOX5mG+gi5/c/gFq96Wfe/n
	PK0BgT6wQJXoGfqEXO7dJjoRkUNEMvxVSWpQaXyj5g3ZwXLFkkx3CiXfVVe2m9aEn9PduIjyWEa
	Y0dPWWorUT3RSVZV9mlJNTr+F+
X-Received: by 2002:a05:6102:4194:b0:7c3:9b0c:a75 with SMTP id ada2fe7eead31-7d4fb22fb70mr863554137.12.1794414349362;
        Wed, 11 Nov 2026 08:25:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/8] transport: Hand the owner over to a link still streaming
Date: Wed, 11 Nov 2026 11:25:23 -0500
Message-ID: <cover.1794414122.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794413813.git.luiz.von.dentz@intel.com>
References: <cover.1794413813.git.luiz.von.dentz@intel.com>
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
Message-ID: <20261111162523.ioRRvKI3A5x7IdUgKGmDZBOyfTfAZxPCaA7Zo2NJulg@z>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When one ASE of a shared CIS is disabled alone, e.g. a microphone closed
while media keeps playing, the transport leaving streaming took the
owner, and so the state, of its linked transport with it: the audio
server stopped the stream of the other ASE while it kept receiving data.

Hand the owner over to a link still streaming instead (not while the
transport is being released or has a pending request), and clear the
owner of desynchronized links when removing it, which fixes a
use-after-free at teardown. A unit test and functional tests cover it.

This series applies on top of "shared/bap: Don't disconnect a CIS still
used by another ASE" (1-cis-switch), as the unit test reuses the test
helpers added there.

v2: Start the multiline comment of patch 3 on the line after /*. Rebased
    on v2 of the first series.

Kannan J (2):
  transport: Hand the owner over to a link still streaming
  unit/test-bap: Add test for disabling one ASE of a shared CIS

Luiz Augusto von Dentz (6):
  transport: Clear the owner of desynchronized links when removing it
  transport: Don't hand the owner over while releasing
  doc/functional-bap: Document disabling one ASE of a shared owner
  test: functional: Cover disabling one ASE of a shared owner
  doc/functional-bap: Document releasing a shared owner
  test: functional: Cover releasing a shared owner

 doc/functional-bap.rst      | 58 ++++++++++++++++++++++++
 profiles/audio/transport.c  | 63 ++++++++++++++++++++++++--
 test/functional/test_bap.py | 66 +++++++++++++++++++++++++++
 unit/test-bap.c             | 90 +++++++++++++++++++++++++++++++++++++
 4 files changed, 274 insertions(+), 3 deletions(-)

-- 
2.56.0

