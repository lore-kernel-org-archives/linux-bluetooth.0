Return-Path: <SRS0=UugF=SB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80104C43381
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E12F2173C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 16:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cysioland.pl header.i=@cysioland.pl header.b="AeoSLUik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfC3QPF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:15:05 -0400
Received: from cysioland.pl ([163.172.129.77]:35700 "EHLO cysioland.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730742AbfC3QPF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Mar 2019 12:15:05 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Mar 2019 12:15:03 EDT
Subject: Re: Battery level of energy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cysioland.pl; s=mail;
        t=1553961915; bh=mSJfZILN+PMJy63dcG4Wi6Tys237Q/+XZ5mT6SaWMUA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AeoSLUikPWzWZjxVBt3kGYnkayhZT9gPQtXF8lvnCxL195cfolYQbeLtObC3tAKs4
         zGXfBtAbG0zDim67o8VKf1khHJFEhc1kls7n9bK1CG/mHsFQZY8dxBx6wYgh7INLX+
         TKcB1nk29HydX3fb0kTySHVfodMQwsyt4NI8VITU=
To:     Grigory Fateyev <gfborn@gmail.com>, linux-bluetooth@vger.kernel.org
References: <CAAOqupzg6GN147uofDAyuFLid5QHOns0nkjOw=+=OicV=cezwA () mail !
 gmail ! com>
From:   Cysioland <me@cysioland.pl>
Openpgp: preference=signencrypt
Autocrypt: addr=me@cysioland.pl; prefer-encrypt=mutual; keydata=
 mQINBFSUXsQBEACcMlsdJumCZPihEBONzTfbBzrWcdX/YQg3kCP4/53Ua0W+bpOB3K+lnO+J
 X4/741zd8LNnWxIIIzkBnI2JtZcc7hkMdS2k1knRriW8RuL1rnufZjEP1zZKw+R3o3z080xh
 zHDvcu49ZzYD2CmJnGEhh18iRAGUw3mnEev9E60YoPptSvSdXccMNjZCKUCtOVNzmkTLSogm
 1lOcoH2Hhp6MwfYOv3DrKJg2sYeVUKk1YJFCUdqXQ7oOFtZoEPfnTV5Qf4rkkxLDgGQx/ll5
 ncBWnqxBEVvMOSBBHWiAM0QolKFWb84NEhiuEN9Si6MJjxjH9OxbLm+sYa/NuMMx4Vbk2ykj
 FhGGXR6uh73rsneUDHuRhd0ofviIaRpQiKpxCGCLKZgnRGReICbtJvi1IESqWXX9ionA8XOr
 nsCFdyCjTND5smCQ2HMyerf9VFk+YxwVpP5UrjatiXs2et256jUtFidFRy+q1WH8HUAO8VEJ
 /QOL2eVC2jUAabj1CzaXiYwf8dZP58l1Hffgkd9mvUt2Gx5eDMZfRq4GScpon1lth5WaD+eP
 7BZcv9YGa9WaXQhZHgLxy5J8EH1VywXEAer9cPcgbRpC5emX/pwrF8Wmgez2XSu8z4vUQLtH
 02sGMUwNB41TkW3kLw9tCvCOYvXfbcNGlt2QZB5p9iqdpgwpAQARAQABtBtDeXNpb2xhbmQg
 PG1lQGN5c2lvbGFuZC5wbD6JAlUEEwECAD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheA
 FiEEezOgjHqErClXYmby9XbF8oM64H0FAlyfkjEFCQiB2m0ACgkQ9XbF8oM64H209xAAkLtG
 8YUl4j2gmTrlcevOpOew14ftasxsXWwy85j/IclPs42RiuRUgbGnkuophjHBBe7BJ6Cfuav7
 JmpVI92Wnap5z6SPDwtVCbeYm+D5+j/VHe9aRBcDzNDEcxd7eUBDIIeRlF7zy/CJfq1LZDK8
 6/xFlaX3v5y+7E6st4DwM+V0n+4q6Kj1TcUXOHuHO9zXE2oO5KSMzXtIFzDMM50a1Z+GWI+i
 8m4PxY46GG3bADwZSE1532I3ZrvB83DPtpNy9KdNYvcY+97PKfxOtKZh2cWNvsecGEysvKEO
 EDXjBXxmrQnM69R8mC30rvsvZRKCo5wkKWmNfp/CeeQAf/GX0PLtYszydy44984NzFsHcSus
 ToKrwXXkIGIWqf7FJmvHtQ/l9pUk+Kf/ifDZeOKwLpCXhx0MVPkKPZAprU3X9P66F5pX9lIT
 0KGgmia0kIjZVe1qI7lF5Az/VAQeOJUGZlGgjo/M/vaLnb428mIZC+6gbthxvbMQWWuOEGYb
 ux8DqjNcA7+kR79shB/01VKmkRAU0Ze+j/yTBZOE7dLdvf8FDCtK2DKgjw9UlNim8gXBl/XQ
 DFpShrBy0CQc34v+q/Edsz/nR7w9vbQ7AxeXYIgnd7arIxT/glLOjWd2+Irtqv4W50FnbZCJ
 v1yv+17lfNklHEapZmhiW8EBzNAy5Mi5Ag0EVJRexAEQAMApK6KlW5+ZrSBJUnnyxO+fz/ny
 Kgcxb7C1SHnMN4aaBIAs1Sar/GmDedOJKtBAstCUtLFo55v3HgFer+Pedu8uzKVqdfZHjNXT
 DL9NiI30lBLx6tAVFQksuLvOW+IcXisXDZKI9wb5NDmBZa4pY2CtN8QZ1lfRD4WcLL2VOJng
 12rc36XqGXR9muv94+3yaG8HBQfeYXY4LPL4FdSs5WM0fxGIk6M2f10C9dVyucjJx3nkE4Aa
 WeANstCeIPBqonAmS8wThfARHjToGSXnNuJtYKLQogF9++9iWke0Kd7z0HQ9UgOA4i/eDd9y
 jS/ivYyCel5tRky17Dchx4c63gHgz115XwFB1lZKm3hBrrvrA7Pc8d/NIII6Bb7wfNkwn4NU
 1tNEjctgPVHXfyQ+hJwBrYztRlFd8JMRBvaeiC37opz5yT5v3pGGhjZWMjewZNo05p82WL15
 Ggs5jAMhVeMU/9KUWBAoYtH4VnSFSiJ+5jt5f7qmlzhPQC0FttUKh13ayXI/YiftHvS+VJPB
 sty9RyTOaNT0Qap6RXAl/KYdLJYIhxbVAcQCZRzlAXosG+AtbhOeJLRvD/uMgIV+cev/mXYJ
 e9xADNjk/S/6haTKThMQhUin0phHWK9GEmTJQTYnXs0hlC2KWgJf2nlGYcE3Fkpa8X0klbRv
 ZTbIRVjzABEBAAGJAjwEGAECACYCGwwWIQR7M6CMeoSsKVdiZvL1dsXygzrgfQUCXJ+SQgUJ
 CIHafgAKCRD1dsXygzrgfYQ6D/0Xj4X5eumdjw7JYYO9nm8DUAC62gVeJ4MY/tapubTiGRsP
 yEnyXd3xS3H54NsUeL4w6DXsAW9xvxIDimNAbbkm4W+2S4cLaj0y/FzyajEb0F9o9tFYL1wq
 l0esUdNwd12J2VR24lNn1wYfS+ma1IYdlnqQUkGQyJUXH5b9SoJJq/H8pSp54l2moiwSp6/A
 8ndj0fdbKZewZcrpSpgJLx3W9vLJ+g8Cu7u3UzUwp3jLf8U4TOnQ0JOWdFIghcuEUAkkCr+Z
 EuZxTKTGEnH9IDsYZCGGm8m2MvzvFavq1LSTprHo1i76djjLf5MiAafgb1IyGIcWriNcjjxu
 a+g4ORYjUtLEictLW4LWmfstTbCLZbnB8OfaenWW1qFn9pOEuFtemZUSiZFJr9QzIirmlShM
 LdUHm1599WsrnKS2vomIFWsbBlzxQt/fOqXeeopnY7o7DSFGnx2JTuJW8o+84grZ89S6ByyT
 whstff6Yxp+RLJuEtRIVXq3OT7yngNzb1UqZE42oQzr1+oJjULFX9RkVUgMYG1ixex+fXVre
 vatFZcNgVvxvcYTImoe01VR7iMlmzyPVvbqUGEe3AxHZSCXqpiQujW9My9rvH1sLOLBJttgn
 5rDYeB2wW0a9yRUNBODQerkkkn76zVlQ1hCn9ngsa4d0X2/HrV3I+Au2U55LDw==
Message-ID: <17afaab3-cc55-9047-db4c-2fd512d0c168@cysioland.pl>
Date:   Sat, 30 Mar 2019 17:05:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAAOqupzg6GN147uofDAyuFLid5QHOns0nkjOw=+=OicV=cezwA () mail !
 gmail ! com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CmAZHkxlxA1Zsp6UT3SMqkLYvsKKERQ9m"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CmAZHkxlxA1Zsp6UT3SMqkLYvsKKERQ9m
Content-Type: multipart/mixed; boundary="P04UuqFnvBPh80k3XKgvL6Qv2gKcmLrEs";
 protected-headers="v1"
From: Cysioland <me@cysioland.pl>
To: Grigory Fateyev <gfborn@gmail.com>, linux-bluetooth@vger.kernel.org
Message-ID: <17afaab3-cc55-9047-db4c-2fd512d0c168@cysioland.pl>
Subject: Re: Battery level of energy
References: <CAAOqupzg6GN147uofDAyuFLid5QHOns0nkjOw=+=OicV=cezwA () mail !
 gmail ! com>
In-Reply-To: <CAAOqupzg6GN147uofDAyuFLid5QHOns0nkjOw=+=OicV=cezwA () mail !
 gmail ! com>

--P04UuqFnvBPh80k3XKgvL6Qv2gKcmLrEs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I actually had a similar problem with my headset, and it turns out that
a headset can report its battery status through Apple-specific AT
commands, namely through a "AT+IPHONEACCEV command". If you listen
through Wireshark or something similar, you may periodically receive
battery level info. In my case it was "AT+IPHONEACCEV=3D2,1,2,2,0", which=

corresponded to 30% of battery (value after "1" means "battery level",
and level is scaled between 0 and 9). Hope that helps.

Documentation:
https://developer.apple.com/accessories/Accessory-Design-Guidelines.pdf

W dniu 23.01.2019 o 18:27, Grigory Fateyev pisze:> It has such info:
>
> [MDR-XB650BT]# info 00:18:09:C5:44:1E
> Device 00:18:09:C5:44:1E
> Name: MDR-XB650BT
> Alias: MDR-XB650BT
> Class: 0x240404
> Icon: audio-card
> Paired: yes
> Trusted: yes
> Blocked: no
> Connected: yes
> LegacyPairing: no
> UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
>
> PS. Luiz, sorry for the direct copy!
>
> =3DD1=3D81=3DD1=3D80, 23 =3DD1=3D8F=3DD0=3DBD=3DD0=3DB2. 2019 =3DD0=3DB=
3. =3DD0=3DB2 20:04, Luiz
August=3D
> o von Dentz <luiz.dentz@gmail.com>:
>>
>> Hi Grigory,
>> On Wed, Jan 23, 2019 at 6:22 PM Grigory Fateyev <gfborn@gmail.com> wro=
te:
>>>
>>> Hello!
>>>
>>> I have a bluetooth headset Sony MDR-XB650BT.
>>>
>>> # hcitool info 00:18:09:C5:44:1E
>>> Requesting information ...
>>> BD Address:  00:18:09:C5:44:1E
>>> OUI Company: CRESYN (00-18-09)
>>> Device Name: MDR-XB650BT
>>> LMP Version: 4.0 (0x6) LMP Subversion: 0x2576
>>> Manufacturer: Cambridge Silicon Radio (10)
>>> Features page 0: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
>>> <3-slot packets> <5-slot packets> <encryption> <slot offset>
>>> <timing accuracy> <role switch> <hold mode> <sniff mode>
>>> <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>>> <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>>> <power control> <transparent SCO> <broadcast encrypt>
>>> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
>>> <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
>>> <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
>>> <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
>>> <sniff subrating> <pause encryption> <AFH cap. master>
>>> <AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
>>> <3-slot EDR eSCO> <extended inquiry> <simple pairing>
>>> <encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power>
>>> <EPC> <extended features>
>>> Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>
>>> I'd like to get the energy level at least in shell. In which directio=
n
>>> I should look for? How to know if my device has GATT support? If it
>>> connected with Android smartphone, where Android version is < 6.0, it=

>>> has an icon with level in percents. I want to get the same on my linu=
x
>>> machine.
>>
>> bluetoothd should be able to detect if there is a battery service,
>> well at least if you are connect over LE, note that in past there
>> exists ways to fetch the battery level of AVRCP and HFP via AT
>> commands, so perhaps Android is using one of those, btw you should be
>> able to see what bluetoothd has discover with:
>>
>> bluetoothctl> info <bdaddr>
>>
>>> Thank you!
>>>
>>> --
>>> Grigory
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --=3D20
> Grigory
>


--P04UuqFnvBPh80k3XKgvL6Qv2gKcmLrEs--

--CmAZHkxlxA1Zsp6UT3SMqkLYvsKKERQ9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEezOgjHqErClXYmby9XbF8oM64H0FAlyfk7oACgkQ9XbF8oM6
4H3hlg//Xb6bCUyOsOpSJUR/HYZX4+DuBU3jmWGLyMmASKMRmvSIZQsR28d9w15Y
Z1f3SSUNGpw4AcUcfRVQVTY2qDaUHovkuhz+NhlXrkn304yV6KiYHAWRDg+6Kl95
1ZqXG0bn7auH3U2whW8iWjJMmOx9ZBkoY9DegUqbKYmwZO0VqS13wlpntUvtEVz7
OVu7AXwKICmJaWzg3+4LEfTQY9vWqKCl1LANRQz6qwGHNa/KkxVHfbxxM87TIy7v
pwsJCtenRfAeto3yGXfwvCXQOGb0zVXP4x6jzseTeyvHUF0+cdHFlJpGEa/qHswA
L1UCbfsXFUCaQRT6nrXOqYbSS+ML+S+BlENWHgHfE3piZ13mFmwQclyGbLXjdSar
qdSZMxJc1cdkloyAKynhI8AF4u/UcRwlAL4Baie3AETl3XRNEKiUN+AshuL18Idm
6fC3Zf3yutWxkEMFTkyB3RypqSsI3ZdJzfuM7pUopPRAWBx0jTGHuqb7S8bp1Na6
80mQ55Si9jA0gLgjqebcyCR/WXlmHzqYjSqqQAwg6Yp2Ur1Tf2UvSimRzrQQtk7F
OfNwGTM0HK3YD5By7UbEtbF94ap51SxQEO3xb7TtrDBJZMniMrFUv2UWplbfGMmM
C/P/JZV9rGo8bpHNQ2uGt0ZRHBrwzo6uBtRUOsrCBGkdztEtQX4=
=5qJ8
-----END PGP SIGNATURE-----

--CmAZHkxlxA1Zsp6UT3SMqkLYvsKKERQ9m--
