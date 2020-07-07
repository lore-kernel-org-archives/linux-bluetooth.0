Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B1FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F38920672
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9G4+gZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGGRi6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRi6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 13:38:58 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EAC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 10:38:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g37so11194511otb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iG6/TEYwis8lNrhhxu1yaHgEn0SxtbkRTd4/TNylxg=;
        b=R9G4+gZ+aaSQistrmzZMbk4rAQF6I+fd1zgQ6NLgL6ysPJhFcJw0HmJ4ydMhDr3l3h
         6/9/31DggUK6914jZgPOr69o2WeDaO4FmWJ9fknzek6Kxky3qREbmJUpX0tPFZYFtCIo
         YLjTmEvCD6m3S4eGb2rapw+fgTPy5zk2DiGc+Q9HlAbh9XXOKtmRjUee0x2sT/JTtrHI
         Wsa/B8Nzav3FXIZ/odTaG+dwFejeIW9NXVMMdejrC9suU8F8PqQM6xDnjhgQnCE50+fg
         W+QY7FisxdZ131Xn52JGAtZ7OOkgAep/sSN+wtW+fbmrZzRyAVc4LqGTyA1HezWtxs+i
         jSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iG6/TEYwis8lNrhhxu1yaHgEn0SxtbkRTd4/TNylxg=;
        b=eaZ+ps8fj5yeaPPW1QhIGeYMfwefKYKL3LA0dynZS+R6Qtdcfv5kxUxOSQhpIFtnaY
         ZyDzo2vF34MBjpUOrjI3HFUCjstaZrHuo1tJi54GWlf1Nc0L18yidEg9GElC13xVEARU
         HPkMmrcuagFZ0pcwgkRbW+ztjFEbRlQnJUzTj0jwYj10AulC7FdCQ6ke64hVGTQzPRGt
         wCspi1SLCWnO6hnujmlspiO+YYWFtbE7ViHtTM/VVq4EOe4TtZtyknuZ4c5P0RmXibBe
         T9eEQg6x0bCGdX6wIhxG1OGZ9kCnxYL6FYtWhsoET9ETEgWxCGUNaDPCfza0uBy79w9m
         ErEQ==
X-Gm-Message-State: AOAM533pDsK/O9OmE51Apxymf97u96wHtttthMthVXqUqoVAAyaxcOEo
        FEMMVAd6nr1ZVt4VAvsN9qiXxHw5VrYVxRJuB72XgC7K
X-Google-Smtp-Source: ABdhPJy4QeivwJAZQU/YGj4HcsUPvzaIfhP16eAvpjUXXFjNzPwNV91asNUZUJ5fq1oOs8vxsLZyN4/Tu4+c/gQCrV4=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr44037513ota.91.1594143536476;
 Tue, 07 Jul 2020 10:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200702220558.3467870-1-luiz.dentz@gmail.com> <FEEBE4D6-F6C6-470D-95E6-FA20EAA1F862@holtmann.org>
In-Reply-To: <FEEBE4D6-F6C6-470D-95E6-FA20EAA1F862@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jul 2020 10:38:45 -0700
Message-ID: <CABBYNZJwv7KFZ=Us4X+rK4K-f+fD-GBsHyZOYQsmeB0bewZyRg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: btusb: Add support for notifying the polling interval
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Tue, Jul 7, 2020 at 9:09 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This enables btusb to inform the polling interval used for receiving
> > packets, the interval is then used wih rx_work which has been changed
> > to be a delayed work.
> >
> > The interval is then used as a time window where frames received from
> > different endpoints are considered to be arrived at same time.
> >
> > In order to resolve potential conflicts between endpoints a dedicated
> > queue for events was introduced and it is now processed before the ACL
> > packets.
> >
> > It worth noting though that priorizing events over ACL data may result
> > in inverting the order of the packets over the air, for instance there
> > may be packets received before a disconnect event that will be
> > discarded and unencrypted packets received before encryption change
> > which would considered encrypted, because of these potential inversions
> > the support for polling interval is not enabled by default so platforms
> > have the following means to enable it:
>
> we can not touch the core that impacts all transport layers even if they are not broken. So adding the second queue is not something that I think is a good idea. And again, we are just papering over a hole.

I guess you are referring to hdev->ev_q, that is only used if the
driver calls hci_recv_evt so it doesn't affect the user of
hci_recv_frame.

> However if you want to queue within btusb driver before sending it to the core, then maybe.

That might require introducing a workqueue into btusb though, but
perhaps that is not such a big deal given that we are not that
concerned on the memory usage, are there any other remarks about the
conflict resolution though? I probably will add some text to the
Kconfig option stating this is a workaround which may cause reordering
of events vs ACL data, but imo it is much cleaner then trying to
handle these races on the upper layers since they might not be limited
to just Connection Complete and Encryption Change, so instead of
papering each hole separately we just use a bigger paper to cover
everything up, it is still just a workaround so platforms would have
to decide if they want to run with it or not.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
