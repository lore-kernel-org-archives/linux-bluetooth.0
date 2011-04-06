Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Support hardcoded Nintendo Wii Remote pins
From: Bastien Nocera <hadess@hadess.net>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Daniele Forsi <dforsi@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Wed, 06 Apr 2011 19:05:44 +0100
In-Reply-To: <BANLkTi=gqh3fxYipPE9CqMgV=6Qr0MkTSA@mail.gmail.com>
References: <BANLkTikdXHstUxQ52RM6OMSnqfLWYJVMvg@mail.gmail.com>
	 <BANLkTinQBr7Scuab_KAs_1L1UY-E9j87pw@mail.gmail.com>
	 <BANLkTikn99GO4JV4uV64KCuka0G1QYYHpQ@mail.gmail.com>
	 <1302100288.3227.51.camel@novo.hadess.net>
	 <BANLkTi=gqh3fxYipPE9CqMgV=6Qr0MkTSA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1302113146.3227.62.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2011-04-06 at 19:55 +0200, David Herrmann wrote:
<snip>
> Exactly.
> 
> I prefer my solution with dba over sba because it allows to pair the wiimote
> without opening the backside. The only issue left with the patches is the
> VID/PID thing. It works perfectly for me when I delete the device with
> gnome-bluetooth and add the wiimote as new device.

gnome-bluetooth just calls RemoveDevice() which won't remove cached SDP
records, resolved name, etc. for the device. Best open
up /var/lib/bluetooth files with a text editor, and remove everything
related to your Wiimote for testing.

(or you can just nuke the directory if you don't care about pairing your
other devices again).

> It would be interesting to know from a bluez dev or gnome-bluetooth dev whether
> the SDP records are always retrieved before trying to connect to a remote
> device or whether we need to do this manually.

The ordering of this is done by bluetoothd, and I'm pretty certain that
the SDP records are only updated *after* pairing, as some devices might
refuse to answer SDP requests from unpaired devices.

But at that point we should already have a name for it cached (at least
with gnome-bluetooth, which waits for the name to be resolved to allow
you to go through the next steps).



