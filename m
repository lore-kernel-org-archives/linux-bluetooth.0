Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342E4CD6E54
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 09:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjJKJbN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 05:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJKJbM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 05:31:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A49C
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 02:31:09 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S56pZ6m8rzvPt0;
        Wed, 11 Oct 2023 17:26:30 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 17:31:07 +0800
Subject: Re: [PATCH v2] Bluetooth: Fix UAF for hci_chan
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
References: <20231009123045.587882-1-william.xuanziyang@huawei.com>
 <117a47da5324a02cece6d601ff8b51b331d072fa.camel@iki.fi>
 <8f61ef8e-f959-3feb-fb9b-b9b60bf26758@huawei.com>
 <a72b89cd520f502d6d384f97fcaf83f92ead147f.camel@iki.fi>
 <CABBYNZKiXwGWR296TU7_4wVMsemzY=mV2CUo-DDMYvSAWX5RwQ@mail.gmail.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <8ccca432-912e-1f89-802f-addde3652e31@huawei.com>
Date:   Wed, 11 Oct 2023 17:31:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZKiXwGWR296TU7_4wVMsemzY=mV2CUo-DDMYvSAWX5RwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> Hi Pauli,
> 
> On Tue, Oct 10, 2023 at 11:32 AM Pauli Virtanen <pav@iki.fi> wrote:
>>
>> Hi,
>>
>> ti, 2023-10-10 kello 20:49 +0800, Ziyang Xuan (William)
>> kirjoitti:[clip]
>>>>>
>>>>> - if (atomic_dec_and_test(&conn->refcnt)) {
>>>>> + if (atomic_dec_and_test(&conn->refcnt) &&
>>>>> +     !test_bit(HCI_CONN_DISC, &conn->flags)) {
>>>>>           unsigned long timeo;
>>>>
>>>> hci_abort_conn already checks if conn->abort_reason was already set, to
>>>> avoid queuing abort for the same conn again. Does this flag not try to
>>>> do the same thing?
>>>
>>> That is not enough. hci_conn occur UAF in hci_proto_disconn_ind() before enter
>>> hci_abort_conn().
>>
>> Thanks, this was not clear to me from the patch.
>>
>> So the problem is that the cancel_delayed_work_sync(&conn->disc_work)
>> in hci_conn_del doesn't help in a few cases:
>>
>> 1. [task A] hci_conn_del(conn) entered
>> 2. [A] cancel_delayed_work_sync(conn->disc_work)
>> 3. [B] concurrent hci_conn_drop(conn) queues disc_work again
>> 4. [A] hci_conn_del finishes
>> 5. UAF when disc_work runs
>>
>> or without needing concurrency
>>
>> 1. hci_conn_del(conn) entered and finishes
>> 2. hci_conn_drop(conn); hci_conn_put(conn); as done in several places
>>
>> ?
> 
> Either way Im not sure what the IDA logic has to with it, that said I
> think using ida function is actually a much better solution then the
> lookup one so I would be happy to apply it if someone split the
> changes related to it and send a patch.

I will send a patch just with handle ida modification. The remaining UAF issues
continue to be tracked.

> 
>> The hci_conn_del here is not necessarily from hci_abort_conn. Should
>> the atomic flag be set in hci_conn_del before
>> cancel_delayed_work_sync(&conn->disc_work) to catch possible other
>> cases?
>>
