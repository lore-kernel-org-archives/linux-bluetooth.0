Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCC2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 05:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB7761381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 05:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhJEF3B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 01:29:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36686 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhJEF3A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 01:29:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1955QtEsA032285, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1955QtEsA032285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 5 Oct 2021 13:26:55 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 13:26:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 13:26:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Tue, 5 Oct 2021 13:26:53 +0800
From:   Hilda Wu <hildawu@realtek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "apusaka@chromium.org" <apusaka@chromium.org>,
        Max Chou <max.chou@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        KidmanLee <kidman@realtek.com>
Subject: RE: [PATCH] Bluetooth: btrtl: Ask ic_info to drop firmware
Thread-Topic: [PATCH] Bluetooth: btrtl: Ask ic_info to drop firmware
Thread-Index: AQHXtecNs2ZfObp2A0STG/YXQiKUp6u9X0sAgACLa3A=
Date:   Tue, 5 Oct 2021 05:26:53 +0000
Message-ID: <912f4b6441b54a1d89df6ffe4a0511ab@realtek.com>
References: <20210930103634.1710-1-hildawu@realtek.com>
 <D5B18E08-AE60-4B8B-960B-694D62E067B5@holtmann.org>
In-Reply-To: <D5B18E08-AE60-4B8B-960B-694D62E067B5@holtmann.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.191]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/5_=3F=3F_02:02:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/05/2021 05:13:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166506 [Oct 04 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: hildawu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;source.android.com:7.1.1;docs.microsoft.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/05/2021 05:17:00
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thank you for your review and suggestions.

The MSFT extension has a HCI_VS_MSFT_Read_Supported_Features command. The AOSP extension has a read capability cmd too.
https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/microsoft-defined-bluetooth-hci-commands-and-events#hci_vs_msft_read_supported_features
https://source.android.com/devices/bluetooth/hci_requirements#vendor-specific-capabilities
If commands did not support, the controller should feedback event status as Unknown HCI Command (0x01).
We can go on this way.

Regards,
Hilda

-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org> 
Sent: Friday, October 1, 2021 5:42 PM
To: Hilda Wu <hildawu@realtek.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>; Luiz Augusto von Dentz <luiz.dentz@gmail.com>; linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; kai.heng.feng@canonical.com; apusaka@chromium.org; Max Chou <max.chou@realtek.com>; alex_lu@realsil.com.cn; KidmanLee <kidman@realtek.com>
Subject: Re: [PATCH] Bluetooth: btrtl: Ask ic_info to drop firmware

Hi Hilda,

> Some un-support wakeup platforms keep USB power and suspend signal is 
> coming late, this makes Realtek some chip keep its firmware, and make 
> it never load new firmware.
> 
> So use vendor specific HCI command to ask them drop its firmware after 
> system shutdown or resume.
> 
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> drivers/bluetooth/btrtl.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Btw. is there a simple way (via vendor HCI commands or similar) to tell which RTL device supports the MSFT or AOSP extensions. I rather have this done once and not keep hacking it over and over again.

Regards

Marcel

------Please consider the environment before printing this e-mail.
