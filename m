Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1256648475.2367.106.camel@localhost.localdomain>
References: <1256648475.2367.106.camel@localhost.localdomain>
Date: Tue, 27 Oct 2009 17:32:20 -0300
Message-ID: <2d5a2c100910271332p1a036037x7ae1db9276c6ce1e@mail.gmail.com>
Subject: Re: Transient devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 27, 2009 at 10:01 AM, Bastien Nocera <hadess@hadess.net> wrote:
> Heya,
>
> I've had a few thoughts about some use cases that currently cause
> problems (or would cause problems) with bluetoothd.
>
>
> 1) Printer pairing and setup
>
> The cups backend will create a non-paired device to detect whether
> devices with a printer class have supported services.
>
> The problem is that the CUPS backend will not remove the device once
> done, and the device will now appear in the list of known devices for
> bluetoothd. In terms of UIs, that means it shows up in the wizard (as
> it's not paired or setup), but not in the properties, thus can't be
> removed from the list.
>
> It would be nice to receive this data and have it cached client-side
> instead, like we do for discovery results.

Not sure if Im following, but you can always cache the device
properties even if the device was created by CUPs. Also I think any
other process willing to do its own wizard for bluetooth is a bad idea
specially if you are caching some data in the application side, btw,
why do you need to cache this information?

I believe the most convenient is always using the applet to create
devices in a way that you virtually plug devices, so other subsystems
doesn't have to care about doing this, actually this very similar to
what macos does for 'Connect Network', what about 'Connect Printer'?

I know this cause an extra step to really enable the device, but
remember bluetooth is not really connected all the time.

> 2) Adapter provided devices
>
> Although we don't currently have code for that, it would be nice to
> handle the possibility.
>
> Some adapters provide a way to store link keys, and other data
> pertaining to input devices.
>
> The problem with setting those up is that the pairing will be permanent
> on the bluetoothd side. We should make sure the associations go away
> when the adapter goes down.

The link key is per adapter and afaik there is no way to use it with
another adapter.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
