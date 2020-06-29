Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 22:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4B021473
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 22:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EDi81zEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgF2Wae (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:30:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51760 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgF2Wab (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 18:30:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200629223029euoutp01e00119e5b8dc8188d5983bc794529ce8~dJF33DTUF2350823508euoutp01J
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 22:30:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200629223029euoutp01e00119e5b8dc8188d5983bc794529ce8~dJF33DTUF2350823508euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593469829;
        bh=yc1QjhOVZH3h6nSAiaewU41F++akJ+nUNlZBhBZwn6Y=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=EDi81zEI/VTsd6/vh8uTWLr8WRBZcP3W44PBWEnPm8bbI3c+gkkME2qY8yzECregN
         /rSf94uvSAG12IgF6jn071aIjSrFPRQWlKC361Pb4/3af61qUBAEVJ+ILv6lJFgaac
         bmh3qT+Crxnz74MVhoqdg6m+dDxDqILJpfrh5r8Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200629223028eucas1p25f11880b9e0836dbc689019e58f84d04~dJF3eNxWB1738217382eucas1p2T;
        Mon, 29 Jun 2020 22:30:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D0.61.06318.48B6AFE5; Mon, 29
        Jun 2020 23:30:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200629223028eucas1p27b9482456072d7864f7505379885a0b4~dJF271ICK1738217382eucas1p2S;
        Mon, 29 Jun 2020 22:30:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200629223028eusmtrp24cec66df7a0f4be5b79a6e88bd33da1c~dJF27QCHA1985619856eusmtrp2M;
        Mon, 29 Jun 2020 22:30:28 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-cc-5efa6b84b00d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 52.71.06017.48B6AFE5; Mon, 29
        Jun 2020 23:30:28 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200629223027eusmtip281de1d06c7315df07330a11f0b730d9f~dJF2h00YK0872608726eusmtip2J;
        Mon, 29 Jun 2020 22:30:27 +0000 (GMT)
Subject: Re: [PATCH v2 12/14] Bluetooth: Update background scan and report
 device based on advertisement monitors
To:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@intel.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <cc9eb868-4f4e-e7a3-d0fb-73c54586e1d1@samsung.com>
Date:   Tue, 30 Jun 2020 00:30:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4c8aeca04ed20e2776cadd9bdb57a7a3632d622c.1592404644.git.marcel@holtmann.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87ot2b/iDB4u1LTYuu8xq8Wca33M
        FjPO72Oy+PbpF6PF6a5XLA6sHrMbLrJ4rN+9nN1j8Z6XTB6fN8kFsERx2aSk5mSWpRbp2yVw
        ZbS3RBW0q1Xs/jOHtYFxrUIXIyeHhICJxJw1vcxdjFwcQgIrGCU+/5rNCuF8YZR4t/cUlPOZ
        UeLfxOmsMC1Hr+9hhEgsZ5SY/20mG4TznlHi4o2XQBkODmGBYomfUzJA4iIC14BG/XvKBtLN
        JmAo0fW2iw2khlfATuLtOgeQMIuAqsSazfsYQWxRgViJvqULwMp5BQQlTs58wgJicwpESbz+
        OxvMZhaQl2jeOpsZwhaXuPVkPhPILgmBfnaJyQ9WskNc6iJxtakZ6mphiVfHt0DFZST+74Rp
        aGaUeHhuLTuE08MocblpBiNElbXEnXO/wC5lFtCUWL9LHyLsKHHlXCPYkxICfBI33gpCHMEn
        MWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiRnC9pDYuGI50wRGxVlI3pyF5LVZSF6bhXDDAkaW
        VYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIFJ5vS/4193MO77k3SIUYCDUYmHN+Hczzgh
        1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1
        tSC1CCbLxMEp1cCo+SG5aFLv6adJDUtMmcWsD++Yn/vEvc/osaKl0cePtVHz5MocWtq6RWdM
        ev/O7oLcWfGk2SKLbH/06mtIHL/ce/PC2l8p8rqifqcDz1jz9Ts+1FhWkBbQsHuSyvWM6zfV
        HG58DZf2WK/Nu5Fr/ukJZy8VZ2naxXl2/57Sp9qxbY9Nrv/jUAklluKMREMt5qLiRAC+cRR5
        LgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7ot2b/iDCZ2MFts3feY1WLOtT5m
        ixnn9zFZfPv0i9HidNcrFgdWj9kNF1k81u9ezu6xeM9LJo/Pm+QCWKL0bIryS0tSFTLyi0ts
        laINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mtpbogra1Sp2/5nD2sC4VqGL
        kZNDQsBE4uj1PYxdjFwcQgJLGSV+3V7DBJGQkTg5rYEVwhaW+HOtiw2i6C2jxOrOFqAODg5h
        gWKJn1MyQOIiAtcYJbZs3MYKUdTGKLG+6RobSDebgKFE11uQbg4OXgE7ibfrHEDCLAKqEms2
        72MEsUUFYiW+3dsCVs4rIChxcuYTFhCbUyBK4vXf2WA2s4CZxLzND5khbHmJ5q2zoWxxiVtP
        5jNNYBSchaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwerYd+7ll
        B2PXu+BDjAIcjEo8vAnnfsYJsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCj
        KdBzE5mlRJPzgZGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB
        cdH1wMSpTvs4PZncH7geKfhQsuqsptsP5Q/XUryClJT3yz7yyXp5cPGZZ9L3o3b8KE2Kunru
        q5d+dmpOtBGXBZPVH9Owydweuox1Ygqf7YXfGHmfn3SltrTs63b2JOuC/RoHjsUtveco8CDM
        Nl0857Ya93Xn1qPzI4XUhTnWvFXY+l9n/5KnSizFGYmGWsxFxYkA/yRborQCAAA=
X-CMS-MailID: 20200629223028eucas1p27b9482456072d7864f7505379885a0b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629223028eucas1p27b9482456072d7864f7505379885a0b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629223028eucas1p27b9482456072d7864f7505379885a0b4
References: <cover.1592404644.git.marcel@holtmann.org>
        <4c8aeca04ed20e2776cadd9bdb57a7a3632d622c.1592404644.git.marcel@holtmann.org>
        <CGME20200629223028eucas1p27b9482456072d7864f7505379885a0b4@eucas1p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On 17.06.2020 16:39, Marcel Holtmann wrote:
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This calls hci_update_background_scan() when there is any update on the
> advertisement monitors. If there is at least one advertisement monitor,
> the filtering policy of scan parameters should be 0x00. This also reports
> device found mgmt events if there is at least one monitor.
>
> The following cases were tested with btmgmt advmon-* commands.
> (1) add a ADV monitor and observe that the passive scanning is
> triggered.
> (2) remove the last ADV monitor and observe that the passive scanning is
> terminated.
> (3) with a LE peripheral paired, repeat (1) and observe the passive
> scanning continues.
> (4) with a LE peripheral paired, repeat (2) and observe the passive
> scanning continues.
> (5) with a ADV monitor, suspend/resume the host and observe the passive
> scanning continues.
>
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

This patch landed recently in linux-next as commit 8208f5a9d435 
("Bluetooth: Update background scan and report device based on 
advertisement monitors").

It causes a regression, a kernel oops during system suspend/resume cycle 
on Samsung Exynos5250 based Snow Chromebook:

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 86c149f5
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in: cmac cros_ec_sysfs cros_ec_lightbar cros_ec_debugfs 
cros_ec_chardev cros_ec_keyb cros_ec_dev snd_soc_hdmi_codec cros_ec_i2c 
cros_ec snd_soc_snow snd_soc_i2s snd_soc_idma snd_soc_s3c_dma exynosdrm 
analogix_dp exynos_gsc v4l2_mem2mem snd_soc_max98095 snd_soc_core 
ac97_bus snd_pcm_dmaengine snd_pcm snd_timer nxp_ptn3460 snd soundcore 
pwm_samsung spi_s3c64xx cyapatp crc_itu_t mwifiex_sdio mwifiex 
sha256_generic libsha256 sha256_arm btmrvl_sdio btmrvl cfg80211 
bluetooth s5p_mfc governor_simpleondemand videobuf2_dma_contig 
videobuf2_memops videobuf2_v4l2 ecdh_generic ecc videobuf2_common 
videodev phy_exynos_usb2 ohci_exynos panfrost gpu_sched mc s3c2410_wdt 
s5p_sss s5p_cec exynos_rng rtc_s3c i2c_arb_gpio_challenge
CPU: 1 PID: 16 Comm: kworker/1:0 Not tainted 
5.7.0-rc7-02995-g8208f5a9d435 #8564
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_freezable mmc_rescan
PC is at __queue_work+0x6c/0x4e8
LR is at __queue_work+0x68/0x4e8
pc : [<c03619d8>]    lr : [<c03619d4>]    psr: 60000093
...
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6be2406a  DAC: 00000051
Process kworker/1:0 (pid: 16, stack limit = 0xf9898f75)
Stack: (0xee117de0 to 0xee118000)
...
[<c03619d8>] (__queue_work) from [<c0361e94>] (queue_work_on+0x40/0x4c)
[<c0361e94>] (queue_work_on) from [<bf17dd0c>] 
(hci_adv_monitors_clear+0x74/0x90 [bluetooth])
[<bf17dd0c>] (hci_adv_monitors_clear [bluetooth]) from [<bf17e138>] 
(hci_unregister_dev+0x158/0x224 [bluetooth])
[<bf17e138>] (hci_unregister_dev [bluetooth]) from [<bf1d1638>] 
(btmrvl_remove_card+0x58/0x7c [btmrvl])
[<bf1d1638>] (btmrvl_remove_card [btmrvl]) from [<c0d09698>] 
(sdio_bus_remove+0x30/0x11c)
[<c0d09698>] (sdio_bus_remove) from [<c09d534c>] 
(device_release_driver_internal+0xe8/0x1ac)
[<c09d534c>] (device_release_driver_internal) from [<c09d3e18>] 
(bus_remove_device+0xcc/0xf8)
[<c09d3e18>] (bus_remove_device) from [<c09cfa3c>] (device_del+0x15c/0x384)
[<c09cfa3c>] (device_del) from [<c0d098b8>] (sdio_remove_func+0x20/0x34)
[<c0d098b8>] (sdio_remove_func) from [<c0d075bc>] 
(mmc_sdio_remove+0x38/0x64)
[<c0d075bc>] (mmc_sdio_remove) from [<c0d08858>] (mmc_sdio_detect+0x6c/0xf8)
[<c0d08858>] (mmc_sdio_detect) from [<c0cff6f0>] (mmc_rescan+0x1d0/0x42c)
[<c0cff6f0>] (mmc_rescan) from [<c0362454>] (process_one_work+0x178/0x4ac)
[<c0362454>] (process_one_work) from [<c0362b44>] (worker_thread+0x2c/0x530)
[<c0362b44>] (worker_thread) from [<c0368610>] (kthread+0x12c/0x158)
[<c0368610>] (kthread) from [<c03001a8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xee117fb0 to 0xee117ff8)
...
---[ end trace 0ec00d142e0a49cf ]---

This board uses btmrvl_sdio bluetooth driver if that helps. Reverting 
this commit in linux-next 20200629 'fixes' the issue.

I can do more tests if needed on this hardware, just let me know how can 
I help and what to do.

> ---
>   include/net/bluetooth/hci_core.h |  1 +
>   net/bluetooth/hci_core.c         | 13 +++++++++++++
>   net/bluetooth/hci_event.c        |  5 +++--
>   net/bluetooth/hci_request.c      | 17 ++++++++++++++---
>   net/bluetooth/mgmt.c             |  5 ++++-
>   5 files changed, 35 insertions(+), 6 deletions(-)

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

