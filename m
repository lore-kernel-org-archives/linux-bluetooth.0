Return-Path: <SRS0=lHyt=SE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77994C4360F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACC92070D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2tNKeSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfDBSq2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:46:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35198 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfDBSq1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Apr 2019 14:46:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so12629408edb.2;
        Tue, 02 Apr 2019 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hY7SZ5HIhFAFytatNUA/0U8YQqP3QRWzFejxjMBfAJU=;
        b=U2tNKeSkTti/XoO8HwlNGgkaIGK4jsX1GEmOFQd8BlOFR5xEO6UDxzbMIhnGtJ7fLY
         h+IjNp1iewWpR2TUcmP7DVpHTyIuvvhskcDLSkBpl920rDstcDO6omLOqwF+QrDW4iFX
         RP2opyueF92NCr2QDAoLZ8N7G2rH+zVCnuivoYf5TB7rDp7uh0bS5jR45S6yOUM3Q4Mt
         eblzTL9+n2xgmJSKZN2CkUnoNsGt3rKxthu189MQ8tc+xp/aZpC38BsqNleNziFDvl1Z
         9lBZSiAuPamBRZY20vyDHbQ023Oiy8qpPw4oJoTUwsI3LV3oPjxTn8kSjKk1x05PywiZ
         isVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hY7SZ5HIhFAFytatNUA/0U8YQqP3QRWzFejxjMBfAJU=;
        b=oa1E5zIbRxJjoKORxrHhvbFEJoQu77s+D9mW1Pw2u+ficbop3HNbjwoXLklw+r2sxx
         Krhh3FkanSnwcjiSnELMxoK1xSt6Jygw7YbdYi7vsyoMPi4NgnFvhMnKKFR/WWR/Ksxy
         t40cXRra1yMqcjdIf0pVg89ZJxG0Va/3txpWQGyUjmJreWyANdJplif6wImhekN9qvGo
         /Ymdfqtu/98tRymis5wLqmzlsy8wjkk/ZpjakDhKp9e+aFyk0GDa3lprxsqMx9TJ6AsL
         F8mBG/+LiFjyk7jjibkhbRvYdPKqrpKiQ09cPYm/SfNnNkMufMgshcY1XRieI+Ym+7LG
         Je+w==
X-Gm-Message-State: APjAAAVbezv24pamIvrZLWn1CnEvb4BmHph9/qpY/6OIwxIMPeq6cO7q
        zyRyscVPsk6+CYxW3Aa3Ckx93dpwK9E=
X-Google-Smtp-Source: APXvYqzpU2tVFVSHoQzNwlbWsKsGcvJDj6yb925tlQvwTUQMmfR6QP4VC+z0mO6h7yAgiau2TSx/Kw==
X-Received: by 2002:a17:906:b291:: with SMTP id q17mr41420554ejz.56.1554230785018;
        Tue, 02 Apr 2019 11:46:25 -0700 (PDT)
Received: from [192.168.0.61] (xd520f246.cust.hiper.dk. [213.32.242.70])
        by smtp.gmail.com with ESMTPSA id e3sm4248661edb.22.2019.04.02.11.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 11:46:23 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV
 events
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam>
 <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c4541728-5dd9-75d5-7d02-6160bfc769e7@gmail.com>
Date:   Tue, 2 Apr 2019 20:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Cong,

On 4/2/19 7:42 PM, Cong Wang wrote:
> On Mon, Apr 1, 2019 at 11:33 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> On Mon, Apr 01, 2019 at 11:03:53AM -0700, Cong Wang wrote:
>>> Hi,
>>>
>>> On Sat, Mar 30, 2019 at 2:23 AM Tomas Bortoli <tomasbortoli@gmail.com> wrote:
>>>>
>>>> Hi Dan,
>>>>
>>>> On 3/30/19 8:25 AM, Dan Carpenter wrote:
>>>>> There is a potential out of bounds if "ev->length" is too high or if the
>>>>> number of reports are too many.
>>>>>
>>>>> Fixes: c215e9397b00 ("Bluetooth: Process extended ADV report event")
>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> Reviewed-By: Tomas Bortoli <tomasbortoli@gmail.com>
>>>
>>> I sent a patchset to fix all of this kind of OOB:
>>> https://marc.info/?l=linux-netdev&m=155314874622831&w=2

Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>

All 3 looks good to me, nice work! Overall, it seems that with these 3
all the RX paths in hci_event.c are bound checked.

>>>
>>> Unfortunately I get no response...
>>>
>>> Does any of you mind to look at them?
>>>
>>
>> I don't know the rules...  When is it ok say:
>>
>>         if (skb->len < sizeof(*ev))
>>                 return;
>>
>> and when must we say:
>>
>>         if (!pskb_may_pull(skb, sizeof(*ev)))
>>                 return;
> 
> 
> The rule is simple: pskb_may_pull() always knows better. In bluetooth
> case, they are actually equivalent, as the skb's in bluetooth are linear.
> 
> 
>>
>> Btw, get rid of all the likely/unlikely() macros.  Then the other style
>> comment would be don't move the "ev = (void *)skb->data;" assignments
>> around.  It's ok to say:
> 
> 
> Similarly, pskb_may_pull() may reallocate skb's, although very unlikely
> for bluetooth case (skb's are linear). At least it doesn't harm anything
> we move the skb->data dereference after pskb_may_pull().
> 
> I think these likely()/unlikely() are reasonable, ill-formatted packets
> are rare cases, normal packets deserve such a special care. We
> use likely()/unlikely() with pskb_may_pull() in many places in
> networking subsystem, at least.
> 
> Anyway, if you don't mind, I can resend my patchset with you Cc'ed.
> 
> Thanks.
> 

