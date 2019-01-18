Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE8C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF882133D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfARMIf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:08:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48449 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfARMIf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 07:08:35 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 352A8CEE14;
        Fri, 18 Jan 2019 13:16:20 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/2] Bluetooth: check message types in l2cap_get_conf_opt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CFEFF965-E86B-4BDF-A72F-C1EE3E1D97BF@holtmann.org>
Date:   Fri, 18 Jan 2019 13:08:33 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <055645D1-A6AC-4ED6-8A44-37F787A9EC5A@holtmann.org>
References: <20190110062833.GA15047@kroah.com>
 <E3A13BCC-C138-4E76-A379-A32CBB9AFF26@holtmann.org>
 <20190118101947.GA20179@kroah.com>
 <CFEFF965-E86B-4BDF-A72F-C1EE3E1D97BF@holtmann.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Greg,

>>>> l2cap_get_conf_opt can handle a "default" message type, but it needs to
>>>> be verified that it really is the correct type (CONF_EFS or CONF_RFC)
>>>> before passing it back to the caller.  To do this we need to check the
>>>> return value of this call now and handle the error correctly up the
>>>> stack.
>>>> 
>>>> Based on a patch from Ran Menscher.
>>>> 
>>>> Reported-by: Ran Menscher <ran.menscher@karambasecurity.com>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>> net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++------
>>>> 1 file changed, 19 insertions(+), 6 deletions(-)
>>>> 
>>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>>> index 2a7fb517d460..93daf94565cf 100644
>>>> --- a/net/bluetooth/l2cap_core.c
>>>> +++ b/net/bluetooth/l2cap_core.c
>>>> @@ -2980,6 +2980,10 @@ static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
>>>> 		break;
>>>> 
>>>> 	default:
>>>> +		/* Only CONF_EFS and CONF_RFC are allowed here */
>>>> +		if ((opt->type != L2CAP_CONF_EFS) &&
>>>> +		    (opt->type != L2CAP_CONF_RFC))
>>>> +			return -EPROTO;
>>> 
>>> after re-reading that specification, this also includes CONF_QOS since that is a multi-field variable as well. Even if we currently don’t act on that field, we need to accept it being send.
>> 
>> /me hands you some \n characters...
>> 
>> Ok, will fix up.
>> 
>>>> 		*val = (unsigned long) opt->val;
>>>> 		break;
>>>> 	}
>>>> @@ -3324,7 +3328,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>>>> 	void *endptr = data + data_size;
>>>> 	void *req = chan->conf_req;
>>>> 	int len = chan->conf_len;
>>>> -	int type, hint, olen;
>>>> +	int type, hint, olen, err;
>>>> 	unsigned long val;
>>>> 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
>>>> 	struct l2cap_conf_efs efs;
>>>> @@ -3336,7 +3340,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>>>> 	BT_DBG("chan %p", chan);
>>>> 
>>>> 	while (len >= L2CAP_CONF_OPT_SIZE) {
>>>> -		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
>>>> +		err = l2cap_get_conf_opt(&req, &type, &olen, &val);
>>>> +		if (err < 0)
>>>> +			return err;
>>>> +		len -= err;
>>> 
>>> We need to handle not yet known options correctly since otherwise we are breaking forwards compatibility if newer specifications introduce new parameters. So just returning with an error here is not acceptable. It will fail qualification test cases.
>> 
>> So what should we do here?  We can't keep going as the size is
>> incorrect.
>> 
>>> Don’t we rather have proper length checks in l2cap_parse_conf_{req,rsp} instead of doing this. I think your second patch is enough.
>> 
>> It is?  Ok, if that's all that is needed, that's fine with me.  I was
>> just taking the patch from the original submitter, I don't understand
>> the bluetooth protocol at all :)
> 
> I need to get my brain back into the nasty details of that protocol. I know for sure that just aborting is violating the handling of unknown options and that will fail qualification.
> 
> Let me look at how they managed to trick us.

actually this one was easy to understand. Just fixing was overly complicated by focusing on the default case and then punching in exceptions.

Since all option types are fixed size, I now added length checks to these. Patch has been posted.

Regards

Marcel

