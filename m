Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D73C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 14:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778EF2073A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 14:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahYIBIUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEFOGk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728058AbgEFOGj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 10:06:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B016C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 07:06:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 188so1439609lfa.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QR19pNnGIKW8mtYSXSWifapXpV8chhnF0OgI5ZJfq5I=;
        b=ahYIBIUUkWRaa/HzxnTkpy0jhWC3ngzXqZxY3lLWHyg9pcPR39F5E+y4I3TNyxXDpX
         KjTOV0Qz1fojahH40/Os2dBH6dQ4XOivGFx74LKjsxx4h0f+6V6Fqy7bhjw7aWgm962e
         /vzFmB+qwDgPHISXD1mFUd08OSCoMNx9/e6Ijt5kxek3tDO8lnN3KlX+2NYMCha8OtXZ
         K53IxnFaucSNihwICK6aS/jmysPW938OlASKykeh/b4oZv+oUihZnYyzwta+4kqgkq6F
         yle7cw3AkG7YZTJPY12Gnm3D4nzy+Kc8d2joiuv4gLbtv1iCkGEbhTWK4Agq8j3Ld3qR
         YFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QR19pNnGIKW8mtYSXSWifapXpV8chhnF0OgI5ZJfq5I=;
        b=k63NY1EFhSxGJV5CvlJ/3aDa72Dz6M2Vh6op4y3aPJ0WRyum/8eAW3qUR4/lMlqJXW
         /g2maeaaL6Qsg2q7S3zNLURmfV1L5KVwWwIndGZjzEoFg9cDf7n5GkO5RpcDa1KF18L8
         nGe+UGylmQMez97vmdnywT8kdI4PH16VW8BLv1PDg1F6Al9rSsbQ1BqgfjjnsSRe0ksT
         ol/YPBa3TngvI0QkIWTXVOYmSvPlJgZJVkboGGwIjxN8lYJ1liqwNW88Q81NwH7qPM3e
         5J3fiLGpkz8mOFZikgKfy9dCkgp9APlNnJpApNSIZBgCyFUZquvtQfy2f7Ewxa6NhJui
         sVEQ==
X-Gm-Message-State: AGi0PubXNT21T309atuB6Vf7H2Bpw0Zvp+JQ41sOMpxUfzGViknBOQKH
        zsjBa6ObXWicaIEn84IiCIrM4UKnnY64EdVHdU0Z0Q==
X-Google-Smtp-Source: APiQypKNXj6p64aUJjmMVUsOBp3zaZEiyRm55sFzsym5iG59kl54qXjx1YdH81k9zouefRHCW670PLFkciAorDx9j6o=
X-Received: by 2002:a19:c394:: with SMTP id t142mr5415479lff.129.1588773997751;
 Wed, 06 May 2020 07:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200504142625.213143-1-alainm@chromium.org> <7610937E-424D-4968-B8D9-378E44773088@holtmann.org>
In-Reply-To: <7610937E-424D-4968-B8D9-378E44773088@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 6 May 2020 10:06:24 -0400
Message-ID: <CALWDO_UPC5UnbEigTBz0Go-mtyXqCm8GNTyew+M4Eu-P2s-Dyw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc:adding definitions for load default params
 mgmt op
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, May 6, 2020 at 7:22 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change adds the definition for the load default parameter command.
> > In particular, this command is used to load default parameters for
> > various operations in the kernel. This mechanism is also expandable to
> > future knobs that may be necessary.
> >
> > This will allow bluetoothd to load parameters from a conf file that may
> > be customized for the specific requirements of each platforms.
> >
> > ---
> >
> > doc/mgmt-api.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 59 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 39f23c456..71d528706 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3137,6 +3137,65 @@ Read Security Information Command
> >       Possible errors:        Invalid Parameters
> >                               Invalid Index
> >
> > +Load Default Parameter Command
> > +=============================
>
> I think that Load Controller Default Parameters is a better name.
I wanted to avoid using "controller" in the name as some of these are
not really "controller" parameters but instead just general
parameters.

>
> > +
> > +     Command Code:           0x0049
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Parameter_Count (2 Octets)
> > +                             Parameter1 {
> > +                                     Parameter_Type (2 Octet)
> > +                                     Value_Length (1 Octet)
> > +                                     Value (0-255 Octets)
> > +                             }
> > +                             Parameter2 { }
> > +                             ...
> > +     Return Parameters:
> > +
> > +     This command is used to feed the kernel a list of default parameters.
> > +
> > +     Currently defined Parameter_Type values are:
> > +
> > +                     0x0000  BR/EDR Page Scan Type
> > +                     0x0001  BR/EDR Page Scan Interval
> > +                     0x0002  BR/EDR Page Scan Window
> > +                     0x0003  BR/EDR Inquiry Scan Type
> > +                     0x0004  BR/EDR Inquiry Scan Interval
> > +                     0x0005  BR/EDR Inquiry Scan Window
> > +                     0x0006  BR/EDR Link Supervision Timeout
> > +                     0x0007  BR/EDR Page Timeout
> > +                     0x0008  BR/EDR Min Sniff Interval
> > +                     0x0009  BR/EDR Max Sniff Interval
> > +                     0x0080  LE Advertisement Min Interval
> > +                     0x0081  LE Advertisement Max Interval
> > +                     0x0082  LE Multi Advertisement Rotation Interval
> > +                     0x0083  LE Scanning Interval for auto connect
> > +                     0x0084  LE Scanning Window for auto connect
> > +                     0x0085  LE Scanning Interval for HID only
> > +                     0x0086  LE Scanning Window for HID only
> > +                     0x0087  LE Scanning Interval for wake scenarios
> > +                     0x0088  LE Scanning Window for wake scenarios
> > +                     0x0089  LE Scanning Interval for discovery
> > +                     0x008a  LE Scanning Window for discovery
> > +                     0x008b  LE Scanning Interval for adv monitoring
> > +                     0x008c  LE Scanning Window for adv monitoring
> > +                     0x008d  LE Scanning Interval for connect
> > +                     0x008e  LE Scanning Window for connect
> > +                     0x008f  LE Min Connection Interval
> > +                     0x0090  LE Max Connection Interval
> > +                     0x0091  LE Connection Connection Latency
> > +                     0x0092  LE Connection Supervision Timeout
>
> I would just enumerate these and not try to split between 0x000 and 0x008 for BR/EDR and LE. Also I would just start with a few values that we currently want to change.
The goal was to try to keep BR and LE parameters together, but if you
prefer, I don't mind collapsing them.  Note that we intend to use all
of these, so I'd prefer not break this into a smaller subset.

>
> > +
> > +     This command can be used any time, but will not take effect until the
> > +     next activity requiring the parameters.  In the case the parameters are
> > +     used during initialization of the adapter, it is expected that the
> > +     parameters be set before the adapter is powered.
>
> Hmmm. This one, I might want to limit this controllers powered down. Otherwise you get into the conflict case that we would expect parameters taking affect and I think that is just too complicated.
Things like connection intervals and scan defaults actually apply the
next time the activity is started.  We need to be able to change these
without completely powering down the controller and tearing down all
connections etc.  Things that are obviously only used during
initialization, then I would expect they would require a power cycles.

>
> > +
> > +     This command generates a Command Complete event on success or
> > +     a Command Status event on failure.
> > +
> > +     Possible errors:        Invalid Parameters
> > +                             Invalid Index
> >
>
> Regards
>
> Marcel
>
