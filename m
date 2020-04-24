Return-Path: <SRS0=/Nrl=6I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1C1C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 17:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832092075A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 17:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEdDWk40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgDXR0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgDXR0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 13:26:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4734C09B047
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 10:26:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g14so13686655otg.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1qtWb0ZZjtNYSUbinR1isbPhbdJy9B5K8n9nS/+lAh4=;
        b=fEdDWk40Cg3TVzanZ+mr2bQVklBhireJFdkYoJupvv66QEF+4hpwrZjP+TwdcwjwAx
         RIYzq4zcmlBFRjf5T7RBuRnppfY2i+mv4RoY+nCJLWPYURK22/lxdQSp6h6JmJvCUhDU
         dsAAw9o02+bfcFxozhqkNvJ84rgqcD2KmLxu+kHxFL89dxQVJ1WTI/yDo/lsTEBn12Dj
         sNQPrGSzZQNZLSv7hAukM/vy8sj5UgbvG1ozVABoEM2rD/bBQfPbfTxhDQ+Q5arV52SF
         YKjFOZNchMTaQlJFLHeVWnZ3W4PMjprE1vZeGEyrLXdskR0g/J2QPJxMa+GGFrlTsp+h
         1g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1qtWb0ZZjtNYSUbinR1isbPhbdJy9B5K8n9nS/+lAh4=;
        b=Qj5hqE135zFrcxSzhSyENwGw3NmSANOca3WBAOipLuIldUimDNomZ4wtkPB1kqC5Vg
         DZLD/P2iagfTbCWmxbknLVESZLuykvSBIb6Wq8Rhct9w5mqZr9CUhKfRVh4/81soxDFJ
         VsXOszgSW0HznkxD434k/tLc78R3j18xyAX6dvTYYuIf75qLnOZ1kGMQG03onL0Wa+YO
         3yxSEGaKqIEsjHAmlIfrLaNJgSV+RpPunQFc3Jau3X+F3eJhoFn8h1rI90nE4YY6hKBz
         6WT4aVf6zXYwqUVns2CXTDLQPi8q8ZoHrxj3YLrqshEyStV6/68zG4shD7XhnGl+LQ8B
         cotQ==
X-Gm-Message-State: AGi0PuahBrykSV/CeyDTtv/A+XCOJ4UqzgswQdVip34N/0BYAlaFXyEm
        cfdqvQLldq5qUdIB1gVxsb55vntgvIzp2FBSN5SZuxKg
X-Google-Smtp-Source: APiQypLV1hdzG3lfGG/WF4OSuDFLDPR8qruWeIO1OTAr4Xkw4hSWiYos/kz+/4TJpWZq4gWLRrxsNuzeAG5wgIzJqzU=
X-Received: by 2002:aca:acd0:: with SMTP id v199mr7734903oie.82.1587749200105;
 Fri, 24 Apr 2020 10:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200423233243.14937-1-pali@kernel.org>
In-Reply-To: <20200423233243.14937-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Apr 2020 10:26:28 -0700
Message-ID: <CABBYNZLC4kfqg8uWj3pq0Gg4f8aSumFW_fJfUck9AVSLpY9Urg@mail.gmail.com>
Subject: Re: [PATCH] device: Return error when ConnectProfile DBus method fails
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Thu, Apr 23, 2020 at 4:36 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Without this patch ConnectProfile DBus method does not return failure if
> profile connection failed and some other profile was already connected.
> This is not correct behavior as ConnectProfile DBus method should always
> return error when specified profile failed to connect. This patch fixes
> this it.
> ---
>  src/device.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index a8d95346a..7ab30705f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1584,6 +1584,7 @@ static void device_profile_connected(struct btd_dev=
ice *dev,
>                                         struct btd_profile *profile, int =
err)
>  {
>         struct btd_service *pending;
> +       bool report_error;
>         GSList *l;
>
>         DBG("%s %s (%d)", profile->name, strerror(-err), -err);
> @@ -1632,9 +1633,16 @@ done:
>
>         DBG("returning response to %s", dbus_message_get_sender(dev->conn=
ect));
>
> -       l =3D find_service_with_state(dev->services, BTD_SERVICE_STATE_CO=
NNECTED);
> +       if (err && dbus_message_is_method_call(dev->connect, DEVICE_INTER=
FACE,
> +                                       "ConnectProfile"))
> +               report_error =3D true;
> +       else if (err && !find_service_with_state(dev->services,
> +                                       BTD_SERVICE_STATE_CONNECTED))
> +               report_error =3D true;
> +       else
> +               report_error =3D false;
>
> -       if (err && l =3D=3D NULL) {
> +       if (report_error) {
>                 /* Fallback to LE bearer if supported */
>                 if (err =3D=3D -EHOSTDOWN && dev->le && !dev->le_state.co=
nnected) {
>                         err =3D device_connect_le(dev);
> --
> 2.20.1

Applied, notice that I did some changes to make it a little more
simple but the end result is the same.

--=20
Luiz Augusto von Dentz
