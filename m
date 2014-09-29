Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
Date: Mon, 29 Sep 2014 16:29:21 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1D7AEE8B-51DB-4A6D-8EBA-3EC81760224E@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com> <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com> <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org> <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

>>> We are dealing with an HID device which sends meaningful information in ADV_IND reports and to which we want to connect when receiving ADV_DIRECT_IND reports.
>>> 
>>> Without kernel support for auto-connecting on ADV_IND while still forwarding ADV_DIRECT_IND to userland, we are forced to keep active scanning on so that the content of ADV_IND reports isn't lost.
>>> 
> 
> I meant  "for auto-connecting on ADV_DIRECT_IND while still forwarding
> ADV_IND to userland", sorry
> 
>> I still think that what you really want is actually using Action 0x02 since you know the remote device address and you want to connect it. It does not matter if it happens via ADV_DIRECT_IND or ADV_IND in the end. However in case it happens via ADV_IND you want to get the advertising data and for that I am proposing to get it via Device Connected event.
> 
> Unfortunately, that is not good enough for this device. Let me give
> you some context.
> 
> This device doesn't have non-volatile memory, so, when its batteries
> are replaced it loses the bonding information (i.e. LTK).

if it can not store its LTK, then why doesn't it use a key hierarchy (as defined in the Bluetooth specification) so that it can restore its keys after reboot. If it remembers its Bluetooth address, then it could clearly remember a single master key.

But seriously, if you can remember your BD_ADDR, then you might want to remember your LTK as well. Just a hint here.

> * When bonded, the device sends ADV_DIRECT_IND.
> * When not bonded (fresh from factory or due to the batteries being
> replaced) it sends ADV_IND containing a special message (let's call it
> "power-on") reflecting that it's not bonded. When this happens we need
> to regenerate the device's LTK and rebond.
> 
> Action 0x02 (even when forwarding the the ADV_IND  report content via
> Device Connected event) is not good enough. In fact, none of the
> current auto-connect actions work for this device:
> 
> * With 0x00, (HCI_AUTO_CONN_REPORT) the content of ADV_IND is
> forwarded to userland but there is no auto-connection upon
> ADV_DIRECT_IND
> * With 0x01, (HCI_AUTO_CONN_DIRECT) there is auto-connection upon
> ADV_DIRECT_IND but if the device's batteries are removed (power-on
> ADV_IND) the device is not reconnected.
> * With 0x02, (HCI_AUTO_CONN_ALWAYS) there is auto-connection upon
> ADV_DIRECT_IND but replacing the device's batteries  (power-on
> ADV_IND) causes an infinite connection loop: connect->encryption
> on->disconnect(due to "encryption on" failing)->connect .... Getting
> the report data inside the  Device Connected event won't help because
> it will never get to that point.

So the encryption trigger is not done by the kernel. It is actually done by userspace when you have an existing LTK. The kernel will auto-conect the device with low security and then userspace will move it to medium security in case we have an LTK. It will also move it to medium security for all HID devices since that is mandatory.

It is not really the kernels fault that you have a loop here. The Action 0x02 would work perfectly fine. It is that userspace is too naive.

> The alternatives are
> 
> 1. Keep using passive scanning and add/modify an action to connect
> upon ADV_DIRECT_IND and forward ADV_IND to userland (to have the
> opportunity or rebonding).
> 2. Constantly do active scanning, which, again, we would like to avoid.

The active scanning will screw you over. It will increase your power consumption and also your latency. Using it for automatic connection trigger was a pretty bad idea from our side. It took us way too long to get kernel side auto-connection up and running.

Having the advertising data in Device Connected event will actually allow you to do exactly what you want. It would allow you to utilize Unpair Device (with Disconnect 0x00) and Pair Device to recreate the bonding. All without ever disconnecting the link.

The important piece of detail is that the security elevation from low to medium does not happen when the device is detected as initial powered on. So instead of security elevation, you do a re-bonding which will give you the encrypted link HID requires and also the new LTK.

So even if we allow Device Found with Action 0x01, then it still means that we would have to provide the same advertising data in Device Connected when using Action 0x02. Otherwise you have the gap that one Action provides all the information, the other one doesn't.

What could be done and I am not yet fully convinced that this is a good idea since it does not map to BR/EDR properly is the following:

0x00: ADV_DIRECT_IND is ignored, ADV_IND is reported via Device Found as connectable, ADV_NONCONN_IND and ADV_SCAN_IND are reported via Device Found as non-connectable (this is current behavior)

0x01: ADV_DIRECT_IND is auto-connected, ADV_IND is reported via Device Found as connectable, ADV_NONCONN_IND and ADV_SCAN_IND are reported via Device Found as non-conntable

0x02: ADV_DIRECT_IND and ADV_IND are auto-connected with advertising data in Device Connected event, ADV_NONCONN_IND and ADV_SCAN_IND are reported via Device Found as non-connectable

So before trying to redefine the Add Device command semantics, I would clearly go for adding the advertising data to Device Connected event and see if that gets you where you need to go.

Regards

Marcel

