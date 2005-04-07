Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY20-F20A55F402EB690A199F6BD853E0@phx.gbl>
From: "Martin Rolsted Jensen" <mrj_ing@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Bluez-devel] Build BlueZ Libs and BluzZ Utils for ARM
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 07 Apr 2005 10:06:03 +0000

Hello everybody!

First of all thanks to Peter Wippich for his help - it gave me a clue, 
but¡K!

I am currently working on a triton1 board with a pxa255 module. I want to 
connect a UART Bluetooth module to the board (WML-C20AH).
The first thing I did was to configure the kernel (2.6.10) to support 
Bluetooth. As far as I can see in the boot sequence of Linux, the ttyBT 
interface is controlled by the standard ttyS1.

Peter told me to build BlueZ Libs and then BluzZ Utils for my platform ¡V I 
got that, marvellous.
My new question is how to build those on a host-PC for my arm-board (no gcc 
on that board).
Am I going to get them precompiled - if so were to get them, and how to 
install (step by step).
I am newbie to Linux ƒº

Best Regards

Martin Rolsted Jensen




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
