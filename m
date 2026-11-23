Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457213;
	b=SeuVOHesVG04DiXnLDWEpyfcRIpGVPiS3ZDuTO4dFZV9XMeeb3+uorNcXSJkVIURnpBa
	 khZpDP1cM4gbHZ3Gs0XpdZca2YUxJgsnGh7FBPViHLMxeRGJIeyZDNaaa9I5UBmM8szu2
	 7pb/E27tLF0PgM85iaPlRfIQjS98ZLy7Rn2yYC0DcD0Ig94bl/uDqzG5f+bT/RGn5Kcao
	 HVsfd8uPlucxpZAp3rqmdwZqUn3z4AGi+TKuxE+QWil17Z4GSn9ERHFG4kxjcE5RA/al1
	 vaowVAi1ksciAsyXOWjCUC3KiNJ0RQ77mvApJYXG0WHI8KOLRx22jRrNQN0K5zpnKyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K/gC1WzVIylwK716jBr23A7FWq/AYO9T9Wc9DElVC74=;
	b=cgbwfcuXHIMpkDTzLnPtTXSPhzoNPxiDDB7IE1wqVUKc6pz5ipC01yLlR411dUG/WSKX
	 YO7qF8mxSSRhQbTRqKD1H+I+s4/iMWIHeLj6kGmVWzo3+VzhVFMZcYwEdWVhFGvNTCwV5
	 UINA22zXna3Sex/C90jyD1thKmqY/tCPCkZOM5hEeMioOUoL1bW8bJHmDjyotX/BDoOi2
	 S9Pon0CgEW8jcbE9r9GU2+8Y/OWlhD7L3fEJgU4cHT1Ljnzvm4pfAPZOUFXKYNlsuQJ2c
	 JSh8fu5l2gue69cnhdAUhGZiSYfaBhbDbqyKMXYj49rB8lCEhFFOszzAql8otBCQgsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynGHK7uE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365C606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0365C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynGHK7uE
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso3780674d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457212; cv=none;
        d=google.com; s=arc-20260327;
        b=RJ/OV42E5HXOhwuHFSJLpsAS4rwek9bmW8ySnPygXYMwFT8izxVkvK0U9kNsPMNtZN
         7bV+ES/mi3ng+NhtOMEzr0sBsPHqg2ZGh5nW8bGwQ+r5eOJRF9aeaHLV0vGPHeINqNa4
         KwF9gIfKzEbMHDN3mv+OaCI9xGrDxfVVuP0C4ks4GEHBmvcv8fUh33cKqnhvJ/dRlTFO
         0C//V0JbpMF0LuGrctCFaUMBUB8/nVZ3OlNXPltzHqZ5QjUWAiTOwXbd41VsbPxEpK/J
         d3A5qEeB1DCZ3ekXpHB30aE3+6/j5+gH4msZV3wmaWTVyxmkdVHGHIeb47VgPdSaCjEe
         Bqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K/gC1WzVIylwK716jBr23A7FWq/AYO9T9Wc9DElVC74=;
        fh=0jffuTCeErHXiWl8rRa+hQbZQFbt+s1uEKtyWkGJncM=;
        b=kLgPwDgSQVI0NdTw/HmYmC5M5zIw/u3Kc2dpPS5g16FxObuMPBS6UhJiPFqbIqy3RA
         +JXzgOajrawK/xbUNINxBsoHuIDsYx5frutPMHZY0JhXpzl6H+V19Qcqu6LTlzkqkRuC
         E+lrK2p6vW89N7pHkWmBjDD8v+lJRN1tzxn9ABNmI4jLPkuR/nTgoR60IA+k3/rhMB0a
         Y6Rgyg6GBRW/blf5ayDriN0vSA0+bEYH4SV7Kbm+ka26bYJzyvViaMP/vjrle/vXSIbm
         2hPyshvbzsHO6siIc5dZlxuRPWPuNsT5rsCeNWrNPmJrk0PLgEc8uuVVOqQV1K6PO87L
         rZfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457212; x=1796062012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K/gC1WzVIylwK716jBr23A7FWq/AYO9T9Wc9DElVC74=;
        b=ynGHK7uEvexHqw48hCg85zxO03l0VsE5U57hLmfl8nlbBwF68tlK9YYvxVRN1kOjF+
         Cbka8q+ONjU3JwYA1L0RANsDs2irI3NaRWoI7Dpspzw37m38nwFmAiHEv4sZuKvhDawl
         oDiAVcf4tLb3OhjvhyQ1xS9zval+bi/EMfItyd/aykMxzB2ZfNdre/eisMt2A51pA0yd
         nFl0/q2Qd2KXdZnucHrhHZUO2D8HJzCfP+vwZLuaoaSeMerJ8Yg2hnYK7rmXrKQjwvrC
         2nNOFZsDhXdOi6JDe0EbMkqMTDY+9m8n+IEOdp53olcPjsXqg9kIgrra/3JhH9jJeMWZ
         3oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457212; x=1796062012;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/gC1WzVIylwK716jBr23A7FWq/AYO9T9Wc9DElVC74=;
        b=e3aN6DYJXgrRyeCEkaEtdH1SEPsceEAUad9MCciS7USE2P/Q/46uWhpXq3dpCvLx/z
         di0/hJP5IEnSTd+YHeZaPHMi3nEfRO06Liqc4x/xOf3Vm9Xr4kfPHEt6R/i2m2Q6Li8Y
         2ebFb8BvbrDK+A1D7XByYGrAW8Tu66xUDrG5nZcxFlDBQ95E4b4QD0sTFPZKDTdd5BFI
         N+X8Y+EkJSi8M3Tbk+9grNANbdydlxxrdENFHgvx3cDMooXN2RCI9cKJh4hs/mOecsPC
         wwj74DXgOlB5tzcC2I2POqWvtYHUx+dTk7+TgahBeukNGDEISonogIXJBhEMTbmjpG+8
         6gMw==
X-Forwarded-Encrypted: i=1; AL+hErFcKodKcW3ln3wT93D6IaBwmWvVZAR1KA6eJIub3PUMWSWZ35/uuoLmdsWJGMy9UdIRJf7xOxZG16++Sy/wK4o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9h322K/rFMvO9dinwWDWyQn2TF+FDU1qgob/kIb3U9WTYrjfO
	Re8ZzJ6xR33E2koH81jLbLNAbMGAVmiAw4kGlKJUWLeDMajGC8lI8Tz40A9Se37kF7b0KtLJ/U3
	9I/bdc8h2tPNkqWva//2AfzqtSz9KZw8=
X-Gm-Gg: AZFdTZf4WSWeMKOexMYs7SLw2ou/9QDWUE1waRocQYBMRuNLigUR44hzDDtkm7ltNg+
	RqhLSA+tkTeFkmOR+lYEsYCmJCaGSACYFLWtANZTZgde+rk+DVT7jCDTrRl5OhY1J2dwPQeLauk
	OLRlqTw8AG3sJGyMxeCFdxNS+Yd5w/a16G+dwwFnalibh6TIpUdtJvnaMznQe+3hbyx6IFqWoa+
	2hF+9IFjjkL6l66kdJAVe+7b9YYXXhsou6JY+LLcP9dNYS0REYoHrMEGx4bnRULRPM2panJ1Bkg
	orTmfJOgzvns0pj8uhfD5WaY+knyiyfEEElWE+Z2MsPszSkrQEyrRcy1jBiBr7iSXIUTHFy4keh
	tlkhhEG0no+O4o6a+cs1fWRfvj5f6zjTfrHmbzsnaJW+JPGySwhOWZbPR7P+Mu2mxoveEqhtupT
	LOYA5eQ54Kj+8FDt9uSMW09MyHsTacigUaVF2xou1vN6R2bhRquv+uzr+K1Ow=
X-Received: by 2002:a05:690e:440f:b0:679:b5ef:a0e4 with SMTP id
 956f58d0204a3-67df44ff8cemr2520240d50.100.1795457211899; Mon, 23 Nov 2026
 10:06:51 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-0@gmail.com>
In-Reply-To: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-0@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 13:06:40 -0500
X-Gm-Features: Aa3M54oC2JPHwdLbrzUoRb6BHLhu1-ajOv4wUQhdYutOJfAao_ufgCkye0yzpeY
Message-ID: <CABBYNZJMr848DGgcX-SUjf5UfcwYfrB12bGRc0ZVzLWsMhc_rw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: RFCOMM: Protect sockets during teardown
 and TTY handoff
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Sat, Nov 21, 2026 at 2:03=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> Socket notification and TTY handoff can outlive the object which made
> the socket's borrowed pointers valid. Keep the listener alive across
> child unlink and notification, and finish old socket users before the
> TTY replaces its DLC callbacks.
>
> Cen Zhang (2):
>   Bluetooth: RFCOMM: Hold the listener across child unlink
>   Bluetooth: RFCOMM: Close the socket before transferring its DLC
>
>  net/bluetooth/rfcomm/sock.c | 17 ++++++++++++-----
>  net/bluetooth/rfcomm/tty.c  | 20 ++++++++------------
>  2 files changed, 20 insertions(+), 17 deletions(-)
>
> ---

Netdev sashiko found a couple of problems:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-bluetooth-objects-ca=
ndidate-0218-v8-da37c8a6b33c9d2d8efc-0%40gmail.com

--=20
Luiz Augusto von Dentz
