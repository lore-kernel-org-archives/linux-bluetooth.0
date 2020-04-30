Return-Path: <SRS0=orbE=6O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02529C47247
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76C4206D6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 17:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixFLyvZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgD3RLm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3RLm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Apr 2020 13:11:42 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8470C035494
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2020 10:11:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b13so145202oti.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2020 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HhEXPM15zHFi4pYSRE7q3ZLxaI3Dnl+P2vNjJtNZXzA=;
        b=ixFLyvZisHaSM3yIipZxvIUVSL9ELQ6tK8202Oi9MJ9jifXH5IQomD5h1gTHmu7Paq
         2DpFw8zvwmRxx3QsK00VNnl9xrX24imvatfgSpPl73C/nAXaV2gZk6951QcYv2J1wTsG
         4Nbv7o16inGz4P8RBSuPF8svUuoEbM7/p6ptU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HhEXPM15zHFi4pYSRE7q3ZLxaI3Dnl+P2vNjJtNZXzA=;
        b=gzBTKdqypxBIvH6qxuwAHa+mua0YxWUn1Y2TuQGr1SZXVL/uoZ+TwGX+wzUrKAKBSQ
         dsMU1tDmdVdw/LJ/gm0CV2RuCVgHMFP6dIAd02fUKZq6XrmwUSoUgYoWliad0QJv6q5q
         IncwEUTLacq+npW9Vij4oCWl/6bLw8WVQqCWDJYqFcJg+OMHKpUsIln0KuytCQ0XmXcV
         4CViX2A0kfk6FfA3Ns7oufPvciwd7paIj4r8BVg7OQhUqgFRC8DXeyIH8xvJXddCiv54
         jNlxk1XnRLcopiMU/ckoO+fwPBlm84wBVoShmyiN6D/W2lC3zE0EYEV92RXp0JOOh0VE
         xUqA==
X-Gm-Message-State: AGi0Pub9P4LkxVFHo7QeO5jSWya3IDBvFrrke+tpasVEKyut2vmZskOb
        9/EkC3MdSabgr/Eek+gkarwrgWE3/xjiZk8pQL087y5681s=
X-Google-Smtp-Source: APiQypJAXUu5v13jmVFGzJgDIcHLXV5IfYdhnHlk471Fi+d0adei0krApKcOkiX2VLiXI+IQHMGqFJgY6hQ8ieZpq9o=
X-Received: by 2002:a05:6830:1d9c:: with SMTP id y28mr89958oti.280.1588266699851;
 Thu, 30 Apr 2020 10:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200428051151.14879-1-sonnysasaka@gmail.com> <D2192131-CC65-4D4E-91BE-B1C3B1C12BC4@holtmann.org>
 <CAOxioN=2p23_K1VuFth5PwFAUR1oXcgs5GPHeM595OOivh6Y2Q@mail.gmail.com>
In-Reply-To: <CAOxioN=2p23_K1VuFth5PwFAUR1oXcgs5GPHeM595OOivh6Y2Q@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 30 Apr 2020 10:11:28 -0700
Message-ID: <CAOxioN=1dP9W=WZ2TM+3RLbVmxBYkcrG0s4HiExihAXQ=0pJJg@mail.gmail.com>
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

Could you take another look at my last proposal based on your
suggestion? If we are to move the logic inside hci_cc_inquiry_cancel,
we will need a way to update the status to the caller, for example by
having hci_cc_inquiry_cancel return a value, or accept a pointer for
the updated status value. Let me know which way you prefer.

On Tue, Apr 28, 2020 at 10:25 AM Sonny Sasaka <sonnysasaka@chromium.org> wr=
ote:
>
> Hi Marcel,
>
> On Tue, Apr 28, 2020 at 2:47 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Sonny,
> >
> > > After sending Inquiry Cancel command to the controller, it is possibl=
e
> > > that Inquiry Complete event comes before Inquiry Cancel command compl=
ete
> > > event. In this case the Inquiry Cancel command will have status of
> > > Command Disallowed since there is no Inquiry session to be cancelled.
> > > This case should not be treated as error, otherwise we can reach an
> > > inconsistent state.
> > >
> > > Example of a btmon trace when this happened:
> > >
> > > < HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> > >> HCI Event: Inquiry Complete (0x01) plen 1
> > >        Status: Success (0x00)
> > >> HCI Event: Command Complete (0x0e) plen 4
> > >      Inquiry Cancel (0x01|0x0002) ncmd 1
> > >        Status: Command Disallowed (0x0c)
> > > ---
> > > net/bluetooth/hci_event.c | 19 +++++++++++++++----
> > > 1 file changed, 15 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 966fc543c01d..0f3f7255779f 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -42,10 +42,9 @@
> > >
> > > /* Handle HCI Event packets */
> > >
> > > -static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> > > +static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_bu=
ff *skb,
> > > +                               u8 status)
> > > {
> > > -     __u8 status =3D *((__u8 *) skb->data);
> > > -
> > >       BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > >
> > >       if (status)
> > > @@ -3233,7 +3232,19 @@ static void hci_cmd_complete_evt(struct hci_de=
v *hdev, struct sk_buff *skb,
> > >
> > >       switch (*opcode) {
> > >       case HCI_OP_INQUIRY_CANCEL:
> > > -             hci_cc_inquiry_cancel(hdev, skb);
> > > +             /* It is possible that we receive Inquiry Complete even=
t right
> > > +              * before we receive Inquiry Cancel Command Complete ev=
ent, in
> > > +              * which case the latter event should have status of Co=
mmand
> > > +              * Disallowed (0x0c). This should not be treated as err=
or, since
> > > +              * we actually achieve what Inquiry Cancel wants to ach=
ieve,
> > > +              * which is to end the last Inquiry session.
> > > +              */
> > > +             if (*status =3D=3D 0x0c && !test_bit(HCI_INQUIRY, &hdev=
->flags)) {
> > > +                     BT_DBG("Ignoring error of HCI Inquiry Cancel co=
mmand");
> > > +                     *status =3D 0;
> > > +             }
> >
> > is there a problem with moving this check into hci_cc_inquiry_cancel? T=
hen we don=E2=80=99t have to play any tricks with an extra parameter that i=
s also included in the skb data struct itself.
> I did that the first time, but turns out the updated status code is
> needed in the bottom part of this function. So, if we are to move this
> logic inside hci_cc_inquiry_cancel, we will need a way to update the
> status, for example by having hci_cc_inquiry_cancel return a value, or
> accept a pointer for the updated status value. Let me know which way
> you prefer.
> >
> > I prefer we start using bt_dev_dbg and in this case maybe we just use b=
t_dev_warn or bt_dev_warn_ratelimited.
> Ack, I will change BT_DBG to bt_dev_dbg.
> >
> > Regards
> >
> > Marcel
> >
