Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <af00d3e489c2ea42ad03636143e3cb36@nleyten.com>
References: <af00d3e489c2ea42ad03636143e3cb36@nleyten.com>
From: Barry Byford <31baz66@gmail.com>
Date: Mon, 19 Dec 2016 19:32:09 +0000
Message-ID: <CAAu3APawTJPdFbiSWCDR0AdYp=_QFYJe=uGW0CabmsbsFWdU=w@mail.gmail.com>
Subject: Re: Data exchange between two bluetooth devices
To: Dario Teixeira <dario.teixeira@nleyten.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Dario,

On 19 December 2016 at 17:41, Dario Teixeira <dario.teixeira@nleyten.com> wrote:
> Hi,
>
> I'm new to Bluetooth programming, and I have some basic questions
> about the best approach to implement a fairly simple scenario.
> I have a small embedded device running Linux, and which supports
> Bluetooth 4.0.  I'm also developing a mobile app that needs to
> exchange some data with the embedded device.  The data consists
> of only a few JSON-encoded objects and is small in volume. The
> communication must happen bidirectionally, though.
>
> Those are pretty much the requirements.  Now the questions:
>
> a) On the embedded side, do I need to program a small daemon using
>    the DBUS-based Bluez API, or can I set up a special device and
>    read/write to it as if it were a character device?
>
> b) The old interface [1] has been deprecated, right?  (It's my
>    understanding that only the new DBUS-based API should be used.)
>
> c) Is Bluetooth Classic or Bluetooth Low Energy better for this
>    scenario? (I've read that BLE can dispense with pairing.)
>
> Thanks in advance for your time!
> Best regards,
> Dario Teixeira
>
> [1] https://people.csail.mit.edu/albert/bluez-intro/
>

I'll take a go at trying to answer this...
To answer your last question first, if you are only exchanging small
amounts of data then I would suggest going with BLE rather than
Classic. There are a couple of resources online that might be helpful
to give you some background.
1) Martin from Bluetooth SIG giving an overview:
https://youtu.be/auApsoMHxtA (There is an issue with the audio for the
first couple of minutes but stick with it)
2) Adafruit introduction to installing BlueZ
https://learn.adafruit.com/install-bluez-on-the-raspberry-pi/overview

Using BlueZ as a peripheral is still behind the --experimental flag so
you will need to read up on that.

There are some  BLE examples using DBus API in the BlueZ repository at:
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-advertisement

If you are more familiar with Javascript/Node then you might want to
take a look at:
https://github.com/sandeepmistry/bleno

Good luck!

Regards,
Barry

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
