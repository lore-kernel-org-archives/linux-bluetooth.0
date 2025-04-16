Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7771F8EEC
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814668; cv=none; b=qCioYvkAKIjRHSL3kLmGGHYzfLgRbjhBQExCXWypogfiWqnLETrAO/H9xAD2a7YSCJnwIQdYy6IDCIopX0EB7worQ415UFdyELK/kQAh+yHQyXZ4AVALwh+p8iJa5UvrKJ6Sm/mwfTY3lZekCurrfvilkF1t++KqP6Fp7C+V1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814668; c=relaxed/simple;
	bh=AO0cEGm39yAV+bD+jvU9BicarzJSoYjil6vs/bt6hXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJeki5YkVWLf4QyWLI1j4yYLVf3zr+eo/HGv7oTZbiwwp6U/oatl+4J6evtoCntnmU54JNNpN9DSqqRM0Z2Az1FbDs0zS/k1YI+enW6X5vxmncwMLeOYbf9bpBA8zkmVAKHRuBRcr85NXqP3lpeQFS8Akjf8UtBuc/mkUNDWVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxsQOJV1; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxsQOJV1"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30eef9ce7feso69280831fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744814664; x=1745419464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leO4+tDvKPDeZZmgAlc8fcZs07s9f5mhhKigyDanlIw=;
        b=VxsQOJV1HKqpb2KFM0sZL1RqYY8sVz9m56hoNapp14Zh1WH89DMiEbTPhZJK1GgWcR
         t5ENG5yZCuWF1nV9EZyMuAUZyxB+Zz8fLTIUNZopWJxNvYjiIkcwRC1B/BkSEECzAlvh
         WLdV2ApYTErPTSwGTFlcyvn+6c4A21kegpxwwxK9CPlDPvBWVxvpifmskziRTIBSyh30
         Wx19+RaM93hTtB3InVnY8pFNVqLKzq4bgRp6FMpLawjoqIgSUb4oDHJThPmuQ2vXxsgi
         k7cjobVb7eIj7BnfGIoTsfZoT8Dmo1ohVHSZOosswITiNxZjGF7pnD6KWCusuEpad0wX
         sTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744814664; x=1745419464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leO4+tDvKPDeZZmgAlc8fcZs07s9f5mhhKigyDanlIw=;
        b=vWmYZGyKfvAbwUnAjaukQaDSWdBK5r3lo6sv+j8RK0sd/BvmXorVNquz4LtTc8DkDK
         4psfhWFJudlwPFjjdF4VWRKE5BckJysGg8v8avAuI0WwquygOQ7BrZqceF0cd2o7SRNO
         a9sPLbmCqiv0rlxmUZmKaH2X5DrPMChDarangatHxWyyzu9lrvCTGTMJ/cvshxfuYOqS
         rYCdlXEmBL+Xz8GL+fxGpozkiG/+sTecPgWyVH3Ke9sm9K0EbCNlcegSDnRf7zLRp+8z
         tBBiUynKccrKVFxrxYKcqOGrixDkD/M+nNx5FA+4SxRKUUnCZSgtCCyMXJJnKv9cW1n3
         w9ZA==
X-Gm-Message-State: AOJu0YwYGBE1qmCcsgRSs2IsbjU/htBzLTEcdvru9+DnNvJ7xbaKC7MD
	+csyMX9dGS3FpqnycwxVkBFcmeiX7gWKToEaImCT7vrhDBhHMG3SFCSaLBK9lTr7anHpKdrL+2W
	ccuQVP+VtjkZyaQU4CTWW/sgGHL6AeliB
X-Gm-Gg: ASbGncs+RltVkaark4rLHg1ZoQ7pjJ+cC15Y/zDAVA9w6kE1YnsEPZnCMkIywvYkSaS
	k8E8vMEKqFdF9jzRoyXiKbF2GnMGXhDNwGW2iDJHywCDXvZ1LuS2mZbbPfx/l33UjG97GtBbrkP
	+6JKpVTjnjAWpmwMY1uiJ0TZXgHhZNe98=
X-Google-Smtp-Source: AGHT+IHcGFfFVwEqMW8prqFhdvwU5LHWkZZw55uKUgBlrwsThPw3bi8ji+4fvOWdZ5xKheoeoAXVHc8pGCyHT7FvMt4=
X-Received: by 2002:a2e:a5c7:0:b0:30b:f52d:148d with SMTP id
 38308e7fff4ca-3107f6c0b1cmr7387791fa.16.1744814664087; Wed, 16 Apr 2025
 07:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416122351.213894-1-frederic.danis@collabora.com>
In-Reply-To: <20250416122351.213894-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Apr 2025 10:44:11 -0400
X-Gm-Features: ATxdqUEauRvlRdXMTHu-eOFsZpY4ugYIkxsEe8qRzI8wwQDllmMc2vw6BnWE5Ps
Message-ID: <CABBYNZLjJFF-oGOTfKoP-E0hvq=pZoY=oTrox-TDtKtSvEBXfQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: l2cap: Fix double free of 'skb'
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Apr 16, 2025 at 8:24=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Commit ad5747d4eed1 ("Bluetooth: l2cap: Process valid commands in too
> long frame") from Apr 14, 2025 (linux-next), leads to the following
> Smatch static checker warning:
>
>         net/bluetooth/l2cap_core.c:7613 l2cap_recv_acldata()
>         error: double free of 'skb' (line 7557)
>
> l2cap_recv_frame() consumes the skb.
>
> Fixes: ad5747d4eed1 ("Bluetooth: l2cap: Process valid commands in too lon=
g frame")
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>  net/bluetooth/l2cap_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1bba7152fd70..5ca7ac43c58d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7556,7 +7556,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, stru=
ct sk_buff *skb, u16 flags)
>                         skb->len =3D len;
>                         l2cap_recv_frame(conn, skb);
>                         l2cap_conn_unreliable(conn, ECOMM);
> -                       goto drop;
> +                       goto unlock;

I went ahead and fixed it up in place since I'm planning to send this
to net this week.

>                 }
>
>                 /* Append fragment into frame (with header) */
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
