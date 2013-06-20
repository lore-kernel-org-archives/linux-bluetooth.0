Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
 <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org> <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
 <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 20 Jun 2013 11:42:40 -0700
Message-ID: <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com>
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> I'm running kernel 3.8.11 on a x86_64 and BlueZ 5.4. The hardware is a
>> chromebook (I saw it with different hardware and I can also repro it
>> on my ubuntu) that uses the ath9k and ath3k drivers for the wifi/bt
>> chip (MD222)
>
> I do not have a Chromebook or actually looked into what Bluetooth chip it=
 uses. Is that one also an ath3k one? Hope the hardware does not have a bug=
 here. It is on USB, right?

Is an ath3k, and bluetooth is conected to the usb.

> Can you reproduce this with a off the shelf CSR or Broadcom chip. Maybe I=
 should send you some of the Intel chips so you can test on our silicon as =
well ;)

I just tried it again on my desktop with a Broadcom usb 0a5c:21e8 (I
think that one is a BCM20702) and I was able to reproduce it with
btmgmt as well (bluez compiled from tip of tree). It took more
iterations (about 50) but eventually the repro case works (in a
different point, see the btmon traces below). I have a bunch of
different Broadcom, Atheros and CSR usb bluetooth adapters here, but
none from Intel ;)

> I can't say this for sure, but if this is our fault and not a hardware is=
sue then this seems to be a pretty nasty race condition.
>
> To debug this you might need to work with dynamic_debug for Bluetooth cor=
e and add a few more DBG statements so we get timing information that we ca=
n compare with the btmon trace.
>
> So in theory all modern chips should send HCI_Reset on devup. Only a few =
old broken ones will send HCI_Reset on devdown. Can you check that the ath3=
k does not send a quirk here and really does HCI_Reset on devup. And that t=
he ath3k firmware loading part not accidentally gets in the way.
>
> It would be also good to verify if devup or devdown is the root cause her=
e.

I don't understand how this could be a hardware problem. I must be
missing something. The host is sending to the controller two
consecutive commands, the second one is a HCI_Reset caused by the
power off/on, but the spec says that we should not send more than one
command at that point (ncmd of the last event is 1). So, since we are
out of spec the firmware is happy to block itself in a bad way :)
right?

Regards,
Alex

< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2
                             [hci0] 58988.081654
        Supported: 0x01
        Simultaneous: 0x01
> HCI Event: Command Complete (0x0e) plen 4                                =
                         [hci0] 58988.084618
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
                             [hci0] 58988.084713
        Length: 18
        Flags: 0x18
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        TX power: 4 dBm
        Name (complete): Drink Mate
@ New Settings: 0x02d3
            powered connectable pairable ssp br/edr le
@ New Settings: 0x02d2
            connectable pairable ssp br/edr le
< HCI Command: Reset (0x03|0x0003) plen 0
                             [hci0] 58988.087811

---------------------------------------------------------------------------=
--------------------------------------------------------
other case:

< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2
                             [hci0] 61133.028188
        Supported: 0x01
        Simultaneous: 0x01
> HCI Event: Command Complete (0x0e) plen 4                                =
                         [hci0] 61133.031169
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
@ New Settings: 0x02d3
            powered connectable pairable ssp br/edr le
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
                             [hci0] 61133.031261
        Length: 18
        Flags: 0x18
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        TX power: 4 dBm
        Name (complete): Drink Mate
@ New Settings: 0x02d2
            connectable pairable ssp br/edr le
< HCI Command: Reset (0x03|0x0003) plen 0
                             [hci0] 61133.035268
