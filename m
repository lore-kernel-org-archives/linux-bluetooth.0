Return-Path: <SRS0=VswU=ZM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B20C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5FA2071F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574268866;
	bh=v9K2RREq+epE3/QQtTe5wMvG9+gFaXJj3kHR9nFJMqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bnb5WXRwUwRXf+Q1wABPjP9sF37tp25Rh5FedH+NOrE4JieUj+5RZHxKvuTfm/z2T
	 iRB+g6NTrLPhZNr/GjTI3ZXw8M1jje2yZI+5W5f29tpU6s8PJNkTT/DG7RhObSEAcH
	 lYOp0W5OnZZS3vfY6t2uPl+xAlRfFFEtYLDGaLSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfKTQyZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:54:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35592 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfKTQyZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Nov 2019 11:54:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so130948lfp.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2019 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yl/io6zu7qIXmXnHQ/CHwQbhCv2/KHgSYlmLHi4gHj4=;
        b=OrdylVenp1hrzGi9xP9N6Ny5Y4SJ+klzwy7eSqlFKUXk85bhpAOndMra9MpG8P7iSd
         h39hquiHnufr6mmbsANbTeZG+JPIObfeMQg9aFigyICwPP81zn3qjOLp9A2hoiEDLmNJ
         MvkOz1pMb2CztPZWWi/Ox0n2mbxO/cgbtKIBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yl/io6zu7qIXmXnHQ/CHwQbhCv2/KHgSYlmLHi4gHj4=;
        b=uY00H3PvxDhISsLumNOvPGWG+sCtAzpFODjxVq9l6zC3TUlfAqiFu2AwNKKWp0AnCf
         LANDDuhZxXGTXD1DGXG9BK241RCQkNVLUiCCJy8hMYz2ZhQOSWhSwH2xz0qQChHpXDvz
         2NKHVOTqlfXJ8ssUC/y+R1fL48zC1MDNUcLoFB8VZagzJuraqhy6K2OjE8DBnQNlYGi2
         X2VyycN7pDsN96N9lAcfBy1q1Q2AxYMN/bpZp9V1zFtA1dBX66dcmFfMWd4tSdQcpO6T
         uZvouB6iuEq/7eGnllUiKaDZNw7xL7Y5q6zWYIMd2TcJEVxouXPYPW7Xrqjhq3QETZQW
         H/tg==
X-Gm-Message-State: APjAAAULLxFUtEnd/shRaSZUS9Ff4/ccdl9l1Q/5lMiqF/4uD5GnaLwM
        arSxOxDS3RNbVs3oIdfidFeCJRe1vVs=
X-Google-Smtp-Source: APXvYqwY4m+0BVMr8o9yuV6j+kIaNHFtGeHX3nyOjBNtJcStoL61y1g9zL+9BLRD6Yd67fyKApcWmQ==
X-Received: by 2002:ac2:5144:: with SMTP id q4mr3914118lfd.36.1574268862600;
        Wed, 20 Nov 2019 08:54:22 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 28sm13062652lfy.38.2019.11.20.08.54.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 08:54:20 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id q28so130808lfp.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2019 08:54:20 -0800 (PST)
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr3781555lfn.106.1574268859986;
 Wed, 20 Nov 2019 08:54:19 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bf6bd30575fec528@google.com> <000000000000e2ac670597ad2663@google.com>
 <CAHk-=wjg0JXgwb6rkFK0q_JvW7YdGpiPtMVWe=YhFK1y_2-F7Q@mail.gmail.com> <14e1a22937ce5a54d94dab04a103e159215fb654.camel@kernel.crashing.org>
In-Reply-To: <14e1a22937ce5a54d94dab04a103e159215fb654.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Nov 2019 08:54:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgR=8QX6A6iPAzsD-E38t6Uesa45yWLmeTWZTnK0GbRow@mail.gmail.com>
Message-ID: <CAHk-=wgR=8QX6A6iPAzsD-E38t6Uesa45yWLmeTWZTnK0GbRow@mail.gmail.com>
Subject: Re: general protection fault in kernfs_add_one
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     syzbot <syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Nov 19, 2019 at 8:04 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Could this be what was fixed by:
>
> ac43432cb1f5c2950408534987e57c2071e24d8f
> ("driver core: Fix use-after-free and double free on glue directory")
>
> Which went into 5.3 afaik ?

Hmm. Sounds very possible. It matches the commit syzbot bisected to,
and looking at the reports, the I can't find anything that is 5.3 or
later.

I did find a 5.3.0-rc2+ report, but that's still consistent with that
commit: it got merged just before 5.3-rc4.

So I think you're right.

I forget what the magic email rule was to report that something is
fixed to syzbot..

              Linus
