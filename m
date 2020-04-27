Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D0C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D88D206D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0c6ZwF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgD0Qhw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgD0Qhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 12:37:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050DDC0610D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:37:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i27so27259747ota.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MB/OZAI8w4Bk96AMg0C+oCt+mVF4/KwV+hTa5WUJ518=;
        b=u0c6ZwF8RtEEoF11v8xiySS3JSq0vVe/5YUOra9WlgNMNFLMIhfdYQIW/gIS8rb+6i
         /WuMLdTW5ikIyUP3bhb5eeokAm9NLvJYqRvBHqOGiYl/8iNNGA3NxsTuiaUrUzZ7B6U0
         w1bbU5Wr0GnpkqkKw2fcy9V/x7cdhM9K0OKUQLiziREL2bAnxznXg8ukJVcrSDBHcxN3
         nd9pT3n1gFyxUo9cmCQXr+djO6wdHTn0KpnkgW7ZgJm61Ba0oFkurKIJqt2w/rMvhiYQ
         AeXem8K8CLJYH3t5nAGA3oCLe9iRqDZPiV2MvnPSZ4fKaeZxjua4z8z80LLusCmoGmeU
         4GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MB/OZAI8w4Bk96AMg0C+oCt+mVF4/KwV+hTa5WUJ518=;
        b=Vk+8OMVUU+06w+XWb/mV0URV5bupxSeWjwtkrh9EpDaXsOqBMpJkWl2C3Pr0kL26N0
         iNKTj6hNoBgvtuFxEws5xZd1r2o4HSt6/6Jf612eszk9+sZfWU5R6FOTWKWdIz1H9oSm
         MzhmJUBFPuMnfn1SdYVidxTBKCuqSb39JG7ymHFxV59H7eJQkO97UndvZdzW3+n85KNi
         ubbHK4nbLGr5t5pgmqAblLRtR0TLMDkGYlo9UBtf2qjw3UUYAm9d0fWLr9jwGwwqjcRj
         hDdgGsupn8kwGtm/ba+jKUUSX565b+8QBhSdLHIZcuFayJyo5cleIeFABYYHPAikyGjT
         6POw==
X-Gm-Message-State: AGi0PuYAatm4WmYliJuPuXqPLh3BHKyqB+U3UoBH+F+/m+716rClmPAQ
        ziyfmTUjbVFE4Vb6t9vUnjbpZvgVlzmnbykBARI=
X-Google-Smtp-Source: APiQypInRjoyvxS63Uy7l39OUcb19E2xuSt8bX44lIKYYQq6wV7d+Mdlr1QoIXOk89AMiCb0dAyIXuLXrmCtEjO/42U=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr19727600otn.79.1588005471362;
 Mon, 27 Apr 2020 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200426210202.700-1-pali@kernel.org>
In-Reply-To: <20200426210202.700-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Apr 2020 09:37:39 -0700
Message-ID: <CABBYNZKJUw2PL3vK5xLq9RDQ+V8sW4D9dP-Eh9m=0SXgChcagQ@mail.gmail.com>
Subject: Re: [PATCH] device: Fix calling DisconnectProfile DBus call with
 disconnected profile UUID
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Apr 26, 2020 at 2:05 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> When DisconnectProfile is called with disconnected UUID, bluetooth daemon
> often returned error "Operation already in progress". This change fixed i=
t
> and no error message is returned for this case.
> ---
>  src/device.c  | 5 +++++
>  src/service.c | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 149c45160..229579378 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2054,6 +2054,9 @@ static DBusMessage *disconnect_profile(DBusConnecti=
on *conn, DBusMessage *msg,
>         if (dev->disconnect)
>                 return btd_error_in_progress(msg);
>
> +       if (btd_service_get_state(service) =3D=3D BTD_SERVICE_STATE_DISCO=
NNECTED)
> +               return dbus_message_new_method_return(msg);
> +
>         dev->disconnect =3D dbus_message_ref(msg);
>
>         err =3D btd_service_disconnect(service);
> @@ -2065,6 +2068,8 @@ static DBusMessage *disconnect_profile(DBusConnecti=
on *conn, DBusMessage *msg,
>
>         if (err =3D=3D -ENOTSUP)
>                 return btd_error_not_supported(msg);
> +       else if (err =3D=3D -EALREADY)
> +               return dbus_message_new_method_return(msg);
>
>         return btd_error_failed(msg, strerror(-err));
>  }
> diff --git a/src/service.c b/src/service.c
> index c14ee0aca..e4d747a6e 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -281,8 +281,9 @@ int btd_service_disconnect(struct btd_service *servic=
e)
>         case BTD_SERVICE_STATE_UNAVAILABLE:
>                 return -EINVAL;
>         case BTD_SERVICE_STATE_DISCONNECTED:
> -       case BTD_SERVICE_STATE_DISCONNECTING:
>                 return -EALREADY;
> +       case BTD_SERVICE_STATE_DISCONNECTING:
> +               return 0;

Have you checked if there are no side effects of this change? Since
you have a call to btd_service_get_service I wonder if this is really
necessary or you want to change the behavior to not return an error
even in case of disconnecting state? But even in that case you are
checking if for -EALREADY and returning no error.

>         case BTD_SERVICE_STATE_CONNECTING:
>         case BTD_SERVICE_STATE_CONNECTED:
>                 break;
> --
> 2.20.1
>


--=20
Luiz Augusto von Dentz
