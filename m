Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42663B80.6070309@nokia.com>
From: =?ISO-8859-1?Q?Timo_Ter=E4s?= <ext-timo.teras@nokia.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------040902000801090008010706"
Subject: [Bluez-devel] [PATCH] RFCOMM does not call tty_hangup() when DCD is de-asserted
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
Date: Wed, 20 Apr 2005 14:22:40 +0300

This is a multi-part message in MIME format.
--------------040902000801090008010706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

It seems that RFCOMM does not handle properly the de-assertation of CD 
signal. It should call tty_hangup() to work properly.

One side effect is that data calls that are hanged up from remote side 
are not detected as being hanged up.

I've made a very quick patch for this. In my case this patch enabled the 
detection carried detect signal de-assertation. But since I'm not an 
expert on RFCOMM stuff there might be some cases where tty_hangup() 
should not be called. In serial side the DCD change is handled by 
uart_handle_dcd_change() defined in include/linux/serial_core.h and it 
has some extra checks there as well.

So could some one wiser there check what actually has to be done for the 
hangup mechanism to work properly. Or if my patch looks good enough feel 
free to commit it.

Thanks,
   Timo

--------------040902000801090008010706
Content-Type: text/plain;
 name="bluez-dcd-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-dcd-fix.diff"

===== net/bluetooth/rfcomm/tty.c 1.36 vs edited =====
--- 1.36/net/bluetooth/rfcomm/tty.c	2005-04-13 15:55:20 +03:00
+++ edited/net/bluetooth/rfcomm/tty.c	2005-04-20 14:13:45 +03:00
@@ -531,6 +531,12 @@ static void rfcomm_dev_modem_status(stru
 	
 	BT_DBG("dlc %p dev %p v24_sig 0x%02x", dlc, dev, v24_sig);
 
+	if ((dev->modem_status & TIOCM_CD) &&
+	    !(v24_sig & RFCOMM_V24_DV)) {
+		if (dev->tty)
+			tty_hangup(dev->tty);
+	}
+
 	dev->modem_status = 
 		((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : 0) |
 		((v24_sig & RFCOMM_V24_RTR) ? (TIOCM_RTS | TIOCM_CTS) : 0) |

--------------040902000801090008010706--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
