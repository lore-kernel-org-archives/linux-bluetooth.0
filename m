Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB34C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 11:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D1820823
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 11:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfARLLD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:11:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46669 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfARLLD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 06:11:03 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF449CEE14;
        Fri, 18 Jan 2019 12:18:47 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 2/2] Bluetooth: check the buffer size for some messages
 before parsing
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118102123.GB20179@kroah.com>
Date:   Fri, 18 Jan 2019 12:11:01 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        Ran Menscher <ran.menscher@karambasecurity.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <8D42DA95-47AB-47B0-B8A5-0F7FF8C786E4@holtmann.org>
References: <20190110062833.GA15047@kroah.com>
 <20190110062917.GB15047@kroah.com>
 <39E6B251-4ED3-4C0F-B8A2-0FAAF6E905A6@holtmann.org>
 <20190118102123.GB20179@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Greg,

>>> The L2CAP_CONF_EFS and L2CAP_CONF_RFC messages can be sent from
>>> userspace so their structure sizes need to be checked before parsing
>>> them.
>> 
>> this message is confusing me. How can these be send from userspace?
> 
> So claimed the original reporter.  You have the information in your
> inbox, is it incorrect?

I am pretty sure he meant that the remote attacker can control it from userspace. This is still a wire protocol and not some socket options.

>>> 
>>> Based on a patch from Ran Menscher.
>>> 
>>> Reported-by: Ran Menscher <ran.menscher@karambasecurity.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>> net/bluetooth/l2cap_core.c | 12 ++++++++----
>>> 1 file changed, 8 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index 93daf94565cf..55e48e6efc2b 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -3361,7 +3361,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>>> 			break;
>>> 
>>> 		case L2CAP_CONF_RFC:
>>> -			if (olen == sizeof(rfc))
>>> +			if ((olen == sizeof(rfc)) &&
>>> +			    (endptr - ptr >= L2CAP_CONF_OPT_SIZE + sizeof(rfc)))
>>> 				memcpy(&rfc, (void *) val, olen);
>> 
>> We don’t do ((x == y) && (..)) actually. Using (x == y && ..) is plenty.
> 
> Ick, ok, whatever, you all trust that your brains can remember C
> priority levels, me, I trust ()...
> 
> I can fix this up to remove the extra (), but I would like _SOMEONE_ to
> at least validate that this resolves the reported issues…

I need to reproduce this and then I can tell you.

Regards

Marcel

