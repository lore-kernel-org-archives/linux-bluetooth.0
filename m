Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
Subject: [Bluez-users] Problem with kernel-2.6.5
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
Date: Wed, 21 Apr 2004 04:27:25 +0100

I wonder if anyone has had a problem with Bluetooth in linux-2.6.5?
I have a Sony C1VFK Picturebook with built-in bluetooth.
Everything works fine in 2.6.3,
buit when I go to 2.6.5 I get the oops below.
I should say that this occurs after "service bluetooth restart" 
and "spicctrl -l1" 
(the latter being required to activate bluetooth on this machine).

It is possible that this has nothing to do with bluetooth,
and is a USB problem.

I give below the output of ksymsoops when fed
the relevant part of dmesg output,
and this actual output.

Any suggestions gratefully received.

===============================================
ksymoops 2.4.9 on i686 2.6.5.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5/ (default)
     -m /usr/src/linux/System.map (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid 
ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
Warning (merge_maps): no symbols in merged map
Unable to handle kernel NULL pointer dereference at virtual address 00000004
cf8dea84
*pde = 0a094067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<cf8dea84>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.5) 
eax: c72a51e0   ebx: 00000000   ecx: 00000286   edx: cefef0a0
esi: 00000001   edi: 00000000   ebp: cab55c00   esp: cb9c5d24
ds: 007b   es: 007b   ss: 0068
Stack: 00001388 00000000 00000002 00000001 c72cb330 cab55c00 cf8ded78 cab55c00 
       c72a51e0 0000000b 00000001 00000002 00000001 00000000 00000000 00001388 
       00000000 c72a51e0 00000000 c72cb780 c72cb838 c72a52e0 cf8256dc cab55c00 
Call Trace:
 [<cf8ded78>] usb_set_interface+0xb8/0x1c0 [usbcore]
 [<cf8256dc>] hci_usb_probe+0x23c/0x4b0 [hci_usb]
 [<c0114c4a>] __wake_up_common+0x3a/0x70
 [<cf8d80d9>] usb_probe_interface+0xb9/0xe0 [usbcore]
 [<c01ef04f>] bus_match+0x3f/0x70
 [<c01ef0bf>] device_attach+0x3f/0xa0
 [<c01ef2cb>] bus_add_device+0x5b/0xa0
 [<c01ee111>] device_add+0xa1/0x130
 [<cf8df1b5>] usb_set_configuration+0x235/0x2e0 [usbcore]
 [<cf8d934f>] usb_new_device+0x2df/0x5c0 [usbcore]
 [<cf8db2ca>] hub_port_connect_change+0x1da/0x2f0 [usbcore]
 [<cf8db754>] hub_events+0x374/0x420 [usbcore]
 [<cf8db835>] hub_thread+0x35/0x110 [usbcore]
 [<c0114bf0>] default_wake_function+0x0/0x20
 [<cf8db800>] hub_thread+0x0/0x110 [usbcore]
 [<c0104e8d>] kernel_thread_helper+0x5/0x18
Code: 80 7b 04 00 74 26 31 f6 8d 74 26 00 8b 43 0c 47 0f b6 44 30 


>>EIP; cf8dea84 No symbols available   <=====

Trace; cf8ded78 No symbols available
Trace; cf8256dc No symbols available
Trace; c0114c4a No symbols available
Trace; cf8d80d9 No symbols available
Trace; c01ef04f No symbols available
Trace; c01ef0bf No symbols available
Trace; c01ef2cb No symbols available
Trace; c01ee111 No symbols available
Trace; cf8df1b5 No symbols available
Trace; cf8d934f No symbols available
Trace; cf8db2ca No symbols available
Trace; cf8db754 No symbols available
Trace; cf8db835 No symbols available
Trace; c0114bf0 No symbols available
Trace; cf8db800 No symbols available
Trace; c0104e8d No symbols available

Code;  cf8dea84 No symbols available
00000000 <_EIP>:
Code;  cf8dea84 No symbols available   <=====
   0:   80 7b 04 00               cmpb   $0x0,0x4(%ebx)   <=====
Code;  cf8dea88 No symbols available
   4:   74 26                     je     2c <_EIP+0x2c>
Code;  cf8dea8a No symbols available
   6:   31 f6                     xor    %esi,%esi
Code;  cf8dea8c No symbols available
   8:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  cf8dea90 No symbols available
   c:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  cf8dea93 No symbols available
   f:   47                        inc    %edi
Code;  cf8dea94 No symbols available
  10:   0f b6 44 30 00            movzbl 0x0(%eax,%esi,1),%eax


2 warnings and 1 error issued.  Results may not be reliable.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
