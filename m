Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A40C2D0EA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 06:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BDF20747
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 06:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDHG0J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:26:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54783 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHG0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 02:26:09 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2F572CECE0;
        Wed,  8 Apr 2020 08:35:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Translate additional address type correctly
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mVOgoyM1HXPMbFwOuOopaizf6Dt_qd=-ghaoXhjkXAy=g@mail.gmail.com>
Date:   Wed, 8 Apr 2020 08:26:08 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <722F5D56-A8FE-4E18-B0B2-643432255E1F@holtmann.org>
References: <20200407211202.1008128-1-marcel@holtmann.org>
 <CANFp7mVOgoyM1HXPMbFwOuOopaizf6Dt_qd=-ghaoXhjkXAy=g@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

>> When using controller based address resolution, then the new address
>> types 0x02 and 0x03 are used. These types need to be converted back into
>> either public address or random address types.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> include/net/bluetooth/hci.h | 6 ++++--
>> net/bluetooth/hci_core.c    | 9 +++++++++
>> 2 files changed, 13 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 58360538d42b..74896536ebce 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -2257,8 +2257,10 @@ struct hci_ev_le_conn_complete {
>> #define LE_EXT_ADV_SCAN_RSP            0x0008
>> #define LE_EXT_ADV_LEGACY_PDU          0x0010
>> 
>> -#define ADDR_LE_DEV_PUBLIC     0x00
>> -#define ADDR_LE_DEV_RANDOM     0x01
>> +#define ADDR_LE_DEV_PUBLIC             0x00
>> +#define ADDR_LE_DEV_RANDOM             0x01
>> +#define ADDR_LE_DEV_PUBLIC_RESOLVED    0x02
>> +#define ADDR_LE_DEV_RANDOM_RESOLVED    0x03
>> 
>> #define HCI_EV_LE_ADVERTISING_REPORT   0x02
>> struct hci_ev_le_advertising_info {
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 589c4085499c..fb210f7ab7ab 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3145,6 +3145,15 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
>> {
>>        struct hci_conn_params *param;
>> 
>> +       switch (addr_type) {
>> +       case ADDR_LE_DEV_PUBLIC_RESOLVED:
>> +               addr_type = ADDR_LE_DEV_PUBLIC;
>> +               break;
>> +       case ADDR_LE_DEV_RANDOM:
> 
> This seems to be a typo. Should it be `case ADDR_LE_DEV_RANDOM_RESOLVED`?

indeed. I have not tested this with static address and identity address yet.

This address translation is needed in a few more places. Especially also in the Connection Complete events. And we also need to store the RPA used for the connection since it would be required for SMP.

Regards

Marcel

