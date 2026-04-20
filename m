Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01F37B00C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712999; cv=pass; b=dgiA1mBIgabxtCwHxLb3c5+coXbi9hPXjFRk4q56AI56wZ72J3Y/S1Ih4Ycx/zsomOhcXOGCzuHSPdHArs36V7NqhnSmnaPEUQNB4geMD1ebvtsHjClqL1CgXvG4FFVpD5861MxxnfQocSMlwNuwL1Rer7IOqXXwwBAQu1alqs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712999; c=relaxed/simple;
	bh=Urc4fTcbbk2a40JtrOyUlkKJdjhGu8/jYnZtRKrjbmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cel0FNRH/OBJoVgmTaedlVqcj1ozaRHaBJ/OlPMtr4ojiumW1FEnSSLfwqOuBE53HZDGYTdnSGNuSMJ6ODhCyYNecLDB6/Ud1+o6A4d5BHKhtxENKZksfVw0fVv5K/OguWZpFIR/B5CyPxo1UYUYTYZwKRpL+tWAbQB4DLsumRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3VVBkaC; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3VVBkaC"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6540fe6a8e1so2460405d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 12:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776712997; cv=none;
        d=google.com; s=arc-20240605;
        b=Qp0D95pqnYg5Fcc2qv5pCUafSCusLmy1IS46vu0+j2ws+3VoyMN4a24UojTYA+WFyz
         ExqWE0UU03KzOVPtgFIEOYUHGQCY8IiLE279Tc9SUccd5SEO82NSeTnAx6s5yMVHDApc
         d2Bw6PbdIGmyg+6q8s2UDbBLsAox677BH7idLvjO5K607DEmBFrjIkVky/If9leNHLiU
         gHT3c0WEPo+bkeRP/4m6pOEp9ZTRDFPJRkm+MDL9hhPsZ5VnAQ5QuUHI7F0KX7ZqdWDr
         zwbqqK0y6uhGcUDe2vGB0fFsc6DmXhDkSqd1h2usdkowEYMGMxDiVOWXgN15Ro1insMo
         8oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUIn3hEw6JYFkddfNv6BL46EZAbPO+C2iSOKicXTGNM=;
        fh=HFsVcJgUypbhncHewZRlNIlVY3lPzJibifEyV190lyE=;
        b=VgYMp3YPrRdjc8SEiAlSscjAgH5XSBIJ/+zsf0XABNsFdU+R7XNw7SNgCLnF7JSxfG
         A+nqU4BN/gNp2lD3FI0MBvB0hn+9tyeR/srRwCFtfeJhIAhF4OegxSU1SyVz+7CJn8Nm
         Zy765fS0Zr5a9GvLCekWLjyPk5mM4/YEPdNeJxp7qTAU2VQXnZbSWk3PLa0aRcM+BpXT
         5bC9zK/dxf3ZsEzaTNQHqpkk5sAbvJw7HTfY+VAH/nhUEg16X8scnihRyD9+9cPINYNS
         HadB6uBIsl+WMgEiSmiVKHznJ2IQaZc+PvVhjR6YpthL3rnfQaBi4ZD1IQx/wa46lugY
         U1lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776712997; x=1777317797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUIn3hEw6JYFkddfNv6BL46EZAbPO+C2iSOKicXTGNM=;
        b=B3VVBkaCz0DSlWRysjem6+2RdUQ1uDcVpfWW9kubqOGtWORcANAPRm2cEpFdWmsk+x
         INcPoxDnEkQ8L8+K0W+BKn5N16jIBq8goQHNh1FfJtEU6w2ewgO4487OSTvlcwfulW/W
         KUxzwhMNrBvka9XiPINFr3NxJ/6X1j1JXQLFTjoMNcWvm1T+/EoH1iQbl9gBe2bpMWJM
         6tzY+mdKpKVvhfBYXeMD6H0L+2in/EMyRWpdyUcaJE6+nx/EUQhYHOnTEb86dAVOedq5
         wQd/q+yWw/KdH4JylXtP7EIFztCmikzOqGZG8zqGxqBqHlhmiJjvRsoeNiFFQV2lMd2s
         Ph+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712997; x=1777317797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUIn3hEw6JYFkddfNv6BL46EZAbPO+C2iSOKicXTGNM=;
        b=h+BpZ5PM2pt4hidhP7HIiwSUBmPwR/XDsujKL4T4kWZtB/SUhE0L0KeDO7hxUYYuhk
         jFKxeWlYz95t9hwUXrzVRAnSAQTteMSw/Pay5Jw2Dxj4//pw2ZvAa7UZI9005Jn88uK4
         uTHaWSlBUqJxtoyexl+dnfhZtA359HkRC9QtOIe8A4wotAm2po3GKPR5D/nDpnDJPpFY
         37ok88FMAoAlQbqXbkH3mO0DArZSoqZOLx1NTfxQLfBWG56hxrtQI/cR93d+t6uOjVN+
         PI9eseoVPjVUD9s4ZMGL+2S/FfkSXFTsURbhPnBM4fDHLIquDIoz+Ik7jcAjDJkEp50l
         EUBg==
X-Forwarded-Encrypted: i=1; AFNElJ+Wr+M17ff3RLT3Ds8KYGOd4ZYyhE+8XWGj94R9gja9GO6gRAi1F7Bv2q5NFFL9gaHvqaB1uJU/DIc8fnhy1dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnOOvsZVoPjty2rnlq2ruF6+3kRSIrjTHP+plKOEiggXSkZJt
	RYhpBp0Aq+mCxs303ZpNay+HNm7f9RM3gIGhZohcqG53k/B5k5s/6u3M6zTWrKLuSjzBfeNvRgY
	/YDQEH8gX+Iv+HGkjawu0tesua3e09cc=
X-Gm-Gg: AeBDievEqZZ8jcoTvFFx9tgmFVt1SmlNXOdRPFll3qjVjZn1VlbTCElQ1SfA7WPCHjo
	YJXDR6QdyZcOBebMS46T1986fHcez11fiaMpcDsq6wJUsy9fL3lIfTJOnZgULrYObtQdGvh5hQk
	+cOl6f2Lz6bN46r0AzX5C9OpIzKPVTZmW+0XJd+yQUBmWVOZMyb2CiaAmvC8GMAqGsspeb1htpu
	rZfEhuPy3XXEofjFZaQmAzKLhnrz3+2zbPnqvGKagW4Nqj3SDe24G6SFoDUrO1PTzXBG5fwvo30
	sX8eKu7G07y1OdsOqCMfyoQ8r0Inq0NSixueDkE7xfe9yv+cU/grCfA1tZLWD4gnOgv7v5M7lNg
	SKQ==
X-Received: by 2002:a53:cf44:0:b0:651:b86f:3657 with SMTP id
 956f58d0204a3-65310a0bde6mr9520237d50.36.1776712996801; Mon, 20 Apr 2026
 12:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418053401.128483-1-suunj1331@gmail.com> <20260418053401.128483-2-suunj1331@gmail.com>
In-Reply-To: <20260418053401.128483-2-suunj1331@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 15:23:04 -0400
X-Gm-Features: AQROBzCElDRvhVtJbXCcMB4PIv35kNLuKPjgXleuneDJqn-BnYQgD22cYaV6t4o
Message-ID: <CABBYNZLBoU3byfK_G+=sTkBx3wNwEh2X6_7dG4+4LFtrc3Skpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, me@brighamcampbell.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeungJu,

On Sat, Apr 18, 2026 at 1:34=E2=80=AFAM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> iso_sock_connect() copies the destination address into
> iso_pi(sk)->dst under lock_sock, then releases the lock and reads
> it back with bacmp() to decide between the CIS and BIS connect
> paths:
>
>     lock_sock(sk);
>     bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
>     iso_pi(sk)->dst_type =3D sa->iso_bdaddr_type;
>     release_sock(sk);
>
>     if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))  // <- no lock held
>
> This read after release_sock() races with any concurrent write to
> iso_pi(sk)->dst on the same socket.
>
> Fix by performing the bacmp() inside the lock_sock critical section
> and caching the result in a local variable.
>
> This patch addresses only the bacmp() race in iso_sock_connect();
> other unprotected iso_pi(sk) accesses are fixed separately in the
> next patch.
>
> KCSAN report:
>
> BUG: KCSAN: data-race in memcmp+0x39/0xb0
>
> race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by tas=
k 549 on cpu 1:
>  memcmp+0x39/0xb0
>  iso_sock_connect+0x275/0xb40
>  __sys_connect_file+0xbd/0xe0
>  __sys_connect+0xe0/0x110
>  __x64_sys_connect+0x40/0x50
>  x64_sys_call+0xcad/0x1c60
>  do_syscall_64+0x133/0x590
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00 -> 0xee
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 549 Comm: iso_race_combin Not tainted 7.0.0-08391-g1d5=
1b370a0f8 #40 PREEMPT(lazy)
>
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  net/bluetooth/iso.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index be145e2736b7..14963ba68597 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1169,6 +1169,7 @@ static int iso_sock_connect(struct socket *sock, st=
ruct sockaddr_unsized *addr,
>         struct sockaddr_iso *sa =3D (struct sockaddr_iso *)addr;
>         struct sock *sk =3D sock->sk;
>         int err;
> +       bool bcast;
>
>         BT_DBG("sk %p", sk);
>
> @@ -1191,9 +1192,11 @@ static int iso_sock_connect(struct socket *sock, s=
truct sockaddr_unsized *addr,
>         bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
>         iso_pi(sk)->dst_type =3D sa->iso_bdaddr_type;
>
> +       bcast =3D !bacmp(&iso_pi(sk)->dst, BDADDR_ANY);
> +
>         release_sock(sk);
>
> -       if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
> +       if (!bcast)
>                 err =3D iso_connect_cis(sk);
>         else
>                 err =3D iso_connect_bis(sk);
> --
> 2.52.0
>

https://sashiko.dev/#/patchset/20260418053401.128483-1-suunj1331%40gmail.co=
m

Seems valid, so we migth just use sa in the place of iso_pi(sk) to
avoid using it without sk being locked. Other problems it may reveal
need to be addressed in separate patches.

--=20
Luiz Augusto von Dentz
