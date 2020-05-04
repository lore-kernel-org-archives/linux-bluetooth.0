Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E451C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 00:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30376206E6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 00:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5oHIr6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgEDAzE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 May 2020 20:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726924AbgEDAzE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 May 2020 20:55:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD8FC061A0E
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2020 17:55:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j14so8268581lfg.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 May 2020 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4x/K6duRrjN/U+VYAUO8TvmRtrGqcEAA6zUTStm690=;
        b=Y5oHIr6Owb2ec6aZLCXJywDjB4MibUg3widgbcL2hrYY44FRlU7zlKvDzGw9t+JVjo
         0RdOHnOMmO6YfXAizXit9SYN7m7EvinkpXkolaNzz7l1GFXx2zynX7roi13CV+SnZ4rt
         QDwoV3yYnrv3ZOkQb9rRUWyf7BB99jz7WWbiDyOuDFoSDuYlcHrPt9cLGAwLZ/5ckgmy
         l3JxWRCVrmAqbLTHnib037//E/XbimnviVvnK9LvjdiJKJAOZHzoojFjyvzZR88pnQbE
         DsEt5ajTv+jtW0R9uMsnTv9dCVKhtski5NWmaO0uar/T+imdTS2dTjQwHI55DNy76Acx
         E6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4x/K6duRrjN/U+VYAUO8TvmRtrGqcEAA6zUTStm690=;
        b=raIcF5p+Ben3bPMIGaUzXG0FB9sMZ/GqGReb8XaOzcuw/NtaxHkQ/850MZfkPZppGs
         yCewDp+j0G1IH8jE3fufugqEJdfdVSkWq39dttPio4jCWbzZ0plc7B33IpS1hKwfem4e
         7NCOg+lqnHvlkO6IfctVSxEH/Wrku0d3nEConCYs37k2YD7i0wP2dbphAwgqE/Dm4eDP
         efGHktwHJPetTNsW5NJpCTaF4KICjZO4pzOZNXopfNcYO71UZbK8HenvjEBezG5Vtm0X
         0fdwiI0y4YHGQTAb3i762AQ3Y4w1vHkT4Y2T0sEvuDpAxkz/Zcze6n3tJNrrQzAG4yA0
         7KIg==
X-Gm-Message-State: AGi0PuZHreS+Tab1+iNbnrd5C4z2RlENtbMfNO1A8yADWha8BKLY3VFz
        uSgJZjNm2HZcK8dt4+WeVZvAZhSHjHoccgc8kVyv45FP
X-Google-Smtp-Source: APiQypL60pnWfx0zauok5h44fqaxqAOHXGmEqWBwKYPftGLAPn+HUdjpBqOIrA0Mppr/cdEjUvzluutljtqi6Ii97vM=
X-Received: by 2002:a19:6a18:: with SMTP id u24mr9989325lfu.191.1588553699665;
 Sun, 03 May 2020 17:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200501192218.73993-1-alainm@chromium.org> <CABBYNZ+5EykQDdsAagP27T1hazfg_+9qHhwt4M136dUZCwU1Kw@mail.gmail.com>
In-Reply-To: <CABBYNZ+5EykQDdsAagP27T1hazfg_+9qHhwt4M136dUZCwU1Kw@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Sun, 3 May 2020 20:54:48 -0400
Message-ID: <CALWDO_XoWJXw_7duPoFgG--96Ay_UsvHsZ57syMKUEuoWYgYsA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] shared/gatt-client:Ignore orphaned characteristics
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, May 1, 2020 at 4:46 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Fri, May 1, 2020 at 12:27 PM Alain Michaud <alainm@chromium.org> wrote:
> >
> > The gatt discovery proceedure simplification to discover all
> > characteristics at once has exposed a device side issue where some
> > device implementation reports orphaned characteristics.  While this
> > technically shouldn't be allowed, some instances of this were observed
> > (namely on some Android phones).
> >
> > The fix is to simply skip over orphaned characteristics and continue
> > with everything else that is valid.
> >
> > This has been tested as part of the Android CTS tests against an
> > affected platform and was confirmed to have worked around the issue.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> >  src/shared/gatt-client.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> > index 963ad619f..507b4d304 100644
> > --- a/src/shared/gatt-client.c
> > +++ b/src/shared/gatt-client.c
> > @@ -632,7 +632,13 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
> >                         util_debug(client->debug_callback, client->debug_data,
> >                                 "Failed to insert characteristic at 0x%04x",
> >                                 chrc_data->value_handle);
> > -                       goto failed;
> > +
> > +                       /* Some devices have been seen reporting orphaned
> > +                        * characteristics.  In order to favor interoperability
> > +                        * we skip over characteristics in error
> > +                        */
> > +                       free(chrc_data);
> > +                       continue;
> >                 }
> >
> >                 if (gatt_db_attribute_get_handle(attr) !=
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
>
> Applied, thanks. Note that I drop the Signed-off-by line since we
> don't use that on userspace.
Thanks, sorry, this is automatically added by the tools I use to
automate the patch upload and I need to remember to remove it.  Sadly,
it's a manual process and is vulnerable to my poor memory :P
>
> --
> Luiz Augusto von Dentz
