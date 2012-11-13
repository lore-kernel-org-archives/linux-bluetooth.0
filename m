Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Nov 2012 09:33:30 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 50541] New: Kernel OOPS in hidp when resuming from suspend
Message-ID: <20121113093330.0376a0c0@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>



Begin forwarded message:

Date: Tue, 13 Nov 2012 17:04:18 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: shemminger@linux-foundation.org
Subject: [Bug 50541] New: Kernel OOPS in hidp when resuming from suspend


https://bugzilla.kernel.org/show_bug.cgi?id=50541

           Summary: Kernel OOPS in hidp when resuming from suspend
           Product: Networking
           Version: 2.5
    Kernel Version: 3.5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
        AssignedTo: shemminger@linux-foundation.org
        ReportedBy: karllinuxtest.relton@ntlworld.com
        Regression: Yes


Somewhere between 3.2 and 3.5 an issue with bluetooth keyboards on resuming
from suspend crept in.

On a resume I now get the following:

Oct 23 15:42:34 laptop2 kernel: [10357.752131] BUG: unable to handle kernel
NULL pointer dereference at   (null)
Oct 23 15:42:34 laptop2 kernel: [10357.752273] IP: [<c1037a58>]
__ticket_spin_lock+0x8/0x30
Oct 23 15:42:34 laptop2 kernel: [10357.752379] *pdpt = 0000000000000000 *pde =
f000ec62f000ec62 
Oct 23 15:42:34 laptop2 kernel: [10357.752485] Oops: 0002 [#1] SMP 
Oct 23 15:42:34 laptop2 kernel: [10357.752551] Modules linked in: hid_generic
hid_apple hidp hid bnep rfcomm parport_pc ppdev autofs4 nfsd nfs binfmt_misc
lockd fscache auth_rpcgss nfs_acl sunrpc nls_iso8859_1 dm_crypt arc4
snd_hda_codec_idt snd_hda_intel snd_hda_codec joydev coretemp pcmcia iwlwifi
snd_hwdep snd_pcm yenta_socket snd_seq_midi btusb pcmcia_rsrc snd_rawmidi
pcmcia_core mac80211 kvm bluetooth snd_seq_midi_event snd_seq dell_laptop
dell_wmi cfg80211 snd_timer snd_seq_device microcode psmouse gpio_ich dcdbas
serio_raw sparse_keymap lpc_ich mac_hid snd soundcore snd_page_alloc
firewire_sbp2 lp parport firewire_ohci firewire_core crc_itu_t tg3 i915 wmi
drm_kms_helper drm i2c_algo_bit video
Oct 23 15:42:34 laptop2 kernel: [10357.753834] 
Oct 23 15:42:34 laptop2 kernel: [10357.753868] Pid: 10165, comm:
khidpd_05ac0256 Tainted: G        W    3.5.0-17-generic #28-Ubuntu Dell Inc.
Latitude D630                   /0KU184
Oct 23 15:42:34 laptop2 kernel: [10357.754104] EIP: 0060:[<c1037a58>] EFLAGS:
00010096 CPU: 1
Oct 23 15:42:34 laptop2 kernel: [10357.754205] EIP is at
__ticket_spin_lock+0x8/0x30
Oct 23 15:42:34 laptop2 kernel: [10357.754286] EAX: 00000000 EBX: 00000296 ECX:
00000000 EDX: 00000100
Oct 23 15:42:34 laptop2 kernel: [10357.754393] ESI: dfaedfa4 EDI: 00000000 EBP:
dfaedefc ESP: dfaedefc
Oct 23 15:42:34 laptop2 kernel: [10357.754501]  DS: 007b ES: 007b FS: 00d8 GS:
00e0 SS: 0068
Oct 23 15:42:34 laptop2 kernel: [10357.754594] CR0: 8005003b CR2: 00000000 CR3:
01974000 CR4: 000007f0
Oct 23 15:42:34 laptop2 kernel: [10357.754702] DR0: 00000000 DR1: 00000000 DR2:
00000000 DR3: 00000000
Oct 23 15:42:34 laptop2 kernel: [10357.754808] DR6: ffff0ff0 DR7: 00000400
Oct 23 15:42:34 laptop2 kernel: [10357.754875] Process khidpd_05ac0256 (pid:
10165, ti=dfaec000 task=df2b0cb0 task.ti=dfaec000)
Oct 23 15:42:34 laptop2 kernel: [10357.755021] Stack:
Oct 23 15:42:34 laptop2 kernel: [10357.755058]  dfaedf04 c1037af8 dfaedf18
c15c924d dfaedf98 dfaedfa4 00000000 dfaedf2c
Oct 23 15:42:34 laptop2 kernel: [10357.755221]  c10654b3 00000000 cfb0b800
e56d0c00 dfaedfb8 f902ea9b 00000000 00000001
Oct 23 15:42:34 laptop2 kernel: [10357.755383]  df2b0cb0 cfb0b8c0 e56d1a00
e56d0c00 cfb0b890 cfb0b880 df2b0cb0 e56d1a48
Oct 23 15:42:34 laptop2 kernel: [10357.755544] Call Trace:
Oct 23 15:42:34 laptop2 kernel: [10357.755595]  [<c1037af8>]
default_spin_lock_flags+0x8/0x10
Oct 23 15:42:34 laptop2 kernel: [10357.755698]  [<c15c924d>]
_raw_spin_lock_irqsave+0x2d/0x40
Oct 23 15:42:34 laptop2 kernel: [10357.755800]  [<c10654b3>]
finish_wait+0x33/0x70
Oct 23 15:42:34 laptop2 kernel: [10357.755885]  [<f902ea9b>]
hidp_session+0x48b/0x730 [hidp]
Oct 23 15:42:34 laptop2 kernel: [10357.755985]  [<c1075e90>] ?
try_to_wake_up+0x230/0x230
Oct 23 15:42:34 laptop2 kernel: [10357.756079]  [<c1075e90>] ?
try_to_wake_up+0x230/0x230
Oct 23 15:42:34 laptop2 kernel: [10357.756090]  [<c10654f0>] ?
finish_wait+0x70/0x70
Oct 23 15:42:34 laptop2 kernel: [10357.756090]  [<f902e610>] ?
hidp_input_report.isra.4+0x2a0/0x2a0 [hidp]
Oct 23 15:42:34 laptop2 kernel: [10357.756090]  [<c1064dd2>] kthread+0x72/0x80
Oct 23 15:42:34 laptop2 kernel: [10357.756090]  [<c1064d60>] ?
kthread_freezable_should_stop+0x60/0x60
Oct 23 15:42:34 laptop2 kernel: [10357.756090]  [<c15d04fe>]
kernel_thread_helper+0x6/0x10
Oct 23 15:42:34 laptop2 kernel: [10357.756090] Code: b9 fa 78 03 c1 e9 59 ff ff
ff 90 b8 03 79 03 c1 b9 00 79 03 c1 e9 49 ff ff ff 66 90 66 90 66 90 66 90 90
55 ba 00 01 00 00 89 e5 <f0> 66 0f c1 10 0f b6 ce 38 d1 74 0d 8d 74 26 00 f3 90
0f b6 10 
Oct 23 15:42:34 laptop2 kernel: [10357.756090] EIP: [<c1037a58>]
__ticket_spin_lock+0x8/0x30 SS:ESP 0068:dfaedefc
Oct 23 15:42:34 laptop2 kernel: [10357.756090] CR2: 0000000000000000
Oct 23 15:42:34 laptop2 kernel: [10357.756090] ---[ end trace 9a445e0f7d0acd41
]---

The issue seems to be in hidp, which makes sense.

Problem still exists in 3.7.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
