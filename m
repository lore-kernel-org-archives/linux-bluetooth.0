Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568391A269
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658891; cv=none; b=YpoB5jHaZT6h1iIGPBYlObXLVnG2QBswZK8Gi1CKb0BF/JIK7InxmyQ3P3uR5J6UDD+qJcY/1PG+q91hrbIWhUUQ5mmE0BTF6LEtNmGKychmxu0S5M51qqkuMYizqpxr0adSpsUtgY3A3snFf/FRgJ+SW1CEy66XJRtl9AdZ3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658891; c=relaxed/simple;
	bh=SUaOyPZ5v668vKbHtvNZQKlDEfpbd2Z7PsBoYS259xY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iudF6zu3kq1ibpnY85V/XSUTqyB178JCOadrmgei8acJLti5PC0xH/diTu+iQrOk1gjhqhO9JHAlSIcUF1CEZUVK23vxzCHhh4J9trxiLjaZcMcy1XMqwnOly/P5kaxW/knyxFFINYA6XgrZu2FLavogZx4m35lRJaaOpPXIRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb0vzhDL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb0vzhDL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c7edf2872so17288885ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658890; x=1729263690; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxJGXiSWx/kSJ/nVuy47tewqCMMGijHXcVTiMffTi50=;
        b=Jb0vzhDLyKzILOdCMImIOA6DHhd+Z+iQWMECH8n+iHx8mO5vlnHgNa/lO/Y7w3+pn4
         MyWmKfzNWJFUkKXHHdSoZXQ/I7umTACklP8niQcyKX5K+AqNUt5fu8/ZFbahQge3Sz9m
         wzhPPzLaSmfr/qhhQkziA6dH4YvZ7or9UuDD60CjYJ7RoPRwHA6eVW1zkGh2YZWGMNUM
         dhyFj15UVizL/s1xF6kDgM/VVkFMiKPOrY8fQTsx+Y3JtTlaiCfyPuZlghz2//YAeeXY
         KgcvKSG/6aytEOEeVDwhtLZG58/gAVmCES9tvRxu06+vaTrPNV1XscHfUH0JhnZ5bEZU
         j/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658890; x=1729263690;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxJGXiSWx/kSJ/nVuy47tewqCMMGijHXcVTiMffTi50=;
        b=UIBYDXzcTQ61aN1yMIuJBVkXpydDW043prCi3N22dvoUAbMB4YDfcstjfnKaoZulia
         zekrhiOP0dKWIbR09XrG2gGJe3pxKyDFFJdUvv5jzWgCJ7N3BFUNzHGJQIijjfEwImX8
         fq14m/Jw3Hh8aEmsmsvBLIic9M2u05GXvuOAqJkMYN6qQn3jqe48mRSihIXpuX++LUjZ
         ImTdsDHB7i3lkCcwvHdA03dGnFS6nItSBqLoXEjMZTaePgaJXTzOu3HI2fHJxBRCTDFu
         Fm1RJOzOnShN++WT4raxD7/v9ugCBWCTZHWS3RE2MCu61Vy2xuObdmnCVrvaJap4DTWA
         b4jw==
X-Forwarded-Encrypted: i=1; AJvYcCVffbKwyBvVXDB28njo0/01tEuWhoaJ/bKRpF6UjzGF2QUIatFHVz3tDk9Iy8YtaMZwrtIvt+pGc9u++Dkix4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsjomQwcllK1EyQxoTs2iBu+83kGsCFMAc2eA6xBfO0YR60pb
	xYKYnXeFXUfZPHADiKAKfI6D9i674kJHLe6WDSluOX9Je2h+p1s8XNwKIBMI
X-Google-Smtp-Source: AGHT+IFW1HyYXB25IUq4+5qX4ADoyxbjxL6YiJ9f82C0LBeYcwZRBfw9Y2RA/oxKZV+ND6CK3nnFPg==
X-Received: by 2002:a17:902:e88a:b0:20b:5e34:1842 with SMTP id d9443c01a7336-20ca03ff886mr52586955ad.25.1728658889471;
        Fri, 11 Oct 2024 08:01:29 -0700 (PDT)
Received: from smtpclient.apple (97-126-102-147.tukw.qwest.net. [97.126.102.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad32d0sm24376465ad.46.2024.10.11.08.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 08:01:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Brian Gix <bggixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH BlueZ 0/4] mesh: Fix segmentation behavior of Lower transport layer
Date: Fri, 11 Oct 2024 08:01:18 -0700
Message-Id: <B340007A-34B2-4F29-A6D5-6842EED8506B@gmail.com>
References: <670328b9.050a0220.66bba.9cd8@mx.google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
In-Reply-To: <670328b9.050a0220.66bba.9cd8@mx.google.com>
To: Junho Lee <tot0roprog@gmail.com>
X-Mailer: iPhone Mail (21G93)


I=E2=80=99m sorry, I was away on holiday until earlier this week. I will rev=
iew these patches this weekend.

> On Oct 6, 2024, at 5:18=E2=80=AFPM, Junho Lee <tot0roprog@gmail.com> wrote=
:
>=20
> =EF=BB=BFHi,
>=20
> Sorry, resending with a bad cc.
>=20
>> On Fri, Oct 04, 2024 at 11:16:16AM -0400, Luiz Augusto von Dentz wrote:
>> Hi,
>>=20
>>> On Fri, Oct 4, 2024 at 3:30=E2=80=AFAM Junho Lee <tot0roprog@gmail.com> w=
rote:
>>>=20
>>> These is implementations of segmentation and reassembly, except for the
>>> friend feature for LPN nodes, implemented according to Mesh Protocol 1.1=

>>> section 3.5.
>>>=20
>>> Junho Lee (4):
>>>  mesh: Implement lower transport layer for segmentation and reassembly
>>>  mesh: Add mesh conf for SAR Transmitter and Receiver
>>>  mesh: Fix inserting NULL into bool type arguments to false
>>>  mesh: Add features of Segmented Control message
>>>=20
>>> mesh/crypto.c       |  69 ++--
>>> mesh/mesh-main.conf | 107 ++++++
>>> mesh/mesh.c         | 125 ++++++-
>>> mesh/mesh.h         |   2 +
>>> mesh/net.c          | 868 ++++++++++++++++++++++++++++++--------------
>>> mesh/net.h          |  33 +-
>>> 6 files changed, 881 insertions(+), 323 deletions(-)
>>>=20
>>> --
>>> 2.34.1
>>>=20
>>>=20
>>=20
>> Lets see if Brian has some free time to review this set, one thing
>> that might help in the future is if we do some unit testing to cover
>> the testing spec, it is probably a lot of work but I think we add them
>> over time, with that it would be a lot easier to check if something
>> breaks.
>>=20
>> --
>> Luiz Augusto von Dentz
>=20
> Thanks for your reply. I agree with what you said. If so, what is
> something I should or can do? I hope this commit can be approved,
> as the existing code is actually causing performance issues.
>=20
> Regards,
> Junho Lee
