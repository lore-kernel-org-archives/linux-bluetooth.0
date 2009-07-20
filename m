Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth works with udev-145 but had some weired issues with
 it
From: Marcel Holtmann <marcel@holtmann.org>
To: Justin Mattock <justinmattock@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com>
References: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 09:14:23 +0200
Message-Id: <1248074063.4549.88.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Justin,

> For some reason in rules.d
> for the permission setting:
> 
> #ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
> to
> RUN+="/usr/sbin/bluetoothd --udev"
> gets this working for me.
> prior to this, udev just would not activate
> bluetoothd
> Anyways thought it would be good to let people know.

this is pretty much strange. What kernel version are you using?

Kay, do you have any idea why such a simple rule would not work?

Regards

Marcel


