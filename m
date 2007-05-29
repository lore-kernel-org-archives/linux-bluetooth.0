Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f3ev58$iku$1@sea.gmane.org>
References: <f3ev58$iku$1@sea.gmane.org>
Date: Tue, 29 May 2007 06:04:15 +0200
Message-Id: <1180411455.21432.114.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Increasing HIDP_DEFAULT_MTU ?
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

Hi Pascal,

> I have a Bluetooth HID peripheral which sends 50-byte payloads
> on L2CAP psm 19, even though it has accepted a Config req with
> MTU 48.  As a result, the data never reaches userspace.
> Is this a bug in the device ?

which device is this. I might need to have one of it at home for
testing.

> Besides, even if the device implemented segmentation with
> DATC, a MTU of 48 might be a significant performance penalty
> (generating twice as many packets on the radio channel ?).

Actually we are not really supporting segmentation by ourself. If I had
one of the devices for testing, I might be able to fix that easily. Hint
hint :)

> So would it be appropriate to change
> bluez-libs-3.11/include/hidp.h:#define HIDP_DEFAULT_MTU 48
> to 672, as recommmended by HID_SPEC_V10 section 7.5.2 ?
> 
> Or maybe make it a command-line option for hidd and
> bluetoothd-service-input ?

I fixed the input service now. We will see how this works out. In
addition the 2.6.22-rc3 kernel contains a patch to fix a bug in the
L2CAP config handling.

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
