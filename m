Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C7EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 19:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGKTsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 15:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGKTsi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 15:48:38 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A819B
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 12:48:36 -0700 (PDT)
Date:   Tue, 11 Jul 2023 19:48:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689104912; x=1689364112;
        bh=UtbX2fcz6zcrkGUMo3JxLMlm4CZ38OCGkW8b/LsPjMw=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=f/ROHUSO0WjOK7tE8M2B3Upx5iEjFyJqrcRjy4srdPn6yvRhZeL/hX6rKwen59R7K
         TfHxYnSDovMtRSndxjkQpyoIeLFXbcGTFsAcZGCTSvovygn/LCMWoDJbPgX2RuEFjC
         GSzUoxx1PJEPSx1hAuKrCRCZ2Pli57ANLgpFxeSSOPgKLASC0m01WFLQmMFBOqfFgU
         jKMQkFpkf5mjtqvz6uM85LY7BcL5t1pZLrY0wcMkoe1dpfHXz9q5084dM7f8IAYhVQ
         cfqIro8U2DqpdMAkVH+gzVKF0JP4YqbZ8VyZ9d9z7/N7i0az6woaExeT5CD1Hj81s9
         VnvDC6Q4JZCKw==
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pauli Virtanen <pav@iki.fi>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: kernel NULL pointer dereference in hci_send_sco()
Message-ID: <K1uGCKZsw3ZP_ygn9btfq5S3EUFCmo0bye7Ew5PG54tNa7_DOiGQ1B3lchlJf_AEZeICj7lGaeSY2tCIJXvgjQOEz0rzD8uoSBw4Ir-Gisc=@protonmail.com>
In-Reply-To: <HwByr9Ffw_HVVE5pnMu6CTIrQjKwBJpJcSskM0xOP0S-4XiIdmGFTLYAcgKJsOkrxt62je88hFJ1vkHzYtCgwsEATe0KFq3E4YX8LeN5Fdo=@protonmail.com>
References: <HwByr9Ffw_HVVE5pnMu6CTIrQjKwBJpJcSskM0xOP0S-4XiIdmGFTLYAcgKJsOkrxt62je88hFJ1vkHzYtCgwsEATe0KFq3E4YX8LeN5Fdo=@protonmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi


I have hit this issue again, still the same kernel and everything.
The call stack appears to be the same.

But now there is a warning before the oops:

  Bluetooth: hci0: SCO packet for unknown connection handle 257

I am wondering if this could be relevant.


2023. j=C3=BAlius 9., vas=C3=A1rnap 15:57 keltez=C3=A9ssel, Barnab=C3=A1s P=
=C5=91cze =C3=ADrta:

> Hi
>=20
>=20
> while using a bluetooth headset with pipewire, I have run into the issue
> in the subject multiple times already.
>=20
> =09BUG: kernel NULL pointer dereference, address: 00000000000006a8
> =09#PF: supervisor read access in kernel mode
> =09#PF: error_code(0x0000) - not-present page
> =09PGD 0 P4D 0
> =09Oops: 0000 [#1] PREEMPT SMP PTI
> =09CPU: 6 PID: 3472 Comm: pipewire-media- Tainted: P           OE      6.=
4.2-3-MANJARO #1 b8b1fec9d2ca7e610dcda537ef3912d54df433f4
> =09Hardware name: SchenkerTechnologiesGmbH XMG FUSION 15 (XFU15L19)/LAPQC=
71A, BIOS QCCFL357.0120.2020.0813.1334 08/13/2020
> =09RIP: 0010:hci_send_sco+0x17/0xb0 [bluetooth]
> =09Code: f7 eb cf 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1=
f 00 0f 1f 44 00 00 41 56 49 89 fe 41 55 41 54 55 53 48 89 f3 <4c> 8b af a8=
 06 00 00 66 90 48 89 df be 03 00 00 00 45 0f b7 66 32
> =09RSP: 0018:ffffbdb60454fd38 EFLAGS: 00010216
> =09RAX: 0000000000000001 RBX: ffff964f52e2f200 RCX: 0000000000000000
> =09RDX: 0000000000000001 RSI: ffff964f52e2f200 RDI: 0000000000000000
> =09RBP: ffff96538383f800 R08: ffffbdb60454fbd0 R09: 0000000000000000
> =09R10: ffff9652bf1a8c80 R11: 0000000000000000 R12: ffff964f512a7680
> =09R13: ffffbdb60454fdf8 R14: 0000000000000000 R15: ffffbdb60454fde8
> =09FS:  00007f139fdff6c0(0000) GS:ffff965ebdb80000(0000) knlGS:0000000000=
000000
> =09CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> =09CR2: 00000000000006a8 CR3: 0000000113a0e004 CR4: 00000000003706e0
> =09Call Trace:
> =09<TASK>
> =09? __die+0x23/0x70
> =09? page_fault_oops+0x171/0x4e0
> =09? exc_page_fault+0x7f/0x180
> =09? asm_exc_page_fault+0x26/0x30
> =09? hci_send_sco+0x17/0xb0 [bluetooth 5eeccc5bad4c2f4e85d0f6a24ae9715b47=
202498]
> =09sco_sock_sendmsg+0x235/0x2e0 [bluetooth 5eeccc5bad4c2f4e85d0f6a24ae971=
5b47202498]
> =09sock_sendmsg+0x93/0xa0
> =09? sockfd_lookup_light+0x12/0x70
> =09__sys_sendto+0x120/0x170
> =09__x64_sys_sendto+0x24/0x30
> =09do_syscall_64+0x5d/0x90
> =09? exc_page_fault+0x7f/0x180
> =09entry_SYSCALL_64_after_hwframe+0x72/0xdc
> =09RIP: 0033:0x7f13a4b22dfc
> =09Code: 89 4c 24 1c e8 f5 69 f7 ff 44 8b 54 24 1c 8b 3c 24 45 31 c9 89 c=
5 48 8b 54 24 10 48 8b 74 24 08 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0=
 ff ff 77 34 89 ef 48 89 04 24 e8 41 6a f7 ff 48 8b 04
> =09RSP: 002b:00007f139fdfd690 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> =09RAX: ffffffffffffffda RBX: 000000000000003c RCX: 00007f13a4b22dfc
> =09RDX: 000000000000003c RSI: 000061500029bb00 RDI: 0000000000000041
> =09RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> =09R10: 0000000000004040 R11: 0000000000000246 R12: 000061500029bb00
> =09R13: 0000617000012d80 R14: 00000fe273d83b20 R15: 000000000000003c
> =09</TASK>
> =09Modules linked in: uinput nvidia_uvm(POE) rfcomm snd_seq_dummy snd_hrt=
imer snd_seq snd_seq_device nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE)=
 hid_ite8291r3(OE) qc71_laptop(OE) ccm cmac algif_hash algif_skcipher af_al=
g bnep snd_sof_pci_intel_cnl snd_sof_intel_hda_common soundwire_intel sound=
wire_cadence snd_sof_intel_hda_mlink snd_sof_intel_hda snd_sof_pci snd_sof_=
xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_ext_core snd_soc_=
acpi_intel_match snd_soc_acpi soundwire_generic_allocation soundwire_bus uc=
si_ccg snd_soc_core typec_ucsi snd_compress typec ac97_bus roles snd_pcm_dm=
aengine btusb uvcvideo videobuf2_vmalloc btrtl uvc videobuf2_memops btbcm v=
ideobuf2_v4l2 btintel videodev btmtk videobuf2_common mc bluetooth ecdh_gen=
eric intel_rapl_msr intel_rapl_common intel_tcc_cooling x86_pkg_temp_therma=
l intel_powerclamp coretemp snd_hda_codec_hdmi kvm_intel iwlmvm snd_hda_cod=
ec_realtek kvm snd_hda_codec_generic irqbypass joydev mac80211 crct10dif_pc=
lmul vfat crc32_pclmul mousedev snd_hda_intel
> =09polyval_clmulni fat polyval_generic libarc4 snd_intel_dspcfg gf128mul =
snd_intel_sdw_acpi ghash_clmulni_intel sha512_ssse3 snd_hda_codec aesni_int=
el iwlwifi crypto_simd snd_hda_core cryptd iTCO_wdt 8250_dw asus_wmi snd_hw=
dep hid_multitouch rapl ledtrig_audio intel_pmc_bxt mei_pxp mei_hdcp ee1004=
 iTCO_vendor_support intel_cstate snd_pcm spi_nor sparse_keymap cfg80211 in=
tel_uncore platform_profile snd_timer intel_wmi_thunderbolt wmi_bmof mei_me=
 intel_lpss_pci r8168(OE) mtd pcspkr snd thunderbolt mei intel_lpss i2c_i80=
1 i2c_hid_acpi rfkill i2c_nvidia_gpu intel_pch_thermal soundcore i2c_smbus =
idma64 i2c_hid acpi_pad acpi_tad mac_hid dm_multipath vboxnetflt(OE) vboxne=
tadp(OE) vboxdrv(OE) crypto_user acpi_call(OE) fuse loop dm_mod bpf_preload=
 ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 uas usbhid usb_s=
torage i915 serio_raw atkbd i2c_algo_bit drm_buddy libps2 intel_gtt vivaldi=
_fmap nvme drm_display_helper mxm_wmi nvme_core crc32c_intel spi_intel_pci =
cec xhci_pci spi_intel nvme_common ttm
> =09xhci_pci_renesas i8042 serio video wmi
> =09CR2: 00000000000006a8
> =09---[ end trace 0000000000000000 ]---
> =09RIP: 0010:hci_send_sco+0x17/0xb0 [bluetooth]
> =09Code: f7 eb cf 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1=
f 00 0f 1f 44 00 00 41 56 49 89 fe 41 55 41 54 55 53 48 89 f3 <4c> 8b af a8=
 06 00 00 66 90 48 89 df be 03 00 00 00 45 0f b7 66 32
> =09RSP: 0018:ffffbdb60454fd38 EFLAGS: 00010216
> =09RAX: 0000000000000001 RBX: ffff964f52e2f200 RCX: 0000000000000000
> =09RDX: 0000000000000001 RSI: ffff964f52e2f200 RDI: 0000000000000000
> =09RBP: ffff96538383f800 R08: ffffbdb60454fbd0 R09: 0000000000000000
> =09R10: ffff9652bf1a8c80 R11: 0000000000000000 R12: ffff964f512a7680
> =09R13: ffffbdb60454fdf8 R14: 0000000000000000 R15: ffffbdb60454fde8
> =09FS:  00007f139fdff6c0(0000) GS:ffff965ebdb80000(0000) knlGS:0000000000=
000000
> =09CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> =09CR2: 00000000000006a8 CR3: 0000000113a0e004 CR4: 00000000003706e0
> =09note: pipewire-media-[3472] exited with irqs disabled
>=20
> Here is the disassembly:
>=20
> =090000000000009fd0 <hci_send_sco>:
> =099fd0:       f3 0f 1e fa             endbr64
> =099fd4:       e8 00 00 00 00          call   9fd9 <hci_send_sco+0x9>
> =09=09=09=099fd5: R_X86_64_PLT32    __fentry__-0x4
> =099fd9:       41 56                   push   r14
> =099fdb:       49 89 fe                mov    r14,rdi
> =099fde:       41 55                   push   r13
> =099fe0:       41 54                   push   r12
> =099fe2:       55                      push   rbp
> =099fe3:       53                      push   rbx
> =099fe4:       48 89 f3                mov    rbx,rsi
> =099fe7:       4c 8b af a8 06 00 00    mov    r13,QWORD PTR [rdi+0x6a8]
> =099fee:       66 90                   xchg   ax,ax
> =099ff0:       48 89 df                mov    rdi,rbx
> =099ff3:       be 03 00 00 00          mov    esi,0x3
> =099ff8:       45 0f b7 66 32          movzx  r12d,WORD PTR [r14+0x32]
> =099ffd:       8b 6b 70                mov    ebp,DWORD PTR [rbx+0x70]
> =09a000:       e8 00 00 00 00          call   a005 <hci_send_sco+0x35>
> =09=09=09=09a001: R_X86_64_PLT32    skb_push-0x4
>=20
> The offending instruction appears to be the mov at 0x9fe7. Based on the s=
ource code:
>=20
> =09void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
> =09{
> =09=09struct hci_dev *hdev =3D conn->hdev;
> =09=09struct hci_sco_hdr hdr;
>=20
> =09=09BT_DBG("%s len %d", hdev->name, skb->len);
>=20
> =09=09hdr.handle =3D cpu_to_le16(conn->handle);
> =09=09hdr.dlen   =3D skb->len;
>=20
> =09=09skb_push(skb, HCI_SCO_HDR_SIZE);
>=20
> The offending part appears to be `conn->hdev`. It looks like `conn` is NU=
LL.
>=20
> I have spent some time looking at the code and it looks like `__sco_sock_=
close()` is the only
> place where `conn->hconn` is set to NULL, but that also sets `sk_state` t=
o `BT_DISCONN`, so I
> don't quite see how `sco_sock_sendmsg()` can then go ahead and call `sco_=
send_frame()` because
> of the the following check:
>=20
> =09if (sk->sk_state =3D=3D BT_CONNECTED)
> =09=09err =3D sco_send_frame(sk, skb);
> =09else
> =09=09err =3D -ENOTCONN;
>=20
> It is entirely possible that I am missing some part of the logic, so I ma=
y be completely wrong.
> In any case, thank you for your help in advance.
>=20
>=20
> Regards,
> Barnab=C3=A1s P=C5=91cze
