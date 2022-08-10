Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4783EC3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 22:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiHJWPC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiHJWPA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 18:15:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A963832DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 15:14:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gk3so30223598ejb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cGpW4EhXIatXeLfl5fsgVMh5RNSm7d4sTNUGMrfZ+vw=;
        b=DHG6EWBNZN1N4Azrdu3oSTv8xz1dw+93gD3YrRpalyNSIauFV7L+e26KjT8Omb99/C
         An0ZlPhXfD3SNA0b88HCIxHzhQ6RN8guzrGvlAT1J40psgnaXANv9fBC/7xk4FZffbPM
         EAbWulMaKzE7wOTUWMVBZpENvUBOQuqwzXiIjA3NmgROkjnK71GLcHj57YDSOD5hDK7p
         oPmDXx0UfZvYE53PT9d8gDOfCSaOZZfL2UDdhx1D0d8+zt0LroI37CRgJxsQHmdGAwg7
         Wf5suBo4iQZfaaFQ1mcvp96MS+zMyW1q6b2FgA3fdY8zsu5P0lP6UnjhWji7gL7EoZka
         nNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cGpW4EhXIatXeLfl5fsgVMh5RNSm7d4sTNUGMrfZ+vw=;
        b=JuK/xy3puqfALSYhACWRqwQbycdOTdJtZbsb7UX8gmrOFYs+YCf6nsM83ONjubEQ8z
         9uxF68SDQswRbRJZIx8Ue4JN0G6YDFfJvng0T1RCjBjFMEN/wxNydplgaMSWriSw5b+S
         hpuApL1mqKQco6SRMxSf1NLyM12pioY5BnA2jwe3/hpvIxgjD+TVaLzAMYW03P6v/mKp
         8mY2/zM38qn29HEoipiehuX9nT3glJSajkuXd5+a29J812QjqphUq+yyVthKH40Cxxi/
         KQMfIw2QrsXpzLztUr7gMuE0HLwfmrAyouBwQgC6kPJ9t40sd/JKG4GWakZLUyBZBOAg
         2xoQ==
X-Gm-Message-State: ACgBeo00Z7F0Y88lAmdv3h/dZ9OKJndbVHQrcXTUJkDZrgH8JPXaLJW+
        XsfzQK1QS/N9Gk1WZW7QnXqS6C3eSUe6peMnK4Q=
X-Google-Smtp-Source: AA6agR561gQenaL1k/PqxiAHi1/ZSgkzVLn3gThpeBb12Dq5xY0OwWWHyItKUvIzbz2KPdnJ6Os1IpipTsWSH1tzzL0=
X-Received: by 2002:a17:907:a40d:b0:733:17c1:a246 with SMTP id
 sg13-20020a170907a40d00b0073317c1a246mr2697676ejc.132.1660169697557; Wed, 10
 Aug 2022 15:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <2277279.ElGaqSPkdT@n95hx1g2>
In-Reply-To: <2277279.ElGaqSPkdT@n95hx1g2>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Aug 2022 15:14:46 -0700
Message-ID: <CABBYNZL+vR125oKiAJtdW8wKJKt5ACmKtBZwXv4b1ZF_QiBOhA@mail.gmail.com>
Subject: Re: [newbie] How does automatic reconnection work
To:     Christian Eggers <ceggers@arri.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

On Wed, Aug 10, 2022 at 3:09 AM Christian Eggers <ceggers@arri.de> wrote:
>
> Many Bluetooth devices seem to have some kind of "reconnect behavior". For instance
> an audio speaker reconnects automatically to a phone as soon as they are within an
> appropriate distance.
>
> On the web, there are also many instructions how to troubleshoot problems related to
> "automatic reconnect" ([1], [2], [3]).
>
> How is this feature actually implemented? What do I have to consider if I want to
> automatically reconnect my product with the customers phone?
>
> In my concrete case, I create a BNEP connection from my product to the customers phone
> (which acts as a NAP, Bluetooth Tethering has to be enabled on the phone). I would like
> to automatically reestablish the network connection as soon as the phone is within an
> appropriate range.

Auto connection is controllable via main.conf:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n263

That said that is not enabled for BNEP profiles by default, it is kind
weird thing actually given that phones in general don't have Bluetooth
tethering enabled all the time, in fact I believe the normal behavior
is to disable tethering when disconnected, so even if you managed to
reconnect it may not be tethering.




> regards
> Christian
>
>
> [1] https://techwiser.com/fix-bluetooth-device-doesnt-auto-connect-in-linux/
> [2] https://unix.stackexchange.com/questions/334386/how-to-set-up-automatic-connection-of-bluetooth-headset
> [3] https://stackoverflow.com/questions/32288670/bluez-auto-reconnect-devices
>
>
>


--
Luiz Augusto von Dentz
