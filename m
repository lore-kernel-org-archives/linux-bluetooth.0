Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B3FEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 20:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGKUOD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjGKUOC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 16:14:02 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4FA12F
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 13:14:00 -0700 (PDT)
Received: from [192.168.1.195] (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4R0sX422DBz49Q8Y;
        Tue, 11 Jul 2023 23:13:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1689106436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jP4Pj9ifW2Z0+9LYsuaP9eRY6L9W/q2Cuhn+LwJNxAI=;
        b=YguzlBQdPJdzX+h6n9uL0VWiWsLphwAq6Z9nJWzdX0zyysnONw/8fYz+bLRQgUox/kBWC5
        7VDf6WSU3IEDrmJWq1QuGr02GFYUNMUhha5MmL5hHtx6FSehpQjzeHF8a8Y8lt5/yAIIBZ
        Rb6+/LpHA/9sqGkf2HzCwNnGwCmMZMI82yXgG3ajSDHhXrOHd1FTFy2mBxFtQLXsaXjXDy
        gWHNxliyCFRzJr4mZ0zguxRIcBTBCqK0y4ciWuPxGJd+F66bzYKN3BWH6rMEG62IhfiMby
        ONLpPIz2Js8HA6gF5USo4ahtbSOf2ep2LqMwoqXOXELfl866WMS36qBMLAccdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1689106436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jP4Pj9ifW2Z0+9LYsuaP9eRY6L9W/q2Cuhn+LwJNxAI=;
        b=R9hrS2/cBCFVsrlcKXYHeToipAizKsLN5c4i7uAXZQrZtvEUEId/pykeqUwoOeRuaPofeK
        oehcnsGsWYS8Y9htvqtARKtvVcieW0aIDp5VBE8fLJOHTHZFQR788rM/YWyAyAdnZVJZ16
        mq9aY4GPaPEzQDlGzmYeY7UPp84UNf5R1evsdEvbrUDuBhO0TLmsBoSZHNJpduc7PC5B8V
        /Wo5YdtWOsaMHMGS/2Gpn/x+FabCtAlxKQ/3UBV0zpOrSEBMqH6Vfys+8GfcN3a+2uIKLX
        /O/5RGa3R4bbZgPNJX5a4IE7ZyraHV6mHfQEqme7Ky6M/H8Dje9ZG/JQf+vfSQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1689106436; a=rsa-sha256;
        cv=none;
        b=HrWuxMv+9Q/tUqBAwWMuSHq1a491XGwVUe4alZV5myLSfXN+fjLOUu7n4e2P6C+GjW5g70
        gTm+u9NLiA04Zx8Dr++64P8SIpg1A/GtbeEPK51F6xqeza1tXrfPl0nCILpZvlTWHp6uFV
        Wh4zh0nkN/EcqTWQgw3Wwg2OM6xIEh64dl021G8v3kYXEMoXLmmVUR0XTq8BxjBpu8zwzd
        T/uq32gye6H2201vnNEq209Na0PK3TC0JwCnIGCI30EZP2XXVdIQe86prqVn2to5/+FDkm
        xkW8MbVUTmLOIrljcKgs8AmOM/uit1BlyUpwmqx0fG5eeEfwrA3i/AYNlqilWg==
Message-ID: <eb5a46bb08053fc2c6108f0fe45e00fa0b0692d7.camel@iki.fi>
Subject: Re: kernel NULL pointer dereference in hci_send_sco()
From:   Pauli Virtanen <pav@iki.fi>
To:     =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 11 Jul 2023 23:13:56 +0300
In-Reply-To: <K1uGCKZsw3ZP_ygn9btfq5S3EUFCmo0bye7Ew5PG54tNa7_DOiGQ1B3lchlJf_AEZeICj7lGaeSY2tCIJXvgjQOEz0rzD8uoSBw4Ir-Gisc=@protonmail.com>
References: <HwByr9Ffw_HVVE5pnMu6CTIrQjKwBJpJcSskM0xOP0S-4XiIdmGFTLYAcgKJsOkrxt62je88hFJ1vkHzYtCgwsEATe0KFq3E4YX8LeN5Fdo=@protonmail.com>
         <K1uGCKZsw3ZP_ygn9btfq5S3EUFCmo0bye7Ew5PG54tNa7_DOiGQ1B3lchlJf_AEZeICj7lGaeSY2tCIJXvgjQOEz0rzD8uoSBw4Ir-Gisc=@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

ti, 2023-07-11 kello 19:48 +0000, Barnab=C3=A1s P=C5=91cze kirjoitti:
> Hi
>=20
>=20
> I have hit this issue again, still the same kernel and everything.
> The call stack appears to be the same.
>=20
> But now there is a warning before the oops:
>=20
>   Bluetooth: hci0: SCO packet for unknown connection handle 257
>=20
> I am wondering if this could be relevant.

Those generally should be harmless, as the hci_conn may be destroyed
earlier than when controller stops sending SCO packets for it.

It's not clear those should be printed as errors, same also for the
"corrupted SCO packet" messages which are also printed when the
hci_conn has been already destroyed.=C2=A0You get lots of that spam during
normal SCO operation.

For this crash, maybe you can try apply the following patches:

https://lore.kernel.org/linux-bluetooth/490b5c6a0e13047fd1bea42d3184b46623a=
dc359.1689003801.git.pav@iki.fi/

https://lore.kernel.org/linux-bluetooth/20230711131353.40500-1-code@siddh.m=
e/

Basically the ISO sockets had similar crashes before, which are now
fixed and SCO seems to need similar fixes.

>=20
>=20
> 2023. j=C3=BAlius 9., vas=C3=A1rnap 15:57 keltez=C3=A9ssel, Barnab=C3=A1s=
 P=C5=91cze =C3=ADrta:
>=20
> > Hi
> >=20
> >=20
> > while using a bluetooth headset with pipewire, I have run into the issu=
e
> > in the subject multiple times already.
> >=20
> > 	BUG: kernel NULL pointer dereference, address: 00000000000006a8
> > 	#PF: supervisor read access in kernel mode
> > 	#PF: error_code(0x0000) - not-present page
> > 	PGD 0 P4D 0
> > 	Oops: 0000 [#1] PREEMPT SMP PTI
> > 	CPU: 6 PID: 3472 Comm: pipewire-media- Tainted: P           OE      6.=
4.2-3-MANJARO #1 b8b1fec9d2ca7e610dcda537ef3912d54df433f4
> > 	Hardware name: SchenkerTechnologiesGmbH XMG FUSION 15 (XFU15L19)/LAPQC=
71A, BIOS QCCFL357.0120.2020.0813.1334 08/13/2020
> > 	RIP: 0010:hci_send_sco+0x17/0xb0 [bluetooth]
> > 	Code: f7 eb cf 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1=
f 00 0f 1f 44 00 00 41 56 49 89 fe 41 55 41 54 55 53 48 89 f3 <4c> 8b af a8=
 06 00 00 66 90 48 89 df be 03 00 00 00 45 0f b7 66 32
> > 	RSP: 0018:ffffbdb60454fd38 EFLAGS: 00010216
> > 	RAX: 0000000000000001 RBX: ffff964f52e2f200 RCX: 0000000000000000
> > 	RDX: 0000000000000001 RSI: ffff964f52e2f200 RDI: 0000000000000000
> > 	RBP: ffff96538383f800 R08: ffffbdb60454fbd0 R09: 0000000000000000
> > 	R10: ffff9652bf1a8c80 R11: 0000000000000000 R12: ffff964f512a7680
> > 	R13: ffffbdb60454fdf8 R14: 0000000000000000 R15: ffffbdb60454fde8
> > 	FS:  00007f139fdff6c0(0000) GS:ffff965ebdb80000(0000) knlGS:0000000000=
000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: 00000000000006a8 CR3: 0000000113a0e004 CR4: 00000000003706e0
> > 	Call Trace:
> > 	<TASK>
> > 	? __die+0x23/0x70
> > 	? page_fault_oops+0x171/0x4e0
> > 	? exc_page_fault+0x7f/0x180
> > 	? asm_exc_page_fault+0x26/0x30
> > 	? hci_send_sco+0x17/0xb0 [bluetooth 5eeccc5bad4c2f4e85d0f6a24ae9715b47=
202498]
> > 	sco_sock_sendmsg+0x235/0x2e0 [bluetooth 5eeccc5bad4c2f4e85d0f6a24ae971=
5b47202498]
> > 	sock_sendmsg+0x93/0xa0
> > 	? sockfd_lookup_light+0x12/0x70
> > 	__sys_sendto+0x120/0x170
> > 	__x64_sys_sendto+0x24/0x30
> > 	do_syscall_64+0x5d/0x90
> > 	? exc_page_fault+0x7f/0x180
> > 	entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > 	RIP: 0033:0x7f13a4b22dfc
> > 	Code: 89 4c 24 1c e8 f5 69 f7 ff 44 8b 54 24 1c 8b 3c 24 45 31 c9 89 c=
5 48 8b 54 24 10 48 8b 74 24 08 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0=
 ff ff 77 34 89 ef 48 89 04 24 e8 41 6a f7 ff 48 8b 04
> > 	RSP: 002b:00007f139fdfd690 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> > 	RAX: ffffffffffffffda RBX: 000000000000003c RCX: 00007f13a4b22dfc
> > 	RDX: 000000000000003c RSI: 000061500029bb00 RDI: 0000000000000041
> > 	RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > 	R10: 0000000000004040 R11: 0000000000000246 R12: 000061500029bb00
> > 	R13: 0000617000012d80 R14: 00000fe273d83b20 R15: 000000000000003c
> > 	</TASK>
> > 	Modules linked in: uinput nvidia_uvm(POE) rfcomm snd_seq_dummy snd_hrt=
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
> > 	polyval_clmulni fat polyval_generic libarc4 snd_intel_dspcfg gf128mul =
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
> > 	xhci_pci_renesas i8042 serio video wmi
> > 	CR2: 00000000000006a8
> > 	---[ end trace 0000000000000000 ]---
> > 	RIP: 0010:hci_send_sco+0x17/0xb0 [bluetooth]
> > 	Code: f7 eb cf 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1=
f 00 0f 1f 44 00 00 41 56 49 89 fe 41 55 41 54 55 53 48 89 f3 <4c> 8b af a8=
 06 00 00 66 90 48 89 df be 03 00 00 00 45 0f b7 66 32
> > 	RSP: 0018:ffffbdb60454fd38 EFLAGS: 00010216
> > 	RAX: 0000000000000001 RBX: ffff964f52e2f200 RCX: 0000000000000000
> > 	RDX: 0000000000000001 RSI: ffff964f52e2f200 RDI: 0000000000000000
> > 	RBP: ffff96538383f800 R08: ffffbdb60454fbd0 R09: 0000000000000000
> > 	R10: ffff9652bf1a8c80 R11: 0000000000000000 R12: ffff964f512a7680
> > 	R13: ffffbdb60454fdf8 R14: 0000000000000000 R15: ffffbdb60454fde8
> > 	FS:  00007f139fdff6c0(0000) GS:ffff965ebdb80000(0000) knlGS:0000000000=
000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: 00000000000006a8 CR3: 0000000113a0e004 CR4: 00000000003706e0
> > 	note: pipewire-media-[3472] exited with irqs disabled
> >=20
> > Here is the disassembly:
> >=20
> > 	0000000000009fd0 <hci_send_sco>:
> > 	9fd0:       f3 0f 1e fa             endbr64
> > 	9fd4:       e8 00 00 00 00          call   9fd9 <hci_send_sco+0x9>
> > 				9fd5: R_X86_64_PLT32    __fentry__-0x4
> > 	9fd9:       41 56                   push   r14
> > 	9fdb:       49 89 fe                mov    r14,rdi
> > 	9fde:       41 55                   push   r13
> > 	9fe0:       41 54                   push   r12
> > 	9fe2:       55                      push   rbp
> > 	9fe3:       53                      push   rbx
> > 	9fe4:       48 89 f3                mov    rbx,rsi
> > 	9fe7:       4c 8b af a8 06 00 00    mov    r13,QWORD PTR [rdi+0x6a8]
> > 	9fee:       66 90                   xchg   ax,ax
> > 	9ff0:       48 89 df                mov    rdi,rbx
> > 	9ff3:       be 03 00 00 00          mov    esi,0x3
> > 	9ff8:       45 0f b7 66 32          movzx  r12d,WORD PTR [r14+0x32]
> > 	9ffd:       8b 6b 70                mov    ebp,DWORD PTR [rbx+0x70]
> > 	a000:       e8 00 00 00 00          call   a005 <hci_send_sco+0x35>
> > 				a001: R_X86_64_PLT32    skb_push-0x4
> >=20
> > The offending instruction appears to be the mov at 0x9fe7. Based on the=
 source code:
> >=20
> > 	void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
> > 	{
> > 		struct hci_dev *hdev =3D conn->hdev;
> > 		struct hci_sco_hdr hdr;
> >=20
> > 		BT_DBG("%s len %d", hdev->name, skb->len);
> >=20
> > 		hdr.handle =3D cpu_to_le16(conn->handle);
> > 		hdr.dlen   =3D skb->len;
> >=20
> > 		skb_push(skb, HCI_SCO_HDR_SIZE);
> >=20
> > The offending part appears to be `conn->hdev`. It looks like `conn` is =
NULL.
> >=20
> > I have spent some time looking at the code and it looks like `__sco_soc=
k_close()` is the only
> > place where `conn->hconn` is set to NULL, but that also sets `sk_state`=
 to `BT_DISCONN`, so I
> > don't quite see how `sco_sock_sendmsg()` can then go ahead and call `sc=
o_send_frame()` because
> > of the the following check:
> >=20
> > 	if (sk->sk_state =3D=3D BT_CONNECTED)
> > 		err =3D sco_send_frame(sk, skb);
> > 	else
> > 		err =3D -ENOTCONN;
> >=20
> > It is entirely possible that I am missing some part of the logic, so I =
may be completely wrong.
> > In any case, thank you for your help in advance.
> >=20
> >=20
> > Regards,
> > Barnab=C3=A1s P=C5=91cze

--=20
Pauli Virtanen
