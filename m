Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B407BC2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76073249B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 16:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrRBRYJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgDFQ6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:58:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47085 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgDFQ6A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 12:58:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id q204so13644282oia.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=64E0UX+pnb2eqzSbVs7MK8J2+uE2vjRsPzZx6oBEpps=;
        b=JrRBRYJgM6h15ZrZaIS7vQ9Dygx1wCqoUBSDA7hED0jkMx6gG9yi6ROmqAWPDMWCn+
         lQyQRTRikNtkMOmbXoSVvOSwSqCHw7gdz0izb3jE/bNa4PBISI+HlR1H0vSjeMUPv8n5
         62e73GfrvOsDAnLR2vrEKlhunFYIjzEQPnMY1wULzl5bWXR8QTK7ET8QBn9O2/iystuh
         AGulLyxgFnGUuSGGwNi1TzuAlrmUMS8GUSU8WtD7QZLGFLx0QtMbxO9g/QsLmrsWVtCD
         +rRiEP46wNbXvE0sGYYYLQ8AIA7BIjHtvnAYu2QC0Wcus1dk3W1GboaTm4au/zvwxuWr
         EKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=64E0UX+pnb2eqzSbVs7MK8J2+uE2vjRsPzZx6oBEpps=;
        b=LvAf1nLYXCgyirarsiQ+8t/UUBJlnG+4rBQU9ElFdF7jB2sPmxWQSCPckSgdOnihjS
         UUTajoW0jkEHXTuhRvLEh3BZj7XCcVxLyoZX+4CqSQVP0AriKu5PAwNg4gfgiOAoWU05
         K+/KGViJ7sfV1g/VVOw/FSFxpvAaI72oMA55H7AOfiSwYKQOE++PDM1x18P4Sn+ullFU
         FYGgXiNLAAwXrdc3mOzntOTW9Wy4hLdDrFvKJBDgnJb2shrfVDrmObCbnU0ICSX0/MRj
         5C49zODx5oJDn0Wyam0xO88hvL0JzDa/WbX0zCZHe8c4T0IZUpw6z8evT7CTmOF0cfEw
         JGIg==
X-Gm-Message-State: AGi0Pua/c6SS08N8+szyPrRuRZBThcdtwK8Yvi98BSXcLE1xyxQtaAc7
        sEElapk1jeMUa+0o2Pyg1QsDAvxtUdTCRgKlFJI=
X-Google-Smtp-Source: APiQypKzv3p708TFprFeo7N1U+RkwnB949AxB6WjrE0YFGDJO+bGHA07OOdumexI0R/AerP1WUIxMOVXeusI1m/x61o=
X-Received: by 2002:aca:b602:: with SMTP id g2mr207255oif.82.1586192279722;
 Mon, 06 Apr 2020 09:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
 <1585899591-14623-2-git-send-email-thorsten.klein@bshg.com>
 <CABBYNZLOjT7bp=M+P1QDLh2pAB0rBwjnbG5zvfaVKh_ZqQkMkQ@mail.gmail.com> <93524ce444664fcebf6fcdc51ac0416f@bshg.com>
In-Reply-To: <93524ce444664fcebf6fcdc51ac0416f@bshg.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Apr 2020 09:57:48 -0700
Message-ID: <CABBYNZJzNX1pJQsM5BKRoTNvtJqUaPrC4CqGHwbHQLxKQrM3CQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] ManufacturerData field added to ScanResponse
To:     "Schachschal, Maximilian (GED-SDD2)" 
        <Maximilian.Schachschal@bshg.com>
Cc:     "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maximilian,

On Mon, Apr 6, 2020 at 2:58 AM Schachschal, Maximilian (GED-SDD2)
<Maximilian.Schachschal@bshg.com> wrote:
>
> Hi Luiz,
>
> > Don't really like to do this, beside it seems to be optional to enter e=
ither on AD or on SRD so the scanner is really at fault here if it only abl=
e to parse the data if placed on SRD, that said we could have some logic th=
at detects if manufacturer don't fit on the AD push it to SRD if that has m=
ore space if the advertisement is discoverable.
>
> I agree on that, that may be the best solution.
> We already thought about that. However it looked like some major changes =
in shared part would be necessary for that and we didn't want to change too=
 much here.
> So this was the easiest (although little dirty) solution for us to start =
with. We wanted to share it here and start discussion on that.
> What needs to be considered for changes to shared part?

Afaik we can just try to append to ad instance if that fails then
proceed to add to sd instance after checking if the instance is
discoverable, so this might not even need a change to bt_ad itself,
but perhaps bt_ad don't actually indicate if a proper error for no
space but we should be add a specific retur for that.

> BR
> Max
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Friday, April 3, 2020 11:42 PM
> To: Klein, Thorsten (BSH) <kleinkastel@googlemail.com>
> Cc: linux-bluetooth@vger.kernel.org; Schachschal, Maximilian (GED-SDD2) <=
Maximilian.Schachschal@bshg.com>
> Subject: Re: [PATCH BlueZ] ManufacturerData field added to ScanResponse
>
> Hi Thorsten,
>
> On Fri, Apr 3, 2020 at 12:42 AM Klein, Thorsten (BSH) <kleinkastel@google=
mail.com> wrote:
> >
> > From: "Schachschal, Maximilian (BSH)"
> > <maximilian.schachschal@bshg.com>
> >
> > Keys are the Manufacturer ID to associate with the data.
> > ---
> >  doc/advertising-api.txt |  6 ++++++
> >  src/advertising.c       | 25 +++++++++++++++++++------
> >  2 files changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt index
> > b0565ea..14ccae2 100644
> > --- a/doc/advertising-api.txt
> > +++ b/doc/advertising-api.txt
> > @@ -51,6 +51,12 @@ Properties   string Type
> >                         the Advertising Data.  Keys are the Manufacture=
r ID
> >                         to associate with the data.
> >
> > +               dict ManufacturerDataScanResponse [Experimental]
> > +
> > +                       Manufactuer Data fields to include in
> > +                       the Scan Response.  Keys are the Manufacturer I=
D
> > +                       to associate with the data.
> > +
>
> Don't really like to do this, beside it seems to be optional to enter eit=
her on AD or on SRD so the scanner is really at fault here if it only able =
to parse the data if placed on SRD, that said we could have some logic that=
 detects if manufacturer don't fit on the AD push it to SRD if that has mor=
e space if the advertisement is discoverable.
>
> >                 array{string} SolicitUUIDs
> >
> >                         Array of UUIDs to include in "Service Solicitat=
ion"
> > diff --git a/src/advertising.c b/src/advertising.c index
> > 45ff19f..0e1a3f1 100644
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > @@ -328,12 +328,12 @@ fail:
> >  }
> >
> >  static bool parse_manufacturer_data(DBusMessageIter *iter,
> > -                                       struct btd_adv_client *client)
> > +                                       struct btd_ad *ad)
> >  {
> >         DBusMessageIter entries;
> >
> >         if (!iter) {
> > -               bt_ad_clear_manufacturer_data(client->data);
> > +               bt_ad_clear_manufacturer_data(ad);
> >                 return true;
> >         }
> >
> > @@ -342,7 +342,7 @@ static bool
> > parse_manufacturer_data(DBusMessageIter *iter,
> >
> >         dbus_message_iter_recurse(iter, &entries);
> >
> > -       bt_ad_clear_manufacturer_data(client->data);
> > +       bt_ad_clear_manufacturer_data(ad);
> >
> >         while (dbus_message_iter_get_arg_type(&entries)
> >                                                 =3D=3D
> > DBUS_TYPE_DICT_ENTRY) { @@ -373,7 +373,7 @@ static bool
> > parse_manufacturer_data(DBusMessageIter *iter,
> >
> >                 DBG("Adding ManufacturerData for %04x", manuf_id);
> >
> > -               if (!bt_ad_add_manufacturer_data(client->data, manuf_id=
,
> > +               if (!bt_ad_add_manufacturer_data(ad, manuf_id,
> >                                                         manuf_data, len=
))
> >                         goto fail;
> >
> > @@ -383,10 +383,22 @@ static bool parse_manufacturer_data(DBusMessageIt=
er *iter,
> >         return true;
> >
> >  fail:
> > -       bt_ad_clear_manufacturer_data(client->data);
> > +       bt_ad_clear_manufacturer_data(ad);
> >         return false;
> >  }
> >
> > +static bool parse_manufacturer_data_adv(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_manufacturer_data(iter, client->data); }
> > +
> > +static bool parse_manufacturer_data_scan(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_manufacturer_data(iter, client->scan); }
> > +
> >  static bool parse_service_data(DBusMessageIter *iter,
> >                                         struct btd_adv_client *client)
> > { @@ -941,7 +953,8 @@ static struct adv_parser {
> >         { "Type", parse_type },
> >         { "ServiceUUIDs", parse_service_uuids },
> >         { "SolicitUUIDs", parse_solicit_uuids },
> > -       { "ManufacturerData", parse_manufacturer_data },
> > +       { "ManufacturerData", parse_manufacturer_data_adv },
> > +       { "ManufacturerDataScanResponse", parse_manufacturer_data_scan
> > + },
> >         { "ServiceData", parse_service_data },
> >         { "Includes", parse_includes },
> >         { "LocalName", parse_local_name },
> > --
> > 2.7.4
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
