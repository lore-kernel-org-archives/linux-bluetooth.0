Return-Path: <crosser@average.org>
Subject: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: bluez-devel@lists.sourceforge.net
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain
Message-Id: <1073475736.6998.9.camel@pccross.average.org>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 14:42:16 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

Dear Marcel and guys,

I have stock 2.6.0 kernel, fairly recent Bluez utilities and MSI USB
Bluetooth dongle.  I have dund running, and if I try to start a PPP
session from a handheld shortly after the previous one has terminated, I
get kernel oops, pretty much every time.

Funny and probably unrelated thing is that the Palm (TT3) from which the
session was initiated often soft-resets itself in a minute after such
event...

Oops included (manually typed in from a photo of the screen).
Tell me if I can help in further investigation.

Eugene
=================
ksymoops 2.4.9 on i686 2.6.0.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0/ (default)
     -m /usr/src/linux-2.6/System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
ds: 007b   es: 007b   ss: 0068
Stack: d0b04b40 00000000 00000024 00000020 c0da4000 cefb3994 c0da5f00 d0b01f53
       00000000 00000000 00000020 cf822ab0 00000001 00001000 0efb21c0 00000000
       00000000 c0da5d65 ffffffff c030d580 00000000 cf7670f0 00000009 00000000
Call trace:
 [<d0b01f53>] l2cap_recv_frame+0x6d3/0xfb0 [l2cap]
 [<c017cf7d>] proc_alloc_inode_0x4d/0x80
 [<c0207128>] get_device+0x18/0x30
 [<d0a58d64>] uhci_submit_common+0x214/0x2e0 [uhci_hcd]
 [<c0258c1e>] hcd_submit_urb+0xfe/0x170
 [<c0259685>] usb_submit_urb+0x1c5/0x240
 [<c010f86a>] do_gettimeofday_0x2a/0xc0
 [<d0a532b4>] hci_usb_rx_complete+0x1a4/0x690 [hci_usb]
 [<d0b02da4>] l2cap_recv_acldata+0x184/0x350 [l2cap]
 [<d0a856c6>] hci_rx_task+0x2d6/0x370 [bluetooth]
 [<c0122d46>] tasklet_action+0x46/0x70
 [<c0122b59>] do_softirq+0x99/0xa0
 [<c010bb32>] do_IRQ+0x122/0x180
 [<c0109e48>] common_interrupt+0x18/0x20
Code: 0f 0b 28 01 89 32 b0 d0 eb 93 0f 0b cb 01 a0 32 b0 d0 e9 67
Using defaults from ksymoops -t elf32-i386 -a i386


Trace; d0b01f53 <_end+106e1ec3/3fbddf70>
Trace; c017cf7d <proc_alloc_inode+4d/80>
Trace; c0207128 <get_device+18/30>
Trace; d0a58d64 <_end+10638cd4/3fbddf70>
Trace; c0258c1e <hcd_submit_urb+fe/170>
Trace; c0259685 <usb_submit_urb+1c5/240>
Trace; c010f86a <do_gettimeofday+2a/c0>
Trace; d0a532b4 <_end+10633224/3fbddf70>
Trace; d0b02da4 <_end+106e2d14/3fbddf70>
Trace; d0a856c6 <_end+10665636/3fbddf70>
Trace; c0122d46 <tasklet_action+46/70>
Trace; c0122b59 <do_softirq+99/a0>
Trace; c010bb32 <do_IRQ+122/180>
Trace; c0109e48 <common_interrupt+18/20>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   28 01                     sub    %al,(%ecx)
Code;  00000004 Before first symbol
   4:   89 32                     mov    %esi,(%edx)
Code;  00000006 Before first symbol
   6:   b0 d0                     mov    $0xd0,%al
Code;  00000008 Before first symbol
   8:   eb 93                     jmp    ffffff9d <_EIP+0xffffff9d>
Code;  0000000a Before first symbol
   a:   0f 0b                     ud2a   
Code;  0000000c Before first symbol
   c:   cb                        lret   
Code;  0000000d Before first symbol
   d:   01 a0 32 b0 d0 e9         add    %esp,0xe9d0b032(%eax)
Code;  00000013 Before first symbol
  13:   67 00 00                  addr16 add %al,(%bx,%si)

 <0>Kernel panic: Fatal exception in interrupt

1 warning issued.  Results may not be reliable.
