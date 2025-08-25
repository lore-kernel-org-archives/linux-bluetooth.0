Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654403595C
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147415; cv=none; b=h4b0JfMuEMm/EN2dSkSkT0dXZMcZ2HGl/8Ih/IPuEW5J0ifNJt4fMCXyMomwTr8uurJ7SyNZRNUMYonh9gNxu1Zr+yjmM+7Wsf1kN+fypI5abgm12XwA3f+zPwomnh3S3VcPmd3FOysSIdv2jDginDkZ08IheKlJXzwqpL6sX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147415; c=relaxed/simple;
	bh=A9ddoh1vjfMNcEJycUDG0mggK03z8XYT8TTnqq2JYiU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JWxCOIlPC6aelpBEEWSoPdfEQjLHn+f/NlY0kbN8078tT66/lD3R1VW+wiJRI5Wjl6Q8ue2B+G4MoQw9vHllAg9pYb4Fx+yn6hx3iRmZEMYauu2W5vHRrAsj/VoWd2sVE/fXqHV3nGDqO9DQYNt8zNHr23oAyszYatRpkDdhUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WvlW/Qlk; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WvlW/Qlk"
Received: from github.com (hubbernetes-node-1a4ae3d.ac4-iad.github.net [10.52.125.82])
	by smtp.github.com (Postfix) with ESMTPA id 8B17F7009A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756147413;
	bh=TtjQjJgExoXXvgShJyH8Q2Jwl6aZqdY7aqEz/FuE4JM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WvlW/Qlk9A1c/77mWMTgh/n6iXZ2rVonbQ8VRIcxm3aNyL1iH51cbFaoiqtw6K8+C
	 811BfbXffZHqUFB+p7YTd+rzMIDi9g3xwSxohhp1++f2guqnQ4GdXCUymh2FtaOzUU
	 CbmVsnEZv+DtsE7Yr4z94Nz/OtvGR7qZK9AEHRaA=
Date: Mon, 25 Aug 2025 11:43:33 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995364/000000-95b108@github.com>
Subject: [bluez/bluez] 12d7c4: lib: Add missing includes in bluetooth/hci.h
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

  Branch: refs/heads/995364
  Home:   https://github.com/bluez/bluez
  Commit: 12d7c41fa726fe800c84b92efe87901dbaefa04c
      https://github.com/bluez/bluez/commit/12d7c41fa726fe800c84b92efe879=
01dbaefa04c
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-25 (Mon, 25 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.h

  Log Message:
  -----------
  lib: Add missing includes in bluetooth/hci.h

Compilation fails when using bluetooth/hci.h without other includes.

> /usr/include/bluetooth/hci.h:310:9: error: unknown type name =E2=80=98u=
int8_t=E2=80=99
>   310 |         uint8_t         lap[3];
>       |         ^~~~~~~
> ...
> /usr/include/bluetooth/hci.h:383:9: error: unknown type name =E2=80=98b=
daddr_t=E2=80=99; did you mean =E2=80=98daddr_t=E2=80=99?
>   383 |         bdaddr_t        bdaddr;
>       |         ^~~~~~~~
> ...


  Commit: 95b1086bb07bf75682e4e5f65dbd81700e7f4ccf
      https://github.com/bluez/bluez/commit/95b1086bb07bf75682e4e5f65dbd8=
1700e7f4ccf
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-25 (Mon, 25 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  lib: Add missing includes in bluetooth/hci_lib.h

Compilation fails when using bluetooth/hci_lib.h without other includes.

> /usr/include/bluetooth/hci_lib.h:21:9: error: unknown type name =E2=80=98=
uint16_t=E2=80=99
>    21 |         uint16_t ogf;
>       |         ^~~~~~~~
> ...
> /usr/include/bluetooth/hci_lib.h:182:27: error: =E2=80=98HCI_VENDOR_PKT=
=E2=80=99 undeclared
>   182 |         hci_set_bit((t =3D=3D HCI_VENDOR_PKT) ? 0 : (t & HCI_FL=
T_TYPE_BITS), &f->type_mask);
>       |                           ^~~~~~~~~~~~~~


Compare: https://github.com/bluez/bluez/compare/12d7c41fa726%5E...95b1086=
bb07b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
