Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3D24E016
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556896; cv=none; b=smXKQ+4xUpFkys/OeZgUA3EHJMowlFIs3PVRLVDdVvJJNE3J58Ar13tP9xzXxu7Q/rPBf+wBx494tQSRlFCQdf9Eh7KzblH7T7zfB2vVIZtP4yCkyTTKAtOM5h2MPgsoyZZi+WuuPF2eqQ4BA+L3Y4cCboUcAGIgOdcobn6C6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556896; c=relaxed/simple;
	bh=ClrivFNWMkAGPB/gwPIa53ox3p/OdJCYRP2VIAIAthE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iegSygMOWT16OVOG6m/KLatPZPl7+NzoJ6W3aLn6iqV9QEe92kPjObzbpt1bGZcenPLKfR39aGozSNjEfUBIMBHV7durBMFNYqgbDsHYE9p2uprA7csVc+K8OUwTSnzRMHKyHQrQgeEr0SGS5+vREL5v5B8fyjsA4w1ZihenlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCeRP7t8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCeRP7t8"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so76323231fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556893; x=1761161693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YzNlKGQ9Z7E5df0IdPWTnAIzVuyZdlHii1gfioRWcrE=;
        b=bCeRP7t8vIHu0f28NTr89oxzgbacCV5Ap8pumxvOWvsXjoBiMCZjtYjUHQoi53RvcU
         yEPu6ZZMN23zq+53IUqX7SxIz5vgclEgkeNDhGgAbj2EiVDz2Yxeh6xE47MMb1LBPvdd
         iWSMICY/F1S7kqaM2xs6goMArfF7S4kxLABDzt3L/2Q7PmVIiWOQIrvtMz9AlViemfpJ
         5eRvcDHB9g/85P1mcxtVirNPmg5fj8vQpYTooBixp30CPICDuE10U2hQlNJwxDSsw73X
         XsGd7BpfPwDI+cDr/zFoc35zFyuD1BIMrbBHl8wwrN2mQQVxF0HdtCx6mYCOUa+jWZ1N
         9nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556893; x=1761161693;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzNlKGQ9Z7E5df0IdPWTnAIzVuyZdlHii1gfioRWcrE=;
        b=nVn8TGO/Awk9IPAqZf2jnG7NdSoBeERNhSOFOR+fmeQ6C0Aucnuk5E3VPIxgb/FpnX
         +PjbfL0U9u4VOtz02sujL7YFBOMSnMrGdHPz65wwSOT73zsV72ve+l9Cl6QWwZFBqn3w
         vn/mo/pGPGg4cQykdj7Rjkw3ZtSZOmRGIhZKryBUgzJVG8EOVdLaxEy/JY/OXoKYZGDI
         tN9qWTdMXZcLWgzoJ2LfT77i+41nCXUSD+fFU3hx+YzRKlO2jBF/zqW16XVU3y6Hje54
         cRyABYH4x7wuarNx6HFa/5ccOlFa5BiTR/ql71HNmBm5XfPI6jDmRx5neZVydglUjngU
         AGEw==
X-Gm-Message-State: AOJu0YxCK7Uf+Xq4SqzemMoVGVZw9I6FwyazfRfJ+s9f0mVeEfAwa1Jg
	Y5AuIYZ5/p/KPSZSWfErFFc4JZetY21LlPvOPdueZjR2bwGj8wcrEnovYLeGRI+nq1SjS5vfHdI
	MHPX0A0NYilbFL51R3nBripXvxYOkVXrTrnaA
X-Gm-Gg: ASbGncuvR2mwzU5DzRqAjtcmqpl0LZWVWHik1s0ObqQhR3BW3GT/CLbDUgPo9MAzE8o
	0dU8ZcRW8u0bqP98y+aT0KOnBtPHmAxTKYKtiw0iFcPKXPx2/V8WqVJIN4/oRh0yYpP3kOtZS24
	W0Fs8Y4e4PUjwopFtXQbUVbnArmtAhyNegRau4tfP0yACTgsWLSDkgQGe5rp4zkCFLdz2yD4xN1
	RYZ0+DaHD1NBHK98xgq2Z9WYQ+eO+7s7T1PWZG7yUlh9FDDCGk3oIFCdg==
X-Google-Smtp-Source: AGHT+IGQEpVuu+MMKJrZYt1NlFaxFm3q6VnEEplS4e1waYAG3eL9oV0kFFZKCioeZ25wJX0inTCSLzn7ZG2XCnpUrxw=
X-Received: by 2002:a05:651c:25cf:20b0:376:77c2:d7fe with SMTP id
 38308e7fff4ca-37677c2f0c2mr32173791fa.48.1760556892264; Wed, 15 Oct 2025
 12:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 15 Oct 2025 16:34:41 -0300
X-Gm-Features: AS18NWBvPNEYuy2E254v5goffc2JifeL_mz2lwDj1zQIJ63DFwDZ9JR-8qVTJd4
Message-ID: <CAOMZO5AQj25sJi6nHX+FO7D3eFPLi7_7LpBQfHW9qXQHH2nQsw@mail.gmail.com>
Subject: Crash at hci_conn_cleanup() when bluetooth service is restarted
To: Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have two i.MX6UL boards populated with a TI WL1837 Bluetooth chip
running kernel 6.1.153 (also tested with 6.1.155).

The rfcomm connection is established:

root@board_1~# rfcomm listen hci0 1
Waiting for connection on channel 1
Connection from C8:DF:84:4C:48:75 to /dev/rfcomm0

root@board_2:~# rfcomm connet hci0 38:0B:3C:E6:FB:F2 1
Connected /dev/rfcomm0 to 38:0B:3C:E6:FB:F2 on channel 1
Press CTRL-C for hangup

Force restarting of the Bluetooth service while the RFComm connection is active:

ssh root@192.168.216.206 systemctl restart bluetooth.service & ssh
root@192.168.216.244 systemctl restart bluetooth.service

Then the following kernel crash happens (in most cases, not always):

Does anyone have any suggestions?

Thanks,

Fabio Estevam

Disconnected
root@board_2:~# [  241.459378] 8<--- cut here ---
[  241.462487] Unable to handle kernel NULL pointer dereference at
virtual address 00000122
[  241.473362] [00000122] *pgd=00000000
[  241.477381] Internal error: Oops: 817 [#1] PREEMPT SMP ARM
[  241.482904] Modules linked in: rfcomm cmac algif_hash ecb
algif_skcipher af_alg bnep wl18xx wlcore mac80211 cfg80211 libarc4
hci_uart bluetooth jc42 rfkill wlcore_sdio lm75 imx_sdma virt_dma
evdev leds_gpio pwm_beeper
[  241.502405] CPU: 0 PID: 157 Comm: kworker/u3:1 Not tainted
6.1.153-stable-standard #1
[  241.510255] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[  241.516449] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
[  241.523304] PC is at hci_conn_cleanup+0x74/0x220 [bluetooth]
[  241.530206] LR is at hci_conn_cleanup+0x28/0x220 [bluetooth]
[  241.537086] pc : [<7f049850>]    lr : [<7f049804>]    psr: 60010013
[  241.543370] sp : 90a21e58  ip : 00000000  fp : 7f0b0130
[  241.548608] r10: 7f0b9e80  r9 : 83c01140  r8 : 7f0b5e48
[  241.553846] r7 : 81db2000  r6 : 81b9fac0  r5 : 81b9f800  r4 : 81b9fac0
[  241.560388] r3 : 00000122  r2 : 81db2a44  r1 : 81b9fa94  r0 : 81b9fac0
[  241.566931] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  241.574086] Control: 10c5387d  Table: 81c1806a  DAC: 00000051
[  241.579846] Register r0 information: slab kmalloc-2k start 81b9f800
pointer offset 704 size 2048
[  241.588690] Register r1 information: slab kmalloc-2k start 81b9f800
pointer offset 660 size 2048
[  241.597524] Register r2 information: slab kmalloc-8k start 81db2000
pointer offset 2628 size 8192
[  241.606442] Register r3 information: non-paged memory
[  241.611515] Register r4 information: slab kmalloc-2k start 81b9f800
pointer offset 704 size 2048
[  241.620350] Register r5 information: slab kmalloc-2k start 81b9f800
pointer offset 0 size 2048
[  241.629005] Register r6 information: slab kmalloc-2k start 81b9f800
pointer offset 704 size 2048
[  241.637835] Register r7 information: slab kmalloc-8k start 81db2000
pointer offset 0 size 8192
[  241.646490] Register r8 information: 175-page vmalloc region
starting at 0x7f03c000 allocated at move_module+0x14/0x17c
[  241.657324] Register r9 information: slab task_struct start
83c01140 pointer offset 0
[  241.665195] Register r10 information: 175-page vmalloc region
starting at 0x7f03c000 allocated at move_module+0x14/0x17c
[  241.676100] Register r11 information: 175-page vmalloc region
starting at 0x7f03c000 allocated at move_module+0x14/0x17c
[  241.687004] Register r12 information: NULL pointer
[  241.691815] Process kworker/u3:1 (pid: 157, stack limit = 0x1a29d5de)
[  241.698276] Stack: (0x90a21e58 to 0x90a22000)
[  241.702654] 1e40:
    81b9f800 7f0b5e48
[  241.710852] 1e60: 81db2000 00000002 00000001 7f049bfc 7f0b0130
7f04a1e8 81b9f800 81b9f800
[  241.719050] 1e80: 81db2008 00000002 00000001 7f096264 00000005
000000c8 00000000 7f097f04
[  241.727247] 1ea0: 00010001 a0504415 00000000 a05044ec 83c01140
81db2000 83c01140 81db2a44
[  241.735445] 1ec0: 81db2a44 81db26c8 81db26d8 7f099008 8fdaa640
80f11d4c 81db2000 81f91040
[  241.743644] 1ee0: 81db289c a05044ec 81db26c8 81f91780 81db26e0
81db289c 81db2000 7f08ec68
[  241.751842] 1f00: 83c01140 7f0b0120 83c01800 81db26c8 81ac0a00
8186d800 81fb7b00 00000000
[  241.760041] 1f20: 00000060 81fb7b05 83c01140 8013ce44 8186d800
8186d800 8186d81c 81ac0a00
[  241.768240] 1f40: 8186d800 81ac0a18 8186d81c 80e03d40 00000088
83c01140 8186d800 8013d0a0
[  241.776439] 1f60: 80eff0ec 80f10b50 90a21f7c 81e35c00 83c01140
81e35b80 909b9eb4 8013d050
[  241.784638] 1f80: 81ac0a00 00000000 00000000 801445a8 81e35c00
801444cc 00000000 00000000
[  241.792836] 1fa0: 00000000 00000000 00000000 8010014c 00000000
00000000 00000000 00000000
[  241.801035] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  241.809233] 1fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[  241.817443]  hci_conn_cleanup [bluetooth] from
hci_conn_del+0x114/0x23c [bluetooth]
[  241.827573]  hci_conn_del [bluetooth] from
hci_abort_conn_sync+0x188/0x2bc [bluetooth]
[  241.837911]  hci_abort_conn_sync [bluetooth] from
hci_set_powered_sync+0xe4/0x140 [bluetooth]
[  241.848846]  hci_set_powered_sync [bluetooth] from
hci_cmd_sync_work+0xac/0x148 [bluetooth]
[  241.859627]  hci_cmd_sync_work [bluetooth] from process_one_work+0x1c4/0x3d0
[  241.867966]  process_one_work from worker_thread+0x50/0x50c
[  241.873594]  worker_thread from kthread+0xdc/0xf8
[  241.878347]  kthread from ret_from_fork+0x14/0x28
[  241.883086] Exception stack(0x90a21fb0 to 0x90a21ff8)
[  241.888159] 1fa0:                                     00000000
00000000 00000000 00000000
[  241.896357] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  241.904552] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  241.911189] Code: e5944000 1afffffa e1c520d0 e5823004 (e5832000)
[  241.941678] ---[ end trace 0000000000000000 ]---
