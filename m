Return-Path: <cyrus@holtmann.org>
Date: Sat, 4 Jul 2009 15:03:32 +0100 (BST)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Feature request: boolean properties to auto reconnect list of
 MAC's at daemon start up
In-Reply-To: <2d5a2c100907040637s73791batd85327f31cb4f1ee@mail.gmail.com>
References: <4A4F39E8.4020908@powercraft.nl>  <20090704135747.05efc95c@stoetzler> <2d5a2c100907040637s73791batd85327f31cb4f1ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1246716212.336777.600.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 4 Jul 2009, Luiz Augusto von Dentz wrote:

> > IIUC that's just how bluetooth input devices work: they do connect to
> > the host - not the other way round. So it is really a problem that
> > cannot be solved on bluez' side.
>
> Yep, most hid devices will just refuse the connection if the 'virtual
> cable plug' was already stabilised, in general this is also a bad idea
> for any connection attempt during the startup as we have no guarantee
> that the connection will complete.

see HIDNormallyConnectable attribute in the HID spec (7.11.13)

I certainly find with my Apple bluetooth keyboard and mouse that the host
OS (not using BlueZ btw) can connect to them at boot without my
intervention.

iain

