Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196DBECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 12:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiH2MUe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiH2MUQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 08:20:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52422796BF
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 05:03:25 -0700 (PDT)
Received: from valentina ([120.152.148.125]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlbPO-1pB0Kk3mOg-00ijLy for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug
 2022 13:42:22 +0200
Date:   Mon, 29 Aug 2022 21:42:12 +1000
From:   Finn Rayment <finn@rayment.fr>
To:     linux-bluetooth@vger.kernel.org
Subject: PROBLEM: BT_RAM_CODE_MT7961_1_2_hdr.bin fails to load
Message-ID: <20220829114212.5baldggjhtqpz6eb@valentina>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:tmeuJGGdi4LeKA5ET2eTBbcFWd1FKjUUsrcb/Kj7VEZrigpMogA
 41WSTmSuGVhYfIIPQiEMGHcCBd6KcyCxtiCx7mMb/O9REPRG2Pza+YDS99DCp1eQJxoAzBJ
 fy+ByWm+NQSPKP+uNo9ksVXgtEIg7cffQ5sIvPV5dQJ5uYgCIEoB62c4STCUYk2nNuRjDQz
 59GQAwVI7yPyZYM2KWdiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kl980kgP8CM=:wuqvjNlNDzDivSCNG4GlIs
 xlrd4Wn94wlpUfCek05clQeosjaA7fY3Tt4KGnzTaCgR3Jtqn+vsM2/p1tFkhQG2vM4PAzOt7
 l7b58jmuQPYrwXQK6RKudrdDg7y0anUQX3WE+ZUDLxHF7oddofNrnrXhIx8Ios/q0YYAxsYmZ
 vWn+8929aqA/qO/d8sEdg0DlgzH7zETZhsCxo6KMfF0xkb109syDEFhaqFkEoXF+DRGtegIKa
 nZCBJnrL7JP+foTIFoU/hNt3HBiaXmivFR8bNR4Ke0xYJJCaGFh4fV5APDyZ1v76GT5X/b43l
 If0AeqX3KdH8HRU2t96ukVLivDQ5BpK4pPmfLxYxY0gzFs8UkQ18zGFjbK6suvSKty8O9hNx/
 NcIg0CAsma1bbRxjUtighLHx4owSPqJ9TFc1KIie2S5rQWOmN8CEglpMR1ldWx4LF/ypsylut
 tX/V2cJwNJ9loOKnZ7QGAR2o0JniB8wQltoLfyh0iATpnLNmRZc9pojpgtuGeX6ZprAh3LYU2
 ILWlNXnesr1IcNka82oRBGuAOpkqH/Gj9do+lqN+yo/6+OYTH3HyokNZNtFX03EzB11r/PR25
 gCA4ME9gAR0o9lYSxC3tpTOO1NWgFiqgNfjXYhVvl8eRGoDrU4D5davimcA32nAewEv7OS9W0
 S9h+l0iiZk3DGEe2U9nIAe5P3UVeY1revIoVCTm/u49xM3oz9c42uHqujfHHE2MavAVpBDEMv
 dYR8zyQxOGb5iV22eKKFTSf/9CsxwfxYSsIaDQ==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When booting linux from kernels 5.15.41, 5.15.52, 5.18.12 and 5.19.4 (so I
assume everything in between as well), the following message is displayed and
bluetooth is not loaded:

```
[    2.415827] usb 5-4: New USB device found, idVendor=0489, idProduct=e0cd, bcdDevice= 1.00
[    2.415833] usb 5-4: New USB device strings: Mfr=5, Product=6, SerialNumber=7
[    2.415835] usb 5-4: Product: Wireless_Device
[    2.415837] usb 5-4: Manufacturer: MediaTek Inc.
[    2.415838] usb 5-4: SerialNumber: 000000000
[    2.436349] Loading firmware: mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
[    2.436378] bluetooth hci0: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin failed with error -2
[    2.436384] Bluetooth: hci0: Failed to load firmware file (-2)
[    2.436387] Bluetooth: hci0: Failed to set up firmware (-2)
```

This results in a completely non-functional bluetooth, until a suspend/resume is
performed, in which case around 80% of the time, the module will successfully
load and bluetooth will work for the remainder of the session, until a second or
further suspend/resume occurs, where I have observed another failure on one
single occasion.

If a suspend/resume does not resolve the issue, I find that it will stay broken
on following suspend/resumes too. A reboot (not necessarily a shutdown,
but simply using /sbin/reboot) is normally enough to get out of this dead loop.

Kernel information:
	Linux version 5.19.4-gentoo-x86_64 (x86_64-pc-linux-gnu-gxx (Gentoo Hardened 11.3.0 p4) 11.3.0, GNU ld (Gentoo 2.38 p4) 2.38) #1 SMP PREEMPT_DYNAMIC Thu Aug 25 23:36:23 AEST 2022

I am running Linux on a Thinkpad L14 Gen 2 (AMD ver.) - the laptops DMI is
reported as follows:
```
[    0.000000] DMI: LENOVO 20X5004GAU/20X5004GAU, BIOS R1KET36W (1.21 ) 11/25/2021
```

and kernel arguments:
```
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.19.4-gentoo-x86_64 root=/dev/mapper/vg0-root ro zswap.enabled=1 zswap.compressor=lz4 dolvm crypt_root=UUID=xxxx_xxxx root_trim=yes
```

To trigger this problem, one must simply boot into Linux.

Output of 'ver_linux':

```
Linux valentina 5.19.4-gentoo-x86_64 #1 SMP PREEMPT_DYNAMIC Thu Aug 25 23:36:23 AEST 2022 x86_64 AMD Ryzen 7 PRO 5850U with Radeon Graphics AuthenticAMD GNU/Linux

GNU C               	11.3.0
GNU Make            	4.3
Binutils            	2.38
Util-linux          	2.37.4
Mount               	2.37.4
Module-init-tools   	29
E2fsprogs           	1.46.5
Bison               	3.8.2
Flex                	2.6.4
Linux C++ Library   	6.0.29
Dynamic linker (ldd)	2.35
Procps              	3.3.17
Net-tools           	2.10
Kbd                 	2.4.0
Console-tools       	2.4.0
Sh-utils            	8.32
Udev                	250
Modules Loaded      	8021q amdgpu asn1_encoder backlight ccm ccp cec cfg80211 cqhci crc32_pclmul crc32c_intel crc64 crc64_rocksoft crct10dif_pclmul des_generic dm_crypt dm_mod drm drm_display_helper drm_kms_helper drm_ttm_helper edac_mce_amd efi_pstore efivarfs ext4 fb_sys_fops firmware_attributes_class garp ghash_clmulni_intel gpu_sched i2c_algo_bit i2c_designware_core i2c_designware_platform i2c_scmi iommu_v2 iosf_mbi ip6_tables ip6t_rt ip6table_filter ip_tables ipt_REJECT iptable_filter jbd2 k10temp libarc4 libcrc32c libdes mac80211 mbcache md4 mfd_core mrp msr mt76 mt76_connac_lib mt7921_common mt7921e nf_conntrack nf_conntrack_broadcast nf_conntrack_ftp nf_conntrack_netbios_ns nf_defrag_ipv4 nf_defrag_ipv6 nf_log_syslog nf_nat nf_nat_ftp nf_reject_ipv4 nvme nvme_core nvram pkcs8_key_parser platform_profile rc_core roles sdhci sdhci_pci serio_raw sp5100_tco syscopyarea sysfillrect sysimgblt t10_pi think_lmi thinkpad_acpi trusted ttm typec_ucsi ucsi_acpi video wmi wmi_bmof xhci_hcd xhci_pci xhci_pci_renesas xt_LOG xt_addrtype xt_conntrack xt_hl xt_limit
```

I was hesitant to report this bug straight away as I saw there was some work
being done on MediaTek drivers recently, but after compiling 5.19.4 and trying
it for myself, the issue still persists.

-- 
Finn Rayment
