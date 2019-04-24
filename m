Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F03C282E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 12:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE3A21773
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 12:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfDXM7w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:59:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42089 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDXM7w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 08:59:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so20072187qtc.9;
        Wed, 24 Apr 2019 05:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hKQPW7bWSthnzapEbQxaxOAB1qjVICyxyXJTNrBo7vQ=;
        b=kpFDQ6J4vgsxMr7fZQw7EALog6cHlvLlMY6JXOsGbLRGHlGqnhhJwbykVPBFhw+0xI
         NWZDZHQa0PcN6QQoAQM+zsbolwrHX1Unjk/zaU2NzTOvG12n0uac1ZkDVMFWZ75p/PTo
         YxQtfUW3oeZn7khR4UeBB60M7O1O2Snt+YnCuHEeAI6tb2vFjhxqkvm+72hvt42CQa29
         EMUYwM5qOeeJzUghKXHLAkVLwTq2KAqWhjb+i0xYkxuxD5I1PnsY7r75v/xr9bpG/ctM
         ZnJI7bjUs9QMmZlO3MuiqHbk4L4apvvnblKmYk+dLdzOs9QyLP9aRV4zmo4EFfcNRE5c
         3c7w==
X-Gm-Message-State: APjAAAW7TtFZ77mjEAgTfMeXUYRpEiLj552f3q3E+DZ8yPF/RgSTXZQ7
        iFDIAs4ljwLVjn63Tjf1W1A+yMgrIhBLN60og5o=
X-Google-Smtp-Source: APXvYqxdyHnqgVjpvMQlfL6QgJt9stlZffGSN4QQCyoRUfv/jIiiuUJTzdGQKWPgwYLqXHG/PC2iXrAAA97Kf/9ZQDI=
X-Received: by 2002:a0c:ebc2:: with SMTP id k2mr6278458qvq.149.1556110791164;
 Wed, 24 Apr 2019 05:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190423151143.464992-1-arnd@arndb.de> <20190423.193735.412590692063607790.davem@davemloft.net>
 <CAK8P3a1ViEZmK-+rpYgpFkJHs+7XoNCTuK1iHcgSrZXaOJedLQ@mail.gmail.com> <FBF10E1F-2D3D-4FFC-8F8C-5969A2F2A475@holtmann.org>
In-Reply-To: <FBF10E1F-2D3D-4FFC-8F8C-5969A2F2A475@holtmann.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Apr 2019 14:59:33 +0200
Message-ID: <CAK8P3a2FLrGXh9iv4eWBX8D_zb7rq5YDErkzDjjHbA5JENHVGw@mail.gmail.com>
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Networking <netdev@vger.kernel.org>,
        isdn4linux@listserv.isdn4linux.de, Paul Bolle <pebolle@tiscali.nl>,
        Holger Schurig <holgerschurig@googlemail.com>,
        Tilman Schmidt <tilman@imap.cc>,
        Al Viro <viro@zeniv.linux.org.uk>,
        gigaset307x-common@lists.sourceforge.net,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 24, 2019 at 12:24 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >>> When isdn4linux came up in the context of another patch series, I
> >>> remembered that we had discussed removing it a while ago.
>
> NAK.
>
> I do not care about isdn4linux, but this is a purely CAPI based driver. So removing (or moving to staging)
> CAPI support seems rather premature.
>
> Maybe someone would have started talking to us before trying to move this into staging. It is a
> maintained driver. That it is rather simple and hasn’t seen patches in a long time, doesn’t mean
> it is not maintained and staging material. I see no reason to tell any user to enable staging tree
> to get CMTP support.

I can definitely leave out the last patch from the series if we know
that there are
still users on CMTP. I searched around for a bit but could not find
any indication
what this is still used for, if anything.

What I found were a couple of references of the driver no longer working
about 10 years ago:

https://wiki.ubuntuusers.de/Archiv/Bluetooth/BlueFritz%21/
https://www.opensuse-forum.de/thread/2776-erledigt-suse-11-2-und-bluefritz/

Is anyone using cmtp for voice or fax services? The use cases from before 2009
that I could find were usually dial-up networking, but that seems pointless now
if the only way to get an ISDN connection is to have it routed over
the internet.

What am I missing?

     Arnd
