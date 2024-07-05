Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E023C463
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197306; cv=none; b=iRhvsdgEplMEO+wQI+TanJZG0Bfnql8R/WaN2O8uwDYxO0CsXVTaiSktdSkriQnPDhjhSZpQeWlHFi7/8S1bidBoXF41WhqL+HM7RKh1y1R6gzyPFVZ9VDyBmHGPZaBQxHNf8dEsXqnkMKsPs+kF45UcQ16y6Z53/6RgHgENHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197306; c=relaxed/simple;
	bh=Qpf7ffqlbYXe1H0vNz1JkjkRuJ/7L4HUw2AO8aWelFI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=hCNqO9Le79txsP+fbwD/U6nttuO4VU+F0hF/BNNaeP9NaX/Zi+2odwDZZvaawziQMcbRmGg7HaEB5eskhfmGkjCIQ4m8ZR0lWN8cd3wHvYXMi11o6h3rMpYbv4J0Jv/FiyLXIJqRfQGH9IQ9/JaLhB+THdU4W9p/8d5bKUGpLQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay1MTb5M; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay1MTb5M"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so1181901b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720197304; x=1720802104; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMryYRW8JpSBbMB1I2cmPVbMt066atVkXuVCmvwtC1s=;
        b=Ay1MTb5Mf9p57/WGQ2NAqRI55eAliWdRrBuRSeEzDC68vaCOUdcep0O2ZEujHYgNWW
         Pr/jX3smKCatJNVyEMu7GlNJa/GowVEiCU+DX286lSynyC99JSduYIB0ZXhbiHjds8s7
         rik8RmrHcouTv6CURz5sra+ibkQhQBvi0NeXwq92JAifkh+5/dHsBW0+A8GmZMXDXGEw
         D/W4t2w4h33/foT50z36ZATyvS6+22YeuO5CHnzo9gW9daVaFAmF5klYDJTGsJU/KiGg
         GoO/hlgb8coSWkxYdz83xvevFzBQheZrDXiokM92iffwIP6SjzhbJkQHiMHadcCkPcIQ
         r1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720197304; x=1720802104;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMryYRW8JpSBbMB1I2cmPVbMt066atVkXuVCmvwtC1s=;
        b=rGxKIAUYXh3aZnOSFB8gmHGuoy2ZkZh3So73rGnjGipmGaF+NM5Ca9AbKjooxZJKj8
         on/xke0/By1k8zhK5SiuNy09cgdngyxp2EQ5EtkpBJRRaTceDscrYWAnrtZ8HfZd0vIv
         TKNXjWbiKnLtU0qlbNOB/omkqKma0U1EICaGufOK2jxeOQwsIx8WQsN4fxEBzzEnq2Vi
         ft0Zh82XXBwDBZJVorc4ofOSuzYjcGWpkpanUTV8iZk54rKPJXva5bZFigr2iEr/WPXM
         Gz646hNnsi73C9nB6Xvky+781VeaL8JXA1bSOZCQg4XutmO2rK9rb7XR8SOh06AbXgCd
         05VQ==
X-Gm-Message-State: AOJu0Yz8m0rvaFWVrve9FQBIkOPBXTPe4eoYogIBY5qF527Er78f7tGY
	FKWeKErkxBLl2sQ2eCyS5UxHghf3tnG1Pcj9hPn3UODxcDu/SUHp0A6O3A==
X-Google-Smtp-Source: AGHT+IEG3iy5j4J5f1CXKw2oHy1auxlB+obj9xAtZbEBv8YwsUU1PPWKLoJdCHLBDJZxFXrC3DiTFg==
X-Received: by 2002:a05:6a20:a11c:b0:1be:c3cb:c4f2 with SMTP id adf61e73a8af0-1c0cd17ebbemr8708942637.1.1720197304038;
        Fri, 05 Jul 2024 09:35:04 -0700 (PDT)
Received: from smtpclient.apple (97-113-165-148.tukw.qwest.net. [97.113.165.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7610fe99909sm2593036a12.59.2024.07.05.09.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 09:35:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Brian Gix <bggixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BlueZ 11/12] tools/mesh: Fix integer overflow due to cast operation
Date: Fri, 5 Jul 2024 09:34:53 -0700
Message-Id: <5C0FE128-47F3-4F69-8CC3-816B565C3A3D@gmail.com>
References: <0b647d8fd3fd6e3ccf748bcdacfd4b89f5098ae0.camel@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <0b647d8fd3fd6e3ccf748bcdacfd4b89f5098ae0.camel@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
X-Mailer: iPhone Mail (21F90)


Sent from my iPhone

> On Jul 4, 2024, at 12:51=E2=80=AFPM, Bastien Nocera <hadess@hadess.net> wr=
ote:
>=20
> =EF=BB=BFOn Thu, 2024-07-04 at 11:45 -0700, Brian Gix wrote:
>>=20
>>> On Jul 4, 2024, at 3:27=E2=80=AFAM, Bastien Nocera <hadess@hadess.net>
>>> wrote:
>>>=20
>>> =EF=BB=BFError: INTEGER_OVERFLOW (CWE-190): [#def29] [important]
>>> bluez-5.76/tools/mesh/mesh-db.c:551:3: cast_overflow: Truncation
>>> due to cast operation on "ele_cnt" from 32 to 8 bits.
>>> bluez-5.76/tools/mesh/mesh-db.c:551:3: overflow_sink: "ele_cnt",
>>> which might have overflowed, is passed to "remote_add_node((uint8_t
>>> const *)uuid, unicast, ele_cnt, key_idx)".
>>> 549|            continue;
>>> 550|
>>> 551|->        remote_add_node((const uint8_t *)uuid, unicast,
>>> ele_cnt,
>>> 552|                                key_idx);
>>> 553|        for (j =3D 1; j < key_cnt; j++) {
>>> ---
>>> tools/mesh/mesh-db.c | 6 ++----
>>> 1 file changed, 2 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
>>> index 1d047691d240..abcc09d523a5 100644
>>> --- a/tools/mesh/mesh-db.c
>>> +++ b/tools/mesh/mesh-db.c
>>> @@ -503,7 +503,8 @@ static void load_remotes(json_object *jcfg)
>>>        uint8_t uuid[16];
>>>        uint16_t unicast, key_idx;
>>>        const char *str;
>>> -        int ele_cnt, key_cnt;
>>> +        uint8_t ele_cnt;
>>> +        int key_cnt;
>>>        int j;
>>>=20
>>>        jnode =3D json_object_array_get_idx(jnodes, i);
>>> @@ -533,9 +534,6 @@ static void load_remotes(json_object *jcfg)
>>>=20
>>>        ele_cnt =3D json_object_array_length(jarray);
>>>=20
>>> -        if (ele_cnt > MAX_ELE_COUNT)
>>> -            continue;
>>> -
>>=20
>> What happens if the json file is corrupted and there are more than
>> 255 elements in the array?
>=20
> ele_cnt is a uint8_t, so it will wrap around.
>=20
> We could add that if you preferred (I checked, and the array length is
> cached):
>=20
> diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
> index abcc09d523a5..4c74e874986c 100644
> --- a/tools/mesh/mesh-db.c
> +++ b/tools/mesh/mesh-db.c
> @@ -529,7 +529,8 @@ static void load_remotes(json_object *jcfg)
>                        continue;
>=20
>                json_object_object_get_ex(jnode, "elements", &jarray);
> -               if (!jarray || json_object_get_type(jarray) !=3D json_type=
_array)
> +               if (!jarray || json_object_get_type(jarray) !=3D json_type=
_array ||
> +                   json_object_array_length(jarray) > MAX_ELE_COUNT)
>                        continue;

I=E2=80=99m ok with this addition. There is a hard limit on the number of el=
ements in a node, and this edit appears to restore that check.

>=20
>                ele_cnt =3D json_object_array_length(jarray);
>=20
>=20
>=20
>>=20
>>>        json_object_object_get_ex(jnode, "netKeys", &jarray);
>>>        if (!jarray || json_object_get_type(jarray) !=3D
>>> json_type_array)
>>>            continue;
>>> --
>>> 2.45.2
>>>=20
>>>=20
>=20
