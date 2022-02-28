Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4008BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiB1T3j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiB1T3i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 14:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFBD189CFE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646076529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwRMpL9DyQr/Cl2+VYq23+L4IO2xk2PxngeUsBiqb88=;
        b=L7QuW13TnXPjPjhQ33azV6ipqyWwNaPUNEnqzbRG1tbvBDF68yReI5fb/KYyPgWfOavt6v
        KZ0lf5v9DDLACI/MPHNhRHwLeJIsrbKj7NwR4GWmAurSm/SpVjzo+Ep/nns9xz88hlhNFf
        IItfnhKfTlRE5f02fU9z3dOycISjNSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-0q8XM8h2OGGVAhfY5y2urA-1; Mon, 28 Feb 2022 14:28:46 -0500
X-MC-Unique: 0q8XM8h2OGGVAhfY5y2urA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16A9551DC;
        Mon, 28 Feb 2022 19:28:45 +0000 (UTC)
Received: from starship (unknown [10.40.195.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F29095C5DE;
        Mon, 28 Feb 2022 19:28:40 +0000 (UTC)
Message-ID: <11924ed80b3507cbf8aea84c0cc8938502a71cf9.camel@redhat.com>
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Mon, 28 Feb 2022 21:28:39 +0200
In-Reply-To: <CABBYNZJBubO13QrSSyukaBFx7jWhb5KSJ-3eABuViXCFBV=KAA@mail.gmail.com>
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
         <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com>
         <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
         <fc74637a-f3c8-7870-82ec-90bf55b60462@molgen.mpg.de>
         <0838aa454b7b127fab1b2a945180304088251b13.camel@redhat.com>
         <CABBYNZKMj6yhqsvkx=tcj=tz_9_78r87NBqk6TC1cyO6g4Pesw@mail.gmail.com>
         <dd0af1b94c916dbb8d118a8755a062db960ba8e2.camel@redhat.com>
         <CABBYNZJBubO13QrSSyukaBFx7jWhb5KSJ-3eABuViXCFBV=KAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2022-02-28 at 10:53 -0800, Luiz Augusto von Dentz wrote:
> Hi Maxim,
> 
> On Mon, Feb 28, 2022 at 4:08 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > On Fri, 2022-02-25 at 14:27 -0800, Luiz Augusto von Dentz wrote:
> > > Hi Maxim,
> > > 
> > > On Thu, Feb 24, 2022 at 8:29 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > > > On Thu, 2022-02-24 at 16:43 +0100, Paul Menzel wrote:
> > > > > Dear Maxim,
> > > > > 
> > > > > 
> > > > > Am 24.02.22 um 14:01 schrieb Maxim Levitsky:
> > > > > > On Tue, 2022-02-22 at 10:35 -0800, Luiz Augusto von Dentz wrote:
> > > > > > > On Mon, Feb 21, 2022 at 7:14 PM Maxim Levitsky wrote:
> > > > > > > > Today I updated to a new kernel and I am bisecting few
> > > > > > > > regressions:
> > > > > 
> > > > > […]
> > > > > 
> > > > > > I do notice that even on 5.16 kernel, I am not able to use the HSF
> > > > > > or whatever low quality bi-directional bluetooh protocol is called
> > > > > > for my headset. Used to work, I don't know what broke it, likely not
> > > > > > related to this.
> > > > > > 
> > > > > > I also updated bluez to 5.6 by installing fedora 33 package, and
> > > > > > initially it seems to work, but after reboot, the issue shows up
> > > > > > again. Looks like sometimes the scan does work. So far I wasn't able
> > > > > > to make it work even once since then. Reloading btusb doesn't help.
> > > > > > Can't install newer package due to deps on glib sadly. I might be
> > > > > > able to compile it from source, but that will take some time to
> > > > > > figure out how the components of the bluez stack are connected
> > > > > > together.
> > > > > > 
> > > > > > For the reference I have 'Intel Corp. AX200 Bluetooth' and I have
> > > > > > the same device on my AMD laptop and both have USB ID 8087:0029 My
> > > > > > AMD laptop has Fedora 34 though.
> > > > > 
> > > > > Sorry, I lost track, if it’s still about one regression, you
> > > > > successfully bisected or not.
> > > > yes, I sucessfully bisected the regression. 1 commit before mentioned commit
> > > > the bluetooth works for me, and not after it, with same .config and everything else.
> > > > 
> > > > 
> > > > > Anyway, passing through the USB Bluetooth device to QEMU helped me [1],
> > > > > and might help you to overcome the dependency problems. (My steps
> > > > > actually worked, but turned out the Linux kernel commit I tested with
> > > > > had another regression not making the Bluetooth controller initialize.)
> > > > First thing I tried, but alas it worked for me in fedora 34 VM I tried to test with
> > > > (with the same 5.17-rc5 kernel, albeet with different .config, more tailored for a VM).
> > > 
> > > Give it a try with:
> > > 
> > > https://patchwork.kernel.org/project/bluetooth/patch/20220224232950.56204-1-brian.gix@intel.com/
> > 
> > It does fix the issue! I can now see scan results in the GNOME bluetooth window.
> > 
> > However I get oops on attempt to reboot my system:
> > 
> > [   82.337829] CPU: 3 PID: 1841 Comm: bluetoothd Tainted: P           O      5.17.0-rc5.unstable #4 206ccbbb843ff077f6623bff67370ced7692b32a
> > [   82.338507] Hardware name: Gigabyte Technology Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F5a 10/20/2021
> > [   82.339052] RIP: 0010:hci_sock_get_channel+0x6/0x40 [bluetooth]
> > [   82.339467] Code: 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 <0f> b7 87 52 03 00 00 48 89 e5 5d c3 66 66 2e 0f 1f
> > 84 00 00 00 00
> > [   82.340466] RSP: 0018:ffffc90003ef3bd8 EFLAGS: 00010212
> > [   82.340779] RAX: 0000000000000000 RBX: ffff8881021e8bf8 RCX: 0000000000000001
> > [   82.341162] RDX: ffff8881021e8000 RSI: 0000000000000005 RDI: 70740115000e0e7c
> > [   82.341572] RBP: ffffc90003ef3c08 R08: 0000000000000005 R09: 0000000000000001
> > [   82.341996] R10: ffffffffa0f1d598 R11: 0000000000000001 R12: ffff888112633c00
> > [   82.342401] R13: 0000000000000003 R14: 0000000000000005 R15: ffff8881021e8010
> > [   82.342827] FS:  00007f11d1aefc00(0000) GS:ffff8897ee0c0000(0000) knlGS:0000000000000000
> > [   82.343276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   82.343636] CR2: 0000559199c81430 CR3: 0000000135cf3000 CR4: 0000000000350ee0
> > [   82.344061] Call Trace:
> > [   82.344230]  <TASK>
> > [   82.344376]  ? mgmt_pending_find+0x33/0x80 [bluetooth 6d0716e174185388977fcac3dab934dbbf4db47d]
> > [   82.344887]  set_powered+0x5f/0x1c0 [bluetooth 6d0716e174185388977fcac3dab934dbbf4db47d]
> > [   82.345358]  hci_sock_sendmsg+0x8da/0xa00 [bluetooth 6d0716e174185388977fcac3dab934dbbf4db47d]
> > [   82.345853]  sock_sendmsg+0x3a/0x80
> > [   82.346089]  sock_write_iter+0x93/0x100
> > [   82.346314]  do_iter_readv_writev+0x14a/0x1c0
> > [   82.346573]  do_iter_write+0x88/0x1c0
> > [   82.346814]  vfs_writev+0xae/0x180
> > [   82.347017]  ? __seccomp_filter+0x2ec/0x3c0
> > [   82.347263]  ? wake_up_q+0xc0/0xc0
> > [   82.347499]  do_writev+0xe5/0x140
> > [   82.347699]  __x64_sys_writev+0x1c/0x40
> > [   82.347923]  do_syscall_64+0x35/0x80
> > [   82.348166]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   82.348457] RIP: 0033:0x7f11d1ee1477
> > [   82.348685] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c
> > 48 89 74 24 10
> > [   82.349682] RSP: 002b:00007ffe34263108 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> > [   82.350111] RAX: ffffffffffffffda RBX: 00007ffe34263130 RCX: 00007f11d1ee1477
> > [   82.350499] RDX: 0000000000000001 RSI: 00007ffe34263130 RDI: 0000000000000008
> > [   82.350909] RBP: 0000000000000008 R08: 0000562c1d1f5610 R09: 0000000000000000
> > [   82.351313] R10: 0000000000000020 R11: 0000000000000246 R12: 0000562c1d1db7b0
> > [   82.351697] R13: 0000000000000000 R14: 0000562c1d1f5990 R15: 0000562c1d1f6ac0
> > [   82.352113]  </TASK>
> > [   82.352258] Modules linked in: xt_state xt_conntrack ip6table_filter ip6_tables tun pmbus pmbus_core ee1004 jc42 wmi_bmof nvidia_uvm(PO) iwlmvm uvcvideo snd_hda_codec_hdmi mac80211 snd_hda_intel
> > kvm_amd videobuf2_vmalloc libarc4 nvidia(PO) videobuf2_memops snd_intel_dspcfg videobuf2_v4l2 kvm snd_usb_audio btusb videobuf2_common snd_hda_codec btrtl snd_usbmidi_lib iwlwifi btbcm snd_hwdep
> > snd_hda_core btintel irqbypass videodev snd_rawmidi xpad joydev input_leds mc ff_memless bluetooth pcspkr snd_pcm i2c_nvidia_gpu cfg80211 i2c_piix4 zenpower bfq rtc_cmos tpm_crb wmi tpm_tis
> > tpm_tis_core acpi_cpufreq sch_fq_codel binfmt_misc fuse ext4 mbcache jbd2 dm_crypt sd_mod uas usb_storage hid_generic usbhid amdgpu drm_ttm_helper ttm gpu_sched drm_kms_helper cfbfillrect syscopyarea
> > cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea cec rc_core ahci drm libahci drm_panel_orientation_quirks libata igb xhci_pci i2c_algo_bit ccp nvme xhci_hcd nvme_core t10_pi dm_mirror
> > dm_region_hash dm_log
> > [   82.352304]  thunderbolt vendor_reset(O) nbd usbmon it87 hwmon_vid i2c_dev i2c_core autofs4
> > [   82.357257] ---[ end trace 0000000000000000 ]---
> > [   82.367400] RIP: 0010:hci_sock_get_channel+0x6/0x40 [bluetooth]
> > [   82.367752] Code: 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 <0f> b7 87 52 03 00 00 48 89 e5 5d c3 66 66 2e 0f 1f
> > 84 00 00 00 00
> > [   82.368753] RSP: 0018:ffffc90003ef3bd8 EFLAGS: 00010212
> > [   82.369063] RAX: 0000000000000000 RBX: ffff8881021e8bf8 RCX: 0000000000000001
> > [   82.369451] RDX: ffff8881021e8000 RSI: 0000000000000005 RDI: 70740115000e0e7c
> > [   82.369853] RBP: ffffc90003ef3c08 R08: 0000000000000005 R09: 0000000000000001
> > [   82.370236] R10: ffffffffa0f1d598 R11: 0000000000000001 R12: ffff888112633c00
> > [   82.370661] R13: 0000000000000003 R14: 0000000000000005 R15: ffff8881021e8010
> > [   82.371064] FS:  00007f11d1aefc00(0000) GS:ffff8897ee0c0000(0000) knlGS:0000000000000000
> > [   82.371514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   82.371849] CR2: 0000559199c81430 CR3: 0000000135cf3000 CR4: 0000000000350ee0
> > [   82.377469] nfsd: last server has exited, flushing export cache
> > [   82.944148] traps: gsettings-helpe[6327] trap int3 ip:7ff04777e937 sp:7ffc87f7cd50 error:0 in libglib-2.0.so.0.6400.6[7ff047741000+86000]
> >  ...killed.
> > [   91.604592] Bluetooth: hci0: failed to disable LE scan: status 0x1f
> > 
> > 
> > 
> > That was when I was opening GNOME bluetooth window.
> > Later I rebooted without touching bluetooth and got this:
> > 
> > 
> > [ +10.357883] general protection fault, probably for non-canonical address 0xdead000000000108: 0000 [#1] SMP
> > [  +0.000622] CPU: 45 PID: 1543 Comm: kworker/u129:1 Tainted: P           O      5.17.0-rc5.unstable #4 206ccbbb843ff077f6623bff67370ced7692b32a
> > [  +0.000784] Hardware name: Gigabyte Technology Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F5a 10/20/2021
> > [  +0.000754] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> > [  +0.000446] RIP: 0010:mgmt_pending_remove+0xd/0x40 [bluetooth]
> > [  +0.000419] Code: 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 48 8b 47 08 48 8b 17 55 <48> 89 42 08 48 89 10 48 89 e5 48 b8 00 01 00 00 00
> > 00 ad de 48 89
> > [  +0.001156] RSP: 0018:ffffc90003bb7df8 EFLAGS: 00010282
> > [  +0.000370] RAX: dead000000000122 RBX: ffff888106c51c00 RCX: 0000000000003e6a
> > [  +0.000465] RDX: dead000000000100 RSI: ffff888107107b00 RDI: ffff88813a9192a0
> > [  +0.000479] RBP: ffffc90003bb7e40 R08: 16d7f151a20cad7d R09: 0000000000000006
> > [  +0.000488] R10: 0000000000000300 R11: ffffffff82a06460 R12: ffff88813a9192a0
> > [  +0.000450] R13: ffff888106c51c00 R14: ffff88813e7a8000 R15: 0000000000000005
> > [  +0.000488] FS:  0000000000000000(0000) GS:ffff8897eeb40000(0000) knlGS:0000000000000000
> > [  +0.000526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0.000388] CR2: 00007ff88d530000 CR3: 00000001795b4000 CR4: 0000000000350ee0
> > [  +0.000461] Call Trace:
> > [  +0.000188]  <TASK>
> > [  +0.000160]  ? mgmt_set_powered_complete+0x85/0x180 [bluetooth 6d0716e174185388977fcac3dab934dbbf4db47d]
> > [  +0.000633]  ? set_discoverable_sync+0x80/0x80 [bluetooth 6d0716e174185388977fcac3dab934dbbf4db47d]
> > [  +0.000619]  hci_cmd_sync_work+0xae/0x100 [bluetooth 6d0716e174185388977fcac3dab934dbbf4db47d]
> > [  +0.000581]  ? set_powered+0x1c0/0x1c0 [bluetooth 6d0716e174185388977fcac3dab934dbbf4db47d]
> > [  +0.000547]  process_one_work+0x1e4/0x380
> > [  +0.003080]  worker_thread+0x50/0x400
> > [  +0.006538]  ? rescuer_thread+0x380/0x380
> > [  +0.007163]  kthread+0xcd/0x100
> > [  +0.005639]  ? kthread_complete_and_exit+0x40/0x40
> > [  +0.008561]  ret_from_fork+0x1f/0x30
> > [  +0.006391]  </TASK>
> > [  +0.000001] Modules linked in: xt_state xt_conntrack ip6table_filter ip6_tables tun pmbus pmbus_core ee1004 jc42 wmi_bmof snd_hda_codec_hdmi iwlmvm uvcvideo nvidia_uvm(PO) snd_hda_intel
> > videobuf2_vmalloc mac80211 snd_usb_audio videobuf2_memops kvm_amd snd_intel_dspcfg libarc4 videobuf2_v4l2 snd_hd>
> > [  +0.003984]  thunderbolt vendor_reset(O) nbd usbmon it87 hwmon_vid i2c_dev i2c_core autofs4
> > [  +0.169523] ---[ end trace 0000000000000000 ]---
> > [  +0.018131] RIP: 0010:mgmt_pending_remove+0xd/0x40 [bluetooth]
> > [  +0.010460] Code: 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 48 8b 47 08 48 8b 17 55 <48> 89 42 08 48 89 10 48 89 e5 48 b8 00 01 00 00 00
> > 00 ad de 48 89
> > [  +0.033495] RSP: 0018:ffffc90003bb7df8 EFLAGS: 00010282
> > [  +0.000003] RAX: dead000000000122 RBX: ffff888106c51c00 RCX: 0000000000003e6a
> > [  +0.000001] RDX: dead000000000100 RSI: ffff888107107b00 RDI: ffff88813a9192a0
> > [  +0.000001] RBP: ffffc90003bb7e40 R08: 16d7f151a20cad7d R09: 0000000000000006
> > [  +0.000001] R10: 0000000000000300 R11: ffffffff82a06460 R12: ffff88813a9192a0
> > [  +0.000001] R13: ffff888106c51c00 R14: ffff88813e7a8000 R15: 0000000000000005
> > [  +0.073048] FS:  0000000000000000(0000) GS:ffff8897eeb40000(0000) knlGS:0000000000000000
> > [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0.000001] CR2: 00007ff88d530000 CR3: 0000000002a0b000 CR4: 0000000000350ee0
> 
> Try the v2:
> 
> https://patchwork.kernel.org/project/bluetooth/patch/20220228173918.524733-1-brian.gix@intel.com/
> 
> If that fixes it please respond with Tested-by (perhaps we also need
> some tag for the regression tracking as well?)

Yes! it does work and no more kernel oops.
Tested by few reboots, once after doing a scan,
once without doing a scan.

Tested-by: Maxim Levitsky <mlevitsk@redhat.com>

Thank you very much for fixing this regression!

Best regards,
	Maxim Levitsky

> 
> > > Btw, are there any other users of the MGMT socket? Or it is just bluetoothd?
> > 
> > If you mean /dev/rfkill then it has a few users
> > 
> > bluetooth 1839                            root   11u      CHR             10,242         0t0          4 /dev/rfkill
> > wpa_suppl 2012                            root   10r      CHR             10,242         0t0          4 /dev/rfkill
> > wpa_suppl 2012                            root   15r      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 3631                             gdm    8u      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 3631 3639 gmain                  gdm    8u      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 3631 3642 gdbus                  gdm    8u      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 5347                        mlevitsk    8u      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 5347                        mlevitsk    9w      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 5347 5351 gmain             mlevitsk    8u      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 5347 5351 gmain             mlevitsk    9w      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 5347 5354 gdbus             mlevitsk    8u      CHR             10,242         0t0          4 /dev/rfkill
> > gsd-rfkil 5347 5354 gdbus             mlevitsk    9w      CHR             10,242         0t0          4 /dev/rfkill
> 
> 


