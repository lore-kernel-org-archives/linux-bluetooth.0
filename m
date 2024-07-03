Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47913D2B7
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001295; cv=none; b=tzprC04WnN6PJ0UB1WZBWFH8qfsVr9JaIbvISSH0aNWKOqPeE9wZSeIPqUVZ/Xtm6yiCOYIOOM1QfYJdJAV5JcaLHrbC/JajIMf7BJaQhl56kpQXjrOzObvM4p+iqh31rWjlC9yW9ZqtjNUtBFCusdK8ulT4RnbWpVDOrbg6c+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001295; c=relaxed/simple;
	bh=dhgfDzIxE+i/XMK1Gmz9JVriNuS7opZTj5zjKeJ+KKk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVy/V0m9vNCZobmQPlRucp65zlxfBbozysgn2uJo4/G4r9QdHbwXeCsH/UXT4++MYh9lPV9WgEcJLJfoBAkrsMxMkvUF4syR7Fza5X6TLBDX3ewA4brgULtoob3nDCKRgDQX0ftvUL8Zjq8gkLU3hKRkzpiSdpFztRm+k+Eou5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Lg3YHXtt; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Lg3YHXtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720001284; x=1720260484;
	bh=dhgfDzIxE+i/XMK1Gmz9JVriNuS7opZTj5zjKeJ+KKk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Lg3YHXttu7qlsynmdwud6W7jSMlJP+1eY0fH1xDtnCWSTXiks6re7sXVZdybEDU/F
	 JHsTZhRL+gUXkMmWpd9jhSFcViwQbMdw5H7UDGvvWO5Exk4gzRhlRymDWovEDj0Fxx
	 /kXoTOTULCNhPLxsIBRyegm0XgHNzRbjcmnZ85Hw7bUcO67k0ZQWkbRLVOQ0iDm4eN
	 kVQn0xvuKR2ppAcqwPH6Swgk0N2r2DK9ULBVperpgnFuK9eS/z+GrSE1fdRgl7hVOP
	 4pDo9uItU/SV5JZY6yCb4Hql+J2W0GRyhHdRzYTXDLEKiJHgpntMfyZednDZv1ha/4
	 yekX0OcyM9I1w==
Date: Wed, 03 Jul 2024 10:08:02 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: lexicdark@proton.me
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Issue with Logitech MX5500 (recurring)
Message-ID: <4HxYDsPdpKNJlPLO7_HWiFNMkeowb4hT1AZZKMHNdPLOne8ZkjZIsl5oRz7pjVUo7-Yxzxa56nNu2R0B-doPaKmuyJDOaLJrXcxHhs9o14M=@proton.me>
In-Reply-To: <CABBYNZ+yC=Z5PDK2nmegZFXGsJuu2S4y8ho6fMcQdb4xK4LKVQ@mail.gmail.com>
References: <Wz8HSZhvOzF1mcJnF44ilQFAE_utAwvRXYILQZzH_sGhEV4tGHH0duomsVNwj5aa-OzSJFCU1ZqbCZkbtqzGXJbUmVbwMgLjVqx9BmhJI3s=@proton.me> <CABBYNZ+yC=Z5PDK2nmegZFXGsJuu2S4y8ho6fMcQdb4xK4LKVQ@mail.gmail.com>
Feedback-ID: 102303237:user:proton
X-Pm-Message-ID: 6ab7611721be65f79427b95646575634131c7ba5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luiz, thanks for having a go.

what you say is correct:
from the recent package update that file was reinstalled as:-
KERNEL=3D=3D"hiddev*", ATTRS{idVendor}=3D=3D"046d", ATTRS{idProduct}=3D=3D"=
c70[345abce]|c71[3bc]", \
 RUN+=3D"hid2hci --method=3Dlogitech-hid --devpath=3D%p"

And I have changed it to:
KERNEL=3D=3D"hiddev*", ATTRS{idVendor}=3D=3D"046d", ATTRS{idProduct}=3D=3D"=
c70[345abce]|c71[3]", \
 RUN+=3D"hid2hci --method=3Dlogitech-hid --devpath=3D%p"

which works again.

This has been wrong for quite some time (many years) but was correct at som=
e stage prior (distant past) but I believe it was put back in when the --me=
thod=3Dlogitech-hid switch was added (incorrectly). That switch does not wo=
rk for this device.

As previously mentioned I have been on the Debian forums several times but =
it has been effectively ignored. So have been working around it ever since =
I installed bluez package for other things. The recent update gave me the i=
mpetus to give this another go more directly.

Alex

On Wednesday, July 3rd, 2024 at 03:17, Luiz Augusto von Dentz <luiz.dentz@g=
mail.com> wrote:

> Hi Alex,
>=20
> On Tue, Jul 2, 2024 at 9:25=E2=80=AFAM lexicdark@proton.me wrote:
>=20
> > Solution requested: Please remove the entries for the logitech MX5500 i=
n /lib/udev/rules.d/97-hid2hci.rules again (and please don't put them back =
in later)
> > This issue now keeps coming back every time a bluez update is pushed. A=
nd it has been going on since I have had it and reported to the Debian foru=
ms several times (but that has been useless, at best). It had been removed =
from configs. about a decade ago then it regressed when someone put it back=
.
> > Any self respecting Logitech MX5500 user wouldn't install bluez unless =
they had to (for other devices).
> > If I edit out the c71[bc] entries for the 046d device and the keyboard =
and mouse work again. These devices never have (and likely never will) work=
 with this forced mode switch. The devices only appear to work in the raw m=
ode. hid2hci --method=3Dlogitech-hid only stops the device from working bec=
ause the hardware doesn't actually support it (supplementary: likely a too =
early BT implementation, it has it's own bluetooth usb device which is to t=
alk with the mouse and keyboard but it seems you can't use it with other de=
vices, and the mouse and keyboard don't work with other BT dongles, at leas=
t as far as I have tried).
> >=20
> > lsusb
> > Bus 007 Device 004: ID 046d:c71c Logitech, Inc. Logitech BT Mini-Receiv=
er
> > Bus 007 Device 003: ID 046d:c71b Logitech, Inc. Logitech BT Mini-Receiv=
er
> > Bus 007 Device 005: ID 046d:c709 Logitech, Inc. BT Mini-Receiver (HCI m=
ode)/lib/udev/rules.d/97-hid2hci.rules
> > first two are mouse and keyboard, c709 is the dongle.
>=20
>=20
> Are you talking about the following rules:
>=20
> # Logitech devices
> KERNEL=3D=3D"hiddev*", ATTRS{idVendor}=3D=3D"046d",
> ATTRS{idProduct}=3D=3D"c70[345abce]|c71[34bc]", \
> RUN+=3D"hid2hci --method=3Dlogitech-hid --devpath=3D%p"
>=20
> I don't know who came up with these rules but it definitely hasn't
> changed in a long long time:
>=20
> commit 7ca701a6120778fb65905f02305963b79ff6d8de
> Author: Marcel Holtmann marcel@holtmann.org
>=20
> Date: Mon Dec 10 22:56:05 2012 +0100
>=20
> build: Put hid2hci udev rules next to the source code
>=20
> > Thanks,
> > Alex
>=20
>=20
>=20
> --
> Luiz Augusto von Dentz
