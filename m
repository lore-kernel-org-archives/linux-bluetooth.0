Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E1DC54FCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60203206F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 17:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krSUDKlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDURPX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbgDURPW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 13:15:22 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740FCC0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 10:15:22 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j4so11783703otr.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P9q15vURD2pcth9Cs8Wji2MpLAM2cRPkZKqy5VAZOwY=;
        b=krSUDKlWLzwlxszKxfFNMA9LyQC2YvLeEtM6iMjj+J8cG45f/gG07wtayGa/Cm1abZ
         OQmgl3XtdML69uNO7KpfuqfaDL4o6dvlpA5N+D7bPkSm5DjX7291IIjotm1hGD8bhRW3
         zXG6Yh7BxljBNeIvmhovat96CvrHkczR0mPr2dtQXD9HtW7jRWtzIMLfQPy1LecmkxDa
         eT/eJDKkBPXzuz4AnGBEoMxi3/8h3PQ45IojtQm+uhv7AnKjhjKOIggjnbbU+RkGXEnb
         s6ezK3UPMWjdvwi3PbcE2VazkJnRK3rB1YzA3negMuqloecbSJUmmDwU0Dv50Bwy6VkS
         KMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P9q15vURD2pcth9Cs8Wji2MpLAM2cRPkZKqy5VAZOwY=;
        b=XnICDh/kbMPa8mR2Ra8zFT1eqISOIzOtoQ479yXHU1MyttzO5seBcAeoEJkoBgWEvQ
         chHCl5f3C6HcguczLiN3uBEICGjPzxiFNuRedKOhMC4nHU6kWvcXFPiRWqgv1Om9q0qJ
         9LRKohNoD8okC+2SSFniGejyaaikGLyYpyBowKaGE5wzRETcbSJsFhpLJcNOpfCq2pR8
         hIVB0uSWVgWi87+8XOB79KbS/PsxrSt3X91a6R31tQG6P3fNxhwBhUjNQXb4ML0lLNcO
         Wn4ogf/8QcCpE0eQyS/f5FyiWBWl2PqFZQJTKS6FtsNG9FP0dorrrmob8bAFZmrC+nRo
         EesA==
X-Gm-Message-State: AGi0PubT57R7zUDFsKrdjzOV3BwxO5jz1EgcBVDD+pTstzxGdsnS0tVd
        Y4uvIHBox0fUhEy0jtYSve4glZmnXiNKdQ/3Vgw=
X-Google-Smtp-Source: APiQypIBnNC4a9g70d4xq425MqMA/zWm8H4zsToHY+f8WqkW8BjcmThIXLYJ5mh9zG19q2YxnKG2SRDzm1hF7T1u2io=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr15037220otn.79.1587489321674;
 Tue, 21 Apr 2020 10:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200420184029.22891-1-scerveau@collabora.com>
In-Reply-To: <20200420184029.22891-1-scerveau@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Apr 2020 10:15:10 -0700
Message-ID: <CABBYNZLvTVMkxLUuXyigJV9RCcxVjktp=sCqvCnxUZ+v+pndRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hog ref before adding to instances
To:     =?UTF-8?Q?St=C3=A9phane_Cerveau?= <scerveau@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi St=C3=A9phane,

On Mon, Apr 20, 2020 at 11:42 AM St=C3=A9phane Cerveau
<scerveau@collabora.com> wrote:
>
> To avoid a double hog free, need to add a ref
> when adding the hog to the slist.
>
> This bug has been reproduced with gamepad-8718
> which was connecting/disconnecting frantically.
>
> Fix also a typo in the method hog_attach_instance
> ---
>  profiles/input/hog-lib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 9c5c814a7..8fb0283ca 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1357,7 +1357,7 @@ static struct bt_hog *hog_new(int fd, const char *n=
ame, uint16_t vendor,
>         return hog;
>  }
>
> -static void hog_attach_instace(struct bt_hog *hog,
> +static void hog_attach_instance(struct bt_hog *hog,
>                                 struct gatt_db_attribute *attr)
>  {
>         struct bt_hog *instance;
> @@ -1373,14 +1373,14 @@ static void hog_attach_instace(struct bt_hog *hog=
,
>         if (!instance)
>                 return;
>
> -       hog->instances =3D g_slist_append(hog->instances, instance);
> +       hog->instances =3D g_slist_append(hog->instances, bt_hog_ref(inst=
ance));
>  }
>
>  static void foreach_hog_service(struct gatt_db_attribute *attr, void *us=
er_data)
>  {
>         struct bt_hog *hog =3D user_data;
>
> -       hog_attach_instace(hog, attr);
> +       hog_attach_instance(hog, attr);
>  }
>
>  static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product=
,
> --
> 2.17.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
