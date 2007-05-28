Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Pascal <pascal@pabr.org>
Date: Mon, 28 May 2007 18:14:31 +0200
Message-ID: <f3ev58$iku$1@sea.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Increasing HIDP_DEFAULT_MTU ?
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

Hi,

I have a Bluetooth HID peripheral which sends 50-byte payloads
on L2CAP psm 19, even though it has accepted a Config req with
MTU 48.  As a result, the data never reaches userspace.
Is this a bug in the device ?

Besides, even if the device implemented segmentation with
DATC, a MTU of 48 might be a significant performance penalty
(generating twice as many packets on the radio channel ?).

So would it be appropriate to change
bluez-libs-3.11/include/hidp.h:#define HIDP_DEFAULT_MTU 48
to 672, as recommmended by HID_SPEC_V10 section 7.5.2 ?

Or maybe make it a command-line option for hidd and
bluetoothd-service-input ?

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
