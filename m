Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.19.22.54.29.108027@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: hal@freedesktop.org
Subject: [Bluez-devel] Bluetooth and HAL
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
Date: Thu, 20 Jan 2005 00:54:30 +0200

Hi,

I want to add bluetooth devices in HAL (Hardware Abstraction Layer).
This way all programs interesting in bluetooth devices can be notified of
the addition or removal of a bluetooth device.
What should we export about a bluetooth device that might be
of interest for userspace programs ?
I think of the following, but I don't know if we really need all of them:

bluetooth.address	string (ex: 00:0d:33:44:33:c6)
bluetooth.interface	string  (ex: hci0)
bluetooth.interface_up	int
bluetooth.linux.driver	string   (ex: hci_usb)
bluetooth.linux.ifindex		int
bluetooth.linux.sysfs_path	string
bluetooth.HCI_version		int
bluetooth.HCI_revision		int
bluetooth.LMP_version		int
bluetooth.LMP_version		int
bluetooth.Manufacturer	string
bluetooth.ChipVersion	string
Maybe :
bluetooth.features	?
bluetooth.packet_types	?

Corrections, comments and suggestions are appreciate.

Thanks,
Paul



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
