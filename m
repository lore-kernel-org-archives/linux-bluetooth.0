Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <06bf01c7f9e6$3008dcf0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Tue, 18 Sep 2007 13:22:23 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] Bluetooth / WiFi USB concurrency issue
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I have a bluetooth device on a USB slot and a WiFi device on another USB 
slot, and my mini-ATX PC (Ubuntu 7.04 kernel 2.6.30
Bluez 3.9) is connected to the network thanks to the WiFi/DHCP.

I have noticed that when a scan (sdptool) is performed, the network link (if 
I perform a simple "wget" for example) is either slowed down or interrupted 
(not sure) and carried one / completed once the scan is finished. On a 
former kernel / bluez it was simply crashed and I had to up/down the 
bluetooth device.

Do you have any idea why this weird thing happens ?

Thanks a lot,
Oli 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
