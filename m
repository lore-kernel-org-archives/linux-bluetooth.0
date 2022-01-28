Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6FAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 01:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbiA1Bpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiA1Bpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 20:45:39 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F01C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 17:45:39 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p5so13985829ybd.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 17:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+u8wqQf+JnCRbCKbY/yHaTc8fb1wco2u5ac9/L6SRVM=;
        b=i2iPMRIjBl7u2M6J4yu3gxS6pPkYgGXPVA+p9HZJQRr3ejMWF9obkj7/EY43IClQjD
         jAV55Wa/TR/wmFTo7XdqaKYTniScGrTcQVZgSYUvjrI/YUHmqAnn6qCqdulDJh/OWbXW
         1BNQcVAHD0Kyy3cQHBJ6kMuK0A7TweiEPtjT+GUMCxaNRZzdxVuLwkIzqZKf0tjOYgsF
         cfkx3eM+/TwNhfurK2IMvKdsxAr8XevhxB9PHKfF5mTcUZhl6JpyqbIniBn8LaGl/rhk
         lX3dWBJbsdP7o6dp9AalPVfbOELm1Ehxx0iSSfpu/ZTHNcXC6EqdlouKVaqfAa+fKIld
         kc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+u8wqQf+JnCRbCKbY/yHaTc8fb1wco2u5ac9/L6SRVM=;
        b=K7+agVDeG/GP7lRfGhU1tl90gs7l6GHA2JddIFsKI42eRmX+KKoN8OwRJVJXbOZMI4
         fs8j3LKpCFq9wlSexKvqsCwDE5+GwrRxuArnf6iRf1UBRtYx5w6BtV5N7SNohS/Cgt41
         43WEumPQxgT84uB33YjQ0ScxSFuJOdZKxXLHrizFhTTptjFbbOE8NgNKxpjFL5I47RUw
         mT0Fx6qq8BqR3cPoSHxX0Yu1NLaGZjY3YJ7E4g22tz9O46bNmUw322WiTgHC6mXUJlp2
         7whZzr72X6K/OQVYj/WhfRoDMhQj2zBSwMHRtOngVTlB6WywIP0z9OXBQ1724p53IQZw
         8HHw==
X-Gm-Message-State: AOAM532nr65TftUiveggRx37f3iyYj1pVPxWRtYEvDA22J1szFgH59XR
        XWihGdYGvzO0yAx0HO5dRv4ggLI4Smz/QbVWYVw=
X-Google-Smtp-Source: ABdhPJyKU5cy3AqDKmfkIc1Hb2Bu+bS1eLXV/skWbac2dp8eyvnsPIuuVMP2eYYHaYeyXXvQLiqCZx/AyT93VFuKc3Y=
X-Received: by 2002:a25:f30a:: with SMTP id c10mr1907176ybs.733.1643334338379;
 Thu, 27 Jan 2022 17:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20220127101609.3646316-1-josephsih@chromium.org> <F67144BA-E7CF-43B7-997C-576536BA5968@holtmann.org>
In-Reply-To: <F67144BA-E7CF-43B7-997C-576536BA5968@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jan 2022 17:45:27 -0800
Message-ID: <CABBYNZLLjHfGiM5W4S59B9bgLZaN3dgk-9WVBb_Fdm8F8jM9ZA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/4] doc: Add Bluetooth quality report event
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Joseph Hwang <josephsih@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Joseph Hwang <josephsih@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Joseph,

On Thu, Jan 27, 2022 at 12:02 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Joseph,
>
> > Add the Bluetooth quality report event in doc/mgmt-api.txt.
> >
> > Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> > ---
> >
> > Changes in v2:
> > - This is a new patch for adding the event in doc/mgmt-api.txt
> >
> > doc/mgmt-api.txt | 20 ++++++++++++++++++++
> > 1 file changed, 20 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index ebe56afa4..a0e71a732 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -4978,3 +4978,23 @@ Advertisement Monitor Device Lost Event
> >               2       LE Random
> >
> >       This event will be sent to all management sockets.
> > +
> > +
> > +Bluetooth Quality Report Event
> > +==============================
> > +
> > +     Event code:             0x0031
> > +     Controller Index:       <controller_id>
> > +     Event Parameters:       Quality_Spec (1 Octet)
> > +                             Report_Len (2 Octets)
> > +                             Report (0-65535 Octets)
> > +
> > +     This event carries the Bluetooth quality report sent by the
> > +     controller.
> > +
> > +     Possible values for the Quality_Spec parameter:
> > +             0       Not Available
> > +             1       Intel Telemetry Event
> > +             2       AOSP Bluetooth Quality Report Event
>
> can we swap this around please:
>
>                 0       AOSP Bluetooth Quality Report Event
>                 1       Intel Telemetry Event
>
> Regards
>
> Marcel

I wonder if we shouldn't have these as bit fields though, so one can
select multiple reports if available.


-- 
Luiz Augusto von Dentz
