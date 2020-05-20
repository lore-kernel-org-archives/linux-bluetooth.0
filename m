Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF41E20671
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjMGnS8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETQA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETQA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 12:00:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE0C061A0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:00:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v17so2917222ote.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AhkKilZyQsaRKBshO1Hg5sUq91a8lDsqH9hafGNmJNw=;
        b=FjMGnS8rXwkO1i55vnLoGny43PAzZaLLcZS8v35LIPlNo0tW9vCtNLLgTlNOvqAnu8
         EVP6dFhv+eMevEDrnKu6Q+hZJAh9Jx9LLYYDppYncUxstX2sVTc3oNtv+t8JcAVbmyso
         4NrPmn8i1y1zqks2HLrlpYAxN3cXFjO2Iugvytr9E1V4jPu8DyeaIZpak0cDnDLJ+n7x
         vLA3OeHKTDLbzS244EPI2our6xoi6EPWkNOBvGZg/mXlaLxnxQq5xfMTUp3qtAIkR0MG
         unzUTM+/WplDZ2BqkugPr8rtHJ2In5lRHTwRk5hT0B3dwHx6vdW3Pj4hKLIZU+970LqL
         tmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AhkKilZyQsaRKBshO1Hg5sUq91a8lDsqH9hafGNmJNw=;
        b=k/SpFj04L46j3zMvzhgcvS8IVGEduMD9Rw7lCQXwmwIPsOVQNMx1go2Qpm/9jikiy4
         ulEgc0nFU5yKyDfJQIFTU02/RREezedApojE9c8Vhd1JDCH7bOj0OFq1lFyJCURXfaix
         tvrsVOwmljV+KtZ1EQ32MCfFeIy6+METSBj5istsBy4IWI42ZFTOX1k2MG8XGy1kvbWo
         9t5a7IWCH6nFfyntLcwdjpEXZWDqD3dzYY94djSMrpZiuYjxr5MFFS/U7dzr5YuCxpep
         fXf6gLVJ11S7B0qa7MNbLO9SFZZxthKvuprz2MzAFlpzyU7oD8MlVQyZ8NfpVbbkYpLb
         Vo0Q==
X-Gm-Message-State: AOAM531HwyqhgG3+9g0KZdkdLnSmtp2zkcm85SGZDeA+eh0o5XcGo14N
        rlKUNKhljFIwqy+lObWsP2TCpYeCYuzC8Z5jTOh4Bw==
X-Google-Smtp-Source: ABdhPJzSY67VLaacI+FarpLMxOH311zN1dOExDM1OX2cKW8gptlr/yeS1+iIQc2Id2HGCHRoAEFOx1cPcjrV2zaheGA=
X-Received: by 2002:a9d:3637:: with SMTP id w52mr3287969otb.177.1589990425272;
 Wed, 20 May 2020 09:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200519202519.219335-1-luiz.dentz@gmail.com> <180CD116-CEC8-42B3-B3F0-C8EAF76FB1A7@holtmann.org>
In-Reply-To: <180CD116-CEC8-42B3-B3F0-C8EAF76FB1A7@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 20 May 2020 09:00:13 -0700
Message-ID: <CABBYNZLJhFqVTtmHip+oqUrBd-rYa19aZZroOHdVSNRM=-D_BQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Disconnect if E0 is used for Level 4
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, May 20, 2020 at 7:23 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > E0 is not allowed with Level 4:
> >
> > BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1319:
> >
> >  '128-bit equivalent strength for link and encryption keys
> >   required using FIPS approved algorithms (E0 not allowed,
> >   SAFER+ not allowed, and P-192 not allowed; encryption key
> >   not shortened'
> >
> > SC enabled:
> >
> >> HCI Event: Read Remote Extended Features (0x23) plen 13
> >        Status: Success (0x00)
> >        Handle: 256
> >        Page: 1/2
> >        Features: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >          Secure Simple Pairing (Host Support)
> >          LE Supported (Host)
> >          Secure Connections (Host Support)
> >> HCI Event: Encryption Change (0x08) plen 4
> >        Status: Success (0x00)
> >        Handle: 256
> >        Encryption: Enabled with AES-CCM (0x02)
> >
> > SC disabled:
> >
> >> HCI Event: Read Remote Extended Features (0x23) plen 13
> >        Status: Success (0x00)
> >        Handle: 256
> >        Page: 1/2
> >        Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >          Secure Simple Pairing (Host Support)
> >          LE Supported (Host)
> >> HCI Event: Encryption Change (0x08) plen 4
> >        Status: Success (0x00)
> >        Handle: 256
> >        Encryption: Enabled with E0 (0x01)
> > [May 8 20:23] Bluetooth: hci0: Invalid security: expect AES but E0 was =
used
> > < HCI Command: Disconnect (0x01|0x0006) plen 3
> >        Handle: 256
> >        Reason: Authentication Failure (0x05)
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_conn.c  | 17 +++++++++++++++++
> > net/bluetooth/hci_event.c |  6 ++----
> > 2 files changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 07c34c55fc50..0c1cae83c8dc 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1325,6 +1325,23 @@ int hci_conn_check_link_mode(struct hci_conn *co=
nn)
> >                       return 0;
> >       }
> >
> > +      /* AES encryption is required for Level 4:
> > +       *
> > +       * BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C
> > +       * page 1319:
> > +       *
> > +       * 128-bit equivalent strength for link and encryption keys
> > +       * required using FIPS approved algorithms (E0 not allowed,
> > +       * SAFER+ not allowed, and P-192 not allowed; encryption key
> > +       * not shortened)
> > +       */
> > +     if (conn->sec_level =3D=3D BT_SECURITY_FIPS &&
> > +         !test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
> > +             bt_dev_err(conn->hdev, "Invalid security: expect AES but =
E0 "
> > +                        "was used");
>
> make this bt_dev_warn since it is something that can happen. We fail appr=
opriately now. Also try to fit the error in a single line. =E2=80=9CInvalid=
 security: Missing AES-CCM usage=E2=80=9D.

Sure will update this.

> > +             return 0;
> > +     }
> > +
> >       if (hci_conn_ssp_enabled(conn) &&
> >           !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
> >               return 0;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 006c24e04b44..dc1cc3c4348c 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3078,10 +3078,8 @@ static void hci_encrypt_change_evt(struct hci_de=
v *hdev, struct sk_buff *skb)
> >        * that are not encrypted with AES-CCM using a P-256 authenticate=
d
> >        * combination key.
> >        */
> > -     if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
> > -         (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
> > -          conn->key_type !=3D HCI_LK_AUTH_COMBINATION_P256)) {
> > -             hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
> > +     if (!hci_conn_check_link_mode(conn)) {
> > +             hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
>
> Why is this a disconnect now? If this is better, then this needs to be ex=
plained above, but I have the feeling we really want to respond to the conn=
ect request in a clean fashion.

While testing this I discover that calling connect_cfm doesn't
actually cause a disconnect, at least not immediately, and by
disconnecting it actually provides the right error to the remote. Note
that there is a similar usage in the if statement right above this
code, but I believe that even in case we want to cleanup the earlier
what we should be calling is hci_encrypt_cfm.

> >               hci_conn_drop(conn);
> >               goto unlock;
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
