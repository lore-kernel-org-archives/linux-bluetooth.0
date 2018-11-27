Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75B9C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21782133F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 12:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ3nKgGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21782133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeK0XUe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:20:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35902 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeK0XUe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 18:20:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so3064203plo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eRUASiDJyX+cBWzxLa6nWiYZ69VjfJiS0+i/e5pxuyo=;
        b=AZ3nKgGCGPPAr/i93drbycKEb2/VFL+rqtsXwr2SXoB16sIm/26S9t4oJjzjFjQTzB
         HqEXSyUvnhj9CqCcwtzzcfpNBoiHR1BQM7VE4y/4QHREGerfhf1g+qAqHLATlaan7YqI
         mKq3XawVatP4TWcnQP8Q86P9h75J4CEO9MSmGtP0b04Sswsl0y4WbpT6+kJ9b0Yf3BaL
         myYWt45PhWfwYM3Vys3DmlNPXiS4aUyQbi8alkakI+3ahGAYfk0Z9qGn42F5SKXJhzsP
         MP9TXW17pCzeWbWxFzoVUGGv2BE3nQj0LPbEwnjv+0paJdidIpZeLI9livwRFS8GRMQ2
         09vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eRUASiDJyX+cBWzxLa6nWiYZ69VjfJiS0+i/e5pxuyo=;
        b=JVHTsjVfziAgwhr+UbrkA9qMJaFctWt3IGjBhityYB8lvHFMQPe7a0rR9qyjj6wpw6
         fMyOSKv0JoJGUmEShEsnzFq6N25m6nDZdnrRypamm2j45U1yOJMJ1vfyLaFMdAj6DYAs
         D5iqgo+SqyIhadaKD4AgbbAZ+ipQ/PxLJ02RIR3oTKrlrQbwTMkVBQlG1ssZ18kgHpYZ
         WuBG9cVVlQiibSLHAMoZW0ihlQfiUVwSeJEdzSSSIgFyIKmM31PjIObyQ+y8dEsoJcP9
         ofj/lkce72f8yk3uylYVLbJCFwWk2x+Mgs6ggCJdKipoR3Hrbv7RipstxPSDhThrAUl2
         FL6Q==
X-Gm-Message-State: AA+aEWblI3Yum50AtCt/iIlBanDP2zrIuWzzapRhtRD0a+ueaFQuSnZL
        ZEFwYSH4KQ12Us4nKgRO+Q5vjiYV4Jw=
X-Google-Smtp-Source: AFSGD/WUdx9ys9k5xiRmHQX9/UaBS1o5PTJu2MiVVrUVQ8tN/cLVpbY3ko1kquTIvxEZTbD/TDQ/mg==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr16408727plr.56.1543321368753;
        Tue, 27 Nov 2018 04:22:48 -0800 (PST)
Received: from [0.0.0.0] (unknown-105-122.windriver.com. [147.11.105.122])
        by smtp.googlemail.com with ESMTPSA id l85sm1641033pfg.161.2018.11.27.04.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 04:22:48 -0800 (PST)
Subject: Re: [PATCH 1/1 v2] Bluetooth: make the balance of judgement condition
 to fix a false report
To:     Johan Hedberg <johan.hedberg@gmail.com>
References: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
 <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
 <00BD5234-6645-4E40-9B3C-859C147EEB7C@gmail.com>
 <3D63F92F-1BA5-415D-AED4-A38FB2E29C00@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Zumeng Chen <zumeng.chen@gmail.com>
Message-ID: <1704c39f-c005-d0cc-9bab-c21e537a07be@gmail.com>
Date:   Tue, 27 Nov 2018 20:22:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <3D63F92F-1BA5-415D-AED4-A38FB2E29C00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2018年11月27日 17:34, Johan Hedberg wrote:
> On 27 Nov 2018, at 11.24, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> On 15 Nov 2018, at 3.31, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
>>> 		return true;
>>> 	}
>>>
>>> -	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
>>> +	if (!(hdr->evt == HCI_EV_CMD_COMPLETE ||
>>> +	      hdr->evt == HCI_EV_CMD_STATUS)) {
>>> 		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
>>> 			   hdr->evt);
>>> 		return false;
>> This is not correct. The purpose of this function is to retrieve the command complete parameters, or the parameters of a specific event if the sending code indicated it (it didn’t in this case). Since the event was not command complete the right behaviour for this function is to fail, i.e. return false. The only issue here is the bt_dev_err, which should probably be downgraded to a BT_DBG. In fact, that’s what it used to be in the past - I’m not sure why it was changed to bt_dev_err.
> The one improvement I’d make however, is to silently return from the function in case of a Command Status event, since that just means that the request is complete, however there are no extra parameters to be retrieved. I’ll be sending a patch for that in a moment.

There is a related kernel as shown in the below list

https://bugzilla.kernel.org/show_bug.cgi?id=198699

I didn't think my patch is to fix this one because I think we need to 
sort out
the whole logic of CMD_COMPLETE. But my patch is good to fix the issue
described by subject.

Cheers,
Zumeng
>
> Johan
>

