Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4610D098.1030805@access-company.com>
References: <4610D098.1030805@access-company.com>
Date: Mon, 02 Apr 2007 12:35:11 +0200
Message-Id: <1175510111.5815.310.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Running bluez on vmware?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> A coworker is now working on running bluez over vmware. As a part of 
> that, he is trying to get a Bluetooth dongle to work (the same dongle 
> we've been using three weeks ago).
> 
> For far there seem to be a strange "hang" problem of hcid. It seems it 
> does not complete the initialization of the device.
> 
> I hope some of you might be able to provide some pointers on this issue, 
> so I'll present you what he's been able to come up so far.
> 
> Setup:
> 
> - BT dongle is connected through a USB 1.1 HUB. This is because vmware 
> supports only USB1.1 devices (more info is here: 
> http://kb.vmware.com/KanisaPlatform/Publishing/612/774_f.SAL_Public.html )
> 
> - it is possible to see the device in /proc/bus/usb/devices (its the 
> second device, has multiple interfaces):
> - After connecting the device it is possible to see two instances of 
> hcid. One is stuck in non-interruptible io/sleep (it will stay like that 
> until the device is disconnected):
> 
> /proc/bus/usb # ps w | grep hcid
>  2411 root        724 S   /usr/sbin/hcid -f /etc/bluetooth/hcid.conf
>  2423 root        224 D   /usr/sbin/hcid -f /etc/bluetooth/hcid.conf
> 
> ~ # hciconfig hci0 -a
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN
>         RX bytes:14 acl:0 sco:0 events:1 errors:0
>         TX bytes:6 acl:0 sco:0 commands:2 errors:0
> 
> ~ # hciconfig hci0 up
> 
> The command does not return (at least for a few minutes).
> When I disconnect the device, the following error is displayed (before 
> the prompt is displayed again):
> 
> Can't init device hci0: Input/output error (5)
> 
> 
> - syslog output for connecting the dongle :
> 
> Mar 27 12:48:07 Device user.info kernel: usb 1-1: new full speed USB 
> device using uhci_hcd and address 5
> Mar 27 12:48:08 Device user.info kernel: usb 1-1: configuration #1 
> chosen from 1 choice
> Mar 27 12:48:08 Device daemon.info hcid[2411]: HCI dev 0 registered
> Mar 27 12:48:08 Device daemon.info hcid[2411]: Register 
> path:/org/bluez/hci0 fallback:0
> Mar 27 10:51:29 Device syslog.info -- MARK --
> 
> - syslog output after disconnecting:
> 
> Mar 27 13:02:20 Device user.info kernel: usb 1-1: USB disconnect, address 5
> Mar 27 13:02:21 Device daemon.info hcid[2411]: HCI dev 0 unregistered
> Mar 27 13:02:21 Device daemon.info hcid[2411]: Unregister 
> path:/org/bluez/hci0
> Mar 27 13:02:21 Device daemon.info hcid[2411]: Device hci0 has been removed
> Mar 27 13:02:21 Device daemon.err hcid[2423]: Can't init device hci0: 
> Connection timed out (110)
> 
> One trace appears when the device is unplugged :
> hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c3d70bd4 err -19

this is not VMware related. It is the hub in between. Try to use a newer
kernel. I never figured out why this actually fails.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
