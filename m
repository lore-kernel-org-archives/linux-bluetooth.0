Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Russell Neches <russell@ccs.neu.edu>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with kernel-2.6.5
Message-ID: <20040423071748.GC6531@heliopause.vort.org>
References: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
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
Date: Fri, 23 Apr 2004 03:17:48 -0400


I also get a crash when removing USB Bluetooth keys, but I've had that
problem with all 2.6 kernels. 

You can see the first insert and remove events, which did not cause a
crash, followed the oops. I figured I'd post to coroborate the issue Tim
is having. 

Russell

Apr 23 03:06:15 localhost kernel: usb 4-1: new full speed USB device using address 2
Apr 23 03:06:16 localhost hal.hotplug[7797]: waiting for usb info at /devices/pci0000:00/0000:00:10.3/usb4/4-1
Apr 23 03:06:16 localhost kernel: Bluetooth: Core ver 2.4
Apr 23 03:06:16 localhost kernel: NET: Registered protocol family 31
Apr 23 03:06:16 localhost kernel: Bluetooth: HCI device and connection manager initialized
Apr 23 03:06:16 localhost kernel: Bluetooth: HCI socket layer initialized
Apr 23 03:06:16 localhost kernel: Bluetooth: HCI USB driver ver 2.5
Apr 23 03:06:16 localhost kernel: drivers/usb/core/usb.c: registered new driver hci_usb
Apr 23 03:06:16 localhost usb.agent[7771]:      hci_usb: loaded sucessfully
Apr 23 03:06:16 localhost usb.agent[7772]:      hci_usb: loaded sucessfully
Apr 23 03:06:16 localhost usb.agent[7770]:      hci_usb: loaded sucessfully
Apr 23 03:06:17 localhost hal.hotplug[7878]: waiting for usb info at /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.0
Apr 23 03:06:17 localhost hal.hotplug[7878]: /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.0 is an USB interface
Apr 23 03:06:17 localhost hal.hotplug[7878]: got info for /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.0 (waited 0 ms)
Apr 23 03:06:17 localhost hal.hotplug[7879]: waiting for bluetooth info at /class/bluetooth/hci0
Apr 23 03:06:17 localhost hal.hotplug[7879]: Dont know how to wait for bluetooth at /class/bluetooth/hci0; sleeping 1000 ms
Apr 23 03:06:17 localhost hal.hotplug[7880]: waiting for usb info at /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.2
Apr 23 03:06:17 localhost hal.hotplug[7880]: /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.2 is an USB interface
Apr 23 03:06:17 localhost hal.hotplug[7880]: got info for /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.2 (waited 0 ms)
Apr 23 03:06:17 localhost hal.hotplug[7881]: waiting for usb info at /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.1
Apr 23 03:06:17 localhost hal.hotplug[7881]: /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.1 is an USB interface
Apr 23 03:06:17 localhost hal.hotplug[7881]: got info for /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.1 (waited 0 ms)
Apr 23 03:06:36 localhost hal.hotplug[7797]: timed out for /devices/pci0000:00/0000:00:10.3/usb4/4-1 (waited 20000 ms)
Apr 23 03:06:51 localhost kernel: usb 4-1: USB disconnect, address 2
Apr 23 03:07:06 localhost kernel: usb 4-1: new full speed USB device using address 3
Apr 23 03:07:06 localhost usb.agent[7992]:      hci_usb: already loaded
Apr 23 03:07:06 localhost hal.hotplug[8020]: waiting for usb info at /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.0
Apr 23 03:07:06 localhost hal.hotplug[8020]: /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.0 is an USB interface
Apr 23 03:07:06 localhost kernel:  printing eip:
Apr 23 03:07:06 localhost kernel: e08cdee4
Apr 23 03:07:06 localhost kernel: Oops: 0000 [#1]
Apr 23 03:07:06 localhost kernel: PREEMPT 
Apr 23 03:07:06 localhost kernel: CPU:    0
Apr 23 03:07:06 localhost kernel: EIP:    0060:[<e08cdee4>]    Not tainted
Apr 23 03:07:06 localhost kernel: EFLAGS: 00010286   (2.6.5) 
Apr 23 03:07:06 localhost kernel: EIP is at usb_disable_interface+0x14/0x50 [usbcore]
Apr 23 03:07:06 localhost kernel: eax: ded02980   ebx: 00000000   ecx: df12e000   edx: dfeef100
Apr 23 03:07:06 localhost kernel: esi: 00000002   edi: 00000000   ebp: cb9b4800   esp: df12fd44
Apr 23 03:07:06 localhost kernel: ds: 007b   es: 007b   ss: 0068
Apr 23 03:07:06 localhost kernel: Process khubd (pid: 998, threadinfo=df12e000 task=df131700)
Apr 23 03:07:06 localhost kernel: Stack: 00000002 0000000b 00000001 00000002 ddecc6b0 cb9b4800 e08ce167 cb9b4800 
Apr 23 03:07:06 localhost kernel:        ded02980 0000000b 00000001 00000002 00000001 00000000 00000000 00001388 
Apr 23 03:07:06 localhost kernel:        00000000 ded02980 00000000 d5d99280 d5d99338 d5d99980 e0a43abf cb9b4800 
Apr 23 03:07:06 localhost kernel: Call Trace:
Apr 23 03:07:06 localhost kernel:  [<e08ce167>] usb_set_interface+0xb7/0x180 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<e0a43abf>] hci_usb_probe+0x22f/0x490 [hci_usb]
Apr 23 03:07:06 localhost kernel:  [<c0170606>] alloc_inode+0x146/0x150
Apr 23 03:07:06 localhost kernel:  [<c018c69d>] sysfs_new_inode+0x5d/0xb0
Apr 23 03:07:06 localhost kernel:  [<e08c8081>] usb_probe_interface+0x61/0x80 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<c02dd30f>] bus_match+0x3f/0x70
Apr 23 03:07:06 localhost kernel:  [<c02dd381>] device_attach+0x41/0xa0
Apr 23 03:07:06 localhost kernel:  [<c02dd56b>] bus_add_device+0x5b/0xa0
Apr 23 03:07:06 localhost kernel:  [<c02dc411>] device_add+0xa1/0x130
Apr 23 03:07:06 localhost kernel:  [<e08ce506>] usb_set_configuration+0x1d6/0x270 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<e08c90e9>] usb_new_device+0x249/0x3c0 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<e08caa15>] hub_port_connect_change+0x175/0x280 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<e08cadea>] hub_events+0x2ca/0x340 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<e08cae8d>] hub_thread+0x2d/0xf0 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<c010924e>] ret_from_fork+0x6/0x14
Apr 23 03:07:06 localhost kernel:  [<c011cd80>] default_wake_function+0x0/0x20
Apr 23 03:07:06 localhost kernel:  [<e08cae60>] hub_thread+0x0/0xf0 [usbcore]
Apr 23 03:07:06 localhost kernel:  [<c0107291>] kernel_thread_helper+0x5/0x14
Apr 23 03:07:06 localhost kernel: 
Apr 23 03:07:06 localhost kernel: Code: 80 7b 04 00 74 26 31 f6 8d 74 26 00 8b 43 0c 47 0f b6 44 30 
Apr 23 03:07:08 localhost hal.hotplug[8022]: waiting for usb info at /devices/pci0000:00/0000:00:10.3/usb4/4-1
Apr 23 03:07:26 localhost hal.hotplug[8020]: timed out for /devices/pci0000:00/0000:00:10.3/usb4/4-1/4-1:1.0 (waited 20000 ms)
Apr 23 03:07:28 localhost hal.hotplug[8022]: timed out for /devices/pci0000:00/0000:00:10.3/usb4/4-1 (waited 20000 ms)


On Wed, Apr 21, 2004 at 04:27:25AM +0100, Timothy Murphy wrote:
> I wonder if anyone has had a problem with Bluetooth in linux-2.6.5?
> I have a Sony C1VFK Picturebook with built-in bluetooth.
> Everything works fine in 2.6.3,
> buit when I go to 2.6.5 I get the oops below.
> I should say that this occurs after "service bluetooth restart" 
> and "spicctrl -l1" 
> (the latter being required to activate bluetooth on this machine).
> 
> It is possible that this has nothing to do with bluetooth,
> and is a USB problem.
> 
> I give below the output of ksymsoops when fed
> the relevant part of dmesg output,
> and this actual output.
> 
> Any suggestions gratefully received.
> 
> ===============================================
> ksymoops 2.4.9 on i686 2.6.5.  Options used
>      -V (default)
>      -k /proc/kallsyms (specified)
>      -l /proc/modules (default)
>      -o /lib/modules/2.6.5/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid 
> ksyms file?
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
> Warning (merge_maps): no symbols in merged map
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> cf8dea84
> *pde = 0a094067
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<cf8dea84>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286   (2.6.5) 
> eax: c72a51e0   ebx: 00000000   ecx: 00000286   edx: cefef0a0
> esi: 00000001   edi: 00000000   ebp: cab55c00   esp: cb9c5d24
> ds: 007b   es: 007b   ss: 0068
> Stack: 00001388 00000000 00000002 00000001 c72cb330 cab55c00 cf8ded78 cab55c00 
>        c72a51e0 0000000b 00000001 00000002 00000001 00000000 00000000 00001388 
>        00000000 c72a51e0 00000000 c72cb780 c72cb838 c72a52e0 cf8256dc cab55c00 
> Call Trace:
>  [<cf8ded78>] usb_set_interface+0xb8/0x1c0 [usbcore]
>  [<cf8256dc>] hci_usb_probe+0x23c/0x4b0 [hci_usb]
>  [<c0114c4a>] __wake_up_common+0x3a/0x70
>  [<cf8d80d9>] usb_probe_interface+0xb9/0xe0 [usbcore]
>  [<c01ef04f>] bus_match+0x3f/0x70
>  [<c01ef0bf>] device_attach+0x3f/0xa0
>  [<c01ef2cb>] bus_add_device+0x5b/0xa0
>  [<c01ee111>] device_add+0xa1/0x130
>  [<cf8df1b5>] usb_set_configuration+0x235/0x2e0 [usbcore]
>  [<cf8d934f>] usb_new_device+0x2df/0x5c0 [usbcore]
>  [<cf8db2ca>] hub_port_connect_change+0x1da/0x2f0 [usbcore]
>  [<cf8db754>] hub_events+0x374/0x420 [usbcore]
>  [<cf8db835>] hub_thread+0x35/0x110 [usbcore]
>  [<c0114bf0>] default_wake_function+0x0/0x20
>  [<cf8db800>] hub_thread+0x0/0x110 [usbcore]
>  [<c0104e8d>] kernel_thread_helper+0x5/0x18
> Code: 80 7b 04 00 74 26 31 f6 8d 74 26 00 8b 43 0c 47 0f b6 44 30 
> 
> 
> >>EIP; cf8dea84 No symbols available   <=====
> 
> Trace; cf8ded78 No symbols available
> Trace; cf8256dc No symbols available
> Trace; c0114c4a No symbols available
> Trace; cf8d80d9 No symbols available
> Trace; c01ef04f No symbols available
> Trace; c01ef0bf No symbols available
> Trace; c01ef2cb No symbols available
> Trace; c01ee111 No symbols available
> Trace; cf8df1b5 No symbols available
> Trace; cf8d934f No symbols available
> Trace; cf8db2ca No symbols available
> Trace; cf8db754 No symbols available
> Trace; cf8db835 No symbols available
> Trace; c0114bf0 No symbols available
> Trace; cf8db800 No symbols available
> Trace; c0104e8d No symbols available
> 
> Code;  cf8dea84 No symbols available
> 00000000 <_EIP>:
> Code;  cf8dea84 No symbols available   <=====
>    0:   80 7b 04 00               cmpb   $0x0,0x4(%ebx)   <=====
> Code;  cf8dea88 No symbols available
>    4:   74 26                     je     2c <_EIP+0x2c>
> Code;  cf8dea8a No symbols available
>    6:   31 f6                     xor    %esi,%esi
> Code;  cf8dea8c No symbols available
>    8:   8d 74 26 00               lea    0x0(%esi,1),%esi
> Code;  cf8dea90 No symbols available
>    c:   8b 43 0c                  mov    0xc(%ebx),%eax
> Code;  cf8dea93 No symbols available
>    f:   47                        inc    %edi
> Code;  cf8dea94 No symbols available
>   10:   0f b6 44 30 00            movzbl 0x0(%eax,%esi,1),%eax
> 
> 
> 2 warnings and 1 error issued.  Results may not be reliable.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
