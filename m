Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200501310806.ALV29436@ms12.netsolmail.com>
From: Chris Taylor <cht@imipolex-g.com>
Subject: Re: [Bluez-users] D-Link DWB-120M and BlueZ 2.14
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 31 Jan 2005 00:06:24 -0800


>this can only mean that the libusb developer package is not installed.
>Check when you call configure for something like:
>
>checking usb.h usability... yes
>checking usb.h presence... yes
>checking for usb.h... yes
>checking for usb_open in -lusb... yes
>checking for usb_get_busses in -lusb... yes
>checking for usb_interrupt_read in -lusb... yes

Aha! I installed the libusb developer package and the firmware utility 
installed and it work fine now! Thanks for your help.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
