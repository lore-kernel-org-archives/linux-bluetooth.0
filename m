Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <463F7386.6050900@am.sony.com>
References: <463F7386.6050900@am.sony.com>
Date: Tue, 08 May 2007 09:15:51 +0200
Message-Id: <1178608551.8628.52.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net, maxk@qualcomm.com
Subject: Re: [Bluez-devel] [RFC] PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
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

Hi Geoff,

> It was found that the PS3 host controller needed this.  I'm not at all
> familiar with the bluetooth stack.  Could anyone suggest a better way?

the quirk is wrong. Please give me some information about the actual
used Bluetooth hardware. I need /proc/bus/usb/devices and once it is
working the output of hciconfig -a.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
