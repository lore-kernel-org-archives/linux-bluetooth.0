Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D66C47095
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 06:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E22C21582
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 06:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0XF6FIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgJFGaM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 02:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgJFGaL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 02:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601965809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vwyAgepOoBCoYxOhMcz2TzI9xFjcG6ujhGRXpaPdzg=;
        b=K0XF6FIe3rL7XjUlYuCIgNFS0OWd9Dy0Mmis/S9e/Lh6QJuHzH2Y+/f7CRocWFJJxezBqf
        sS8NkyGcDsVOzLJQejVcJRHJ1Y560CnxKDrW17BllrqtqltAAFED1o3BeRQllF1pIrC4Kz
        hU9YrHzlAuEzh5S+gHojw488y3FKPhw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-L8TzxCKfMLO3qRM-yPv9BA-1; Tue, 06 Oct 2020 02:30:08 -0400
X-MC-Unique: L8TzxCKfMLO3qRM-yPv9BA-1
Received: by mail-ej1-f70.google.com with SMTP id x22so3345801ejs.17
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2020 23:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vwyAgepOoBCoYxOhMcz2TzI9xFjcG6ujhGRXpaPdzg=;
        b=IEIzQjIBkp2rcDexmd9WWDB/3H8bXqxmMtHwoBkyHZ5NDhWMayz36ME3ksUZ8Z3Xwl
         5/Nq12t6Du8i504lJluHe7Nmo5s2iglMphuo9kudfUi8Xwcz6ecjiqi2az/F3u8V9Apx
         /Oz5bg3lPjBrQiUGoZQZHZl65/Z5hZ/PEs8zMr9nb716uD+vvQYgRLGl1M3pYLoadCS5
         WyGDVkycntSlgPaA7E5op5qbCJHG2dGx1gBLVYg5nHhioK42KgAh9WNYWw7+dlBUqjdk
         iqjT3lCh9lW8W6ihZOnGXFWseddKi5cyc9JSkP0Aal8ruH/8CoybMzg7/dnEv/6okZjQ
         WF/Q==
X-Gm-Message-State: AOAM530dBUBL3aDAI7YRlKYaRwq+99GGIRn7dmWIPd9bhBnkkH7SDhWb
        6iz4jHIDvnq14jcZfF9Rz6PDtrtKPW/1oLbMzQc7lno6fTxgpk+p7/G1E/vOSfcSFMvkT/Ihkpc
        XGSurMzHqLQxvcGLKNPk0k2veUxbe
X-Received: by 2002:a50:e3c4:: with SMTP id c4mr3830705edm.90.1601965806573;
        Mon, 05 Oct 2020 23:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhkqyrg+DyKKwlFvUJxqKcNDl3H/dazO0Z2xeNbQHL8lAxXSWRnze8VoStOqhtN3tIDvWSMw==
X-Received: by 2002:a50:e3c4:: with SMTP id c4mr3830687edm.90.1601965806375;
        Mon, 05 Oct 2020 23:30:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id b6sm1625489edu.21.2020.10.05.23.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 23:30:05 -0700 (PDT)
Subject: Re: [PATCH v3] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
 <20201004051708.21985-1-anant.thazhemadam@gmail.com>
 <407eed16-ba46-0ba6-544f-d5e820a1ced7@redhat.com>
 <93ed51be-97b9-c5b4-8448-d06528a1d1af@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9761cf0c-e2bf-38ea-e1d1-59b481736186@redhat.com>
Date:   Tue, 6 Oct 2020 08:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93ed51be-97b9-c5b4-8448-d06528a1d1af@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 10/6/20 4:44 AM, Anant Thazhemadam wrote:
> On 05-10-2020 14:48, Hans de Goede wrote:
>> To fully fix the memleak you also need to add a kfree_skb(h5->rx_skb);
>> call to the end of h5_serdev_remove(), because in the hu->serdev case
>> that is where the h5 struct will be free-ed (it is free-ed after that
>> function exits).
> 
> Hi Hans,
> 
> I'm not entirely convinced that it might be entirely the best idea to do
> that.
> 
> * The bug detected by syzbot only provides us with reproducer and
> information about this bug (which gets triggered when !hu->serdev).
> Even if like you said, there might be a memory leak unattended to when
> hu->serdev exists, then this might not necessarily be the right place to fix
> it.
> 
> * From what I can see, all the drivers that have modified to provide serdev
> support have different close() mechanisms.
> However, one thing they do have in common (in this context) is that their
> respective serdev_remove() function simply calls hci_uart_unregister_device()
> to unregister the device.
> It is primarily for this reason that I feel adding a kfree_skb() call at the end
> of h5_serdev_remove() might not exactly be the best way we could solve this
> (and since this hasn't been picked up by syzbot yet, there's no way to know if
> this just fixes things or ends up causing unforeseen complications).
> 
> Alternatively, wouldn't freeing h5->rx_skb and assigning it to NULL, for both
> hu->serdev and !hu->serdev cases within h5_close() itself be a better
> approach?

That will indeed also fix the leak in both cases and is more consistent
wrt when the free_skb happens. So this sounds good to me, go for it.

Regards,

Hans



> I've also taken the liberty of testing a patch that does this, and it
> seems to work correctly too. :)
> 
> But then again, I'm not exactly an authority on how this works.
> 
> Thanks,
> Anant
> 

