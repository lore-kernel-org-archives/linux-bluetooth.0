Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462170;
	b=eETxywK0V+hrAPx7CNSix491498Zgd1yXhaGiZ5sbMG2QWWljBlvWASPNsfBg7i47A1E
	 LdriVYV6l6xPLCjcT32viycWsPajU05lqAkZRbC5GPaFJNquOmz8KIDU4+iKxckQDUZ3d
	 4iQILr4Dhwf/nmKZZWfPT5vMTxaBfta60uhWyuIiz1sa61A1NdAKPQE39dyDFKw1ogsgE
	 AZmL3KCFkdnumHxhTuJsJgofGZmNtCY1+aLpYwsxZ4zegwDYLSMaygzDA1HzqUoIefN7M
	 aMtmYkxbD8rT9D27D4m8v6XLNFp22BMS3iXFKXRXGShu+nw54qZPf4KfSJkEWdQBing==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=l9YBlkQvJhzeLkIHDtyxOfbv0l9Brm6xhCvS00bPQC4=;
	b=pOqHYB6kTV817H246hY242RUKDWDrHewZpCIad7/jr2cwjBG4mT2sI9mFKxtn+UHXHSg
	 z5WrO0iWxDZ063bwQ1Trs7srV2QIVxhNUSKhtoSoOsx+Tm1V52WFVZJCsQJuCOYPrkcZi
	 Pp1FCpm76GhtcnRUKDoqHVBRO2t9hDuF0lb+qmdoEf7rpC0EPR8cc4+9hUxoYcs1Jh3oV
	 XLxCAC6D2eTHRxM9SaBAlWiAgVG1+renpz2KzJCaQD10C1Irb6yNQIZyDuDipMEzIdDa2
	 r0xntilumaIgxPZSJWVzyWm53IHdhJaHETbWk8Vd4OzqrYLEYNR20nlbB3QZpJA742g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YeC4yJsq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30E606A337
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE30E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YeC4yJsq
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67db6d4054eso4161819d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 11:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795462169; cv=none;
        d=google.com; s=arc-20260327;
        b=MBLQVlUQrYVmCbiM3vvTcKxqWwHsYcqks2hvdBlqykxOWvTou5yjisQ0KWuxnMs3dF
         NytKqMTlcA/vi9T2JoyOm9d9pEddhSe/GDBH5ACS62FxjDnZU+RAzGjNzyHvvMs2mgBu
         V8Hd1BvpnqwniTVNL/qSyRZtvWd8brDNay+2voOp7OVHvO0fC3U7zRjYqTlOIY1c4kGM
         gHxp+Cr62BJZxQtH6qpvJIAAjU+Hmpm5fGUIka0+Mhv6Y5L25kvOOPwhyP+2sY/oGzAR
         7mLdBCtAcjuSskP0qZ5DHcabJ+xjtF9tps03D1Cq/etwquwwWhM+LQhod+SG63bylC3V
         tv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l9YBlkQvJhzeLkIHDtyxOfbv0l9Brm6xhCvS00bPQC4=;
        fh=UA/cNErwqknDfefZj80dwpXzGaUZl6eKpR9TO5+4Joc=;
        b=T9J4h1r/5k5J5JHIHtINZFWwQxaksz+hl7pyLLOmyRaumzpT+Im7n0pE7oe5PmxKlv
         XkUcbhy1H0Vi250NYqu0+yCOwiR78z517WWfNXg3QXfEYouKtPiwrpWMT94QYqCuB9Fy
         kH3tWzR5ba8I2K4u/H6UBJzSH2OaRAme1/lYjP+Q3G7azCJ1MudwKfGuc24hZ2c5HNoJ
         cSd0zNjKGSc1Bo3S7oe+uUphNzwdGX6EEpQkPuuAGMu/X+yMP+vWieigZMGi+uqSX0mp
         KWeMvazEXrygDF6Ls7eznuKY4CVRqeyxgxTiuMHuyRhbXYHlIXyb5yPWX5GxDGbqtxub
         hI9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795462169; x=1796066969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l9YBlkQvJhzeLkIHDtyxOfbv0l9Brm6xhCvS00bPQC4=;
        b=YeC4yJsqwOZigqx+OUStXGHl6kVYFAmICv150Rt4cXHvBqarDOAnGCgJNTHdpCNcsB
         CIDwG0tsqmnLJXkkictmrae4vvcd1hMeLe/LkY4CAavfx/ZYGsypLLU+WtHdBZ6pGWb/
         7QJDywpKJqSEYL2if6xMcLyemRxYMaJMkSropLGzaIx5vDY/eDUVIZhn0dgSfr/Xy98q
         aPQJM7WbTCy4qTcqe23EJjPfamen2Q3zgmpp32u4OQo6yX/5Hs+AruDfilkAZdG1XjOn
         ZIYcsu7I6+inPrNmVeAu7v05owb+O5ZmCJ35f95kbDGeKHqNBDrzm67hf2IE3AKw6+Y1
         rYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462169; x=1796066969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l9YBlkQvJhzeLkIHDtyxOfbv0l9Brm6xhCvS00bPQC4=;
        b=JlGGcWxKbYWNEWfFkW/7PXTspQU6IpS/9KRJxht/VRGMMyEgfHrCFL5jqdL+OTZyWR
         yqSMVUej8cyf+upBc+WYNqisI+7WAaOe7atAw+hrnQcMa/H52iidt7C9c4tlPvlMlFwF
         5L9Off9lIVQBsx84/kW36O81rwKBW2T8qwDhsG4W1yKt6WPwgvbjoabGC+L+pQU8Qecb
         OkrjHq6zVCHcryFF0bZWxMC3qXT6c6QAhHAydMsNB/9F9+154t+znas9Bya7cyoX95z5
         YqD3TPxx2FYX5hUttrh98xoet/Pr2a3bRf9mLcMsZJEKiWCRVroPszShHHbO0r73dW+2
         qyTA==
X-Gm-Message-State: APuU4Z8HbxJQErnQ5TDIbSe43LY8vBeW0gOAVKMrmnpdt4v0ril/6Enq
	DkAgDb8/stqukVexVmxD4VtN3cU3vQutlGsHgcAIgTifuLVWT/dJLG81GOlgTrE1xfZsJU8n64Z
	9st66Zd344y5kqXKktRLt1LkK4PWKsnLQWYgf
X-Gm-Gg: AZFdTZeK7UTOUKlY5xq/WC1U9iVIH/JKKOg4HETeNxyqOzBEVaF9uNi/oLxYoYVG2+s
	H39tZGKY178qH7cRIuAssrBuS8HWZTP2wJ1l8IHK6FhgwS5DZ9sUNQS4nf2PheslbHWOArg4GKZ
	XbbAnUGygwyKuudV9psp32urEWBCwpEzoDOY9GorNAPErxuNVI2Ize1XOx8BxRKjA2qNxr5eR6A
	nRfRJbeIUXxxPUVnWGvoe3h59IgWcCusJwISowpR5Kri70Vs2A+w2M3jksFExBvwvL2RjoAhjOc
	CKCsDh7yEFlQ/NfwjYm00ukn1TBGpIvQs8eIM0AXFxtDXJNGD0vyw9sqNC3r+p1aZZ9VZBgESX+
	3hLqbWLBKrV21fDzoj1wgpZAWKrzZLl2e47CoopF4p66UZc/EodRMAhQMJpAiMg97awmxNFJq6c
	tkzY55WkDeo6aKMEQblkrIedQsZ0bBRPu0at9zvDKqmVSxjspfpJxr/++DbSZzOi6Ydp5WBa9YT
	/K1iHlt
X-Received: by 2002:a05:690e:4890:10b0:67d:bb89:acb1 with SMTP id
 956f58d0204a3-67df4441bc5mr3034628d50.75.1795462168686; Mon, 23 Nov 2026
 11:29:28 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122200947.2780757-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122200947.2780757-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 14:29:14 -0500
X-Gm-Features: Aa3M54omQbXLV90wjW8o8Pr9B9_9D9foHp1KK2DC2lMT1Dy_gUYxY39xQQynIrg
Message-ID: <CABBYNZKK7et_CfHMq4wtz1sohqYxbns=_BcA6vR5YgwzSn3o7w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: lib: Map Connection Failed to be Established
 to ETIMEDOUT
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Sun, Nov 22, 2026 at 3:09=E2=80=AFPM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> Connection Failed to be Established / Synchronization Timeout (0x3e) is
> not handled by bt_to_errno() so it is reported to userspace as ENOSYS.
>
> It is the error the controller uses when the first packets of an LE
> connection or CIS are not received, and when it cannot synchronize to
> a periodic advertising train or BIG in time, i.e. a timeout, so map it
> to ETIMEDOUT like Connection Timeout (0x08).
>
> This changes what userspace sees: connect() on an L2CAP LE or ISO (CIS)
> socket that fails with 0x3e now reports ETIMEDOUT instead of ENOSYS.
> BlueZ iso-tester "ISO Connect - Reject" expects ENOSYS for this case
> and needs "iso-tester: Accept ETIMEDOUT for Connection Failed to be
> Established" to pass.

I don't see any patch for userspace, though; did you forget to send it?

> Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
> ---
>  net/bluetooth/lib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> index cea21a4c49a0..0f84c397891a 100644
> --- a/net/bluetooth/lib.c
> +++ b/net/bluetooth/lib.c
> @@ -89,6 +89,7 @@ int bt_to_errno(__u16 code)
>                 return ENOMEM;
>
>         case 0x08:
> +       case 0x3e:
>                 return ETIMEDOUT;
>
>         case 0x09:
>
> base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
