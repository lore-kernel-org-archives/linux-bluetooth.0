Return-Path: <cyrus@holtmann.org>
Message-ID: <1355925422.1827.3.camel@aeonflux>
Subject: Re: hci_emu and hci_vhci
From: Marcel Holtmann <marcel@holtmann.org>
To: Kevin Wilson <wkevils@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 19 Dec 2012 14:57:02 +0100
In-Reply-To: <CAGXs5wVmFirtMq6ZeUna7q0hfxpedMOcPEEVuD2r09Whet1Z=A@mail.gmail.com>
References: <CAGXs5wVmFirtMq6ZeUna7q0hfxpedMOcPEEVuD2r09Whet1Z=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin,

> What can we test with hci_emu and hci_vhci ?
> 
> When I tried:
> modprobe hci_vhci
> and then
> ./hciemu -n 10
> 
> I see with hciconfig that a virtual device was created (it shows Bus: VIRTUAL)
> When I have no other BT physical device, which tests can I do with the virtual
> 	hci device ?
> 	
> When I try :
> hciconfig scan
> or
> hciconfig inq
> I get this answer in both cases:
> Inquiry failed: Invalid request code
> 
> Also when I set both PSCAN/ISCAN bit in it, I cannot see it when scanning
> from other machine with physical BT devices.

of course not. This one is virtual and does not magically transmit radio
waves ;)

> So I assume testing with pan --connect, etc also won't work.

If you start two entities of hciemu which each its own port number, then
you can connect between them. Of course if they are running on the same
host, then the network interfaces will not see any traffic. Local
traffic goes over the loopback interface.

> Are there any tests which we can do with a virtual
> hci device ?

Plenty of them, but you need a full piconet emulation for anything
further.

Regards

Marcel


