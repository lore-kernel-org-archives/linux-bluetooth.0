Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: Enabling autosuspend for btusb by default
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <9629d543-a8e2-27d2-21e5-7f6a21395e3c@redhat.com>
Date: Wed, 1 Nov 2017 15:31:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

<resend with a bunch of To and Cc address added, sorry?

Hi All,

I'm working on trying to improve the OOTB power-consumption
of Linux (Fedora Workstation) on laptops.

One of the easy wins here is enabling runtime-pm / autosuspend
for btusb, since on many laptops the USB bluetooth device is
the only USB device not using autosuspend, enabling this will
not only allow suspending the USB bluetooth device but also to
USB HCI, leading to a significant saving in power consumption
of aprox. 0.4W.

So I would like to look into enabling runtime-pm / autosuspend
for btusb by default.

Question, are there any known issues with enabling runtime-pm ?

I realize that simply enabling it for all btusb devices is a bit
of a big hammer and might be a bad idea since there will probably
be some devices out there which do not support this properly.

I was thinking that instead of enabling runtime-pm for all btusb
devices, maybe this is something which we can do a vendor-id
basis, starting with Intel and Broadcom devices ?

Regards,

Hans
