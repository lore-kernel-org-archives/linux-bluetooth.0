Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <524739BF-BD94-4276-BDAB-31B4944D24C3@holtmann.org>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org> <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org> <395166283.280598.1520200683559@email.1und1.de>
 <423BE2B6-2209-4390-B420-FA7267318A09@holtmann.org> <1219888621.198216.1520231304685@email.1und1.de>
 <524739BF-BD94-4276-BDAB-31B4944D24C3@holtmann.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 5 Mar 2018 08:55:34 +0100
Message-ID: <CAMZdPi8ab7n0B9qYyZaJAGf4qRH8eYXcUJ=B8pyvyLWyaNVX+Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lukas Wunner <lukas@wunner.de>,
	Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>,
	Johan Hedberg <johan.hedberg@gmail.com>, devicetree <devicetree@vger.kernel.org>,
	Loic Poulain <loic.poulain@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	linux-rpi-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
	Phil Elwell <phil@raspberrypi.org>, =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary="001a113d028806bf620566a5a92b"
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113d028806bf620566a5a92b
Content-Type: text/plain; charset="UTF-8"

> >>
> >> that is weird since we should be either in a probe context or in
hdev->open context and both can sleep as far as I know.

Yes but this is an explicit warning in gpiolib based on gpio controller
capabilities,
not on current context (WARN_ON(desc->gdev->chip->can_sleep)).

So, since we are always in process/thread context here, it seems safe to
use the _cansleep version.

Regards,
Loic

--001a113d028806bf620566a5a92b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; &gt;&gt;<br>&gt; &gt;&gt; that is weird since we shou=
ld be either in a probe context or in hdev-&gt;open context and both can sl=
eep as far as I know.<br><br>Yes but this is an explicit warning in gpiolib=
 based on gpio controller capabilities,<br>not on current context (WARN_ON(=
desc-&gt;gdev-&gt;chip-&gt;can_sleep)).<br><br>So, since we are always in p=
rocess/thread context here, it seems safe to use the _cansleep version.<br>=
<br>Regards,<br>Loic<br></div>

--001a113d028806bf620566a5a92b--
