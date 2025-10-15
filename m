Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AA28850C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557837; cv=none; b=kUcpEahHV2cUGbDDGARZ6j5H9TCeB8I1PjKlH1rlSxDV63HHyJfayqT7IXRaFdmR0nWVEgE/emAAqg/ffUr3TfCnLD6D3wFJ5ewXzcCPWQZP1JDnkbg/KkmcMfmliR6k1lKvPJvfRMNOqMc+lmiEtJlClYeis9Ldlh9X6xcBcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557837; c=relaxed/simple;
	bh=36yhJNeaOkLAGrVr+fWbNPopqWrcXXKLdRiBm+6l4lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd8XoH3PXIFEYojhZKmh5yeD/c3VQDKSeJAR+clV70MP8kHhqJESONJqtksiLcwpPfRRJKGwKw+a90Z5Eed7CTMvyD1u7/AwKTtkL8QxgTJupjUrQ7HoFhbue/vze+zPXt7RNvHWCRdfOPqHQAYU29D9BVuaOzDzRWFZ6zdC/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN/5ljgo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN/5ljgo"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37612b15a53so73142861fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557834; x=1761162634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgC6QpXyg76kPHCmIFQM9z5PtHOM0yJ4JC/Nei67JGM=;
        b=UN/5ljgo9KQJSesBJIB4zwGsefu82e4oErC0mPnT2wYxCkbUQgR+/8x55SDJIynfC3
         5fmQ7Bddx4kVffNIH74HbWDv9nFNY9uI2lRWuo6rtqVWiGofYbuklWS93jw9pjP4DQ86
         kQPX/c3pUn86Ju3B9sN3cBRmMTF7R3f+REytOBqwif/z2FIp2G8Pyv3VD1+lguCU+vbQ
         Awqm3SPlPh++Voo70Q2vxvYMCRML1PbSEHPPpY9lPhD3JalwBBdpcwWRGe3jS1H9FJmD
         W+2+vSpGMeMsAuZhlkQ17gHAMfM4/qfeWHGMaUrCvJgGR8KnIrcLfls3FcoU3Xv334ZI
         Xj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557834; x=1761162634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgC6QpXyg76kPHCmIFQM9z5PtHOM0yJ4JC/Nei67JGM=;
        b=fQnFXB37fjE/VBix0A/9V7FC5GuT8PsQlTrpJjRvVw3dVHpgABb+HrgHndE4yKPcr+
         1O7UKg11Su7OoNQ9g4HQitDu9IQSP9a3MNHYSalN5a9oucJKZ0lL7nhBgcT9jVUwegup
         3teoF+suaprPi76fRFr/J0ZMF4q9BZysVNFVa7h3E6LCrW+O7ICsoU46dRRzLYYKR2eG
         Lk0qUhYIRxlMfvxQgwPKlV9ABuR7OuV3mXCHv8ZyFvG+iOUJ9yoWfjnxe05yE9fq/OZe
         5Ucuo3/RKWhSG35syYKkB+HOB1LtMNMgPqJrbHCiVTM8JnucrUMuJox9gvOcd95WYXmj
         XFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqdvXZYY5VGlUnB72gxq3NNz66weBWe2fBV2CpQTuVPWP6C6jTc2X2aYN/seIndjOCmvFU/YEig6hKSMBIsHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVa3d3889sjyTIDyTP5s3iUBsz1YnrZnazBkFtaXp7Zr+2DmR
	EG4EAbzxWHFFGqjHbvfUUUYm1m8pP5JqpuSrvNddzu03sz4pC7VQOcj5em6NgK8bm8dokDrWwDn
	2WdSqwp7Xx9Ja74W+gHWCPpQDqDP6cauY5WUBZQw=
X-Gm-Gg: ASbGncvV4WTWhoqC3JKd7cZ9rB919Y3+4fmSxeigGCwcCS2NdXNvnBXHzD5XL701iLH
	4Oir/ESNbqbJU5uBtO0BShZ0ZmaYNyBO/Spq9jsdfD7Ol+O2YCknlPs4qZozwsAyTVMtKOuAUAk
	GSsRRDe9ktvh9saPo6q28itx8hduggGS4pjxmBLKoS/9nXWw+Ytf15HR48gG6qbJaKEXuD8WJaW
	ZJt06cQ8nQIq29NuzXwUO5n
X-Google-Smtp-Source: AGHT+IHpvRkpZJyL54QhDJO62vZ2jObyIKQuCgnQaIFKf3wBmEgC1PFat0eUCAKlwWjd2FsUuOfueTjC2wYlx/kybiU=
X-Received: by 2002:a05:651c:2122:b0:372:8c3e:2641 with SMTP id
 38308e7fff4ca-37609d3db3bmr78051691fa.10.1760557833443; Wed, 15 Oct 2025
 12:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AQj25sJi6nHX+FO7D3eFPLi7_7LpBQfHW9qXQHH2nQsw@mail.gmail.com>
In-Reply-To: <CAOMZO5AQj25sJi6nHX+FO7D3eFPLi7_7LpBQfHW9qXQHH2nQsw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Oct 2025 15:50:21 -0400
X-Gm-Features: AS18NWDAeNxQxqnYrLxn0nftERFUxBUNM1A08X9npeSYQ-07zYHrnB7fshqshgE
Message-ID: <CABBYNZLfGVoTVcNTyVd2snYdebK0_S2Y3fdW0bNfNnYtz9JqaA@mail.gmail.com>
Subject: Re: Crash at hci_conn_cleanup() when bluetooth service is restarted
To: Fabio Estevam <festevam@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Wed, Oct 15, 2025 at 3:34=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi,
>
> I have two i.MX6UL boards populated with a TI WL1837 Bluetooth chip
> running kernel 6.1.153 (also tested with 6.1.155).
>
> The rfcomm connection is established:
>
> root@board_1~# rfcomm listen hci0 1
> Waiting for connection on channel 1
> Connection from C8:DF:84:4C:48:75 to /dev/rfcomm0
>
> root@board_2:~# rfcomm connet hci0 38:0B:3C:E6:FB:F2 1
> Connected /dev/rfcomm0 to 38:0B:3C:E6:FB:F2 on channel 1
> Press CTRL-C for hangup
>
> Force restarting of the Bluetooth service while the RFComm connection is =
active:
>
> ssh root@192.168.216.206 systemctl restart bluetooth.service & ssh
> root@192.168.216.244 systemctl restart bluetooth.service
>
> Then the following kernel crash happens (in most cases, not always):
>
> Does anyone have any suggestions?

Kernel version is a bit old, could you try to reproduce it with
something more recent?

> Thanks,
>
> Fabio Estevam
>
> Disconnected
> root@board_2:~# [  241.459378] 8<--- cut here ---
> [  241.462487] Unable to handle kernel NULL pointer dereference at
> virtual address 00000122
> [  241.473362] [00000122] *pgd=3D00000000
> [  241.477381] Internal error: Oops: 817 [#1] PREEMPT SMP ARM
> [  241.482904] Modules linked in: rfcomm cmac algif_hash ecb
> algif_skcipher af_alg bnep wl18xx wlcore mac80211 cfg80211 libarc4
> hci_uart bluetooth jc42 rfkill wlcore_sdio lm75 imx_sdma virt_dma
> evdev leds_gpio pwm_beeper
> [  241.502405] CPU: 0 PID: 157 Comm: kworker/u3:1 Not tainted
> 6.1.153-stable-standard #1
> [  241.510255] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [  241.516449] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> [  241.523304] PC is at hci_conn_cleanup+0x74/0x220 [bluetooth]
> [  241.530206] LR is at hci_conn_cleanup+0x28/0x220 [bluetooth]
> [  241.537086] pc : [<7f049850>]    lr : [<7f049804>]    psr: 60010013
> [  241.543370] sp : 90a21e58  ip : 00000000  fp : 7f0b0130
> [  241.548608] r10: 7f0b9e80  r9 : 83c01140  r8 : 7f0b5e48
> [  241.553846] r7 : 81db2000  r6 : 81b9fac0  r5 : 81b9f800  r4 : 81b9fac0
> [  241.560388] r3 : 00000122  r2 : 81db2a44  r1 : 81b9fa94  r0 : 81b9fac0
> [  241.566931] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [  241.574086] Control: 10c5387d  Table: 81c1806a  DAC: 00000051
> [  241.579846] Register r0 information: slab kmalloc-2k start 81b9f800
> pointer offset 704 size 2048
> [  241.588690] Register r1 information: slab kmalloc-2k start 81b9f800
> pointer offset 660 size 2048
> [  241.597524] Register r2 information: slab kmalloc-8k start 81db2000
> pointer offset 2628 size 8192
> [  241.606442] Register r3 information: non-paged memory
> [  241.611515] Register r4 information: slab kmalloc-2k start 81b9f800
> pointer offset 704 size 2048
> [  241.620350] Register r5 information: slab kmalloc-2k start 81b9f800
> pointer offset 0 size 2048
> [  241.629005] Register r6 information: slab kmalloc-2k start 81b9f800
> pointer offset 704 size 2048
> [  241.637835] Register r7 information: slab kmalloc-8k start 81db2000
> pointer offset 0 size 8192
> [  241.646490] Register r8 information: 175-page vmalloc region
> starting at 0x7f03c000 allocated at move_module+0x14/0x17c
> [  241.657324] Register r9 information: slab task_struct start
> 83c01140 pointer offset 0
> [  241.665195] Register r10 information: 175-page vmalloc region
> starting at 0x7f03c000 allocated at move_module+0x14/0x17c
> [  241.676100] Register r11 information: 175-page vmalloc region
> starting at 0x7f03c000 allocated at move_module+0x14/0x17c
> [  241.687004] Register r12 information: NULL pointer
> [  241.691815] Process kworker/u3:1 (pid: 157, stack limit =3D 0x1a29d5de=
)
> [  241.698276] Stack: (0x90a21e58 to 0x90a22000)
> [  241.702654] 1e40:
>     81b9f800 7f0b5e48
> [  241.710852] 1e60: 81db2000 00000002 00000001 7f049bfc 7f0b0130
> 7f04a1e8 81b9f800 81b9f800
> [  241.719050] 1e80: 81db2008 00000002 00000001 7f096264 00000005
> 000000c8 00000000 7f097f04
> [  241.727247] 1ea0: 00010001 a0504415 00000000 a05044ec 83c01140
> 81db2000 83c01140 81db2a44
> [  241.735445] 1ec0: 81db2a44 81db26c8 81db26d8 7f099008 8fdaa640
> 80f11d4c 81db2000 81f91040
> [  241.743644] 1ee0: 81db289c a05044ec 81db26c8 81f91780 81db26e0
> 81db289c 81db2000 7f08ec68
> [  241.751842] 1f00: 83c01140 7f0b0120 83c01800 81db26c8 81ac0a00
> 8186d800 81fb7b00 00000000
> [  241.760041] 1f20: 00000060 81fb7b05 83c01140 8013ce44 8186d800
> 8186d800 8186d81c 81ac0a00
> [  241.768240] 1f40: 8186d800 81ac0a18 8186d81c 80e03d40 00000088
> 83c01140 8186d800 8013d0a0
> [  241.776439] 1f60: 80eff0ec 80f10b50 90a21f7c 81e35c00 83c01140
> 81e35b80 909b9eb4 8013d050
> [  241.784638] 1f80: 81ac0a00 00000000 00000000 801445a8 81e35c00
> 801444cc 00000000 00000000
> [  241.792836] 1fa0: 00000000 00000000 00000000 8010014c 00000000
> 00000000 00000000 00000000
> [  241.801035] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [  241.809233] 1fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000 00000000 00000000
> [  241.817443]  hci_conn_cleanup [bluetooth] from
> hci_conn_del+0x114/0x23c [bluetooth]
> [  241.827573]  hci_conn_del [bluetooth] from
> hci_abort_conn_sync+0x188/0x2bc [bluetooth]
> [  241.837911]  hci_abort_conn_sync [bluetooth] from
> hci_set_powered_sync+0xe4/0x140 [bluetooth]
> [  241.848846]  hci_set_powered_sync [bluetooth] from
> hci_cmd_sync_work+0xac/0x148 [bluetooth]
> [  241.859627]  hci_cmd_sync_work [bluetooth] from process_one_work+0x1c4=
/0x3d0
> [  241.867966]  process_one_work from worker_thread+0x50/0x50c
> [  241.873594]  worker_thread from kthread+0xdc/0xf8
> [  241.878347]  kthread from ret_from_fork+0x14/0x28
> [  241.883086] Exception stack(0x90a21fb0 to 0x90a21ff8)
> [  241.888159] 1fa0:                                     00000000
> 00000000 00000000 00000000
> [  241.896357] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [  241.904552] 1fe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0
> [  241.911189] Code: e5944000 1afffffa e1c520d0 e5823004 (e5832000)
> [  241.941678] ---[ end trace 0000000000000000 ]---

Try passing these logs to scripts/decode_stacktrace.sh so it can
decode the line numbers, etc, it looks like a NULL pointer error but
needs to check what is the line number and the actual code that is
behind it.

--=20
Luiz Augusto von Dentz
