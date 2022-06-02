Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABBDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 20:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiFBUpv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiFBUpt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 16:45:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D828FA2
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 13:45:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a10so5901309pju.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v1FHdFMdEE/JMWWujz9oOl3mtg84SZg9LKBOYtQhMLI=;
        b=kiVjzhRopyep6+t1BYbaXwGJGEWwYARCmEme5u0NThV14Oe8t1NydcwhC6UzkCNK71
         kaaCkSWw6xqoDQhin3FPe4IIPh2MZGRXgO1tBkpmeQRYvSKIMd5CsMB2CJYBkHe7gZ7J
         /7v5ONtqAN16m/dqXXEWTxw5bd/N3wI8bDY6sttrhDGgJqIJpGO8zmpkdBoi7e7DR/MQ
         pEoV++/Ej8GvfhRA+C4VytPOYhMAgcp0h3LOvtwxoZmPSCVgdn1u+XhMP40rZGHXuBzB
         dQIr9M2Ywf06tIGyrFwLS+L6RYT6cCg8rnvI12CVR2ZHs0eU5r6e+OLN6fmd9+otsGBV
         9tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v1FHdFMdEE/JMWWujz9oOl3mtg84SZg9LKBOYtQhMLI=;
        b=ksMxV9hCn6D3cQVSwYpqIMbXaU3/PISU7CMjbar/zW+NL/whztmtrKKMB3tO8HFK0R
         R8cRT1+62ExriLviI02zX1JL8lIvlEOzRb2pfE43UmhNbnX4bCeWJupOD5x3Wwn3i7tP
         ZWFOKquZQryficVh5sGfvjXrrVyg6Glhxcf3e1okrG29pDy1Kv8dhvLfLrGrG0Rzto9L
         dJzNap6LyEgcry29+4QBgbFh0Xy6TedUOKnwWP0V2eI84yLssEDrJc2f0yxKkRBq7GhO
         I2gMpGOQjRp3klkM75Q9rdDau8IZXQfAG+h7E64AimXbhYKl1ejTKs2EWq3vh0dj/h8U
         WkQQ==
X-Gm-Message-State: AOAM530iHjebku6Sru9gbCkrA3xI5aQruRZfKZ1agNC9jOWTYV1+3rF5
        Hl8U5KjLw1dQUsSAq6dmaG7p+ECBcdHi2sqc/pu8uB2H
X-Google-Smtp-Source: ABdhPJxldhDYKR0fp49ZXkjrwtn6GmVeZMPqp3TGHvBefQvLTwp6tGa47/dQE+np4nT7Oo7AjV84bonngp+1pWivCb8=
X-Received: by 2002:a17:90b:3507:b0:1e3:4b80:5c7a with SMTP id
 ls7-20020a17090b350700b001e34b805c7amr7287725pjb.4.1654202747222; Thu, 02 Jun
 2022 13:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220602152613.79718-1-frederic.danis@collabora.com>
In-Reply-To: <20220602152613.79718-1-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jun 2022 13:45:36 -0700
Message-ID: <CABBYNZJuhnwOpzU_fjuo648O-9-gH+HU0vbH-ueQXU=z1gSYSQ@mail.gmail.com>
Subject: Re: [PATCH] btproxy: Allow to select multiple BT controllers
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Thu, Jun 2, 2022 at 9:08 AM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> When running on a computer with a real Bluetooth controller (e.g. hci0) a=
nd
> multiple emulators (e.g. hci1 and hci2) it isn't possible to use the
> emulators with 2 test-runner vms.
> If btproxy is started without index parameter the first test-runner will
> use hci0, and btprox can't be started with multiple index parameters
> (e.g. -i1 -i2).
>
> This patch allows to select the controllers to be used by btproxy.

Does it keep the old behavior and adds the possibility to enter -i
command line option multiple times?

> ---
>  tools/btproxy.c | 48 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/tools/btproxy.c b/tools/btproxy.c
> index 94ca1c7fd..c09a504ff 100644
> --- a/tools/btproxy.c
> +++ b/tools/btproxy.c
> @@ -48,6 +48,7 @@ struct sockaddr_hci {
>  };
>  #define HCI_CHANNEL_USER       1
>  #define HCI_INDEX_NONE         0xffff
> +#define HCI_INDEX_MAX          15
>
>  static uint16_t hci_index =3D HCI_INDEX_NONE;
>  static bool client_active =3D false;
> @@ -533,13 +534,28 @@ static bool setup_proxy(int host_fd, bool host_shut=
down,
>         return true;
>  }
>
> -static int open_channel(uint16_t index)
> +static int get_next_hci_index(int index)
> +{
> +       while (++index <=3D HCI_INDEX_MAX) {
> +               if (hci_index & (1 << index))
> +                       return index;
> +       }
> +
> +       return -1;
> +}

Perhaps use util_get_uid?

> +
> +static int open_channel(int index)
>  {
>         struct sockaddr_hci addr;
>         int fd, err;
>
> -       if (index =3D=3D HCI_INDEX_NONE)
> -               index =3D 0;
> +       if (index =3D=3D HCI_INDEX_NONE) {
> +               index =3D get_next_hci_index(-1);
> +               if (index < 0) {
> +                       perror("No controller available");
> +                       return -1;
> +               }
> +       }
>
>         printf("Opening user channel for hci%u\n", index);
>
> @@ -561,9 +577,10 @@ static int open_channel(uint16_t index)
>                 /* Open next available controller if no specific index wa=
s
>                  * provided and the error indicates that the controller.
>                  */
> -               if (hci_index =3D=3D HCI_INDEX_NONE &&
> +               index =3D get_next_hci_index(index);
> +               if (index >=3D0 &&
>                                 (err =3D=3D -EBUSY || err =3D=3D -EUSERS)=
)
> -                       return open_channel(++index);
> +                       return open_channel(index);
>
>                 perror("Failed to bind Bluetooth socket");
>                 return -1;
> @@ -601,13 +618,7 @@ static void server_callback(int fd, uint32_t events,=
 void *user_data)
>                 return;
>         }
>
> -       if (client_active && hci_index !=3D HCI_INDEX_NONE) {
> -               fprintf(stderr, "Active client already present\n");
> -               close(host_fd);
> -               return;
> -       }
> -
> -       dev_fd =3D open_channel(hci_index);
> +       dev_fd =3D open_channel(HCI_INDEX_NONE);
>         if (dev_fd < 0) {
>                 close(host_fd);
>                 return;
> @@ -800,6 +811,7 @@ int main(int argc, char *argv[])
>
>         for (;;) {
>                 int opt;
> +               int index;
>
>                 opt =3D getopt_long(argc, argv, "rc:l::u::p:i:aezdvh",
>                                                 main_options, NULL);
> @@ -844,7 +856,15 @@ int main(int argc, char *argv[])
>                                 usage();
>                                 return EXIT_FAILURE;
>                         }
> -                       hci_index =3D atoi(str);
> +                       index =3D atoi(str);
> +                       if (index > HCI_INDEX_MAX) {
> +                               fprintf(stderr, "Invalid controller index=
\n");
> +                               usage();
> +                               return EXIT_FAILURE;
> +                       }
> +                       if (hci_index =3D=3D HCI_INDEX_NONE)
> +                               hci_index =3D 0;
> +                       hci_index |=3D 1 << index;
>                         break;
>                 case 'a':
>                         type =3D HCI_AMP;
> @@ -892,7 +912,7 @@ int main(int argc, char *argv[])
>                 if (use_redirect) {
>                         printf("Creating local redirect\n");
>
> -                       dev_fd =3D open_channel(hci_index);
> +                       dev_fd =3D open_channel(HCI_INDEX_NONE);
>                 } else {
>                         printf("Connecting to %s:%u\n", connect_address,
>                                                                 tcp_port)=
;
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
