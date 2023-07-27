Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CAC001DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 01:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjG0Bdt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 21:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Bds (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 21:33:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D54C1FF0;
        Wed, 26 Jul 2023 18:33:47 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBCrD6JZKzNmh1;
        Thu, 27 Jul 2023 09:30:20 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 09:33:43 +0800
Subject: Re: [PATCH net-next] Bluetooth: Remove unused declaration
 amp_read_loc_info()
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230726142817.20504-1-yuehaibing@huawei.com>
 <2cf9a03e-6d81-64cd-3cc2-0b989e5d5824@molgen.mpg.de>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <8a059842-3790-3c09-18c9-b7fd7e6c8e4c@huawei.com>
Date:   Thu, 27 Jul 2023 09:33:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2cf9a03e-6d81-64cd-3cc2-0b989e5d5824@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2023/7/26 23:11, Paul Menzel wrote:
> Dear YueHaibing,
> 
> 
> Thank you very much for your patch.
> 
> Am 26.07.23 um 16:28 schrieb YueHaibing:
>> This is never used, so remove it.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Should your name be spelled with a space: Yue Haibing?
> 
>     $ git config --global user.name "Yue Haibing"
>     $ git commit --amend --author="Yue Haibing <yuehaibing@huawei.com>"

Thanks，will fix this.
>> ---
>>   net/bluetooth/amp.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
>> index 832764dfbfb3..97c87abd129f 100644
>> --- a/net/bluetooth/amp.h
>> +++ b/net/bluetooth/amp.h
>> @@ -28,7 +28,6 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
>>     int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
>>   -void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
> 
> Was it never implemented, or just forgotten to be removed?

This is introduce in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")
and never implemented. I will update this to commit message.

> 
>>   void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
>>   void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
>>   void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
> 
> 
> Kind regards,
> 
> Paul
> 
> .
