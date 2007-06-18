Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Pascal <pascal@pabr.org>
Date: Mon, 18 Jun 2007 22:16:44 +0200
Message-ID: <f56p7n$lnu$1@sea.gmane.org>
References: <1181925876.31424.326.camel@cookie.hadess.net>	<1181977540.6846.38.camel@aeonflux.inter-touch.com>	<1182011715.31424.346.camel@cookie.hadess.net>	<1182022535.30934.11.camel@aeonflux.inter-touch.com>	<1182111907.3161.16.camel@cookie.hadess.net>	<1182171997.3161.29.camel@cookie.hadess.net>	<f5636a$qvr$1@sea.gmane.org>	<1182177408.3161.43.camel@cookie.hadess.net>	<1182182402.3161.52.camel@cookie.hadess.net>	<f56ffd$gd7$1@sea.gmane.org>
	<1182194592.2281.6.camel@cookie.hadess.net>
Mime-Version: 1.0
In-Reply-To: <1182194592.2281.6.camel@cookie.hadess.net>
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

> It's trying to "HIDP: Set report: Feature report" and gets disconnected
> afterwards.

OK, this comes from bluez-utils/input/server.c, right
before ioctl(HIDPCONNADD).

You could strace the bluetoothd-service-input process
to check whether this ioctl returns an error code.
If that doesn't help, you will have to add printk()s in
linux/net/bluetooth/hidp/core.c:hidp_add_connection()
to understand what is happening.

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
