Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF5BC2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E000206BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDGXXX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:23:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56955 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGXXX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 19:23:23 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5FFC6CECDD;
        Wed,  8 Apr 2020 01:32:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Update resolving list when updating whitelist
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKsT9Svp7kKPfQkQZWPo2+KeokM0yHet6de=LjeANumMQ@mail.gmail.com>
Date:   Wed, 8 Apr 2020 01:23:21 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <8FE77D49-9522-42C0-BE0C-C282281389E9@holtmann.org>
References: <20200407205611.1002903-1-marcel@holtmann.org>
 <CABBYNZKsT9Svp7kKPfQkQZWPo2+KeokM0yHet6de=LjeANumMQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> When the whitelist is updated, then also update the entries of the
>> resolving list for devices where IRKs are available.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> net/bluetooth/hci_request.c | 37 +++++++++++++++++++++++++++++++++++--
>> 1 file changed, 35 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>> index efec2a0bb824..45fbda5323af 100644
>> --- a/net/bluetooth/hci_request.c
>> +++ b/net/bluetooth/hci_request.c
>> @@ -695,6 +695,21 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
>>        bt_dev_dbg(req->hdev, "Remove %pMR (0x%x) from whitelist", &cp.bdaddr,
>>                   cp.bdaddr_type);
>>        hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
>> +
>> +       if (use_ll_privacy(req->hdev)) {
>> +               struct smp_irk *irk;
>> +
>> +               irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
>> +               if (irk) {
>> +                       struct hci_cp_le_del_from_resolv_list cp;
>> +
>> +                       cp.bdaddr_type = bdaddr_type;
>> +                       bacpy(&cp.bdaddr, bdaddr);
>> +
>> +                       hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
>> +                                   sizeof(cp), &cp);
>> +               }
>> +       }
>> }
>> 
>> /* Adds connection to white list if needed. On error, returns -1. */
>> @@ -715,7 +730,7 @@ static int add_to_white_list(struct hci_request *req,
>>                return -1;
>> 
>>        /* White list can not be used with RPAs */
>> -       if (!allow_rpa &&
>> +       if (!allow_rpa && !use_ll_privacy(hdev) &&
>>            hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
>>                return -1;
>>        }
>> @@ -732,6 +747,24 @@ static int add_to_white_list(struct hci_request *req,
>>                   cp.bdaddr_type);
>>        hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
>> 
>> +       if (use_ll_privacy(hdev)) {
>> +               struct smp_irk *irk;
>> +
>> +               irk = hci_find_irk_by_addr(hdev, &params->addr,
>> +                                          params->addr_type);
>> +               if (irk) {
>> +                       struct hci_cp_le_add_to_resolv_list cp;
>> +
>> +                       cp.bdaddr_type = params->addr_type;
>> +                       bacpy(&cp.bdaddr, &params->addr);
>> +                       memcpy(cp.peer_irk, irk->val, 16);
>> +                       memset(cp.local_irk, 0, 16);
>> +
>> +                       hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST,
>> +                                   sizeof(cp), &cp);
> 
> Shouldn't we be checking if there is any space left in the list before
> trying to send the command? I wonder what would happen if there is too
> many IRKs, I guess that means we would still have to resolve them in
> the host.

the resolving list size is just a guesstimate and no guarantee that space is available. However my assumption is that if you have x entries for whitespace, then you also get x entries for the resolving list. If we are not putting the device in the whitelist, then it also makes no sense to add it to the resolving list.

Regards

Marcel

