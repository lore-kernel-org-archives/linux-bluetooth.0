Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44BB3BFB.80104@free.fr>
Date: Mon, 17 Jul 2006 09:27:55 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44B3F51E.1070009@free.fr> <1152644670.15028.42.camel@localhost>
In-Reply-To: <1152644670.15028.42.camel@localhost>
Content-Type: multipart/mixed; boundary="------------010505050500020502050603"
Subject: Re: [Bluez-devel] Broadcom 2035 SCO question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010505050500020502050603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Please see comments below :

> Hi Fabien,
> 
>> I recently purchased a class 1 "sweex" bluetooth USB dongle.  It has a 
>> broadcom bcm2035
>> usb chip( idVendor = 0x0a5c, idProduct = 0x200a). It advertises SCO 
>> mtu=16, sco packets = 0.
>> I tryed to use it with SCO, no luck.(I wasn't surprised by that, given 
>> sco packets = 0) Then i looked at hci usb driver and found it was in the 
>> blacklist, with HCI_BROKEN_ISOC.
>>
>> I then removed it from this list, forced SCO mtu to 48 and packets 
>> number to 8 by hacking hci_event.c... and guess what, it works !!
>>
>> So my question is: shouldn't this product marked as HCI_WRONG_SCO_MTU 
>> mtu instead of HCI_BROKEN_ISOC?
> 
> is it enough to change HCI_BROKEN_ISOC into HCI_WRONG_SCO_MTU to make
> this work. If yes, then I am happy to submit a patch.
> 

Yes. It is not perfect (i have some noise sometimes at startup), but it
is enough to make it work.

Please find attached one-line patch for this.

cheers,

Fabien


--------------010505050500020502050603
Content-Type: text/plain;
 name="patch-bcm2035.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-bcm2035.diff"

--- hci_usb.c	2006-07-15 15:32:34.000000000 +0200
+++ hci_usb.c	2006-07-15 15:32:47.000000000 +0200
@@ -108,7 +108,7 @@
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
 
 	/* Broadcom BCM2035 */
-	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
+	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */


--------------010505050500020502050603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--------------010505050500020502050603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010505050500020502050603--
