Return-Path: <cyrus@holtmann.org>
Subject: Re: How to set link policy with Logitech diNovo dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <493D7110.1020508@tommie-lie.de>
References: <493D7110.1020508@tommie-lie.de>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 20:51:47 +0100
Message-Id: <1228765907.28839.95.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> I recently got a used Logitech diNovo Media Desktop. It has a bluetooth
> hub and the Logitech MX900 bluetooth mouse. I first connected everything
> to my laptop with integrated Cambridge Silicon Bluetooth and everything
> worked fine. Then I plugged the Logitech hub to my desktop PC and used
> hid2hci to switch it over to HCI mode. I configured bluetooth for my
> system and connected to all the devices. Keyboard and Media Pad work
> fine, but the mouse is jumpy, as if some packets get buffered for some
> milliseconds before being send.
> I googled around and found a message from 2004 [1] stating that the
> link policy has to be set correctly. As you can see from my output of
> hciconfig -a (see below), it is not. I have a correct lp line in my
> /etc/bluetooth/hcid.conf (see below) and the exact same configuration
> enables all lp flags on my laptop's internal bluetooth (plugging in the
> Logitech hub to my laptop doesn't set the hub to proper lp either, but
> the internal bluetooth works!).
> Is there a way I can manually set the link policy? I understand that I
> can't use much of the tips from the thread refered to in [1], as the
> tools used there are outdated (I don't even have a hcid on my Ubuntu
> Intrepid Ibex 8.10 with bluez-utils 4.12 and kernel 2.6.27).
> Using another bluetooth mouse (Logitech Travel Mouse) on the Logitech
> hub connected to my PC works fine, the problem only occurs with the MX900.

for the 4.x series we removed the link policy setting and defaulted to
everything enabled. That just makes sense. Also the 2.6.27 kernel uses
the default link policy of Bluetooth and doesn't bother setting it on
every connection attempt. Seems like there might be a bug in bluez-4.12,
but to be honest I don't even bother debugging it since I just released
bluez-4.22 and it works fine for me.

However to be sure what is going on you have to run "hcidump -X -V" and
you can set the link policy manually via "hciconfig hci0 lp".

Regards

Marcel


