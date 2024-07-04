Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4513791C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118743; cv=none; b=eQOBN8Exqi9OM1wOQ5GftMQhKSWBh8B3gghxcoSUywR6ubJZMF2Jl0cuPNXO8LtwKDtQTk1F0C6jlMMNiKu0BKxhYokU2/SAUKCfe5ECWwnIjqb8q6MZvMYc/voE4Mj7ojWfnDyixmolzJ5n0vZcNMOc9atnr5++zvLvLu4xun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118743; c=relaxed/simple;
	bh=8yU0WSJm8B6j+o1CpIqBXWhcd7VuCLjaAaIoca84+hw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=D1gpRT5q4GomXFCX8FTzNuj0VydR8Ege9zhbMAGdFWyxG7ZXOzNnr001sQDrbB0VhmgJFZG06OaP7Fugmw0gP1NGMok9iAvK/8pqIWUJLYUDcxl1H9YlUQiPmWE8lMSVTZionmivGqodilZJcOenJraPgHlNvpCD2J3PRDscxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er9pVdFR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er9pVdFR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7594c490b04so597441a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720118741; x=1720723541; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6/+QKSxwwG+u3NDCNmTXkZFX5Z7TV2L+ouSwYKU4cg=;
        b=er9pVdFRA3Xt262R/NEVFpTO3UyXzJDFCeXODyKp3PUG1On6vviVr128/hy0wQs1ST
         0aZrQZKZ8qZeHs2K3BzGw0tJXUXuB+OdbfdmuZBVOJALRYHkYVZW6UslPNzYTMHb2zpE
         N1s9Ak1KlVeTcmB0GaEFPSfvDQriUn5WzBPes+8fUDzf6fUaQVlNMCisJeyUMbTaCTdl
         +LQhMRUiAji55LsZ3V9CupYVz4BwQd3etmfzBTXNirPJXJ1kbHHWyavqKAq9oHovdBOs
         G+ChDO4em6GeXFFmqw044T/Yj5hnuO2dhqn2Z+kxSpiRtkfhBsROaGvqDYeLlK3CD1yR
         YDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720118741; x=1720723541;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6/+QKSxwwG+u3NDCNmTXkZFX5Z7TV2L+ouSwYKU4cg=;
        b=adbM9OLzjzwY3xLtndLCSg2kFpWQ0+q1tFyqsdJ0xukabr0eg6vcHi0EsaWzFiZKSZ
         pbExEqL5xGIJ02OQ8XBjU/1yH2u2V7R5dEENRg98M5PkiR2WGMrHABgYWMma2I0ooq1a
         02643l/+Jz8/Uy0i+nqT7jsdC6xUF/BvalUw09ocbP3CtBIq+5FLULo4bPDprrtytSZA
         3tVmBjXP5GB9USKXMLVIW0XIeGblx2updGNeB2CwKLnRaoNIzxaMkQFpSAJ9YBxL6Log
         +ht2GZchsbdFlyAYA/KnadCPkVXzzOK044uOMVRRLALZgkXQbFSYGPm/QsNqzyFE/hdq
         +2oA==
X-Gm-Message-State: AOJu0YwVVhvN5LakQXcG6RDCueFvbKMrR01gy0EVXcifLgsc5vG/wjtH
	6/cZ3xhiAj+1C4am53OpM8WNQKcTBN1I7mFcPBURO5YOb/luefvjM5rrwMoG
X-Google-Smtp-Source: AGHT+IFB8m4QjUtOPLZtRYl3c+/BI/UB2Ervp4j4xOmWGoFkx41XQLHsSxUTHB0dAj/5xTTN6EPRbw==
X-Received: by 2002:a05:6a20:2d29:b0:1bd:24f9:1124 with SMTP id adf61e73a8af0-1c0cc88ed6dmr3089402637.27.1720118741129;
        Thu, 04 Jul 2024 11:45:41 -0700 (PDT)
Received: from smtpclient.apple (97-113-165-148.tukw.qwest.net. [97.113.165.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a94e83dsm1871041a91.7.2024.07.04.11.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 11:45:40 -0700 (PDT)
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
Date: Thu, 4 Jul 2024 11:45:30 -0700
Message-Id: <C7C313BA-2B8A-4638-81E8-80ED55CE07B6@gmail.com>
References: <20240704102617.1132337-12-hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20240704102617.1132337-12-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
X-Mailer: iPhone Mail (21F90)


> On Jul 4, 2024, at 3:27=E2=80=AFAM, Bastien Nocera <hadess@hadess.net> wro=
te:
>=20
> =EF=BB=BFError: INTEGER_OVERFLOW (CWE-190): [#def29] [important]
> bluez-5.76/tools/mesh/mesh-db.c:551:3: cast_overflow: Truncation due to ca=
st operation on "ele_cnt" from 32 to 8 bits.
> bluez-5.76/tools/mesh/mesh-db.c:551:3: overflow_sink: "ele_cnt", which mig=
ht have overflowed, is passed to "remote_add_node((uint8_t const *)uuid, uni=
cast, ele_cnt, key_idx)".
> 549|            continue;
> 550|
> 551|->        remote_add_node((const uint8_t *)uuid, unicast, ele_cnt,
> 552|                                key_idx);
> 553|        for (j =3D 1; j < key_cnt; j++) {
> ---
> tools/mesh/mesh-db.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
> index 1d047691d240..abcc09d523a5 100644
> --- a/tools/mesh/mesh-db.c
> +++ b/tools/mesh/mesh-db.c
> @@ -503,7 +503,8 @@ static void load_remotes(json_object *jcfg)
>        uint8_t uuid[16];
>        uint16_t unicast, key_idx;
>        const char *str;
> -        int ele_cnt, key_cnt;
> +        uint8_t ele_cnt;
> +        int key_cnt;
>        int j;
>=20
>        jnode =3D json_object_array_get_idx(jnodes, i);
> @@ -533,9 +534,6 @@ static void load_remotes(json_object *jcfg)
>=20
>        ele_cnt =3D json_object_array_length(jarray);
>=20
> -        if (ele_cnt > MAX_ELE_COUNT)
> -            continue;
> -

What happens if the json file is corrupted and there are more than 255 eleme=
nts in the array?

>        json_object_object_get_ex(jnode, "netKeys", &jarray);
>        if (!jarray || json_object_get_type(jarray) !=3D json_type_array)
>            continue;
> --
> 2.45.2
>=20
>=20
