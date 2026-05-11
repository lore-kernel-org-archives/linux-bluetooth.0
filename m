Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB52F0C45
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506544; cv=none; b=sRY9Rnfp85XacCle45oiYhSZRdFUDZuCcrHt/rNdopw4trV9ZFZmEi3yx7Ih/M+F/gPPFb48ASsfc3xP0YUgvEQJZNBAC8lszKsDxlHpx2o8m+lVFKuUcCsr+UCZsorDNDajPb5yZIziuNVA4iZJ0WPTtjaZxML4bbTye2DDEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506544; c=relaxed/simple;
	bh=nfEVDIBtRRCF8Vx+thcR5Lj5KQqEAWLPrY05OdUYcc4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qbFAigpzKJ4HWffjaV0302j0YnjkhCDUc5c/lOmk1VHnOPJXEL41PIhTFt2ve3gNvC1NNfn77c1ky9ICJog4HfPo+y3y5aNL0fSSAgP1/AxXVF4dZKI3+P3x/NT/ezPjCNHAR7ggYJWdqJeXElB0rfksw4ONTP6vqbmhS2jl6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MpCKFxpt; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MpCKFxpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778506542;
	bh=DsCIrAOB9a2xahln+6TQjODM2BIygZHW7KSDfdVD3ZY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MpCKFxptVkL2wrUN1ZlNuzxzHwclRP24ww8ifyFhv6y896batrK0BlytNbzZ2lXM5
	 K/Igs85L+Ayj+EicnwfsjipB8k7hwtvD0DxDdvluHfg1C1KijRTN96gt8H/8pSj2f8
	 FxQTzRc9wqUZ7juKMPIbVFXcuZy9Zl6246c4mBBA=
Received: from github.com (hubbernetes-node-25c2e9d.ash1-iad.github.net [10.56.81.34])
	by smtp.github.com (Postfix) with ESMTPA id 852645210D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 06:35:42 -0700 (PDT)
Date: Mon, 11 May 2026 06:35:42 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1092724/000000-849390@github.com>
Subject: [bluez/bluez] 9c42e0: mesh: Remove unused but set variable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1092724
  Home:   https://github.com/bluez/bluez
  Commit: 9c42e065a6d6935510b7708942d9a3b709b8b846
      https://github.com/bluez/bluez/commit/9c42e065a6d6935510b7708942d9a=
3b709b8b846
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Remove unused but set variable

We played around with the bits, but didn't do anything with it.

mesh/net.c: In function =E2=80=98ack_received=E2=80=99:
mesh/net.c:1569:18: error: variable =E2=80=98ack_copy=E2=80=99 set but no=
t used [-Werror=3Dunused-but-set-variable=3D]
 1569 |         uint32_t ack_copy =3D ack_flag;
      |                  ^~~~~~~~


  Commit: a099005271bf7c6203c2e359de7486d6147bd717
      https://github.com/bluez/bluez/commit/a099005271bf7c6203c2e359de748=
6d6147bd717
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M tools/mesh/mesh-db.c

  Log Message:
  -----------
  mesh: Fix str{r,}chr usage

Fix the code manipulating "const char *" return values from
json_object_to_json_string_ext() to modify it for printing, we're
not allowed to do that.

tools/mesh/mesh-db.c: In function =E2=80=98mesh_db_finish_export=E2=80=99=
:
tools/mesh/mesh-db.c:2598:13: error: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers=
]
 2598 |         pos =3D strrchr(hdr, '}');
      |             ^
tools/mesh/mesh-db.c:2604:13: error: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers=
]
 2604 |         pos =3D strrchr(hdr, '"');
      |             ^
tools/mesh/mesh-db.c:2613:13: error: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers=
]
 2613 |         pos =3D strchr(str, '{');
      |             ^


  Commit: 8493905fe64d4cb18f5b08e47d37a77687baecd3
      https://github.com/bluez/bluez/commit/8493905fe64d4cb18f5b08e47d37a=
77687baecd3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M mesh/util.c

  Log Message:
  -----------
  mesh: Fix const qualifier dropping when using strchr()

strchr() with a const string returns a const string, we don't change
that string or "next", so make both const and get rid of the warning.

mesh/util.c: In function =E2=80=98create_dir=E2=80=99:
mesh/util.c:108:14: error: assignment discards =E2=80=98const=E2=80=99 qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
  108 |         prev =3D strchr(dir_name, '/');
      |              ^


Compare: https://github.com/bluez/bluez/compare/9c42e065a6d6%5E...8493905=
fe64d

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
