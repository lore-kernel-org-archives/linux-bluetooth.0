Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: radoa <cat@pobox.sk>
Message-ID: <loom.20041025T141305-8@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] =?utf-8?b?aGNpX2Rldl9vcGVu?= function
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 25 Oct 2004 12:21:00 +0000 (UTC)

Hi,

I want to ask how linux kernel initializes HCI sockets.
When bluetooth dongle is inserted to USB, is registered by USB driver in bluez 
stack as new device. But has not set flag HCI_UP, this flag is set only in call 
of ioctl command HCIDEVUP - which calls hci_dev_open(). Function hci_dev_open() 
resets BT dongle and receives its BT address. But where and when is ioctl with 
HCIDEVUP cmd called? It seems that ioctl call is only place where is BT dongle 
initialized.
I use kernel 2.6.8.1

Thank you very much

radoa



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
