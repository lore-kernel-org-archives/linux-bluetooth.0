Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Oct 2008 16:28:08 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <0K9100LJ4ENCPS80@gb0135mbx01.mail.slb.com>
MIME-version: 1.0
Subject: Re: [Bluez-devel] Pairing with a Headset
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Tried again with bluez-4.15...

At 17:50 15-10-08, you wrote:
>At 15:36 12-10-08, you wrote:
> >Hi,
> >
> >I'm using bluez-4.12/bluez-gnome-1.8 and tried out pairing my laptop
> >with a SE HBH-610 headset
> >
> >A couple of questions:
> >
> >snip
> >
> >Q2 My os uses 2.6.26 and I have the following bt modules loaded:
> >
> >Module                  Size  Used by
> >sco                     9472  2
> >bnep                   11264  2
> >rfcomm                 29328  4
> >l2cap                  17920  16 bnep,rfcomm
> >hci_usb                13084  3
> >bluetooth              42852  11 sco,bnep,rfcomm,l2cap,hci_usb
> >
> >Do I need to apply the seven bt patches for 2.6.26 or will the
> >headset work as is - i.e. is the btusb (?) module required for sco to work?
> >-------------------------------------------------------------------------
>So, after applying patch-mh7 and recompiling, I get the btusb module
>instead of hci_usb
>
>When pairing using bluez-gnome, everything proceeds as normal up
>until the "pairing complete" message at which point the system
>freezes and the only way out is to switch off.
>
>It's difficult to trouble-shoot as this system is totally ram based -
>did anybody else see this problem?
>----------------------------------------

Output from bluetoothd -dn up until system freeze

hcid_dbus_bonding_process-complete: status 00
adapter_get_device (00:1E:45:8B:2A:33)
Releasing agent: 1:1 /org/bluez/agent/wizard
Probe devices for /org/bluez/hci0/dev_00_1E_45_8B_2A_33
adapter_get_device (00:1E:45:8B:2A:33)
adapter_handle_uuid: server not enabled for 
00001112-0000-1000-8000-00805f9b34fb (0x1112)
adapter_handle_uuid: server not enabled for 
0000111f-0000-1000-8000-00805f9b34fb (0x111f)
adapter_handle_uuid: server not enabled for 
0000110a-0000-1000-8000-00805f9b34fb (0x110a)
Found AV Target
Registered interface org.bluez.Control on path 
/org/bluez/hci0/dev_00_1E_45_8B_2A_33
Found AV Remote
Serial_probe: path /org/bluez/hci0/dev_00_1E_45_8B_2A_33
Registered interface org.bluez.Serial on path 
/org/bluez/hci0/dev_00_1E_45_8B_2A_33
Serial_probe: path /org/bluez/hci0/dev_00_1E_45_8B_2A_33
Network_probe: path /org/bluez/hci0/dev_00_1E_45_8B_2A_33
Registered interface org.bluez.Serial on path 
/org/bluez/hci0/dev_00_1E_45_8B_2A_33
Network_probe: path /org/bluez/hci0/dev_00_1E_45_8B_2A_33
[system freeze]

Any ideas would be welcome... 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
