Return-Path: <SRS0=XOWI=VK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3F2C742A7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Jul 2019 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D387120830
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Jul 2019 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9pU9X/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfGMOw7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:52:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42080 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfGMOw7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Jul 2019 10:52:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so12388379otn.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jul 2019 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+EpY7TbCNUCxbfq/nA1UuYrOkXKvnEL2BxXNBei8XaY=;
        b=J9pU9X/GNc3rEsMb4DPQTTyuMctyyvVJxk1/Fkrblz7AriLHULN5TSvKgAoIy5IK8V
         vp57N5uFs8RDbdTo3HouzayrOCaX5PC4Fywr3l/7xWipH5EVll+B6iokWuc8pRk+GlXS
         +OhOvkzlHCaP71qWTGZU4sf07trPICmjUNz9cYvOsPbqNYOXTMZKTf0iAMVNQHCEp0iP
         ePzUxAUwLPDqR1zMmiK2ark6uICI8EEX88Lc3ghERjoT9wF/NtSsjI0dE9IsYQr5BQiJ
         6lNxsuL0ZFFwb/JA50tO7W1Yx7TQyd3/nuHRkNwrtoW4Z6tL7GC4/s4hHRiVparplS/6
         N6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+EpY7TbCNUCxbfq/nA1UuYrOkXKvnEL2BxXNBei8XaY=;
        b=acecMkr8035t+Y70WbfPyrf85g1a8xXnzey4FTKjioWhle+0d0QneT4a+wF93Z9ORQ
         gKztAW00YhK7BQdnkQdy1R2Jtig05HfTOHfq4chftjwuOh1AJ48/WjPwsaEbGQvwEhc/
         rEdnvoRSXxLcByVlXpBf26VegtI7Ioy92IPlR7PTEWTagpbkGwD+W45oxKO6DHhyFHna
         0fxPJmB+GFOZH+WdcZuYNA2HL5JyKRJCBBH1XGz+Y9/yh7sBZ8FsoVHT5ElSuR9Tt80b
         ZA3Jl8h0UHzbrDqCmreMh0gfQWotWA1/wBPCgIJG4uHw1REzEkBEVzUUcT3K4CL+psTT
         IF9g==
X-Gm-Message-State: APjAAAV8b1vdrL1X3q0cPoBEJp7e7Ro0oS9dkbro46IjqN+8Ik7aQJ1Z
        VZSe4H15sZWSKLeIe+65CztYbB4Mr5Gpq5WNvMK1L1kW
X-Google-Smtp-Source: APXvYqwAOUr6k1qpCgOG/6Sh11S8zn3uDpWRIUFsUBJPfnxwotE+adUhdfnz7HnOytwe7xkLlWD5FwmQZsf5FOKnaJ4=
X-Received: by 2002:a9d:7003:: with SMTP id k3mr12750007otj.28.1563029577630;
 Sat, 13 Jul 2019 07:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
In-Reply-To: <20190712151329.11333-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 13 Jul 2019 17:52:46 +0300
Message-ID: <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Jul 12, 2019 at 6:13 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This uses application ObjectManager to discover the MediaEndpoint and
> MediaPlayer object of an application and deprecates the use of
> RegisterEndpoint and RegisterPlayer.
> ---
>  doc/media-api.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index bca8c9563..07f7ac3e0 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -66,7 +66,27 @@ Methods              void RegisterEndpoint(object endpoint, dict properties)
>
>                         Unregister sender media player.
>
> +               void RegisterApplication(object root, dict options)
>
> +                       Register endpoints an player objects within root
> +                       object which must implement ObjectManager.
> +
> +                       The application object path together with the D-Bus
> +                       system bus connection ID define the identification of
> +                       the application.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.AlreadyExists
> +
> +               void UnregisterApplication(object application)
> +
> +                       This unregisters the services that has been
> +                       previously registered. The object path parameter
> +                       must match the same value that has been used
> +                       on registration.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.DoesNotExist
>  Media Control hierarchy
>  =======================
>
> --
> 2.21.0

Can you try this set?


-- 
Luiz Augusto von Dentz
