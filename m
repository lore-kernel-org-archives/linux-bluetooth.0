Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEA1FF7C1
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486012; cv=none; b=rnTfli8sK+BhHlvDCIKXSHZtriIrkAb4hsSOG71J8+ruHQXmnBV3eqYT6Wlc1EaAdCpZ+a8gzR0TN9CjT2iEQqlAKzPTVh7FFwVSMuCQkgd3ncHqUkwYT7u46ya2x4F8ZH5qHI+Xuf968SI6sa8Fy5tcWLoelACbgY5d9beAjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486012; c=relaxed/simple;
	bh=tgXR20FvNUfNlyFoKWjbWVnUPlhbUBPlOXCY1nAuxH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO2VxeT5AVkBRfs/EKoq9eDrl8470Qf6eLHKGUItgCIBlT5lgqDbfF3KzKOXZHamHpAurFZDBIvBMqXKDY6aNoMY7tnDO4O5Ro1WRa50vbgbVbwe2ojy91xAaAfQZLisiCJsdboZUgRlWvGYP0WHQh0gh66jF22aGyMdLafVwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=gVYh20SX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="gVYh20SX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733486005; x=1734090805; i=fiona.klute@gmx.de;
	bh=Sh/UTLAS5dO/hYY+X9W1bP3QNwSdO4Wj4BJwWsphbKk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gVYh20SXY2dtRd2pRS04B6oSIR71SdZLOqo3R+x6YadI3XchBpNx8qJQHs8jgqJ4
	 77cWOct7cPFGVujGi8VPXHCETtDntiw6WYsU1qXcbbad4L3JSLhSCmeLs8Wukk9s1
	 INXN2uja5GaAJxbXmyeJckuD1Kga5b2l6VAtAo39Mfoy95DWIAr+fJZ3J+GsCBVBz
	 P0xr04qgg8exH2j3srk4ByTOjuGxDOXYl3JQ7xPZ7Zh2tJxDNUpDFko5pME+efuvE
	 RuI04V0EVGoI90XrMAH3FHuPHV/Q9e8XcFltROJNUVuJseDLlapvxnKmB7wkAnrFG
	 9Zt4LV+n3324S9RcGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.113.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1t2xRw40tI-00I0PY; Fri, 06
 Dec 2024 12:53:25 +0100
Message-ID: <b6a7a2b6-fdb7-46b5-8990-86450c79949d@gmx.de>
Date: Fri, 6 Dec 2024 12:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] Leave config files writable for owner
To: Bastien Nocera <hadess@hadess.net>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
References: <20241205133233.1738092-1-fiona.klute@gmx.de>
 <CABBYNZJE_zK-enNFyHG4-8dCksj3TxAZRQZ4Q+OxibksnSKoZg@mail.gmail.com>
 <d37768fdcd33092f0bcbb4e4e417ccb6b9a1a2f8.camel@hadess.net>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <d37768fdcd33092f0bcbb4e4e417ccb6b9a1a2f8.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H+8SOCSswbs8l41GyGbFAJKlfKHhbF9Iehu/5OcycnRl06Jxeu1
 N/2nz/FfCSe9u1rBTrHzsJvAodIMnoxrckedFysmriy86FKkSUXZkddmFTtf5IGFUs/5BRn
 nNonsyYtsjmPj3obSxtWGamRR5tUGXkVtVcBuio5dKpblKkHuKfxqgVBlp/pvpsLYTsE2zr
 EB24mkexzYSn+641N3OGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:za/qwIYuiAw=;i0LMw8zy09rD/FdsNqzJM4nGjTk
 GL385AQ5RPRup8KbE3jh//NWbW9dEclgLu1H5MkVs26m6AkGi1csJhFmAfzIkPwuYGPzmdG+p
 hd75tP7AYpoZcliTyQ9PGPVcpMXubETIDbOXNApeOeghTqKFxW+xeU3GSpog4UxftH4ncMzJP
 ydh2gz6+KhOhwnP5K8QuPXn7my5MdJEOAkBj61bwb0gaBUou5FHAnQAQU9l+YSlHQ16wShr+c
 Tbka/jEaOn9D2DdEvrNogl/K2RGhHh67fC9Vw5WWBJyIDiOfGKExnJfF7DTUXwO3ZQFqGmYxH
 RQYBxReg3Uy5KSZiEvTqJ0ZR5lkXT5/LlLBSC6O/d0eROJu/nC7rtUHSQflb6q6+xFbkFcjca
 IQd/FVpnCLMaKHF0o3wjrFKbD7tGUM/lJFNj5m7MkM7WLulnYrMa87/ZVYaMlCq2nFmtilnZk
 B3GMJ4vB9Z5b5ucmlLZSODZirBXIcYbMJS7xp4SE3Y97we+uQVgXz5N5zgiy8kee+hCuoK0gB
 SG+ccTv4jxVe2chs0KlwclXt6FE8TwkrQDssXaFCUCikpmoFca+aZZ8zHUZIlcyrwdQbsmzjf
 sFEpCx80CtbGE54quAflYE6ZGTY17fnf6v6upjMObujXymIso3q5UjlToas8xJF1ZTHEUYUbx
 1vZymY5ei/DVG00viBz5nGMN68gdHWpeWlAY+4hN2A7pcW4p3/pQjv0qX6dP2WGM1X56jDM1t
 iFfN7rtn6vRhPbnlokICAj24L9mUS0c38mZN2Sfbuj1AqR3vQvLiU50vZ/ROqkgDmjXuaeQy9
 J6Nh/zPewl98mHf4QBr3Qv2emtK07I+9jOFoVkmOekQYo1MK+8xUqskPtW7+xgQeg4eG5YmTu
 sR/ZeA1HwLJNHC9+DDw0A1UZT9ZRRFN8OXVDBSTnh7cEsRyX+DSW8Ef7x4NW3WGGe/QTVIx/X
 ugAqaM7DpxXpKmz6Vd/ap7xTt21190WH6nwrq90klFAi0mt7xTFL8Oa//uuL9g+MyapnnePi6
 yixHQoHyF7C4xS+SfrxqmlPH1Sr/beyKZ7Mqnuk0OyVVxPqGUkz6GZwA3iZhIVlcZGe/qNP+J
 A9G8lIGWKCogR72+h22DSPMrHfcqqA

Am 06.12.24 um 10:46 schrieb Bastien Nocera:
> On Thu, 2024-12-05 at 10:00 -0500, Luiz Augusto von Dentz wrote:
>> Hi Bastian, Emil,
>>
>> On Thu, Dec 5, 2024 at 8:35=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de>
>> wrote:
>>>
>>> This is needed both so the owner can adjust config as needed, and
>>> for
>>> distribution builds to be able to move/delete files as part of the
>>> build without adjusting permissions themselves. Limiting writes
>>> from
>>> the running service needs to be done in the systemd unit (already
>>> the
>>> case) or init script.
>>>
>>> See also:
>>> https://lore.kernel.org/linux-bluetooth/4d1206df-598b-4a68-8655-74981b=
62ecca@gmx.de/T/
>>> ---
>>>  =C2=A0Makefile.am | 2 +-
>>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile.am b/Makefile.am
>>> index 297d0774c..29018a91c 100644
>>> --- a/Makefile.am
>>> +++ b/Makefile.am
>>> @@ -32,7 +32,7 @@ confdir =3D $(sysconfdir)/bluetooth
>>>  =C2=A0statedir =3D $(localstatedir)/lib/bluetooth
>>>
>>>  =C2=A0bluetoothd-fix-permissions:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm555 $(DESTDIR)$(confd=
ir)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm755 $(DESTDIR)$(confd=
ir)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm700 $(DESTDIR)$=
(statedir)
>>>
>>>  =C2=A0if DATAFILES
>>> --
>>> 2.45.2
>>
>> Any comments regarding these changes, shall we also use 0755 in the
>> systemd service?
>
> That's fine, although the changes are really academic, as root/the
> owner can write and move those files just fine, even without explicit
> write permissions.

With chmod, yes. A build process that expects created directories to be
writable for the user running the build fails. Sure, it'd be possible to
add a workaround, but it's better to fix the issue at the source.

> The point made about the stopping the running daemon from writing to
> /etc is on point though, which could be fixed by something like:
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> index 8ebe89bec682..ddaa9d444eed 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -15,7 +15,7 @@ LimitNPROC=3D1
>
>   # Filesystem lockdown
>   ProtectHome=3Dtrue
> -ProtectSystem=3Dstrict
> +ProtectSystem=3Dfull
>   PrivateTmp=3Dtrue
>   ProtectKernelTunables=3Dtrue
>   ProtectControlGroups=3Dtrue
>
> See
> https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.htm=
l#ProtectSystem=3D
As I understand the documentation there "strict" implies "full":

> If true, mounts the /usr/ and the boot loader directories (/boot
> and /efi) read-only for processes invoked by this unit. If set to
> "full", the /etc/ directory is mounted read-only, too. If set to
> "strict" the entire file system hierarchy is mounted read-only,
> except for the API file system subtrees /dev/, /proc/ and /sys/
> (protect these directories using PrivateDevices=3D,
> ProtectKernelTunables=3D, ProtectControlGroups=3D).

So switching from strict to full would actually weaken protection,
though /etc should be read-only either way.

Best regard,
Fiona

