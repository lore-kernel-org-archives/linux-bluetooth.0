Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D383C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 17:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbiBQRgk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:36:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiBQRgh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 12:36:37 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ABC72B3AC1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 09:36:22 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 911D6CECE3;
        Thu, 17 Feb 2022 18:36:21 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix not using conn_timeout
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKY7utNOKjMXT_YYbFNXMAjjOY3QmshYVE4aCp5g_DwjQ@mail.gmail.com>
Date:   Thu, 17 Feb 2022 18:36:21 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FB05C2BC-3219-4013-AE25-F65D4A11FFAB@holtmann.org>
References: <20220216221822.2694867-1-luiz.dentz@gmail.com>
 <85EF808B-F51B-4F3B-B484-5952D8DC108B@holtmann.org>
 <CABBYNZKY7utNOKjMXT_YYbFNXMAjjOY3QmshYVE4aCp5g_DwjQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> When using hci_le_create_conn_sync it shall wait for the conn_timeout
>>> since the connection complete may take longer than just 2 seconds.
>>> 
>>> Also fix the masking of HCI_EV_LE_ENHANCED_CONN_COMPLETE and
>>> HCI_EV_LE_CONN_COMPLETE so they are never both set so we can predict
>>> which one the controller will use in case of HCI_OP_LE_CREATE_CONN.
>>> 
>>> Fixes: 6cd29ec6ae5e3 ("Bluetooth: hci_sync: Wait for proper events when connecting LE")
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> net/bluetooth/hci_sync.c | 27 +++++++++++++++------------
>>> 1 file changed, 15 insertions(+), 12 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>> index 9dbf007e3dc7..002f9c5b5371 100644
>>> --- a/net/bluetooth/hci_sync.c
>>> +++ b/net/bluetooth/hci_sync.c
>>> @@ -3265,11 +3265,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
>>>      if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
>>>              events[0] |= 0x40;      /* LE Data Length Change */
>>> 
>>> -     /* If the controller supports LL Privacy feature, enable
>>> -      * the corresponding event.
>>> +     /* If the controller supports LL Privacy feature or LE Extended
>>> +      * Create Connection, enable the corresponding event.
>>>       */
>>> -     if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
>>> +     if (ll_privacy_capable(hdev) || hdev->commands[37] & 0x80) {
>>>              events[1] |= 0x02;      /* LE Enhanced Connection Complete */
>>> +     } else if (hdev->commands[26] & 0x10) {
>>> +             /* If the controller supports the LE Create Connection
>>> +              * command, enable the corresponding event.
>>> +              */
>>> +             events[0] |= 0x01;      /* LE Connection Complete */
>>> +     }
>>> 
>>>      /* If the controller supports Extended Scanner Filter
>>>       * Policies, enable the corresponding event.
>>> @@ -3289,12 +3295,6 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
>>>      if (hdev->commands[26] & 0x08)
>>>              events[0] |= 0x02;      /* LE Advertising Report */
>>> 
>>> -     /* If the controller supports the LE Create Connection
>>> -      * command, enable the corresponding event.
>>> -      */
>>> -     if (hdev->commands[26] & 0x10)
>>> -             events[0] |= 0x01;      /* LE Connection Complete */
>>> -
>> 
>> I do not understand why you are trying to intermix this with LL Privacy. If the controller supports the LE Extended Create Connection, then we should enable that event. No matter if we have LL Privacy supported or enabled.
>> 
>> If we have other code that intermixes this, then it needs to be untangled.
>> 
>> What we should be doing is to only support LL Privacy if we also have support for LE Extended Create Connection command, but the assumption the other way around makes no sense.
> 
> The spec does allow the use of LE Create Connection and Enhanced
> Connection Complete since it does support own_address_type to be
> 0x02/0x03 which means LL Privacy, I believe LE Extented Create
> Connection was introduced much later than LL Privacy so we may find
> controllers supporting LL Privacy with LE Create Connection but
> without support for LE Extended Create Connection.

my memory is getting old and even while I actively worked on 4.2 and 5.x specs, I keep forgetting details.

So here is the thing from the latest specs for the LE Enhanced Connection Complete event:

C24: Mandatory if the Controller supports Connection State and either LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supported, otherwise optional if the Controller supports Connection State, otherwise excluded.

That means that when either of these features are listed as supported, we unmask the event. Keep the LE Connection Complete also unmasked since the spec is clear that if both are unmasked the “enhanced” version shall be used.

Maybe introduce an use_enhanced_conn_complete() macro.

Regards

Marcel

