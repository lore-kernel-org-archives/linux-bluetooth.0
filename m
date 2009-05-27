Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4A1BA619.4040401@hartkopp.net>
References: <4A1A9D1D.2050301@hartkopp.net> <4A1AF7B0.4020701@hartkopp.net>
	 <4A1BA619.4040401@hartkopp.net>
Date: Wed, 27 May 2009 09:13:45 +0800
Message-ID: <a8e1da0905261813i3577af33g101336259a51c03c@mail.gmail.com>
Subject: Re: possible recursive locking in 2.6.30-rc6
From: Dave Young <hidave.darkstar@gmail.com>
To: Oliver Hartkopp <oliver@hartkopp.net>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/mixed; boundary=000e0cd28d521359ef046ada8e61
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd28d521359ef046ada8e61
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2009 at 4:19 PM, Oliver Hartkopp <oliver@hartkopp.net> wrot=
e:
> I did not bisect the problem in detail but as an additional hint:
>
> 2.6.29.4 is working properly.
>
> 2.6.30-rc3 also had some (different) problems that already might have bee=
n fixed:
>
> [ =C2=A0116.146378] PPP generic driver version 2.4.2
> [ =C2=A0118.808167] 2 locks held by swapper/0:
> [ =C2=A0118.808172] =C2=A0#0: =C2=A0(hci_task_lock){++.-.+}, at: [<f87f3c=
c0>]
> hci_rx_task+0x16/0x1f8 [bluetooth]
> [ =C2=A0118.808208] =C2=A0#1: =C2=A0(&hdev->lock){+.-.+.}, at: [<f87f577c=
>]
> hci_event_packet+0x13c/0x2168 [bluetooth]
> [ =C2=A0118.808242] Pid: 0, comm: swapper Not tainted 2.6.30-rc3 #1
> [ =C2=A0118.808248] Call Trace:
> [ =C2=A0118.808263] =C2=A0[<c013f72d>] ? __debug_show_held_locks+0x1e/0x2=
0
> [ =C2=A0118.808275] =C2=A0[<c011efb1>] __might_sleep+0xce/0xd3
> [ =C2=A0118.808286] =C2=A0[<c0174987>] __kmalloc+0x83/0x128
> [ =C2=A0118.808297] =C2=A0[<c021e6f0>] ? kvasprintf+0x28/0x45
> [ =C2=A0118.808307] =C2=A0[<c021e6f0>] kvasprintf+0x28/0x45
> [ =C2=A0118.808321] =C2=A0[<c02188e4>] kobject_set_name_vargs+0x21/0x50
> [ =C2=A0118.808333] =C2=A0[<c0295733>] dev_set_name+0x14/0x16
> [ =C2=A0118.808355] =C2=A0[<f87f88a7>] hci_conn_add_sysfs+0x48/0xac [blue=
tooth]
> [ =C2=A0118.808379] =C2=A0[<f87f57d8>] hci_event_packet+0x198/0x2168 [blu=
etooth]
> [ =C2=A0118.808391] =C2=A0[<c011e990>] ? default_wake_function+0xb/0xd
> [ =C2=A0118.808400] =C2=A0[<c013fa43>] ? mark_lock+0x1e/0x1f4
> [ =C2=A0118.808410] =C2=A0[<c013fc5c>] ? mark_held_locks+0x43/0x5b
> [ =C2=A0118.808423] =C2=A0[<c03d8337>] ? _spin_unlock_irqrestore+0x36/0x3=
c
> [ =C2=A0118.808433] =C2=A0[<c033efc6>] ? sock_def_readable+0x64/0x6c
> [ =C2=A0118.808459] =C2=A0[<f87f827b>] ? hci_send_to_sock+0x127/0x130 [bl=
uetooth]
> [ =C2=A0118.808472] =C2=A0[<c03d82b0>] ? _read_unlock+0x1d/0x20
> [ =C2=A0118.808494] =C2=A0[<f87f827b>] ? hci_send_to_sock+0x127/0x130 [bl=
uetooth]
> [ =C2=A0118.808517] =C2=A0[<f87f3d48>] hci_rx_task+0x9e/0x1f8 [bluetooth]
> [ =C2=A0118.808529] =C2=A0[<c01270a6>] tasklet_action+0x6b/0xb2
> [ =C2=A0118.808539] =C2=A0[<c0127422>] __do_softirq+0x93/0x145
> [ =C2=A0118.808549] =C2=A0[<c01274ff>] do_softirq+0x2b/0x43
> [ =C2=A0118.808559] =C2=A0[<c0127603>] irq_exit+0x35/0x63
> [ =C2=A0118.808569] =C2=A0[<c0104439>] do_IRQ+0x6d/0x83
> [ =C2=A0118.808579] =C2=A0[<c01030ae>] common_interrupt+0x2e/0x34
> [ =C2=A0118.808590] =C2=A0[<c013007b>] ? call_usermodehelper_exec+0x6b/0x=
cd
> [ =C2=A0118.808603] =C2=A0[<c026cda4>] ? acpi_idle_enter_bm+0x23a/0x271
> [ =C2=A0118.808614] =C2=A0[<c032fc2f>] cpuidle_idle_call+0x60/0x91
> [ =C2=A0118.808623] =C2=A0[<c0101d3a>] cpu_idle+0x49/0x63
> [ =C2=A0118.808633] =C2=A0[<c03c5c33>] rest_init+0x53/0x55
> [ =C2=A0118.808644] =C2=A0[<c0562725>] start_kernel+0x261/0x266
> [ =C2=A0118.808655] =C2=A0[<c0562037>] __init_begin+0x37/0x3c
> [ =C2=A0118.808669] 2 locks held by swapper/0:
> [ =C2=A0118.808673] =C2=A0#0: =C2=A0(hci_task_lock){++.-.+}, at: [<f87f3c=
c0>]
> hci_rx_task+0x16/0x1f8 [bluetooth]
> [ =C2=A0118.808707] =C2=A0#1: =C2=A0(&hdev->lock){+.-.+.}, at: [<f87f577c=
>]
> hci_event_packet+0x13c/0x2168 [bluetooth]
> [ =C2=A0118.808736] Modules linked in: ppp_generic slhc i915 drm i2c_algo=
_bit
> binfmt_misc vcan rfcomm l2cap snd_hda_codec_idt arc4 ecb cryptomgr aead
> snd_hda_intel snd_hda_codec pcompress crypto_blkcipher snd_pcm_oss crypto=
_hash
> crypto_algapi snd_mixer_oss snd_pcm snd_seq_oss b43 snd_seq_midi snd_rawm=
idi
> pcmcia mac80211 snd_seq_midi_event snd_seq snd_timer snd_seq_device cfg80=
211
> snd yenta_socket rsrc_nonstatic snd_page_alloc btusb pcmcia_core ssb i2c_=
i801
> bluetooth dell_laptop backlight rfkill dcdbas
> [ =C2=A0118.808856]
> [ =C2=A0118.808863] Pid: 0, comm: swapper Not tainted (2.6.30-rc3 #1) Lat=
itude D830
>
> [ =C2=A0118.808871] EIP: 0060:[<c026cda4>] EFLAGS: 00000202 CPU: 0
> [ =C2=A0118.808880] EIP is at acpi_idle_enter_bm+0x23a/0x271
> [ =C2=A0118.808887] EAX: c055df88 EBX: 0000290d ECX: a982255e EDX: 000000=
04
> [ =C2=A0118.808894] ESI: 00000000 EDI: f70cbcdc EBP: c055dfac ESP: c055df=
88
> [ =C2=A0118.808901] =C2=A0DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [ =C2=A0118.808908] CR0: 8005003b CR2: 08064a50 CR3: 005b0000 CR4: 000006=
d0
> [ =C2=A0118.808916] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 000000=
00
> [ =C2=A0118.808922] DR6: ffff0ff0 DR7: 00000400
> [ =C2=A0118.808927] Call Trace:
> [ =C2=A0118.808936] =C2=A0[<c032fc2f>] cpuidle_idle_call+0x60/0x91
> [ =C2=A0118.808946] =C2=A0[<c0101d3a>] cpu_idle+0x49/0x63
> [ =C2=A0118.808955] =C2=A0[<c03c5c33>] rest_init+0x53/0x55
> [ =C2=A0118.808965] =C2=A0[<c0562725>] start_kernel+0x261/0x266
> [ =C2=A0118.808975] =C2=A0[<c0562037>] __init_begin+0x37/0x3c
>
> Oliver Hartkopp wrote:
>> Oliver Hartkopp wrote:
>>> Hi all,
>>>
>>
>> This is another trace after having a successful connection and after
>> terminating this connection after 40 secs with the latest 2.6.30-rc7.
>>
>> When the kernel config is needed please give me a note.
>>
>> Tnx,
>> Oliver
>>
>>
>> [ =C2=A0 52.331965] PPP generic driver version 2.4.2
>> [ =C2=A0 57.917179] PPP BSD Compression module registered
>> [ =C2=A0 57.964543] PPP Deflate Compression module registered
>> [ =C2=A0 97.634897]
>> [ =C2=A0 97.634901] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> [ =C2=A0 97.638773] [ INFO: possible recursive locking detected ]
>> [ =C2=A0 97.638773] 2.6.30-rc7 #23
>> [ =C2=A0 97.638773] ---------------------------------------------
>> [ =C2=A0 97.638773] bluetooth/2505 is trying to acquire lock:
>> [ =C2=A0 97.669944] =C2=A0(bluetooth){+.+.+.}, at: [<c0130c14>] flush_wo=
rk+0x28/0xb0
>> [ =C2=A0 97.669944]
>> [ =C2=A0 97.669944] but task is already holding lock:
>> [ =C2=A0 97.669944] =C2=A0(bluetooth){+.+.+.}, at: [<c0130424>] worker_t=
hread+0x149/0x25e
>> [ =C2=A0 97.669944]
>> [ =C2=A0 97.669944] other info that might help us debug this:
>> [ =C2=A0 97.669944] 2 locks held by bluetooth/2505:
>> [ =C2=A0 97.669944] =C2=A0#0: =C2=A0(bluetooth){+.+.+.}, at: [<c0130424>=
]
>> worker_thread+0x149/0x25e
>> [ =C2=A0 97.669944] =C2=A0#1: =C2=A0(&conn->work_del){+.+...}, at: [<c01=
30424>]
>> worker_thread+0x149/0x25e
>> [ =C2=A0 97.669944]
>> [ =C2=A0 97.669944] stack backtrace:
>> [ =C2=A0 97.669944] Pid: 2505, comm: bluetooth Not tainted 2.6.30-rc7 #2=
3
>> [ =C2=A0 97.669944] Call Trace:
>> [ =C2=A0 97.669944] =C2=A0[<c03d5ab1>] ? printk+0xf/0x11
>> [ =C2=A0 97.669944] =C2=A0[<c0140d9a>] __lock_acquire+0x7ce/0xb1b
>> [ =C2=A0 97.669944] =C2=A0[<c0141177>] lock_acquire+0x90/0xad
>> [ =C2=A0 97.669944] =C2=A0[<c0130c14>] ? flush_work+0x28/0xb0
>> [ =C2=A0 97.669944] =C2=A0[<c0130c2e>] flush_work+0x42/0xb0
>> [ =C2=A0 97.669944] =C2=A0[<c0130c14>] ? flush_work+0x28/0xb0
>> [ =C2=A0 97.669944] =C2=A0[<f87f8966>] del_conn+0x1c/0x84 [bluetooth]
>> [ =C2=A0 97.669944] =C2=A0[<c0130469>] worker_thread+0x18e/0x25e
>> [ =C2=A0 97.669944] =C2=A0[<c0130424>] ? worker_thread+0x149/0x25e
>> [ =C2=A0 97.669944] =C2=A0[<f87f894a>] ? del_conn+0x0/0x84 [bluetooth]
>> [ =C2=A0 97.669944] =C2=A0[<c0133843>] ? autoremove_wake_function+0x0/0x=
33
>> [ =C2=A0 97.669944] =C2=A0[<c01302db>] ? worker_thread+0x0/0x25e
>> [ =C2=A0 97.669944] =C2=A0[<c013355a>] kthread+0x45/0x6b
>> [ =C2=A0 97.669944] =C2=A0[<c0133515>] ? kthread+0x0/0x6b
>> [ =C2=A0 97.669944] =C2=A0[<c01034a7>] kernel_thread_helper+0x7/0x10
>>
>>
>>> i'm sometimes working with BT DUN with a Nokia 6210 Navigator.
>>>
>>> Last weekend anything must gone wrong, so my mobile was not able to cre=
ate a
>>> ppp link with DUN this morning. After updating the driver and BT-chip f=
irmware
>>> of my Dell 830 laptop and several pairing attempts i was able to kick i=
t to
>>> work again ... :-]
>>>
>>> And i needed to move the channel from '5' to '3' in /etc/bluetooth/rfco=
mm.conf
>>> - i assume the Nokia Windows Software re-configured this in the process=
 of
>>> re-installing their SW when updating the Windows drivers ... don't know=
.
>>>
>>> In the meantime (when the paring or anything else was broken) i discove=
red
>>> this kernel message about a locking issue.
>>>
>>> Is this a known problem?
>>>
>>> Regards,
>>> Oliver
>>>
>>> ps. Please CC me as i did not subcribe the list. Tnx
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [ INFO: possible recursive locking detected ]
>>> 2.6.30-rc6-02911-gbb803cf #16
>>> ---------------------------------------------
>>> bluetooth/2518 is trying to acquire lock:
>>> =C2=A0(bluetooth){+.+.+.}, at: [<c0130c14>] flush_work+0x28/0xb0
>>>
>>> but task is already holding lock:
>>> =C2=A0(bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x149/0x25e
>>>
>>> other info that might help us debug this:
>>> 2 locks held by bluetooth/2518:
>>> =C2=A0#0: =C2=A0(bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x1=
49/0x25e
>>> =C2=A0#1: =C2=A0(&conn->work_del){+.+...}, at: [<c0130424>] worker_thre=
ad+0x149/0x25e
>>>
>>> stack backtrace:
>>> Pid: 2518, comm: bluetooth Not tainted 2.6.30-rc6-02911-gbb803cf #16
>>> Call Trace:
>>> =C2=A0[<c03d64d9>] ? printk+0xf/0x11
>>> =C2=A0[<c0140d96>] __lock_acquire+0x7ce/0xb1b
>>> =C2=A0[<c0141173>] lock_acquire+0x90/0xad
>>> =C2=A0[<c0130c14>] ? flush_work+0x28/0xb0
>>> =C2=A0[<c0130c2e>] flush_work+0x42/0xb0
>>> =C2=A0[<c0130c14>] ? flush_work+0x28/0xb0
>>> =C2=A0[<f8b84966>] del_conn+0x1c/0x84 [bluetooth]
>>> =C2=A0[<c0130469>] worker_thread+0x18e/0x25e
>>> =C2=A0[<c0130424>] ? worker_thread+0x149/0x25e
>>> =C2=A0[<f8b8494a>] ? del_conn+0x0/0x84 [bluetooth]
>>> =C2=A0[<c0133843>] ? autoremove_wake_function+0x0/0x33
>>> =C2=A0[<c01302db>] ? worker_thread+0x0/0x25e
>>> =C2=A0[<c013355a>] kthread+0x45/0x6b
>>> =C2=A0[<c0133515>] ? kthread+0x0/0x6b
>>> =C2=A0[<c01034a7>] kernel_thread_helper+0x7/0x10
>>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

Hi oliver

Could you try the attached patch and report your result?

--=20
Regards
dave

--000e0cd28d521359ef046ada8e61
Content-Type: application/octet-stream;
	name="bluetooth_flush_work_remove.patch"
Content-Disposition: attachment;
	filename="bluetooth_flush_work_remove.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fv7ceip90

TG9ja2RlcCB3YXJuaW5nIHJlcG9ydGVkIGJ5IE9saXZlciBIYXJ0a29wcCA8b2xpdmVyQGhhcnRr
b3BwLm5ldD4gCgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
WyBJTkZPOiBwb3NzaWJsZSByZWN1cnNpdmUgbG9ja2luZyBkZXRlY3RlZCBdCjIuNi4zMC1yYzYt
MDI5MTEtZ2JiODAzY2YgIzE2Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpibHVldG9vdGgvMjUxOCBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2NrOgogKGJsdWV0
b290aCl7Ky4rLisufSwgYXQ6IFs8YzAxMzBjMTQ+XSBmbHVzaF93b3JrKzB4MjgvMHhiMAoKYnV0
IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxvY2s6CiAoYmx1ZXRvb3RoKXsrLisuKy59LCBhdDog
WzxjMDEzMDQyND5dIHdvcmtlcl90aHJlYWQrMHgxNDkvMHgyNWUKCm90aGVyIGluZm8gdGhhdCBt
aWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6CjIgbG9ja3MgaGVsZCBieSBibHVldG9vdGgvMjUxODoK
ICMwOiAgKGJsdWV0b290aCl7Ky4rLisufSwgYXQ6IFs8YzAxMzA0MjQ+XSB3b3JrZXJfdGhyZWFk
KzB4MTQ5LzB4MjVlCiAjMTogICgmY29ubi0+d29ya19kZWwpeysuKy4uLn0sIGF0OiBbPGMwMTMw
NDI0Pl0gd29ya2VyX3RocmVhZCsweDE0OS8weDI1ZQoKc3RhY2sgYmFja3RyYWNlOgpQaWQ6IDI1
MTgsIGNvbW06IGJsdWV0b290aCBOb3QgdGFpbnRlZCAyLjYuMzAtcmM2LTAyOTExLWdiYjgwM2Nm
ICMxNgpDYWxsIFRyYWNlOgogWzxjMDNkNjRkOT5dID8gcHJpbnRrKzB4Zi8weDExCiBbPGMwMTQw
ZDk2Pl0gX19sb2NrX2FjcXVpcmUrMHg3Y2UvMHhiMWIKIFs8YzAxNDExNzM+XSBsb2NrX2FjcXVp
cmUrMHg5MC8weGFkCiBbPGMwMTMwYzE0Pl0gPyBmbHVzaF93b3JrKzB4MjgvMHhiMAogWzxjMDEz
MGMyZT5dIGZsdXNoX3dvcmsrMHg0Mi8weGIwCiBbPGMwMTMwYzE0Pl0gPyBmbHVzaF93b3JrKzB4
MjgvMHhiMAogWzxmOGI4NDk2Nj5dIGRlbF9jb25uKzB4MWMvMHg4NCBbYmx1ZXRvb3RoXQogWzxj
MDEzMDQ2OT5dIHdvcmtlcl90aHJlYWQrMHgxOGUvMHgyNWUKIFs8YzAxMzA0MjQ+XSA/IHdvcmtl
cl90aHJlYWQrMHgxNDkvMHgyNWUKIFs8ZjhiODQ5NGE+XSA/IGRlbF9jb25uKzB4MC8weDg0IFti
bHVldG9vdGhdCiBbPGMwMTMzODQzPl0gPyBhdXRvcmVtb3ZlX3dha2VfZnVuY3Rpb24rMHgwLzB4
MzMKIFs8YzAxMzAyZGI+XSA/IHdvcmtlcl90aHJlYWQrMHgwLzB4MjVlCiBbPGMwMTMzNTVhPl0g
a3RocmVhZCsweDQ1LzB4NmIKIFs8YzAxMzM1MTU+XSA/IGt0aHJlYWQrMHgwLzB4NmIKIFs8YzAx
MDM0YTc+XSBrZXJuZWxfdGhyZWFkX2hlbHBlcisweDcvMHgxMAoKYmx1ZXRvb3RoZCBpcyBhIHNp
bmdsZSB0aHJlYWQgd29ya3F1ZXVlLCBzbyB3b3JrIGZ1bmN0aW9ucyB3aWxsIGV4ZWN1dGUgaW4g
b3JkZXIuCgpKdXN0IHJlbW92ZSB0aGUgZmx1c2hfd29yayBoYW5kbGluZyBpbiBoY2lfc3lzZnMu
YwoKU2lnbmVkLW9mZi1ieTogRGF2ZSBZb3VuZyA8aGlkYXZlLmRhcmtzdGFyQGdtYWlsLmNvbT4K
UmVwb3J0ZWQtYnk6IE9saXZlciBIYXJ0a29wcCA8b2xpdmVyQGhhcnRrb3BwLm5ldD4KLS0tCm5l
dC9ibHVldG9vdGgvaGNpX3N5c2ZzLmMgfCAgICA2IC0tLS0tLQoxIGZpbGUgY2hhbmdlZCwgNiBk
ZWxldGlvbnMoLSkKCi0tLSBsaW51eC0yLjYub3JpZy9uZXQvYmx1ZXRvb3RoL2hjaV9zeXNmcy5j
CTIwMDktMDUtMTYgMTc6MTg6MTAuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYvbmV0L2Js
dWV0b290aC9oY2lfc3lzZnMuYwkyMDA5LTA1LTI3IDA4OjQ0OjM1LjAwMDAwMDAwMCArMDgwMApA
QCAtOTAsOSArOTAsNiBAQAogCXN0cnVjdCBoY2lfY29ubiAqY29ubiA9IGNvbnRhaW5lcl9vZih3
b3JrLCBzdHJ1Y3QgaGNpX2Nvbm4sIHdvcmtfYWRkKTsKIAlzdHJ1Y3QgaGNpX2RldiAqaGRldiA9
IGNvbm4tPmhkZXY7CiAKLQkvKiBlbnN1cmUgcHJldmlvdXMgZGVsIGlzIGNvbXBsZXRlICovCi0J
Zmx1c2hfd29yaygmY29ubi0+d29ya19kZWwpOwotCiAJZGV2X3NldF9uYW1lKCZjb25uLT5kZXYs
ICIlczolZCIsIGhkZXYtPm5hbWUsIGNvbm4tPmhhbmRsZSk7CiAKIAlpZiAoZGV2aWNlX2FkZCgm
Y29ubi0+ZGV2KSA8IDApIHsKQEAgLTExOCw5ICsxMTUsNiBAQAogCXN0cnVjdCBoY2lfY29ubiAq
Y29ubiA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgaGNpX2Nvbm4sIHdvcmtfZGVsKTsKIAlz
dHJ1Y3QgaGNpX2RldiAqaGRldiA9IGNvbm4tPmhkZXY7CiAKLQkvKiBlbnN1cmUgcHJldmlvdXMg
YWRkIGlzIGNvbXBsZXRlICovCi0JZmx1c2hfd29yaygmY29ubi0+d29ya19hZGQpOwotCiAJaWYg
KCFkZXZpY2VfaXNfcmVnaXN0ZXJlZCgmY29ubi0+ZGV2KSkKIAkJcmV0dXJuOwogCg==
--000e0cd28d521359ef046ada8e61--
