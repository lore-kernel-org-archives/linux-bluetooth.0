Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth and HAL
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: hal@freedesktop.org
In-Reply-To: <pan.2005.01.19.22.54.29.108027@yahoo.com>
References: <pan.2005.01.19.22.54.29.108027@yahoo.com>
Content-Type: text/plain
Message-Id: <1106180785.8190.151.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 20 Jan 2005 01:26:25 +0100

Hi Paul,

> I want to add bluetooth devices in HAL (Hardware Abstraction Layer).
> This way all programs interesting in bluetooth devices can be notified of
> the addition or removal of a bluetooth device.
> What should we export about a bluetooth device that might be
> of interest for userspace programs ?
> I think of the following, but I don't know if we really need all of them:
> 
> bluetooth.address	string (ex: 00:0d:33:44:33:c6)
> bluetooth.interface	string  (ex: hci0)
> bluetooth.interface_up	int
> bluetooth.linux.driver	string   (ex: hci_usb)
> bluetooth.linux.ifindex		int
> bluetooth.linux.sysfs_path	string
> bluetooth.HCI_version		int
> bluetooth.HCI_revision		int
> bluetooth.LMP_version		int
> bluetooth.LMP_version		int
> bluetooth.Manufacturer	string
> bluetooth.ChipVersion	string
> Maybe :
> bluetooth.features	?
> bluetooth.packet_types	?
> 
> Corrections, comments and suggestions are appreciate.

looks fine so far, but ChipVersion is vendor specific and not really of
interest. For interface_up you may should simply take all flags and then
the userspace application can decode it like hciconfig does. You may
wanna include the features, but be aware of the extended features from
the Bluetooth 1.2 specification. The packet_types are useless and I am
going to remove that support at some point. Maybe you wanna add the
class of device value.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
