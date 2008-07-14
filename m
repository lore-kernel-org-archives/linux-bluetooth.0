Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Mon, 14 Jul 2008 02:30:16 +0000 (UTC)
Message-ID: <loom.20080714T020902-534@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] =?utf-8?q?Questions_when_tracing_the_hci=5Fusb?=
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

Hello, I am starting tracing the source code of hci_usb, and want to test the
Alternative Setting patches from Alok. But I have some questions:

(1) In hci_usb_isoc_rx_submit, I saw the usb_rcvisocpipe are initializing
settings for Host-side. But why is it necessary to call usb_submit_urb() to send
the urb, and then repeat infinitely in hci_usb_rx_complete when the returned
count is 0? Is that mandatory to do this to permit the usb device to send data
up to Host?

(2) Why the isoc is set to 2 in the beginning? What will happen when we set it
to something like "5" in the beginning? (Alok's patches seems to dynamically
adjust it depending on  hdev->conn_hash.sco_num)

Thanks,
Jui-Hao



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
