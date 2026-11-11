Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429478;
	b=XQ0hYPNa3hQx6T2M3t8uB1zyOT4tVxJFZKpRAr7UyC1Y0gr3p8jes3WkElhf5U8dKykB
	 9qudk0L86r0c9aJn3LJjs1ryqLI1+0Nob/WPpyQztxHR7u0uICOn3IwvvXwpcGQAIGlt/
	 BArtrd10WL9HPITkqyYOdoW2Ktv/qmyIsMrjVRDa4/WmGtT9A8lJgF9H5tKAPhgxT8YUW
	 uoIX0aXnzANpSSbMp3AY2zWDtd9vmGbBCOZADasxEsMPYe8LJ3GjBMwVXnT50d9nUppcF
	 ylwwzUwZXIRhzOkY0mde8lS+1gRyMMekwIESqU9mcEiezHvRN7447FoxlfItOkN6GTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gnErk2hoIj8sp0I2N1pPn4DjMDV/O+wPgLT9tM5Mzec=;
	b=W5r2Z237KOP9WXo4NGUih3pB0IoDRNe7F3k45KWczz8u8FFTGqw34CQttCNIXhud/S83
	 S/3iQoQDttiW67MKpHH20ZicBRgYIg4VXPAS8lO55tT+9+LxY6ePmCaeLwCfCvg1F3taG
	 nz9HLg7okKCtkCfbkVKqYVMWv/Boy5z3BNejihkh0/R7AMsU/PeOOIByPelVfQrhjUm7F
	 VSwNxKym7GUnJjJ54ioRC/V2HC2VaGH0D9jmvmkhovz4qDjrnBWG3tftegWB8ErhgyJI+
	 g4EyJYCRpNaMqK9/uketgHcZ1hUXz3kA8EopM4ihmhrGBC/V/8MVZ/X7FNEnXAE70iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6xZiC0I;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9C60A2626
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A9C60A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6xZiC0I
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-998749fe872so1718540241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429477; x=1795034277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gnErk2hoIj8sp0I2N1pPn4DjMDV/O+wPgLT9tM5Mzec=;
        b=R6xZiC0IHIvjp3wbF6JOfUbbTxFtCZbkdi21wNmlbL6oZIC+pjgUHFdt33FxrEWdHp
         NMxCkwFa5nGVgU6aj+MVjJ7H1Pl66whFFLc9WT6Wf9uY21ECPrFS/sk4GpB3iaN4Fp3W
         6eIw6zHCVFxTymonUwsj7StFNT6Qq/TfUP/tYUZUFPL0NlEa7S7EQRcuwq/yCCxvOuH4
         3uSK6m/RU/H7NM5uBO45OL/5RA7jPl9M3sas1cfZNGwwDwB60UVgATuwdVWfjbIU3jJD
         6kxCU5Q5f9EY9X18ojOiWUvxlCkbjw1L8xWKBdmnl40AWkMQ0tcgLgyWakF9vTs3asBV
         MWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429477; x=1795034277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gnErk2hoIj8sp0I2N1pPn4DjMDV/O+wPgLT9tM5Mzec=;
        b=KL7kbH99RkS64TQDkvbGQfYr+9SqPE64oPSqdTol1RLSSU+UmhyX/qGuTbfjM5b0Ak
         g30hqn3MTbLzQGNKFD2bGgemyHADLFVv+Rhz6yT6PgRGhg4jRiLqjnVFcXI8Lzec9Kyl
         b1/35H/YPxJL6kDjHw0hK1+CIVZzJbOndfHixf2qFByg1ldnx77KEunaY8k/wZ35qGum
         YjQQ0BJNFzkyqqvcbRZTl5p4eG0Qt1fr/XSCTf6vTyXDwRm/Qvq2sOhdG9ZBY5FJOZLC
         uEdzVHyTFoQAHjCWhQNFpHVPx3X1+cMIDnq2O4gOa8KLPEhgaZlV5G4mhOyuDqOgcjDR
         hULQ==
X-Gm-Message-State: APuU4Z+b+IOlqh7KCpqFBgQ1FbEU29lo31YoI91LRddcZ7ux26yLLD+y
	BZEYEPfzpnNpDNmfWHbjZ0oencGPQxpsGhgnNmsHsAIwkdSGmoXLNXXYtfr7WA==
X-Gm-Gg: AYBFou03Y4A0UfO3xByY3+v4m+qcHSl1R68wA32AgCtwI9fSVi+Lmyd8A24o5q7B5uJ
	rERmV5fUl3Xb7fRVJCiodTIMLgbcED9q0DD1+FgiJMxcPKfkVeQ4rk9TNHRlMCR4Mu6EWU1eCd/
	8pqu82HVx7wVeyp2KyUR2rmuWD6E9/iZ4FL+8pm6Ajl9PPlk1Owqr1B+GkTbjX2uLkzfD37vHp9
	BBnwrMT+hEvxWU3tGGvxChmF1yVsoYrwMhAtmDncP4hpENxNDpVFfbGP+nDE5EpQGMqzM7bqx4c
	UCYdm+4ESfkVqP0q0DOywvtOLkYCHaf8sjG/oyd+qR6bSO6E5t0AC3f6MCtVNnSkKrqPlnmUHLr
	5HzV6zvR7DtrVSctEy3L4aiECs1Zt6MQl6XOXoP0JpgfDKkpSktB6laEjX/6I4OecKcSeERgf/T
	Hy3VYHbDNone+4vdWrHIryFU7xuP1JWB6qV0sWyDOkrA8lA4UK+5yjInPhU2/+q4SkK2BeTeWrw
	KgQrPhhICkM7wwGQoks78u3W4ztroaKSa59OxQE6+x1JF+TOymicc1SK4VWeruvm/UjlAjl0LbM
	yY1tv/KOVr+dxcZw6/F0FJVZuTsDx9umpQwJQusujJ3NdUQnkSD0a51LBV84t/vQAiNWvXaXzQP
	W5l98+tOaX9gqrNt0X+GsIJUiAWGvaNF/CZgRBJ3GNO1TKvZRIgdz5AduwkMhyVQ6yK3LdDOGT+
	yrDuA=
X-Received: by 2002:a67:e7c6:0:b0:7b2:f3ff:6b34 with SMTP id ada2fe7eead31-7d4eed5b7damr1666305137.1.1794429477332;
        Wed, 11 Nov 2026 12:37:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/8] transport: Hand the owner over to a link still streaming
Date: Wed, 11 Nov 2026 15:37:34 -0500
Message-ID: <cover.1794428234.git.luiz.von.dentz@intel.com>
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
Message-ID: <20261111203734.bz7DvNphUvxqqsZUIz5RQCQMHJPaoxRrnQ9B0NrsKNk@z>

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

v3: Start the multiline comment of patch 1 on the line after /*, and
    rebase on v3 of the first series.
v2: Start the multiline comment of patch 3 on the line after /*.

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
 profiles/audio/transport.c  | 64 ++++++++++++++++++++++++--
 test/functional/test_bap.py | 66 +++++++++++++++++++++++++++
 unit/test-bap.c             | 90 +++++++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+), 3 deletions(-)

-- 
2.56.0

