Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE4340285
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518240; cv=pass; b=OKp/dBcyoE1gUlAd2tRAZdAPY1Gn9bZLGKhZ8QgSTWV//6vSmeHg5wKrNOhj331jx8HVGlMiE8IU9TK1d+ciSePEl0TaFE1wyftCKkZn9mAqoW82BmKfNU0LB/ns/rnKmBK0MFnJR0bU/mITSiqb7PTf43mfCRsJ8rimEXJtc9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518240; c=relaxed/simple;
	bh=Pet/c2OGnY1gfQmFiC8Mebb/GP6QRqCrlNN3wTZ2f2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USr3wMp9Aohfs6fB5/+Uiu8//hL1sBxatVvg0l2HrqKhgLb5EGH50wOBLeC75kgWMj2U1+ne4J3DsmLzw1J8ZiAJkcOGa9dRKcEDo17+HvJxTM4tJY1z03/Yb50FEt8v175ZprRM1IoPG4UnKt05e4uTKt5BY6bb0omdoy2HQX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrZJT7J4; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZJT7J4"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8947e6ffd20so12562416d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771518238; cv=none;
        d=google.com; s=arc-20240605;
        b=jjzTaxYkry8fvFkr1I3MSDWId1JaWrsfkVJEqvEleedGhlcio7AA3E7hzUXrHD0Grp
         dgGxMUHEFJfW9OzbHKG+Fov7Oa5KOGuHgnw7Xk0UcALqi3VlwbrKbdzMGY8tOfbwDZIG
         BHrBf0EkhRQTKGTZ6lqpLB9LZmi8/hQ2yIpxZJOfFUyVPMSHv/PPLrpXeWI4drf3k4xs
         idIfiB0kWvr7Qp0bVPog0BHgAuI4ss09BP05g7wfx+tJ34MGhTPCMMqQVcUm0ARKIzDs
         3LJ8uSyo7Ul1KeZxGtbaX9qMTys1r8A5lwl7UavTTxaI2nIah8S80912TWbfdy3b51YV
         76IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4yeHhzpJN+4nhHpP7a5dAzytay7Sndg0H7YbB+nOFY=;
        fh=a3464CWZ3GN/AYyjOX915k2VheWVQUv+mA81mMAF/MM=;
        b=EcVZ/Zv+QtOvtmBlrGG9aR2hUfHNgizKxx740seSiDuwLCjYL9fj8HcHeitTSSA72c
         5y2x8FTDrzHDrDY6qYn5sEpIIqSO5FFE5FwyRYd82oYhEBlEuHbrK2sXVtxTfiFYP6Z7
         3+TdM7pn62UFaXW609RWjnELmzbfBV4OszAepRIbEK2dvQsq0ZVYJK+W3VULRV/0Dp2+
         WWQaJxM66yokc2BRLD9B3Qb1lVyCdQHUoBZFCEFrlOiDotL2hecKq3jNYnKuG6jtbFva
         3FyJCdBvbHV7SA7COha5Evc3Q5hsmxwx/vAWgekBdcB2RVPJXKfFe4yBuXzLeipfoNBK
         iHmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518238; x=1772123038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4yeHhzpJN+4nhHpP7a5dAzytay7Sndg0H7YbB+nOFY=;
        b=mrZJT7J454lOVT2fHTGATGc4l8IO2bPDStIQnggw0HMTtL4ogP7jQP4B2SVnvHEQHS
         6ZjV+PkQp59VtiFOYqr3o+cnTcAY47usUPIjkj/eqhojDO2zR+sZ2F0Dbh3l9A158lyj
         TBKPq4T/kYOtPMAWoIzERcvj/Fh7M1BhLFce2yp4Pj8XKzYFk+P1iTiuKiV7Cuu+GOdg
         jUJ7fC3/+mWXSx6eaGBfQQ8zk4Pz69t7RsnlphkJp2Jfe1hn0zC9SJpdyfkYwefRKutl
         qL5ot5zxVg5oehijT0c5ji5vo5TLK+qkShxz1jsjx2CQE8ApboRDYcC7J/3VWlJZYCaB
         FIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518238; x=1772123038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4yeHhzpJN+4nhHpP7a5dAzytay7Sndg0H7YbB+nOFY=;
        b=wCTmHEUs+cNXQGVHrkmtGvAZzzUuzU22CHEcEw1vHL1dwZq6b4J9fme4wXTv6dogyn
         z7gx97/zhEAOuVYpUl1oy7leN9xG78dpjxgnIcL+1ZupSP5S+Fy3qWKJk95BIOgoTArM
         wzFf1ykprPPzp3NCz9BXGN3QO5ZJHjsKgiqDGdKEj9eEgc6/b4QHMPC4AW2aJbDjoYaY
         sl1Va6qEyuGJpLfg40RALPG4QIjn6iUSUJpw7b+ZJOps+NbBFzO0qOIGTuflBuPMx8DZ
         I0GwHDyDsy+2Y4h1C/u6tyyDzivgkX31+nJblaataiMqcmH5vutFjFOEx+Z11afIm5W6
         /Qpw==
X-Forwarded-Encrypted: i=1; AJvYcCU4EBelLdI8h6f4XCQNuDOjx/IkAO17jHIBxFNmDkdfYFM+/tuN5W5MEiPVgJNCb1tPmLoHpai9CrEbUa/YXLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtslxo5dJ7WnelnbDB8CRtaOQSRT00XKHD633zvI0FCRR2YK3f
	p7HS4dvzfED185XMWZCn/G5T3soYtt6fNd+zXkWxMG0JXoo57OXdHiOA3IbIPeqnw335qgBUL81
	FINFZkD+66+Cea9R1pZCzMlsOCKko4sQ=
X-Gm-Gg: AZuq6aJ13ZtY6z7vpRhj+DgaWaQOX6nzlm/NFGzIGq3/bP/IcxjE+Sw7D332laTjIGE
	3iPr7cINNvtksNZTKy1zWd4NPRj6VQO/AOylTMSMmmYPEiphLGQ4M7rc/FRywdvPQsMW0FOMAUy
	ySxM+LeC26QKpcP0oeXOs03PEz33k37WdqI3qnq6nZK/QTmYsDqo5JKTK8pLExpDhSSWT9b4v5Z
	dxXAx3rfWDgixXjDa5CvOgc+Q8ohCsZZwtbwW2kb9IxA4ye76PYBGhh5TQcREkJRMNCW28yV11p
	o/omylk+WNcouTYwcD6u7MQBPaj86K6lCn6Hzoj3AOX133A3l6aBW1rA5yhpUp4fRZFyqArWnYi
	ask2kGVrusHxBe9BayzQMB8G6
X-Received: by 2002:ad4:4ea6:0:b0:896:fb02:e3fc with SMTP id
 6a1803df08f44-897361aba19mr295664726d6.38.1771518237674; Thu, 19 Feb 2026
 08:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
 <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
In-Reply-To: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
From: Daniel Matsumoto <insidetf2@gmail.com>
Date: Thu, 19 Feb 2026 13:23:46 -0300
X-Gm-Features: AaiRm50d6W_5fE_7G4yZsWAY8m58LxN519vozyjLw2jc2sNJvuLhnez0JhwrDVQ
Message-ID: <CADbaWgEfX87oPoiO3vdn_s4=Q4TVRVzh=qDgewEC-t2Xa9gU7Q@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: luiz.von.dentz@intel.com, maiquelpaiva@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Makes perfect sense regarding EXPORT_SYMBOL. Thanks for taking a look
and dropping it.

Regards,
Daniel


On Thu, Feb 19, 2026 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Daniel,
>
> On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.in> wr=
ote:
> >
> > Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow in
> > mgmt_mesh_add"):
> >
> > I reviewed the call path for this patch and the overflow condition
> > appears to be unreachable in the current tree.
> > The only caller of mgmt_mesh_add() is mesh_send() in
> > net/bluetooth/mgmt_util.c. The length parameter is explicitly
> > sanitized before the call:
> >
> > if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
> >    len <=3D MGMT_MESH_SEND_SIZE ||
> >    len > (MGMT_MESH_SEND_SIZE + 31))
> > return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
> >       MGMT_STATUS_REJECTED);
> >
> > Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which includes
> > the param buffer sized for this maximum length, the bounds check
> > introduced in the commit is redundant.
> > While defensive programming is valid, tagging this as a fix for a heap
> > overflow is misleading for backporters and security scanners, as the
> > overflow cannot be triggered.
>
> Yeah, well I would say it would only be valid to apply defensive
> programming if that function would be marked with EXPORT_SYMBOL so it
> could be used outside of net/bluetooth context.
>
> > Please consider dropping this from the stable queue to avoid
> > unnecessary code churn.
>
> +1, will drop it entirely, it seems I will need to ask for more
> evidence as apparently people are relying too much on LLVM nowadays.
>
> --
> Luiz Augusto von Dentz
>
