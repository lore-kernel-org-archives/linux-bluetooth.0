Return-Path: <dv_mlist@verizon.net>
Subject: bluetooth pcmcia/cf serial errors with 2.6 kernel
From: digger vermont <dv_mlist@verizon.net>
To: Russell King <rmk+serial@arm.linux.org.uk>,
   Linux Serial <linux-serial@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Max Krasnyansky <maxk@qualcomm.com>,
   bluez-users <bluez-users@lists.sourceforge.net>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1074885137.3532.9.camel@myrna>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 14:16:42 -0500
List-ID: <bluez-users.lists.sourceforge.net>

Hello Russell King and Linux Serial Mailing List,

	Changes to the serial driver in 2.6.xx kernels have caused problems
with some bluetooth pcmcia/cf cards that do work properly with 2.4.xx
kernels. 

When the cards are plugged the uarts are correctly identified and the
ports created.  However, hciattach returns errors when trying to attach
the port to the BlueZ stack. Different settings have been tried such as
baud rates and irq's through setserial with no difference.
	
The problem is not platform specific.  It occurs on my powerbook.  I'm
not sure of the platforms of the other reported errors, but they are not
powerpc's.

Here are more specifics:

kernel 2.4.24 works fine

kernel 2.6.2-rc1 and 2.6.2-rc1-ben1
	Com One Platinum:Reported to work fine.
	Xircom PC cards:Reported to time out.
	Socket CF:	Error is "BCSP initialization timed out".
			Card is reported as "Socket", "CF+ Personal
			Network Card Rev 2.5"

Here is the top of the thread on the bluez-users mailing list:
	http://thread.gmane.org/gmane.linux.bluez.user/1864
	
If there is any other information I can help with please let me know.


Thanks,

digger	
	
