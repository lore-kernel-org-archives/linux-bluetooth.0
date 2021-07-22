Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8D9C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AB3610F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGVRTL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:19:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35024 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhGVRTK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 13:19:10 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id 10258CECE5;
        Thu, 22 Jul 2021 19:59:44 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v10 10/10] Bluetooth: Add offload feature under
 experimental flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKMrq_6Rb9rJKhMU-w=WjznQsVc=yYfDVuxKtEjvtNLdw@mail.gmail.com>
Date:   Thu, 22 Jul 2021 19:59:43 +0200
Cc:     Kiran K <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <87EBBD58-71B1-4712-A5BC-8B53E739DAFE@holtmann.org>
References: <20210630080807.12600-1-kiran.k@intel.com>
 <20210630080807.12600-10-kiran.k@intel.com>
 <CABBYNZK-bE6vxikRHhxBM_7ucyZqMjxUBY6VEyw_e8C_xxAigA@mail.gmail.com>
 <B7EC95F8-FFDF-40CE-83B6-85861D530FD5@holtmann.org>
 <CABBYNZKMrq_6Rb9rJKhMU-w=WjznQsVc=yYfDVuxKtEjvtNLdw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>> Allow user level process to enable / disable codec offload
>>>> feature through mgmt interface. By default offload codec feature
>>>> is disabled.
>>>> 
>>>> Signed-off-by: Kiran K <kiran.k@intel.com>
>>>> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>>>> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
>>>> ---
>>>> * changes in v10:
>>>> - new patch added to place offload codec feature under experimental flag
>>>> 
>>>> include/net/bluetooth/hci.h |   4 ++
>>>> net/bluetooth/mgmt.c        | 106 +++++++++++++++++++++++++++++++++++-
>>>> net/bluetooth/sco.c         |  10 ++++
>>>> 3 files changed, 119 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>> index e20318854900..5ca98d9f64dd 100644
>>>> --- a/include/net/bluetooth/hci.h
>>>> +++ b/include/net/bluetooth/hci.h
>>>> @@ -331,6 +331,10 @@ enum {
>>>>       HCI_CMD_PENDING,
>>>>       HCI_FORCE_NO_MITM,
>>>> 
>>>> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
>>>> +       HCI_OFFLOAD_CODECS_ENABLED,
>>>> +#endif
>>> 
>>> That is probably a bad idea as it could lead the enum to assume
>>> different values based on what is enabled, besides we don't gain
>>> anything by not having the symbol defined all the time.
>> 
>> While this would work with dev_flags which are internal and not API, I still don’t like it.
>> 
>> There is really no benefit to make this a compile time option. And as far as I remember I never said this needs to be compile time. Actually I rather have this as an experimental setting so that it can be switched on at runtime. Nobody is going to recompile their kernels to test codec offload.
> 
> Initially I was with the same opinion, but the problem is the codecs
> are read at init sequence and the experimental flags are set at a
> later stage thus why I suggested a KConfig option until the feature is
> more mature and we can remove the option altogether.

I am fine with the codec options being read all the time. I mean having an experimental option to control the use of offload.

Regards

Marcel

