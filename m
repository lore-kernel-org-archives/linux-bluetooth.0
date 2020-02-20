Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A64C11D01
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921E02465D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 07:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBTHey convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:34:54 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44311 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBTHey (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 02:34:54 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AE3FCCECDC;
        Thu, 20 Feb 2020 08:44:17 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: Fix - During le_conn_timeout disable EXT_ADV
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOVXEJKFgCYSfACM-pqsvZaJF2JWzcWTkyRPw3vbXGZGjhwcyQ@mail.gmail.com>
Date:   Thu, 20 Feb 2020 08:34:52 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <8A9D15AB-0A69-4BCA-A673-33F3A616C31E@holtmann.org>
References: <20200218123747.3006-1-sathish.narasimman@intel.com>
 <072E9094-BA5F-47CB-9740-B04A6DC5384D@holtmann.org>
 <CAOVXEJJ9NgkPocUmQS=f2204UEf2sfc8HrSmQ7ZvWYonKunRuQ@mail.gmail.com>
 <CAOVXEJKFgCYSfACM-pqsvZaJF2JWzcWTkyRPw3vbXGZGjhwcyQ@mail.gmail.com>
To:     Sathish Narasimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

>>>> Disabling LE_LEGACY_ADV when LE_EXT_ADV is enabled causes 'command
>>>> disallowed . This patch fixes that issue and disables EXT_ADV if
>>>> enabled.
>>>> 
>>>> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
>>>> ---
>>>> net/bluetooth/hci_conn.c | 16 +++++++++++++---
>>>> 1 file changed, 13 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>>> index a582c676e584..a8d8a876363c 100644
>>>> --- a/net/bluetooth/hci_conn.c
>>>> +++ b/net/bluetooth/hci_conn.c
>>>> @@ -481,9 +481,19 @@ static void le_conn_timeout(struct work_struct *work)
>>>>       * (which doesn't have a timeout of its own).
>>>>       */
>>>>      if (conn->role == HCI_ROLE_SLAVE) {
>>>> -             u8 enable = 0x00;
>>>> -             hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
>>>> -                          &enable);
>>>> +             if (ext_adv_capable(hdev)) {
>>>> +                     struct hci_cp_le_set_ext_adv_enable cp;
>>>> +
>>>> +                     cp.enable = 0x00;
>>>> +                     cp.num_of_sets = 0x00;
>>>> +
>>>> +                     hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
>>>> +                                  sizeof(cp), &cp);
>>>> +             } else {
>>>> +                     u8 enable = 0x00;
>>>> +                     hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
>>>> +                                  sizeof(enable), &enable);
>>>> +             }
>>> 
>>> hmmm, I wonder if it is better to create a helper function for this.
>>> 
>>> Regards
>>> 
>>> Marcel
>>> 
>> 
>> let me verify and submit patch with __hci_req_disable_advertising
>> 
>> Regards
>> Sathish N
> 
> calling __hci_req_disable_advertising is not working. the command is
> not getting executed
> I hope the below method is fine? where it works
> 
> +static void le_disable_advertising(struct hci_dev *hdev)
> +{
> +       if (ext_adv_capable(hdev)) {
> +               struct hci_cp_le_set_ext_adv_enable cp;
> +               cp.enable = 0x00;
> +               cp.num_of_sets = 0x00;
> +
> +               hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp),
> +                            &cp);
> +       } else {
> +               u8 enable = 0x00;
> +               hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> +                            sizeof(enable), &enable);
> +       }
> +
> +}

at first glance this looks fine.

Regards

Marcel

