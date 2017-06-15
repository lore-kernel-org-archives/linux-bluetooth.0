Return-Path: <marcos@scriven.org>
MIME-Version: 1.0
From: Marcos Scriven <marcos@scriven.org>
Date: Thu, 15 Jun 2017 23:20:52 +0100
Message-ID: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
Subject: Questions on event masks (specifically in tools/3dsp.c)
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

(NB I've resent this as plain text)

I've been trying out /tools/3dsp.c on a Raspberry Pi 3. There's some
background in this thread that Marcel mentioned
http://www.spinics.net/lists/linux-bluetooth/msg62198.html

The Raspberry Pi uses the Broadcom bcm43438 chip, which according to
the registration documents does support connectionless slave broadcast

I don't see any errors, but nothing seems to happen, so have been
taking a close look at the code, especially the start_glasses method.

In there I see the event masks:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.c#n316

uint8_t evtmask1[] = { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
uint8_t evtmask2[] = { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00 };


I thus looked at the spec for set event mask page 2 (section 7.3.69) -
but this mask, especially evtmask2, doesn't seem to make sense. Here's
the full table (edit resending as plain text):

Value

Parameter Description

0x0000000000000000

No events specified (default)

0x0000000000000001

Physical Link Complete Event

0x0000000000000002

Channel Selected Event

0x0000000000000004

Disconnection Physical Link Event

0x0000000000000008

Physical Link Loss Early Warning Event

0x0000000000000010

Physical Link Recovery Event

0x0000000000000020

Logical Link Complete Event

0x0000000000000040

Disconnection Logical Link Complete Event

0x0000000000000080

Flow Spec Modify Complete Event

0x0000000000000100

Number of Completed Data Blocks Event

0x0000000000000200

AMP Start Test Event

0x0000000000000400

AMP Test End Event

0x0000000000000800

AMP Receiver Report Event

0x0000000000001000

Short Range Mode Change Complete Event

0x0000000000002000

AMP Status Change Event

0xFFFFFFFFFFFFC0 00

Reserved for future use



Only the first two octets (by which I mean the rightmost four digits
in the table above, assuming little endianess) are in use.

So is it right to say 0xC0 => 8 + 4 + 0 + 0 for the 4th column, which
only contains options for 1 (Short range mode) and 2 (AMP Status
change)

And 0x74 is even more confusing, as there doesn't seem to be any
parameters mapped to that.

Can anyone help here please?

Thanks

Marcos
