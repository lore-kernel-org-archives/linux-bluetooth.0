Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Oops in hci_usb
Message-ID: <20040501203033.GA1900@gmx.net>
References: <20040501173626.GA3866@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040501173626.GA3866@kos.to>
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
Date: Sat, 1 May 2004 22:30:33 +0200

On  0, Riku Voipio <riku.voipio@iki.fi> wrote:

> Just found an oops, by usinh thinkpax x40:s enable/disable bluetooth
> button to disable the bluetooth radio... Like I forgot to say in the
> previous mail, please CC me, not subscribed and the archives seem not to
> work.
> 
> Linux wombat 2.6.6-rc1 #1 Wed Apr 21 03:05:54 EEST 2004 i686 GNU/Linux
> 
> usb 4-1: USB disconnect, address 2
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000068
>  printing eip:
> c017a875
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c017a875>]    Not tainted
> EFLAGS: 00010282   (2.6.6-rc1)
> EIP is at sysfs_hash_and_remove+0x15/0x7d
> eax: 00000000   ebx: e015b3c0   ecx: 00000068   edx: de4f0690
> esi: de544280   edi: e015b360   ebp: e015b3c0   esp: de76de58
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 280, threadinfo=de76c000 task=dea2e230)
> Stack: de4f0580 e0133cc0 e015b3c0 de81cd30 c01d2b5f de544280 c0292ca9 c01d2ee5
>        de81cd30 e015b3ac de81cc00 de81cc00 de7db800 de7db824 e01531fb de81cd30
>        de4f0590 de4f0180 e0132cda de81cc00 de4f0580 e0133cc0 de4f0680 e0133cc0
> Call Trace:
>  [<c01d2b5f>] class_device_dev_unlink+0x25/0x27
>  [<c01d2ee5>] class_device_del+0x75/0xae
>  [<e01531fb>] hci_unregister_dev+0x10/0x84 [bluetooth]
>  [<e0132cda>] hci_usb_disconnect+0x35/0x7f [hci_usb]
>  [<e00890e0>] usb_unbind_interface+0x7a/0x7c [usbcore]
>  [<c01d2365>] device_release_driver+0x64/0x66
>  [<c01d2489>] bus_remove_device+0x55/0x96
>  [<c01d1556>] device_del+0x5d/0x9b
>  [<c01d15a7>] device_unregister+0x13/0x23
>  [<e008ecfb>] usb_disable_device+0x71/0xac [usbcore]
>  [<e0089bbd>] usb_disconnect+0x9b/0xe8 [usbcore]
>  [<e008bbd3>] hub_port_connect_change+0x26f/0x274 [usbcore]
>  [<e008b5c4>] hub_port_status+0x45/0xb0 [usbcore]
>  [<e008beab>] hub_events+0x2d3/0x346 [usbcore]
>  [<e008bf4b>] hub_thread+0x2d/0xe4 [usbcore]
>  [<c0103b6e>] ret_from_fork+0x6/0x14
>  [<c011342c>] default_wake_function+0x0/0x12
>  [<e008bf1e>] hub_thread+0x0/0xe4 [usbcore]
>  [<c0101ffd>] kernel_thread_helper+0x5/0xb
> 
> Code: ff 48 68 78 63 89 34 24 8b 44 24 18 89 44 24 04 e8 66 ff ff

USB Subsystem in 2.6.6-rc1/2 is heavily under construction. And has
several problems. This is not a hci_usb bug. And quiet normal for a
development pre release. Report bugs to usb developers. (but I think
this is known)

nicholas




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
