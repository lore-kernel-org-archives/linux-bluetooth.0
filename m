Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E36C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiHVWyO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVWyK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:54:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED52B251
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:54:08 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so11983339ljq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=6IsETC87mxfK7/5VhKSNRp3ZonXwfy637BHG/csxGBI=;
        b=WxyUh0PLFfEOaZM8QVR/gZ7Q/65aTg3gn0+DbSDeNYTngNlUosbiFPrVgpV9QLSdQe
         1TZ4FvPpcyp9fx5r+DKt2cbEzfmpmrBeZ1G+x49xDy4C86jXUAjeL9Za2VXYJ70qfw80
         E20rzTMrm4A/SAd0zr40SKyobIj5j4pxj7TBZqtIXhtaEcc3T5OKpBeZIMC7x5hAJ/GR
         NZSAj1y97HHXfYaKawwUR5um7mAAIpFEfkqrQZiTXnmYrXPLu9dYVgOEgIdQZCZfdOR0
         nCKHIe79qJUSNl84S5WbZ0k7BNZb+xXhThiR6cjcLYBqCWFILNt7a3oUQFI+q4eqaFWO
         YvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=6IsETC87mxfK7/5VhKSNRp3ZonXwfy637BHG/csxGBI=;
        b=2wraDArgjeKb6u+63jo953E9mKWZjBvutyhRhI+h5q3vPlhVHid4gruHKSMZcpqsLO
         d+E5UZLtECkiwS14bxlLPIIBibA/KYn5zaLd7Qk4AX/yV8pPQjt6nOceTpVWfX382GUU
         zBoWe3EI+kVY6hC8Kgw8Upg1IDAvaZ2hLUPVOnDV4+EmaFhqtnT6upP34uGxO1qD7YY2
         Cu9GyfpEEeV2kKkcJtUvx69NcNfLPxcyaxlMFrBS0CdQe2fSs36f8sRO6qy7ODPzIGN6
         sk82aaJzF0CLNJjTsgOOenX8DIpsVsrOMfhcZZU9Js0kje1bKNfhlQrJ6tZeL4rTebPW
         DSEw==
X-Gm-Message-State: ACgBeo2YcYqtplTwWCmu8sMsh8X+YaSahh5R0hus+sB2qhQpY+2x4ux2
        EQ5xZnXwBWuioO/RATcUfg5SHv5SDXtGGatkqro=
X-Google-Smtp-Source: AA6agR6rVrYLsgiPXYvhyMhGdQbXoGffufuVVnzclPlzeu2QX+MugdPUMDPkOPzZdqfDTlFwNAIXT2mF+Dz4MrG1Ddw=
X-Received: by 2002:a2e:8497:0:b0:261:cbd8:2348 with SMTP id
 b23-20020a2e8497000000b00261cbd82348mr2258118ljh.423.1661208846817; Mon, 22
 Aug 2022 15:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
 <f9fd47a4-e5fc-5640-de71-dee1d52da2a8@molgen.mpg.de> <CAJQfnxHsRrJpQQB06bxhjc1TetK-8H20Cos366A6qH5AY9j9vw@mail.gmail.com>
In-Reply-To: <CAJQfnxHsRrJpQQB06bxhjc1TetK-8H20Cos366A6qH5AY9j9vw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Aug 2022 15:53:55 -0700
Message-ID: <CABBYNZKTBYnCkrvs1m+whDk4_Jt4=7tpqHG7hJSih3NJPm+idg@mail.gmail.com>
Subject: Re: [Bluez PATCH] adapter: Reset pending settings when receiving MGMT error
To:     Archie Pusaka <apusaka@google.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Aug 21, 2022 at 11:33 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Paul,
>
> On Mon, 22 Aug 2022 at 14:15, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > Dear Archie,
> >
> >
> > Thank you for the patch.
> >
> >
> > Am 22.08.22 um 06:53 schrieb Archie Pusaka:
> > > From: Archie Pusaka <apusaka@chromium.org>
> >
> > I think the tag in the email subject needs to be [PATCH BlueZ] to be
> > detected by the build bot.
>
> Is the bot the one who just commented about the test result? If so
> probably it can detect this format as well.
> >
> > > We set the pending settings flag when sending MGMT_SETTING_*
> > > commands to the MGMT layer and clear them when receiving success
> > > reply, but we don't clear them when receiving error reply. This
> > > might cause a setting to be stuck in pending state.
> >
> > Were you able to reproduce a problem on real hardware?
>
> I only received some reports, but unfortunately I cannot repro on real
> hardware. The symptom is BlueZ can't be turned off, snoop logs shows
> that MGMT_OP_SET_POWERED fails to be sent, and we are stuck with it
> since the next commands to toggle power are ignored.

Weird how can you tell MGMT_OP_SET_POWERED fails to be sent or you
meant it was sent but the kernel returned an error? It would be great
to include these errors.

> >
> > > Therefore, also clear the pending flag when receiving error.
> > > Furthermore, this patch also postpone setting the pending flag
> >
> > postpone*s*
>
> Thanks, will fix.
> >
> > > until we queue the MGMT command in order to avoid setting it too
> > > soon but we return early.
> >
> > Maybe add a comment, that how you tested this?
>
> The reporter claims the problem is no longer observable after this
> patch. I didn't do any other intelligent way of testing,
> unfortunately. Do I also need to document that?
> >
> > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > >
> > > ---
> > >
> > >   src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++--------
> > >   1 file changed, 37 insertions(+), 8 deletions(-)
> >
> > [=E2=80=A6]
> >
> >
> > Kind regards,
> >
> > Paul



--=20
Luiz Augusto von Dentz
