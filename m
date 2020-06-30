Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B471C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 06:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C59207E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 06:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgF3Gtw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:49:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47425 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgF3Gtv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 02:49:51 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8E30DCECE2;
        Tue, 30 Jun 2020 08:59:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 12/14] Bluetooth: Update background scan and report
 device based on advertisement monitors
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cc9eb868-4f4e-e7a3-d0fb-73c54586e1d1@samsung.com>
Date:   Tue, 30 Jun 2020 08:49:49 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2378EEDB-97C4-4AFB-91B7-4EAF63FA4EFD@holtmann.org>
References: <cover.1592404644.git.marcel@holtmann.org>
 <4c8aeca04ed20e2776cadd9bdb57a7a3632d622c.1592404644.git.marcel@holtmann.org>
 <CGME20200629223028eucas1p27b9482456072d7864f7505379885a0b4@eucas1p2.samsung.com>
 <cc9eb868-4f4e-e7a3-d0fb-73c54586e1d1@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

>> This calls hci_update_background_scan() when there is any update on the
>> advertisement monitors. If there is at least one advertisement monitor,
>> the filtering policy of scan parameters should be 0x00. This also reports
>> device found mgmt events if there is at least one monitor.
>> 
>> The following cases were tested with btmgmt advmon-* commands.
>> (1) add a ADV monitor and observe that the passive scanning is
>> triggered.
>> (2) remove the last ADV monitor and observe that the passive scanning is
>> terminated.
>> (3) with a LE peripheral paired, repeat (1) and observe the passive
>> scanning continues.
>> (4) with a LE peripheral paired, repeat (2) and observe the passive
>> scanning continues.
>> (5) with a ADV monitor, suspend/resume the host and observe the passive
>> scanning continues.
>> 
>> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
> This patch landed recently in linux-next as commit 8208f5a9d435 
> ("Bluetooth: Update background scan and report device based on 
> advertisement monitors").
> 
> It causes a regression, a kernel oops during system suspend/resume cycle 
> on Samsung Exynos5250 based Snow Chromebook:
> 
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = 86c149f5
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in: cmac cros_ec_sysfs cros_ec_lightbar cros_ec_debugfs 
> cros_ec_chardev cros_ec_keyb cros_ec_dev snd_soc_hdmi_codec cros_ec_i2c 
> cros_ec snd_soc_snow snd_soc_i2s snd_soc_idma snd_soc_s3c_dma exynosdrm 
> analogix_dp exynos_gsc v4l2_mem2mem snd_soc_max98095 snd_soc_core 
> ac97_bus snd_pcm_dmaengine snd_pcm snd_timer nxp_ptn3460 snd soundcore 
> pwm_samsung spi_s3c64xx cyapatp crc_itu_t mwifiex_sdio mwifiex 
> sha256_generic libsha256 sha256_arm btmrvl_sdio btmrvl cfg80211 
> bluetooth s5p_mfc governor_simpleondemand videobuf2_dma_contig 
> videobuf2_memops videobuf2_v4l2 ecdh_generic ecc videobuf2_common 
> videodev phy_exynos_usb2 ohci_exynos panfrost gpu_sched mc s3c2410_wdt 
> s5p_sss s5p_cec exynos_rng rtc_s3c i2c_arb_gpio_challenge
> CPU: 1 PID: 16 Comm: kworker/1:0 Not tainted 
> 5.7.0-rc7-02995-g8208f5a9d435 #8564
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_freezable mmc_rescan
> PC is at __queue_work+0x6c/0x4e8
> LR is at __queue_work+0x68/0x4e8
> pc : [<c03619d8>]    lr : [<c03619d4>]    psr: 60000093
> ...
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6be2406a  DAC: 00000051
> Process kworker/1:0 (pid: 16, stack limit = 0xf9898f75)
> Stack: (0xee117de0 to 0xee118000)
> ...
> [<c03619d8>] (__queue_work) from [<c0361e94>] (queue_work_on+0x40/0x4c)
> [<c0361e94>] (queue_work_on) from [<bf17dd0c>] 
> (hci_adv_monitors_clear+0x74/0x90 [bluetooth])
> [<bf17dd0c>] (hci_adv_monitors_clear [bluetooth]) from [<bf17e138>] 
> (hci_unregister_dev+0x158/0x224 [bluetooth])
> [<bf17e138>] (hci_unregister_dev [bluetooth]) from [<bf1d1638>] 
> (btmrvl_remove_card+0x58/0x7c [btmrvl])
> [<bf1d1638>] (btmrvl_remove_card [btmrvl]) from [<c0d09698>] 
> (sdio_bus_remove+0x30/0x11c)
> [<c0d09698>] (sdio_bus_remove) from [<c09d534c>] 
> (device_release_driver_internal+0xe8/0x1ac)
> [<c09d534c>] (device_release_driver_internal) from [<c09d3e18>] 
> (bus_remove_device+0xcc/0xf8)
> [<c09d3e18>] (bus_remove_device) from [<c09cfa3c>] (device_del+0x15c/0x384)
> [<c09cfa3c>] (device_del) from [<c0d098b8>] (sdio_remove_func+0x20/0x34)
> [<c0d098b8>] (sdio_remove_func) from [<c0d075bc>] 
> (mmc_sdio_remove+0x38/0x64)
> [<c0d075bc>] (mmc_sdio_remove) from [<c0d08858>] (mmc_sdio_detect+0x6c/0xf8)
> [<c0d08858>] (mmc_sdio_detect) from [<c0cff6f0>] (mmc_rescan+0x1d0/0x42c)
> [<c0cff6f0>] (mmc_rescan) from [<c0362454>] (process_one_work+0x178/0x4ac)
> [<c0362454>] (process_one_work) from [<c0362b44>] (worker_thread+0x2c/0x530)
> [<c0362b44>] (worker_thread) from [<c0368610>] (kthread+0x12c/0x158)
> [<c0368610>] (kthread) from [<c03001a8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xee117fb0 to 0xee117ff8)
> ...
> ---[ end trace 0ec00d142e0a49cf ]---
> 
> This board uses btmrvl_sdio bluetooth driver if that helps. Reverting 
> this commit in linux-next 20200629 'fixes' the issue.
> 
> I can do more tests if needed on this hardware, just let me know how can 
> I help and what to do.

can you check latest bluetooth-next. I think that we applied a fix for it.

Regards

Marcel

