Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82553C001DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 03:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjG1D3r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 23:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjG1D3p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 23:29:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D426AE;
        Thu, 27 Jul 2023 20:29:44 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBtMb2JWdzNmbY;
        Fri, 28 Jul 2023 11:26:19 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 11:29:42 +0800
Subject: Re: [PATCH v2 -next] Bluetooth: Remove unused declaration
 amp_read_loc_info()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmenzel@molgen.mpg.de>
References: <20230727013907.29068-1-yuehaibing@huawei.com>
 <CABBYNZ+Fxmkxg3qQMABt-1DcvhMcUnqsOrwGgHXMQum5ezF82Q@mail.gmail.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a452560c-97b3-ed32-e9a5-ac9f8f3ba14c@huawei.com>
Date:   Fri, 28 Jul 2023 11:29:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Fxmkxg3qQMABt-1DcvhMcUnqsOrwGgHXMQum5ezF82Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2023/7/28 6:21, Luiz Augusto von Dentz wrote:
> Hi Yue,
> 
> On Wed, Jul 26, 2023 at 6:42 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")
>> and never be implemented.
> 
> The commit information above shall be added with Fixes: tag so it can
> be properly backported, etc.

Ok, v3 on the way.
> 
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>> v2: fix SOB and update commit log
>> ---
>>  net/bluetooth/amp.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
>> index 832764dfbfb3..97c87abd129f 100644
>> --- a/net/bluetooth/amp.h
>> +++ b/net/bluetooth/amp.h
>> @@ -28,7 +28,6 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
>>
>>  int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
>>
>> -void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
>>  void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
>>  void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
>>  void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
>> --
>> 2.34.1
>>
> 
> 
