Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236EC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 20:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCQUyE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCQUyD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 16:54:03 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BA30ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 13:54:02 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id by13so5633069vsb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679086441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7K8fJbtv53eY/GnAqShkP527gnvGCkOmOIzplFRbxg=;
        b=ZHu3j9m9tDbXq863vh1hoRFemU5gpK0JbQIOj/Kf2IY0Gn2bxoxsDIz7VbVh01Mubs
         HCX2H5oWxWcICf/FYOaFGKvH7Q5Zf8N3BH3SJI96QazKIo4FlWwhRgOq4D8jXMTwc8+d
         iudW25yd8hhpFFUozfXz3xWaRXMfyH7CawlRXUekXAI7e4xbDuZmoA+/Bj7q6oeENmR/
         JPUJfbNwh/0nz7kY4/f4VvdkdPsQNIwAKl3y5gYi3qLwtr7QYITuU2XhcXwUuPHYqESZ
         WnLFTUTJUc8bzvHBkcIg+Ko78nq04JMGcepj7VKf/af+ZiHkG14+glrCttk6SVcPSD7Q
         1GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7K8fJbtv53eY/GnAqShkP527gnvGCkOmOIzplFRbxg=;
        b=ioDihLL4pNG9vtPFWRkvvBk3SGrjp8smfZi5OwWf3mUOzVcDo9Ibhn3g0egrsUQpl8
         nNk+35P0H56TSTjf8SObIhD0XqOoLRAETZow+AgzPanHvsmKzUscFbyWLS5oeW7cSVVy
         /Byr1Xbo0WIlYPIlDROzEeftvfquTsDnn8ubXlYOiIJ6dB1A6mvz4Uh77BjNhSBMMI8P
         rVyUXP/uy1EJQwoaxDO0hWLH4BuomuJcvHgdxAF3ASj9O4Mrv39cnW8wBy9Y9f+jXLHC
         RwhzUlheNvj7ckepsz3KRvwsWvNC7IL2u7ilfHIq2ilybPLilBt0Z2N8Zs8EtruBp2fq
         8H8w==
X-Gm-Message-State: AO0yUKWNQ6E2POtOFxPVRQfq4BOWEx37zGa1pMXLSkAGZr6md8qaCPpK
        fWCMn64kDnfxWMFBwlXeBTjSNn2Kac9GdVe2L2riFEM8
X-Google-Smtp-Source: AK7set/vm9wvh+05KecFPR1lwkf7DB9oNmsz+i48ahZ1XwfxsspZ9ISq71TKilDp3AHd+CMU13jaChIwRxCrDjhxBZ8=
X-Received: by 2002:a67:d80c:0:b0:421:947e:4470 with SMTP id
 e12-20020a67d80c000000b00421947e4470mr28762vsj.2.1679086441070; Fri, 17 Mar
 2023 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230317204620.2809181-1-raul.cheleguini@gmail.com>
In-Reply-To: <20230317204620.2809181-1-raul.cheleguini@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Mar 2023 13:53:48 -0700
Message-ID: <CABBYNZ+tW=w74V8bOYtjcwG=RUUKxSBKGkpe+w8A4gohCWbXZg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Partial support for Actions Semi ATS2851 based devices
To:     Raul Cheleguini <raul.cheleguini@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Raul,

On Fri, Mar 17, 2023 at 1:46=E2=80=AFPM Raul Cheleguini
<raul.cheleguini@gmail.com> wrote:
>
> This change enables support to device initialization and to scan
> process, by adding two new quirks for the following advertised but
> unsupported commands: "Set Random Private Address Timeout" and
> "Extended Create Connection".
>
> It offers partial device support: controller initialization and scan.
> The pairing process still needs work.
>
> At the moment there is little to none available documentation about the
> ATS2851 and its based USB dongles. It is known that it works in other
> systems via generic drivers, and this is one step towards have it working
> in Linux.
>
> Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
> ---
>  drivers/bluetooth/btusb.c   |  2 ++
>  include/net/bluetooth/hci.h | 14 ++++++++++++++
>  net/bluetooth/hci_sync.c    | 13 +++++++++++--
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7382b021f3df..7bba19061277 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4106,6 +4106,8 @@ static int btusb_probe(struct usb_interface *intf,
>                 set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirk=
s);
>                 set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quir=
ks);
>                 set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
> +               set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
> +               set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
>         }
>
>         if (!reset)
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 997107bfc0b1..3ff1681fd2b8 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -301,6 +301,20 @@ enum {
>          * don't actually support features declared there.
>          */
>         HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
> +
> +       /*
> +        * When this quirk is set, the HCI_OP_LE_SET_RPA_TIMEOUT command =
is
> +        * disabled. This is required for the Actions Semiconductor ATS28=
51
> +        * controller, which erroneously claim to support it.
> +        */
> +       HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
> +
> +       /*
> +        * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command =
is
> +        * disabled. This is required for the Actions Semiconductor ATS28=
51
> +        * controller, which erroneously claim to support it.
> +        */
> +       HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
>  };
>
>  /* HCI device flags */
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 8e5fe73873a8..9b2a0d6d6c1a 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4090,9 +4090,11 @@ static int hci_le_set_rpa_timeout_sync(struct hci_=
dev *hdev)
>  {
>         __le16 timeout =3D cpu_to_le16(hdev->rpa_timeout);
>
> -       if (!(hdev->commands[35] & 0x04))
> +       if (!(hdev->commands[35] & 0x04) ||
> +           test_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks))
>                 return 0;

This one Im not so sure, if we can't set a timeout then we shouldn't
use the controller to rotate the RPA, although it seems we are already
doing it when the command bit is not set.

>
> +
>         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RPA_TIMEOUT,
>                                      sizeof(timeout), &timeout,
>                                      HCI_CMD_TIMEOUT);
> @@ -4530,6 +4532,12 @@ static const struct {
>                          "HCI Set Event Filter command not supported."),
>         HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
>                          "HCI Enhanced Setup Synchronous Connection comma=
nd is "
> +                         "advertised, but not supported."),
> +       HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
> +                        "HCI LE Set Random Private Address Timeout comma=
nd is "
> +                        "advertised, but not supported."),
> +       HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
> +                        "HCI LE Extended Create Connection command is "
>                          "advertised, but not supported.")
>  };
>
> @@ -6067,7 +6075,8 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, s=
truct hci_conn *conn)
>         if (err)
>                 goto done;
>
> -       if (use_ext_conn(hdev)) {
> +       if (use_ext_conn(hdev) &&
> +           !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks)) {
>                 err =3D hci_le_ext_create_conn_sync(hdev, conn, own_addr_=
type);
>                 goto done;
>         }

I guess we can incorporate the new quirk check inside use_ext_conn.

> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
