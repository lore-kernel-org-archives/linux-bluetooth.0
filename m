Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CBEC875E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 23:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjIGXNw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjIGXNv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 19:13:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E1CBD
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 16:13:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E222C433C9
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694128427;
        bh=fqtzpOwF01d9J5zGTxL2bsZ0fWi/0NNqv3VGCmSih2E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZLO0Ozh/q4YCb31dih2bpU4VAbkI53AgEvqtCc0nCKz7C42Bjg7ZSodK/XDBCLOlU
         +E1nzGw1zHF0Svt74m78dnQwrys9iLB0u5iEo7RSqlfqztGe/xLH7zK6lH9Kjj00hT
         AeAfb3lww0NWjHfpzflB48H4aWeT+XSTfFBu3J+brdl4gLYt7g1C/f695T8zcy6u7j
         pAbrZWD/Q1QVJppx3k0n2WG1UJv1DRiQrrEGrpxr9upTkCiedPFv7z6K9IGl2IvWkx
         vt5viArshVbP4AddiOJxjCxwNgKVg+E1knwdzBoYReYSE/rVQT8wmhRpdbtJmFYsly
         Soezx4zgV3+lQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 68FFDC4332E; Thu,  7 Sep 2023 23:13:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217870] ATS2851 chipset for Baseus BA07 Bluetooth does not
 connect, no bluetooth device connects, adapter does not turn on
Date:   Thu, 07 Sep 2023 23:13:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mg-tatangelo@hotmail.com.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217870-62941-lFsZQyhQkX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217870-62941@https.bugzilla.kernel.org/>
References: <bug-217870-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217870

--- Comment #2 from mg-tatangelo@hotmail.com.br (mg-tatangelo@hotmail.com.b=
r) ---
(In reply to Bagas Sanjaya from comment #1)
> (In reply to mg-tatangelo@hotmail.com.br from comment #0)
> > doesn't connect/bugs on linux, mainly on KDE, on KDE it doesn't even sh=
ow
> > that it's connected, on gnome it shows that the adapter is connected, b=
ut
> it
> > looks like it's plugged in and not plugged in at the same time, like, it
> > really, IT IS CONNECTED, but it appears that it is off, no device appea=
rs
> to
> > pair and when it appears (rare occasions), it keeps loading infinitely =
when
> > I click to make the connection, an interesting fact that happened and I
> will
> > leave it here as a help: when I I use a virtual machine with Linux, THE
> > SOUND CATCHES, the adapter picks up, I can hear what comes out of the
> > virtual machine, with the same headphones that I try to connect to the
> > bluetooth adapter and it does not go when Linux is my main OS, the only=
 The
> > thing that doesn't work is the phone, through the virtual machine, but =
the
> > sound comes out! so probably the chipset works, but it must be
> misconfigured
> > or have little/no support for the chipset and that's it, I hope you can
> help
> > me, hugs!
>=20
> Sorry but can you attach full dmesg output?

Sim, here it is or dmesg output:
pop-os@pop-os:~$ sudo dmesg
[    0.000000] Linux version 6.2.6-76060206-generic (jenkins@warp.pop-os.or=
g)
(x86_64-linux-gnu-gcc-12 (Ubuntu 12.1.0-2ubuntu1~22.04) 12.1.0, GNU ld (GNU
Binutils for Ubuntu) 2.38) #202303130630~1689015125~22.04~ab2190e SMP
PREEMPT_DYNAMIC Mon J
[    0.000000] Command line:
BOOT_IMAGE=3D/casper_pop-os_22.04_amd64_intel_debug_530/vmlinuz.efi boot=3D=
casper
live-media-path=3D/casper_pop-os_22.04_amd64_intel_debug_530 hostname=3Dpop=
-os
username=3Dpop-os noprompt ---
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai=20=20
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point
registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes,
using 'compacted' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[   20.833658] eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
*[   20.834110] Bluetooth: Core ver 2.22*
[   20.834129] NET: Registered PF_BLUETOOTH protocol family
[   20.834130] Bluetooth: HCI device and connection manager initialized
[   20.834135] Bluetooth: HCI socket layer initialized
[   20.834137] Bluetooth: L2CAP socket layer initialized
[   20.834140] Bluetooth: SCO socket layer initialized
[   20.834474] input: Eee PC WMI hotkeys as
/devices/platform/eeepc-wmi/input/input7
[   21.275057] usbcore: registered new interface driver btusb
[   21.275097] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[   21.354618] intel_rapl_common: Found RAPL domain package
[   21.354622] intel_rapl_common: Found RAPL domain core
*[   21.362014] Bluetooth: hci0: Opcode 0x204b failed: -56*
[   21.825364] snd_hda_intel 0000:07:00.1: enabling device (0000 -> 0002)
[   21.825481] snd_hda_intel 0000:07:00.1: Force to non-snoop mode
[   21.825525] snd_hda_intel 0000:09:00.4: enabling device (0000 -> 0002)
[   21.919378] snd_hda_intel 0000:07:00.1: bound 0000:07:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[   21.983424] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:03.1/0000:07:00.1/sound/card0/input8
[   21.983505] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:03.1/0000:07:00.1/sound/card0/input9
[   21.984066] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:03.1/0000:07:00.1/sound/card0/input10
[   21.984133] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:03.1/0000:07:00.1/sound/card0/input11
[   21.984243] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as
/devices/pci0000:00/0000:00:03.1/0000:07:00.1/sound/card0/input12
[   21.984345] input: HDA ATI HDMI HDMI/DP,pcm=3D11 as
/devices/pci0000:00/0000:00:03.1/0000:07:00.1/sound/card0/input13
[   22.116993] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC887-VD:
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[   22.116999] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[   22.117001] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1
(0x1b/0x0/0x0/0x0/0x0)
[   22.117002] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[   22.117003] snd_hda_codec_realtek hdaudioC1D0:    dig-out=3D0x11/0x0
[   22.117004] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   22.117005] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=3D0x19
[   22.117007] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=3D0x18
[   22.117008] snd_hda_codec_realtek hdaudioC1D0:      Line=3D0x1a
[   22.129878] input: HD-Audio Generic Front Mic as
/devices/pci0000:00/0000:00:08.1/0000:09:00.4/sound/card1/input14
[   22.129938] input: HD-Audio Generic Rear Mic as
/devices/pci0000:00/0000:00:08.1/0000:09:00.4/sound/card1/input15
[   22.129983] input: HD-Audio Generic Line as
/devices/pci0000:00/0000:00:08.1/0000:09:00.4/sound/card1/input16
[   22.130013] input: HD-Audio Generic Line Out as
/devices/pci0000:00/0000:00:08.1/0000:09:00.4/sound/card1/input17
[   22.130050] input: HD-Audio Generic Front Headphone as
/devices/pci0000:00/0000:00:08.1/0000:09:00.4/sound/card1/input18
[   25.163670] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   25.163675] Bluetooth: BNEP filters: protocol multicast
[   25.163678] Bluetooth: BNEP socket layer initialized
[   26.147876] zram: Added device: zram0
[   27.981373] zram0: detected capacity change from 0 to 32587776
[   28.056021] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[   28.101179] Dynamic Preempt: full
[   28.260140] r8169 0000:05:00.0 enp5s0: Link is Down
[   28.301326] Dynamic Preempt: full
[   28.353893] Adding 16293884k swap on /dev/zram0.  Priority:1000 extents:1
across:16293884k SSFS
[   31.206641] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow
control rx/tx
[   31.206657] IPv6: ADDRCONF(NETDEV_CHANGE): enp5s0: link becomes ready
[   91.608218] rfkill: input handler disabled
[   98.409533] EXT4-fs (sda1): VFS: Can't find ext4 filesystem
[   98.409645] EXT4-fs (sda1): VFS: Can't find ext4 filesystem
[   98.409739] EXT4-fs (sda1): VFS: Can't find ext4 filesystem
[   98.409834] Can't find a SQUASHFS superblock on sda1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
