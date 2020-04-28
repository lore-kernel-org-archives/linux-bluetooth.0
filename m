Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F5C83001
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC50D208E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+gDYQ0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgD1RZT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgD1RZS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 13:25:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D57C03C1AB
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 10:25:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z25so33950395otq.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qEl4USUqFB6JqHlqFfW/Dryo1O9t3q0l8vsjJt61DdI=;
        b=U+gDYQ0h5oVcim2DhdgUj0HZlz4grXKpjTP/HLyWUAh7bg+sRo4MPGeeiV3IvsZgsF
         iBvgFhFXN3TuxqtpSC85+7YxqB5GAMT0tuVHR80nwViYc8EJxob97pnLoUWaVf/145Qg
         O1/pEuOqlRGOfmwtMIC/YFJGY2tAUmutz6fY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qEl4USUqFB6JqHlqFfW/Dryo1O9t3q0l8vsjJt61DdI=;
        b=V15vsBwKRyEAIrkC9rrrVF/AG556cA2+TvjPQ3cSUlMWvSNzKzzECbE//3daUMjZhJ
         TyFqrlKNi/yelE7Xd+C3RICHcRWmVzUWxfhWL9oK0FMfU9HX7Ig3GzOX179vjoVRgzq0
         QMidgVUqNnBXv5ZIAHRMYgXqKSOFSLcRSX1b4ot1UOjegahKkmP1oloYMWHlLbTCCqG5
         mpGXLquQGFJhZfczvqPRg+qStXlDVql+yK3iRdQgOKh4C4+Jcbl73D3cvXSG8PAxhjtG
         sU4mWoMFwyveRViv/d2TaYhYuMUoETUnclfBYK743pzaIynjgxP85O0NFwXGVMlxhTEP
         ruQA==
X-Gm-Message-State: AGi0PuY45/gOLJSU/kjTo4YfFp0r1wMKTyYE1uEwAMrDszBO11RyxpL5
        T05phSDxn1Qk5y2I67M8frRAzH7vvRHh9a1uQF7Bcq4qXTY=
X-Google-Smtp-Source: APiQypJypzkfRqGd3vIhwlR7BEixBzyoiy77kzqT6y7tluJvrLmZcjJvtRQu1GccfB5WsdcOoFjeNcVGWjU9k3G6tXk=
X-Received: by 2002:a9d:51cc:: with SMTP id d12mr21818762oth.70.1588094716580;
 Tue, 28 Apr 2020 10:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200428051151.14879-1-sonnysasaka@gmail.com> <D2192131-CC65-4D4E-91BE-B1C3B1C12BC4@holtmann.org>
In-Reply-To: <D2192131-CC65-4D4E-91BE-B1C3B1C12BC4@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 28 Apr 2020 10:25:05 -0700
Message-ID: <CAOxioN=2p23_K1VuFth5PwFAUR1oXcgs5GPHeM595OOivh6Y2Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry Complete
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 28, 2020 at 2:47 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sonny,
>
> > After sending Inquiry Cancel command to the controller, it is possible
> > that Inquiry Complete event comes before Inquiry Cancel command complet=
e
> > event. In this case the Inquiry Cancel command will have status of
> > Command Disallowed since there is no Inquiry session to be cancelled.
> > This case should not be treated as error, otherwise we can reach an
> > inconsistent state.
> >
> > Example of a btmon trace when this happened:
> >
> > < HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> >> HCI Event: Inquiry Complete (0x01) plen 1
> >        Status: Success (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4
> >      Inquiry Cancel (0x01|0x0002) ncmd 1
> >        Status: Command Disallowed (0x0c)
> > ---
> > net/bluetooth/hci_event.c | 19 +++++++++++++++----
> > 1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 966fc543c01d..0f3f7255779f 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -42,10 +42,9 @@
> >
> > /* Handle HCI Event packets */
> >
> > -static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff=
 *skb)
> > +static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff=
 *skb,
> > +                               u8 status)
> > {
> > -     __u8 status =3D *((__u8 *) skb->data);
> > -
> >       BT_DBG("%s status 0x%2.2x", hdev->name, status);
> >
> >       if (status)
> > @@ -3233,7 +3232,19 @@ static void hci_cmd_complete_evt(struct hci_dev =
*hdev, struct sk_buff *skb,
> >
> >       switch (*opcode) {
> >       case HCI_OP_INQUIRY_CANCEL:
> > -             hci_cc_inquiry_cancel(hdev, skb);
> > +             /* It is possible that we receive Inquiry Complete event =
right
> > +              * before we receive Inquiry Cancel Command Complete even=
t, in
> > +              * which case the latter event should have status of Comm=
and
> > +              * Disallowed (0x0c). This should not be treated as error=
, since
> > +              * we actually achieve what Inquiry Cancel wants to achie=
ve,
> > +              * which is to end the last Inquiry session.
> > +              */
> > +             if (*status =3D=3D 0x0c && !test_bit(HCI_INQUIRY, &hdev->=
flags)) {
> > +                     BT_DBG("Ignoring error of HCI Inquiry Cancel comm=
and");
> > +                     *status =3D 0;
> > +             }
>
> is there a problem with moving this check into hci_cc_inquiry_cancel? The=
n we don=E2=80=99t have to play any tricks with an extra parameter that is =
also included in the skb data struct itself.
I did that the first time, but turns out the updated status code is
needed in the bottom part of this function. So, if we are to move this
logic inside hci_cc_inquiry_cancel, we will need a way to update the
status, for example by having hci_cc_inquiry_cancel return a value, or
accept a pointer for the updated status value. Let me know which way
you prefer.
>
> I prefer we start using bt_dev_dbg and in this case maybe we just use bt_=
dev_warn or bt_dev_warn_ratelimited.
Ack, I will change BT_DBG to bt_dev_dbg.
>
> Regards
>
> Marcel
>
