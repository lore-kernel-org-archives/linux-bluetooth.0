Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY20-F1F019D190C77973EA71AF853D0@phx.gbl>
From: "Martin Rolsted Jensen" <mrj_ing@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Bluez-devel] Bluetooth on PXA255
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
Date: Wed, 06 Apr 2005 11:29:13 +0000

Hello everybody!
I am currently working on a triton1 board with a pxa255 module. I want to 
connect a UART Bluetooth module to the board (WML-C20AH).
The first thing I did was to configure the kernel (2.6.10) to support 
Bluetooth. As far as I can see in the boot sequence of Linux, the ttyBT 
interface is controlled by the standard ttyS1.
My question is how to control/setup the device? For instant hciconfig does 
not work.
I am newbie to Linux :-)

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
