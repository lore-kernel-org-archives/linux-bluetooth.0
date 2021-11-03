Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 08:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8027460EB4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 08:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhKCIaw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:30:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52481 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhKCIaw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 04:30:52 -0400
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id B6ABBCED07;
        Wed,  3 Nov 2021 09:28:14 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: hci_sync: Set Privacy Mode when updating the
 resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLbU=qUa91Nj45B2nD=GHbAu6j=mCWP+ZkA23a733rfww@mail.gmail.com>
Date:   Wed, 3 Nov 2021 09:28:14 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <AF9E9ADC-B77F-4C07-B030-84BC40472739@holtmann.org>
References: <20211102055116.2898794-1-luiz.dentz@gmail.com>
 <6313C3AD-AEA9-4E4E-98C4-3F1C62DE04CA@holtmann.org>
 <CABBYNZLbU=qUa91Nj45B2nD=GHbAu6j=mCWP+ZkA23a733rfww@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds support for Set Privacy Mode when updating the resolving list
>>> when HCI_LIMITED_PRIVACY so the controller shall use Device Mode for
>>> devices programmed in the resolving list, Device Mode is actually
>>> required when the remote device are not able to use RPA as otherwise the
>>> default mode is Network Privacy Mode in which only RPA are allowed thus
>>> the controller would filter out advertisement using the identity address
>>> for which there is an IRK.
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> include/net/bluetooth/hci.h |  7 ++++++
>>> net/bluetooth/hci_sync.c    | 48 ++++++++++++++++++++++++++++++++-----
>>> 2 files changed, 49 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 63065bc01b76..aa856dfd5b9f 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -1930,6 +1930,13 @@ struct hci_rp_le_read_transmit_power {
>>>      __s8  max_le_tx_power;
>>> } __packed;
>>> 
>>> +#define HCI_OP_LE_SET_PRIVACY_MODE   0x204e
>>> +struct hci_cp_le_set_privacy_mode {
>>> +     __u8  bdaddr_type;
>>> +     bdaddr_t  bdaddr;
>>> +     __u8  mode;
>>> +} __packed;
>>> +
>>> #define HCI_OP_LE_READ_BUFFER_SIZE_V2 0x2060
>>> struct hci_rp_le_read_buffer_size_v2 {
>>>      __u8    status;
>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>> index b794605dc882..43173d645436 100644
>>> --- a/net/bluetooth/hci_sync.c
>>> +++ b/net/bluetooth/hci_sync.c
>>> @@ -1580,8 +1580,37 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
>>>                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>>> }
>>> 
>>> +/* Set Device Privacy Mode. */
>>> +static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
>>> +                                     struct hci_conn_params *params)
>>> +{
>>> +     struct hci_cp_le_set_privacy_mode cp;
>>> +     struct smp_irk *irk;
>>> +
>>> +     /* Set Privacy Mode requires the use of resolving list (aka. LL Privacy)
>>> +      * by default Network Mode is used so only really send the command if
>>> +      * Device Mode is required (HCI_LIMITED_PRIVACY).
>>> +      */
>>> +     if (!use_ll_privacy(hdev) ||
>>> +         !hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
>>> +             return 0;
>>> +
>>> +     irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
>>> +     if (!irk)
>>> +             return 0;
>>> +
>>> +     memset(&cp, 0, sizeof(cp));
>>> +     cp.bdaddr_type = irk->addr_type;
>>> +     bacpy(&cp.bdaddr, &irk->bdaddr);
>>> +     cp.mode = 0x01;
>>> +
>> 
>> you need to check if this command is actually supported.
> 
> The spec suggests it is mandatory if LL Privacy is supported:
> 
> 'C9: Mandatory if LE Feature (LL Privacy) is supported, otherwise excluded.'

and what about Bluetooth 4.2 spec. devices? Not all earlier specs have both features.

>> I think the best option is to add it to Set Device Flags and let bluetoothd set it on a per device basis like it does with the wakeup flag.
> 
> Got it, I guess

I prefer Set Device Flags since with Get Device Flags you can indicate if this is supported or not.

>> Trying to tie it to the Limited Privacy mode seems weird. Since that is for discoverability and this is for outgoing connections.
> 
> Hmm, I'm afraid this wouldn't follow the spec to the letter then since
> it doesn't actually split Incoming/advertising and Outgoing/scanning
> privacy, it does seems to be global so if we go with different
> settings to control each direction separately we may end up with a
> custom mode e.g: limited discoverability for advertising vs network
> privacy mode for scanning, for instance limited discoverability does
> blast the public address while discoverable and bondable but both
> privacy modes seems to require the use of RPA, anyway it would
> probably be a good idea to document the interactions, also main.conf
> seem to have gone with privacy from the specification so we may either
> need add more modes:
> 
> Privacy:
> "on"/"network": Apply Network Privacy Mode both for advertising and scanning
> "limited-network": Apply Limited Discoverable Mode to advertising and
> Network Privacy Mode for scanning
> "device": Apply Device Privacy Mode both for advertising and scanning
> "limited-device": Apply Limited Discoverable Mode to advertising and
> Device Privacy Mode for scanning

Then we can do that and use Limited Privacy mode for exactly that. However in addition I would use the Set Device Flags to allow punching holes for specific devices.

Regards

Marcel

