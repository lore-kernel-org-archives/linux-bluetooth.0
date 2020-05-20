Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD54C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3E5206F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ertmoMkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETQMa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 12:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETQMa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 12:12:30 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0AC061A0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:12:30 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r25so3435398oij.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xZ8DRdmeUNyP0PUflWE1EGx9yFWiqiQD2HEoHTtH/vw=;
        b=ertmoMkXnVPnu0U+HG1oiT3M6S7KUW2FLLOeWRKeHZl6Y1JUXrhUdkJPGXdO61GHcC
         xgSj53izAlbacByJnCZs+R4womn+O8ZKbDoCqN/8WBvZEAwUVJC3adV93Vn7gXIsz/nk
         lsa8iORhueCzcPeSccvisD03EAnzC2DIX1OS4cTgcJmxUO7MIQ5gIoxwMA0nxAG1TLDz
         84vUc2GSAMdLI5OW+y0GrXwfMY2FxgWBW43ZqZelByO4ZUU9+NH2c7h6L8ecxwV/AAEW
         IGR3uVid3UpLLRsOY7Pdn/EmA4+oioqfn7ePgedzx5Gat6XmhHiCsiVZWTp7QCneCOwf
         vKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xZ8DRdmeUNyP0PUflWE1EGx9yFWiqiQD2HEoHTtH/vw=;
        b=acUjxWZrtR/x6vLQXkjQCRgEw3M9qWKcycUCcBo6K/Af0xlYL4ldg0FvjeV/a/4j/E
         cEgcq6LcbAnexSxVnbdc41s1CPnaGa1OR6i9xzN/2FJP8R1/JpsEEQyGAhg4D2lg5DU4
         Y4At1/jUBIkdKOXDZa/YNlLNw8Gg9oIUl0sx5Tnr+ZdVYIset6sQJckHNXR4vdrF5I7D
         OWoxXh54XphbxkgLuxYx8cz/4QLrLh7akgPq16d3/Vg5D5VZ14Wp4pCzzFqBKRGvt+v6
         GbmTm3O4oPo62prfr0bIQaDjHtScA8sNiZ9mWIlJVrx7wOTLOjK8LujAspHcgWHsxYQ/
         VCwA==
X-Gm-Message-State: AOAM533i/zpkzF9COOAa8h//Kl84f/GzB6hQHTGy/x8w5X1ZmDI/kMJY
        NvmO+gWqY3rIElMQbUqMpDwR9Bh3jqZ6Zdoenb01n35K
X-Google-Smtp-Source: ABdhPJzuh3stIwr1Y1Rd2cScaNvoE/1t7MePIfcAtJDZxEGeebrcuTcUNEYppaD8dKXjybZJkNQsoMXEOcwlgFYaV3c=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr3753290oif.108.1589991149619;
 Wed, 20 May 2020 09:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200519202519.219335-1-luiz.dentz@gmail.com> <20200519202519.219335-3-luiz.dentz@gmail.com>
 <6C0E3EC4-853B-4736-8611-47B895BEE3D0@holtmann.org>
In-Reply-To: <6C0E3EC4-853B-4736-8611-47B895BEE3D0@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 20 May 2020 09:12:18 -0700
Message-ID: <CABBYNZJn5UtqoZppppvn9b6BRro78H2rD7hUpMf3sz9=XmaQvA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Fix bogus check for re-auth no supported
 with non-ssp
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, May 20, 2020 at 7:25 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This reverts 19f8def031bfa50c579149b200bfeeb919727b27
> > "Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
> > working around a bug on a broken controller rather then any limitation
> > imposed by the Bluetooth spec, in fact if there ws not possible to
> > re-auth the command shall fail not succeed.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_event.c | 10 ++--------
> > 1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index dc1cc3c4348c..8c9051ffa665 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2869,14 +2869,8 @@ static void hci_auth_complete_evt(struct hci_dev=
 *hdev, struct sk_buff *skb)
> >
> >       if (!ev->status) {
> >               clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
> > -
> > -             if (!hci_conn_ssp_enabled(conn) &&
> > -                 test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
> > -                     bt_dev_info(hdev, "re-auth of legacy device is no=
t possible.");
> > -             } else {
> > -                     set_bit(HCI_CONN_AUTH, &conn->flags);
> > -                     conn->sec_level =3D conn->pending_sec_level;
> > -             }
> > +             set_bit(HCI_CONN_AUTH, &conn->flags);
> > +             conn->sec_level =3D conn->pending_sec_level;
> >       } else {
> >               if (ev->status =3D=3D HCI_ERROR_PIN_OR_KEY_MISSING)
> >                       set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
>
> wouldn=E2=80=99t we now also remove HCI_CONN_REAUTH_PEND flag?

Yep, it doesn't seem there is any other user of HCI_CONN_REAUTH_PEND,
not sure if we wouldn't need this in the future though if we do want
to check if reauth was triggered.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
