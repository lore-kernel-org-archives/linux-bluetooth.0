Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D373C2F420
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581B520879
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 14:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfAUOvN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:51:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52707 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfAUOvN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 09:51:13 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 06EA6CEE94;
        Mon, 21 Jan 2019 15:58:58 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: Verify that l2cap_get_conf_opt provides large
 enough buffer
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118150044.GA31656@kroah.com>
Date:   Mon, 21 Jan 2019 15:51:11 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <70BE945F-F92B-4353-A2F8-41158CFEC535@holtmann.org>
References: <20190118124319.12187-1-marcel@holtmann.org>
 <20190118125342.GA31025@kroah.com>
 <93BDB9CB-55F3-415A-8EED-DD532C36BC8A@holtmann.org>
 <20190118150044.GA31656@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Greg,

>>>> The function l2cap_get_conf_opt will return L2CAP_CONF_OPT_SIZE + opt->len
>>>> as length value. The opt->len however is in control over the remote user
>>>> and can be used by an attacker to gain access beyond the bounds of the
>>>> actual packet.
>>>> 
>>>> To prevent any potential leak of heap memory, it is enough to check that
>>>> the resulting len calculation after calling l2cap_get_conf_opt is not
>>>> below zero. A well formed packet will always return >= 0 here and will
>>>> end with the length value being zero after the last option has been
>>>> parsed. In case of malformed packets messing with the opt->len field the
>>>> length value will become negative. If that is the case, then just abort
>>>> and ignore the option.
>>>> 
>>>> In case an attacker uses a too short opt->len value, then garbage will
>>>> be parsed, but that is protected by the unknown option handling and also
>>>> the option parameter size checks.
>>>> 
>>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>> ---
>>>> net/bluetooth/l2cap_core.c | 6 ++++++
>>>> 1 file changed, 6 insertions(+)
>>>> 
>>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>>> index 77799e7d5a34..ccdc5c67d22a 100644
>>>> --- a/net/bluetooth/l2cap_core.c
>>>> +++ b/net/bluetooth/l2cap_core.c
>>>> @@ -3337,6 +3337,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>>>> 
>>>> 	while (len >= L2CAP_CONF_OPT_SIZE) {
>>>> 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
>>>> +		if (len < 0)
>>>> +			break;
>>> 
>>> <snip>
>>> 
>>> Patch looks good to me, thanks for fixing this all up:
>> 
>> it would be still good if we can get this verified by the reporter.
> 
> The "reporter" seems to have disappeared once they reported this stuff,
> so I would not count on them doing anything here, we asked numerous
> times :(
> 
> If the patches look correct, I recommend just merging it and I can
> backport it to the stable releases and the distros can pick it up from
> there.

I think that I have Johan merge them into bluetooth-next first and let them sit a little so we can verify they do not break anything else. You can pick them up later into -stable if nobody complained and we didn’t break qualification.

Regards

Marcel

