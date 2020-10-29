Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DC0C4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 00:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729CA206BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 00:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrI8ZUHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbgJ2AWg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbgJ2AWg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 20:22:36 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E227C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 17:22:34 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id x7so884075ota.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 17:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9z45DYPQUZKGWrC2dHq+OmefHbukpDU4ATI+T3ojLk=;
        b=ZrI8ZUHj2PQOjc1mhlM3zpWI6hp3jGFO3kbmayzXrIyk+2FgXNFuR/ZErFhwvyJ9Hp
         Mq8GOkagFDHpCcFYBT2StNp8lPUmGdxWKR9Yybd+17f36/cUdpBfMMjPScjso1K1yodG
         NlcIRAw7E5lNkl0aQX1Rf9nHC47yDB5GtmtAhMxTALpbNIgeJI6dWpI6Y6mMoNA5mmEJ
         1XP2lHhK7i8hPyM+Zs3awtjjQtDt0BnzVhz5pVyysGKy3lGh/xOZFZyWlZmano3ERvqb
         vf+9FXHBIMohsYioAcUrZP8/6Rc1NbkICgpK9TiqlJKt0O6zwV8p280hdjXzERw4K3gQ
         gRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9z45DYPQUZKGWrC2dHq+OmefHbukpDU4ATI+T3ojLk=;
        b=LGPQcHHwAtHK1hpuPgwmIhMw/pG/gPmPRMCB4CA83PRYD1ubk7jtStxuLcpBCOYZiR
         RFlADcVBFgOotbGt+UaSOcwQOMgx+bKlWJP0EhLN4Jx1CJQ81XIW9XJT0TOJQxoN2Z6a
         p3xHGqzqqbBbz+DkcoXyO0RFiRIfTLW4NYYWmW2xsryc7+U8H6HAh6MIctle9hg5P7xd
         mj1Sc30+/Vy8v97tBVcJUxiFVa4UuQwlZigulQUkn/u/tOrh5mgcgYf8QTIVmkekoatn
         yKbxehNkvpkCRi5TNgoR6IqyB2FrY8PtqVcNCNhAd/spAyadxAKj42CD4RIDYAJtkawL
         FDdA==
X-Gm-Message-State: AOAM5310t0QRNqZMfViHbn0jKh0ExK0+iDNBxYsbe6EBBdVVUpIfvzkN
        yQqntb/O6PkUFF4jux5gniCy7k/2lYYPob6du5lI1yV2lJQ=
X-Google-Smtp-Source: ABdhPJySA9Gbjwo3Zb/v1rg5ZLM3I2KARw3rxJpSlE8uQ5trqTSWLpI7OQ93bQ/0xnCr362by04VwMovcUPURBLcAAg=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr1399553otn.44.1603930953831;
 Wed, 28 Oct 2020 17:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201022082304.31757-1-sathish.narasimman@intel.com> <CAOVXEJL1qCPmpY-jGW8AsycxGytCzuJQR4hv-bXPPSNyO=5GZQ@mail.gmail.com>
In-Reply-To: <CAOVXEJL1qCPmpY-jGW8AsycxGytCzuJQR4hv-bXPPSNyO=5GZQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Oct 2020 17:22:23 -0700
Message-ID: <CABBYNZJQhuYaaxj-CtAsOuEGQSnbf3oMsT55Gyf_Wb0dRa1mmQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Wed, Oct 28, 2020 at 4:46 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi
>
> On Thu, Oct 22, 2020 at 1:47 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
> >
> > When adding device to white list the device is added to resolving list
> > also it has to be added only when HCI_ENABLE_LL_PRIVACY flag is set.
> > HCI_ENABLE_LL_PRIVACY flag has to be tested before adding/deleting devices
> > to resolving list. use_ll_privacy macro is used only to check if controller
> > supports LL_Privacy.
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=209745
> >
> > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > ---
> >  net/bluetooth/hci_request.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 6f12bab4d2fa..610ed0817bd7 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -698,7 +698,8 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
> >                    cp.bdaddr_type);
> >         hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
> >
> > -       if (use_ll_privacy(req->hdev)) {
> > +       if (use_ll_privacy(req->hdev) &&
> > +           hci_dev_test_flag(req->hdev, HCI_ENABLE_LL_PRIVACY)) {
> >                 struct smp_irk *irk;
> >
> >                 irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
> > @@ -732,7 +733,8 @@ static int add_to_white_list(struct hci_request *req,
> >                 return -1;
> >
> >         /* White list can not be used with RPAs */
> > -       if (!allow_rpa && !use_ll_privacy(hdev) &&
> > +       if (!allow_rpa &&
> > +           !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
> >             hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
> >                 return -1;
> >         }
> > @@ -750,7 +752,8 @@ static int add_to_white_list(struct hci_request *req,
> >                    cp.bdaddr_type);
> >         hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
> >
> > -       if (use_ll_privacy(hdev)) {
> > +       if (use_ll_privacy(hdev) &&
> > +           hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
> >                 struct smp_irk *irk;
> >
> >                 irk = hci_find_irk_by_addr(hdev, &params->addr,
> > @@ -812,7 +815,8 @@ static u8 update_white_list(struct hci_request *req)
> >                 }
> >
> >                 /* White list can not be used with RPAs */
> > -               if (!allow_rpa && !use_ll_privacy(hdev) &&
> > +               if (!allow_rpa &&
> > +                   !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
> >                     hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
> >                         return 0x00;
> >                 }
> > --
> > 2.17.1
> >
>
>
> Gentle reminder.
> Seems Many devices are failing to reconnect after every on 5.9 kernel
>
> This patch will FIX the issue

Btw, you should probably mention the commit id that introduced this regression.

-- 
Luiz Augusto von Dentz
