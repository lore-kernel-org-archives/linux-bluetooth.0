Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20040415232702.GA24097@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] kernel oops when usb dongle plugged in with module loaded
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 16 Apr 2004 01:27:02 +0200

Hi,

I face the same problem as Matthias Thomae with an Acer BT600 and
utils/libs 2.6. I investigated the Oops after reinserting usb dongle
problem a bit. And  noticed that it Oops only, when hci_usb module had
been loaded before the dongle was plugged in. So unloading the module
before plugging in the device and everthing works fine (of course only
when the module was loaded thereafter automaticalls or manually).
If you pull out the dongle and then unload the module, you can reinsert
the BT dongle. If you manually modprobe the module before plugging in
the device, it Oops too.

I tested  2.6.4 which doesn't seem to be affected, but 2.6.5 and
2.6.5-mh3 show this behaviour.

I added the oops from  my syslog:
Apr 16 00:28:41 thinkpad kernel: drivers/usb/core/usb.c: usb_hotplug
Apr 16 00:28:41 thinkpad kernel: usb 2-1: registering 2-1:1.0 (config
#1, interface 0)
Apr 16 00:28:41 thinkpad kernel: drivers/usb/core/usb.c: usb_hotplug
Apr 16 00:28:41 thinkpad kernel: hci_usb 2-1:1.0: usb_probe_interface
Apr 16 00:28:41 thinkpad kernel: hci_usb 2-1:1.0: usb_probe_interface -
got id
Apr 16 00:28:42 thinkpad kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Apr 16 00:28:42 thinkpad kernel:  printing eip:
Apr 16 00:28:42 thinkpad kernel: c0255489
Apr 16 00:28:42 thinkpad kernel: *pde = 00000000
Apr 16 00:28:42 thinkpad kernel: Oops: 0000 [#1]
Apr 16 00:28:42 thinkpad kernel: PREEMPT 
Apr 16 00:28:42 thinkpad kernel: CPU:    0
Apr 16 00:28:42 thinkpad kernel: EIP:
0060:[usb_disable_interface+11/53]    Not tainted
Apr 16 00:28:42 thinkpad kernel: EFLAGS: 00010246   (2.6.5-mh3) 
Apr 16 00:28:42 thinkpad kernel: EIP is at
usb_disable_interface+0xb/0x35
Apr 16 00:28:42 thinkpad kernel: eax: ccbdc000   ebx: 00000000   ecx:
cfd92000   edx: c0e96c80
Apr 16 00:28:42 thinkpad kernel: esi: 00000002   edi: 00000000   ebp:
ccbdc000   esp: cfd93d44
Apr 16 00:28:42 thinkpad kernel: ds: 007b   es: 007b   ss: 0068
Apr 16 00:28:42 thinkpad kernel: Process khubd (pid: 5,
threadinfo=cfd92000 task=c12ba080)
Apr 16 00:28:42 thinkpad kernel: Stack: ccbdc000 00000002 00000001
c0e966b0 c02556f5 00000001 00000002 00000001 
Apr 16 00:28:42 thinkpad kernel:        00000000 00000000 00001388
00000000 c0e96c80 00000000 c0e96a80 c0e96b38 
Apr 16 00:28:42 thinkpad kernel:        c0e96d80 d088b942 c12babc0
c12babe0 00000018 00000003 00000002 00000001 
Apr 16 00:28:42 thinkpad kernel: Call Trace:
Apr 16 00:28:42 thinkpad kernel:  [usb_set_interface+147/354]
usb_set_interface+0x93/0x162
Apr 16 00:28:42 thinkpad kernel:
[__crc_blk_queue_make_request+2092763/2906822] hci_usb_probe+0x216/0x44a
[hci_usb]
Apr 16 00:28:42 thinkpad kernel:  [printk+288/368] printk+0x120/0x170
Apr 16 00:28:42 thinkpad kernel:  [usb_probe_interface+170/187]
usb_probe_interface+0xaa/0xbb
Apr 16 00:28:42 thinkpad kernel:  [bus_match+50/91] bus_match+0x32/0x5b
Apr 16 00:28:42 thinkpad kernel:  [device_attach+58/135]
device_attach+0x3a/0x87
Apr 16 00:28:42 thinkpad kernel:  [sysfs_create_group+72/121]
sysfs_create_group+0x48/0x79
Apr 16 00:28:42 thinkpad kernel:  [bus_add_device+84/140]
bus_add_device+0x54/0x8c
Apr 16 00:28:42 thinkpad kernel:  [device_add+148/271]
device_add+0x94/0x10f
Apr 16 00:28:42 thinkpad kernel:  [usb_set_configuration+521/664]
usb_set_configuration+0x209/0x298
Apr 16 00:28:42 thinkpad kernel:  [usb_new_device+702/1370]
usb_new_device+0x2be/0x55a
Apr 16 00:28:42 thinkpad kernel:  [hub_port_connect_change+432/675]
hub_port_connect_change+0x1b0/0x2a3
Apr 16 00:28:42 thinkpad kernel:  [hub_events+867/1061]
hub_events+0x363/0x425
Apr 16 00:28:42 thinkpad kernel:  [hub_thread+43/236]
hub_thread+0x2b/0xec
Apr 16 00:28:42 thinkpad kernel:  [ret_from_fork+6/20]
ret_from_fork+0x6/0x14
Apr 16 00:28:42 thinkpad kernel:  [default_wake_function+0/12]
default_wake_function+0x0/0xc
Apr 16 00:28:42 thinkpad kernel:  [hub_thread+0/236] hub_thread+0x0/0xec
Apr 16 00:28:42 thinkpad kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Apr 16 00:28:42 thinkpad kernel: 
Apr 16 00:28:42 thinkpad kernel: Code: 80 7b 04 00 74 1f 31 f6 8b 43 0c
83 c7 01 0f b6 54 30 02 83 
Apr 16 00:28:42 thinkpad usb.agent[1680]: kernel driver hci_usb already
loaded


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
