Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36677CA90AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFA820731
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jx9mB9zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELTfD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 15:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTfD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 15:35:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A870C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 12:35:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i13so19288525oie.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 12:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YGDI+yJeD00tU/1yDVwaMSidQu+F9oEjFDSx9vNfTE=;
        b=jx9mB9zjYgKNh/5R9uRCOM/VSSO7kShG8ymD1UvaJ/u0/VuvPpCVtXriExJmLP0Z0w
         mAOyBJtdoADQ0BwcOr86myJHuADBTOATkyrqQ180T9T2h2QHxHg1sBo/mWYmRBjWF8za
         FvvJRwlfyigczMa0UOX1M5z1Jao5wpBLWns1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YGDI+yJeD00tU/1yDVwaMSidQu+F9oEjFDSx9vNfTE=;
        b=ZYG+YsIFKxrHyjJFSCZpKKLMHtSVi36wMxOx09642ZtUoD/X0KR4v/yyWEyHqwSF/y
         xIgUs7l7uOl9FH41hi9dZ/ku1z3Y0KKdi5fURr9fgwhZRoxFAH+t4EEvwTnHKsqLhthe
         WCSlFXNBTGkpMRRt0U2MnHsE1yRuXA3f/AVbBIf/FZ7WPB1i6As41BLFBSZeiKMcO2m0
         ZjM+oWU6i/47PMJ96t9ouiGiAkWb5Zb7Dqi7r6ea4+yO+7mGCeS1dDP8Q3QupWwWK6JI
         OaIOiZeB1pWbM7AS09zY2QBTM7DhU8uiJ/BlkolhRYplCN3fKs3L4nfjc4OZ5198vkJv
         L+FQ==
X-Gm-Message-State: AGi0PuYkgR6/jTWHZba4HOOq9kUmKTECk3c84aO4znZur3VMtc1uAN1H
        k5aokhrBsIIbpPwyZJRk38Lfo27OFYrgkP4w8K7dh1VS
X-Google-Smtp-Source: APiQypLGe3gFlDI3UlHpyA01X3K8KDzjk6z3SUQyFn4SasQXT4B/jQ/4TmXSiwS6PkqihsQc2Y+S6v4wPi9bNK4R7hA=
X-Received: by 2002:aca:c705:: with SMTP id x5mr24940139oif.136.1589312101412;
 Tue, 12 May 2020 12:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200428051151.14879-1-sonnysasaka@gmail.com> <D2192131-CC65-4D4E-91BE-B1C3B1C12BC4@holtmann.org>
 <CAOxioN=2p23_K1VuFth5PwFAUR1oXcgs5GPHeM595OOivh6Y2Q@mail.gmail.com>
 <CAOxioN=1dP9W=WZ2TM+3RLbVmxBYkcrG0s4HiExihAXQ=0pJJg@mail.gmail.com>
 <89566A98-F0CE-4E70-A344-915E81FB0C14@holtmann.org> <CAOxioNkYyVdOorRkZsvQjcLjuHgc0BJKqG--g30meO3F=Rv46g@mail.gmail.com>
In-Reply-To: <CAOxioNkYyVdOorRkZsvQjcLjuHgc0BJKqG--g30meO3F=Rv46g@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 12 May 2020 12:34:49 -0700
Message-ID: <CAOxioNkY0pm-3xU0g1uouUsCUW6FhoUkAPUg5pcu+J9uanUuXw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry Complete
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Could you take another look at my latest patch based on your feedback? Thanks.

On Wed, May 6, 2020 at 12:57 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Marcel,
>
> Please take a look at the modified patch based on your feedback. Thanks.
>
> On Tue, May 5, 2020 at 4:42 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Sonny,
> >
> > > Could you take another look at my last proposal based on your
> > > suggestion? If we are to move the logic inside hci_cc_inquiry_cancel,
> > > we will need a way to update the status to the caller, for example by
> > > having hci_cc_inquiry_cancel return a value, or accept a pointer for
> > > the updated status value. Let me know which way you prefer.
> >
> > maybe something like this (missing comment of course):
> >
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -42,14 +42,20 @@
> >
> >  /* Handle HCI Event packets */
> >
> > -static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
> > +static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
> > +                                 u8 *new_status)
> >  {
> >         __u8 status = *((__u8 *) skb->data);
> >
> >         BT_DBG("%s status 0x%2.2x", hdev->name, status);
> >
> > -       if (status)
> > +       if (status) {
> > +               if (!test_bit(HCI_INQUIRY, &hdev->flags) && status == 0x0c) {
> > +                       BT_DBG("Ignoring error of HCI Inquiry Cancel command");
> > +                       *new_status = 0x00;
> > +               }
> >                 return;
> > +       }
> >
> >         clear_bit(HCI_INQUIRY, &hdev->flags);
> >         smp_mb__after_atomic(); /* wake_up_bit advises about this barrier */
> > @@ -3233,7 +3239,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> >
> >         switch (*opcode) {
> >         case HCI_OP_INQUIRY_CANCEL:
> > -               hci_cc_inquiry_cancel(hdev, skb);
> > +               hci_cc_inquiry_cancel(hdev, skb, status);
> >                 break;
> >
> >         case HCI_OP_PERIODIC_INQ:
> >
> > Regards
> >
> > Marcel
> >
