Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B97363C63
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583729; cv=pass; b=m9O4SvJq3SM/1zJJSz06urAWuJd/6EmYF+AJAm4kWv/LvlY0dyGoHzBBmY7VejN4s0wM9Zr6c1aCpP/Ds3lKo0riG2Bb5CFLYrZM5yKOnJBAIqro9DCePgmrC7af9zhnO9RWEJbN6Ut9e5A8xYK1BpOL31p0atwVwpfxckJT5i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583729; c=relaxed/simple;
	bh=8htVseq9wQKiK0UE4dDd9JnlLWJaYWLtXE9iyBFW9As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzO5BKEZprJED4OmbB5IGGt8Z/egBPKl5CmD3gRfS1n0It7dIy8Ocposqo5AhhPFGvxiiRGTT55gvGCwadxbn2ibhONqsz+uh2zaJ8IYzd6c/az2xQU4EXwySG4xwyOvS1KxuHQfKya9LHmm+DaG8KQIH/+a28aVjRRxkvWFrxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqHDnuj1; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqHDnuj1"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c744a00edso2212720d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 08:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787583725; cv=none;
        d=google.com; s=arc-20260327;
        b=T7EQ71Vt06gOmLLelvB0NGSjtTQHEBE1Sgpphw75T1PiToC2eit9bcGJfKGHEBWXwd
         tc+fnLBkaikLHO4yBA/tDTVSx5a9gkBthrg/O+JoEB48nU/QWc/p9vd7pO6MTVKjFxmT
         LwBKvtBBGwnl8BkbOdc8TnAd2nZmVVek8YloLYX9i6OYFAlZBQZBAZhgHdPNhmQ66jxU
         tPPsvklf/6Bp3GJyOE4uMbnftc1b5LVsnB3syW/+FAJ9QZJsUvs+rtiM6/XcrIRcNqG4
         71OrpXmPWJwHCo6Zkl47i2SrbafAPXIv2R+mA4suYWiJxDws46jeLlAADNAws3qjzsMt
         xWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0FEMUJZQVmX93REvnJ4GsWEzwIniTrdgUugr/eES0z8=;
        fh=Ihq42f0kMl9s0ceeGl3E/JgQh2K3IBhapAZ/zO/4CPk=;
        b=SoFQgLSWVz3+8yYraFINQsunSNpg5JUV6soem3uq1o+6VGL3INj6Cz7wbl64s6S8h2
         aj9pxgUo48zL/3ovTS2lul9VSoeF97UbTh1Nsdn3noLGghWispgRIuy71CZq3XHrQGsG
         LTgwpgDpmBY+G3mxicFeHOD+sATV9i+CFfJcLLFEsQrdelv69Om+Vz4Ql7XOYM58Sdfg
         IWtPu9UjJ9wsBXWMqQ8n0Mh3zI6qUTtAkmcW6VW0xqfWw2RsNRkPNKokPbiPedGTktUE
         DJUt5P/hCRUPIdTVBWIPyLxbAQjHI3M4BC9VeINO15VvxV5Zcyb82420/fQCAdHDdv8S
         /Eyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583725; x=1788188525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0FEMUJZQVmX93REvnJ4GsWEzwIniTrdgUugr/eES0z8=;
        b=NqHDnuj1+lxh0iGUTQGJA9oo5OwqwV8EOiXupnKHSIx287Jyavh3kUuZeArCV5tXqi
         nP9vfhoeIqQr2lGwF1mMBDkIGS7tbIggAFCthuJMtAqiYIIXGVZfhtm5LIgpKNb5/udZ
         r4sd5PmCa5To+qIdLgSJb14tfEa6Jvp9bcxGBivYE3EBB8s7PeDMtPkzWmveRIGObbE8
         8x+mhjAxPLPQ9B5zoZLfi2cLis2bXpPk9wfMqI2gXgYUw5ha3mYCD9fxw+HUNVSaKWTd
         Uyw5aYtGUvRhZAtJa2yE7QA9Dhhb6k3kxb1gVexU0k7NfXvUVqEh6chzQSbK1tFSS/9U
         jHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583725; x=1788188525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0FEMUJZQVmX93REvnJ4GsWEzwIniTrdgUugr/eES0z8=;
        b=SP6OuGD2DHVJro2kBqmo1Do354kSjJTS/fbjo4L5ulOxw1cePEjMzYHiKJOAu6zsZt
         a+fBvMJb53BhSgjtjHF8Aekc2/5mdIqMRCuiSeGJy7iaNQOa634CYP5JyWxMN4qSX3NB
         PL23bhQvhE9cZNwzZa4UMZUwIeghfbxefmT9B17KGwPNFRdd+yjKZFvm9cl3vh46TwAv
         oX5OesvJeLsuktxLbuio8EAVcmAos+eS/g8GmrCIX356dgPgwD4LusCuOfcisIRD9l85
         10TjMwZrxXIOCFNX8bvMeoImatC8CXUsMcnwGucSFNG3wSUQn7LPc01471Fvxz/5xBCH
         2ONA==
X-Gm-Message-State: AFuF++k6vLsviFmmX6oYdZ9UEfuaawORK2DJYM1t9cjjef8qMPPppt3T
	ng2uod//HMj/cb4yWVVw0Fi5a37uyDShPvHnv9rk+QUXLCV5vEBTkzFO6Rby1Le525H3ufeAQyz
	19q9i6XhQIdbunj9L03CO1XUB4j/rdfQ=
X-Gm-Gg: AR+sD11PJ4yTS5tPiSR/V5ssknCMrZkKfZR/7+HMu8cTM6WWHkhuEMFuMvBqovaa/u4
	g8v0lwl2+0sLqdsoH/HXFXBPpFjvLr5GYhCaFSuMCajkkUBLAfyacXyo9fPzkwmZbVd4u3ccHn4
	gEUb4I9CR5/m3CMsIJKAoPuuXf2QO3oFOeJ1GB3ij8RlwuxnR+F+bYCAtyNx4UaRpDBFtL53HHJ
	JvbFI2tdHEsOWDSPwhGDktFnBbuHs5lHrGaH0JuktbqxFHakBbGoa2dMgjRQ8Y2duRPAKytPtVw
	ilyrrj4ZfXb3t5eYAtkc/Pz+aQXi/2Joo+AxSF9poMJA/g68j8WRNSbW0Dw7rSaN0js3Vh6Ro4d
	3TGoECNQiAl9i9ruPmZX2y45nDIoH
X-Received: by 2002:a05:690e:4086:b0:66d:bc2:8067 with SMTP id
 956f58d0204a3-66d0bc28453mr1305222d50.42.1787583724407; Mon, 24 Aug 2026
 08:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
 <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com> <20260824144051.50010-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260824144051.50010-1-acharyalaxman8848@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 11:01:52 -0400
X-Gm-Features: AcwNN1Wa_Sx4KTo6DQHVJ-mtw5XFv-5Ba7tmLh-coqhcOdt0jH_gninJBULA00A
Message-ID: <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laxman,

On Mon, Aug 24, 2026 at 10:40=E2=80=AFAM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> Hi Luiz,
>
> You are right that sizeof(*vnd_codecs) and
> sizeof(vnd_codecs->num) are both one byte here.  The issue is the order
> in which the existing check performs the access: vnd_codecs->num must
> be evaluated as the count argument to flex_array_size() before the
> result can be compared with skb->len.
>
> For example, consider a V1 reply containing exactly these three bytes:
>
>         status =3D 0, std_codecs->num =3D 1, std_codecs->codec[0]
>
> It passes the initial sizeof(*rp) check.  After pulling the status byte,
> the standard codec length check also passes, and pulling that array
> leaves skb->len equal to zero.  The existing vendor length check then
> evaluates vnd_codecs->num with vnd_codecs pointing at the end of the
> skb data.
>
> The added check uses sizeof(), whose operand is not evaluated, to make
> sure the count byte is present before the following expression reads
> vnd_codecs->num.  The V2 parser has the same ordering issue.

So you are saying flex_array_size being performed before size_of would
matter? Afaike flex_array_size doesn't acuatually access the
vnd_codecs pointer, it just calculate the array size based on the it
size:

#define flex_array_size(p, member, count) \
__builtin_choose_expr(__is_constexpr(count), \
(count) * sizeof(*(p)->member) + __must_be_array((p)->member), \
size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))

Same thing as to sizeof(vnd_codecs->num) that would be evaluated to 1
at build time, so it doesn't generate an access to vnd_codecs at
runtime, maybe it would have been better to change it to
sizeof(*vnd_codecs) if that causes less confusion.

--=20
Luiz Augusto von Dentz
