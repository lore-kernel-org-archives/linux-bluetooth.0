Return-Path: <nchip@kos.to>
Date: Wed, 5 May 2004 22:07:25 +0300
From: Riku Voipio <riku.voipio@iki.fi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Oops in hci_usb
Message-ID: <20040505190725.GB1339@kos.to>
References: <20040501173626.GA3866@kos.to> <1083587205.4666.0.camel@pegasus> <20040503193747.GA21331@kos.to> <1083686495.4666.39.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1083686495.4666.39.camel@pegasus>
Sender: Riku Voipio <nchip@kos.to>
List-ID: <bluez-users.lists.sourceforge.net>

Here's an oops with SCO options enabled and without preempt. I wonder if
symbols are resolved from some wrong place, thou. Anyway, these oops
don't look like they are preempt-related.

 usb 4-1: USB disconnect, address 2
 Unable to handle kernel paging request at virtual address f000f0a4
  printing eip:
 c025a6fe
 *pde = 00000000
 Oops: 0002 [#1]
 CPU:    0
 EIP: 0060:[__scheduling_functions_start_here+74/188]    Not tainted
 EFLAGS: 00010002   (2.6.6-rc-noprempt3)
 EIP is at __down+0x4a/0xbc
 eax: f000f0a4   ebx: 00000068   ecx: 00000000   edx: de9b7e24
 esi: de9cb2b0   edi: 00000246   ebp: 00000070   esp: de9b7e18
 ds: 007b   es: 007b   ss: 0068
 Process khubd (pid: 510,threadinfo=de9b6000 task=de9cb2b0)
 Stack: 00000001 de9cb2b0 c0112200 00000070 00000000 e008ca2f def95000 80000200
        e016f8a0 dad6e580 e016f840 e016f8a0 c025a86c 00000068 ffff0001 00000000
        c0170342 daf35d54 e015f8e0 e016f8a0 debfbb30 c01c4d54 dad6e580 c027e049
 Call Trace:
  [default_wake_function+0/18] default_wake_function+0x0/0x12
  [pg0+533998127/1070284800] usb_set_interface+0xa3/0x167 [usbcore]
  [__down_failed+8/12] __down_failed+0x8/0xc
  [.text.lock.inode+5/15] .text.lock.inode+0x5/0xf
  [class_device_dev_unlink+26/30]class_device_dev_unlink+0x1a/0x1e
  [class_device_del+117/174] class_device_del+0x75/0xae
  [pg0+534895964/1070284800] hci_unregister_dev+0x13/0x74 [bluetooth]
  [pg0+534857951/1070284800] hci_usb_disconnect+0x35/0x7e [hci_usb]
  [pg0+533975264/1070284800] usb_unbind_interface+0x7a/0x7c [usbcore]
  [device_release_driver+100/102] device_release_driver+0x64/0x66
  [bus_remove_device+85/150] bus_remove_device+0x55/0x96
  [device_del+93/155] device_del+0x5d/0x9b
  [device_unregister+19/35] device_unregister+0x13/0x23
  [pg0+533997713/1070284800] usb_disable_device+0x71/0xac [usbcore]
  [pg0+533978045/1070284800] usb_disconnect+0x9b/0xe8 [usbcore]
  [pg0+533985987/1070284800] hub_port_connect_change+0x26f/0x274 [usbcore]
  [pg0+533984436/1070284800] hub_port_status+0x45/0xb0 [usbcore]
  [pg0+533986671/1070284800] hub_events+0x2a7/0x2fa [usbcore]
  [pg0+533986799/1070284800] hub_thread+0x2d/0xe4 [usbcore]
  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
  [default_wake_function+0/18] default_wake_function+0x0/0x12
  [pg0+533986754/1070284800] hub_thread+0x0/0xe4 [usbcore]
  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

 Code: 89 10 89 44 24 10 83 43 04 01 8b 43 04 83 e8 01 01 03 0f 98

-- 
Riku Voipio  	       | riku.voipio at iki.fi         |
kirkkonummentie 33     |    +358 44 5000343          --+--
02140 Espoo            |                               |
dark> A bad analogy is like leaky screwdriver          |
