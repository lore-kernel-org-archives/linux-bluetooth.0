Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0005C0015E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Jul 2023 02:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjGWCJ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jul 2023 22:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWCJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jul 2023 22:09:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21AD11A
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jul 2023 19:09:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b4748fe4so18453415ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jul 2023 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690078195; x=1690682995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSeWXWWzUP2iutBUMp1BGFNaw97+seIOmNvMXu/DKAU=;
        b=iqOBaQOk0S1MPKPrdT6yrDjFxGDI8SJ4GrQXNoi/cEl21dUjQfnxnTxMMgIp+j7H1V
         JifFvz4eeJveoLSCOu2r48g77ep4g+qr6O9tjKHADTAofhI6CnxzldOmLlp3H/8TmTo/
         0Iiv7Cdky1CIUBrSiOJGrE1KpY6gAM4RqOxaU3bH+rwk9+OyUCefnYsOdWJ6vPMM2zDn
         q6e9oJ3GXhsAXpleB7/vQSMtkr76PoH0HZ0feoIbE8Sb0/5MzsA65IviIrMj6S+f4dcj
         iiaQK9B40HfUVJ+/INr+PpmlGRxqDgGUV3SQpZyF2rONOX1XxIFpiSGKACNNaMsojqO0
         WzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690078195; x=1690682995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSeWXWWzUP2iutBUMp1BGFNaw97+seIOmNvMXu/DKAU=;
        b=UCl9YCHn1wDZw01cdxp879R1k6L0wFbkXbY//3bsHUWQCNqZOop9Ca/SW0aJrsyMWC
         fTkXC1DzF/UsS2SfYzTkWG6SsbXGbFP8KOBexbbcrYmu1ASnezpAzsq5Tdw1SUweGoYW
         VksrktAwbtD27cq2STGF6ocvcY175Wk/1tqu+Z414ahBCAuPvjrJroWUD7hSAj8PCOCF
         3vK/+BGh3AEWK+9E+yf7/bDQCDXT3QDi4fBI61V2Uh7MvyJswlsFsOa8+XiAjQ7/HKKX
         IKdWhe7mdSZR3It5uxHD59Wc+bI248X4rhqJrXTdSr9rIuOIA4O86hIma6VBa7oK9mGh
         li3w==
X-Gm-Message-State: ABy/qLYKpNaDgkhUZjfi2oKxdo2+Ep72I1+jjrDiEbfXG29Z0gJGCxik
        iBnrVSzv021kAH9CZRH5mDIYpEwECt7r3A==
X-Google-Smtp-Source: APBJJlGVBhMKy4B2Hfimo7pjTp6oocRW1KneFrGuEkte8+vAQYXtu9vxrNgSdWEys1yGJ2Xy2LAVyA==
X-Received: by 2002:a17:902:ce84:b0:1b8:6b17:9093 with SMTP id f4-20020a170902ce8400b001b86b179093mr5204229plg.1.1690078195197;
        Sat, 22 Jul 2023 19:09:55 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902b20f00b001b7ffca7dbcsm547432plr.148.2023.07.22.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 19:09:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3EBE4819BF89; Sun, 23 Jul 2023 09:09:52 +0700 (WIB)
Date:   Sun, 23 Jul 2023 09:09:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Moh Oktavi Aziz Nugraha <moktavizzen@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        avisaziz123@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: ThinkPad T430 (BCM20702) Can't Detect Bluetooth Devices
 Starting from Kernel v6.1.0 Until Now v6.3.1
Message-ID: <ZLyL7+IOqRSysJrl@debian.me>
References: <CAHCNbp3ztCcp31JdVYuxy+s1qXaa+Zy74eGJmfPmyrx_6Wjhhw@mail.gmail.com>
 <ZK32l3yQEMdmttOG@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GD8D6lMHMafEJvgj"
Content-Disposition: inline
In-Reply-To: <ZK32l3yQEMdmttOG@debian.me>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--GD8D6lMHMafEJvgj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 07:40:55AM +0700, Bagas Sanjaya wrote:
> On Sat, May 06, 2023 at 06:33:48PM +0700, Moh Oktavi Aziz Nugraha wrote:
> > [1.] One line summary of the problem:
> > ThinkPad T430 (BCM20702) Can't Detect Bluetooth Devices Starting from
> > Kernel v6.1.0 Until Now v6.3.1
> >=20
> > [2.] Full description of the problem/report:
> > Last week I installed Ubuntu, but my bluetooth can't detect devices
> > when I use kernel 6.1 and above. My bluetooth was fine when I used
> > kernel 6.0 and before. I'm filing this bug on the kernel because when
> > I tested this bug on Fedora and Ubuntu, the same problem appeared when
> > I used kernel version 6.1 and above.
> > The workaround for version 6.1 and above is to run "hcitool scan" on
> > the terminal if I want to detect bluetooth devices.
> > There are similar problem in earlier kernel version, but it was fixed
> > according to this post https://askubuntu.com/a/1169415
> > Here is the video i made to reproduce the issue https://youtu.be/pHjOIA=
k90Zc
> > Here is the information about my Bluetooth card:
> > Bus 001 Device 007: ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0
> > [ThinkPad]
> > What I have tried:
> > - Installed Fedora 38 and then Install bluetooth firmware
> > https://github.com/winterheart/broadcom-bt-firmware, and then
> > downgrade bluez (bluetooth cant detect devices)
> > - Installed Fedora 37 (no problem, because the default kernel is 6.0)
> > - installed Ubuntu 23.04 and then  install bluetooth firmware
> > https://github.com/winterheart/broadcom-bt-firmware (bluetooth cant
> > detect devices)
> > - Installed Ubuntu 22.10 (no problem, because the default kernel is 5.1=
9)
> > - Installed Ubuntu 22.04 (no problem, because the default kernel is 5.1=
9)
> > - Go back to Ubuntu 23.04 and then try these kernel:
> > v5.15.110 (good)
> > v5.19.17 (good)
> > v6.0.12 (good)
> > v6.0.19 (good)
> > v6.1.27 (bad)
> > v6.2.14 (bad)
> > v6.3.1 (bad)
> > After trying all of that I came to conclusion that this bug is caused
> > by the kernel.
> > I want to try git bisect to find the commit that caused the regression
> > between kernel versions 6.0 and 6.1, but it might take me a while
> > since it=E2=80=99s my first time using it. Plus, I=E2=80=99ve got a bun=
ch of college
> > assignments to finish up this week, so I=E2=80=99m a bit strapped for t=
ime.
>=20
> Can you please perform bisection using git to find the culprit?
> See [1] for details.
>=20
> [1]: https://docs.kernel.org/admin-guide/bug-bisect.html
>=20
> >=20
> > [3.] Keywords (i.e., modules, networking, kernel):
> > bluetooth, networking, broadcom, bcm20702, thinkpad, t430
> >=20
> > [4.] Kernel information
> > [4.1.] Kernel version (from /proc/version):
> > Linux version 6.3.1-060301-generic (kernel@kathleen)
> > (x86_64-linux-gnu-gcc-12 (Ubuntu 12.2.0-17ubuntu1) 12.2.0, GNU ld (GNU
> > Binutils for Ubuntu) 2.40) #202304302031 SMP PREEMPT_DYNAMIC Mon May
> > 1 00:41:22 UTC 2023
> > [4.2.] Kernel .config file:
> > <attachment1-KernelConfig.txt>
> >=20
> > [5.] Most recent kernel version which did not have the bug:
> > 6.0.19
> >=20
> > [6.] Output of Oops.. message (if applicable) with symbolic
> > information resolved (see Documentation/admin-guide/bug-hunting.rst)
> > I can't find the Oops message when i use "journalctl | grep Oops"
> >=20
> > [7.] A small shell script or example program which triggers the
> > problem (if possible)
> > I cant write a shell script yet, but i have made a video to show the
> > trigger and how to reproduce the issue https://youtu.be/pHjOIAk90Zc
> >=20
> > [8.] Environment
> > [8.1.] Software (add the output of the ver_linux script here)
> > <attachment2-Software.txt>
> > [8.2.] Processor information (from /proc/cpuinfo):
> > <attachment3-Processor.txt>
> > [8.3.] Module information (from /proc/modules):
> > <attachment4-Module.txt>
> > [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iom=
em)
> > <attachment5-DriverHW.txt>
> > [8.5.] PCI information ('lspci -vvv' as root)
> > <attachment6-PCI.txt>
> > [8.6.] SCSI information (from /proc/scsi/scsi)
> > <attachment7-SCSI.txt>
> > [8.7.] Other information that might be relevant to the problem (please
> > look in /proc and include all information that you think to be
> > relevant):
> > <attachment9-lsusb.txt>
> >=20
> > [X.] Other notes, patches, fixes, workarounds:
> > The workaround for version 6.1 and above is to run "hcitool scan" on
> > the terminal if I want to detect bluetooth devices.
> >=20
> > NOTE:
> > I sent this email again because the first time i got a message
> > Content-Policy reject msg: The message contains HTML subpart,
> >     therefore we consider it SPAM or Outlook Virus.  TEXT/PLAIN is acce=
pted.!
>=20
> > ccm 20480 6 - Live 0x0000000000000000
> > rfcomm 98304 16 - Live 0x0000000000000000
> > vboxnetadp 28672 0 - Live 0x0000000000000000 (OE)
> > vboxnetflt 32768 0 - Live 0x0000000000000000 (OE)
> > xt_CHECKSUM 16384 1 - Live 0x0000000000000000
> > xt_MASQUERADE 20480 3 - Live 0x0000000000000000
> > xt_conntrack 16384 1 - Live 0x0000000000000000
> > snd_seq_dummy 16384 0 - Live 0x0000000000000000
> > snd_hrtimer 16384 1 - Live 0x0000000000000000
> > ipt_REJECT 16384 2 - Live 0x0000000000000000
> > nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000
> > xt_tcpudp 20480 9 - Live 0x0000000000000000
> > nft_compat 20480 16 - Live 0x0000000000000000
> > nft_chain_nat 16384 2 - Live 0x0000000000000000
> > nf_nat 61440 2 xt_MASQUERADE,nft_chain_nat, Live 0x0000000000000000
> > nf_conntrack 196608 3 xt_MASQUERADE,xt_conntrack,nf_nat, Live 0x0000000=
000000000
> > nf_defrag_ipv6 24576 1 nf_conntrack, Live 0x0000000000000000
> > nf_defrag_ipv4 16384 1 nf_conntrack, Live 0x0000000000000000
> > vboxdrv 688128 2 vboxnetadp,vboxnetflt, Live 0x0000000000000000 (OE)
> > nf_tables 348160 138 nft_compat,nft_chain_nat, Live 0x0000000000000000
> > libcrc32c 16384 3 nf_nat,nf_conntrack,nf_tables, Live 0x0000000000000000
> > nfnetlink 24576 2 nft_compat,nf_tables, Live 0x0000000000000000
> > cmac 16384 3 - Live 0x0000000000000000
> > algif_hash 20480 1 - Live 0x0000000000000000
> > algif_skcipher 16384 1 - Live 0x0000000000000000
> > af_alg 32768 6 algif_hash,algif_skcipher, Live 0x0000000000000000
> > bridge 413696 0 - Live 0x0000000000000000
> > stp 16384 1 bridge, Live 0x0000000000000000
> > llc 16384 2 bridge,stp, Live 0x0000000000000000
> > bnep 32768 2 - Live 0x0000000000000000
> > intel_rapl_msr 20480 0 - Live 0x0000000000000000
> > intel_rapl_common 40960 1 intel_rapl_msr, Live 0x0000000000000000
> > x86_pkg_temp_thermal 20480 0 - Live 0x0000000000000000
> > intel_powerclamp 24576 0 - Live 0x0000000000000000
> > snd_hda_codec_hdmi 94208 1 - Live 0x0000000000000000
> > coretemp 24576 0 - Live 0x0000000000000000
> > snd_ctl_led 24576 0 - Live 0x0000000000000000
> > btusb 69632 0 - Live 0x0000000000000000
> > btrtl 28672 1 btusb, Live 0x0000000000000000
> > kvm_intel 528384 0 - Live 0x0000000000000000
> > btbcm 28672 1 btusb, Live 0x0000000000000000
> > snd_hda_codec_realtek 192512 1 - Live 0x0000000000000000
> > btintel 53248 1 btusb, Live 0x0000000000000000
> > snd_hda_codec_generic 118784 1 snd_hda_codec_realtek, Live 0x0000000000=
000000
> > uvcvideo 139264 0 - Live 0x0000000000000000
> > btmtk 16384 1 btusb, Live 0x0000000000000000
> > snd_hda_intel 61440 1 - Live 0x0000000000000000
> > binfmt_misc 24576 1 - Live 0x0000000000000000
> > kvm 1347584 1 kvm_intel, Live 0x0000000000000000
> > videobuf2_vmalloc 20480 1 uvcvideo, Live 0x0000000000000000
> > snd_intel_dspcfg 36864 1 snd_hda_intel, Live 0x0000000000000000
> > bluetooth 1048576 46 rfcomm,bnep,btusb,btrtl,btbcm,btintel,btmtk, Live =
0x0000000000000000
> > snd_intel_sdw_acpi 20480 1 snd_intel_dspcfg, Live 0x0000000000000000
> > uvc 16384 1 uvcvideo, Live 0x0000000000000000
> > irqbypass 16384 1 kvm, Live 0x0000000000000000
> > iwldvm 348160 0 - Live 0x0000000000000000
> > videobuf2_memops 20480 1 videobuf2_vmalloc, Live 0x0000000000000000
> > crct10dif_pclmul 16384 1 - Live 0x0000000000000000
> > snd_hda_codec 204800 4 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda=
_codec_generic,snd_hda_intel, Live 0x0000000000000000
> > videobuf2_v4l2 36864 1 uvcvideo, Live 0x0000000000000000
> > polyval_clmulni 16384 0 - Live 0x0000000000000000
> > polyval_generic 16384 1 polyval_clmulni, Live 0x0000000000000000
> > ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
> > ecdh_generic 16384 2 bluetooth, Live 0x0000000000000000
> > nls_iso8859_1 16384 1 - Live 0x0000000000000000
> > mei_pxp 20480 0 - Live 0x0000000000000000
> > mei_hdcp 28672 0 - Live 0x0000000000000000
> > i915 3919872 37 - Live 0x0000000000000000
> > ecc 45056 1 ecdh_generic, Live 0x0000000000000000
> > sha512_ssse3 53248 0 - Live 0x0000000000000000
> > videodev 344064 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
> > snd_hda_core 139264 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_=
codec_generic,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
> > mac80211 1634304 1 iwldvm, Live 0x0000000000000000
> > aesni_intel 397312 8 - Live 0x0000000000000000
> > snd_hwdep 20480 1 snd_hda_codec, Live 0x0000000000000000
> > videobuf2_common 86016 4 uvcvideo,videobuf2_vmalloc,videobuf2_memops,vi=
deobuf2_v4l2, Live 0x0000000000000000
> > crypto_simd 20480 1 aesni_intel, Live 0x0000000000000000
> > snd_pcm 192512 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda=
_core, Live 0x0000000000000000
> > mc 86016 4 uvcvideo,videobuf2_v4l2,videodev,videobuf2_common, Live 0x00=
00000000000000
> > cryptd 28672 3 ghash_clmulni_intel,crypto_simd, Live 0x0000000000000000
> > snd_seq_midi 20480 0 - Live 0x0000000000000000
> > rapl 20480 0 - Live 0x0000000000000000
> > libarc4 16384 1 mac80211, Live 0x0000000000000000
> > snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
> > drm_buddy 20480 1 i915, Live 0x0000000000000000
> > ttm 102400 1 i915, Live 0x0000000000000000
> > snd_rawmidi 53248 1 snd_seq_midi, Live 0x0000000000000000
> > intel_cstate 24576 0 - Live 0x0000000000000000
> > drm_display_helper 217088 1 i915, Live 0x0000000000000000
> > iwlwifi 569344 1 iwldvm, Live 0x0000000000000000
> > thinkpad_acpi 159744 0 - Live 0x0000000000000000
> > snd_seq 94208 9 snd_seq_dummy,snd_seq_midi,snd_seq_midi_event, Live 0x0=
000000000000000
> > cec 94208 2 i915,drm_display_helper, Live 0x0000000000000000
> > nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
> > think_lmi 45056 0 - Live 0x0000000000000000
> > snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000=
000000000
> > rc_core 77824 1 cec, Live 0x0000000000000000
> > ledtrig_audio 16384 3 snd_ctl_led,snd_hda_codec_generic,thinkpad_acpi, =
Live 0x0000000000000000
> > mei_me 57344 2 - Live 0x0000000000000000
> > firmware_attributes_class 16384 1 think_lmi, Live 0x0000000000000000
> > at24 24576 0 - Live 0x0000000000000000
> > wmi_bmof 16384 0 - Live 0x0000000000000000
> > platform_profile 16384 1 thinkpad_acpi, Live 0x0000000000000000
> > snd_timer 49152 3 snd_hrtimer,snd_pcm,snd_seq, Live 0x0000000000000000
> > drm_kms_helper 258048 2 i915,drm_display_helper, Live 0x0000000000000000
> > cfg80211 1257472 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
> > snd 135168 17 snd_hda_codec_hdmi,snd_ctl_led,snd_hda_codec_realtek,snd_=
hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi=
,thinkpad_acpi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
> > i2c_algo_bit 20480 1 i915, Live 0x0000000000000000
> > mei 167936 5 mei_pxp,mei_hdcp,mei_me, Live 0x0000000000000000
> > syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
> > soundcore 16384 2 snd_ctl_led,snd, Live 0x0000000000000000
> > sysfillrect 20480 1 drm_kms_helper, Live 0x0000000000000000
> > sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
> > input_leds 16384 0 - Live 0x0000000000000000
> > joydev 32768 0 - Live 0x0000000000000000
> > mac_hid 16384 0 - Live 0x0000000000000000
> > serio_raw 20480 0 - Live 0x0000000000000000
> > msr 16384 0 - Live 0x0000000000000000
> > parport_pc 53248 0 - Live 0x0000000000000000
> > ppdev 24576 0 - Live 0x0000000000000000
> > lp 28672 0 - Live 0x0000000000000000
> > parport 73728 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> > drm 712704 17 i915,drm_buddy,ttm,drm_display_helper,thinkpad_acpi,drm_k=
ms_helper, Live 0x0000000000000000
> > efi_pstore 16384 0 - Live 0x0000000000000000
> > dmi_sysfs 24576 0 - Live 0x0000000000000000
> > ip_tables 36864 0 - Live 0x0000000000000000
> > x_tables 65536 7 xt_CHECKSUM,xt_MASQUERADE,xt_conntrack,ipt_REJECT,xt_t=
cpudp,nft_compat,ip_tables, Live 0x0000000000000000
> > autofs4 57344 2 - Live 0x0000000000000000
> > hid_logitech_hidpp 65536 0 - Live 0x0000000000000000
> > crc32_pclmul 16384 0 - Live 0x0000000000000000
> > psmouse 212992 0 - Live 0x0000000000000000
> > ahci 49152 2 - Live 0x0000000000000000
> > hid_logitech_dj 36864 0 - Live 0x0000000000000000
> > sdhci_pci 81920 0 - Live 0x0000000000000000
> > i2c_i801 40960 0 - Live 0x0000000000000000
> > cqhci 40960 1 sdhci_pci, Live 0x0000000000000000
> > libahci 57344 1 ahci, Live 0x0000000000000000
> > xhci_pci 24576 0 - Live 0x0000000000000000
> > i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
> > e1000e 352256 0 - Live 0x0000000000000000
> > sdhci 94208 1 sdhci_pci, Live 0x0000000000000000
> > lpc_ich 32768 0 - Live 0x0000000000000000
> > xhci_pci_renesas 20480 1 xhci_pci, Live 0x0000000000000000
> > video 73728 2 i915,thinkpad_acpi, Live 0x0000000000000000
> > wmi 40960 3 think_lmi,wmi_bmof,video, Live 0x0000000000000000
> > hid_generic 16384 0 - Live 0x0000000000000000
> > usbhid 77824 2 hid_logitech_hidpp,hid_logitech_dj, Live 0x0000000000000=
000
> > hid 176128 4 hid_logitech_hidpp,hid_logitech_dj,hid_generic,usbhid, Liv=
e 0x0000000000000000
>=20
> > 0000-0000 : PCI Bus 0000:00
> >   0000-0000 : dma1
> >   0000-0000 : pic1
> >   0000-0000 : timer0
> >   0000-0000 : timer1
> >   0000-0000 : keyboard
> >   0000-0000 : PNP0800:00
> >   0000-0000 : PNP0C09:00
> >     0000-0000 : EC data
> >   0000-0000 : keyboard
> >   0000-0000 : PNP0C09:00
> >     0000-0000 : EC cmd
> >   0000-0000 : rtc0
> >   0000-0000 : dma page reg
> >   0000-0000 : pic2
> >   0000-0000 : dma2
> >   0000-0000 : fpu
> >     0000-0000 : PNP0C04:00
> >   0000-0000 : pnp 00:01
> >     0000-0000 : ACPI PM1a_EVT_BLK
> >     0000-0000 : ACPI PM1a_CNT_BLK
> >     0000-0000 : ACPI PM_TMR
> >     0000-0000 : ACPI CPU throttle
> >     0000-0000 : ACPI GPE0_BLK
> >     0000-0000 : iTCO_wdt.1.auto
> >     0000-0000 : ACPI PM2_CNT_BLK
> >     0000-0000 : iTCO_wdt.1.auto
> >   0000-0000 : pnp 00:01
> >   0000-0000 : pnp 00:01
> > 0000-0000 : PCI conf1
> > 0000-0000 : PCI Bus 0000:00
> >   0000-0000 : pnp 00:01
> >   0000-0000 : pnp 00:01
> >   0000-0000 : PCI Bus 0000:04
> >   0000-0000 : PCI Bus 0000:02
> >   0000-0000 : 0000:00:02.0
> >   0000-0000 : 0000:00:1f.2
> >     0000-0000 : ahci
> >   0000-0000 : 0000:00:19.0
> >   0000-0000 : 0000:00:1f.2
> >     0000-0000 : ahci
> >   0000-0000 : 0000:00:1f.2
> >     0000-0000 : ahci
> >   0000-0000 : 0000:00:16.3
> >     0000-0000 : serial
> >   0000-0000 : 0000:00:1f.2
> >     0000-0000 : ahci
> >   0000-0000 : 0000:00:1f.2
> >     0000-0000 : ahci
> >   0000-0000 : 0000:00:1f.3
> >     0000-0000 : i801_smbus
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> >   00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> > 00000000-00000000 : PCI Bus 0000:00
> >   00000000-00000000 : 0000:00:02.0
> > 00000000-00000000 : System ROM
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : ACPI Non-volatile Storage
> > 00000000-00000000 : ACPI Tables
> > 00000000-00000000 : System RAM
> > 00000000-00000000 : Reserved
> >   00000000-00000000 : Graphics Stolen Memory
> > 00000000-00000000 : PCI Bus 0000:00
> >   00000000-00000000 : 0000:00:02.0
> >   00000000-00000000 : 0000:00:02.0
> >   00000000-00000000 : PCI Bus 0000:02
> >   00000000-00000000 : PCI Bus 0000:04
> >   00000000-00000000 : PCI Bus 0000:04
> >   00000000-00000000 : PCI Bus 0000:03
> >     00000000-00000000 : 0000:03:00.0
> >       00000000-00000000 : iwlwifi
> >   00000000-00000000 : PCI Bus 0000:02
> >     00000000-00000000 : 0000:02:00.0
> >       00000000-00000000 : mmc0
> >   00000000-00000000 : 0000:00:19.0
> >     00000000-00000000 : e1000e
> >   00000000-00000000 : 0000:00:14.0
> >     00000000-00000000 : xhci-hcd
> >   00000000-00000000 : 0000:00:1b.0
> >     00000000-00000000 : ICH HD audio
> >   00000000-00000000 : 0000:00:1f.3
> >   00000000-00000000 : 0000:00:16.0
> >     00000000-00000000 : mei_me
> >   00000000-00000000 : 0000:00:1f.2
> >     00000000-00000000 : ahci
> >   00000000-00000000 : 0000:00:1d.0
> >     00000000-00000000 : ehci_hcd
> >   00000000-00000000 : 0000:00:1a.0
> >     00000000-00000000 : ehci_hcd
> >   00000000-00000000 : 0000:00:19.0
> >     00000000-00000000 : e1000e
> >   00000000-00000000 : 0000:00:16.3
> >   00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
> >     00000000-00000000 : Reserved
> > 00000000-00000000 : IOAPIC 0
> > 00000000-00000000 : HPET 0
> >   00000000-00000000 : PNP0103:00
> > 00000000-00000000 : pnp 00:01
> > 00000000-00000000 : pnp 00:01
> > 00000000-00000000 : pnp 00:01
> > 00000000-00000000 : Reserved
> >   00000000-00000000 : pnp 00:01
> >     00000000-00000000 : iTCO_wdt.1.auto
> > 00000000-00000000 : PCI Bus 0000:00
> >   00000000-00000000 : 00:05 TPM
> >   00000000-00000000 : pnp 00:01
> > 00000000-00000000 : pnp 00:00
> >   00000000-00000000 : Local APIC
> >   00000000-00000000 : pnp 00:01
> > 00000000-00000000 : System RAM
> >   00000000-00000000 : Kernel code
> >   00000000-00000000 : Kernel rodata
> >   00000000-00000000 : Kernel data
> >   00000000-00000000 : Kernel bss
> > 00000000-00000000 : Reserved
> > 00000000-00000000 : RAM buffer
>=20
> No wonder why this regression is being ignored: the reporter didn't
> bisect (hence I asked above).
>=20
> To the reporter: Does this regression also occurs on latest mainline
> (currently v6.5-rc1)?
>=20

There is no update reply from Moh Oktavi (and indeed this regression
fall through cracks unnoticed by bluetooth people), thus to clean up:

#regzbot inconclusive: regression fall through cracks unnoticed, reporter M=
IA

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--GD8D6lMHMafEJvgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLyL6gAKCRD2uYlJVVFO
owH6AP99JDni/W46guGiUdOgy3P6nFBNwr7MF0Mt8CBXAkKkRAD/cRWmT2SbgSOQ
vF99N0Np6IiINFf+dR+oTvKuFdQd0A4=
=ARDC
-----END PGP SIGNATURE-----

--GD8D6lMHMafEJvgj--
