Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383291AbhLCVvF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:51:05 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41034 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383250AbhLCVvE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:51:04 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6366DCED20;
        Fri,  3 Dec 2021 22:47:39 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v3 3/4] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLsEYAWriqGnEOis0TMkNpPk3-xPzcCrBneNBcGyhC97Q@mail.gmail.com>
Date:   Fri, 3 Dec 2021 22:47:38 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <42067C5D-4DB4-4DC1-B4BC-F0FE009E6061@holtmann.org>
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
 <20211120012448.1476960-3-luiz.dentz@gmail.com>
 <0B2956DC-56B1-43A2-BB4A-CF42ABFC9C30@holtmann.org>
 <CABBYNZKZ-VNtMDDAJrEokVUHqh8MSrZ8eR9mJaoX7ASrOt3tRQ@mail.gmail.com>
 <B7D70E25-E96B-4309-8EA3-00D8B9BF5F41@holtmann.org>
 <CABBYNZLsEYAWriqGnEOis0TMkNpPk3-xPzcCrBneNBcGyhC97Q@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>>> This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
>>>>> userspace to indicate to the controller to use Device Privacy Mode to a
>>>>> specific device.
>>>>> 
>>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>> ---
>>>>> include/net/bluetooth/hci_core.h |  1 +
>>>>> net/bluetooth/mgmt.c             | 12 ++++++++++++
>>>>> 2 files changed, 13 insertions(+)
>>>>> 
>>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>>>> index fc93a1907c90..9c94d1c49b25 100644
>>>>> --- a/include/net/bluetooth/hci_core.h
>>>>> +++ b/include/net/bluetooth/hci_core.h
>>>>> @@ -153,6 +153,7 @@ struct bdaddr_list_with_irk {
>>>>> 
>>>>> enum hci_conn_flags {
>>>>>     HCI_CONN_FLAG_REMOTE_WAKEUP,
>>>>> +     HCI_CONN_FLAG_DEVICE_PRIVACY,
>>>> 
>>>> coming this now, I wonder if we better call them FLAG_REMOTE_WAKEUP_SUPPORT and FLAG_DEVICE_PRIVACY_SUPPORT. If I am not mistaken, then these are for indicating support for it.
>>> 
>>> These flags are used in multiple places:
>>> 
>>> hci_dev->conn_flags
>>> hci_conn_params->conn_flags
>>> bdaddr_list_with_flags->flags
>>> 
>>> Which is one of the reason I made them all use  DECLARE_BITMAP(flags,
>>> __HCI_CONN_NUM_FLAGS) so they are in sync, the use of them in
>>> hci_dev->conn_flags means they are supported but in the other 2 it
>>> means they are in use, so I prefer leave as they are.
>> 
>> is my comment wrong? Don’t they always indicate the support for it?
> 
> Support vs Use, anyway I always think about the shortest form for
> defines and having some term like SUPPORT sounds a little superfluous
> for me, but I'm fine adding it if you really think that is necessary
> in this case.

I already applied 1/4 and 2/4. So just re-spin them to make them apply to bluetooth-next.

Regards

Marcel

