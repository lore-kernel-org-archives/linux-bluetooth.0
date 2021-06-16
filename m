Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84884C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 05:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4382461375
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 05:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhFPFTb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 01:19:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56890 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhFPFTa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 01:19:30 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id E0D21CED07;
        Wed, 16 Jun 2021 07:25:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v9 03/10] Bluetooth: Add a callback function to retireve
 data path
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DM8PR11MB55738B34B77C3B03B305D607F50F9@DM8PR11MB5573.namprd11.prod.outlook.com>
Date:   Wed, 16 Jun 2021 07:17:05 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B1717D42-94D8-45CF-A9F2-565513E12AA1@holtmann.org>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-3-kiran.k@intel.com>
 <3C9F25C0-3122-4208-938A-3C3094E018BA@holtmann.org>
 <DM8PR11MB55738B34B77C3B03B305D607F50F9@DM8PR11MB5573.namprd11.prod.outlook.com>
To:     "K, Kiran" <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

>>> There is no standard HCI command to retrieve data path for transport.
>>> Add a new callback function to retrieve data path which is used in
>>> offload usecase. This needs to be set at setup stage if controller
>>> supports offload codecs
>>> 
>>> Signed-off-by: Kiran K <kiran.k@intel.com>
>>> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>>> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
>>> ---
>>> * changes in v9:
>>> - define a separate patch for core changes
>>> 
>>> include/net/bluetooth/hci_core.h | 1 +
>>> 1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/include/net/bluetooth/hci_core.h
>>> b/include/net/bluetooth/hci_core.h
>>> index 3284044c3dd7..641477396da3 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -617,6 +617,7 @@ struct hci_dev {
>>> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>>> 	void (*cmd_timeout)(struct hci_dev *hdev);
>>> 	bool (*prevent_wake)(struct hci_dev *hdev);
>>> +	int (*get_data_path)(struct hci_dev *hdev);
>>> };
>> 
>> and where is the code using hdev->get_data_path. That code needs to be in
>> this patch.
> 
> In the previous patchset, there was a comment to separate out driver and core changes. Let me know if I am missing something here.
> https://patchwork.kernel.org/project/bluetooth/patch/20210518104232.5431-3-kiran.k@intel.com/
> 

I know that and this is not contradictory. Introducing such a callback must come with the usage of said callback. Usage means the core side and not the driver side of it.

Regards

Marcel

