Return-Path: <dwmw2@redhat.com>
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1038466070.772.42.camel@pegasus.local> 
References: <1038466070.772.42.camel@pegasus.local>
	<5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
	<5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
	<5.1.0.14.2.20021127095652.07b78738@mail1.qualcomm.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Max Krasnyansky <maxk@qualcomm.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reuse of H4 and BCSP code 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Jan 2003 23:45:21 +0000
Message-ID: <11011.1042674321@passion.cambridge.redhat.com>
Sender: David Woodhouse <dwmw2@redhat.com>
List-ID: <bluez-devel.lists.sourceforge.net>


On Thu, 28 Nov 2002, marcel@rvs.uni-bielefeld.de said:
>  The serial.o have a register_serial function and I want to start
> playing with it. And yes we have one card that works with btuart_cs,
> but not with serial_cs. I was told that the "magic initialization" of
> serial_cs (or serial.o) causes the hciattach to fail, but the minimal
> things in btuart_cs keep it happy and the device will work. 

Having fixed the 8250 driver so it doesn't screw up the extended
functionality of the Oxford Semi OXCF950 on startup, it transpires that all
we were actually losing was the extra magic baud rate divisor. Using the old
serial driver from 2.4 and setting baud_base to 1152000 to compensate allows
you to use the line discipline code with the standard serial driver.

--
dwmw2
