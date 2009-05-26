Return-Path: <cyrus@holtmann.org>
Message-ID: <4A1BA619.4040401@hartkopp.net>
Date: Tue, 26 May 2009 10:19:37 +0200
From: Oliver Hartkopp <oliver@hartkopp.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: possible recursive locking in 2.6.30-rc6
References: <4A1A9D1D.2050301@hartkopp.net> <4A1AF7B0.4020701@hartkopp.net>
In-Reply-To: <4A1AF7B0.4020701@hartkopp.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I did not bisect the problem in detail but as an additional hint:

2.6.29.4 is working properly.

2.6.30-rc3 also had some (different) problems that already might have been fixed:

[  116.146378] PPP generic driver version 2.4.2
[  118.808167] 2 locks held by swapper/0:
[  118.808172]  #0:  (hci_task_lock){++.-.+}, at: [<f87f3cc0>]
hci_rx_task+0x16/0x1f8 [bluetooth]
[  118.808208]  #1:  (&hdev->lock){+.-.+.}, at: [<f87f577c>]
hci_event_packet+0x13c/0x2168 [bluetooth]
[  118.808242] Pid: 0, comm: swapper Not tainted 2.6.30-rc3 #1
[  118.808248] Call Trace:
[  118.808263]  [<c013f72d>] ? __debug_show_held_locks+0x1e/0x20
[  118.808275]  [<c011efb1>] __might_sleep+0xce/0xd3
[  118.808286]  [<c0174987>] __kmalloc+0x83/0x128
[  118.808297]  [<c021e6f0>] ? kvasprintf+0x28/0x45
[  118.808307]  [<c021e6f0>] kvasprintf+0x28/0x45
[  118.808321]  [<c02188e4>] kobject_set_name_vargs+0x21/0x50
[  118.808333]  [<c0295733>] dev_set_name+0x14/0x16
[  118.808355]  [<f87f88a7>] hci_conn_add_sysfs+0x48/0xac [bluetooth]
[  118.808379]  [<f87f57d8>] hci_event_packet+0x198/0x2168 [bluetooth]
[  118.808391]  [<c011e990>] ? default_wake_function+0xb/0xd
[  118.808400]  [<c013fa43>] ? mark_lock+0x1e/0x1f4
[  118.808410]  [<c013fc5c>] ? mark_held_locks+0x43/0x5b
[  118.808423]  [<c03d8337>] ? _spin_unlock_irqrestore+0x36/0x3c
[  118.808433]  [<c033efc6>] ? sock_def_readable+0x64/0x6c
[  118.808459]  [<f87f827b>] ? hci_send_to_sock+0x127/0x130 [bluetooth]
[  118.808472]  [<c03d82b0>] ? _read_unlock+0x1d/0x20
[  118.808494]  [<f87f827b>] ? hci_send_to_sock+0x127/0x130 [bluetooth]
[  118.808517]  [<f87f3d48>] hci_rx_task+0x9e/0x1f8 [bluetooth]
[  118.808529]  [<c01270a6>] tasklet_action+0x6b/0xb2
[  118.808539]  [<c0127422>] __do_softirq+0x93/0x145
[  118.808549]  [<c01274ff>] do_softirq+0x2b/0x43
[  118.808559]  [<c0127603>] irq_exit+0x35/0x63
[  118.808569]  [<c0104439>] do_IRQ+0x6d/0x83
[  118.808579]  [<c01030ae>] common_interrupt+0x2e/0x34
[  118.808590]  [<c013007b>] ? call_usermodehelper_exec+0x6b/0xcd
[  118.808603]  [<c026cda4>] ? acpi_idle_enter_bm+0x23a/0x271
[  118.808614]  [<c032fc2f>] cpuidle_idle_call+0x60/0x91
[  118.808623]  [<c0101d3a>] cpu_idle+0x49/0x63
[  118.808633]  [<c03c5c33>] rest_init+0x53/0x55
[  118.808644]  [<c0562725>] start_kernel+0x261/0x266
[  118.808655]  [<c0562037>] __init_begin+0x37/0x3c
[  118.808669] 2 locks held by swapper/0:
[  118.808673]  #0:  (hci_task_lock){++.-.+}, at: [<f87f3cc0>]
hci_rx_task+0x16/0x1f8 [bluetooth]
[  118.808707]  #1:  (&hdev->lock){+.-.+.}, at: [<f87f577c>]
hci_event_packet+0x13c/0x2168 [bluetooth]
[  118.808736] Modules linked in: ppp_generic slhc i915 drm i2c_algo_bit
binfmt_misc vcan rfcomm l2cap snd_hda_codec_idt arc4 ecb cryptomgr aead
snd_hda_intel snd_hda_codec pcompress crypto_blkcipher snd_pcm_oss crypto_hash
crypto_algapi snd_mixer_oss snd_pcm snd_seq_oss b43 snd_seq_midi snd_rawmidi
pcmcia mac80211 snd_seq_midi_event snd_seq snd_timer snd_seq_device cfg80211
snd yenta_socket rsrc_nonstatic snd_page_alloc btusb pcmcia_core ssb i2c_i801
bluetooth dell_laptop backlight rfkill dcdbas
[  118.808856]
[  118.808863] Pid: 0, comm: swapper Not tainted (2.6.30-rc3 #1) Latitude D830

[  118.808871] EIP: 0060:[<c026cda4>] EFLAGS: 00000202 CPU: 0
[  118.808880] EIP is at acpi_idle_enter_bm+0x23a/0x271
[  118.808887] EAX: c055df88 EBX: 0000290d ECX: a982255e EDX: 00000004
[  118.808894] ESI: 00000000 EDI: f70cbcdc EBP: c055dfac ESP: c055df88
[  118.808901]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[  118.808908] CR0: 8005003b CR2: 08064a50 CR3: 005b0000 CR4: 000006d0
[  118.808916] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  118.808922] DR6: ffff0ff0 DR7: 00000400
[  118.808927] Call Trace:
[  118.808936]  [<c032fc2f>] cpuidle_idle_call+0x60/0x91
[  118.808946]  [<c0101d3a>] cpu_idle+0x49/0x63
[  118.808955]  [<c03c5c33>] rest_init+0x53/0x55
[  118.808965]  [<c0562725>] start_kernel+0x261/0x266
[  118.808975]  [<c0562037>] __init_begin+0x37/0x3c

Oliver Hartkopp wrote:
> Oliver Hartkopp wrote:
>> Hi all,
>>
> 
> This is another trace after having a successful connection and after
> terminating this connection after 40 secs with the latest 2.6.30-rc7.
> 
> When the kernel config is needed please give me a note.
> 
> Tnx,
> Oliver
> 
> 
> [   52.331965] PPP generic driver version 2.4.2
> [   57.917179] PPP BSD Compression module registered
> [   57.964543] PPP Deflate Compression module registered
> [   97.634897]
> [   97.634901] =============================================
> [   97.638773] [ INFO: possible recursive locking detected ]
> [   97.638773] 2.6.30-rc7 #23
> [   97.638773] ---------------------------------------------
> [   97.638773] bluetooth/2505 is trying to acquire lock:
> [   97.669944]  (bluetooth){+.+.+.}, at: [<c0130c14>] flush_work+0x28/0xb0
> [   97.669944]
> [   97.669944] but task is already holding lock:
> [   97.669944]  (bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x149/0x25e
> [   97.669944]
> [   97.669944] other info that might help us debug this:
> [   97.669944] 2 locks held by bluetooth/2505:
> [   97.669944]  #0:  (bluetooth){+.+.+.}, at: [<c0130424>]
> worker_thread+0x149/0x25e
> [   97.669944]  #1:  (&conn->work_del){+.+...}, at: [<c0130424>]
> worker_thread+0x149/0x25e
> [   97.669944]
> [   97.669944] stack backtrace:
> [   97.669944] Pid: 2505, comm: bluetooth Not tainted 2.6.30-rc7 #23
> [   97.669944] Call Trace:
> [   97.669944]  [<c03d5ab1>] ? printk+0xf/0x11
> [   97.669944]  [<c0140d9a>] __lock_acquire+0x7ce/0xb1b
> [   97.669944]  [<c0141177>] lock_acquire+0x90/0xad
> [   97.669944]  [<c0130c14>] ? flush_work+0x28/0xb0
> [   97.669944]  [<c0130c2e>] flush_work+0x42/0xb0
> [   97.669944]  [<c0130c14>] ? flush_work+0x28/0xb0
> [   97.669944]  [<f87f8966>] del_conn+0x1c/0x84 [bluetooth]
> [   97.669944]  [<c0130469>] worker_thread+0x18e/0x25e
> [   97.669944]  [<c0130424>] ? worker_thread+0x149/0x25e
> [   97.669944]  [<f87f894a>] ? del_conn+0x0/0x84 [bluetooth]
> [   97.669944]  [<c0133843>] ? autoremove_wake_function+0x0/0x33
> [   97.669944]  [<c01302db>] ? worker_thread+0x0/0x25e
> [   97.669944]  [<c013355a>] kthread+0x45/0x6b
> [   97.669944]  [<c0133515>] ? kthread+0x0/0x6b
> [   97.669944]  [<c01034a7>] kernel_thread_helper+0x7/0x10
> 
> 
>> i'm sometimes working with BT DUN with a Nokia 6210 Navigator.
>>
>> Last weekend anything must gone wrong, so my mobile was not able to create a
>> ppp link with DUN this morning. After updating the driver and BT-chip firmware
>> of my Dell 830 laptop and several pairing attempts i was able to kick it to
>> work again ... :-]
>>
>> And i needed to move the channel from '5' to '3' in /etc/bluetooth/rfcomm.conf
>> - i assume the Nokia Windows Software re-configured this in the process of
>> re-installing their SW when updating the Windows drivers ... don't know.
>>
>> In the meantime (when the paring or anything else was broken) i discovered
>> this kernel message about a locking issue.
>>
>> Is this a known problem?
>>
>> Regards,
>> Oliver
>>
>> ps. Please CC me as i did not subcribe the list. Tnx
>>
>> =============================================
>> [ INFO: possible recursive locking detected ]
>> 2.6.30-rc6-02911-gbb803cf #16
>> ---------------------------------------------
>> bluetooth/2518 is trying to acquire lock:
>>  (bluetooth){+.+.+.}, at: [<c0130c14>] flush_work+0x28/0xb0
>>
>> but task is already holding lock:
>>  (bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x149/0x25e
>>
>> other info that might help us debug this:
>> 2 locks held by bluetooth/2518:
>>  #0:  (bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x149/0x25e
>>  #1:  (&conn->work_del){+.+...}, at: [<c0130424>] worker_thread+0x149/0x25e
>>
>> stack backtrace:
>> Pid: 2518, comm: bluetooth Not tainted 2.6.30-rc6-02911-gbb803cf #16
>> Call Trace:
>>  [<c03d64d9>] ? printk+0xf/0x11
>>  [<c0140d96>] __lock_acquire+0x7ce/0xb1b
>>  [<c0141173>] lock_acquire+0x90/0xad
>>  [<c0130c14>] ? flush_work+0x28/0xb0
>>  [<c0130c2e>] flush_work+0x42/0xb0
>>  [<c0130c14>] ? flush_work+0x28/0xb0
>>  [<f8b84966>] del_conn+0x1c/0x84 [bluetooth]
>>  [<c0130469>] worker_thread+0x18e/0x25e
>>  [<c0130424>] ? worker_thread+0x149/0x25e
>>  [<f8b8494a>] ? del_conn+0x0/0x84 [bluetooth]
>>  [<c0133843>] ? autoremove_wake_function+0x0/0x33
>>  [<c01302db>] ? worker_thread+0x0/0x25e
>>  [<c013355a>] kthread+0x45/0x6b
>>  [<c0133515>] ? kthread+0x0/0x6b
>>  [<c01034a7>] kernel_thread_helper+0x7/0x10
>>
> 
> 

