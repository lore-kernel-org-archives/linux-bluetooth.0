Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09444C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 16:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiBQQNf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:13:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiBQQNe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 11:13:34 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7616A5B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 08:13:19 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2d310db3812so37239127b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 08:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rr/wqyaJbRSIDjn2wKiX+KqsdF8KYwEggKDDkcFdngc=;
        b=hd6XXdhYumqYB55Zryz3Fe2hCNYYJa0rfvaeldpGrvcAyohip03birJhROkyaqfdvy
         OwUMLbTf96g0f1l5sMzaWABHh+LM0WZYh6z14W1aQf4xs4m7ORN/pkeppWPHXUqD9B/g
         EYOf8m0nQ6I4A9kQ6M8h8enb0xrREddTV1YVqenO3L29PKuiUiF58TgWJ4d2YDExMcgO
         KbMhynYIEKALBxbEqau2CkHe2GC7OTGvNJ3Y20GSMS2QadQIA51rHiBD2aKv472lD7yp
         6GruirVBGHtzLKxmUHiK0Ag3JXu1gh03IV+w4Mffglj3zTIv+B5LSavFtkpcSzSDsOK/
         fQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rr/wqyaJbRSIDjn2wKiX+KqsdF8KYwEggKDDkcFdngc=;
        b=EQpYh2ViZH9hwUGM3wPUcSfe5y5n2+NJzKkfaNnNMtCCIbep0E+5Pzq02Prod4ufy2
         szTcYnqN6fCgHtk6YRBhYB9Cux3GAYCtIYm5gOt3PAKAfszz16CTVXgX2akR7HROXYEn
         cV1ExRvHxNlc5RHgUBKfF/oqUITo2ebsuG/Cthmqn26B0Y1qOKfpx9UiY3sycNVjNpPv
         yFjR3iTKagQPezl1Xab7aQBZfuMOhTN6/Kr86zAHUnmxRIbQEADdoF3THgVY8UKiwJK0
         yyBLg0FCr8B55LNJvj37rg1b2Zz6ps1lMf/0ADLILU0Pozjw7GsSAm6z37eB6FbfBgto
         eM8g==
X-Gm-Message-State: AOAM533FsiNR/QswwGmcTUAeLGTppjboNledMD4zt9OI0IlD+QTHHL6C
        bLLR1wUKBkJ9+IISdiECCg4R2sHVCkS3c00JYzTaDAkScTQ=
X-Google-Smtp-Source: ABdhPJwXzQB8DYulN445aoLjMNo8s9U841H6j4ak8UncUOD/OUCbRn8NuMfsHm5NfTcHLOaSOd0UYMX2tLLLE0FiCRw=
X-Received: by 2002:a81:638b:0:b0:2d6:ac65:962 with SMTP id
 x133-20020a81638b000000b002d6ac650962mr2048816ywb.37.1645114398822; Thu, 17
 Feb 2022 08:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20220216221822.2694867-1-luiz.dentz@gmail.com> <85EF808B-F51B-4F3B-B484-5952D8DC108B@holtmann.org>
In-Reply-To: <85EF808B-F51B-4F3B-B484-5952D8DC108B@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Feb 2022 08:13:08 -0800
Message-ID: <CABBYNZKY7utNOKjMXT_YYbFNXMAjjOY3QmshYVE4aCp5g_DwjQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix not using conn_timeout
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Feb 17, 2022 at 1:50 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > When using hci_le_create_conn_sync it shall wait for the conn_timeout
> > since the connection complete may take longer than just 2 seconds.
> >
> > Also fix the masking of HCI_EV_LE_ENHANCED_CONN_COMPLETE and
> > HCI_EV_LE_CONN_COMPLETE so they are never both set so we can predict
> > which one the controller will use in case of HCI_OP_LE_CREATE_CONN.
> >
> > Fixes: 6cd29ec6ae5e3 ("Bluetooth: hci_sync: Wait for proper events when connecting LE")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_sync.c | 27 +++++++++++++++------------
> > 1 file changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 9dbf007e3dc7..002f9c5b5371 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3265,11 +3265,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
> >       if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
> >               events[0] |= 0x40;      /* LE Data Length Change */
> >
> > -     /* If the controller supports LL Privacy feature, enable
> > -      * the corresponding event.
> > +     /* If the controller supports LL Privacy feature or LE Extended
> > +      * Create Connection, enable the corresponding event.
> >        */
> > -     if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
> > +     if (ll_privacy_capable(hdev) || hdev->commands[37] & 0x80) {
> >               events[1] |= 0x02;      /* LE Enhanced Connection Complete */
> > +     } else if (hdev->commands[26] & 0x10) {
> > +             /* If the controller supports the LE Create Connection
> > +              * command, enable the corresponding event.
> > +              */
> > +             events[0] |= 0x01;      /* LE Connection Complete */
> > +     }
> >
> >       /* If the controller supports Extended Scanner Filter
> >        * Policies, enable the corresponding event.
> > @@ -3289,12 +3295,6 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
> >       if (hdev->commands[26] & 0x08)
> >               events[0] |= 0x02;      /* LE Advertising Report */
> >
> > -     /* If the controller supports the LE Create Connection
> > -      * command, enable the corresponding event.
> > -      */
> > -     if (hdev->commands[26] & 0x10)
> > -             events[0] |= 0x01;      /* LE Connection Complete */
> > -
>
> I do not understand why you are trying to intermix this with LL Privacy. If the controller supports the LE Extended Create Connection, then we should enable that event. No matter if we have LL Privacy supported or enabled.
>
> If we have other code that intermixes this, then it needs to be untangled.
>
> What we should be doing is to only support LL Privacy if we also have support for LE Extended Create Connection command, but the assumption the other way around makes no sense.

The spec does allow the use of LE Create Connection and Enhanced
Connection Complete since it does support own_address_type to be
0x02/0x03 which means LL Privacy, I believe LE Extented Create
Connection was introduced much later than LL Privacy so we may find
controllers supporting LL Privacy with LE Create Connection but
without support for LE Extended Create Connection.

> >       /* If the controller supports the LE Connection Update
> >        * command, enable the corresponding event.
> >        */
> > @@ -5188,7 +5188,7 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
> >       return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
> >                                       plen, data,
> >                                       HCI_EV_LE_ENHANCED_CONN_COMPLETE,
> > -                                     HCI_CMD_TIMEOUT, NULL);
> > +                                     conn->conn_timeout, NULL);
> > }
> >
> > int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
> > @@ -5274,8 +5274,11 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
> >       cp.max_ce_len = cpu_to_le16(0x0000);
> >
> >       err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
> > -                                    sizeof(cp), &cp, HCI_EV_LE_CONN_COMPLETE,
> > -                                    HCI_CMD_TIMEOUT, NULL);
> > +                                    sizeof(cp), &cp,
> > +                                    ll_privacy_capable(hdev) ?
> > +                                    HCI_EV_LE_ENHANCED_CONN_COMPLETE :
> > +                                    HCI_EV_LE_CONN_COMPLETE,
> > +                                    conn->conn_timeout, NULL);
>
> This is stupid. We should not be using LE Create Connection in the first place here. If the LE Extended Create Connection is available, we unmask its event and also use the command.

This comes from the spec actually:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 2374
When the Controller receives the HCI_LE_Create_Connection command, the
Controller sends the HCI_Command_Status event to the Host. An HCI_LE_-
Connection_Complete or HCI_LE_Enhanced_Connection_Complete event
shall be generated...

The reason why HCI_LE_Enhanced_Connection_Complete is required is
because own_address_type can be set to 0x02/0x03 and in that case we
need the Local_Resolvable_Private_Address used by the controller. Now
you can say that we could restrict LL Privacy support to be used only
with LE Extended Create Connection but that would be our own
restriction.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
