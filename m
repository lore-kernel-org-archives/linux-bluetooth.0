Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Oops in hci_usb
References: <20040501173626.GA3866@kos.to> <1083686495.4666.39.camel@pegasus> <20040504172251.GA27072@kos.to>
In-Reply-To: <20040504172251.GA27072@kos.to>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405041930.50943.cijoml@volny.cz>
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
Date: Tue, 4 May 2004 19:30:50 +0200

Hi,

switch off Preempt kernel, switch off sco support. This helped me.

Michal

On Tuesday 04 of May 2004 19:22, Riku Voipio wrote:
> Hi Marcel,
>
> > > > do you enabled CONFIG_BT_HCIUSB_SCO in your kernel? If yes, disable
> > > > it and try again.
> > >
> > > Getting rid SCO option and updating to 2.6.6-RC3 makes the bluetooth
> > > on x40 work like a charm, no more oops and pairing worked first try.
> > > I can try 2.6.6-RC3 with CONFIG_BT_HCIUSB_SCO if you want to track
> > > the problem deeper.
> >
> > please do so, because actually I don't know why it happens.
>
> With -RC3 and SCO enabled, I get the following Oops: (Tanted due to
> madwifi)
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000068
>  printing eip:
> c017a671
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c017a671>]    Tainted: P
> EFLAGS: 00010282   (2.6.6-rc3)
> EIP is at sysfs_hash_and_remove+0x15/0x7d
> eax: 00000000   ebx: e006c3e0   ecx: 00000068   edx: ffff0001
> esi: dafc3680   edi: e006c380   ebp: e006c3e0   esp: ccc55e58
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 7775, threadinfo=ccc54000 task=ccc3c3b0)
> Stack: d3c87554 e0033d40 e006c3e0 c7804530 c01d2e4c dafc3680 c0293529
> c01d31c4 c7804530 e006c3cc c7804400 c7804400 d7189400 d7189424 e00641eb
> c7804530 d3c87564 d3c87454 e0032d11 c7804400 d3c87554 e0033d40 d3c87c54
> e0033d40 Call Trace:
>  [<c01d2e4c>] class_device_dev_unlink+0x1a/0x1e
>  [<c01d31c4>] class_device_del+0x75/0xae
>  [<e00641eb>] hci_unregister_dev+0x10/0x84 [bluetooth]
>  [<e0032d11>] hci_usb_disconnect+0x35/0x7c [hci_usb]
>  [<e00880e0>] usb_unbind_interface+0x7a/0x7c [usbcore]
>  [<c01d265d>] device_release_driver+0x64/0x66
>  [<c01d2781>] bus_remove_device+0x55/0x96
>  [<c01d184e>] device_del+0x5d/0x9b
>  [<c01d189f>] device_unregister+0x13/0x23
>  [<e008dcfb>] usb_disable_device+0x71/0xac [usbcore]
>  [<e0088bbd>] usb_disconnect+0x9b/0xe8 [usbcore]
>  [<e008abd3>] hub_port_connect_change+0x26f/0x274 [usbcore]
>  [<e008a5c4>] hub_port_status+0x45/0xb0 [usbcore]
>  [<e008aeab>] hub_events+0x2d3/0x346 [usbcore]
>  [<e008af4b>] hub_thread+0x2d/0xe4 [usbcore]
>  [<c0103b6e>] ret_from_fork+0x6/0x14
>  [<c01130ac>] default_wake_function+0x0/0x12
>  [<e008af1e>] hub_thread+0x0/0xe4 [usbcore]
>  [<c0101ffd>] kernel_thread_helper+0x5/0xb
>
> Code: ff 48 68 78 63 89 34 24 8b 44 24 18 89 44 24 04 e8 66 ff ff


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
