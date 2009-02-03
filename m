Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How can i configure bluez to transmit Voice over PCM
Date: Tue, 3 Feb 2009 08:56:38 +0100
Message-ID: <49ED01FC03EE524BB7BB258E8F93BFF32F3E3D@bfl-exchange-1.BFL.local>
In-Reply-To: <1233507125.4809.2.camel@californication>
References: <49ED01FC03EE524BB7BB258E8F93BFF32F3DB5@bfl-exchange-1.BFL.local> <1233507125.4809.2.camel@californication>
From: "Matuschka, Sebastian" <Sebastian.Matuschka@gcd-solutions.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

> Also when using PCM for SCO then you need to use the D-Bus API for
> headsets and not the ALSA plugin.
>=20
As far as I understand it, D-Bus is for exchanging information between
processes, correct? So I need a device driver and a device where the PCM
stream is sent to. What type of device and driver do I respectively the
D-Bus API need?
Regards
Sebastian
