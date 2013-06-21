Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com>
Date: Fri, 21 Jun 2013 09:22:17 -0400
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Message-Id: <8D8512CF-7924-48A3-9B8E-78145262DA99@holtmann.org>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com> <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org> <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com> <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org> <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>>> I'm running kernel 3.8.11 on a x86_64 and BlueZ 5.4. The hardware is a
>>> chromebook (I saw it with different hardware and I can also repro it
>>> on my ubuntu) that uses the ath9k and ath3k drivers for the wifi/bt
>>> chip (MD222)
>> 
>> I do not have a Chromebook or actually looked into what Bluetooth chip it uses. Is that one also an ath3k one? Hope the hardware does not have a bug here. It is on USB, right?
> 
> Is an ath3k, and bluetooth is conected to the usb.
> 
>> Can you reproduce this with a off the shelf CSR or Broadcom chip. Maybe I should send you some of the Intel chips so you can test on our silicon as well ;)
> 
> I just tried it again on my desktop with a Broadcom usb 0a5c:21e8 (I
> think that one is a BCM20702) and I was able to reproduce it with
> btmgmt as well (bluez compiled from tip of tree). It took more
> iterations (about 50) but eventually the repro case works (in a
> different point, see the btmon traces below). I have a bunch of
> different Broadcom, Atheros and CSR usb bluetooth adapters here, but
> none from Intel ;)

let me see if we have some final production chips for you. I looked at my stack and it only has pre-production units in there. I rather not send these around.

>> I can't say this for sure, but if this is our fault and not a hardware issue then this seems to be a pretty nasty race condition.
>> 
>> To debug this you might need to work with dynamic_debug for Bluetooth core and add a few more DBG statements so we get timing information that we can compare with the btmon trace.
>> 
>> So in theory all modern chips should send HCI_Reset on devup. Only a few old broken ones will send HCI_Reset on devdown. Can you check that the ath3k does not send a quirk here and really does HCI_Reset on devup. And that the ath3k firmware loading part not accidentally gets in the way.
>> 
>> It would be also good to verify if devup or devdown is the root cause here.
> 
> I don't understand how this could be a hardware problem. I must be
> missing something. The host is sending to the controller two
> consecutive commands, the second one is a HCI_Reset caused by the
> power off/on, but the spec says that we should not send more than one
> command at that point (ncmd of the last event is 1). So, since we are
> out of spec the firmware is happy to block itself in a bad way :)
> right?

It is most likely our bug. Sometimes the hardware does however behave funny.

My guess right now is that you are hitting a really nasty race conditions and in ath3k chips is shows up easier since the command processing is slower.

So in hci_do_dev_close() we forcefully set the cmd_cnt to 1. And in case of HCI_QUIRK_RESET_ON_CLOSE we are sending a HCI Reset from close.

Before we go ahead with this, I like you to confirm what HCI Reset behavior you actually have for your hardware. HCI Reset on devup or on devdown. Check your full btmon where we send the HCI Reset.

What we might need to do different here is to check if we have a pending command, flush all other commands and then wait for this command to complete before sending HCI Reset.

So in theory that HCI Request Lock should protect the whole init and shutdown procedures and all mgmt and ioctl interfaces should block each other. Why this is not the case is something else to investigate. Maybe we have some issue there as well.

Regards

Marcel

