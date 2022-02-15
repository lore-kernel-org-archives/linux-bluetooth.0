Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54225C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 15:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbiBOPdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:33:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiBOPcG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 10:32:06 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A733AFF6D
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 07:29:59 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c6so57186039ybk.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 07:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=nhOZ59LYl8NskK9N2KqTB2wexmgYyniE3SzsHLGoVrQ=;
        b=jSn9o50b5DR1G+D955jjb97r4jfI04oFRMQHIuH+yC14I+LM3sVr190itSv1QCSr5C
         XbrZR5LzqFBGclVcd9TKnVT6aIVLnalGAYX0yClpAcN0TkQCBCG8Ra6rgLIImZ7B3mXU
         yE6Jozwsi86V+cfiAavJ7Qi4BT++Gqmf6BrS7CY2hMeFxRdrar00V69SjkbYgwGgyIR/
         7yvIrJDK3ONIfW6zFxhb5ycb1qlJQFWZ3hc08FmNGfmVnpimOpjYKS7U6w2M5Iv6DdOE
         04jDzXNU4SWQA7dpL95zt/iytDoWTQKoyHt26WRPpbRyEw0h+ddPq2vrc01cuDLgycM3
         byJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=nhOZ59LYl8NskK9N2KqTB2wexmgYyniE3SzsHLGoVrQ=;
        b=ZJSkmg9vzlI4mFZqOkNjKZqzrgWqQZkzFC18hAPIy2u1bQOQIdPIvEqVTg1BUuOdeL
         /ie4GECq0YKGW1avi3yxYW6hBYA9RFY3xgBCqhNq64+6pOs2UIJ84VUz7W6+A5eiRR8p
         W6y8kwLRGcGUUovHkTatN0Phkwc9mBQNPWR5YBlqpZBvSzpcWn0RwpX12m+CdVyWgSza
         8Myo1Eg4qs7M0svokC1qtQrMdkUTlJx/h7olkR++gfOX7vHnCrof4RDMIUYhVqemtmah
         Ce1dY26IokMMyJ6RnG4WeEtpaWQrAm5SsZ9QlldtcDtErb/Sv6FrjVk1opAcXSrSEW8a
         lwcA==
X-Gm-Message-State: AOAM533VymD+arb5tHJw6+o/VkAvGMqowo5E87gq7oTYABkzg+R0SLW0
        2cSQxGIX0VDNcU1VofMk0KGpnxXUdm5829ZWHwcn/cmN+tYwzQ==
X-Google-Smtp-Source: ABdhPJxIsm4hO6f2Vl7PNsYn+hPUNyaNZdf8aZBBkEpjRqG2AhtuyezV87VXU/l+ISyAGDR8r/xGWn/qWrn0JUBuJ8g=
X-Received: by 2002:a81:b655:: with SMTP id h21mr4273880ywk.510.1644938998340;
 Tue, 15 Feb 2022 07:29:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
In-Reply-To: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 15 Feb 2022 08:29:42 -0700
Message-ID: <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
Cc:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Feb 10, 2022 at 6:44 PM Chris Murphy <lists@colorremedies.com> wrot=
e:

> Case 2:
>
> Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> Jefferson Peak (JfP)

Comparing 5.16.9 (working) and 5.17.0-rc7 (non-working) on this
Thinkpad X1 Carbon, I'm seeing two notable differences:

Multiple messages like this:
[   15.731405] kernel: Bluetooth: hci0: unexpected event 0xff length: 5 > 0

And a lockdep warning:

[   26.658252] kernel: Chain exists of:
                         sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM -->
rfcomm_mutex --> &d->lock



5.17.0-0.rc4.96.fc36.x86_64+debug
[   11.210423] systemd[1]: unit_file_build_name_map: alias:
/etc/systemd/system/dbus-org.bluez.service =E2=86=92 bluetooth.service
[   11.222138] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/bluetooth.service
[   11.222142] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/bluetooth.target
[   13.403381] kernel: thinkpad_acpi: rfkill switch
tpacpi_bluetooth_sw: radio is unblocked
[   13.723178] kernel: Bluetooth: Core ver 2.22
[   13.726055] kernel: NET: Registered PF_BLUETOOTH protocol family
[   13.728463] kernel: Bluetooth: HCI device and connection manager initial=
ized
[   13.730914] kernel: Bluetooth: HCI socket layer initialized
[   13.734079] kernel: Bluetooth: L2CAP socket layer initialized
[   13.736746] kernel: Bluetooth: SCO socket layer initialized
[   14.017250] kernel: Bluetooth: hci0: Bootloader revision 0.1 build
42 week 52 2015
[   14.023991] kernel: Bluetooth: hci0: Device revision is 2
[   14.026848] kernel: Bluetooth: hci0: Secure boot is enabled
[   14.029674] kernel: Bluetooth: hci0: OTP lock is enabled
[   14.032315] kernel: Bluetooth: hci0: API lock is enabled
[   14.035066] kernel: Bluetooth: hci0: Debug lock is disabled
[   14.037744] kernel: Bluetooth: hci0: Minimum firmware build 1 week 10 20=
14
[   14.091618] kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-17-16-1.sfi
[   14.093532] kernel: Bluetooth: hci0: Boot Address: 0x40800
[   14.095001] kernel: Bluetooth: hci0: Firmware Version: 86-46.21
[   14.538285] kernel: Modules linked in: acpi_cpufreq(-)
snd_hda_codec_hdmi intel_tcc_cooling x86_pkg_temp_thermal
intel_powerclamp snd_hda_codec_realtek coretemp snd_hda_codec_generic
kvm_intel snd_sof_pci_intel_cnl snd_sof_intel_hda_common kvm
soundwire_intel soundwire_generic_allocation soundwire_cadence
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof soundwire_bus
irqbypass rapl snd_soc_skl intel_cstate snd_soc_hdac_hda intel_uncore
snd_hda_ext_core snd_soc_sst_ipc snd_soc_sst_dsp
snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_compress
ac97_bus iwlmvm snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg
snd_intel_sdw_acpi snd_hda_codec mac80211 snd_hda_core snd_hwdep
snd_seq snd_seq_device btusb think_lmi(+) snd_pcm
firmware_attributes_class libarc4 wmi_bmof intel_wmi_thunderbolt btrtl
i2c_i801 snd_timer uvcvideo i2c_smbus btbcm btintel videobuf2_vmalloc
videobuf2_memops iwlwifi btmtk videobuf2_v4l2 videobuf2_common
thunderbolt bluetooth videodev joydev cfg80211
[   15.730572] kernel: Bluetooth: hci0: Waiting for firmware download
to complete
[   15.731394] kernel: Bluetooth: hci0: Firmware loaded in 1599609 usecs
[   15.731405] kernel: Bluetooth: hci0: unexpected event 0xff length: 5 > 0
[   15.732383] kernel: Bluetooth: hci0: Waiting for device to boot
[   15.745966] kernel: Bluetooth: hci0: unexpected event 0xff length: 7 > 0
[   15.745981] kernel: Bluetooth: hci0: Device booted in 13808 usecs
[   15.754072] kernel: Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-17-16-1.ddc
[   15.761008] kernel: Bluetooth: hci0: Applying Intel DDC parameters compl=
eted
[   15.761991] kernel: Bluetooth: hci0: Firmware revision 0.1 build 86
week 46 2021
[   16.172456] kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   16.172460] kernel: Bluetooth: BNEP filters: protocol multicast
[   16.172471] kernel: Bluetooth: BNEP socket layer initialized
[   21.136887] kernel: Bluetooth: RFCOMM TTY layer initialized
[   21.136911] kernel: Bluetooth: RFCOMM socket layer initialized
[   21.137263] kernel: Bluetooth: RFCOMM ver 1.11
[   26.492364] kernel: Bluetooth: hci0: unexpected event 0xff length: 4 > 0
[   26.657785] kernel:
[   26.657800] kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   26.657806] kernel: WARNING: possible circular locking dependency detect=
ed
[   26.657812] kernel: 5.17.0-0.rc4.96.fc36.x86_64+debug #1 Tainted: G
       W        --------- ---
[   26.657820] kernel: ----------------------------------------------------=
--
[   26.657824] kernel: krfcommd/1391 is trying to acquire lock:
[   26.657831] kernel: ffff8d697a534940
(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:
rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   26.657879] kernel:
                       but task is already holding lock:
[   26.657884] kernel: ffff8d695be69540 (&d->lock){+.+.}-{3:3}, at:
__rfcomm_dlc_close+0x8b/0x230 [rfcomm]
[   26.657920] kernel:
                       which lock already depends on the new lock.
[   26.657924] kernel:
                       the existing dependency chain (in reverse order) is:
[   26.657929] kernel:
                       -> #2 (&d->lock){+.+.}-{3:3}:
[   26.657945] kernel:        __mutex_lock+0x93/0x7d0
[   26.657958] kernel:        __rfcomm_dlc_close+0x8b/0x230 [rfcomm]
[   26.657985] kernel:        rfcomm_session_close+0x42/0x90 [rfcomm]
[   26.658012] kernel:        rfcomm_run+0x61a/0x1860 [rfcomm]
[   26.658038] kernel:        kthread+0xf2/0x120
[   26.658049] kernel:        ret_from_fork+0x1f/0x30
[   26.658059] kernel:
                       -> #1 (rfcomm_mutex){+.+.}-{3:3}:
[   26.658069] kernel:        __mutex_lock+0x93/0x7d0
[   26.658075] kernel:        rfcomm_dlc_open+0x30/0x340 [rfcomm]
[   26.658090] kernel:        rfcomm_sock_connect+0xd4/0x130 [rfcomm]
[   26.658106] kernel:        __sys_connect+0x8c/0xb0
[   26.658116] kernel:        __x64_sys_connect+0x14/0x20
[   26.658125] kernel:        do_syscall_64+0x37/0x80
[   26.658134] kernel:        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   26.658143] kernel:
                       -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0=
:0}:
[   26.658152] kernel:        __lock_acquire+0x12b5/0x1ec0
[   26.658161] kernel:        lock_acquire+0xd0/0x2d0
[   26.658167] kernel:        lock_sock_nested+0x2e/0x80
[   26.658174] kernel:        rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   26.658189] kernel:        __rfcomm_dlc_close+0xa4/0x230 [rfcomm]
[   26.658204] kernel:        rfcomm_session_close+0x42/0x90 [rfcomm]
[   26.658218] kernel:        rfcomm_run+0x61a/0x1860 [rfcomm]
[   26.658233] kernel:        kthread+0xf2/0x120
[   26.658239] kernel:        ret_from_fork+0x1f/0x30
[   26.658248] kernel:
                       other info that might help us debug this:
[   26.658252] kernel: Chain exists of:
                         sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM -->
rfcomm_mutex --> &d->lock
[   26.658264] kernel:  Possible unsafe locking scenario:
[   26.658267] kernel:        CPU0                    CPU1
[   26.658270] kernel:        ----                    ----
[   26.658272] kernel:   lock(&d->lock);
[   26.658278] kernel:                                lock(rfcomm_mutex);
[   26.658283] kernel:                                lock(&d->lock);
[   26.658289] kernel:   lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);
[   26.658294] kernel:
                        *** DEADLOCK ***
[   26.658297] kernel: 2 locks held by krfcommd/1391:
[   26.658302] kernel:  #0: ffffffffc162b130
(rfcomm_mutex){+.+.}-{3:3}, at: rfcomm_run+0x135/0x1860 [rfcomm]
[   26.658327] kernel:  #1: ffff8d695be69540 (&d->lock){+.+.}-{3:3},
at: __rfcomm_dlc_close+0x8b/0x230 [rfcomm]
[   26.658350] kernel:
                       stack backtrace:
[   26.658354] kernel: CPU: 2 PID: 1391 Comm: krfcommd Tainted: G
  W        --------- ---  5.17.0-0.rc4.96.fc36.x86_64+debug #1
[   26.658363] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200,
BIOS N2HET66W (1.49 ) 11/10/2021
[   26.658368] kernel: Call Trace:
[   26.658373] kernel:  <TASK>
[   26.658380] kernel:  dump_stack_lvl+0x5e/0x77
[   26.658392] kernel:  check_noncircular+0xdc/0x100
[   26.658400] kernel:  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[   26.658416] kernel:  __lock_acquire+0x12b5/0x1ec0
[   26.658429] kernel:  lock_acquire+0xd0/0x2d0
[   26.658438] kernel:  ? rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   26.658455] kernel:  ? __mutex_lock+0xe7/0x7d0
[   26.658463] kernel:  ? __rfcomm_dlc_close+0x8b/0x230 [rfcomm]
[   26.658480] kernel:  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[   26.658495] kernel:  lock_sock_nested+0x2e/0x80
[   26.658503] kernel:  ? rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   26.658518] kernel:  rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   26.658535] kernel:  __rfcomm_dlc_close+0xa4/0x230 [rfcomm]
[   26.658552] kernel:  rfcomm_session_close+0x42/0x90 [rfcomm]
[   26.658569] kernel:  rfcomm_run+0x61a/0x1860 [rfcomm]
[   26.658584] kernel:  ? sched_clock_cpu+0xb/0xc0
[   26.658598] kernel:  ? __init_waitqueue_head+0x60/0x60
[   26.658614] kernel:  ? _raw_spin_unlock_irqrestore+0x41/0x60
[   26.658625] kernel:  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[   26.658640] kernel:  kthread+0xf2/0x120
[   26.658647] kernel:  ? kthread_complete_and_exit+0x20/0x20
[   26.658657] kernel:  ret_from_fork+0x1f/0x30
[   26.658675] kernel:  </TASK>
[  167.235571] kernel: Bluetooth: hci0: unexpected event 0xff length: 4 > 0
[  190.233772] kernel: Bluetooth: hci0: unexpected event 0xff length: 4 > 0
[  190.433812] kernel: Bluetooth: hci0: Opcode 0x 401 failed: -16
[  194.234441] kernel: Bluetooth: hci0: unexpected event 0xff length: 4 > 0
[  199.234214] kernel: Bluetooth: hci0: unexpected event 0xff length: 4 > 0



--=20
Chris Murphy
