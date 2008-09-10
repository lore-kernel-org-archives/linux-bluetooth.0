Return-Path: <cyrus@holtmann.org>
Subject: Re: Packaging question
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <48C685F1.9040905@suse.de>
References: <48C685F1.9040905@suse.de>
Content-Type: text/plain
Date: Thu, 11 Sep 2008 00:15:45 +0200
Message-Id: <1221084945.13336.31.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> I'm packaging bluez-4.4 right now and just wanted to gather opinions about the
> package naming (it might be good if distributions could agree on consistent
> naming of packages).
> 
> So how is everybody going to name the packages? The "old" ones for bluez-3.x
> were easy:
> 
> - either bluez-libs or libbluetooth2 for the libs
> - bluez-utils for the hcid and hciconfig and related stuff
> - bluez-audio for the audio stuff (packaged separately because of
>   the dependencies
> - bluez-cups for the cups backend
> 
> From a first glance, I'd just keep the package-naming as is, but since it is a
> major version update anyway, if we want to change it, now might be a good time
>  ;-)
> 
> Opinions, anyone?

it seems that everybody is keeping the package names as they are. So
mainly you have bluez-utils and bluez-libs (libbluetooth in case of
Debian).

The bluez-audio is the wrong approach and I commented on it already
multiple times. Check the Fedora packages. So actual audio plugin should
be part of bluez-utils since it has no dependencies whatsoever. And yes,
it makes sense to have it without the ALSA and GStreamer plugins.

So Fedora has bluez-alsa (containing the libasound* bits) and
bluez-gstreamer (containing the libgst* bits).

Check http://people.redhat.com/bnocera/bluez/bluez.spec for details.

Personally I like to see the bluez-utils package vanish and we are just
using bluez as main package name. Adding a virtual package bluetooth
that install all BlueZ packages would be nice to have, too.

This would result in the following package names:

	bluez
	bluez-libs
	bluez-libs-devel
	bluez-cups
	bluez-alsa
	bluez-gstreamer

Regards

Marcel


