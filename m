Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Oops in hci_usb
References: <20040501173626.GA3866@kos.to> <1083785352.4420.33.camel@pegasus> <20040506184816.GA7468@kos.to>
In-Reply-To: <20040506184816.GA7468@kos.to>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405062128.42044.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 6 May 2004 21:28:42 +0200

Send us 

hciconfig -a
hciconfig hci0 revision.

Possibly it is not CSR based dongle. We prefer using CSR based dongles

Michal

On Thursday 06 of May 2004 20:48, Riku Voipio wrote:
> On Wed, May 05, 2004 at 09:29:12PM +0200, Marcel Holtmann wrote:
> > this is a wild guess, but maybe the linking of the USB device into the
> > /sys structure causes this problem. So please comment out this line
> >
> > 	SET_HCIDEV_DEV(hdev, &intf->dev);
> >
> > in the hci_usb driver and try again.
>
> Seemingly didn't help..
>
> usb 4-1: USB disconnect, address 2
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> c019b4bf
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c019b4bf>]    Not tainted
> EFLAGS: 00010246   (2.6.6-rc-noprempt3)
> EIP is at get_kobj_path_length+0x1a/0x31
> eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: d993cf38
> esi: 00000001   edi: 00000000   ebp: ffffffff   esp: dd235e00
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 514, threadinfo=dd234000 task=dd28c830)
> Stack: c01c4e80 dd8d1819 dd8d1800 dd382390 c019b65e c02d9900 d993cf38
> 00000100 e016f8a0 c014ece7 dd235e40 dd8d1800 00000000 c02a4ee0 e016c591
> 00000000 c027ef6f d993cf38 d993cf30 e016f840 e016f8a0 c019b7e2 c027de26
> c02d9900 Call Trace:
>  [<c01c4e80>] class_hotplug_filter+0x0/0x2c
>  [<c019b65e>] kset_hotplug+0x139/0x268
>  [<c014ece7>] lookup_hash+0x1f/0x23
>  [<c019b7e2>] kobject_hotplug+0x55/0x57
>  [<c019bafb>] kobject_del+0x1b/0x33
>  [<c01c50df>] class_device_del+0x88/0xae
>  [<e0167d5c>] hci_unregister_dev+0x13/0x74 [bluetooth]
>  [<e015e8d9>] hci_usb_disconnect+0x35/0x7c [hci_usb]
>  [<e00870e0>] usb_unbind_interface+0x7a/0x7c [usbcore]
>  [<c01c4565>] device_release_driver+0x64/0x66
>  [<c01c4689>] bus_remove_device+0x55/0x96
>  [<c01c3756>] device_del+0x5d/0x9b
>  [<c01c37a7>] device_unregister+0x13/0x23
>  [<e008c891>] usb_disable_device+0x71/0xac [usbcore]
>  [<e0087bbd>] usb_disconnect+0x9b/0xe8 [usbcore]
>  [<e0089ac3>] hub_port_connect_change+0x26f/0x274 [usbcore]
>  [<e00894b4>] hub_port_status+0x45/0xb0 [usbcore]
>  [<e0089d6f>] hub_events+0x2a7/0x2fa [usbcore]
>  [<e0089def>] hub_thread+0x2d/0xe4 [usbcore]
>  [<c0103982>] ret_from_fork+0x6/0x14
>  [<c0112200>] default_wake_function+0x0/0x12
>  [<e0089dc2>] hub_thread+0x0/0xe4 [usbcore]
>  [<c0101f7d>] kernel_thread_helper+0x5/0xb
>
> Code: f2 ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
