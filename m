Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F914BFA5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837771; cv=none; b=MlfyvtyAsqugrcY4UpvnsNtgEV/u9NQjl5WGSxfiybTDI+bRE665eYfetzKiCMi9o94na3qIckm7RkmmaxkJa134cXq6Jf6stUlOi0kIf0ZdLpSc68D2iOgYtV/Uix9/Y0Y7Ip5rnfxMoeOc5A0UXbpHG7Wj9XfK+HjcEVwBA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837771; c=relaxed/simple;
	bh=nveyGyJkI4LXPsUzuNqkuzGZkb63BLYNyvg9wYMeIV0=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=O99wikUY6Lf0ebAfRn3tmSjAWEATwz+NZ3H2XGHUIa7/64V8JNTD9FVX4Hy71j6dyTgX3B3SU27sNjsNM4ZwHd0kI6wWtFsVvlD1bSn+lUx3TGzRo27XcFTnwosmaGxLBhXo6N4k3QNi6+NuY7FvoThGAg4MgxGf2Th1LrfoqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ryanjgray.com; spf=pass smtp.mailfrom=ryanjgray.com; dkim=pass (2048-bit key) header.d=ryanjgray.com header.i=@ryanjgray.com header.b=nc1XmJPg; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ryanjgray.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryanjgray.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryanjgray.com header.i=@ryanjgray.com header.b="nc1XmJPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryanjgray.com;
	s=protonmail2; t=1712837757; x=1713096957;
	bh=nveyGyJkI4LXPsUzuNqkuzGZkb63BLYNyvg9wYMeIV0=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nc1XmJPg8Q9uVQOY5bKzKTk6eBZkkheRQgUctesyvmFmkTGw29iGiqzQuE6eM1s7x
	 QZ3zlPnkidZc1L740QBq/PNo7+zFscKaRZQogH/tHf48KNlKkucxGmmYnp7DHfAzvd
	 rnGIpMK4qEwTYHq70j8swIMSt6mWyCZAq6tH0MzvMcAyK1DfbIKBVXfluKnLpt9xTg
	 3J8tqrDQLduEDxr90tSstWnSfG9HEoPKvceMjI0d0VLXTPkCfglp+GLJSO8oufzK1G
	 a5GukPcVofcTG3T1tKOzvIWlzM2Bunf/ZvRNUq9m5hhDwo1y70BudvN7oWp0TleIPg
	 9lOqzJjWftbzg==
Date: Thu, 11 Apr 2024 12:15:52 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: "Ryan J. Gray" <ryan@ryanjgray.com>
Subject: Bluetooth: hci0: SCO packet for unknown connection handle 257 (Kernel panic)
Message-ID: <7xyuVSlhQ9uUJem05dCPPOMCNoKxbFwx0HbIy3BBrWNphFSb3CnYnMSANrv25-Y_l7xDOktoulkpi0yQB2N_o8tYwI8dfJEIB548q1-6Mio=@ryanjgray.com>
Feedback-ID: 43206630:user:proton
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------91f4eb2d3a6ff3f676c4e57240defea2d2f2c4c2df2ec6555f6843e84a456cc7"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------91f4eb2d3a6ff3f676c4e57240defea2d2f2c4c2df2ec6555f6843e84a456cc7
Content-Type: multipart/mixed;boundary=---------------------ff55c3c83e0ad154ac1e12b0bb565750

-----------------------ff55c3c83e0ad154ac1e12b0bb565750
Content-Type: multipart/alternative;boundary=---------------------7430c4a7e042aa53ed677790bb261949

-----------------------7430c4a7e042aa53ed677790bb261949
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hey all,

I hope I've got the right list for this.

I ran into a bizarre problem a couple of days ago, where my laptop kernel =
panicked after I was in a voice call on Signal Desktop, using my Sony WH-1=
000XM5 Bluetooth headphones.

I'm using EndeavourOS, my kernel is:
Linux kvasir 6.8.2-arch2-1 #1 SMP PREEMPT_DYNAMIC Thu, 28 Mar 2024 17:06:3=
5 +0000 x86_64 GNU/Linux


My laptop:
Razer Blade 17 (2022) - has Intel AX211 WiFi/Bluetooth.


hci0 details:
[ =C2=A0 15.915176] Bluetooth: hci0: Device revision is 0[ =C2=A0 15.91517=
9] Bluetooth: hci0: Secure boot is enabled
[ =C2=A0 15.915180] Bluetooth: hci0: OTP lock is enabled
[ =C2=A0 15.915181] Bluetooth: hci0: API lock is enabled
[ =C2=A0 15.915181] Bluetooth: hci0: Debug lock is disabled
[ =C2=A0 15.915182] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ =C2=A0 15.915183] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtyp=
e 1 build 38
[ =C2=A0 15.915242] Bluetooth: hci0: DSM reset method type: 0x00
[ =C2=A0 15.918180] Bluetooth: hci0: Found device firmware: intel/ibt-0040=
-0041.sfi
[ =C2=A0 15.918197] Bluetooth: hci0: Boot Address: 0x100800
[ =C2=A0 15.918199] Bluetooth: hci0: Firmware Version: 60-48.23
[ =C2=A0 17.366978] Bluetooth: hci0: Waiting for firmware download to comp=
lete
[ =C2=A0 17.367360] Bluetooth: hci0: Firmware loaded in 1415209 usecs
[ =C2=A0 17.367554] Bluetooth: hci0: Waiting for device to boot
[ =C2=A0 17.383254] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[ =C2=A0 17.383319] Bluetooth: hci0: Device booted in 15524 usecs
[ =C2=A0 17.383983] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt=
-0040-0041.ddc
[ =C2=A0 17.386302] Bluetooth: hci0: Applying Intel DDC parameters complet=
ed
[ =C2=A0 17.389362] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype =
1 build 75324
[ =C2=A0 17.389381] Bluetooth: hci0: Firmware SHA1: 0x23bac558



Signal kept jumping between the hands-free mode of my headphones and the H=
Q audio mode pretty rapidly, so I switched off my headphones to continue t=
he call on mobile, as soon as I got a message/call in Signal I presume it =
tried to play the notification sound through my headphones (which weren't =
connected anymore), and the kernel panic happened.
It seems like Signal tried to use an old handle to my headphones, and that=
 caused the bluetooth kernel driver to crash, judging from the timing of t=
he journalctl messages?
It sounds to me like a use-after-free bug, but I don't really know enough =
about kernel driver development to try and narrow it down.



Here is a snippet of journalctl from the moment it kernel panicked:
Apr 09 16:28:04 kvasir kernel: Bluetooth: hci0: SCO packet for unknown con=
nection handle 257Apr 09 16:28:04 kvasir kernel: BUG: unable to handle pag=
e fault for address: 000000000000e84d
Apr 09 16:28:04 kvasir kernel: #PF: supervisor read access in kernel mode
Apr 09 16:28:04 kvasir kernel: #PF: error_code(0x0000) - not-present page
Apr 09 16:28:04 kvasir kernel: PGD 0 P4D 0
Apr 09 16:28:04 kvasir kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
Apr 09 16:28:04 kvasir kernel: CPU: 8 PID: 1489 Comm: systemd Tainted: P =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OE =C2=A0 =C2=A0 =C2=A06.8.2-arch2-1 #1 =
a430fb92f7ba43092b62bbe6bac995458d3d442d
Apr 09 16:28:04 kvasir kernel: Hardware name: Razer Blade 17 (2022) - RZ09=
-0423/DI780, BIOS 1.09 01/10/2023
Apr 09 16:28:04 kvasir kernel: RIP: 0010:rb_first+0xf/0x30
Apr 09 16:28:04 kvasir kernel: Code: 10 c3 cc cc cc cc 0f 1f 44 00 00 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07 48 85 c0 =
74 14 48 89 c2 <48> 8b 40 10 48 85 c0 75 f4 48 89 d0 c3 cc cc cc cc 31 d2 =
eb f4 66
Apr 09 16:28:04 kvasir kernel: RSP: 0018:ffffa0aec556bd18 EFLAGS: 00010202
Apr 09 16:28:04 kvasir kernel: RAX: 000000000000e83d RBX: ffff930c5911a200=
 RCX: 0000000001000078
Apr 09 16:28:04 kvasir kernel: RDX: 000000000000e83d RSI: 0000000000000000=
 RDI: ffff930c6570fdf8
Apr 09 16:28:04 kvasir kernel: RBP: ffff930c5911a700 R08: ffff930c4694cbd0=
 R09: 0000000001000078
Apr 09 16:28:04 kvasir kernel: R10: 0000000001000078 R11: ffffa0aec556bd18=
 R12: 0000000000000000
Apr 09 16:28:04 kvasir kernel: R13: ffff930c6570fdf8 R14: 0000000000000002=
 R15: 0000000000000000
Apr 09 16:28:04 kvasir kernel: FS: =C2=A000007f781c810880(0000) GS:ffff931=
3e2800000(0000) knlGS:0000000000000000
Apr 09 16:28:04 kvasir kernel: CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
Apr 09 16:28:04 kvasir kernel: CR2: 000000000000e84d CR3: 0000000113108000=
 CR4: 0000000000f50ef0
Apr 09 16:28:04 kvasir kernel: PKRU: 55555554
Apr 09 16:28:04 kvasir kernel: Call Trace:
Apr 09 16:28:04 kvasir kernel: =C2=A0<TASK>
Apr 09 16:28:04 kvasir kernel: =C2=A0? __die+0x23/0x70
Apr 09 16:28:04 kvasir kernel: =C2=A0? page_fault_oops+0x171/0x4e0
Apr 09 16:28:04 kvasir kernel: =C2=A0? exc_page_fault+0x7f/0x180
Apr 09 16:28:04 kvasir kernel: =C2=A0? asm_exc_page_fault+0x26/0x30
Apr 09 16:28:04 kvasir kernel: =C2=A0? rb_first+0xf/0x30
Apr 09 16:28:04 kvasir kernel: =C2=A0simple_xattrs_free+0x29/0x90
Apr 09 16:28:04 kvasir kernel: =C2=A0kernfs_put.part.0+0x60/0x150
Apr 09 16:28:04 kvasir kernel: =C2=A0evict+0xd4/0x1e0
Apr 09 16:28:04 kvasir kernel: =C2=A0__dentry_kill+0x6e/0x170
Apr 09 16:28:04 kvasir kernel: =C2=A0shrink_dentry_list+0x6b/0xe0
Apr 09 16:28:04 kvasir kernel: =C2=A0shrink_dcache_parent+0xd2/0x140
Apr 09 16:28:04 kvasir kernel: =C2=A0vfs_rmdir+0xb0/0x200
Apr 09 16:28:04 kvasir kernel: =C2=A0do_rmdir+0x1a9/0x1c0
Apr 09 16:28:04 kvasir kernel: =C2=A0__x64_sys_rmdir+0x42/0x70
Apr 09 16:28:04 kvasir kernel: =C2=A0do_syscall_64+0x86/0x170
Apr 09 16:28:04 kvasir kernel: =C2=A0? do_syscall_64+0x96/0x170
Apr 09 16:28:04 kvasir kernel: =C2=A0? syscall_exit_to_user_mode+0x80/0x23=
0
Apr 09 16:28:04 kvasir kernel: =C2=A0? do_syscall_64+0x96/0x170
Apr 09 16:28:04 kvasir kernel: =C2=A0? do_syscall_64+0x96/0x170
Apr 09 16:28:04 kvasir kernel: =C2=A0? do_syscall_64+0x96/0x170
Apr 09 16:28:04 kvasir kernel: =C2=A0entry_SYSCALL_64_after_hwframe+0x6e/0=
x76
Apr 09 16:28:04 kvasir kernel: RIP: 0033:0x7f781c31977b
Apr 09 16:28:04 kvasir kernel: Code: f0 ff ff 73 01 c3 48 8b 0d b2 c5 0d 0=
0 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 54 =
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 81 c5 0d =
00 f7 d8
Apr 09 16:28:04 kvasir kernel: RSP: 002b:00007fff45ca3498 EFLAGS: 00000246=
 ORIG_RAX: 0000000000000054
Apr 09 16:28:04 kvasir kernel: RAX: ffffffffffffffda RBX: 0000619355419610=
 RCX: 00007f781c31977b
Apr 09 16:28:04 kvasir kernel: RDX: 0000000000000000 RSI: 0000000000000001=
 RDI: 0000619355401a30
Apr 09 16:28:04 kvasir kernel: RBP: 00007fff45ca34f0 R08: 00007f781c4aa90a=
 R09: 0000000000000007
Apr 09 16:28:04 kvasir kernel: R10: 000061935540a7e0 R11: 0000000000000246=
 R12: 0000000000000001
Apr 09 16:28:04 kvasir kernel: R13: 0000000000000000 R14: 0000619355401a30=
 R15: 0000000000000000
Apr 09 16:28:04 kvasir kernel: =C2=A0</TASK>
Apr 09 16:28:04 kvasir kernel: Modules linked in: uinput snd_seq_dummy snd=
_hrtimer snd_seq snd_seq_device rfcomm snd_ctl_led ledtrig_audio uhid cmac=
 snd_soc_skl_hda_dsp algif_hash snd_soc_hdac_hdmi snd_soc_intel_hda_dsp_co=
mmon snd_>
Apr 09 16:28:04 kvasir kernel: =C2=A0nf_tables snd_intel_dspcfg kvm_intel =
libcrc32c snd_intel_sdw_acpi i915 mac80211 uvcvideo btusb snd_hda_codec vi=
deobuf2_vmalloc kvm btrtl uvc videobuf2_memops libarc4 snd_hda_core btinte=
l processor_th>
Apr 09 16:28:04 kvasir kernel: =C2=A0int3403_thermal int3400_thermal intel=
_hid pmt_telemetry int340x_thermal_zone acpi_thermal_rel sparse_keymap pmt=
_class acpi_tad acpi_pad mac_hid fuse loop nfnetlink ip_tables x_tables ex=
t4 crc32c_gene>
Apr 09 16:28:04 kvasir kernel: CR2: 000000000000e84d
Apr 09 16:28:04 kvasir kernel: ---[ end trace 0000000000000000 ]---
Apr 09 16:28:04 kvasir kernel: RIP: 0010:rb_first+0xf/0x30
Apr 09 16:28:04 kvasir kernel: Code: 10 c3 cc cc cc cc 0f 1f 44 00 00 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07 48 85 c0 =
74 14 48 89 c2 <48> 8b 40 10 48 85 c0 75 f4 48 89 d0 c3 cc cc cc cc 31 d2 =
eb f4 66
Apr 09 16:28:04 kvasir kernel: RSP: 0018:ffffa0aec556bd18 EFLAGS: 00010202
Apr 09 16:28:04 kvasir kernel: RAX: 000000000000e83d RBX: ffff930c5911a200=
 RCX: 0000000001000078
Apr 09 16:28:04 kvasir kernel: RDX: 000000000000e83d RSI: 0000000000000000=
 RDI: ffff930c6570fdf8
Apr 09 16:28:04 kvasir kernel: RBP: ffff930c5911a700 R08: ffff930c4694cbd0=
 R09: 0000000001000078
Apr 09 16:28:04 kvasir kernel: R10: 0000000001000078 R11: ffffa0aec556bd18=
 R12: 0000000000000000
Apr 09 16:28:04 kvasir kernel: R13: ffff930c6570fdf8 R14: 0000000000000002=
 R15: 0000000000000000
Apr 09 16:28:04 kvasir kernel: FS: =C2=A000007f781c810880(0000) GS:ffff931=
3e2800000(0000) knlGS:0000000000000000
Apr 09 16:28:04 kvasir kernel: CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
Apr 09 16:28:04 kvasir kernel: CR2: 000000000000e84d CR3: 0000000113108000=
 CR4: 0000000000f50ef0
Apr 09 16:28:04 kvasir kernel: PKRU: 55555554
Apr 09 16:28:04 kvasir kernel: note: systemd[1489] exited with irqs disabl=
ed
Apr 09 16:28:04 kvasir systemd[1]: user@1000.service: Main process exited,=
 code=3Dkilled, status=3D9/KILL
Apr 09 16:28:04 kvasir systemd[1]: user@1000.service: Killing process 2051=
 (xdg-permission-) with signal SIGKILL.
Apr 09 16:28:04 kvasir (sd-pam)[1491]: pam_unix(systemd-user:session): ses=
sion closed for user <snip>
Apr 09 16:28:04 kvasir kernel: traps: ThreadPoolSingl[54126] trap int3 ip:=
60260199ba4a sp:79c68adfe6a0 error:0 in signal-desktop[6025fdd77000+816d00=
0]
Apr 09 16:28:04 kvasir systemd[1]: user@1000.service: Killing process 1508=
 (dbus-broker-lau) with signal SIGKILL.

Any help would be greatly appreciated.


Let me know if I can provide any more information to help narrow this down=
, it's a weird bug.


Thanks,
Ryan.
-----------------------7430c4a7e042aa53ed677790bb261949
Content-Type: multipart/related;boundary=---------------------dfc305eaaf94fe13094c00abebf40a1f

-----------------------dfc305eaaf94fe13094c00abebf40a1f
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij5IZXkgYWxsLDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5
OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+SSBob3BlIEkndmUgZ290IHRo
ZSByaWdodCBsaXN0IGZvciB0aGlzLjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlh
bCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZv
bnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+SSByYW4gaW50
byBhIGJpemFycmUgcHJvYmxlbSBhIGNvdXBsZSBvZiBkYXlzIGFnbywgd2hlcmUgbXkgbGFwdG9w
IGtlcm5lbCBwYW5pY2tlZCBhZnRlciBJIHdhcyBpbiBhIHZvaWNlIGNhbGwgb24gU2lnbmFsIERl
c2t0b3AsIHVzaW5nIG15IFNvbnkgV0gtMTAwMFhNNSBCbHVldG9vdGggaGVhZHBob25lcy48L2Rp
dj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTog
MTRweDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2Vy
aWY7IGZvbnQtc2l6ZTogMTRweDsiPkknbSB1c2luZyBFbmRlYXZvdXJPUywgbXkga2VybmVsIGlz
OjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1z
aXplOiAxNHB4OyI+PHNwYW4+TGludXgga3Zhc2lyIDYuOC4yLWFyY2gyLTEgIzEgU01QIFBSRUVN
UFRfRFlOQU1JQyBUaHUsIDI4IE1hciAyMDI0IDE3OjA2OjM1ICswMDAwIHg4Nl82NCBHTlUvTGlu
dXg8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlm
OyBmb250LXNpemU6IDE0cHg7Ij48c3Bhbj48YnI+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZv
bnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PHNwYW4+TXkg
bGFwdG9wOjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMt
c2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPjxzcGFuPlJhemVyIEJsYWRlIDE3ICgyMDIyKSAtIGhh
cyBJbnRlbCBBWDIxMSBXaUZpL0JsdWV0b290aC48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9u
dC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48c3Bhbj48YnI+
PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsg
Zm9udC1zaXplOiAxNHB4OyI+PHNwYW4+aGNpMCBkZXRhaWxzOjwvc3Bhbj48L2Rpdj48ZGl2IHN0
eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPjxz
cGFuPjxzcGFuPlsgJm5ic3A7IDE1LjkxNTE3Nl0gQmx1ZXRvb3RoOiBoY2kwOiBEZXZpY2UgcmV2
aXNpb24gaXMgMDwvc3Bhbj48ZGl2PjxzcGFuPlsgJm5ic3A7IDE1LjkxNTE3OV0gQmx1ZXRvb3Ro
OiBoY2kwOiBTZWN1cmUgYm9vdCBpcyBlbmFibGVkPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+WyAm
bmJzcDsgMTUuOTE1MTgwXSBCbHVldG9vdGg6IGhjaTA6IE9UUCBsb2NrIGlzIGVuYWJsZWQ8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj5bICZuYnNwOyAxNS45MTUxODFdIEJsdWV0b290aDogaGNpMDog
QVBJIGxvY2sgaXMgZW5hYmxlZDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPlsgJm5ic3A7IDE1Ljkx
NTE4MV0gQmx1ZXRvb3RoOiBoY2kwOiBEZWJ1ZyBsb2NrIGlzIGRpc2FibGVkPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+WyAmbmJzcDsgMTUuOTE1MTgyXSBCbHVldG9vdGg6IGhjaTA6IE1pbmltdW0g
ZmlybXdhcmUgYnVpbGQgMSB3ZWVrIDEwIDIwMTQ8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5bICZu
YnNwOyAxNS45MTUxODNdIEJsdWV0b290aDogaGNpMDogQm9vdGxvYWRlciB0aW1lc3RhbXAgMjAx
OS40MCBidWlsZHR5cGUgMSBidWlsZCAzODwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPlsgJm5ic3A7
IDE1LjkxNTI0Ml0gQmx1ZXRvb3RoOiBoY2kwOiBEU00gcmVzZXQgbWV0aG9kIHR5cGU6IDB4MDA8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5bICZuYnNwOyAxNS45MTgxODBdIEJsdWV0b290aDogaGNp
MDogRm91bmQgZGV2aWNlIGZpcm13YXJlOiBpbnRlbC9pYnQtMDA0MC0wMDQxLnNmaTwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuPlsgJm5ic3A7IDE1LjkxODE5N10gQmx1ZXRvb3RoOiBoY2kwOiBCb290
IEFkZHJlc3M6IDB4MTAwODAwPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+WyAmbmJzcDsgMTUuOTE4
MTk5XSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIFZlcnNpb246IDYwLTQ4LjIzPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+WyAmbmJzcDsgMTcuMzY2OTc4XSBCbHVldG9vdGg6IGhjaTA6IFdhaXRp
bmcgZm9yIGZpcm13YXJlIGRvd25sb2FkIHRvIGNvbXBsZXRlPC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+WyAmbmJzcDsgMTcuMzY3MzYwXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIGxvYWRlZCBp
biAxNDE1MjA5IHVzZWNzPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+WyAmbmJzcDsgMTcuMzY3NTU0
XSBCbHVldG9vdGg6IGhjaTA6IFdhaXRpbmcgZm9yIGRldmljZSB0byBib290PC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+WyAmbmJzcDsgMTcuMzgzMjU0XSBCbHVldG9vdGg6IGhjaTA6IE1hbGZvcm1l
ZCBNU0ZUIHZlbmRvciBldmVudDogMHgwMjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPlsgJm5ic3A7
IDE3LjM4MzMxOV0gQmx1ZXRvb3RoOiBoY2kwOiBEZXZpY2UgYm9vdGVkIGluIDE1NTI0IHVzZWNz
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+WyAmbmJzcDsgMTcuMzgzOTgzXSBCbHVldG9vdGg6IGhj
aTA6IEZvdW5kIEludGVsIEREQyBwYXJhbWV0ZXJzOiBpbnRlbC9pYnQtMDA0MC0wMDQxLmRkYzwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPlsgJm5ic3A7IDE3LjM4NjMwMl0gQmx1ZXRvb3RoOiBoY2kw
OiBBcHBseWluZyBJbnRlbCBEREMgcGFyYW1ldGVycyBjb21wbGV0ZWQ8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj5bICZuYnNwOyAxNy4zODkzNjJdIEJsdWV0b290aDogaGNpMDogRmlybXdhcmUgdGlt
ZXN0YW1wIDIwMjMuNDggYnVpbGR0eXBlIDEgYnVpbGQgNzUzMjQ8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj5bICZuYnNwOyAxNy4zODkzODFdIEJsdWV0b290aDogaGNpMDogRmlybXdhcmUgU0hBMTog
MHgyM2JhYzU1ODwvc3Bhbj48L2Rpdj48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48c3Bhbj48YnI+PC9zcGFu
PjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1z
aXplOiAxNHB4OyI+PHNwYW4+U2lnbmFsIGtlcHQganVtcGluZyBiZXR3ZWVuIHRoZSBoYW5kcy1m
cmVlIG1vZGUgb2YgbXkgaGVhZHBob25lcyBhbmQgdGhlIEhRIGF1ZGlvIG1vZGUgcHJldHR5IHJh
cGlkbHksIHNvIEkgc3dpdGNoZWQgb2ZmIG15IGhlYWRwaG9uZXMgdG8gY29udGludWUgdGhlIGNh
bGwgb24gbW9iaWxlLCBhcyBzb29uIGFzIEkgZ290IGEgbWVzc2FnZS9jYWxsIGluIFNpZ25hbCBJ
IHByZXN1bWUgaXQgdHJpZWQgdG8gcGxheSB0aGUgbm90aWZpY2F0aW9uIHNvdW5kIHRocm91Z2gg
bXkgaGVhZHBob25lcyAod2hpY2ggd2VyZW4ndCBjb25uZWN0ZWQgYW55bW9yZSksIGFuZCB0aGUg
a2VybmVsIHBhbmljIGhhcHBlbmVkLjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWls
eTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPjxzcGFuPkl0IHNlZW1zIGxp
a2UgU2lnbmFsIHRyaWVkIHRvIHVzZSBhbiBvbGQgaGFuZGxlIHRvIG15IGhlYWRwaG9uZXMsIGFu
ZCB0aGF0IGNhdXNlZCB0aGUgYmx1ZXRvb3RoIGtlcm5lbCBkcml2ZXIgdG8gY3Jhc2gsIGp1ZGdp
bmcgZnJvbSB0aGUgdGltaW5nIG9mIHRoZSBqb3VybmFsY3RsIG1lc3NhZ2VzPzwvc3Bhbj48L2Rp
dj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTog
MTRweDsiPjxzcGFuPkl0IHNvdW5kcyB0byBtZSBsaWtlIGEgdXNlLWFmdGVyLWZyZWUgYnVnLCBi
dXQgSSBkb24ndCByZWFsbHkga25vdyBlbm91Z2ggYWJvdXQga2VybmVsIGRyaXZlciBkZXZlbG9w
bWVudCB0byB0cnkgYW5kIG5hcnJvdyBpdCBkb3duLjxicj48L3NwYW4+PC9kaXY+PGRpdiBzdHls
ZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48c3Bh
bj48YnI+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PHNwYW4+SGVyZSBpcyBhIHNuaXBwZXQgb2Ygam91cm5h
bGN0bCBmcm9tIHRoZSBtb21lbnQgaXQga2VybmVsIHBhbmlja2VkOjwvc3Bhbj48L2Rpdj48ZGl2
IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsi
PjxzcGFuPjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBCbHVldG9vdGg6IGhj
aTA6IFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMjU3PC9zcGFuPjxk
aXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IEJVRzogdW5hYmxlIHRvIGhh
bmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNzOiAwMDAwMDAwMDAwMDBlODRkPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6ICNQRjogc3VwZXJ2aXNv
ciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAw
OSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1w
cmVzZW50IHBhZ2U8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2ly
IGtlcm5lbDogUEdEIDAgUDREIDAgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4
OjA0IGt2YXNpciBrZXJuZWw6IE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSTwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBDUFU6IDgg
UElEOiAxNDg5IENvbW06IHN5c3RlbWQgVGFpbnRlZDogUCAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7IE9FICZuYnNwOyAmbmJzcDsgJm5ic3A7Ni44LjItYXJjaDItMSAjMSBhNDMw
ZmI5MmY3YmE0MzA5MmI2MmJiZTZiYWM5OTU0NThkM2Q0NDJkPC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6IFJhemVyIEJs
YWRlIDE3ICgyMDIyKSAtIFJaMDktMDQyMy9ESTc4MCwgQklPUyAxLjA5IDAxLzEwLzIwMjM8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUklQOiAw
MDEwOnJiX2ZpcnN0KzB4Zi8weDMwPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4
OjA0IGt2YXNpciBrZXJuZWw6IENvZGU6IDEwIGMzIGNjIGNjIGNjIGNjIDBmIDFmIDQ0IDAwIDAw
IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIGYzIDBmIDFl
IGZhIDQ4IDhiIDA3IDQ4IDg1IGMwIDc0IDE0IDQ4IDg5IGMyICZsdDs0OCZndDsgOGIgNDAgMTAg
NDggODUgYzAgNzUgZjQgNDggODkgZDAgYzMgY2MgY2MgY2MgY2MgMzEgZDIgZWIgZjQgNjY8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUlNQOiAw
MDE4OmZmZmZhMGFlYzU1NmJkMTggRUZMQUdTOiAwMDAxMDIwMjwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAwMGU4M2Qg
UkJYOiBmZmZmOTMwYzU5MTFhMjAwIFJDWDogMDAwMDAwMDAwMTAwMDA3ODwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBSRFg6IDAwMDAwMDAwMDAw
MGU4M2QgUlNJOiAwMDAwMDAwMDAwMDAwMDAwIFJESTogZmZmZjkzMGM2NTcwZmRmODwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBSQlA6IGZmZmY5
MzBjNTkxMWE3MDAgUjA4OiBmZmZmOTMwYzQ2OTRjYmQwIFIwOTogMDAwMDAwMDAwMTAwMDA3ODwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBSMTA6
IDAwMDAwMDAwMDEwMDAwNzggUjExOiBmZmZmYTBhZWM1NTZiZDE4IFIxMjogMDAwMDAwMDAwMDAw
MDAwMDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVs
OiBSMTM6IGZmZmY5MzBjNjU3MGZkZjggUjE0OiAwMDAwMDAwMDAwMDAwMDAyIFIxNTogMDAwMDAw
MDAwMDAwMDAwMDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIg
a2VybmVsOiBGUzogJm5ic3A7MDAwMDdmNzgxYzgxMDg4MCgwMDAwKSBHUzpmZmZmOTMxM2UyODAw
MDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDA8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5B
cHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogQ1M6ICZuYnNwOzAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5
IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IENSMjogMDAwMDAwMDAwMDAwZTg0ZCBDUjM6IDAwMDAw
MDAxMTMxMDgwMDAgQ1I0OiAwMDAwMDAwMDAwZjUwZWYwPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IFBLUlU6IDU1NTU1NTU0PC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IENhbGwgVHJhY2U6PC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6ICZuYnNw
OyZsdDtUQVNLJmd0Ozwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFz
aXIga2VybmVsOiAmbmJzcDs/IF9fZGllKzB4MjMvMHg3MDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAmbmJzcDs/IHBhZ2VfZmF1bHRfb29wcysw
eDE3MS8weDRlMDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIg
a2VybmVsOiAmbmJzcDs/IGV4Y19wYWdlX2ZhdWx0KzB4N2YvMHgxODA8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogJm5ic3A7PyBhc21fZXhjX3Bh
Z2VfZmF1bHQrMHgyNi8weDMwPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0
IGt2YXNpciBrZXJuZWw6ICZuYnNwOz8gcmJfZmlyc3QrMHhmLzB4MzA8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogJm5ic3A7c2ltcGxlX3hhdHRy
c19mcmVlKzB4MjkvMHg5MDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBr
dmFzaXIga2VybmVsOiAmbmJzcDtrZXJuZnNfcHV0LnBhcnQuMCsweDYwLzB4MTUwPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6ICZuYnNwO2V2aWN0
KzB4ZDQvMHgxZTA8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2ly
IGtlcm5lbDogJm5ic3A7X19kZW50cnlfa2lsbCsweDZlLzB4MTcwPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6ICZuYnNwO3Nocmlua19kZW50cnlf
bGlzdCsweDZiLzB4ZTA8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zh
c2lyIGtlcm5lbDogJm5ic3A7c2hyaW5rX2RjYWNoZV9wYXJlbnQrMHhkMi8weDE0MDwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAmbmJzcDt2ZnNf
cm1kaXIrMHhiMC8weDIwMDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBr
dmFzaXIga2VybmVsOiAmbmJzcDtkb19ybWRpcisweDFhOS8weDFjMDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAmbmJzcDtfX3g2NF9zeXNfcm1k
aXIrMHg0Mi8weDcwPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNp
ciBrZXJuZWw6ICZuYnNwO2RvX3N5c2NhbGxfNjQrMHg4Ni8weDE3MDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAmbmJzcDs/IGRvX3N5c2NhbGxf
NjQrMHg5Ni8weDE3MDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFz
aXIga2VybmVsOiAmbmJzcDs/IHN5c2NhbGxfZXhpdF90b191c2VyX21vZGUrMHg4MC8weDIzMDwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAmbmJz
cDs/IGRvX3N5c2NhbGxfNjQrMHg5Ni8weDE3MDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAw
OSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAmbmJzcDs/IGRvX3N5c2NhbGxfNjQrMHg5Ni8weDE3
MDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAm
bmJzcDs/IGRvX3N5c2NhbGxfNjQrMHg5Ni8weDE3MDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFw
ciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiAmbmJzcDtlbnRyeV9TWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUrMHg2ZS8weDc2PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0
IGt2YXNpciBrZXJuZWw6IFJJUDogMDAzMzoweDdmNzgxYzMxOTc3Yjwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBDb2RlOiBmMCBmZiBmZiA3MyAw
MSBjMyA0OCA4YiAwZCBiMiBjNSAwZCAwMCBmNyBkOCA2NCA4OSAwMSA0OCA4MyBjOCBmZiBjMyAw
ZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCBmMyAwZiAxZSBmYSBiOCA1NCAwMCAwMCAwMCAwZiAwNSAm
bHQ7NDgmZ3Q7IDNkIDAwIGYwIGZmIGZmIDc3IDA1IGMzIDBmIDFmIDQwIDAwIDQ4IDhiIDE1IDgx
IGM1IDBkIDAwIGY3IGQ4PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2
YXNpciBrZXJuZWw6IFJTUDogMDAyYjowMDAwN2ZmZjQ1Y2EzNDk4IEVGTEFHUzogMDAwMDAyNDYg
T1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwNTQ8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkg
MTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDYx
OTM1NTQxOTYxMCBSQ1g6IDAwMDA3Zjc4MWMzMTk3N2I8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5B
cHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTog
MDAwMDAwMDAwMDAwMDAwMSBSREk6IDAwMDA2MTkzNTU0MDFhMzA8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUkJQOiAwMDAwN2ZmZjQ1Y2EzNGYw
IFIwODogMDAwMDdmNzgxYzRhYTkwYSBSMDk6IDAwMDAwMDAwMDAwMDAwMDc8L3NwYW4+PC9kaXY+
PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUjEwOiAwMDAwNjE5MzU1
NDBhN2UwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDE8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUjEzOiAwMDAw
MDAwMDAwMDAwMDAwIFIxNDogMDAwMDYxOTM1NTQwMWEzMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDA8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogJm5i
c3A7Jmx0Oy9UQVNLJmd0Ozwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBr
dmFzaXIga2VybmVsOiBNb2R1bGVzIGxpbmtlZCBpbjogdWlucHV0IHNuZF9zZXFfZHVtbXkgc25k
X2hydGltZXIgc25kX3NlcSBzbmRfc2VxX2RldmljZSByZmNvbW0gc25kX2N0bF9sZWQgbGVkdHJp
Z19hdWRpbyB1aGlkIGNtYWMgc25kX3NvY19za2xfaGRhX2RzcCBhbGdpZl9oYXNoIHNuZF9zb2Nf
aGRhY19oZG1pIHNuZF9zb2NfaW50ZWxfaGRhX2RzcF9jb21tb24gc25kXyZndDs8L3NwYW4+PC9k
aXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogJm5ic3A7bmZfdGFi
bGVzIHNuZF9pbnRlbF9kc3BjZmcga3ZtX2ludGVsIGxpYmNyYzMyYyBzbmRfaW50ZWxfc2R3X2Fj
cGkgaTkxNSBtYWM4MDIxMSB1dmN2aWRlbyBidHVzYiBzbmRfaGRhX2NvZGVjIHZpZGVvYnVmMl92
bWFsbG9jIGt2bSBidHJ0bCB1dmMgdmlkZW9idWYyX21lbW9wcyBsaWJhcmM0IHNuZF9oZGFfY29y
ZSBidGludGVsIHByb2Nlc3Nvcl90aCZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkg
MTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogJm5ic3A7aW50MzQwM190aGVybWFsIGludDM0MDBfdGhl
cm1hbCBpbnRlbF9oaWQgcG10X3RlbGVtZXRyeSBpbnQzNDB4X3RoZXJtYWxfem9uZSBhY3BpX3Ro
ZXJtYWxfcmVsIHNwYXJzZV9rZXltYXAgcG10X2NsYXNzIGFjcGlfdGFkIGFjcGlfcGFkIG1hY19o
aWQgZnVzZSBsb29wIG5mbmV0bGluayBpcF90YWJsZXMgeF90YWJsZXMgZXh0NCBjcmMzMmNfZ2Vu
ZSZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5l
bDogQ1IyOiAwMDAwMDAwMDAwMDBlODRkPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2
OjI4OjA0IGt2YXNpciBrZXJuZWw6IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0t
LTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBS
SVA6IDAwMTA6cmJfZmlyc3QrMHhmLzB4MzA8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkg
MTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogQ29kZTogMTAgYzMgY2MgY2MgY2MgY2MgMGYgMWYgNDQg
MDAgMDAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgZjMg
MGYgMWUgZmEgNDggOGIgMDcgNDggODUgYzAgNzQgMTQgNDggODkgYzIgJmx0OzQ4Jmd0OyA4YiA0
MCAxMCA0OCA4NSBjMCA3NSBmNCA0OCA4OSBkMCBjMyBjYyBjYyBjYyBjYyAzMSBkMiBlYiBmNCA2
Njwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBS
U1A6IDAwMTg6ZmZmZmEwYWVjNTU2YmQxOCBFRkxBR1M6IDAwMDEwMjAyPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IFJBWDogMDAwMDAwMDAwMDAw
ZTgzZCBSQlg6IGZmZmY5MzBjNTkxMWEyMDAgUkNYOiAwMDAwMDAwMDAxMDAwMDc4PC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IFJEWDogMDAwMDAw
MDAwMDAwZTgzZCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiBmZmZmOTMwYzY1NzBmZGY4PC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IFJCUDog
ZmZmZjkzMGM1OTExYTcwMCBSMDg6IGZmZmY5MzBjNDY5NGNiZDAgUjA5OiAwMDAwMDAwMDAxMDAw
MDc4PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6
IFIxMDogMDAwMDAwMDAwMTAwMDA3OCBSMTE6IGZmZmZhMGFlYzU1NmJkMTggUjEyOiAwMDAwMDAw
MDAwMDAwMDAwPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBr
ZXJuZWw6IFIxMzogZmZmZjkzMGM2NTcwZmRmOCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDIgUjE1OiAw
MDAwMDAwMDAwMDAwMDAwPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXByIDA5IDE2OjI4OjA0IGt2
YXNpciBrZXJuZWw6IEZTOiAmbmJzcDswMDAwN2Y3ODFjODEwODgwKDAwMDApIEdTOmZmZmY5MzEz
ZTI4MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPkFwciAwOSAxNjoyODowNCBrdmFzaXIga2VybmVsOiBDUzogJm5ic3A7MDAxMCBEUzogMDAw
MCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5B
cHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogQ1IyOiAwMDAwMDAwMDAwMDBlODRkIENSMzog
MDAwMDAwMDExMzEwODAwMCBDUjQ6IDAwMDAwMDAwMDBmNTBlZjA8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogUEtSVTogNTU1NTU1NTQ8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIGtlcm5lbDogbm90ZTogc3lz
dGVtZFsxNDg5XSBleGl0ZWQgd2l0aCBpcnFzIGRpc2FibGVkPC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+QXByIDA5IDE2OjI4OjA0IGt2YXNpciBzeXN0ZW1kWzFdOiB1c2VyQDEwMDAuc2VydmljZTog
TWFpbiBwcm9jZXNzIGV4aXRlZCwgY29kZT1raWxsZWQsIHN0YXR1cz05L0tJTEw8L3NwYW4+PC9k
aXY+PGRpdj48c3Bhbj5BcHIgMDkgMTY6Mjg6MDQga3Zhc2lyIHN5c3RlbWRbMV06IHVzZXJAMTAw
MC5zZXJ2aWNlOiBLaWxsaW5nIHByb2Nlc3MgMjA1MSAoeGRnLXBlcm1pc3Npb24tKSB3aXRoIHNp
Z25hbCBTSUdLSUxMLjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkFwciAwOSAxNjoyODowNCBrdmFz
aXIgKHNkLXBhbSlbMTQ5MV06IHBhbV91bml4KHN5c3RlbWQtdXNlcjpzZXNzaW9uKTogc2Vzc2lv
biBjbG9zZWQgZm9yIHVzZXIgJmx0O3NuaXAmZ3Q7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+QXBy
IDA5IDE2OjI4OjA0IGt2YXNpciBrZXJuZWw6IHRyYXBzOiBUaHJlYWRQb29sU2luZ2xbNTQxMjZd
IHRyYXAgaW50MyBpcDo2MDI2MDE5OWJhNGEgc3A6NzljNjhhZGZlNmEwIGVycm9yOjAgaW4gc2ln
bmFsLWRlc2t0b3BbNjAyNWZkZDc3MDAwKzgxNmQwMDBdPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
QXByIDA5IDE2OjI4OjA0IGt2YXNpciBzeXN0ZW1kWzFdOiB1c2VyQDEwMDAuc2VydmljZTogS2ls
bGluZyBwcm9jZXNzIDE1MDggKGRidXMtYnJva2VyLWxhdSkgd2l0aCBzaWduYWwgU0lHS0lMTC48
L3NwYW4+PC9kaXY+PHNwYW4+PC9zcGFuPjxicj48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9u
dC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48c3Bhbj5Bbnkg
aGVscCB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxl
PSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPjxzcGFu
Pjxicj48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNl
cmlmOyBmb250LXNpemU6IDE0cHg7Ij48c3Bhbj5MZXQgbWUga25vdyBpZiBJIGNhbiBwcm92aWRl
IGFueSBtb3JlIGluZm9ybWF0aW9uIHRvIGhlbHAgbmFycm93IHRoaXMgZG93biwgaXQncyBhIHdl
aXJkIGJ1Zy48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5z
LXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48c3Bhbj48YnI+PC9zcGFuPjwvZGl2PjxkaXYgc3R5
bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PHNw
YW4+VGhhbmtzLDwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNh
bnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPjxzcGFuPlJ5YW4uPGJyPjwvc3Bhbj48L2Rpdj4K
PGRpdiBjbGFzcz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2sgcHJvdG9ubWFpbF9zaWduYXR1
cmVfYmxvY2stZW1wdHkiIHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZv
bnQtc2l6ZTogMTRweDsiPgogICAgPGRpdiBjbGFzcz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxv
Y2stdXNlciBwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+PC9kaXY+CiAgICAKICAg
ICAgICAgICAgPGRpdiBjbGFzcz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stcHJvdG9uIHBy
b3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVtcHR5Ij4KICAgICAgICAKICAgICAgICAgICAgPC9k
aXY+CjwvZGl2Pgo=
-----------------------dfc305eaaf94fe13094c00abebf40a1f--
-----------------------7430c4a7e042aa53ed677790bb261949--
-----------------------ff55c3c83e0ad154ac1e12b0bb565750
Content-Type: application/pgp-keys; filename="publickey - ryan@ryanjgray.com - 0xCB50AEEA.asc"; name="publickey - ryan@ryanjgray.com - 0xCB50AEEA.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - ryan@ryanjgray.com - 0xCB50AEEA.asc"; name="publickey - ryan@ryanjgray.com - 0xCB50AEEA.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWWYzR1ZCWUpLd1lCQkFI
YVJ3OEJBUWRBaWF4QlZZV0RLSFhQVDVTL1BhcnpDeHhNWGZGbkJMbGwKZlliRGMyL0JiZm5OSjNK
NVlXNUFjbmxoYm1wbmNtRjVMbU52YlNBOGNubGhia0J5ZVdGdWFtZHlZWGt1ClkyOXRQc0tQQkJB
V0NnQWdCUUpoL2NaVUJnc0pCd2dEQWdRVkNBb0NCQllDQVFBQ0dRRUNHd01DSGdFQQpJUWtRdUVH
ekRBZ2ZoS2tXSVFUTFVLN3FEa2ptckIySldtRzRRYk1NQ0IrRXFXS2xBUDQ0ckc0cmdlMkgKOExS
dllQRlhQbjVZZ21YWkdGSTh2dEo5NGt4ZVEyZ3JVQUQvZFdRdnpBS1pSTVpzb0lVbHNJTC9pbFFt
CkFaRmRQU1M1QzZ3ZE52dGZId3JPT0FSaC9jWlVFZ29yQmdFRUFaZFZBUVVCQVFkQVdGRk4xcVdY
RFQ5NApJYURaZEhFNW56dkFmL0xaRS8xSXBITzNJVGFRZ25jREFRZ0h3bmdFR0JZSUFBa0ZBbUg5
eGxRQ0d3d0EKSVFrUXVFR3pEQWdmaEtrV0lRVExVSzdxRGtqbXJCMkpXbUc0UWJNTUNCK0VxWisy
QVA0dStlUk1DV0pDClBJQXhVQTVYend2ZkQxZzh4VEhvL3lSOURtYURDeWJwaWdFQW1FclppaHVX
dEhzeXlaVGVaRGpmNEFFUApNYS80TlIyUEpmOEwvTUpsRlFrPQo9Y29VcwotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------ff55c3c83e0ad154ac1e12b0bb565750--

--------91f4eb2d3a6ff3f676c4e57240defea2d2f2c4c2df2ec6555f6843e84a456cc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmYX1GgJkLhBswwIH4SpFiEEy1Cu6g5I5qwdiVphuEGzDAgf
hKkAAGXNAQC8YwCDNF9XEEZ/yMiszCnLeALOJ/6cPjRZpqTZjte0igEAk2iB
h2Xyb3REg3vP8ywQi9rq/MaAapy+5PX0qgyYmAo=
=5EP9
-----END PGP SIGNATURE-----


--------91f4eb2d3a6ff3f676c4e57240defea2d2f2c4c2df2ec6555f6843e84a456cc7--

