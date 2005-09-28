Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <433ADB96.5080100@flander.com>
From: Simo Salminen <simo.salminen@flander.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] problems with high-speed rfcomm transfers
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 28 Sep 2005 21:06:14 +0300

Hello,

Has anyone else had problems with high-speed rfcomm transfers with 
BlueZ?

I am using simple rfcomm test setup. The client dumps data to rfcomm 
socket, and the server receives the data. Sometimes the data 
transfer just freezes, without any error messages. The client has 
sent the data, but it does not arrive at the server program.

Tested with the bluez version that comes with 2.6.12 kernel, using 
usb bt dongle.

Anyway, I understand that more detailed error description is surely 
needed, but I just wanted to know if anyone else has had these 
problems.


With amd64 machine it sometimes crashes with this error message:

Unable to handle kernel NULL pointer dereference at 0000000000000050 
RIP:
<ffffffff8801bdb9>{:rfcomm:rfcomm_tty_chars_in_buffer+9}
PGD 2d9d4067 PUD 3cb13067 PMD 0
Oops: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in: wacom snd_seq_midi snd_emu10k1_synth 
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss 
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_mpu401 
snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem 
snd_hwdep snd rfcomm bnep l2cap hci_usb realtime
Pid: 10354, comm: rfcomm Not tainted 2.6.13-gentoo-r2
RIP: 0010:[<ffffffff8801bdb9>] 
<ffffffff8801bdb9>{:rfcomm:rfcomm_tty_chars_in_buffer+9}
RSP: 0000:ffff81002d89fe90  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81003b32e000 RCX: 0000000000000000
RDX: 0000000000000051 RSI: ffff81003b32e9f8 RDI: ffff81003b32e000
RBP: 0000000000000000 R08: ffff81002d89e000 R09: ffff81003e24bb40
R10: 00000000ffffffff R11: 0000000000000103 R12: 0000000000000041
R13: 0000000000000000 R14: ffff8100316d17c0 R15: 0000000000000001
FS:  00000000007b2a00(0000) GS:ffffffff80794800(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000050 CR3: 0000000029430000 CR4: 00000000000006e0
Process rfcomm (pid: 10354, threadinfo ffff81002d89e000, task 
ffff81003e045860)
Stack: ffffffff80304c56 ffff8100316d17c0 ffff81003b32e000 
ffff81003b32e018
        0000000000000000 0000000000000000 ffffffff802ff0e8 
0000000000000145
        ffff8100316d17c0 ffff81003d755ccc
Call Trace:<ffffffff80304c56>{normal_poll+326} 
<ffffffff802ff0e8>{tty_poll+104}
        <ffffffff80195c99>{sys_poll+489} 
<ffffffff80195130>{__pollwait+0}
        <ffffffff8010dd36>{system_call+126}

Code: 48 8b 50 50 48 8d 42 18 48 39 42 18 74 06 8b 8a 98 00 00 00
RIP <ffffffff8801bdb9>{:rfcomm:rfcomm_tty_chars_in_buffer+9} RSP 
<ffff81002d89fe90>
CR2: 0000000000000050
  <1>Unable to handle kernel paging request at 00000001827b4a08 RIP:
<ffffffff80130880>{try_to_wake_up+64}
PGD 3de20067 PUD 0
Oops: 0000 [2] PREEMPT SMP
CPU 0
Modules linked in: wacom snd_seq_midi snd_emu10k1_synth 
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss 
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_mpu401 
snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem 
snd_hwdep snd rfcomm bnep l2cap hci_usb realtime
Pid: 4442, comm: krfcommd Not tainted 2.6.13-gentoo-r2
RIP: 0010:[<ffffffff80130880>] <ffffffff80130880>{try_to_wake_up+64}
RSP: 0000:ffff81003dbc9bb8  EFLAGS: 00010016
RAX: 0000000202020200 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff81003e045860
RBP: ffff81003dbc9c28 R08: 000000000142f74b R09: 0000000000000000
R10: ffff810033b2700c R11: ffff81003f5a1140 R12: ffffffff807d3600
R13: 0000000000000001 R14: ffff81003e045860 R15: 0000000000000000
FS:  0000000000518ae0(0000) GS:ffffffff80794800(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000001827b4a08 CR3: 000000003e2ea000 CR4: 00000000000006e0
Process krfcommd (pid: 4442, threadinfo ffff81003dbc8000, task 
ffff81003ea87050)
Stack: 0000000000000001 ffff810001e0b560 0000000039147a80 
0000000000000000
        ffff810001e0b560 0000000000000001 000000003dbc9d48 
0000000000000000
        0000000000000096 0000000000000000
Call Trace:<ffffffff801325a0>{__wake_up_common+64} 
<ffffffff80132613>{__wake_up+67}
        <ffffffff80303bc0>{n_tty_receive_buf+4256} 
<ffffffff804ed662>{_spin_unlock_irq+18}
        <ffffffff804ebd72>{thread_return+191} 
<ffffffff80455a15>{kernel_sendmsg+53}
        <ffffffff880177ab>{:rfcomm:rfcomm_send_frame+59} 
<ffffffff8801b6a7>{:rfcomm:rfcomm_dev_data_ready+199}
        <ffffffff88018ae6>{:rfcomm:rfcomm_run+2294} 
<ffffffff80130302>{activate_task+50}
        <ffffffff801326b7>{__wake_up_sync+87} 
<ffffffff804ed223>{_spin_unlock_irqrestore+19}
        <ffffffff801310bb>{sched_exit+235} 
<ffffffff804ed0f1>{_spin_unlock+17}
        <ffffffff8014d650>{keventd_create_kthread+0} 
<ffffffff8013a9f6>{do_exit+3094}
        <ffffffff804ed662>{_spin_unlock_irq+18} 
<ffffffff80159e70>{do_stop+0}
        <ffffffff8010e916>{child_rip+8} 
<ffffffff880181f0>{:rfcomm:rfcomm_run+0}
        <ffffffff8010e90e>{child_rip+0}

Code: 48 8b 98 08 48 79 80 4c 01 e3 48 89 df e8 be c7 3b 00 49 8b
RIP <ffffffff80130880>{try_to_wake_up+64} RSP <ffff81003dbc9bb8>
CR2: 00000001827b4a08
  <6>note: krfcommd[4442] exited with preempt_count 2
usb 2-10: USB disconnect, address 3



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
