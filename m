Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Stefan Michaelis" <stefan.michaelis@gmx.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <27820.1125566922@www47.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] =?ISO-8859-1?Q?hid2hci_segementation_fault_at_boot_time?=
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
Date: Thu, 1 Sep 2005 11:28:42 +0200 (MEST)

Dear all,

I own a Logitech Bluetooth Desktop keyboard and mouse. I wanted to use the
Logitech dongle to additionally connect my Bluetooth headset to the PC for
Skype voice calls. 
So far no problems, modules and demons load fine, switched the Logitech
dongle to bluetooth mode via hid2hci.
To automate this process during boot time I enabled the bluetooth.init
script. The demons and modules still load fine, but hid2hci crashes with a
segmentation fault. When I run the init script after bootup as superuser
everything goes fine.
Any idea where is the difference or what I am doing wrong?
Running Suse 9.1 with a vanilla kernel 2.6.12.4. Tried the last three
releases of Bluez.

Regards

Stefan

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
