Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth and detection devices actually present
From: Marcel Holtmann <marcel@holtmann.org>
To: Massimo Morini <morrisbit@yahoo.it>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <9741e91f0810010219xf3def84kbca579dfd16f0cf7@mail.gmail.com>
References: <9741e91f0810010219xf3def84kbca579dfd16f0cf7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 08:36:53 +0200
Message-Id: <1223015813.11272.32.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Massimo,

> In Applet 0.26 in Bluetooth devices detected appear, let's say, over time ...
> 
> I want to delete these devices (if I find the file)
> 
> 
> so by "explores devices," of Applet Bluetooth,
> i see devices actually present in the vicinity at that moment.
> 
> and not all those who took over in time BlueZ and that will be saved.
> 
> can you show me the files I try?

this should no longer be the case for bluez-gnome-1.x. We re-discover
them when needed.

Regards

Marcel


