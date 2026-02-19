Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507033D6FD
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523363; cv=pass; b=FlXJvutUWQoyKLjPhYK/CEOn5sDjSsWgQC4WVhWzY1UYoCtdYBjKflBhRyr51j0Ii7Oc6t10QTCVRnaGwEWJsgQ9njqseYiOpNPqzrNGX0KWtETs3BCxkth+tW6dsRUH4AXIBVOksWs4oIEIul+zJmlOhLlUvSGr29knS5bjVH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523363; c=relaxed/simple;
	bh=nthbS0viVjFrlhnBCE7lWWs7/UpBfZh1k0Iq3ugZ8n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ohkv4j40jVE5h8FqaBLqEVtrDuR0ExlmTsIY86zMH6IGk4IB2ro7n8eMfidvkAhXEHBMDCzRGA/lnjrhdeNv78qjAqyKfLKDCpHcatmbDJFc11+N1nlfo5pxmKJxTL0DypD5JnGQeRFx+7OmBKJp2RGYFVJLpat8TbsIgHetFUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5eaFwji; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5eaFwji"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7962119ff2bso11706517b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771523361; cv=none;
        d=google.com; s=arc-20240605;
        b=cCjWdNBhgLaAYcteDsqLvUdDVt50rsC62iXKhct4vJSDw16zDJb3Z6aZ7grBJDlvRr
         bjhXqdyJ9lW1H5ZBxfECVf+ssm9yfQH85tDSyqM4nay6zFl1wOl1LHIxnj9piHAdu4Pi
         auT/6IE6RS1Rh1BJmRtsg2kz8HU+lMwVozMAojWKStcelvdX3mWQws1GBvmM90pdMURH
         4tD5/UW/fO1gQyd1k8u7SWXHSJDKZO30zIvSImQsNk0+48dF4pGA/Amm0q3/r2HWF+p/
         H8uE478TP6a2Xei4rdIQ8eiFoBThuH7vERwHHo7L4/kVInTHEtEDk00P18Tb2KtNQlvC
         qmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNq8j0WObSJ7gPKSfbCO7fM3Ese3EJIEbd+/lawWf+4=;
        fh=kfigm9GWMXH/m2kiGktfQi/nK+pNMP6q5XnKGns5ppA=;
        b=T682pSMLzspvDemXtwqhe/pVTSeNQtf91D3j7q6ZJvCfLiWB7HRHLl3eoaVDr08bta
         H65ofgpSTwzVfkZP8lDjv88R7ib4xSCddLY6yo9dNXDbnFigApYNtaNkeUpEtYlrOHbh
         eH/+VzC2n5CWM46qLs1BZGUxCa7n2ZzMbK/YVSrWvx2ThuF2dFjAvBOIEljTqThu/+6U
         bpUFRQFO+A2r8XJTqJTjYs3falSnmr3/bq54+AujxGkOzjdntruaXZfQuf0W6x/CHBTW
         DBXAiTvOs9BvaW3jEeDhZa1PAIWBTjeN9nlewIfg+sJMOuX6JXFjLPfCHEg4fDUJqBWt
         3lhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523361; x=1772128161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNq8j0WObSJ7gPKSfbCO7fM3Ese3EJIEbd+/lawWf+4=;
        b=H5eaFwjibveyfStWBXDAHbmpCNc8oIlhXjPGDD9b7bvERL/omWio7xdSccZZkyGPx5
         CH/kOFlzraNnqZNpETdb3Tk8VnWwTJbQILdB2AxTK99wTfOH4FXJNJ0HWd2qiDEP9v/c
         roHNZaAalojbiCeWSdquT4PCYcdgfvkWuol9efIryzsS6nv09Y4V+wdvGukSPoS66eI+
         qksN9z7VJ6Sln5BTPgelL0NsUFxvRasJE85BXeD1c3PleMcbKcR7ALpuKveh2tCxnLfU
         ou67PW3yBmAp9LCf9ZHj6S9zLMzt1zVsefohS2bGnjpK/m3jMJCTbq/PIhKEfAuppCJS
         mJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523361; x=1772128161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNq8j0WObSJ7gPKSfbCO7fM3Ese3EJIEbd+/lawWf+4=;
        b=u8S00aNjqVTTihCHi7cBpNtfuvax4/O0nB9JR6b3oCflkHrmCo8wITkS+C9AgIqMNC
         1tKltu53A2N8255FVZh0k0E6k5H46+3a+ken1ocjxPj5smabhGZ8kaBxk7+/maT/RSzw
         9tnc0IdzGsMsmq9Qo2aqjatKv4TFee+DMDT8tS6h3jl8wn8J9RoNXnzLzGbFI49tZkjy
         Ssa9AjdsnD3EUr4yxr76hyBkdZOFteaaW9GPhzffkIKC+2JQHYV2LFDqiES8aRAfuRYg
         L1DzuOUBuWbs0FLngP+uZeEN6Y8uRHsc5zQ/Gb+N2bYIaaKfef1c3TrH4ajGW/FKhzzg
         OGYA==
X-Forwarded-Encrypted: i=1; AJvYcCVwQ9AIT3I2f/3qby+DK+bxXRaGjBF/zlzV4gE23+xBsodnkKbQfzu2aaN06h57EebB3g/AW3E3vEu4ok5qzxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUS3ARYwx4ujHJH6sMEOC/o8nh2VnAC5dB826K9/jqq0LKQYDQ
	6GgD5o7VONdhlYA+u49z9AaT12Ku+9EzaWs97fzqDYFb7c+M9wNlJXRVkCLAgac0ctfo0arTBKU
	1q+dmbh04K+xD76cde7RAWcQArj/o33w=
X-Gm-Gg: AZuq6aJRoRv3k4vo2mRWZLVl8gs+/h2xKi/XdtmzP3eddJzSHKznT31sSxSiPsf4gt9
	SaR6y9r4JEblhWvX+YF0UpeeAfPmHQqKtZdiKojwxuOyE7j1EHxJx6l1k7Bwq61ZRL/erRlG5zc
	cmSJ21S0dNHD4E/bc2Dz8Mpai+BsLN60pQkgI+KGEpvSvzVKiEjWak8WhiOnH5UmeN9u+9Onl5Z
	RCLKouo9nsU2cmYyn6JN6QoU3pLHfCZGZU9EDq0JDzsNVBKEUi/KRTDXO6gKpd+5eWMtb+Qf4NL
	ko/YBJ3N4K3YgtkCd2B+oq3ANjoJX2fqGHlntsTFj3pf+d4GWKJQHO2XhWwOzJkZzYBkxg==
X-Received: by 2002:a05:690e:130b:b0:64a:d7b7:8fab with SMTP id
 956f58d0204a3-64c21b8b654mr15264045d50.91.1771523361363; Thu, 19 Feb 2026
 09:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
 <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
 <CADbaWgEfX87oPoiO3vdn_s4=Q4TVRVzh=qDgewEC-t2Xa9gU7Q@mail.gmail.com> <CALGDAeCGPpEjJonFJ5q7tg7UhJwp+CnLO9Fb8U6dEhjGzRS=nQ@mail.gmail.com>
In-Reply-To: <CALGDAeCGPpEjJonFJ5q7tg7UhJwp+CnLO9Fb8U6dEhjGzRS=nQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Feb 2026 12:49:09 -0500
X-Gm-Features: AZwV_QjYWiliR1zasSh8flKtwogXUGhGG_iQzwQpvtfDZaoyhjDTUMVfQKN_vMQ
Message-ID: <CABBYNZJ9cSB_-Q_yVPPivqHCPw+9DE=mfN0J3oqDSm0naDxwjg@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Maiquel Paiva <maiquelpaiva@gmail.com>
Cc: Daniel Matsumoto <insidetf2@gmail.com>, luiz.von.dentz@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maiquel,

On Thu, Feb 19, 2026 at 12:08=E2=80=AFPM Maiquel Paiva <maiquelpaiva@gmail.=
com> wrote:
>
> Thank you for the detailed follow-up.
> The explanation about EXPORT_SYMBOL makes perfect sense.
>
> I was analyzing the function's limits in complete isolation,
> and didn't realize the context of the trust limit within the module itsel=
f.
>
> I will certainly use this as a great learning experience,
> (it's never too late to learn!)
>
> I fully agree with reverting commit ac0c6f1b6a58
> ("Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add")
> to avoid confusion and unnecessary code changes,
> since the function that calls mesh_send already handles sanitization.
>
> Just to confirm: what will happen to the other commit in this series that=
 addresses the blocking problem
> (003ca042a386)? The handling of the mesh_pending list was indeed unprotec=
ted
> that's exactly what guard(mutex) is for.

That seems valid, although it lacks a reproducer, since we need to
protect the list mesh_pending.

> Thank you for the review.
>
> Thanks,
> Maiquel Paiva
>
> Em qui., 19 de fev. de 2026 =C3=A0s 13:23, Daniel Matsumoto <insidetf2@gm=
ail.com> escreveu:
>>
>> Hi Luiz,
>>
>> Makes perfect sense regarding EXPORT_SYMBOL. Thanks for taking a look
>> and dropping it.
>>
>> Regards,
>> Daniel
>>
>>
>> On Thu, Feb 19, 2026 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> >
>> > Hi Daniel,
>> >
>> > On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.in>=
 wrote:
>> > >
>> > > Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow i=
n
>> > > mgmt_mesh_add"):
>> > >
>> > > I reviewed the call path for this patch and the overflow condition
>> > > appears to be unreachable in the current tree.
>> > > The only caller of mgmt_mesh_add() is mesh_send() in
>> > > net/bluetooth/mgmt_util.c. The length parameter is explicitly
>> > > sanitized before the call:
>> > >
>> > > if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
>> > >    len <=3D MGMT_MESH_SEND_SIZE ||
>> > >    len > (MGMT_MESH_SEND_SIZE + 31))
>> > > return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
>> > >       MGMT_STATUS_REJECTED);
>> > >
>> > > Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which include=
s
>> > > the param buffer sized for this maximum length, the bounds check
>> > > introduced in the commit is redundant.
>> > > While defensive programming is valid, tagging this as a fix for a he=
ap
>> > > overflow is misleading for backporters and security scanners, as the
>> > > overflow cannot be triggered.
>> >
>> > Yeah, well I would say it would only be valid to apply defensive
>> > programming if that function would be marked with EXPORT_SYMBOL so it
>> > could be used outside of net/bluetooth context.
>> >
>> > > Please consider dropping this from the stable queue to avoid
>> > > unnecessary code churn.
>> >
>> > +1, will drop it entirely, it seems I will need to ask for more
>> > evidence as apparently people are relying too much on LLVM nowadays.
>> >
>> > --
>> > Luiz Augusto von Dentz
>> >



--=20
Luiz Augusto von Dentz
