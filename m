Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94963352C4F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837849; cv=pass; b=OqxwFfl4YDn9xG6LeNdsrb8YMX2csaIqu/zHYRsFCeF8BGaWMitmnladNPqsaTd+qVc+ej3uOgBakZe4Ft4Gyl7t0YBBAbNadZ7D/mVt56wg3UEQu8a5V4Q+7rHtCaDJKiTadk0WcJIqXLc+0ZZ2veNJkKpFaMFCDs235mkwEW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837849; c=relaxed/simple;
	bh=HaJDAk3mIX9LRxG8QNvxqKNRvtTw9xWVThyEOEHtLlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrL7XdmCDVcel3XZD3GpjaTNbAxpAUge9GzUEhAu0sKa33SE5z6rNtUSz19i5MySykN6JcVaH+RFjPqBHpg/QoKh6hLZmtBJGYvnzNpc+I//tgEQDaBdgWYIWL3UL0dB5PqKiwdfjy4NFDIgFF5bUNXMo2xc4Z43KwaqcE40rmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAViBgB/; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAViBgB/"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79627af6349so26856517b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 11:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770837847; cv=none;
        d=google.com; s=arc-20240605;
        b=Icf3w3O3W7tKV3A2wcdvJE9HN7s7HOxQwC9IVHoqG9Geumgu6RWZVQplWqcOB/Sf+E
         oi2sNODmLbANt7MIF6lo0r3DzaA5FEh8FS2DYrEdVtfXiQF2bVwZ2ud0REIwuKWTJLfY
         kLhl9KwivEVnwBc2vwdBU/Ez24BfencnGzYCK/xFVVI2AqW+bP3oC/NgHTYLLghdd+Wq
         MRQQFh1t2rfH66iaOizkb7vxMgk1I2UR7tRnl0cOlesm7VjbwitagRBMWzIQkljTAHnU
         49yBV9c2aNPzic1oMmfjmmoGQYw2EmxblIgPg4kM8BD0fvpsFCQiwACzbL/AjD5to1eQ
         IhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJnoBv8wPxr3CnPnohq7c8MjeZhtuaqwUQXnscm8xaQ=;
        fh=ELLMRzgW11duZ9xSd82ma9utsw95HBVu55S3RojscII=;
        b=E2xXP/FLmyXNz5lv1E/M0WBk8R2CQgD9W76yPqCI7yGvowQYn3+CCaPpuv4kZOf7w+
         Ew24m3F0BLmYhVdq2u42Qmbewug7oklZxj9ukxhamns8irviwUG6DarA7aGWW4bqSi0v
         OQx1Tg2hKk0/QqMcE+msa3RFAATP90xwiotJyQs+WjHnml73j8Czjrk5NqR2EYyfu5g5
         6wNWFry3qXTAqvvI+xqEMH2G3YYpdOfFsg1uYEtmCyxJyz7WI3ez0vwgCeBfO6qdOoQt
         7kvGO2v4h0TZ+KCcxWFrYnctmbetuqyFE/hXoO6gKEVZotarEe54U/8HrKiPB1ecqL6r
         KzAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770837847; x=1771442647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJnoBv8wPxr3CnPnohq7c8MjeZhtuaqwUQXnscm8xaQ=;
        b=IAViBgB/BpuQXupko04njcr4QRCCmbmb3OipPUPxbgwfFi1NvNYdellYyy9J1MhPGy
         6dRWmipvvRWojB7og3HJm1rU02tg7I8YrZu7fQp11KwPgU8EWF9X9R/DDkW+z/50233S
         QMWkjz+X02Ip89w6QLjJ4G63v+yrKGlgj8WGlFiG2G86giqhHpPUzn8iE3A2J8UCdjlW
         6AQFlEXPZqTGNV2585cANZrip5VTBrUZ25wK+dNDaiFid/YZPFRGqKRJo5oxgwmm0wSt
         56hQDDLdE7IFtJ6xzzYQyQWjOl9t93FvAHw4aKfoSfQcona0XN0+fCwTpFShUNDMG1e0
         Z6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770837847; x=1771442647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJnoBv8wPxr3CnPnohq7c8MjeZhtuaqwUQXnscm8xaQ=;
        b=h+u0cA6LXYCKitngtPWpC2TZ5bjUu/xJXEmOEMZmj9C07LNAtdOgnp+2Jb9CxQqroR
         r2DvD+yCz3IF7LWjKBhQyetHneNPi86XQZt7WhF/QaP8bcH4YydBBnRY9SGb3T30hwIl
         7xuDQGbPAHpqJuQ6TVoJW7TzIjIsWMjWkX27tj30vq9H5rSFzYHXERrhNYQG98sS5y9Z
         6+4gNR0ISAWENbUArTTrwkNOzxAwNC3v2fAIYiaUsI86cMBBP+SfZpw7PNPizFQclM+m
         H/zxv37Zxs/GbFnZb/iUbLPwTkv60dCKO1O0NPUe5ep12YWzvV/1vMcdiR/snyR3gaYU
         tFRA==
X-Forwarded-Encrypted: i=1; AJvYcCW9+worxnHuqaK7i+sqpyD9+4LNLEPvmjNagO69oL+apROf5bliww5Pu+nyluvE+9qzOXclVkGNsL1VY9ztO9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ33VVyDXnchlczipGJCi69cYmF7wo+EtOBm5eUTmpAQuHZHqf
	m2QVUt61Wo6PUDdlZ46an5f0ch9nMeFC/8Xtgft0iPUCiScu/IHN1Fs2tBHWLBAMWbziQq2kIfE
	0FuKbI+9dkYu62lzShFWoDJRFufCtyAE=
X-Gm-Gg: AZuq6aLPohzUduLg0F398b2uIM5+ogboQhO1GcbyJ4xGhO/K8uc8EHi8FU6A2b49zcd
	AV0VDgsB64OfQ0vc7siyCpHX/V8GvkTbGpWMQ2fPyAkvQSC11Z6XeWZ/eKQ8331oZ8JX9RyI2dQ
	9wOAAkTrrQiB4VnN0icWfjaRJbOPHAMpTOevB2vYPbweDEwJvGvxc7LOpdTZ3hDPHLecJb/GzfU
	XR61T0Y79CnRStTxLy9nAu0+rt7jzlWuwPydQgfxKiXUvGC01aEB9Z7fnk4o7uyhLoKYGFIzcp1
	6rnSd0SgJaEwHY+idwS89DWJDuO2LSpF64ocOHth/eZQyZqN1zACLGW9zSOGwbvQQl9lVA==
X-Received: by 2002:a05:690c:2021:b0:794:f8b6:44e2 with SMTP id
 00721157ae682-79737646ecdmr8996757b3.36.1770837847465; Wed, 11 Feb 2026
 11:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
 <20260209080613.217578-2-vivek.sahu@oss.qualcomm.com> <7cb9a945-651c-426d-8cc7-1ec1174ac68b@kernel.org>
 <8fab20ba-9924-48a6-b417-5ebd28b77cd9@oss.qualcomm.com> <6def8756-f4c0-4b4d-a20a-205d548acf88@kernel.org>
 <4b049560-94b8-4a7a-a60e-c2e0c1e58683@oss.qualcomm.com>
In-Reply-To: <4b049560-94b8-4a7a-a60e-c2e0c1e58683@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Feb 2026 14:23:56 -0500
X-Gm-Features: AZwV_Qiki52fD9FbCMBTd-xyRPxluVccdPlhJ5DuMk1Nadw8GlM6bpa_i23w2dg
Message-ID: <CABBYNZ+qeXwqFj1Trnt_c8y_w_nKD36AwKbNdZ5SEtkXERuJxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: qualcomm: add
 bindings for QCC2072
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vivek,

On Tue, Feb 10, 2026 at 7:05=E2=80=AFAM Vivek Sahu <vivek.sahu@oss.qualcomm=
.com> wrote:
>
>
> On 2/9/2026 9:38 PM, Krzysztof Kozlowski wrote:
> > On 09/02/2026 16:43, Vivek Sahu wrote:
> >> On 2/9/2026 1:37 PM, Krzysztof Kozlowski wrote:
> >>> On 09/02/2026 09:06, Vivek Sahu wrote:
> >>>> QCC2072 is a WiFi/BT connectivity chip.
> >>>> It requires different firmware, so document it as a new compat strin=
g.
> >>>>
> >>>> Correct the sorting of other chipsets for better readability.
> >>>>
> >>>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> >>>> ---
> >>>>    .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | =
3 ++-
> >>> There is no such file.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >> The patch is updated on
> >> "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git" rep=
o
> > This is not correct base. Why would you base on something old, without
> > any in-flight accepted patches?
> >
> > You are supposed to work on maintainer's tree.
> >
> > Best regards,
> > Krzysztof
> Yes, I'm now raising patch on linux-next branch. Please ignore this commi=
t.

If it goes in via bluetooth-next, which is probably the case, then
please rebase on top of it.

--=20
Luiz Augusto von Dentz
