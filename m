Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C914C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jul 2021 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0278060E77
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jul 2021 13:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhGYMU0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGYMUZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Jul 2021 08:20:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D29C061757
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jul 2021 06:00:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hs23so11223879ejc.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jul 2021 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=nAK5MB9sPYqjlh5rpF65jiMMnujrBD48MVs/hKZOpxs=;
        b=SpKJxZr5Yofz5zOjE2m54wD4A/1F/gMripq+WP24V/nwrAYoRDmWdsoxgBGMuv0fnV
         B5UJvKWS7nx4oCkM02QY3rbNnynAyOfa0Kx3cEPjfgw+E9kiNxM9/ykeQAJ6J7Rbuczz
         3FccJSCgQxFodxYMaX5W8z03twIKYuyvrkbUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nAK5MB9sPYqjlh5rpF65jiMMnujrBD48MVs/hKZOpxs=;
        b=K8mR1jCZDc5ug6/rh3Caxy7yyp3vlk6n0xhcJWLalhwqbUFrgxkEKH1vsI34mjEXXg
         o7N3JviNimEDsuCllF8V/nZMAFXkapEDw+arqS7+ltyyR76bK/klMpBwM4Kji7biDr6y
         3vz7EMj7qtUAx1CkV4jjAFKEJch5/vPvsULsaILCtRv+3Mct9FdQTodEFwonUxeTrl9o
         /IVHpaccZI+u7X7XcLzDcqAF3CC/ZCfowyTvUKerTwKh/s6LC4nb9MDAfBnvbIr3CiAt
         rBCzrCQbG4tvMCjSU25WhbvHZ0XtmsYm6y+2vjlhLS4NIQKylV7BLCLXm8Lv8x3EWR9v
         mgGQ==
X-Gm-Message-State: AOAM532v73APFcwglBGn2VC1ZU8tTI9Sq07jSKMjg9tKqP54HWoPGOoZ
        n764rYJzPECRa+JC0VGvzb2DIgNaL9qKheAN5b1DTaiuPmJ21Q==
X-Google-Smtp-Source: ABdhPJx0fmlCU6+CsYeSWVr+dc2ScFidCBwlt9/+GwFxsf/0i/uohCYP6OBR9npBaFRYCXV/Ci75dGYGk1ISuL0/Gaw=
X-Received: by 2002:a17:906:7fd3:: with SMTP id r19mr3485080ejs.314.1627218052996;
 Sun, 25 Jul 2021 06:00:52 -0700 (PDT)
MIME-Version: 1.0
From:   Zhan Shu <zshu1@binghamton.edu>
Date:   Sun, 25 Jul 2021 09:00:40 -0400
Message-ID: <CALdsPdb7x1mmt2YjkWE-0+kAJ+37uJ2A=-NbSp0C9CSK-o4rfA@mail.gmail.com>
Subject: BlueTooth bug freeze target linux kernel system
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  We are working on fuzzing testing the target protocol security.
While fuzzing the BlueTooth L2CAP signal request we found that the
target system will freeze and the process 'bluetoothd' CPU usage
becomes fully used. No other process can run anymore. This bug can not
be reproduced by the same set of command sequences. So we can not
locate the problem in the code. But to reproduce the error we can do
the loop:
1. build a normal L2CAP socket connection.
2. send set of command to reach the specific state
'02:06:04:00:01:00:40:00','04:07:13:00:40:00:00:00:01:03:f5:03:04:09:8e:00:00:00:00:00:00:00:00','04:07:13:00:40:00:00:00:01:02:9d:03:04:09:ef:00:00:00:00:00:00:00:00'
3. Randomly fills the value into the options field of the CONFIG
request. And send the CONFIG request to the target.
4. Shut down the HCI connection directly.
5. go to step1 and do everything again.
This is not the only way to crash the target but fuzzing on other
states may take a longer time to crash the target. We send each
command every 0.7 seconds, and usually, the target will crash in half
an hour.
We tested this bug on 4.14, 4.15, and 5.43 three different kernels of
Linux. They all have the same problem.
We post the dmsg before it crash here:
[174611.980681] Modules linked in: rfcomm cmac xt_CHECKSUM
iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack
nf_conntrack libcrc32c ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp
llc pci_stub vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE)
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
devlink ccm bnep intel_rapl uvcvideo x86_pkg_temp_thermal
intel_powerclamp videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
videobuf2_core coretemp videodev crct10dif_pclmul crc32_pclmul
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic media
ghash_clmulni_intel snd_hda_intel snd_hda_codec rtsx_usb_ms memstick
snd_hda_core pcbc arc4 btusb snd_hwdep btrtl btbcm btintel aesni_intel
snd_pcm iwlmvm bluetooth
[174611.980707]  ecdh_generic aes_x86_64 mac80211 snd_seq_midi
snd_seq_midi_event dell_laptop dell_smm_hwmon crypto_simd glue_helper
snd_rawmidi iwlwifi cfg80211 snd_seq snd_seq_device cryptd
intel_cstate intel_rapl_perf joydev dell_wmi sparse_keymap input_leds
snd_timer serio_raw snd mei_me shpchp dell_smbios dcdbas
dell_wmi_descriptor wmi_bmof mei dell_rbtn soundcore lpc_ich acpi_pad
mac_hid kvm_intel binfmt_misc kvm irqbypass sch_fq_codel parport_pc
ppdev lp parport ip_tables x_tables autofs4 rtsx_usb_sdmmc rtsx_usb
i915 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
ahci psmouse libahci fb_sys_fops r8169 drm mii wmi video i2c_hid hid
[174611.980735] CPU: 0 PID: 916 Comm: bluetoothd Tainted: G        W
OE    4.15.0-72-generic #81-Ubuntu
[174611.980736] Hardware name: Dell Inc. Inspiron 5558/0V7MX2, BIOS
A02 03/09/2015
[174611.980743] RIP: 0010:bt_sock_poll+0x17a/0x1d0 [bluetooth]
[174611.980744] RSP: 0018:ffffb6ea41293a88 EFLAGS: 00010246
[174611.980746] RAX: fffffffffffffd38 RBX: ffff8c0c53bf0000 RCX:
0000000000000000
[174611.980747] RDX: 0000000000000000 RSI: ffff8c0c21941800 RDI:
0000000000000000
[174611.980748] RBP: ffffb6ea41293aa0 R08: ffff8c0c4b771d00 R09:
0000000000000466
[174611.980749] R10: 0000000000000000 R11: 00017c4f569e4e50 R12:
ffffb6ea41293c30
[174611.980749] R13: ffff8c0c4b771d00 R14: 0000000000000000 R15:
ffff8c0c4b771d00
[174611.980751] FS:  00007fafd6a797c0(0000) GS:ffff8c0c5f400000(0000)
knlGS:0000000000000000
[174611.980752] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[174611.980753] CR2: 0000000000000000 CR3: 0000000190dac004 CR4:
00000000003606f0
[174611.980754] Call Trace:
[174611.980758]  sock_poll+0x74/0x90
[174611.980761]  do_sys_poll+0x26f/0x580
[174611.980764]  ? __wake_up_sync_key+0x1e/0x30
[174611.980766]  ? sock_def_readable+0x40/0x70
[174611.980768]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980769]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980771]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980772]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980774]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980775]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980777]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980778]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980779]  ? compat_poll_select_copy_remaining+0x130/0x130
[174611.980781]  SyS_poll+0x30/0x130
[174611.980782]  ? SyS_poll+0x30/0x130
[174611.980785]  do_syscall_64+0x73/0x130
[174611.980787]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[174611.980789] RIP: 0033:0x7fafd5c27bc4
[174611.980789] RSP: 002b:00007ffe26f7aac8 EFLAGS: 00000246 ORIG_RAX:
0000000000000007
[174611.980791] RAX: ffffffffffffffda RBX: 000056363ed5bc90 RCX:
00007fafd5c27bc4
[174611.980792] RDX: 00000000ffffffff RSI: 000000000000001b RDI:
000056363ed77000
[174611.980793] RBP: 000000000000001b R08: 000000000000001b R09:
000056363ed78f10
[174611.980794] R10: 000056363ed5c8e0 R11: 0000000000000246 R12:
000056363ed77000
[174611.980794] R13: 00000000ffffffff R14: 00007fafd65b8f70 R15:
000000000000001b
[174611.980796] Code: 80 fa 01 75 11 eb 5e 0f b6 48 12 48 89 c6 48 89
d0 80 f9 01 74 4f 48 8b 93 e0 02 00 00 83 e2 01 74 09 0f b6 56 12 80
fa 06 74 3a <48> 8b b8 c8 02 00 00 48 39 c3 48 8d 97 38 fd ff ff 75 c9
5b 31
[174611.980822] RIP: bt_sock_poll+0x17a/0x1d0 [bluetooth] RSP: ffffb6ea41293a88
[174611.980823] CR2: 0000000000000000
Hope someone can figure it out.

Thanks,
Zhan
