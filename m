Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD97C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 20:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhLUU5p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 15:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhLUU5o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 15:57:44 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBCEC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:57:44 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f9so2592ybq.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZfzKpYpBjXQ1PbJDUSj9HerCpc7msvdKmrUG8Ddawc=;
        b=ktrM+JFAVdSxWcKNR8ZEFMKyawg6rCVkKx0kxMJE52e4108mM8BLOoGs4Erm2v0CsR
         zZrdwKr0toPKmRJa3asNkAfdotCJDFAJUCOsUMTPT2a5/JmO9+KcuEYi+DVO8TLiW23p
         S+XCX1ztqRNbw2s5avwSFQYI9zO6V1j8FMYdrzk6BqhEHG3hQ+b35cKvunn+CeTaciP4
         axZmwUpUBG5OvY7T8jruIr6pcXK/S3ul1xAgDqZpJt053z4rGuUwOKH/lIVxxBZ8b/9P
         gyBvDQPaBSp9svSdM18ZB+o4KchRhUGkcX6EHkhrL27r7WUGoWmeE0UiPa0Nd2ElNV3n
         E4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZfzKpYpBjXQ1PbJDUSj9HerCpc7msvdKmrUG8Ddawc=;
        b=n1qEj7ZoQcrrS2LQNmXbHKeLjvvyrk2RsHQqmLHVgDGG2YIHfa7dKgIBn3nztmg0Vi
         jqthu9B+rEwAqUNFe4FzKoUTvQh15DtwOrcKmVoRhx3SM9ja3un/eQVzLfkVhzOjm+j+
         pQ1roIsJybhOjh+VM+nz5nvbNizomvJlc6YEoJz02nNSlKOqohcyHq3tHwFq8t2kBl4t
         jbtGcTp7fjjurzEwL7m6kKcQFqlJj86PNklCpg2FWEItDK8yxP6zo+ANGippbC34chjz
         47aMlI9AWqQOj0P9AZJSAY8BZ6ULEBaFCJLO73lJCENp5FqZweNo6nm3s4tMCLVMhIAE
         +Ozw==
X-Gm-Message-State: AOAM531/D3yh6tyTXHmf/g8hKIpH8qIohAPh43YLU/8YAkKkPS2yqHT2
        FBvMMD9UO3GjkOCQMEih0TI5cJc7x78QOOy03xk=
X-Google-Smtp-Source: ABdhPJx0RQSb+ZBP0RJdx7+XHb6G2kVVAs6+/VQYBzGqdZEN93istPYtgdoJARnBuUILOcFYKQ7lEjRoTOmcenqAOmE=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr134705ybo.398.1640120263515;
 Tue, 21 Dec 2021 12:57:43 -0800 (PST)
MIME-Version: 1.0
References: <61c10192.1c69fb81.96a67.06a8@mx.google.com>
In-Reply-To: <61c10192.1c69fb81.96a67.06a8@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Dec 2021 12:57:32 -0800
Message-ID: <CABBYNZLQ_b8Aw21QnUzmuEedny4wh4LSu6DLQvw1pynFGvHMTA@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH] Bluetooth: Use driver status and experiment
 value for central-peripheral support.
To:     Jesse Melhuish <melhuishj@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jesse,

On Mon, Dec 20, 2021 at 5:59 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
>
> ---
> The observed behavior without any change is that support for the
> central-peripheral role can be enabled through an experiment flag in
> BlueZ regardless of whether the controller can actually support it.
> Additionally, if the controller has enabled this feature but the
> experiment flag has not been set the central-peripheral role is not
> listed as supported. I'm not certain what the expected behavior should
> be, but enabling if either source says to enable (this patch) or only
> when both enable the feature both seem like reasonable options to start
> with.
>
>  src/adapter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 9fc6853c9..60325015b 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -10434,7 +10434,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
>                         }
>
>                         if (feat->func)
> -                               feat->func(adapter, action);
> +                               feat->func(adapter, action ||
> +                                       (rp->features[i].flags & BIT(0)));

Feature being supported doesn't mean the system wants it to be enabled
since this is experimental after all there could be side effects, the
proper way to enable it is via main.conf:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n115

>                 }
>         }
>  }
> --
> 2.31.0

-- 
Luiz Augusto von Dentz
