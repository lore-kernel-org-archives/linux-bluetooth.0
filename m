Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64418C38
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027915; cv=none; b=ovQMXx8g8fjtAgLXWCKnteUsNhzL7jCWRJrrVOE48riXSa2vG2r3nheiTWzlEchJKffqKpYsohbXS8HjBrnW7rxAmKQeDeuo+iDjwhlAn0I+AQojOqEJCz5qo7rT0s3RvYS6E3D1/DC8m53GsRLuMwQ3XBo8CvpQES+DTMctK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027915; c=relaxed/simple;
	bh=oxts7am21tIoq0poqCoKxXjL2LR5mLqEybv/Lrt3ehM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh1ds+uYi6JFAu/f+tFKpjcMVx4CfCwTwbHQ6Kplis64Mdy7vc0zuJurev4IPpJ9Msyn2/IsmZoBWHPzByCtMlC/QiQWtCu7fBKpCn7ZqkvmIKRHfZbld0jLnrC+qmM+OVIhwjLFv2m9uxZNtqBAuJnTPT39niB4cjG0YaDSj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK5UT0xk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK5UT0xk"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee88c4443eso7943201fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720027912; x=1720632712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbMnmN6G5xckS/U+ZlzEmNcd04SpFlRFzQIP7UPsyEs=;
        b=UK5UT0xkrGatAnII1hUQfBWJw9u/JeRDdhckWzAvUDolDDtDrBHzVJpzd1BxUxqJUn
         8WVZkVbwLKsRt0Kzncer4NtHFFNDmZrc2keNQxMmIcPttcBlSvuirdasMY31YvCA1lcN
         2UWsmhx9GYrZgFt25ZDh5zn4k9KV4PuHAqlL/p9SUogr62Bw4tNgbgcxoF/2vMOLZE5d
         KL+IyyAHUJKp/Ks0D3HphrK3s3jtsyVPie8IRQkWxvz+dzNrBlcS743Z1bxft2o+Wi3t
         jEYQIlvFGUH1+SR8TRU0gOb8HHM3iONGqlpJcdcAZuEsndyjFu50WzCfNxVfBCJLt0RG
         wxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027912; x=1720632712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbMnmN6G5xckS/U+ZlzEmNcd04SpFlRFzQIP7UPsyEs=;
        b=kO9LH26Js9uyLZsa2uEj/47QV++3lpu1b7dDmmlYlbriCB8Xit4UC85KI0TBy6v705
         /KTxRR5wT+0pj16fOMphCjBtgr1E8/luAdtC7F1BRioX0gWQTPg47uGeuy6WUGe/jGJi
         if/WZa4sBSkTJIt9Pidauq53jBJZyRau61fbGAlW3vQmjS7LpS1c0wwSlhbglXsqFULH
         sgxB7WDfUFYEan05eMXlJ09pPu8HDj96AY7O55OYsPHklf2lEbsp44vZ1OqrqzMXBzhN
         GBCii4/MdLrRN2mUFe/KPSN/j7cKIKdtIXneQce2OV76vBChmg0YEVgFAydhkspNxlbw
         K8lQ==
X-Gm-Message-State: AOJu0Yw3Xl58OjjT5HtlgrROnRqQXZHtRWG39RWmQKEwphw43aeA1/DG
	SxPV6mex/ZzgJXmOe0ZdJUNhrGkVQIROoNV3g8PjwIi4p+2HBt/T+e0z+SymbelL8WkzKQLYI9M
	j4TsxmderZBerkBnYh8fXzanc5YNZy7DC
X-Google-Smtp-Source: AGHT+IHD9/XeSDHfCxwpBa7kG8QisLPFukKa0vvT6ARamgm7aRjwkuKqguZJnn8T1IxQFxIiB66ZO55/g9Cb66GYRWY=
X-Received: by 2002:a2e:a36b:0:b0:2ec:5019:8fa4 with SMTP id
 38308e7fff4ca-2ee5e6f794dmr73740591fa.49.1720027911415; Wed, 03 Jul 2024
 10:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li> <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
 <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li>
In-Reply-To: <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jul 2024 13:31:38 -0400
Message-ID: <CABBYNZLrATLZaE756Guu9K3nGxGc3aVzSuxOiLw9icsO5+QXww@mail.gmail.com>
Subject: Re: [bug report] Reproducible pairing loss after reboot / Mediatek
 RZ616 [partly resolved / probably not a Bluez bug]
To: =?UTF-8?B?Sm9uYXMgw5Z6YmF5?= <usul@gmx.li>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 12:38=E2=80=AFPM Jonas =C3=96zbay <usul@gmx.li> wrot=
e:
>
> Hi Luiz,
>
> Luiz Augusto von Dentz:
> > Hi Jonas,
> >
> > On Wed, Jul 3, 2024 at 5:01=E2=80=AFAM Jonas =C3=96zbay <usul@gmx.li> w=
rote:
> >>
> >> Hello Bluetooth List,
> >>
> >> this is a first post here as I found no other place to report bugs. Pl=
ease forgive if I do not report according to the expected format or missed =
any additional information and point me to the respective guidelines - than=
k you!
> >>
> >> =3D=3DProblem summary:=3D=3D
> >> Bluetooth pairing with a mouse is lost after system reboot. The pairin=
g has to be removed and a new pairing initiated for being able to use the m=
ouse again.
> >>
> >> =3D=3DSystem specifications:=3D=3D
> >> Framework Laptop 16 (Batch 7)
> >> CPU: Ryzen 7 7840HS
> >> GPU: AMD RX 7700S
> >> WiFi/BT controller: Mediatek RZ616
> >> Linux Kernel: 6.9.7-200.fc40.x86_64
> >> Distro: Fedora 40
> >> Bluez version: 5.76-1.fc40
> >> Peripheral device: Cherry Gentix BT
> >>
> >> =3D=3DReproduction steps:=3D=3D
> >> 1) Pair the Bluetooth mouse via GUI or bluetoothctl
> >> 2) The mouse will now work as expected
> >> 3) Reboot the system
> >> 4) The mouse does not work, the GUI might switch between "connected/di=
sconnected"
> >> 5) start btmon
> >> 6) clicking the left mouse button produced the attached btmon log
> >
> > Weird, it is doing a pairing request right away:
> >
> > < ACL Data TX: Handle 512 flags 0x00 dlen 11
> >
> > #11 [hci0] 2.185573
> >        SMP: Pairing Request (0x01) len 6
> >          IO capability: NoInputNoOutput (0x03)
> >          OOB data: Authentication data not present (0x00)
> >          Authentication requirement: No bonding, No MITM, SC, No
> > Keypresses, CT2 (0x28)
> >          Max encryption key size: 16
> >          Initiator key distribution: <none> (0x08)
> >          Responder key distribution: IdKey LinkKey (0x0a)
> >
> > But it is doing No bonding, so perhaps that is the real problem here
> > since that indicates to bluetoothd not to store the keys. The No
> > Bonding is controlled by HCI_BONDABLE flag which is set by
> > MGMT_OP_SET_BONDABLE which by default is false but is automatically
> > set to true once a pairing agent is registered, try reproducing this
> > with bluetoothctl and if you are not able to this must be gnome/fedora
> > not registering an agent.
> >
> >> Sometimes btmon also displays the following errors after MGMT Event: D=
evice disconnected (sorry, console cut them, could not capture to file):
> >> bluetoothd[2974]: =3D profiles/input/hog-lib.c:proto_mode_read_cb() Pr=
otocol Mode characteristic read failed: Request attribute has encountered a=
n...   14.720255
> >> bluetoothd[2974]: =3D profiles/input/hog-lib.c:report_reference_cb() R=
ead Report Reference descriptor failed: Request attribute has encountered a=
n...   14.720368
> >> bluetoothd[2974]: =3D profiles/input/hog-lib.c:report_reference_cb() R=
ead Report Reference descriptor failed: Request attribute has encountered a=
n...   14.720401
> >> bluetoothd[2974]: =3D profiles/input/hog-lib.c:info_read_cb() HID Info=
rmation read failed: Request attribute has encountered an unlikely error   =
       14.720616
> >> bluetoothd[2974]: =3D profiles/deviceinfo/deviceinfo.c:read_pnpid_cb()=
 Error reading PNP_ID value: Request attribute has encountered an unlikely =
er..   14.720675
> >>
> >> =3D=3DAdditional Information:=3D=3D
> >> The mouse also sometimes stops working suddenly. In this case it might=
 come back after a few seconds, but sometimes I have to use "systemctl rest=
art bluetooth" which re-enables the mouse. This might be a different proble=
m though. I have no way to reproduce this well so I also could not produce =
a log file yet.
> >>
> >> Please tell me if I can provide any additional information. Thank you =
for your work on this piece of software! :)
> >>
> >> Cheers,
> >>    Jonas
>
> Thank you very much for the extremely quick reply!
> After pairing the device with bluetoothctl it finally reconnects after re=
boot.
> I have some basic knowledge of C/C++ - where would I start looking for in=
 the GNOME sources? Any specific function calls I could search for to have =
a starting point? I have no idea about how the UI would call things from th=
e bluetooth system ...

@Bastien Nocera do you happen to know why gnome not register a pairing
agent? Ive seem quite a few reports of things not working after
rebooting lately which hints to No-bonding pairing happening or
perhaps fedora uses main.conf:AlwaysPairable?


--=20
Luiz Augusto von Dentz
