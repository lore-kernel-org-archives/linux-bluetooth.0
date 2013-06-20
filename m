Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
Date: Thu, 20 Jun 2013 08:31:24 -0400
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Message-Id: <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com> <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org> <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>>> I'm experiencing a problem that wedges the bluetooth adapter from time
>>> to time. The repro case can be hit with this scenario:
>>> 
>>> run bluetoothd
>>> while hciconfig hci0 up && hciconfig hci0 down; do echo -n .; done
>>> 
>>> In few iterations you will have a timeout while trying to bring up the
>>> interface. This is just a repro case, the real scenario just happens
>>> from time to time if you for instance restart bluetoothd at the right
>>> (or wrong!) moment.
>> 
>> can you give us at least a few details on the kernel you are running and what hardware this is?
> 
> I'm running kernel 3.8.11 on a x86_64 and BlueZ 5.4. The hardware is a
> chromebook (I saw it with different hardware and I can also repro it
> on my ubuntu) that uses the ath9k and ath3k drivers for the wifi/bt
> chip (MD222)

I do not have a Chromebook or actually looked into what Bluetooth chip it uses. Is that one also an ath3k one? Hope the hardware does not have a bug here. It is on USB, right?

Can you reproduce this with a off the shelf CSR or Broadcom chip. Maybe I should send you some of the Intel chips so you can test on our silicon as well ;)

>> If you do not use hciconfig and instead use btmgmt or bluetoothctl, do you see the same issue?
> 
> Using btmgmt I see the same issue with a very similar hcidump (just
> the timing is different).
> while btmgmt power on && btmgmt power off; do echo -n; done
> btmgmt power on after about 4 iterations is blocked and never returns.
> 
> Using the dbus interface to the running bluetoothd apparently doesn't
> hit the problem (ran fine for a few hundred times)
> while dbus-send --system --print-reply --dest=org.bluez
> /org/bluez/hci0 org.freedesktop.DBus.Properties.Set
> string:org.bluez.Adapter1 string:Powered variant:boolean:true &&
> dbus-send --system --print-reply --dest=org.bluez /org/bluez/hci0
> org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
> string:Powered variant:boolean:false; do echo -n; done

I can't say this for sure, but if this is our fault and not a hardware issue then this seems to be a pretty nasty race condition.

To debug this you might need to work with dynamic_debug for Bluetooth core and add a few more DBG statements so we get timing information that we can compare with the btmon trace.

So in theory all modern chips should send HCI_Reset on devup. Only a few old broken ones will send HCI_Reset on devdown. Can you check that the ath3k does not send a quirk here and really does HCI_Reset on devup. And that the ath3k firmware loading part not accidentally gets in the way.

It would be also good to verify if devup or devdown is the root cause here.

Regards

Marcel

