Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8C5B1FB
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969537; cv=none; b=OUpokkyr8E6atp7eBWMYobO10Bbxs329rMeHzxUR5ycNW306cbnKfgOPeX/S5oc6px+dgv8RNmMUyx1auznI26bFEpL4OlFW8JcBjWUHgxc9cyHA/62wdwTsW4cRcWqqp+k/BUfpQBqjOT/rFkzNtiWOMhwfmRuqrJ6pzJ23+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969537; c=relaxed/simple;
	bh=kx7189c1EbXDpLKKvmQDwmOpkqhbAaxRGwm0wJDS/y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mg3dAQ9RBV+pmUsIFZTpun0GK5PUMsJf/QJ2U/1NnfpgvI4ht/QTwtWWmmufUi6AwyqB4ZYeq9HwkDJmprUKluCZ5XT7UkPVzNfvJ1PTX6bSc5n5aTo1JCF2Yo6PJ7Notm73YF1Tjtiod/jX9mEKYt7t2BSMt+j7/Bg4RNFGMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7VyoDip; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VyoDip"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f149845fbaso10907081fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Aug 2024 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722969534; x=1723574334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbl5M7qUlGOR74BYoN635Rucx7pgEKEVFcEQEeWPn68=;
        b=J7VyoDipJRiJrEssHwWAhtGIu/+IJt8GAO5NiOguRc37diwnDANgSgrdo5JjrG8Hs0
         R2DmEalMRTUa4lvTndJ0rLTNvP8dsGGL4IwdbPPGsK99vAGgo1T7b8m5dNVesId5dYKV
         PqOhHGmN7uFyATe1TstHQhWg8/qYmidwJ/Arx8Rta8fVlsQOMhS/41ErR72wyqYt0GQl
         1iWahMrm8iGYHGyUCCMb/t7XgB3ZPfb+Pqw0Fwx40IRaoBXS9DIO3fmVPchTUPqPbapY
         OraZ2KbZN+hK/vt8DJLKgFDqiqstTWFxPM59MScPMh1dzRaJot+EYcg27dRJyyLVtGd+
         H7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969534; x=1723574334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbl5M7qUlGOR74BYoN635Rucx7pgEKEVFcEQEeWPn68=;
        b=ILb3O7Jv2Q75U2qzKKaLLYob+Rl8FecYWX56/GxYOD7vL7P4JAvE9lqr28LOAHA6Bi
         JOWrEzPu5nr1NoKRoT+T9cVGZWrflbO5IlYqL2Budc3n3NjViBfGVXEb05Lvgd5APypH
         0V6gbViQDHGFkABwfcOkusutomGYYfzk0m1eyOo9gtYO5owePgrTpL6zenadi9VeVQtp
         EjnuXy7823pj1T4MMcsMZxj5w+W/RRdFGdnERfvBeq2OAhQjvzWdFmZ8+nB1zLmy1Y2A
         WEEGnQsstL4zYC8dQv+smUS6GUa3BRfZgHiyWKsAfLr2x99jUDAR/7xnNC9CRn2+ZMot
         8K/A==
X-Gm-Message-State: AOJu0YzEzo5+191ogYcQNe+i0hYcGR8BB/jH0yprepks5HdQQYFKwklk
	SFr6+NRtzOHEj6OT/apRJi1arU5NzkahHB5Sk5ag9R95+fkRoRbvoijcNd/qBIFBToupG1zUXuI
	VxCuB+WsW0BVx0lO3ZRLfWbL4CvkpSQ==
X-Google-Smtp-Source: AGHT+IG9hSES0YzqA6B5tFi0aj36Mfik8SFlGptGUvghr6WnnLgwSjFbveN4JblBtXzSX1o323agHfsAT5bGZtO5v0k=
X-Received: by 2002:a2e:9c8d:0:b0:2ef:2e8f:f3b3 with SMTP id
 38308e7fff4ca-2f15aaa446emr107598121fa.21.1722969533772; Tue, 06 Aug 2024
 11:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805140840.1606239-1-hadess@hadess.net> <20240805140840.1606239-2-hadess@hadess.net>
In-Reply-To: <20240805140840.1606239-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Aug 2024 14:38:40 -0400
Message-ID: <CABBYNZKVOpfAdsaCy4+ZS3v8KFwG8O0j2ZZJ7Fryx4JS+bnrWA@mail.gmail.com>
Subject: Re: [BlueZ 1/8] sdp: Ensure size doesn't overflow
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Aug 5, 2024 at 10:09=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Error: INTEGER_OVERFLOW (CWE-190): [#def1] [important]
> bluez-5.77/lib/sdp.c:1685:2: tainted_data_argument: The check "sent < siz=
e" contains the tainted expression "sent" which causes "size" to be conside=
red tainted.
> bluez-5.77/lib/sdp.c:1686:3: overflow: The expression "size - sent" is de=
emed overflowed because at least one of its arguments has overflowed.
> bluez-5.77/lib/sdp.c:1686:3: overflow_sink: "size - sent", which might ha=
ve underflowed, is passed to "send(session->sock, buf + sent, size - sent, =
0)".
> 1684|
> 1685|           while (sent < size) {
> 1686|->                 int n =3D send(session->sock, buf + sent, size - =
sent, 0);
> 1687|                   if (n < 0)
> 1688|                           return -1;
> ---
>  lib/sdp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/sdp.c b/lib/sdp.c
> index 411a95b8a7d3..8a15ad803db1 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -1678,13 +1678,13 @@ sdp_data_t *sdp_data_get(const sdp_record_t *rec,=
 uint16_t attrId)
>         return NULL;
>  }
>
> -static int sdp_send_req(sdp_session_t *session, uint8_t *buf, uint32_t s=
ize)
> +static int sdp_send_req(sdp_session_t *session, uint8_t *buf, size_t siz=
e)
>  {
> -       uint32_t sent =3D 0;
> +       size_t sent =3D 0;
>
>         while (sent < size) {
>                 int n =3D send(session->sock, buf + sent, size - sent, 0)=
;
> -               if (n < 0)
> +               if (n < 0 || sent > SIZE_MAX - n)
>                         return -1;

Not really following you here, it seems the problem is that sent + n
could overflow causing sent to loop around but if that happens don't
we get a problem with send syscall itself? Using size_t makes sense
but I guess we want n to also be ssize_t then, and perhap use if (n <
0 || n > size - sent) logic if we cannot trust syscalls returns the
correct number of bytes.

>                 sent +=3D n;
>         }
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
