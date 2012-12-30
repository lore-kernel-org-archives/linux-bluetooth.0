Return-Path: <cyrus@holtmann.org>
Message-ID: <1356892983.19248.82.camel@aeonflux>
Subject: Re: bluez-5.0 dropped --with-ouifile=PATH
From: Marcel Holtmann <marcel@holtmann.org>
To: Pacho Ramos <pacho@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 30 Dec 2012 10:43:03 -0800
In-Reply-To: <1356878136.18481.1.camel@belkin4>
References: <1356878136.18481.1.camel@belkin4>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

> That option is needed on Gentoo to let it catch oui.txt file present
> on /usr/share/misc/oui.txt, could it be re-added to prevent us from
> needing to sed src/oui.c looking for that file in our location?

or you build against a recent version of udev that comes with hwdb
support. Then it will actually start using the efficient version of
reading the OUI values from this file.

There is no plan to keep support for oui.txt for very long. It is still
supported as transition period, but that is about it.

Regards

Marcel


