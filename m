Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3639AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4DD22513
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 19:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbhAYThh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbhAYTh0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 14:37:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63733C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:36:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f1so16889040edr.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+Mm021t8XQ28YMnyF7U7y5xgXhoPAsbNMG0IjzYd/A=;
        b=m5e/w9fNDS5Rg17lW6rcLk1uvHmTjrT2NO4ZT/tfxQBCOBZbyCPrh1L5WJ8wKjkaKx
         b3X1IzCWBHglSsNaozXCFXWKT2WPU9Kr+EJNBRESp30q3yAl41YVvP5F1noax0C2GY7M
         86lB84BQ4fatmxGIjbcAhJTJbIDCccYvniyXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+Mm021t8XQ28YMnyF7U7y5xgXhoPAsbNMG0IjzYd/A=;
        b=PZwCwMkqk7A0q5x2Ogst3tKam/a19Gvs7n5CB48oJA/2l6oWnb+LdZKGX6098nzCo3
         LgawUqNaiD+pG8D1BDKct4Ldq3NYlI+vWSmyAkpgLt1Ol2sr3v8ZDFPXdtQAM4S5GAmT
         v1stvree00Xq5l8nr/+r0yecDyx4fsFptMSgM/8DYCxReLKbPkPPMmSWZgPx9BsfE439
         ENOL5Jk3GDDv63R3hW+8vWfGXkENEWb3Jvr5+vP0bFiM3kn29wP5VEMp243tF5NFE35I
         qxOVOVWWfSe/JO6KkUu5BzUqNnyTTnIrQEMc0Bpg6vM+VbEJt79sPpW/jLb/gZNrTLOS
         Xi+A==
X-Gm-Message-State: AOAM533eNeM1zxYbnwBmKsDu3iiygSPibtNplDnF5ZXJtoAyhs/4a6ya
        IcbUNtUi3uka0NE9S+KxlMZoyxzwugHalw==
X-Google-Smtp-Source: ABdhPJxhwGn25pPCvtzxsi8p6n6IzxGIj4KJLEHKRikDCYMjDRRt1hb3cZE+t+rA/5n+oCdImSlUUA==
X-Received: by 2002:a05:6402:757:: with SMTP id p23mr1826890edy.245.1611603405042;
        Mon, 25 Jan 2021 11:36:45 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id h12sm10637168edb.16.2021.01.25.11.36.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:36:44 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id p15so7522429wrq.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:36:44 -0800 (PST)
X-Received: by 2002:adf:a2ca:: with SMTP id t10mr2619745wra.370.1611603404084;
 Mon, 25 Jan 2021 11:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20210110003033.2528-1-sonnysasaka@chromium.org> <CABBYNZJBo2oM=U-FA8sw31aMzVqr-k4Qq=mhC0LX-AWB6xW=0g@mail.gmail.com>
In-Reply-To: <CABBYNZJBo2oM=U-FA8sw31aMzVqr-k4Qq=mhC0LX-AWB6xW=0g@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 25 Jan 2021 11:36:31 -0800
X-Gmail-Original-Message-ID: <CAO271mkbktDGgZeO5Z4X33F_5yjg0w5WS3Uw6Xbpqdcs_zP8zA@mail.gmail.com>
Message-ID: <CAO271mkbktDGgZeO5Z4X33F_5yjg0w5WS3Uw6Xbpqdcs_zP8zA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input/hog: Fix double registering report value callbacks
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I have revised the patch to using the notifyid to detect double
registration. Please take a another look. Thanks!

On Mon, Jan 11, 2021 at 9:47 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Sat, Jan 9, 2021 at 4:34 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > In commit 23b69ab3e484 ("input/hog: Cache the HID report map"), we
> > optimized HOG reconnection by registering report value callbacks early,
> > but there was a bug where we also re-register the same report value
> > callbacks after at CCC write callback. We should handle this case by
> > avoiding the second callback register if we know we have done it
> > earlier.
> >
> > ---
> >  profiles/input/hog-lib.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > index 1f132aa4c..089f42826 100644
> > --- a/profiles/input/hog-lib.c
> > +++ b/profiles/input/hog-lib.c
> > @@ -80,6 +80,7 @@ struct bt_hog {
> >         struct bt_uhid          *uhid;
> >         int                     uhid_fd;
> >         bool                    uhid_created;
> > +       bool                    report_value_cb_registered;
> >         gboolean                has_report_id;
> >         uint16_t                bcdhid;
> >         uint8_t                 bcountrycode;
> > @@ -336,6 +337,13 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
> >                 return;
> >         }
> >
> > +       /* If we already had the report map cache, we must have registered UHID
> > +        * and the report value callbacks. In that case, don't re-register the
> > +        * report value callbacks here.
> > +        */
> > +       if (hog->report_value_cb_registered)
> > +               return;
> > +
>
> Can't we check the report->notifyid instead of introducing yet another
> flag that seems to have the same intent of tracking if the report has
> been subscribed? In fact it seem there is something odd related to how
> we handle the CCC here, we do read it on ccc_read_cb but we don't
> check if its value is already set. Pehaps something like the following
> would be more complete solution, though we should really look into
> convert hog-lib to use bt_gatt_client instead of keep using GAttrib:
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 1f132aa4c..34a4d7c3b 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -360,15 +360,30 @@ static void ccc_read_cb(guint8 status, const
> guint8 *pdu, guint16 len,
>  {
>         struct gatt_request *req = user_data;
>         struct report *report = req->user_data;
> +       uint16_t value;
>
>         destroy_gatt_req(req);
>
> -       if (status != 0) {
> +       if (status || !len) {
>                 error("Error reading CCC value: %s", att_ecode2str(status));
>                 return;
>         }
>
> -       write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
> +       if (len == 1)
> +               value = *pdu;
> +       else
> +               value = get_le16(pdu);
> +
> +       if (!value) {
> +               write_ccc(report->hog, report->hog->attrib, report->ccc_handle,
> +                         report);
> +               return;
> +       }
> +
> +       report->notifyid = g_attrib_register(report->hog->attrib,
> +                                       ATT_OP_HANDLE_NOTIFY,
> +                                       report->value_handle,
> +                                       report_value_cb, report, NULL);
>  }
