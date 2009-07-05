Return-Path: <cyrus@holtmann.org>
Subject: Re: udev rule bluetooth.rules
From: Marcel Holtmann <marcel@holtmann.org>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain
Date: Sun, 05 Jul 2009 09:24:56 -0700
Message-Id: <1246811096.12994.213.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> Ref bluez-4.43 /etc/udev/bluetooth.rules:
> 
> # Run helper every time a Bluetooth device appears
> # On remove actions, bluetoothd should go away by itself
> ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
> 
> Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules so that it starts in the correct order - i.e. after dbus?
> 
> Is it possible to have a udev rule check that dbus is running before executing?

you are right. I should have fixed this. Just forgot about it. What
number prefix do we want for Bluetooth.

Regards

Marcel


