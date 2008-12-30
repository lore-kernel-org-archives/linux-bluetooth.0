Return-Path: <cyrus@holtmann.org>
Message-ID: <4959AE62.8020605@villagepublishing.com.au>
Date: Tue, 30 Dec 2008 16:15:14 +1100
From: David Thornton <david@villagepublishing.com.au>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: bccmds
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks,

I looked at bccmd.c in /tools right after you posted - and hence solved 
my problem.

I am, though, getting a strange error after sending an HCI inquiry command.

here are the first 15 lines of each response:

thingo: 0x04
thingo: 0x0f
thingo: 0x04
thingo: 0x00
thingo: 0x01
thingo: 0x00
thingo: 0x00
thingo: 0x00
thingo: 0x00
thingo: 0x00

that packet is normal - command status event

thingo: 0x04
thingo: 0x10
thingo: 0x01
thingo: 0x35
thingo: 0x01
thingo: 0x00
thingo: 0x00
thingo: 0x00
thingo: 0x00
thingo: 0x00

hardware error - but i cannot tell what the error code means (yes i will 
check Core Spec 2.0 now :) )

thingo: 0x04
thingo: 0xff
thingo: 0x1f
thingo: 0xc3
thingo: 0x02
thingo: 0x00
thingo: 0x0f
thingo: 0x00
thingo: 0x20
thingo: 0xa7

this packet looks like a CSR manufaturer specific response (0xff) what 
does that mean?

even stranger is when run again and every subsequent time before a 
reboot (of bluecore) it  works and gives back the correct amount of 
hosts found!!!

Is it to do with some kind of baud error? Bluecore can adapt to 
different baud rates just by looking at the data sent over time - but i 
want to know what effect this - moreover what it mucks up.

thanks and sorry for the long email
