Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7106BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8D9207D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NcU3+YTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgF3Hgg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:36:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55154 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgF3Hgf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 03:36:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200630073633euoutp02bc6d778f5df7cb76b41d22b2f7aac7ba~dQip_4BN62410324103euoutp02a
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 07:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200630073633euoutp02bc6d778f5df7cb76b41d22b2f7aac7ba~dQip_4BN62410324103euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593502593;
        bh=43wwakXWd1isGO8+rcTNITURKmYWk3ZL+jiehc1no2U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NcU3+YThBzOTuvZ0MmYkatV/hs8O/um3ycH28AI3y1n6nhb8XSMyj6DAQZru2YawT
         +15EUQMscZtMp1riMzzKilUb1dcxRzotb5BSWzL/IEN0d42IXGO8dndKyT/qhsRb1C
         zVupaqFzXe/cOxMPNKvARyYpxwrJuZGLLyqvILls=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200630073633eucas1p128dbf0cecfa5f5069d62ce143ac53195~dQipzSlGd2195821958eucas1p19;
        Tue, 30 Jun 2020 07:36:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 03.29.06318.18BEAFE5; Tue, 30
        Jun 2020 08:36:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200630073632eucas1p155551c37b45a6653c0611ec93fafe335~dQipVPPCH0886508865eucas1p1-;
        Tue, 30 Jun 2020 07:36:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200630073632eusmtrp23e968e6b7ca52fee02b9972cc9d24323~dQipUphD81006110061eusmtrp23;
        Tue, 30 Jun 2020 07:36:32 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-d0-5efaeb81c109
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.C6.06314.08BEAFE5; Tue, 30
        Jun 2020 08:36:32 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200630073632eusmtip1d9b9038b235fc3bb9fe433a2cbd73bad~dQio_SjP22526025260eusmtip1H;
        Tue, 30 Jun 2020 07:36:32 +0000 (GMT)
Subject: Re: [PATCH v2 12/14] Bluetooth: Update background scan and report
 device based on advertisement monitors
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@intel.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ddb9ef62-f773-2a0c-8ac4-31d0116ef456@samsung.com>
Date:   Tue, 30 Jun 2020 09:36:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2378EEDB-97C4-4AFB-91B7-4EAF63FA4EFD@holtmann.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87qNr3/FGTyczGGxdd9jVos51/qY
        LWac38dk8e3TL0aL012vWBxYPWY3XGTxWL97ObvH4j0vmTw+b5ILYInisklJzcksSy3St0vg
        yvj6eQFrwWy1io7/LA2MFxW6GDk5JARMJDbe/s7axcjFISSwglHizJnXUM4XRommx7+gnM+M
        EovabrHAtGw/tZ4RIrGcUaJ96nuoqveMEm9nPgeq4uAQFiiW+DklA6RBREBTYu6Ss8wgNcwC
        +xklbt5aCjaJTcBQouttFxtIPa+AncSBdmaQMIuAqkTPzM2sILaoQKxE39IFbCA2r4CgxMmZ
        T8BaOQUcJDa07gezmQXkJba/ncMMYYtL3Hoynwlkl4TAInaJdZ/PsUJc7SLRe3s7I4QtLPHq
        +BZ2CFtG4v9OmIZmRomH59ayQzg9jBKXm2ZAdVhL3Dn3C+xSZqB31u/Shwg7Slw518gIEpYQ
        4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJGYdXwe39uCFS8wTGJVmIXltFpJ3ZiF5ZxbC3gWM
        LKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECk8zpf8e/7mDc9yfpEKMAB6MSD2/CuZ9x
        QqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2
        ampBahFMlomDU6qBkeNpZUx69MSynfs5J56c+Gyl5ltF9+XL5z5u2HZKTlhC1Oh56CV1vgiL
        xdxfqhPtbdoNL+x5ud8pSuuE+/uCPu/n59NeVc+M5dyvuPXqxVv7littPHpJjo/XV0Hgr1iV
        cPjro82a3OJXvX1i3f8l//y16f62Of//N7qYq7rxXGeaEnteyFH4jxJLcUaioRZzUXEiAAt1
        SmQuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7oNr3/FGcz8pW2xdd9jVos51/qY
        LWac38dk8e3TL0aL012vWBxYPWY3XGTxWL97ObvH4j0vmTw+b5ILYInSsynKLy1JVcjILy6x
        VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/j6eQFrwWy1io7/LA2MFxW6
        GDk5JARMJLafWs/YxcjFISSwlFFi/8seNoiEjMTJaQ2sELawxJ9rXWwQRW8ZJZa/nsXSxcjB
        ISxQLPFzSgZIjYiApsTcJWeZQWqYBfYzSkzefo8RJCEkcJRJYutisEFsAoYSXW9BBnFw8ArY
        SRxoZwYJswioSvTM3AxWIioQK/Ht3hawG3gFBCVOznzCAmJzCjhIbGjdD2YzC5hJzNv8kBnC
        lpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl
        5+duYgTG1LZjPzfvYLy0MfgQowAHoxIPb8K5n3FCrIllxZW5hxglOJiVRHidzp6OE+JNSays
        Si3Kjy8qzUktPsRoCvTcRGYp0eR8YLznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpgbPM8uW/7357O8/eDrf3cIrmDN/o7+PexrXhWO+9byWV/t4X2a6/6z7Z3
        WZautCjyaMaV9QeXP/7t+yHmqc+VyLOuqX6T5WPy53kwvw7JW/dhXopZq8ZTyYWRRv0VkWI/
        bl6+/XJe+JYem+q2pvmS+SLRT6amuhyf4rskqEuIW/ahQeopxtdblViKMxINtZiLihMByGKG
        Lr8CAAA=
X-CMS-MailID: 20200630073632eucas1p155551c37b45a6653c0611ec93fafe335
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629223028eucas1p27b9482456072d7864f7505379885a0b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629223028eucas1p27b9482456072d7864f7505379885a0b4
References: <cover.1592404644.git.marcel@holtmann.org>
        <4c8aeca04ed20e2776cadd9bdb57a7a3632d622c.1592404644.git.marcel@holtmann.org>
        <CGME20200629223028eucas1p27b9482456072d7864f7505379885a0b4@eucas1p2.samsung.com>
        <cc9eb868-4f4e-e7a3-d0fb-73c54586e1d1@samsung.com>
        <2378EEDB-97C4-4AFB-91B7-4EAF63FA4EFD@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 30.06.2020 08:49, Marcel Holtmann wrote:
>>> This calls hci_update_background_scan() when there is any update on the
>>> advertisement monitors. If there is at least one advertisement monitor,
>>> the filtering policy of scan parameters should be 0x00. This also reports
>>> device found mgmt events if there is at least one monitor.
>>>
>>> The following cases were tested with btmgmt advmon-* commands.
>>> (1) add a ADV monitor and observe that the passive scanning is
>>> triggered.
>>> (2) remove the last ADV monitor and observe that the passive scanning is
>>> terminated.
>>> (3) with a LE peripheral paired, repeat (1) and observe the passive
>>> scanning continues.
>>> (4) with a LE peripheral paired, repeat (2) and observe the passive
>>> scanning continues.
>>> (5) with a ADV monitor, suspend/resume the host and observe the passive
>>> scanning continues.
>>>
>>> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> This patch landed recently in linux-next as commit 8208f5a9d435
>> ("Bluetooth: Update background scan and report device based on
>> advertisement monitors").
>>
>> It causes a regression, a kernel oops during system suspend/resume cycle
>> on Samsung Exynos5250 based Snow Chromebook:
>>
>> 8<--- cut here ---
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> pgd = 86c149f5
>> [00000000] *pgd=00000000
>> Internal error: Oops: 5 [#1] SMP ARM
>> Modules linked in: cmac cros_ec_sysfs cros_ec_lightbar cros_ec_debugfs
>> cros_ec_chardev cros_ec_keyb cros_ec_dev snd_soc_hdmi_codec cros_ec_i2c
>> cros_ec snd_soc_snow snd_soc_i2s snd_soc_idma snd_soc_s3c_dma exynosdrm
>> analogix_dp exynos_gsc v4l2_mem2mem snd_soc_max98095 snd_soc_core
>> ac97_bus snd_pcm_dmaengine snd_pcm snd_timer nxp_ptn3460 snd soundcore
>> pwm_samsung spi_s3c64xx cyapatp crc_itu_t mwifiex_sdio mwifiex
>> sha256_generic libsha256 sha256_arm btmrvl_sdio btmrvl cfg80211
>> bluetooth s5p_mfc governor_simpleondemand videobuf2_dma_contig
>> videobuf2_memops videobuf2_v4l2 ecdh_generic ecc videobuf2_common
>> videodev phy_exynos_usb2 ohci_exynos panfrost gpu_sched mc s3c2410_wdt
>> s5p_sss s5p_cec exynos_rng rtc_s3c i2c_arb_gpio_challenge
>> CPU: 1 PID: 16 Comm: kworker/1:0 Not tainted
>> 5.7.0-rc7-02995-g8208f5a9d435 #8564
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> Workqueue: events_freezable mmc_rescan
>> PC is at __queue_work+0x6c/0x4e8
>> LR is at __queue_work+0x68/0x4e8
>> pc : [<c03619d8>]    lr : [<c03619d4>]    psr: 60000093
>> ...
>> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 6be2406a  DAC: 00000051
>> Process kworker/1:0 (pid: 16, stack limit = 0xf9898f75)
>> Stack: (0xee117de0 to 0xee118000)
>> ...
>> [<c03619d8>] (__queue_work) from [<c0361e94>] (queue_work_on+0x40/0x4c)
>> [<c0361e94>] (queue_work_on) from [<bf17dd0c>]
>> (hci_adv_monitors_clear+0x74/0x90 [bluetooth])
>> [<bf17dd0c>] (hci_adv_monitors_clear [bluetooth]) from [<bf17e138>]
>> (hci_unregister_dev+0x158/0x224 [bluetooth])
>> [<bf17e138>] (hci_unregister_dev [bluetooth]) from [<bf1d1638>]
>> (btmrvl_remove_card+0x58/0x7c [btmrvl])
>> [<bf1d1638>] (btmrvl_remove_card [btmrvl]) from [<c0d09698>]
>> (sdio_bus_remove+0x30/0x11c)
>> [<c0d09698>] (sdio_bus_remove) from [<c09d534c>]
>> (device_release_driver_internal+0xe8/0x1ac)
>> [<c09d534c>] (device_release_driver_internal) from [<c09d3e18>]
>> (bus_remove_device+0xcc/0xf8)
>> [<c09d3e18>] (bus_remove_device) from [<c09cfa3c>] (device_del+0x15c/0x384)
>> [<c09cfa3c>] (device_del) from [<c0d098b8>] (sdio_remove_func+0x20/0x34)
>> [<c0d098b8>] (sdio_remove_func) from [<c0d075bc>]
>> (mmc_sdio_remove+0x38/0x64)
>> [<c0d075bc>] (mmc_sdio_remove) from [<c0d08858>] (mmc_sdio_detect+0x6c/0xf8)
>> [<c0d08858>] (mmc_sdio_detect) from [<c0cff6f0>] (mmc_rescan+0x1d0/0x42c)
>> [<c0cff6f0>] (mmc_rescan) from [<c0362454>] (process_one_work+0x178/0x4ac)
>> [<c0362454>] (process_one_work) from [<c0362b44>] (worker_thread+0x2c/0x530)
>> [<c0362b44>] (worker_thread) from [<c0368610>] (kthread+0x12c/0x158)
>> [<c0368610>] (kthread) from [<c03001a8>] (ret_from_fork+0x14/0x2c)
>> Exception stack(0xee117fb0 to 0xee117ff8)
>> ...
>> ---[ end trace 0ec00d142e0a49cf ]---
>>
>> This board uses btmrvl_sdio bluetooth driver if that helps. Reverting
>> this commit in linux-next 20200629 'fixes' the issue.
>>
>> I can do more tests if needed on this hardware, just let me know how can
>> I help and what to do.
> can you check latest bluetooth-next. I think that we applied a fix for it.

Indeed. Commit f2790f025a0e ("Bluetooth: fix kernel null pointer 
dereference error on suspend") fixed the issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

