Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37907C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Nov 2021 03:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1706761411
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Nov 2021 03:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhKGD2V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Nov 2021 23:28:21 -0400
Received: from mail-4319.protonmail.ch ([185.70.43.19]:16161 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhKGD2U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Nov 2021 23:28:20 -0400
Date:   Sun, 07 Nov 2021 03:25:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1636255536;
        bh=L/j4faggOCaUSS+dguQPjivP6TQjj639YqR+h2amJuI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=f1fajxlzzB2UrvNW4zVFwyItm4qJq2A36sLrmOXh6Qc8xPHwFTC0A2AMwmVnKiwk5
         bU8hl2uyy/y2m4ljWRZyX6vukr4wQSGqLY9FgGxVsWU95XlPpaG1Rt/fDNI9SlChtv
         mwJTvf/lAktpmQ/KHV87lzVlLYsduWyA2CUnCw+k=
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        regressions@lists.linux.dev,
        Sonny Sasaka <sonnysasaka@chromium.org>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Message-ID: <20211107032525.76a5f347@localhost>
In-Reply-To: <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com> <20210930063106.19881-1-redecorating@protonmail.com> <20210930141256.19943-1-redecorating@protonmail.com> <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org> <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com> <20211001083412.3078-1-redecorating@protonmail.com> <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, 06 Nov 2021 08:47:39 +1100
"Luiz Augusto von Dentz" <luiz.dentz@gmail.com> wrote:
> Nowadays it is possible to treat errors such like this on a per
> command basis (assuming it is not essential for the init sequence):
>=20
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 979da5179ff4..f244f42cc609 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -551,6 +551,7 @@ enum {
>  #define HCI_LK_AUTH_COMBINATION_P256   0x08
>=20
>  /* ---- HCI Error Codes ---- */
> +#define HCI_ERROR_UNKNOWN_CMD          0x01
>  #define HCI_ERROR_UNKNOWN_CONN_ID      0x02
>  #define HCI_ERROR_AUTH_FAILURE         0x05
>  #define HCI_ERROR_PIN_OR_KEY_MISSING   0x06
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index bb88d31d2212..9c697e058974 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3325,11 +3325,18 @@ static int
> hci_le_read_adv_tx_power_sync(struct hci_dev *hdev)
>  /* Read LE Min/Max Tx Power*/
>  static int hci_le_read_tx_power_sync(struct hci_dev *hdev)
>  {
> +       int status;
> +
>         if (!(hdev->commands[38] & 0x80))
>                 return 0;
>=20
> -       return __hci_cmd_sync_status(hdev,
> HCI_OP_LE_READ_TRANSMIT_POWER,
> -                                    0, NULL, HCI_CMD_TIMEOUT);
> +       status =3D __hci_cmd_sync_status(hdev,
> HCI_OP_LE_READ_TRANSMIT_POWER,
> +                                      0, NULL, HCI_CMD_TIMEOUT);
> +       /* Ignore if command is not really supported */
> +       if (status =3D=3D HCI_ERROR_UNKNOWN_CMD)
> +               return 0;
> +
> +       return status;
>  }
>=20
>  /* Read LE Accept List Size */

I've tried this patch, and status seems to be -56, not 0x01, but if I
change
+=09if (status =3D=3D HCI_ERROR_UNKNOWN_CMD)
to
+=09if (status =3D=3D -56)
It ignores the error and continues.

I seem to have an unrelated problem where although I can connect to my
Logitech MX Anywhere 2S mouse (I haven't tried any other devices yet),
it doesn't move the cursor or register clicks. I've also noticed that
bluetoothctl pair isn't asking for a "yes" when I pair a device, which
it was doing on 5.15 (with the patch I sent to get bluetooth working at
all). I've put dmesg and btsnoop for both 5.15 and bluetooth-next into
a gist here:
https://gist.github.com/Redecorating/5620b758d8191418cf19879d09672cf4
but I think this is a separate issue.

>=20
> Anyway, it would probably be worth pointing out to the vendor they
> have a broken firmware if they do mark the command as supported but
> return such error.

Do you know if it'd be better to contact Broadcom or Apple for this?

> --
> Luiz Augusto von Dentz

--=20

