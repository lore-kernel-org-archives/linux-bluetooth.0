Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 23 Jul 2009 11:59:55 -0400
Message-ID: <bd54d4980907230859n5b414b5er3b834e13df9b301a@mail.gmail.com>
Subject: Intro
From: Brad Hein <linuxbrad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm working on an issue that appears to be related to the rfcomm part
of the bluez suite. I am suspecting a bug but need help determining
for sure...

What I'm trying to do is communicate, via rfcomm, with a bluetooth
serial device. I can talk to it via the /dev/rfcomm0 interface with
minicom and minicom never has a problem communicating with it.

But when I use other methods to access the rfcomm port, such as
"socat", "screen", and cat/printf from the shell, I'm seeing a problem
where data streams from the device asif I was sending things to it
continuously but I'm not. using hcidump I'm seeing data from thin air
being sent to the device.

I think there is a problem where rfcomm is sending (random?) stuff to
the device which the device sees as serial input and so it's
responding to it.

I have the same result against different devices. So far I've seen it on:
* My Palm Centro Phone
* My OBDii Bluetooth dongle that connects to my vehicle's onboard ECU.


An example may help illustrate the problem:

In the following experiment I set up the following:

* Used `rfcomm bind` command to attach rfcomm0 to my phone because the
bluetooth serial device isn't with me at the moment.
*  "cat /dev/rfcomm0" in one terminal
* "hcidump -X" in another terminal (as seen below)
* in a third window I ran the command `printf "ati\r" >> /dev/rfcomm0`
 to send a simple command to the phone.


All I sent was "ATi\r" and then I start seeing all kinds of responses
from the device, continuously until I ^C out of the "cat /dev/rfcomm0"
command.

If I use minicom to talk to the rfcomm device, I see "ERROR" for each
letter I type - which is expected behavior.



< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
      0000: 61 74 69 0d                                       ati.

================ That's what I sent - ati\r

> ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 11 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
================ This is expected response

< ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .

================ ACK?


> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
> ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1

================ ACK?


< ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0a                                                .

================ Who sent this? Not me!!!!!


> ACL data: handle 11 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..

================ Device says wtf? in response to the phantom \x0a sent earlier.


> ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1

================== ?

< ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .


=================== Phantom Packet - I didn't send this - who did?


> ACL data: handle 11 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..

=================== Response to another phantom packet

> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
> ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0a                                                .

=================== Phantom packet - I didn't send this, who did?


> ACL data: handle 11 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..

==================== Device response, device is performing as expected
- responding to the stuff that's being sent to it.
