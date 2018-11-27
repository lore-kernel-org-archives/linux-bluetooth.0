Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDEAC43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 12:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269E72133F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 12:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJHeU51h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269E72133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbeK0XK5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:10:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53201 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbeK0XK5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 18:10:57 -0500
Received: by mail-it1-f194.google.com with SMTP id i7so33833018iti.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 04:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2g5f2VL6Nkzigj+vOzYnQ4P1n58Ayikr02eBRZIasiY=;
        b=YJHeU51h+MHx41GWDYTpsEecD1kCu6wwuDYCU1shLZL2dDzeB5sKE6lM3j5xSTo8bG
         tr3WCsnvqjdqRlwJBE6XmC+YuKmOQLIfZFOPB5Tc4RiVax+mDXmFZfwF74sqGAjkw+S/
         XH0UXEiPHedSzy6cuEM51Q4lEQNdXqJmrcGLntfHI0w7x8bKnTV3ilHNOoK8aD6rGUGL
         skoZH3Rrb4Nq77sBmIj5CwBrI7so7rfefVoW71EIzMy+TQ4LFZZMqvGJNWQ3jvDAQ6WK
         dnGUkrsh8f88hGAEGcnslcrfS2i6x+TOusG7/QhTENAjLa05cnHwZMm50AxyRGkO/wP5
         GmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2g5f2VL6Nkzigj+vOzYnQ4P1n58Ayikr02eBRZIasiY=;
        b=ErHv2AgqTAro2uTWbanofXzVzy0h/HTge4E4C9E+nSWxRc7np8M1mV8gJg1d9FOkTj
         8Z1n6XoQbEDU9zLQiLEKl/HoMJm+nYKLQbjPeEZOxztoRSQyztqnrqMIT7y5wS95Y0jl
         +15YwFHu7UDXOlmWhAX5Sz5Sa1eBvwqDs5kjgqBZwW225++FYY9aHxq+ZEH7YCl5j98u
         dwkUH+PK22tNsUI2BQSUA8l4BFutc0AfGJfnqDpqIj3ChcpNZbZI7GfafHLxY7fCsYf9
         0v/2XmIZaog8YZi8OeWnslSWbuDfrUFcfndt8imKFGlBqk8mXC99IDcpmjE9Ij7e8BxW
         3K2g==
X-Gm-Message-State: AA+aEWb2wAmZXP+x/SLYMJNtWbbnvOjLgDw2D5asc002YhT0Ng5oVfHt
        EMnM3j5PIQVM05SqKiNUMjyvRJcL1n4=
X-Google-Smtp-Source: AFSGD/XVOkIHDm1ko/JQtHgPDElPRt+qFV7zXXSinGsv/I1jcLzUKRP0M9e2a9abbGdJ5X10oVlEUg==
X-Received: by 2002:a02:9b26:: with SMTP id o35mr28515606jak.23.1543320794136;
        Tue, 27 Nov 2018 04:13:14 -0800 (PST)
Received: from [0.0.0.0] (unknown-105-122.windriver.com. [147.11.105.122])
        by smtp.googlemail.com with ESMTPSA id h140sm1583042itb.23.2018.11.27.04.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 04:13:13 -0800 (PST)
Subject: Re: [PATCH 1/1 v2] Bluetooth: make the balance of judgement condition
 to fix a false report
To:     Johan Hedberg <johan.hedberg@gmail.com>
References: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
 <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
 <00BD5234-6645-4E40-9B3C-859C147EEB7C@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Zumeng Chen <zumeng.chen@gmail.com>
Message-ID: <bec61fb3-3fab-fc1e-60da-cdf8046ca104@gmail.com>
Date:   Tue, 27 Nov 2018 20:13:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <00BD5234-6645-4E40-9B3C-859C147EEB7C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2018年11月27日 17:24, Johan Hedberg wrote:
> Hi,
>
>
>> On 15 Nov 2018, at 3.31, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
>> 		return true;
>> 	}
>>
>> -	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
>> +	if (!(hdr->evt == HCI_EV_CMD_COMPLETE ||
>> +	      hdr->evt == HCI_EV_CMD_STATUS)) {
>> 		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
>> 			   hdr->evt);
>> 		return false;
> This is not correct. The purpose of this function is to retrieve the command complete parameters, or the parameters of a specific event if the sending code indicated it (it didn’t in this case). Since the event was not command complete the right behaviour for this function is to fail, i.e. return false.

Ha, John, I'm pretty sure you do not debug these codes here by yourself, 
but one
point is right, the name has a little confusion.

>   The only issue here is the bt_dev_err, which should probably be downgraded to a BT_DBG. In fact, that’s what it used to be in the past - I’m not sure why it was changed to bt_dev_err.

It has nothing to do with bt_dev_err, BT_DBG just mutes the issues. 
whether or not
it will go wrong there if your driver level didn't take care of some 
events. Actually it's
OK to ignore it for most BT modules.

Cheers,
Zumeng
>
> Johan
>

