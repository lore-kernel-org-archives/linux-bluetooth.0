Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D247C31681
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DED020879
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 18:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebpM6+Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfAUSZy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:25:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37800 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfAUSZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 13:25:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id s13so21370193otq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvRB2pw7t3XQlA+UbW6+m+LQpIORv0gJo9HQeaYxE0c=;
        b=ebpM6+GzpNjDeDZ+kKkPPxYQ//Kfgte4i6kwZg58uCb0azieqRhmWJBTO3mJBC6WK6
         Xr8h+AblhwuAzLHyQqDA2Spb1BuwV5asFh2Fx20WLL+5RRQxapmSCd0OGFfMj0/JWqJ/
         KYqhw5zaDVk7BPZs8uKao5fQSIwTW893hgs+ybPMIEkEGYKnfp80WTECbi+Svm/XaTDr
         q2GGfqRnCYL+Ry4BQYI1tZ/jX6dIZ136lw3bIkzI7PCd9bWBKPc27DCQDiNZF9H1bSG6
         LztNOo7Y26rSe0KBaqWOyPkZuUiOitKTv2r0wQ9IkzdVIPq75oLUM1qIP09a5XKz4GmD
         l7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvRB2pw7t3XQlA+UbW6+m+LQpIORv0gJo9HQeaYxE0c=;
        b=WUXSXrfZwsWewSKgOPdLfOGnOs+o4LF5ysvyQzE7DGgHWlf+62rQft+ZMHG4+5OzZF
         72aJ5VRY7WixFy54ax/OHhXHo3/MSXBbx5xhKagDHngZdy3TjMWbfmPzi+PZ8+mfNEWI
         psmEqLOGdN81bVa9ZA+43WYfsNkH/ns+5sJ0GyHUYl1W4rnLQ8b3LO7nbMaI6Xltg9VS
         zQTl1F0w6S8jEAsp5sLPw+yXOlsWhYynaEKK4VASflkyRmXYRIIXt/pcx5G7YkYoaF/N
         SbVSbn/20g6jPq5uwZbaFUIMJ94+2jmCnWEGTOEFrEgGeO89OhBrd97j+U29g6mpUBIc
         CRsQ==
X-Gm-Message-State: AJcUukdxZFl3oNIfJmURrkeB00yqUfFHRBd4n2FHQi9Gy0lb3FPIKqmK
        RuJi+uOj+yz8tJZTsiWer42AMAnDfK3PZnLBKUJPvA==
X-Google-Smtp-Source: ALg8bN7YcmNeCeq8yq3hScllzWfSyPQTRMXufePzrfNSpJB7zNC/LMlUvGmrtS+EV1+O+0IAzp36ERNzcvNEUp5MYSI=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr11525204otf.52.1548095152755;
 Mon, 21 Jan 2019 10:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20190115141023.353-1-luiz.dentz@gmail.com>
In-Reply-To: <20190115141023.353-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Jan 2019 20:25:41 +0200
Message-ID: <CABBYNZLL7Usr=bS2rcJCCV6STVwi9ywq3Om6jkF8cfB8GC6mcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Tue, Jan 15, 2019 at 4:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds the possibility to expose remote SEP using MediaEndpoint
> interface to allow setting a configuration.
> ---
>  doc/media-api.txt | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index b5ad2db12..af9485342 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -500,14 +500,23 @@ Properties        object Player [readonly]
>  MediaEndpoint1 hierarchy
>  ========================
>
> -Service                unique name
> +Service                unique name (Server role)
> +               org.bluez (Client role)
>  Interface      org.bluez.MediaEndpoint1
> -Object path    freely definable
> +Object path    freely definable (Server role)
> +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/sepX
> +               (Client role)
>
>  Methods                void SetConfiguration(object transport, dict properties)
>
>                         Set configuration for the transport.
>
> +                       For client role transport must be set with a server
> +                       endpoint oject which will be configured and the
> +                       properties must contain the following properties:
> +
> +                               array{byte} Capabilities
> +
>                 array{byte} SelectConfiguration(array{byte} capabilities)
>
>                         Select preferable configuration from the supported
> @@ -532,6 +541,20 @@ Methods            void SetConfiguration(object transport, dict properties)
>                         endpoint, because when this method gets called it has
>                         already been unregistered.
>
> +Properties     string UUID [readonly, optional]:
> +
> +                       UUID of the profile which the endpoint is for.
> +
> +               byte Codec [readonly, optional]:
> +
> +                       Assigned number of codec that the endpoint implements.
> +                       The values should match the profile specification which
> +                       is indicated by the UUID.
> +
> +               array{byte} Capabilities [readonly, optional]:
> +
> +                       Capabilities blob, it is used as it is so the size and
> +                       byte order must match.
>
>  MediaTransport1 hierarchy
>  =========================
> --
> 2.17.2

Are there any comments for this set? Notice that I did include the
device path in this set so there is no need to hack to guess what
device the endpoint belongs to.


-- 
Luiz Augusto von Dentz
