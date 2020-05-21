Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C18C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53D920759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 16:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1RecP1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgEUQ0Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQ0Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 12:26:24 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3AC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 09:26:24 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 23so5478036oiq.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDsdKKMHXkycKmGzZMViNb09+pseXzzj8QtscCnutNM=;
        b=k1RecP1GHeQERVYVG+z3kiXFFbsHK2ideutQk8x/6jkDVNpVopwHiB2Nm1Pnjhjo3u
         k0yuLZfs4N7IWm4LdYQ8kldkp/Pn75JrDbpqzzoCACX++o/m3S2/XRC/Rv99ACkwR4PA
         A6mPKKQGyldf4a2xVz8jl6bCLNUVlLrX/w/6AalyfVrCzekAgEnFmdcRc6ai9Y6q/ULz
         yOcYvE1PwypNYmFP6jRcNPxWVc2Yhb3T5nyuePPaTjN/+ndGYBPYWhTXy2LfZ0krZ7oA
         8El/Rizg7t6H1KJfrJf3uBE9L7xiMmOJuUKE3GZDg/TbNkTI450/uvTpBLDOcTsW07q9
         uCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDsdKKMHXkycKmGzZMViNb09+pseXzzj8QtscCnutNM=;
        b=YkzNDkg8v1fyVFcFCBJ1kKoPlIk+nURFPGI1ujYkI+Ii4RkzzLp9ld9W5EMqGy0BaY
         IdyQ0TjJ4O3V52r+mVYR/NmHErZBVRamzRaUFXHhWU101/NIqtx3c4W5dnS/vvQd2TCV
         Cqtfhd3aUBes+jl4yB5eYBLUXMnGzinbtAgAvjDKLsxIbtJbHgK4KYOYohyu6LIIIcIv
         Y00z9i4uAZ7NLU2bmZrYG3tOxGlpUeRW/QQ5zE1LV0mVve1xKnXLBMn8EUO9PQ7pvyYR
         ELGvHMRmZPk+V4ehG2K/nXVG4QslGbVLQkX7N2YRtGfMtvU2r4tVyAKb5EnR3lW9PWhu
         rKLg==
X-Gm-Message-State: AOAM5320CocfjU3DtXSMVcgY3Vfa8dfOczbsr2v91bHhWBB6LEaH7CRE
        dBVuc/rC8GQXVRiaoNpz6EqLoMKRBu31HfmwUYw=
X-Google-Smtp-Source: ABdhPJzEBVsZG5858I+seQY5b22ADFiLfhRxg0jM0f8hoDgpfcx4p+GDo6RSY4ai0zxSfvxmxavm4hAPDLCbx3qUqEI=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr7416640oif.108.1590078383505;
 Thu, 21 May 2020 09:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200521145757.245774-1-alainm@chromium.org>
In-Reply-To: <20200521145757.245774-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 May 2020 09:26:07 -0700
Message-ID: <CABBYNZKU4JVHxL5NEaMFgf6-aAOrG4re=T0Yat9b=viz57PcsQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:adding definitions for load default params
 mgmt op
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, May 21, 2020 at 8:05 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change adds the definition for the load default parameter command.
> In particular, this command is used to load default parameters for
> various operations in the kernel. This mechanism is also expandable to
> future values that may be necessary.
>
> This will allow bluetoothd to load parameters from a conf file that may
> be customized for the specific requirements of each platforms.
>
> ---
> rebase against current master
>
>  doc/mgmt-api.txt | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 6ee01fed8..c6575e654 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3223,6 +3223,68 @@ Set Experimental Feature Command
>                                 Invalid Index
>
>
> +Load Default Controller Parameter Command
> +=============================
> +
> +       Command Code:           0x004b
> +       Controller Index:       <controller id>
> +       Command Parameters:     Parameter_Count (2 Octets)
> +                               Parameter1 {
> +                                       Parameter_Type (2 Octet)
> +                                       Value_Length (1 Octet)
> +                                       Value (0-255 Octets)
> +                               }
> +                               Parameter2 { }
> +                               ...
> +       Return Parameters:
> +
> +       This command is used to feed the kernel a list of default controller
> +       parameters.
> +
> +       Currently defined Parameter_Type values are:
> +
> +               0x0000  BR/EDR Page Scan Type
> +               0x0001  BR/EDR Page Scan Interval
> +               0x0002  BR/EDR Page Scan Window
> +               0x0003  BR/EDR Inquiry Scan Type
> +               0x0004  BR/EDR Inquiry Scan Interval
> +               0x0005  BR/EDR Inquiry Scan Window
> +               0x0006  BR/EDR Link Supervision Timeout
> +               0x0007  BR/EDR Page Timeout
> +               0x0008  BR/EDR Min Sniff Interval
> +               0x0009  BR/EDR Max Sniff Interval
> +               0x000a  LE Advertisement Min Interval
> +               0x000b  LE Advertisement Max Interval
> +               0x000c  LE Multi Advertisement Rotation Interval
> +               0x000d  LE Scanning Interval for auto connect
> +               0x000e  LE Scanning Window for auto connect
> +               0x000f  LE Scanning Interval for HID only
> +               0x0010  LE Scanning Window for HID only

I remember commenting that we don't have profile information on the
kernel so Im not sure how you are planning to detect the when the
device is HID or not?

> +               0x0012  LE Scanning Interval for wake scenarios
> +               0x0013  LE Scanning Window for wake scenarios
> +               0x0014  LE Scanning Interval for discovery
> +               0x0015  LE Scanning Window for discovery
> +               0x0016  LE Scanning Interval for adv monitoring
> +               0x0017  LE Scanning Window for adv monitoring
> +               0x0018  LE Scanning Interval for connect
> +               0x0019  LE Scanning Window for connect
> +               0x001a  LE Min Connection Interval
> +               0x001b  LE Max Connection Interval
> +               0x001c  LE Connection Connection Latency
> +               0x001d  LE Connection Supervision Timeout
> +
> +       This command can be used when the controller is not powered and
> +       all settings will be programmed once powered.  Note that these only
> +       control the default parameters.  Higher level Apis may influence the
> +       effective value used.
> +
> +       This command generates a Command Complete event on success or
> +       a Command Status event on failure.
> +
> +       Possible errors:        Invalid Parameters
> +                               Invalid Index
> +
> +
>  Command Complete Event
>  ======================
>
> --
> 2.26.2.761.g0e0b3e54be-goog
>


-- 
Luiz Augusto von Dentz
