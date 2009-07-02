Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Jul 2009 22:21:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafael Seste <rseste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Can't connect to cell phone using dbus api
Message-ID: <20090702192104.GA18514@jh-x301>
References: <5d223510907021202gb1f466amc697137d582a168a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d223510907021202gb1f466amc697137d582a168a@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafael,

On Thu, Jul 02, 2009, Rafael Seste wrote:
> I'm trying to connect to my cellphone (nokia 5310) using the Dbus api.
> 
> First of all I created the device (org.bluez.Adapter.CreateDevice) and
> it worked but it didn't request the pin code. The simple-agent was
> running.

You'd need to use CreatePairedDevice if you want to pair. simple-agent
will also do it for you if you run it as "simple-agent hci0 <address>".

> Then I tried to connect using org.bluez.Audio.Connect but it returned
> the following error:
> 
> Error org.bluez.Error.ConnectFailed: Headset connect failed

That's because your phone isn't a headset :)

The Audio interface at the moment only supports headset-like devices but
not devices having the opposite role (i.e. those that usually connect to
headsets), like your phone.

> I tried to change the profile to HeadsetGateway
> (org.bluez.HeadsetGateway.Connect) and got this output:
> 
> Error org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with
> signature "" on interface "org.bluez.HeadsetGateway" doesn't exist

I think you'll need to explicitly enable the the experimental support for
that interface by adding Enable=Gateway to /etc/bluetooth/audio.conf.
However, even then you're likely to bump against problems since as I
mentioned the support is still completely experimental.

> Isn't it possible to connect with my cellphone?

It is but the audio profiles don't really work yet. Other profiles your
headset supports will most likely work better.

Johan
