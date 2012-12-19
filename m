Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 19 Dec 2012 13:10:32 +0200
Message-ID: <CAGXs5wVmFirtMq6ZeUna7q0hfxpedMOcPEEVuD2r09Whet1Z=A@mail.gmail.com>
Subject: hci_emu and hci_vhci
From: Kevin Wilson <wkevils@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

What can we test with hci_emu and hci_vhci ?

When I tried:
modprobe hci_vhci
and then
./hciemu -n 10

I see with hciconfig that a virtual device was created (it shows Bus: VIRTUAL)
When I have no other BT physical device, which tests can I do with the virtual
	hci device ?
	
When I try :
hciconfig scan
or
hciconfig inq
I get this answer in both cases:
Inquiry failed: Invalid request code

Also when I set both PSCAN/ISCAN bit in it, I cannot see it when scanning
from other machine with physical BT devices.

So I assume testing with pan --connect, etc also won't work.

Are there any tests which we can do with a virtual
hci device ?

rgs
Kevin
