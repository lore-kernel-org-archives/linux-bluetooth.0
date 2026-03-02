Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037B31280C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439300; cv=none; b=GjWXlwTQzDuH6lwAbl2wXBA4hlJkJ86SucRcxPS30Vpo9JYg5leeQjMyAfAd2lDiMSjHw9XUWmo2Y9GSmCchPWSGpr2IuRiBu6VGw5Qvwf74UPIqB4GHe3PuAtNT9w28ExREFDiOxYF7ge79JyOmy1iSH1Xei3W0Svmk8Zu5vTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439300; c=relaxed/simple;
	bh=Vg1I1nMuLr7IoUJpfqY+CZQTtl4UyuRwy9Oj2NVSeOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VR/+r551zfgeCWkPvlKZqCN4MMEqpkaKO8lS7e9IgI+TNWrLgZVuojSPO+kkod0q0V4/1PW/AKhcA91VFxT2RW2jTCyUaozhbOc5wvZGJ6X+aCEc1zKXGq9Nbto8wqzFq6GFI/6P1GdFsxy+6PjBh0E6D7W7wLs8xFQQnQOzSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 387D8443C0;
	Mon,  2 Mar 2026 08:14:56 +0000 (UTC)
Message-ID: <d7e804582c0f3f0fb163e0c8766f222f4905618b.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/5] Enable and add support for Nintendo Switch 2
 controllers
From: Bastien Nocera <hadess@hadess.net>
To: Martin BTS <martinbts@gmx.net>, linux-bluetooth@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Date: Mon, 02 Mar 2026 09:14:55 +0100
In-Reply-To: <20260301152930.221472-1-martinbts@gmx.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepfeekjeffkeeggeefvedtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehmrghrthhinhgsthhssehgmhigrdhnvghtpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgv
 ghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihesvghnughrihhfthdrtghomh

Hey Martin,

On Sun, 2026-03-01 at 16:29 +0100, Martin BTS wrote:
> The Nintendo Switch 2 controllers are special in their handshake
> (requirements) and the way how they use GATT notifications to
> transport user
> input.
>=20
> This patchset plows the road and introduces an initial plugin for NS2
> controllers, resulting in a uhid device that can be sensibly used by
> hid-generic but is also supposed to sit well with the new (out-of-
> tree)
> hid-switch2 driver.
>=20
> Patches 1 and 2 are required, 3 and 4 are QoL improvements and patch
> 5
> is the Nintendo Switch 2 specific part.
>=20
> Disclaimer:
> I only have a Pro Controller 2 and all work has been done with this
> Pro
> Controller 2 only. This is also my first contribution ever this close
> to the
> kernel. I may only appear to know what I am doing and the development
> status
> is "works on my machine".=20

Can you please keep Vicki Pfau (CC'ed) in the recipients list for your
patchset? She already started working on a switch2 device driver for
the USB and Bluetooth transports and sent the USB version for review
recently.

Cheers

>=20
> Martin BTS (5):
> =C2=A0 shared/att: Don't disconnect on ATT request timeout
> =C2=A0 shared/gatt-client: Handle secondary discovery timeout
> =C2=A0 device: Add btd_device_set_alias()
> =C2=A0 dbus-common: Add Gaming appearance class (0x2a)
> =C2=A0 plugins/switch2: Add Nintendo Switch 2 Controller plugin
>=20
> =C2=A0Makefile.plugins=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0plugins/switch2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1053
> ++++++++++++++++++++++++++++++++++++++
> =C2=A0src/dbus-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 2 +
> =C2=A0src/device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 14 +
> =C2=A0src/device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0src/shared/att.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 12 +-
> =C2=A0src/shared/gatt-client.c |=C2=A0=C2=A0 13 +
> =C2=A07 files changed, 1094 insertions(+), 4 deletions(-)
> =C2=A0create mode 100644 plugins/switch2.c
