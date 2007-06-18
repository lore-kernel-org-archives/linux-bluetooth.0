Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Pascal <pascal@pabr.org>
Date: Mon, 18 Jun 2007 19:30:12 +0200
Message-ID: <f56ffd$gd7$1@sea.gmane.org>
References: <1181925876.31424.326.camel@cookie.hadess.net>	<1181977540.6846.38.camel@aeonflux.inter-touch.com>	<1182011715.31424.346.camel@cookie.hadess.net>	<1182022535.30934.11.camel@aeonflux.inter-touch.com>	<1182111907.3161.16.camel@cookie.hadess.net>	<1182171997.3161.29.camel@cookie.hadess.net>	<f5636a$qvr$1@sea.gmane.org>	<1182177408.3161.43.camel@cookie.hadess.net>
	<1182182402.3161.52.camel@cookie.hadess.net>
Mime-Version: 1.0
In-Reply-To: <1182182402.3161.52.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] HID initiated connections and input service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
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

Bastien Nocera wrote:
> Jun 18 16:27:12 snoogens input[4052]: New input device 00:19:C1:7D:2E:FA ()
> 
> But no device is actually created.

Do you mean nothing shows up in /dev/input/ ?
Maybe you need to "modprobe joydev" or "modprobe evdev" manually.


> Could it be that I'm not setting the device flags to
> HIDP_BOOT_PROTOCOL_MODE? (Incidentally, is there any way to check
> whether a device is in this mode, or in full HID mode?)

You want it to be in "report protocol" mode, not "boot protocol".
The PS3 controller only supports "report protocol" anyway.
"hcidump -V -x" will show whether hidp.ko is trying to send a
"HIDP: Set protocol" command.

Pascal


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
