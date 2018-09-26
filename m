Return-Path: <SRS0=Mlcw=MI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB133C43382
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A9121480
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 09:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J59katLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A9121480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeIZQKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:10:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34855 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZQKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Sep 2018 12:10:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id r191-v6so10164125lff.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Sep 2018 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQbu6RFiMFa/lcV4uaxUfxtEpm+63RDrUFGSRm40O7A=;
        b=J59katLEKz4XJBhFh7F+Y/BLml2vScvnWhWKyhG7zUQ36n4v2zrA4M6frQdRwTfcnV
         XLFN7gXEYy6/sDMrv1waFH5GcOrQTb32PhZrV7h4skfS/Bw0xX9HAVue2iFNgzw2EGYl
         qOb7yu8wrWGQkG8A7RsXY4jo/Nj2EbTYMrw5EdKMypvkY0Fx8Q0X4HtBY9MviOXG2GGZ
         zlifRy/pyVnQFYBUXgOMxbv8kS8h1O1BEvlnSCPbOhpL7c3CKcAceOc9M3MvkJc97lhy
         3+mzBCBdWAlYuKdoksLzVdDtYPmLcpPi5SeNGKLZSdtjTMFnNi/lxQ/vOBO/dTIj5I9J
         NOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yQbu6RFiMFa/lcV4uaxUfxtEpm+63RDrUFGSRm40O7A=;
        b=HCV5gwJ8jdRC7AdgmZnpOePSJ4c4jK2MeoZomSmpi+N+AlV7QZjl664wgMumLpyHf1
         AGAE+ivrApIR4epQnILwkoYLlEeNXbBy3C/x1spZHi9MnVvIfDRdr/+MyU+5EUKqmxD2
         mx1mk6D0da8Jifv70b1cfUCWmhFfx3npHr/xixDcHREP0W8p29VV/HE6Nes1qrnwbDyk
         mMtyQIj3V3AVVtQyfbRorPAlroDDJa9R3CG3KEgQ+UM1cu5E6qjC+rUqZDEs7285mzib
         DE6HT8go2ijy25VxVqJ+S9yJPok0JAvGlC4QS0KvL+bndouN0b7KkMBNYYC69NoNhkEF
         RA0w==
X-Gm-Message-State: ABuFfojQZsZFG57bdbhBUnQWLnkQDmnuQJOj+M4arD7fkgoEtHHSKcs8
        7s6B37OOyBgDoHnWDfnn4sgVifk+
X-Google-Smtp-Source: ACcGV6285D3ax3hmHp1UgFSmH1GatuDAhEANe2tKHMC0YMhryUkNuw86fba2QdeouC9FkFROv0RPSg==
X-Received: by 2002:a19:aa8b:: with SMTP id t133-v6mr1703906lfe.92.1537955887162;
        Wed, 26 Sep 2018 02:58:07 -0700 (PDT)
Received: from x1c.lan (85-76-70-99-nat.elisa-mobile.fi. [85.76.70.99])
        by smtp.gmail.com with ESMTPSA id x78-v6sm912199lfa.33.2018.09.26.02.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 02:58:05 -0700 (PDT)
Date:   Wed, 26 Sep 2018 12:58:03 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Matias Karhumaa <matias.karhumaa@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: fix crash in unpairing
Message-ID: <20180926095803.GA32364@x1c.lan>
Mail-Followup-To: Matias Karhumaa <matias.karhumaa@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20180926061346.GA13570@makarhum-Latitude-E5440>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926061346.GA13570@makarhum-Latitude-E5440>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matias,

On Wed, Sep 26, 2018, Matias Karhumaa wrote:
> In case unpair_device() was called through mgmt interface at the same time
> when pairing was in progress, Bluetooth kernel module crash was seen.
> 
> [  600.351225] general protection fault: 0000 [#1] SMP PTI
> [  600.351235] CPU: 1 PID: 11096 Comm: btmgmt Tainted: G           OE     4.19.0-rc1+ #1
> [  600.351238] Hardware name: Dell Inc. Latitude E5440/08RCYC, BIOS A18 05/14/2017
> [  600.351272] RIP: 0010:smp_chan_destroy.isra.10+0xce/0x2c0 [bluetooth]
> [  600.351276] Code: c0 0f 84 b4 01 00 00 80 78 28 04 0f 84 53 01 00 00 4d 85 ed 0f 85 ab 00 00 00 48 8b 08 48 8b 50 08 be 10 00 00 00 48 89 51 08 <48> 89 0a 48 b9 00 02 00 00 00 00 ad de 48 89 48 08 48 8b 83 00 01
> [  600.351279] RSP: 0018:ffffa9be839b3b50 EFLAGS: 00010246
> [  600.351282] RAX: ffff9c999ac565a0 RBX: ffff9c9996e98c00 RCX: ffff9c999aa28b60
> [  600.351285] RDX: dead000000000200 RSI: 0000000000000010 RDI: ffff9c999e403500
> [  600.351287] RBP: ffffa9be839b3b70 R08: 0000000000000000 R09: ffffffff92a25c00
> [  600.351290] R10: ffffa9be839b3ae8 R11: 0000000000000001 R12: ffff9c995375b800
> [  600.351292] R13: 0000000000000000 R14: ffff9c99619a5000 R15: ffff9c9962a01c00
> [  600.351295] FS:  00007fb2be27c700(0000) GS:ffff9c999e880000(0000) knlGS:0000000000000000
> [  600.351298] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  600.351300] CR2: 00007fb2bdadbad0 CR3: 000000041c328001 CR4: 00000000001606e0
> [  600.351302] Call Trace:
> [  600.351325]  smp_failure+0x4f/0x70 [bluetooth]
> [  600.351345]  smp_cancel_pairing+0x74/0x80 [bluetooth]
> [  600.351370]  unpair_device+0x1c1/0x330 [bluetooth]
> [  600.351399]  hci_sock_sendmsg+0x960/0x9f0 [bluetooth]
> [  600.351409]  ? apparmor_socket_sendmsg+0x1e/0x20
> [  600.351417]  sock_sendmsg+0x3e/0x50
> [  600.351422]  sock_write_iter+0x85/0xf0
> [  600.351429]  do_iter_readv_writev+0x12b/0x1b0
> [  600.351434]  do_iter_write+0x87/0x1a0
> [  600.351439]  vfs_writev+0x98/0x110
> [  600.351443]  ? ep_poll+0x16d/0x3d0
> [  600.351447]  ? ep_modify+0x73/0x170
> [  600.351451]  do_writev+0x61/0xf0
> [  600.351455]  ? do_writev+0x61/0xf0
> [  600.351460]  __x64_sys_writev+0x1c/0x20
> [  600.351465]  do_syscall_64+0x5a/0x110
> [  600.351471]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  600.351474] RIP: 0033:0x7fb2bdb62fe0
> [  600.351477] Code: 73 01 c3 48 8b 0d b8 6e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 69 c7 2c 00 00 75 10 b8 14 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 de 80 01 00 48 89 04 24
> [  600.351479] RSP: 002b:00007ffe062cb8f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> [  600.351484] RAX: ffffffffffffffda RBX: 000000000255b3d0 RCX: 00007fb2bdb62fe0
> [  600.351487] RDX: 0000000000000001 RSI: 00007ffe062cb920 RDI: 0000000000000004
> [  600.351490] RBP: 00007ffe062cb920 R08: 000000000255bd80 R09: 0000000000000000
> [  600.351494] R10: 0000000000000353 R11: 0000000000000246 R12: 0000000000000001
> [  600.351497] R13: 00007ffe062cbbe0 R14: 0000000000000000 R15: 0000000000000000
> [  600.351501] Modules linked in: algif_hash algif_skcipher af_alg cmac ipt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc overlay arc4 nls_iso8859_1 dm_crypt intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp dell_laptop kvm_intel crct10dif_pclmul dell_smm_hwmon crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev media hid_multitouch input_leds joydev serio_raw dell_wmi snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic dell_smbios dcdbas sparse_keymap
> [  600.351569]  snd_hda_intel btusb snd_hda_codec btrtl btbcm btintel snd_hda_core bluetooth(OE) snd_hwdep snd_pcm iwlmvm ecdh_generic wmi_bmof dell_wmi_descriptor snd_seq_midi mac80211 snd_seq_midi_event lpc_ich iwlwifi snd_rawmidi snd_seq snd_seq_device snd_timer cfg80211 snd soundcore mei_me mei dell_rbtn dell_smo8800 mac_hid parport_pc ppdev lp parport autofs4 hid_generic usbhid hid i915 nouveau kvmgt vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt mxm_wmi psmouse ahci sdhci_pci cqhci libahci fb_sys_fops sdhci drm e1000e video wmi
> [  600.351637] ---[ end trace e49e9f1df09c94fb ]---
> [  600.351664] RIP: 0010:smp_chan_destroy.isra.10+0xce/0x2c0 [bluetooth]
> [  600.351666] Code: c0 0f 84 b4 01 00 00 80 78 28 04 0f 84 53 01 00 00 4d 85 ed 0f 85 ab 00 00 00 48 8b 08 48 8b 50 08 be 10 00 00 00 48 89 51 08 <48> 89 0a 48 b9 00 02 00 00 00 00 ad de 48 89 48 08 48 8b 83 00 01
> [  600.351669] RSP: 0018:ffffa9be839b3b50 EFLAGS: 00010246
> [  600.351672] RAX: ffff9c999ac565a0 RBX: ffff9c9996e98c00 RCX: ffff9c999aa28b60
> [  600.351674] RDX: dead000000000200 RSI: 0000000000000010 RDI: ffff9c999e403500
> [  600.351676] RBP: ffffa9be839b3b70 R08: 0000000000000000 R09: ffffffff92a25c00
> [  600.351679] R10: ffffa9be839b3ae8 R11: 0000000000000001 R12: ffff9c995375b800
> [  600.351681] R13: 0000000000000000 R14: ffff9c99619a5000 R15: ffff9c9962a01c00
> [  600.351684] FS:  00007fb2be27c700(0000) GS:ffff9c999e880000(0000) knlGS:0000000000000000
> [  600.351686] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  600.351689] CR2: 00007fb2bdadbad0 CR3: 000000041c328001 CR4: 00000000001606e0
> 
> Crash happened because list_del_rcu() was called twice for smp->ltk. This
> was possible if unpair_device was called right after ltk was generated
> but before keys were distributed.
> 
> In this commit smp_cancel_pairing was refactored to cancel pairing if it
> is in progress and otherwise just removes keys. Once keys are removed from
> rcu list, pointers to smp context's keys are set to NULL to make sure
> removed list items are not accessed later.
> 
> This commit also adjusts the functionality of mgmt unpair_device() little
> bit. Previously pairing was canceled only if pairing was in state that
> keys were already generated. With this commit unpair_device() cancels
> pairing already in earlier states.
> 
> Bug was found by fuzzing kernel SMP implementation using Synopsys
> Defensics.
> 
> Reported-by: Pekka Oikarainen <pekka.oikarainen@synopsys.com>
> Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
> ---
>  net/bluetooth/mgmt.c |  7 ++-----
>  net/bluetooth/smp.c  | 29 +++++++++++++++++++++++++----
>  net/bluetooth/smp.h  |  3 ++-
>  3 files changed, 29 insertions(+), 10 deletions(-)

Thanks. The patch has been applied to the Bluetooth stable tree.

Johan
