Return-Path: <cyrus@holtmann.org>
From: Daniel Matthes <matthes@ftz.htwk-leipzig.de>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Date: Fri, 24 Oct 2008 15:23:01 +0200
Subject: AW: Establish a SPP Connection between two linux computers
Message-ID: <09E68493E3CD0D47BF12172B07F527382CCB5D1EBF@mail1.ftz.htwk-leipzig.de>
References: <09E68493E3CD0D47BF12172B07F527382CC88B2B9C@mail1.ftz.htwk-leipzig.de>
 <09E68493E3CD0D47BF12172B07F527382CC88B2BCE@mail1.ftz.htwk-leipzig.de>
 <09E68493E3CD0D47BF12172B07F527382CCB5D1EBA@mail1.ftz.htwk-leipzig.de>
In-Reply-To: <09E68493E3CD0D47BF12172B07F527382CCB5D1EBA@mail1.ftz.htwk-leipzig.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody, hello Marcel,

	
I need a quick answer to my question, to solve my task. Could someone please answer my question quickly

Thanks in advance

Daniel
-----Ursprüngliche Nachricht-----
Von: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] Im Auftrag von Daniel Matthes
Gesendet: Donnerstag, 23. Oktober 2008 10:43
An: 'linux-bluetooth@vger.kernel.org'
Betreff: Re: Establish a SPP Connection between two linux computers


Hello again,

Is somebody able to solve my problem?

I'm looking for a solution to connect two linux systems by using the serial port profile. I have so far found no way to solve this problem, because I could not find the serial port service within the bluez driver.

Regards Daniel

-----Ursprüngliche Nachricht-----
Von: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] Im Auftrag von Daniel Matthes
Gesendet: Dienstag, 21. Oktober 2008 15:16
An: 'linux-bluetooth@vger.kernel.org'
Betreff: Establish a SPP Connection between two linux computers

I want to connect two debian (lenny) systems with two Anycom USB-200 USB Dongles, so I've downloaded the bluez-1.41 driver.

I want to create a serial connection (by using SPP). 

At the beginning, I've tested the driver by connecting a linux operating system with a windows operating system.

I run  sdptool browse and I've found:

Service Name: Serieller Bluetooth-Anschluss
.
Protocol Descriptor List:
            "L2CAP"  (0x0100)
            "RFCOMM"  (0x0003)
                        Channel: 1
..

After this I run rfcomm bind 0 <bdaddr> 1 and then I could establish with minicom  a connection to the windows system and send data.

In the second turn. I install bluez on the second linux computer. After running sdptool browse, there are no entries for serial support.
I've also created an entry with sdptool add -channel 1 SP. Afterwards I could browse the serial port entry with the other computer,
but there was also no way to connect the computers.

So here my question:  How can I connect two linux systems with bluetooth by using the serial port profile.
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
