Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89210C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 22:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbiCNWM6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiCNWM6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 18:12:58 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F743C72D
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 15:11:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2dc242a79beso181072717b3.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyvyNHR+CeEpTAxf5X7ZBEjmkBrVP/b8h3SdnK8vnz0=;
        b=HZvhNn2NqnKNqz3Z8KYnpnsUWiwValBc7s3IcxJLxi7BhS5mYXrYiA6+frKYP+bCnS
         inzDX1KAt3xey0U3b4e874y8mSH3zIm4KQwIbYnN/zb9vtU2DkwsC1yJiWfPUDWXB5Tm
         DhBgUibPPk0C6knrUxaz9MM2c9zU0UWk+DhbVn6iLoXub0X5sQpSiRATNdOJNm4yEhEX
         J5alXxuW+EFkBZ9zWUUk74Z4ssiyyRE8oBMT6mj1Zje6byNBNwdKqQzIxJB1GujU5g2v
         4LflJLtJcnzwEhbJKhNUPFlvGAwGk7KX2uV4I59wzMW3gPp9c9XLZgtPjt/g5G1Qa69N
         QCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyvyNHR+CeEpTAxf5X7ZBEjmkBrVP/b8h3SdnK8vnz0=;
        b=Bh7ip8q8fsbUjPOPsDmwsi4NGGJWmQ/gS+srTplUDFJwG3Qylnm36nQ+nkysxFPJZF
         EorXqqOoQRhmaxUcdnd+UNX5SlAAGiGKsUZiRNNUxSTQqkY6GdJfhKUn85CFKOHT6lGx
         LvpbkwvZSjZMBlu20YBLerbiWZefgH2vU44vIu5qdSRTjAlELr90ulBTUoVrn0fSMKA7
         I0u2SymZ+6JbnLxTyOIiKpYUXgdUDlDKRGJi2qok97z8DAKILp+WpGEuUxMqQl24PUNB
         RNTHPv3TbiKwMw0MRzrKAYMjS/JFEKYs2UpgZ5WPUUqEaYYFIZJhKRHLEW/96JNedeeg
         EBog==
X-Gm-Message-State: AOAM530EDb2tORKqFmqnBHszGR2CJtUvIbw3aKixr3MBzG8uEXovEwC6
        UVakzwKlmtQ2cuWsX9e4Y930my+EoGNh2UmSqS8=
X-Google-Smtp-Source: ABdhPJwiYHNbik6Y2XiE3Pv1C4gNFCY0XsJMQphbKhES2s09Lvzf61tB+kQ9DM6T4P5gnhK4KSOqBChxZo8+rFYc8qE=
X-Received: by 2002:a0d:fe87:0:b0:2e5:874a:c060 with SMTP id
 o129-20020a0dfe87000000b002e5874ac060mr423826ywf.489.1647295906772; Mon, 14
 Mar 2022 15:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220314020245.135251-1-jesse12p@gmail.com>
In-Reply-To: <20220314020245.135251-1-jesse12p@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Mar 2022 15:11:36 -0700
Message-ID: <CABBYNZK9M8SC_01kuTUZ+d9kZ0hAWxx=pagrY1J3D01Umv+5TA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] sixaxis: Fix Sony Navigation Controller pairing
To:     Jesse Pullinen <jesse12p@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jesse,

On Sun, Mar 13, 2022 at 7:46 PM Jesse Pullinen <jesse12p@gmail.com> wrote:
>
> Fixed the device name.
>
> Commit 61745d2bb8b5f534278db49faf8e2cdb7e894529
> ("sixaxis: Fix Bluetooth PS3 clone joypad being named like the original")
> made the matching use the name, which broke the pairing.
> ---
>  profiles/input/sixaxis.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
> index ab8831995..cbd27cd06 100644
> --- a/profiles/input/sixaxis.h
> +++ b/profiles/input/sixaxis.h
> @@ -49,7 +49,7 @@ get_pairing(uint16_t vid, uint16_t pid, const char *name)
>                         .type = CABLE_PAIRING_SIXAXIS,
>                 },
>                 {
> -                       .name = "Navigation Controller",
> +                       .name = "Sony Navigation Controller",
>                         .source = 0x0002,
>                         .vid = 0x054c,
>                         .pid = 0x042f,
>
> base-commit: 42e99371584cc26c637fcc332de437d2c646f324
> --
> 2.35.1

Actually shouldn't we try to have another call to get_pairing if it
returns NULL to a specific name? That way the pid/vid is used as
fallback if the name doesn't match since the name perhaps can be set
by the user, or with a firmware update.


-- 
Luiz Augusto von Dentz
