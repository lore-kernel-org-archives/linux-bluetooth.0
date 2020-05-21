Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C89FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14EA020748
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfOk5XqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEUQXT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgEUQXS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 12:23:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7EC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 09:23:17 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 69so5963526otv.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wX3BGtuWgRKIwl8LY0OgnL46scpk643X5ArzO3KuMSA=;
        b=NfOk5XqK3UfoGg0qMMv2O7Sm3UyE1TS5kORwXz3GMsa+z+mbyHVviTX2PU0JLoe3LV
         EkCsW/ivdwSf6EuTJpfmdV810hxIlnZia4ffowfzig9N8b+9OTVPLTevIyaOMDhJuzBO
         i3+2nLRwNMfd+cUotibI3AufUN4/lOifDtbaatLXtojfIcmHsPUUnVqMZMfSNfLnSiQL
         aq5c+p4nqssUXXsYbS56uHPty+oowWJPuw5BjDd4v0fwPxNoNlklMbX9BsxUvwr4XEWJ
         0yDn6XhKJE0PBuvvkbj7yDIUNPgZsEYSTXxV3V3MPsGkM8HaRv0GeBh2mX4N+fsGr2mw
         +u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wX3BGtuWgRKIwl8LY0OgnL46scpk643X5ArzO3KuMSA=;
        b=aVFM6IjQFBMuZmSuEc8Qpas7+i1CyKwACfZz+vO6PM/9+sGvq0NKNzp1SEKvdqmOuF
         LlRMcVBxsC8sjHz+f3Rt+iAzFP1Vb6nzkCj8S0iU9SIMoeK6AHWQMlP9LNu4JMWQeZyD
         6Xbs9bAaXTjrk/dw1obZqfbVqn0Ig9ADyUkVT+8eZSfm0Q4vZixchVi2FYBqOdTb5LIT
         9hFJ5tOVgHN7F+eCQpTO52ILYawKRPBXchznLQqqVj6l+nw/Ry1oKJoCWKMS0fAJNLmH
         +QsE2oTB2a6bray8D6xcUc+9pl+mdmeAZyFg/42eJWRwSQ0DFuP7uhvj/Lmxhxu1o0yT
         SNQg==
X-Gm-Message-State: AOAM533LZl7hbXLCuEx5rRGQ9woDu0Iu1iXXqFQsqdcGyFTgSBglde8w
        zFMw8/i9pCIvJNJV4CEmxgiCxmD/5nb+Jks8pzk=
X-Google-Smtp-Source: ABdhPJw/Ug0GNmRkeaYpAR2CwrhZLH2OiQqOn6fAESqmwV7/6paWZyh7/klOSO62VFjAx4MqfP/fC5GV1XAbL1v6y5E=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr7918437ots.11.1590078196888;
 Thu, 21 May 2020 09:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200520204444.28994-1-post@0x21.biz>
In-Reply-To: <20200520204444.28994-1-post@0x21.biz>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 May 2020 09:23:04 -0700
Message-ID: <CABBYNZK4Uxgj+=TvTHjuoG9YDNn6ud739E7Dub0WWemq-vfGTA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] test/example-advertisement: Fix include_tx_power
To:     Alvar Penning <post@0x21.biz>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alvar,

On Wed, May 20, 2020 at 1:54 PM Alvar Penning <post@0x21.biz> wrote:
>
> Adding the Tx Power Level is no longer done via IncludeTxPower, but via
> the tx-power value in the Includes array. The previous code did not
> throw an error, but neither led to the insertion of the value. As a
> result of this change, include_tx_power now adds the Tx Power Level
> again.
> ---
>  test/example-advertisement | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test/example-advertisement b/test/example-advertisement
> index f116893b6..96e410683 100755
> --- a/test/example-advertisement
> +++ b/test/example-advertisement
> @@ -57,7 +57,7 @@ class Advertisement(dbus.service.Object):
>          self.solicit_uuids = None
>          self.service_data = None
>          self.local_name = None
> -        self.include_tx_power = None
> +        self.include_tx_power = False
>          self.data = None
>          dbus.service.Object.__init__(self, bus, self.path)
>
> @@ -78,8 +78,8 @@ class Advertisement(dbus.service.Object):
>                                                          signature='sv')
>          if self.local_name is not None:
>              properties['LocalName'] = dbus.String(self.local_name)
> -        if self.include_tx_power is not None:
> -            properties['IncludeTxPower'] = dbus.Boolean(self.include_tx_power)
> +        if self.include_tx_power:
> +            properties['Includes'] = dbus.Array(["tx-power"], signature='s')
>
>          if self.data is not None:
>              properties['Data'] = dbus.Dictionary(
> --
> 2.25.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
