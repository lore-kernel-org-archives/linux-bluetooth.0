Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9665C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 06:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7B7222D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 06:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQd0lRce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCJGFM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:05:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34012 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJGFL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 02:05:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so12096896otl.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2020 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMsB7ODugHJLMK1rCXKFSOq1ym/jlDUVx64dEEGLh6c=;
        b=RQd0lRceslnJ5JSuvUPDB8/P+V2tBKhEkhTk7+HJSj+DkEmbc0BaXHcup+NaqSiy2i
         MSxc2jog/5yhtQP+Iz1ofHZc981Dc9mcaZutR5pMWtPiEkNAXAjjXjWKgbvJiQ3zncEo
         3oEaBGRblD4uGPZ37TB/A/iYBCQB7avtxTno2BBlg3bV54VTzlC8EgN7JbWcpfBJXRI6
         UAgTTqVXGfOXYzpiTv+/AghDuO23XOrRjMLAJi8S9CdZjOhNsyJNa5USPiZD1ZCv+w+l
         +RnA/xQeJl0afAxRPu4v7t0uLA78UgKlQjSN/6jPaq7MvKQGdF7bXn/UDOaULl6JieiU
         71MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMsB7ODugHJLMK1rCXKFSOq1ym/jlDUVx64dEEGLh6c=;
        b=lJEsRDc9yREVnSRqB+WrgUChSF+5ScbKyGmdf98v2K0DHB56tE38f06e5+xF0e9kA0
         uzhIsy/OAk0Yc4bt3vBelcrcRvlDwn8avkQDjTnKkGi+W1g2ymfm5L0aOUKyREbBekx1
         Gozt5ox68wbShcfX+j9xDA8iwurtKXqafwdCU6SDuAafs743vGa74EEbpzQOK8s9bU0B
         F905jXJzakzGRM370n+TMpqFjWz2yaloV2F0x1VBfiz38MLod450AxQsmrlPpf6arFZV
         l4bklsi3sdwCZqADNUlF3TEO58mmsmvphUsJIsf4iKqhpGf3lPLijv7IKMT5UMKQgx7R
         q8LA==
X-Gm-Message-State: ANhLgQ0JuJBFY9Kl1iQvfbEZl5xxTwAvstI0w2s1oO8uzDEU4xOmM2fj
        LMS1bvCrxlEi3uWHzWBOPJeBMK8AO4RF08v7D2Y=
X-Google-Smtp-Source: ADFU+vs+BiRvGMesbpbDl1X6EoUsWDwza3eVXLC/bBBXxO4y8ZIRyLWAph8CV03YQh82qSmTXIfV68z+5Lbx73KbNec=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr14691388otc.146.1583820310905;
 Mon, 09 Mar 2020 23:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200310023516.209146-1-alainm@chromium.org> <20200310023516.209146-2-alainm@chromium.org>
In-Reply-To: <20200310023516.209146-2-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Mar 2020 23:04:58 -0700
Message-ID: <CABBYNZKWQRw+W8f_ethSbcaS+4MgJgsjBYx2BAx_XGRNWnz+WA@mail.gmail.com>
Subject: Re: [BlueZ PATCH 1/2] HOGP must only accept data from bonded devices.
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Mon, Mar 9, 2020 at 7:37 PM Alain Michaud <alainm@chromium.org> wrote:
>
> HOGP 1.0 Section 6.1 establishes that the HOGP must require bonding.
>
> Reference:
> https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00352.htm
> ---
>
>  profiles/input/hog.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 83c017dcb..dfac68921 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -186,6 +186,10 @@ static int hog_accept(struct btd_service *service)
>                         return -EINVAL;
>         }
>
> +       /* HOGP 1.0 Section 6.1 requires bonding */
> +       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
> +               return -ECONNREFUSED;

Perhaps attempting to elevate the security level would be better than
just refuse to attach the instance since otherwise we may end up with
connecting services like battery, etc, leaving the device half
working.

>         /* TODO: Replace GAttrib with bt_gatt_client */
>         bt_hog_attach(dev->hog, attrib);
>
> --
> 2.25.1.481.gfbce0eb801-goog
>


-- 
Luiz Augusto von Dentz
