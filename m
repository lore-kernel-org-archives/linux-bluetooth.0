Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] getting bluetooth v1.2
From: Adam Goode <adam@evdebs.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1111943294.9195.250.camel@pegasus>
References: <25911.1111942263@www59.gmx.net>
	 <1111943294.9195.250.camel@pegasus>
Content-Type: text/plain
Message-Id: <1112024952.30560.2.camel@lynx.auton.cs.cmu.edu>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 28 Mar 2005 10:49:12 -0500

On Sun, 2005-03-27 at 19:08 +0200, Marcel Holtmann wrote:

> The revision on a D-Link DBT-120 is a hardware revision. It is possible
> to update the Rev. 4 dongles, but not with the btdfu program. The flash
> timing are not correct.
> 

This fixes btdfu for me with Rev. 4 dongles. 


--- dfu.c~      2004-06-16 20:02:01.000000000 -0400
+++ dfu.c       2005-03-03 14:07:53.000000000 -0500
@@ -33,7 +33,7 @@
 #include "dfu.h"

 #define DFU_PACKETSIZE         0x03ff          /* CSR default value:
1023 */
-#define DFU_TIMEOUT            100
+#define DFU_TIMEOUT            1000

 int dfu_detach(struct usb_dev_handle *udev, int intf)
 {




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
