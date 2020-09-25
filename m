Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07AAC4727F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827FA21D42
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 17:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIYRdk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:33:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34137 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYRdj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 13:33:39 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id BF348CECDF;
        Fri, 25 Sep 2020 19:40:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: Fix the vulnerable issue on enc key size
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <21f9469eda2747eca351a1cb811a4834@realsil.com.cn>
Date:   Fri, 25 Sep 2020 19:33:34 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <B1309F72-4077-45BD-BD12-DEF324CAE2C6@holtmann.org>
References: <21f9469eda2747eca351a1cb811a4834@realsil.com.cn>
To:     =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alex,

>>> When someone attacks the service provider, it creates connection,
>>> authenticates. Then it requests key size of one byte and it identifies
>>> the key with brute force methods.
>>> 
>>> After l2cap info req/resp exchange is complete. the attacker sends l2cap
>>> connect with specific PSM.
>>> 
>>> In above procedure, there is no chance for the service provider to check
>>> the encryption key size before l2cap_connect(). Because the state of
>>> l2cap chan in conn->chan_l is BT_LISTEN, there is no l2cap chan with the
>>> state of BT_CONNECT or BT_CONNECT2.
>>> 
>>> So service provider should check the encryption key size in
>>> l2cap_connect()
>>> 
>>> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
>>> ---
>>> net/bluetooth/l2cap_core.c | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>> 
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index ade83e224567..63df961d402d 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -4150,6 +4150,13 @@ static struct l2cap_chan *l2cap_connect(struct
>> l2cap_conn *conn,
>>> 
>>> 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
>>> 		if (l2cap_chan_check_security(chan, false)) {
>>> +			if (!l2cap_check_enc_key_size(conn->hcon)) {
>>> +				l2cap_state_change(chan, BT_DISCONN);
>>> +				__set_chan_timer(chan,
>> L2CAP_DISC_TIMEOUT);
>>> +				result = L2CAP_CR_SEC_BLOCK;
>>> +				status = L2CAP_CS_NO_INFO;
>>> +				goto response;
>>> +			}
>>> 			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
>>> 				l2cap_state_change(chan, BT_CONNECT2);
>>> 				result = L2CAP_CR_PEND;
>> 
>> I am not following what you are trying to fix here. Can you show this with a
>> btmon trace from an attacking device?
>> 
>> Regards
>> 
>> Marcel
>> 
>> 
> 
> I'm sorry, I didn't have btmon trace from an attacking device.
> I didn't have the real attacking device. I just simulate the attacking.
> I have a device that can create one byte size encryption key.
> It uses the link key that was produced by pairing with the service provider. Actually the KNOB (Key Negotiation of Bluetooth Attack) says, the link key is unnecessary for the reconnection.
> I use this device to reconnect to service provider, and then initiate the Key Negotiation for one byte size encryption key. Actually the attacker identified the encryption key with some brute force methods.
> 
> I want to provide the trace on service provider side.

what kernel version are you running? I wonder if we should always return L2CAP_CR_PEND here. Do you have a reproducer code?

The problem really is that the MASK_REQ_DONE indication is not enough to make a decision for the key size. We have to ensure that also the key size is actually available. If that is not yet done, then we should not check it. This means that any response to L2CAP_Connect_Request PDU needs to be delayed until the key size has been read.

Regards

Marcel

