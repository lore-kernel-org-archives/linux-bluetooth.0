Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1632C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 23:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B219F61078
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 23:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhKLXGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 18:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhKLXGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 18:06:16 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C4C061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 15:03:25 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r26so20675073oiw.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 15:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwqQ7uJnnuH8oQfmXy4+/qc3GRMuRkeI5EuUmtqWloY=;
        b=AfRfNGfzobvrsH8PJyu8iRlDxBCAbu3NUiJx1yGqDDqQL4miKCwLPeMuo7lv/WYxsV
         zKEdMzpDf3afDWY8SLr4IfwGJW0rORQUqjnL/Npx6D0763FWe0S/JyH3XPciMD3+39tR
         V43X5NxhXMMA+HGy39SADeq+1Qh4Jc3xYVx+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwqQ7uJnnuH8oQfmXy4+/qc3GRMuRkeI5EuUmtqWloY=;
        b=7p6hQDwZDQIKUJDkR6P9vDqvpn6nWnnqcejA8N6SXNMfp7jq/bZCPckfoyTCbXe++d
         ECj0WhPdahGkN3RE1PQDrCOHkSa+2PGLk0aCKRP1tv9bXQQSpu4sHjYM/TfxcD68UUNA
         HOPPP/6oA9pVlh/kfErCtYQ1ogLhreVGMu4ZXe5PEz29yTX6PHJIpgbQ/oiwKslc3BJg
         jAO++1EWbao0csr9HqLaoFZhK9DyYJfsXHdafItDk09pFoXuqCngrvCtBskSVxoF2tJM
         XrpOKIVLCfFh6Asw7jvrgttdggEtM4mLquq+oc5sbovQJcVPEUNDV0XQn719rA7JurPg
         j2yg==
X-Gm-Message-State: AOAM532Mdu4iU5XBfQsWZdaOa4KnG1aFzna+lK1k7mLef6Gnm9htRZxn
        sdZRQojsmCd3piC8DleMemTGJVdWozxiJQ==
X-Google-Smtp-Source: ABdhPJwKQ8sN+A/6+K55f8rmXf5i8z5sIxgkC4XqnxGATuao4oxDiUN7C2YNOP/wWgC9DBfKtAbG9Q==
X-Received: by 2002:a05:6808:a8f:: with SMTP id q15mr2980906oij.65.1636758203866;
        Fri, 12 Nov 2021 15:03:23 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id p14sm1306193oov.0.2021.11.12.15.03.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 15:03:23 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id be32so20618585oib.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 15:03:22 -0800 (PST)
X-Received: by 2002:aca:1708:: with SMTP id j8mr15596758oii.62.1636758201979;
 Fri, 12 Nov 2021 15:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20211108200058.v2.1.Ide934b992a0b54085a6be469d3687963a245dba9@changeid>
 <17BDA821-9D4A-46C9-8C0E-F7DB35D50033@holtmann.org> <CACGnfjTBtZ+1ey6+wF7hAVX23ty7yS9qEH0b6p+vzCLBWWPW0Q@mail.gmail.com>
In-Reply-To: <CACGnfjTBtZ+1ey6+wF7hAVX23ty7yS9qEH0b6p+vzCLBWWPW0Q@mail.gmail.com>
From:   Jesse Melhuish <melhuishj@chromium.org>
Date:   Fri, 12 Nov 2021 17:03:10 -0600
X-Gmail-Original-Message-ID: <CACGnfjSdxUGj=6Wk-oUcH-jwe3PYMm9gbPdi_atmaozN8A-mWg@mail.gmail.com>
Message-ID: <CACGnfjSdxUGj=6Wk-oUcH-jwe3PYMm9gbPdi_atmaozN8A-mWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Don't initialize msft/aosp when using user channel
To:     Jesse Melhuish <melhuishj@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
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

Forgot to include: patch v3 incorporating your feedback will follow
very shortly.

On Fri, Nov 12, 2021 at 4:50 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
>
> Hi Marcel,
>
> No problem, thanks. Happy to extend userchan-tester; do you mind if we
> continue reviewing this patch for approval in the meantime so we can
> mitigate the issue on our end?
>
> On Thu, Nov 11, 2021 at 12:43 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Jesse,
> >
> > > A race condition is triggered when usermode control is given to
> > > userspace before the kernel's MSFT query responds, resulting in an
> > > unexpected response to userspace's reset command.
> > >
> > > Issue can be observed in btmon:
> > > < HCI Command: Vendor (0x3f|0x001e) plen 2                    #3 [hci0]
> > >        05 01                                            ..
> > > @ USER Open: bt_stack_manage (privileged) version 2.22  {0x0002} [hci0]
> > > < HCI Command: Reset (0x03|0x0003) plen 0                     #4 [hci0]
> > >> HCI Event: Command Complete (0x0e) plen 5                   #5 [hci0]
> > >      Vendor (0x3f|0x001e) ncmd 1
> > >       Status: Command Disallowed (0x0c)
> > >       05                                               .
> > >> HCI Event: Command Complete (0x0e) plen 4                   #6 [hci0]
> > >      Reset (0x03|0x0003) ncmd 2
> > >       Status: Success (0x00)
> > >
> > > Signed-off-by: Jesse Melhuish <melhuishj@chromium.org>
> > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Moved guard to the new home for this code.
> > >
> > > net/bluetooth/hci_sync.c | 6 ++++--
> > > 1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index b794605dc882..5f1f59ac1813 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -3887,8 +3887,10 @@ int hci_dev_open_sync(struct hci_dev *hdev)
> > >           hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
> > >               ret = hdev->set_diag(hdev, true);
> > >
> > > -     msft_do_open(hdev);
> > > -     aosp_do_open(hdev);
> > > +     if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> > > +             msft_do_open(hdev);
> > > +             aosp_do_open(hdev);
> > > +     }
> >
> > but then you need to do the same on hci_dev_close. Also it would be good to extend userchan-tester with test cases for this.
> >
> > Regards
> >
> > Marcel
> >
