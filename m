Return-Path: <SRS0=UfNv=DJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88732C47423
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Oct 2020 10:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1C9207EA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Oct 2020 10:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odAo3zHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBKzb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Oct 2020 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJBKzb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Oct 2020 06:55:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91650C0613D0;
        Fri,  2 Oct 2020 03:55:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q123so999339pfb.0;
        Fri, 02 Oct 2020 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I3l3pW7Q2Q9okF2imcqI+zzuik+YfrLOZr205jkuH+8=;
        b=odAo3zHgm1zZYT0pe5T8WJVP7L80LgED9ZRhTaVeHHY1rR0ItOX4c4TqvOA1VfvPwE
         yl8BaawUJvMlFjHSvve2wbNgFGiL+OkRXIUC3JPQMFxoslWxxShskfBmNhx8aItG2cqp
         KvBEJjCCw5B21ehOQ7ek0b0/y5x+zP2tuc+U/6jqsRPKbt9SP+zMAHxU0VwAVsLE6icB
         lnZnWDFPKBR737aCJ7In0ssj+qNzgmjpPtXxFJVTdx+vRQyxvmz4KbBDEU5JlbZLQ+4u
         YAVNuElr9s+tbnqdtBEf8Mp1tDai2Ss06qX6Iypcn77qvap5Pdtr+Sdivnt9ie1OxJLs
         Eq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I3l3pW7Q2Q9okF2imcqI+zzuik+YfrLOZr205jkuH+8=;
        b=EwTZB8k97nuO6lTKeHOhkBeQgeQ0+p3CKhmoAP7LawQZ71cuYSJ25cFdPcynhpzy6m
         o72tktcRiYUll0OEDatit1Nyz8EreXQH7XE0vet4ok5MaC0+wIMBdLlI8VRAEzpv6yNo
         WKASqj0r2exizR1LPRAOaFTTTFnhv9PL3pzdlTSYwprPe95KCJvGB1mpD6ZAfkjL5S2v
         vIX+jLxRUf3oeNaZMmGzeetwimVWnnq065x2DhJAPccQLcn0PaGGLvMCPT/44YY8ashW
         TOEq+azJI/xiiCt1ORXXxbuGqlIaq6cAG7mbp4/RCrNP2++krxJFlu8jJ8ouQq9Y2sNo
         t5yQ==
X-Gm-Message-State: AOAM531xbQKec7fJgTRDpcb9Ehe4hdbuNlEoDtvcne/u5jtnIDz+rzcX
        n2pnrnUJ2YICtxsFQcXnzzVgLNCPGMTKZYWUEoQ=
X-Google-Smtp-Source: ABdhPJwoHAzGsxNS1W+ppr9tgidop7dSUNJHWMP0mvnqAXpS9f9Mspru3pgObTSnaU5sA2OM3Ow6/w==
X-Received: by 2002:a05:6a00:2387:b029:142:2501:3970 with SMTP id f7-20020a056a002387b029014225013970mr1971780pfc.53.1601636130257;
        Fri, 02 Oct 2020 03:55:30 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.217.69])
        by smtp.gmail.com with ESMTPSA id e11sm1462142pfl.58.2020.10.02.03.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 03:55:29 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] bluetooth: hci_h5: close serdev
 device and free hu in h5_close
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
 <33d8c103-0c24-3ad7-2a3c-ffeb625521ee@redhat.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <52301834-83de-45e3-ff93-27fb3f865c5a@gmail.com>
Date:   Fri, 2 Oct 2020 16:25:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <33d8c103-0c24-3ad7-2a3c-ffeb625521ee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 02/10/20 3:52 pm, Hans de Goede wrote:
> Hi,
>
> On 10/1/20 9:43 PM, Anant Thazhemadam wrote:
>> When h5_close() gets called, the memory allocated for the hu gets
>> freed only if hu->serdev doesn't exist. This leads to a memory leak.
>> So when h5_close() is requested, close the serdev device instance and
>> free the memory allocated to the hu entirely instead.
>>
>> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
>> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>
> So 2 comments to this:
>
> 1. You claim this change fixes a memory-leak, but in the serdev case
> the memory is allocated in h5_serdev_probe() like this:
>
>        h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
>
> So its lifetime is tied to the lifetime of the driver being bound
> to the serdev and it is automatically freed when the driver gets
> unbound. If you had looked at where the h5 struct gets allocated
> in h5_close()-s counterpart, h5_open() then you could have seen
> this there:
>
>         if (hu->serdev) {
>                 h5 = serdev_device_get_drvdata(hu->serdev);
>         } else {
>                 h5 = kzalloc(sizeof(*h5), GFP_KERNEL);
>                 if (!h5)
>                         return -ENOMEM;
>         }
>
> So it is very clear here, that the kzalloc only happens in the
> if (!hu->serdev) which clearly makes the kfree() have the same
> condition the right thing todo. In the hu->serdev the data which
> was allocated by h5_serdev_probe() is used instead and no alloc
> happens inside h5_open()
>
> In general when looking at resource teardown you should also look
> at where they are allocated in the mirror function
> and the teardown should mirror the alloc code.
>
> So the main change of your commit is wrong:
>
> NACK.
>
>
> 2. You are making multiple changes in a single commit here, I count at
> least 3. When ever you are making multiple changes like this, you should really
> split the commit up in 1 commit per change and explain in each commit
> message why that change is being made (why it is necessary). Writing
> commit messages like this also leads to you double-checking your own
> work by carefully considering why you are making the changes.
>
> So about the 3 different changes:
>
> 2a) Make the kfree(h5) call unconditionally, which as mentioned above
> is wrong.
>
Hmm, I understand, thank you.

> 2b) Introduce a call to kfree_skb(h5->rx_skb); which is not mentioned in
> the commit message at all.  This looks like it would actually be a sensible
> change, at least in the "if (!hu->serdev)" case.  When using the serdev
> interface then just freeing it will leave a dangling pointer, so it
> would be better (for both the hu->serdev and the !hu->serdev cases)
> to call h5_reset_rx() on close instead which does:
>
>         if (h5->rx_skb) {
>                 kfree_skb(h5->rx_skb);
>                 h5->rx_skb = NULL;
>         }
>
This was the first thing I did! (and I tested and it works too)
        https://syzkaller.appspot.com/text?tag=Patch&x=13acf917900000

However, I was worried that doing so might mean freeing an skb
that might be required somewhere by the serdev connection (which could
possibly lead to a null ptr dereference), so I thought closing the connection
altogether might be a better alternative.

But now, since I've been told better, I'll submit a v3, that makes the more
sensible change and doesn't close the serdev_device, with a much more
informative commit message!

I also found a similar implementation in mrvl_close() where the serdev_device
was being closed and felt it might be the right way to go. But I now know that
I shouldn't have overlooked the fact that the open functions for both differ.
I'm sorry for this.

Like you mentioned, I should've given more priority to the mirror function,
and looked to see if even they were along the same lines, and I will be sure to
keep that in mind.

> 2c) Introduce a call to serdev_device_close(), without really explaining
> why in the commit message. Again if you would have looked at the mirror
> h5_close() function then you see no serdev_device_open() there.
> Actually serdev_device_open() is not called anywhere in the hci_h5.c code.
>
> Digging a little deeper (using grep) shows that hci_uart_register_device()
> calls serdev_device_open() and hci_uart_register_device() gets called from:
> h5_serdev_probe(), likewise hci_uart_unregister_device() calls
> serdev_device_close() for us and that gets called from h5_serdev_remove(),
> so there is no need to call serdev_device_close() from h5_close() and doing
> so will actually break things, because then the serdev will be left closed
> on a subsequent h5_open() call.
>
> Regards,
>
> Hans
>
Thank you so much for this review, and for your time! :)

Thanks,
Anant
