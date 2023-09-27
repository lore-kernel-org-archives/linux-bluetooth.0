Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12D7E7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjI0VtN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0VtM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:49:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD08E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:49:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so201578571fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851348; x=1696456148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dgtXt6MJhHrRZgwi1sjc1vSpDl2E6f5BuQUT3jWywI=;
        b=lp9DUUffTekKdasol8XUxGoT1mhxU4r7dTcbkmuLMmhKhQsTGZpLpWeaEAP4dNlTgo
         5WOahA3+7UZwYGILPeCgOn1NUZ6Kyco/3T9m3QzivUXNeIFW8JAq5E01Zmq+XaL3DTBW
         CabIk8IzltsrfqW3q1lUi7xhXQR5bTKT/P3TOUs/vZiV838WW8T+pKQT8hHdCp3o2F10
         +bPDO7RNqqUI3l7Bi56HWibw9OsJRXPlu54cPbal8P4FRyprq6ddm+S9q+Ctuvnt/aUJ
         BGBpKNDDIxn+HbgcFkL0ot2RdUoyLYIxeF0CxUzwmflF4hSs6LYJhPFW9H+gmwr1Kj0Z
         jM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851348; x=1696456148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dgtXt6MJhHrRZgwi1sjc1vSpDl2E6f5BuQUT3jWywI=;
        b=iMNCXA+tHfBjY+cKdum8qKd3jtZKrgU0rYz9wB+jLzVZVRUwHxqNmL5XUVXoifU/bA
         sus6lVT1WpmVMMWWqXEI1o9atGrctPgXy/7jukOx4/jKQ/62bPcO4aHDTU+9VS6l3j3q
         9fcY+slQSlhmsBny/rOJQ+2yNfZWz4hK6wxxQtS27bl18QJSmNzKIAieSyphJnnW/5j9
         Gk58B1os2mhp0L6EnhvPZIv9brvVN88DdoxkvdBl4z83JqGb/X6yGmXH3SCrGBCFv6nh
         PiGyo9GuhB/8pjfetESmszQeVbet8WNQDf/Ul39QUjMWHPZke2ECO8xZkXRGgUFp0Ljy
         SBlA==
X-Gm-Message-State: AOJu0Yy9NWfZ5h3bPMG3sjA9S7+HRpuwrS52CIAhjBZnOHQ6QcTX/Om4
        xJgm7g6+MXb+VwTvIikyoQ5XdVU9cfg+WVvkofpmoi6ccLBfXg==
X-Google-Smtp-Source: AGHT+IGucfMevix5fV5Gly3R70Dy8ChkIFujKPXSU7cSaloxJbbqy5Hk6tAcOrTIav/gUtsH09HpMleMRgcdG8B41Nk=
X-Received: by 2002:a2e:8885:0:b0:2b6:a3a0:5f7 with SMTP id
 k5-20020a2e8885000000b002b6a3a005f7mr3126425lji.9.1695851348304; Wed, 27 Sep
 2023 14:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230927075835.20125-1-iulia.tanasescu@nxp.com> <20230927075835.20125-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230927075835.20125-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Sep 2023 14:48:56 -0700
Message-ID: <CABBYNZJW+KV_+293w8MPu7+Ek0zrSgA73ZVF67zZCA8iWy+znQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Allow binding a bcast listener to 0 bises
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, Sep 27, 2023 at 12:59=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> This makes it possible to bind a broadcast listener to a broadcaster
> address without asking for any BIS indexes to sync with.

Is the intend to use this logic for discovering broadcaster? I guess
we should make it clearer and perhaps have iso-tester also testing its
behavior.

> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/hci_conn.c | 2 +-
>  net/bluetooth/iso.c      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e62a5f368a51..c4395d34da70 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2138,7 +2138,7 @@ int hci_le_big_create_sync(struct hci_dev *hdev, st=
ruct hci_conn *hcon,
>         } pdu;
>         int err;
>
> -       if (num_bis > sizeof(pdu.bis))
> +       if (num_bis < 0x01 || num_bis > sizeof(pdu.bis))
>                 return -EINVAL;
>
>         err =3D qos_set_big(hdev, qos);
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 2132a16be93c..8ab7ea5ebedf 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -790,8 +790,7 @@ static int iso_sock_bind_bc(struct socket *sock, stru=
ct sockaddr *addr,
>         BT_DBG("sk %p bc_sid %u bc_num_bis %u", sk, sa->iso_bc->bc_sid,
>                sa->iso_bc->bc_num_bis);
>
> -       if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc) ||
> -           sa->iso_bc->bc_num_bis < 0x01 || sa->iso_bc->bc_num_bis > 0x1=
f)
> +       if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc))
>                 return -EINVAL;
>
>         bacpy(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
