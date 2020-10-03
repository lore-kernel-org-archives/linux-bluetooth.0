Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E19C4727D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 22:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A64C206F8
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 22:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBnjRal1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgJCWIC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 18:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgJCWIC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 18:08:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61DEC0613D0;
        Sat,  3 Oct 2020 15:08:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so3259914pgf.12;
        Sat, 03 Oct 2020 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K7prn+OySA9dsDPOdM/Xq3Uxq9GhNO6pfnjq7gcgnBM=;
        b=SBnjRal1k9R0s2/i3bXCb0PMhTx3D6dT9Kf78kMqTIg7IrSLNp/IpQqeWrisPZ2yvD
         nnc/HcLp03ktgfYVXQ3rP3Gh0SNnfH5vAQ+yBCgCH94TlJKIsCQ+lYBle/zXJWDe8ZD0
         clwC/+Oo/rC5hK+P9DVjNqbruAFwGKvs1rcxC8ckKfm2/o/LWofTlUyIfTS7NuP8JAXl
         zry7RbAYiBmtjphf23GXLNx4pXZ3YfANLrHOwaqsVQBT5gzh9xiBJ2cha6VvR3se0Mxx
         44S+S5m3X6dyAlJmh2KXKThfxJKc1ex7gWbK56ndmvc3UiSNGx7RrQOdrnBlo8xfUh3y
         DwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K7prn+OySA9dsDPOdM/Xq3Uxq9GhNO6pfnjq7gcgnBM=;
        b=rDhKo0U0AMX1H9BhpFABWm1uh9vg16PGyKpVwuUWI2fw9cUpUYN5bxKG6C9c8lAsCq
         QFgkLks3aBK7U+CnLzFWAkkYkKHshQcjfBfVkLh6F5d8iIaJIciqK0wsnjQtv4hgHe2W
         zVKcB6VvSNdVCVy2upkTFVOO+1P66daq2ofVtmPFWj1V2DgNpLGg8FTpWyZd2ugeTtru
         kqhI1xBj3vLpeuxojMPCFLZoT996PzPCPSWIvP1+akHir+80SZV2MTiDL8dxCIsNzQRR
         qAJv5l37RxW04hWTeK8bkLnFVb/I0T+IU/p38/OhbGHeoU04weE/sE2d1iiD7/jIb33N
         fxng==
X-Gm-Message-State: AOAM531jfaVBBrhyg3TfFKTPRIKhh6LC3MeYpOtKrNPwBw6mCV3K+iAu
        Y1yFD6bas20P9B2oep8ihuxHGKMiSE+sargVyG0=
X-Google-Smtp-Source: ABdhPJz27UI1n/OwASkq+l9PBfvnArPfn7FK4DrS9UteyGak86q9+UJctpK1rdhYlHRAZT7DQ/OGcQ==
X-Received: by 2002:a05:6a00:23cc:b029:142:2501:34e5 with SMTP id g12-20020a056a0023ccb0290142250134e5mr9491367pfc.62.1601762879292;
        Sat, 03 Oct 2020 15:07:59 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.217.69])
        by smtp.gmail.com with ESMTPSA id v2sm6392108pfu.105.2020.10.03.15.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 15:07:58 -0700 (PDT)
Subject: Re: [PATCH v2] bluetooth: hci_h5: close serdev device and free hu in
 h5_close
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
 <33d8c103-0c24-3ad7-2a3c-ffeb625521ee@redhat.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <53d30b50-6cd4-57b2-9dc7-8cb8109ff7ab@gmail.com>
Date:   Sun, 4 Oct 2020 03:37:54 +0530
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
Hi,

I did some more investigating and testing for this bug, and turns out I was very
wrong. I'm truly sorry for that.

The memory leak that is caused is caused when !hu->serdev itself, since we free
h5, but not h5->rx_skb. This is what causes the memory leak.

I'll send in a v3 that corrects this issue soon enough, by freeing h5->rx_skb first
followed by h5 when !hu->serdev; and otherwise (when hu->serdev exists)
calling h5_reset_rx().

Sorry for the trouble.

Thanks,
Anant
