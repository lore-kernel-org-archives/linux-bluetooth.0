Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 02:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE01C6143C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 02:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhENCd1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 22:33:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39019 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhENCd0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 22:33:26 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14E2W78g8028223, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14E2W78g8028223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 May 2021 10:32:07 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 10:32:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 10:31:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Fri, 14 May 2021 10:31:45 +0800
From:   Hilda Wu <hildawu@realtek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        KidmanLee <kidman@realtek.com>
Subject: RE: [PATCH] Bluetooth: btusb: Add support USB ALT 3 for WBS
Thread-Topic: [PATCH] Bluetooth: btusb: Add support USB ALT 3 for WBS
Thread-Index: AQHXR+FETZsNaKRViEWtURNUsICg4arg/wKAgAFAQAA=
Date:   Fri, 14 May 2021 02:31:45 +0000
Message-ID: <08bd26e7da6549898da05b5ec3bb8b44@realtek.com>
References: <20210513101806.5666-1-hildawu@realtek.com>
 <846A7897-6645-4FA0-8B3A-C0AB01965365@holtmann.org>
In-Reply-To: <846A7897-6645-4FA0-8B3A-C0AB01965365@holtmann.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.158]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/5/13_=3F=3F_08:28:00?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 02:19:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163648 [May 13 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: hildawu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 02:21:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 02:19:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163648 [May 13 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: hildawu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 02:21:00
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thank you!
I will propose a patch v2.

Regards,
Hilda

-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org> 
Sent: Thursday, May 13, 2021 11:13 PM
To: Hilda Wu <hildawu@realtek.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>; Luiz Augusto von Dentz <luiz.dentz@gmail.com>; Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>; Max Chou <max.chou@realtek.com>; alex_lu@realsil.com.cn; KidmanLee <kidman@realtek.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add support USB ALT 3 for WBS

Hi Hilda,

> Because mSBC frames do not need to be aligned to the SCO packet 
> boundary. Using USB ALT 3 let HCI payload >= 60 bytes, let mSBC data 
> satisfy 60 Bytes avoid payload unaligned situation and fixed some 
> headset no voise issue.
> 
> USB Alt 3 supported also need HFP support transparent MTU in 72 Bytes.
> 
> Signed-off-by: hildawu <hildawu@realtek.com>

please use real name here.

> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c 
> index 6f253378e893..872034e7a232 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1752,6 +1752,13 @@ static void btusb_work(struct work_struct *work)
> 			 * which work with WBS at all.
> 			 */
> 			new_alts = btusb_find_altsetting(data, 6) ? 6 : 1;
> +			/* Because mSBC frames do not need to be aligned to the
> +			 * SCO packet boundary. If support the Alt 3, use the
> +			 * Alt 3 for HCI payload >= 60 Bytes let air packet
> +			 * data satisfy 60 bytes.
> +			 */
> +			if ((new_alts == 1) && (btusb_find_altsetting(data, 3)))
> +				new_alts = 3;

	if (new_alts == 1 && btusb_find_altsetting(..))
		..

Regards

Marcel

------Please consider the environment before printing this e-mail.
