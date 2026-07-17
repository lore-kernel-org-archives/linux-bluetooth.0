Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1D36A370
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303215; cv=pass; b=gTAzvQqBG7WPqqkBPvmgehF+OHuT3P29ckktFPKqgF0GR6uIiQKmFDfNaVpIbUDE4G2wyJP+r3lezt0usOn6LneB5n+lEC74Tr3UcYFPMivwjie6XG1el8uT0NcoJnaBpd8inPALvKsEn5XQtRhRd9YoTzVbfuAynhusaUm60G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303215; c=relaxed/simple;
	bh=bw8IJ3nTUToFJiJoltsUkDtdFquX0yyZolILvaph4AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzkzTzECXkGWTFIWssJF3l6MEDDfsix9ch1H91ybGHHqMVoOgQngOqMXGTvCTlRjolM5OImEg4sz8Bw5mhACj35WwfE1vxQr/gRK0+FPl5bt08WKP2AHj5/pek2pE3o2QBrcKppxdjT4JZG0EI4WjxwpMnSHSailua9zfBpU+oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4c+9n80; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4c+9n80"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ec29f1d07so52574667b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784303213; cv=none;
        d=google.com; s=arc-20260327;
        b=lzwNtuz/GY9lDAUHeJyMRbaE53pXU7mTkuQwNEF8meigaJbBOZ10DVRgoq2AdQ+t0R
         yVazlsZ+muHgf3CsL7h/Q9B3STV4qU7vQ2JO938CP76LX3IjAoout/TULjljO2jTrqSY
         qifKS28ZekfWSM654tL7KWEsVde2uUkP/M7YLDe8Uf1fukevFwj2e13HESeUKlUQPbvr
         102CcJYU2Y62FLo89yyfwi53ydC2RiIwftX4ElD324PPeWexxgsrAzhakZnd6P0IG14L
         ZPNatR0QojUv1T1VrQRNpWTm9aq6KiHDpkJ8rT4fE7bPk4kBsobKzGmV+K/fCXIVvJCh
         lI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9RYRQYbVym2FzqU0NlUIG9BqrH8mSEo44js+wTCgU3I=;
        fh=SPVv+hyDtCYw/w4JWDVLs++kFTWEVgRFrw593GpkOsc=;
        b=rxpKn3JPTomcYyYU0LXoHQO+BxJnNwPxyx8ckSgHzB4hK6plloQ5F+U/FegLOIhHco
         Nmv1fIPidaecPeQBnbb3J/SD2x4abhA7sFpnGu4cPlCNwHHxpRJnOgu4ETaiQQ/342Mj
         xdGDTcOI6Tub2bNXzDiBptMpOB8ni/VSljS6qDG1yZ/oFml4XTOkNqWOGbl2zKSk9vr/
         jrh0qbIL/wASr1RPjCeIPu1NrS3NuHMST3qsOqJQrls6fGj4RsHsD+Fvc9v/voG8Pawj
         v6O+cIcfTD3oLUARMNkynBbCpIUmw/mKaqcv5unRk9nwurT5DvgKMag1e1OibiSt0mvB
         OtzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303213; x=1784908013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9RYRQYbVym2FzqU0NlUIG9BqrH8mSEo44js+wTCgU3I=;
        b=Y4c+9n80ZWD15XO7O7wi8G3szi3qVvhYSUxu4OBjaxnCPkisWyxN1ux6bV79NTDpYu
         rCPlgPWFrucaRPkKBjnSqx1ggM72xAWf6QNLZ7o7zcu/4ykU5RPLOatQXfOqKfPKhor+
         Vc4LOsb3cyjXJ3A7bLNs3rI58+F4d7/VJ0/KWG5WQ/eMRSbBg4qRH239dhi3jDiea5qV
         u308CtOyLYnxWQKu8tHXHrQ/Xbe1ljtg771LDZ8AiFT0DodBk7w4ljhPwVwuaIZ4ohdD
         DcUuwNubosCixvQzh+G0QS6SBTOEogh43Gfbi5rEn/Lz51OyJ5bFl4/PxPQlBrqlEh4g
         zJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303213; x=1784908013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9RYRQYbVym2FzqU0NlUIG9BqrH8mSEo44js+wTCgU3I=;
        b=j7gGnABsK1B5X2lNpx6nAbDJRGeLO0C5AFHqsGs4fhtd62+6LTrmhffYSxw+Yk/GbM
         T2fpEOJWG3wJvdAbSMbd4B1ARRkp4+sLPChNNRxrUHmvVOAPMArVglpiD6Il2quROoCG
         6o2H7+d7zE5fD33t0YWj+fa4pD1t4bvrNhVrwfsTLIV6NQ2qAMiuhtbYkQMZoJWVLwk2
         kclONkG60Pus2Pwm3s8Z/WIU8lEsXSZ8MnT+JZ86Oki9HdMxAqnlHzabv0VVMKYlAqAg
         WIlJ/ZTz1XaiGeTTVMITSOAm6G0K/Y8EXw0tsJxCqDLMoH/k2UJyiU7VKoaoElOW4Rh8
         Jmqw==
X-Gm-Message-State: AOJu0YyVdEN1uzfQXBVy8NrQPgNbckEoOlM3LS4sclukWcwCKvz82i1M
	FpL3O1cOdCwBhPd25FSljv8MtPgY9W+aR6lyvM06AqXISfDLA86ikRZQBXUHb7Jkw8GmdP3p5Fe
	DicLgjcyKYJ9OXHaONwm0+Uv3vHvnu5E=
X-Gm-Gg: AfdE7cnZ7623SSjTiTRqd415L3sudAatimcXukzK/vFY19xtbh7vE1lUYTtvs9+ODET
	j5VY/1zpLSNhgQ1mp2/kqcWuGTMtMi4tr8Qvc7BNPKt3RGsQVHRCYBDb0SGE0BGZuk7J1ZSPEPI
	046OQBDe4EgoTvKKUWsErmCBbtcNLNfHYHTXNynHP5LQBVIQr/SdQrSlGUgx6Sdn82KHn03CieU
	CXEzG7RDMyht717mJWspV8CEKejdxHTysReylG8sz+NZc7FlsEBKHs6lS/2r+xdMr2rTEBh+no=
X-Received: by 2002:a05:690c:dd2:b0:81e:7075:e2e3 with SMTP id
 00721157ae682-81ef26a561fmr10645497b3.35.1784303212647; Fri, 17 Jul 2026
 08:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703081431.922054-1-zzzccc427@gmail.com>
In-Reply-To: <20260703081431.922054-1-zzzccc427@gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 17 Jul 2026 23:46:41 +0800
X-Gm-Features: AUfX_myP408gERlsjWpfmEwL9GMYvG575rzX8vaPm3ISt9pWjulFIhoYJYKvag0
Message-ID: <CAFRLqsUu39pejCszxYxxLfHDqQ-3QE7mbN1JmEWUerpA6A2-hg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_debugfs: serialize force_bredr_smp writes
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel, Luiz,

Gentle ping on this patch.

Could you please take a look when you have a chance?

Thanks!

Best regards,
Cen Zhang

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=BA=94 16:14=E5=86=99=E9=81=93=EF=BC=9A
>
> force_bredr_smp_write() calls smp_force_bredr() without hci_dev_lock().
> That helper checks HCI_FORCE_BREDR_SMP, updates hdev->smp_bredr_data,
> and then toggles the force flag.
>
> Two same-value writers can both pass the state check and run the same
> enable or disable transition on one hdev. On the disable side, one writer
> can clear hdev->smp_bredr_data while the other still observes the old
> force flag and later passes NULL into smp_del_chan(). The double
> transition can also leave the force flag out of sync with the requested
> state.
>
> Take hci_dev_lock() around smp_force_bredr() in the debugfs write path so
> each request observes and applies one stable BR/EDR SMP transition.
>
> Validation reproduced this kernel report:
>
>   KASAN null-ptr-deref in smp_del_chan+0x31/0x90
>   RIP: 0033:0x7faae680d340
>   RIP: 0010:smp_del_chan+0x31/0x90 [bluetooth]
>   Read of size 8
>   Call Trace:
>    dump_stack_lvl+0x66/0xa0
>    kasan_report+0xe0/0x110
>    smp_del_chan+0x31/0x90
>    smp_force_bredr+0x69/0xc0
>    trace_clock_x86_tsc+0x20/0x20
>    srso_alias_return_thunk+0x5/0xfbef5
>    lock_acquire+0xd0/0x300
>    ksys_write+0xd2/0x170
>    full_proxy_write+0x9e/0xd0
>    vfs_write+0x1b0/0x810
>    find_held_lock+0x2b/0x80
>    do_user_addr_fault+0x65a/0x890
>    rcu_is_watching+0x20/0x50
>    do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option=
 for testing")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> v2:
> - Reword commit message to avoid checkpatch's 75-character line warning.
>
>  net/bluetooth/hci_debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index b7f682922a16..ff344564c923 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -520,7 +520,9 @@ static ssize_t force_bredr_smp_write(struct file *fil=
e,
>         if (err)
>                 return err;
>
> +       hci_dev_lock(hdev);
>         err =3D smp_force_bredr(hdev, enable);
> +       hci_dev_unlock(hdev);
>         if (err)
>                 return err;
>
> --
> 2.43.0
