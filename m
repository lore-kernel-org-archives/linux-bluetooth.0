Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C11C4363D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 06:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF756206B5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 06:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJCGlf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 02:41:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53870 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCGle (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 02:41:34 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id 00601CECF8;
        Sat,  3 Oct 2020 08:48:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v4] Bluetooth: btintel: Add *setup* function for new
 generation Intel controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJW=9p=wV4okj=_WtJjEsZhuh9ZHEB-U_7ZMLEbxJ+UXQ@mail.gmail.com>
Date:   Sat, 3 Oct 2020 08:41:32 +0200
Cc:     Kiran K <kiraank@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Kiran K <kiran.k@intel.com>, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <9E9FAF70-08C3-465A-98C5-2EBCBB50D699@holtmann.org>
References: <1601621530-2803-1-git-send-email-kiran.k@intel.com>
 <CABBYNZJW=9p=wV4okj=_WtJjEsZhuh9ZHEB-U_7ZMLEbxJ+UXQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> Signed-off-by: Kiran K <kiran.k@intel.com>
>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
>> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
>> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
>> ---
>> drivers/bluetooth/btintel.h |   6 +
>> drivers/bluetooth/btusb.c   | 324 +++++++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 328 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
>> index 09346ae..c4e28a8 100644
>> --- a/drivers/bluetooth/btintel.h
>> +++ b/drivers/bluetooth/btintel.h
>> @@ -132,6 +132,12 @@ struct intel_debug_features {
>>        __u8    page1[16];
>> } __packed;
>> 
>> +#define INTEL_HW_PLATFORM(cnvx_bt)     ((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
>> +#define INTEL_HW_VARIANT(cnvx_bt)      ((u8)(((cnvx_bt) & 0x003f0000) >> 16))
>> +#define INTEL_CNVX_TOP_TYPE(cnvx_top)  ((cnvx_top) & 0x00000fff)
>> +#define INTEL_CNVX_TOP_STEP(cnvx_top)  (((cnvx_top) & 0x0f000000) >> 24)
>> +#define INTEL_CNVX_TOP_PACK_SWAB(t, s) __swab16(((__u16)(((t) << 4) | (s))))
>> +
>> #if IS_ENABLED(CONFIG_BT_INTEL)
>> 
>> int btintel_check_bdaddr(struct hci_dev *hdev);
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 1005b6e..5e51749 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
>> #define BTUSB_WIDEBAND_SPEECH  0x400000
>> #define BTUSB_VALID_LE_STATES   0x800000
>> #define BTUSB_QCA_WCN6855      0x1000000
>> +#define BTUSB_INTEL_NEWGEN     0x2000000
> 
> I wonder if it is a good idea to keep adding such flags per model
> here, it should be possible to pass the pid/vid so we don't have to
> add generation after generation here.

We agreed to first add the next gen controller as an independent setup method. And then later combine them into a single one that detects what version it is. We also need to unify it with our first generation ROM products.

Regards

Marcel

