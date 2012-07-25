Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 10:45:16 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 2/2] Bluetooth: Lock l2cap chan in sockopt
Message-ID: <20120725074514.GG11981@aemeltch-MOBL1>
References: <1340978315-4700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342181266-26323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342181266-26323-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724232734.GN20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724232734.GN20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 24, 2012 at 08:27:34PM -0300, Gustavo Padovan wrote:
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-13 15:07:46 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_sock.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> where is the explanation of this patch? I'd like to know why it is needed.

I think it may fix one my crash in l2cap_sock_getsockopt but I am not
completely sure (and do not remember).

[  745.735560] [5395] l2cap_sock_getsockopt: sk d8176800
[  745.746210] [5395] l2cap_sock_getsockopt_old: sk d8176800
[  745.760703] [5395] l2cap_sock_getsockopt: sk d8176800
[  745.767357] [5395] l2cap_sock_getsockopt_old: sk d8176800
[  745.772484] BUG: unable to handle kernel NULL pointer dereference at
(null)
[  745.774157] IP: [<f828dccc>] l2cap_sock_getsockopt+0x2ec/0x3f0
[bluetooth]
[  745.775077] *pde = 00000000 
[  745.776483] Oops: 0000 [#1] SMP 
[  745.776483] Modules linked in: bnep arc4 mac80211_hwsim mac80211
cfg80211 btusb bluetooth binfmt_misc snd_intel8x0 snd_ac97_codec ac97_bus
joydev ppdev snd_pcm snd_seq hid_generic psmouse snd_timer snd_seq_device
parport_pc snd serio_raw i2c_piix4 soundcore snd_page_alloc lp parport
usbhid hid ahci libahci e1000
[  745.776483] 
[  745.776483] Pid: 5395, comm: l2test Not tainted 3.5.0-rc1niko+ #123
innotek GmbH VirtualBox
[  745.776483] EIP: 0060:[<f828dccc>] EFLAGS: 00010246 CPU: 0
[  745.776483] EIP is at l2cap_sock_getsockopt+0x2ec/0x3f0 [bluetooth]
[  745.776483] EAX: 00000000 EBX: fffffff2 ECX: 00000006 EDX: d8176800
[  745.776483] ESI: d8176400 EDI: 00000002 EBP: e3ef3f48 ESP: e3ef3f04
[  745.776483]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  745.776483] CR0: 8005003b CR2: 00000000 CR3: 26a5d000 CR4: 000006d0
[  745.776483] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  745.776483] DR6: ffff0ff0 DR7: 00000400
[  745.776483] Process l2test (pid: 5395, ti=e3ef2000 task=df4c0000
task.ti=e3ef2000)
[  745.776483] Stack:
[  745.776483]  f82a04a0 f82997aa d8176800 00000000 00000006 d8176800
00000006 00000246
[  745.776483]  00000246 c1119cd4 00003f58 00000000 00000006 e3ef3f48
f8297960 ddb66780
[  745.776483]  00000006 e3ef3f6c c14815fb bfc9944e bfc99454 00000000
00000000 0000000f
[  745.776483] Call Trace:
[  745.776483]  [<c1119cd4>] ? might_fault+0x54/0xb0
[  745.776483]  [<c14815fb>] sys_getsockopt+0x5b/0xc0
[  745.776483]  [<c1481d99>] sys_socketcall+0x269/0x2e0
[  745.776483]  [<c12c0948>] ? trace_hardirqs_on_thunk+0xc/0x10
[  745.776483]  [<c15833df>] sysenter_do_call+0x12/0x38
[  745.776483] Code: 00 00 a8 01 0f 84 6c ff ff ff c7 44 24 2a 00 00 00 00
b9 06 00 00 00 66 c7 44 24 2e 00 00 8b 46 04 83 7c 24 18 06 0f 46 4c 24 18
<8b> 10 0f b7 52 14 66 89 54 24 2a 8b 00 0f b7 50 1c 0f b6 40 1e 
[  745.776483] EIP: [<f828dccc>] l2cap_sock_getsockopt+0x2ec/0x3f0
[bluetooth] SS:ESP 0068:e3ef3f04
[  745.776483] CR2: 0000000000000000
[  745.856959] ---[ end trace 7fb1d28495fb8a81 ]---
[  745.956316] [5395] l2cap_sock_release: sock ddb66780, sk d8176800
[  745.964074] [5395] l2cap_sock_shutdown: sock ddb66780, sk d8176800

Best regards 
Andrei Emeltchenko 

