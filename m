Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B35C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 22:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705A061054
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 22:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhKLWxR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhKLWxP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 17:53:15 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC754C061767
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 14:50:23 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bf8so20605240oib.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 14:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vODi7QdVsXr5ltMsHWp2FnleR3mjZRfOo8/CUw9j+es=;
        b=M8edBYX7AF53kHQELBSlm84mGncbdzrpwtmcNx6TcpAU6cijvGMOcynVW5F0IdglzE
         p7UL1KV57VrYCFjmjBl0iheYUMGwJaL4sqfIFhCTIBIwfhUczA63C6gf2f3CBjRRkXd5
         NHsBF9M+k2vtvhKS0FWv5qoy+TjF0ZmRIaXvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vODi7QdVsXr5ltMsHWp2FnleR3mjZRfOo8/CUw9j+es=;
        b=db12uOByfrTE5ZRP7uL9OHljrVHvebuq1ZFVt61pMB0YoxpMO8q8xzr2mrndw0woA9
         8k7VJ75dqechMJVFO8yxTb4XkMDHY/HSmpmq7VyxecH/2ZP4cjBfgVqbiIl22k1uub6x
         eTGmryn9gcgQ0DdQoUC6aLY/g+UA+XvXVnonlfqYzq5vK5bI6o5eQI7jw+bGs0fg3Ttn
         GUdVo8AqAI4Kr6Fgx16U7c/1iCQpzrbHjMgVHkEQK43kyFP1VlCnc0fTHOnuZsNMUP82
         z77/EuwrLfZGXqZTzVyXr3cDNkh3IAOwIdCMEJSlT5Jz3qyRC0je00fM5l7puqMsrk7x
         mhcA==
X-Gm-Message-State: AOAM530bp+vS540PPNiIM0ngB+MMD1FpoCWYVLwye/dDdB+qfqizGsrd
        1CQWAcfedRKs6nzKziBJWDQfpXu1aVtR2g==
X-Google-Smtp-Source: ABdhPJyK785+SbxRoWnhM7FhsCpZBxRxeZivrWoYtWyfp4JPCt9xG8ub6i/RFpAsXggBb3HE697lBw==
X-Received: by 2002:a05:6808:11c6:: with SMTP id p6mr16002369oiv.158.1636757422464;
        Fri, 12 Nov 2021 14:50:22 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id t12sm1473836oth.21.2021.11.12.14.50.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 14:50:21 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so16036295ote.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 14:50:20 -0800 (PST)
X-Received: by 2002:a9d:6c2:: with SMTP id 60mr14670064otx.279.1636757420114;
 Fri, 12 Nov 2021 14:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20211108200058.v2.1.Ide934b992a0b54085a6be469d3687963a245dba9@changeid>
 <17BDA821-9D4A-46C9-8C0E-F7DB35D50033@holtmann.org>
In-Reply-To: <17BDA821-9D4A-46C9-8C0E-F7DB35D50033@holtmann.org>
From:   Jesse Melhuish <melhuishj@chromium.org>
Date:   Fri, 12 Nov 2021 16:50:08 -0600
X-Gmail-Original-Message-ID: <CACGnfjTBtZ+1ey6+wF7hAVX23ty7yS9qEH0b6p+vzCLBWWPW0Q@mail.gmail.com>
Message-ID: <CACGnfjTBtZ+1ey6+wF7hAVX23ty7yS9qEH0b6p+vzCLBWWPW0Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Don't initialize msft/aosp when using user channel
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Jesse Melhuish <melhuishj@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

No problem, thanks. Happy to extend userchan-tester; do you mind if we
continue reviewing this patch for approval in the meantime so we can
mitigate the issue on our end?

On Thu, Nov 11, 2021 at 12:43 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jesse,
>
> > A race condition is triggered when usermode control is given to
> > userspace before the kernel's MSFT query responds, resulting in an
> > unexpected response to userspace's reset command.
> >
> > Issue can be observed in btmon:
> > < HCI Command: Vendor (0x3f|0x001e) plen 2                    #3 [hci0]
> >        05 01                                            ..
> > @ USER Open: bt_stack_manage (privileged) version 2.22  {0x0002} [hci0]
> > < HCI Command: Reset (0x03|0x0003) plen 0                     #4 [hci0]
> >> HCI Event: Command Complete (0x0e) plen 5                   #5 [hci0]
> >      Vendor (0x3f|0x001e) ncmd 1
> >       Status: Command Disallowed (0x0c)
> >       05                                               .
> >> HCI Event: Command Complete (0x0e) plen 4                   #6 [hci0]
> >      Reset (0x03|0x0003) ncmd 2
> >       Status: Success (0x00)
> >
> > Signed-off-by: Jesse Melhuish <melhuishj@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Moved guard to the new home for this code.
> >
> > net/bluetooth/hci_sync.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index b794605dc882..5f1f59ac1813 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3887,8 +3887,10 @@ int hci_dev_open_sync(struct hci_dev *hdev)
> >           hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
> >               ret = hdev->set_diag(hdev, true);
> >
> > -     msft_do_open(hdev);
> > -     aosp_do_open(hdev);
> > +     if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> > +             msft_do_open(hdev);
> > +             aosp_do_open(hdev);
> > +     }
>
> but then you need to do the same on hci_dev_close. Also it would be good to extend userchan-tester with test cases for this.
>
> Regards
>
> Marcel
>
