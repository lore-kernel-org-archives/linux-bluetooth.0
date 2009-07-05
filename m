Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Jul 2009 13:32:59 +0200
From: Stefan Seyfried <seife@suse.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: udev rule bluetooth.rules
Message-ID: <20090705133259.1bb7bad7@stoetzler>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 5 Jul 2009 12:24:34 +0200
John Frankish <j-frankish@slb.com> wrote:

> Ref bluez-4.43 /etc/udev/bluetooth.rules:
> 
> # Run helper every time a Bluetooth device appears
> # On remove actions, bluetoothd should go away by itself
> ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd
> --udev"
> 
> Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules
> so that it starts in the correct order - i.e. after dbus?

That's taken care of - if dbus is not available, bluetoothd will exit
with return code 1. udev will notice that and later start it again in
the coldplug run.
-- 
Stefan Seyfried
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
