Return-Path: <cyrus@holtmann.org>
Message-ID: <529D149D.8040908@ahsoftware.de>
Date: Tue, 03 Dec 2013 00:15:41 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Add empty udev rule to disable hid2hci by default
References: <529B7153.2060204@ahsoftware.de>
In-Reply-To: <529B7153.2060204@ahsoftware.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 01.12.2013 18:26, schrieb Alexander Holler:
> Hello.
>
> Almost every distribution gets it wrong and enables hid2hci by default
> (besides Fedora where I already intervened twice).
>
> This is a real problem, because it disables Bluetooth keyboards and/or
> mice which aren't paired with bluez, thus many Live-CDs and default
> installs aren't usable when only a Bluetooth keyboard is connect.
>
> An easy solution to disable that behaviour would be to install an empty
> rule in /etc/udev/rules.d named the same as the one in
> /lib/udev/rules.d. It could just contain a comment like

(...)

Unfortunately that isn't a very practical idea, as the rule(-file) would 
likely become installed again with every upgrade or reinstall. :(

> I think otherwise that problem will never go away. It's really
> unbelievable how many distributions got this wrong and thus how many
> Live-CDs and default installations are unusable when only a Bluetooth
> keyboard is used with a hid-aware Bluetooth dongle.

So another idea seems to be necessary to either educate distributions 
(or their package maintainers) that they should build a distinct package 
for hid2hci and don't install that package by default, or some mechanism 
which enables the user to enable/disable hid2hci (as it was the case 
before the udev-rule went to /lib),

Regards,

Alexander Holler
