Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Enabling BT 1.2 features on Logitech Mobile
	Freedom Headset?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <ctqd54$geq$1@sea.gmane.org>
References: <ctqd54$geq$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1107344136.11616.16.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 02 Feb 2005 12:35:36 +0100

Hi Jesse,

> My Anycom USB-240 dongle, marketed as BT 1.2 *ready*, despite
> containing BT 1.1 firmware, seems to be doing AFH by default:
> 
> [5:55]jesse@trevarthan:[/home/jesse]# hciconfig hci0 afhmode
> hci0:   Type: USB
>         BD Address: 00:0B:0D:34:1F:E0 ACL MTU: 120:20  SCO MTU: 64:0
>         AFH mode: Enabled
> 
> However, my Logitech Mobile Freedom Headset, also marketed
> as a BT 1.2 device, *isn't* doing AFH:
> 
> [5:55]jesse@trevarthan:[/home/jesse]# hcitool afh 00:0D:44:36:E6:F4
> AFH disabled
> 
> Does anyone know how I might enable AFH on my headset? Without
> AFH, my 802.11b network is unusable while the headset is streaming
> audio...

what does "hciconfig hci0 features version" and "hcitool info <headset>"
prints out?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
