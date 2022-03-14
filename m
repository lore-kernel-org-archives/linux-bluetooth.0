Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 15:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiCNPiV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiCNPiU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 11:38:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8610143ADA
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 08:37:10 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h196so13039900qke.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0elgh052PSKRgUoeTnvN0bWDvw6A8anfaBt8OXlPQ1Y=;
        b=IyDJx9FYLxq0/OFsl6PjULq1hPM856m5NjEgas6tyzwW95iNX23GcmcSfTJao1Fs/h
         tEtyXRs5sajz8UhQzmJCrvnbMP7lrCkmfqVXyx57DLKwk4PFK0RvlBIsiR/94g0I7C5A
         YrnmAurs8ZyiwcDO763iE4Nv7FSddrIfqLH+28Ije3Ai5heLz+OwouI0bqjK4GIIGWai
         MTsTx3GdhUHVPdnjITT9f0PKJUHfKt2sEuZ5Aur/ejjH+qKT/4cd6c/WW8NOPmmTLXgw
         izFMebbzzUX0tj8pI8aAt+aXqwLiX40VKiFbdvc6SUYsmPf/GGGio/meEWEfa6Q5ya6T
         7vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0elgh052PSKRgUoeTnvN0bWDvw6A8anfaBt8OXlPQ1Y=;
        b=J3mr0a15+fHst14FdKmWCKCeCURLWV/KsnSDxMxVHCxE72rXF2H9bt/+sfYrsuzT4c
         xY7R4TnE7QoETTBdrFOkBhGljWc9i4yd+gC33kvChnzzn0LcjnCX/R8y7WfGgsDTHT+x
         asTj+EX0XH7NbQK9oHhKMJWE14oOQR2GbfDpgkHN9HkFMr8G2ipNCZ8F3P7LHrvvMana
         EyrhNQagKpnxQgt0LB78yPfOTMJv78/9HrE6lJbVpeMpgdlC9krYaAO+lxiz9B8qSFvA
         Khw/Q6+G9dENkmBF98uOu6qPu1sbK4t3EQOg489j1HNb7/sEki5sMXbWGrY60N+hck+I
         6uxw==
X-Gm-Message-State: AOAM533AhHs39i9URA9Aoa/bYM4ZKa+75h/bCJPm80t07jBrkVcHL1BI
        cN77YB1Vitcc6+3UjBWOsLX7KcJGeIAQmP7xN3dFIg==
X-Google-Smtp-Source: ABdhPJyTloUkN91Q7ZAlujMEv/38sKubt4ooFXq30iFcN33LD+RPW78EKqagwBPZqPZIqDQ7wmDhXrXxN16GxBT1U60=
X-Received: by 2002:a05:620a:1902:b0:5f1:8f5d:b0f2 with SMTP id
 bj2-20020a05620a190200b005f18f5db0f2mr15068195qkb.60.1647272229548; Mon, 14
 Mar 2022 08:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220312164550.1810665-1-mike@fireburn.co.uk> <61E2F921-2006-4E9A-AAFF-47371CBC5FCD@holtmann.org>
In-Reply-To: <61E2F921-2006-4E9A-AAFF-47371CBC5FCD@holtmann.org>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Mon, 14 Mar 2022 15:36:57 +0000
Message-ID: <CAHbf0-GWcz85r4GEzmySFJ1n4iqeDTAm5H_Njs0FEpBs1hkJHw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Remove excessive bluetooth warning
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 14 Mar 2022 at 15:32, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Mike,
>
> > Fixes: 3e54c5890c87a ("Bluetooth: hci_event: Use of a function table to=
 handle HCI events")
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > ---
> > net/bluetooth/hci_event.c | 8 --------
> > 1 file changed, 8 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index fc30f4c03d29..aa57fccd2e47 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6818,14 +6818,6 @@ static void hci_event_func(struct hci_dev *hdev,=
 u8 event, struct sk_buff *skb,
> >               return;
> >       }
> >
> > -     /* Just warn if the length is over max_len size it still be
> > -      * possible to partially parse the event so leave to callback to
> > -      * decide if that is acceptable.
> > -      */
> > -     if (skb->len > ev->max_len)
> > -             bt_dev_warn(hdev, "unexpected event 0x%2.2x length: %u > =
%u",
> > -                         event, skb->len, ev->max_len);
> > -
>
> which event type is this? You need to have a commit message giving detail=
s. I am also pretty sure that this is broken hardware and we can go for rat=
elimited version, but the warning is justified if the hardware is stupid. I=
f our table is wrong, we fix the table, but not just silence an unpleasant =
warning.
>
> Regards
>
> Marcel
>

Hi Marcel

I noticed it had already been fixed in "Bluetooth: hci_event: Fix
HCI_EV_VENDOR max_len"

I've replied to that patch asking if it can be added to stable, would
be nice to get this into 5.17.0 before next week

Cheers

Mike
