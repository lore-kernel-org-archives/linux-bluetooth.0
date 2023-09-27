Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2204E82CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjI0Vqs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Vqr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:46:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14358E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:46:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c135cf2459so185900481fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851203; x=1696456003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB63DcVyqxbhMRdT1D5mscGB0SuAdUA1QlLHxGnMCMY=;
        b=PHXqtytNzVzhCdScHrAmaR8PjAtO0L/lXB0eZx/zaGRJ0rTStU0iaMZd9tzLlrDv3W
         mj8gAqznDA9FM8XeP3A/q++FMNjFa74uyeo+O2NkqLqCF2/6rRghPm6JcIttVw9w/Un8
         xPKAi4Zyhc+fIvEcWb/YKCr3fyRynAt4Qz1hfouVs5uXwn+6VhISX+gy8rXeztS+cjPH
         d5DWlTPmZKM5s8AdJnTT+Pk/q5hSqlNMpvTjhw6hdtSUoFqtk1eF5ThvANiNOhcHnL92
         UTEd3qa8TPlmPQLcy7cIVaUWQduN0avlT80yAJdWjeGfwWyM8LyrA4pn46Ms7ctqwexj
         DRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851203; x=1696456003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iB63DcVyqxbhMRdT1D5mscGB0SuAdUA1QlLHxGnMCMY=;
        b=YEl/RVZDxnhR15tUWJJkrESXjlULgItkPha6SDTLAytck7/VpPOP4XLBl4wHjrtw5O
         x28wZS9l+arjmrElPaF0n3bzwrH5ZO5Nfxaj3mT3l6b5C6+ibKNh2VqHH57A3mhBqb9I
         zw2yIQOZUfxsGvzP37Wwuy/VsM6b9rzONSv3/PctRkSOl8AvBN95nGhvXoqMW3rBZz7b
         0+ibL7DC6l4f5CAVphak1fCirvtxES+j27n8E0MYYx94+16iSVLBM7UAffdKMmfiEkrh
         o6je6O8eO/2ttIQoJqgN8brcJvXsaMXAdXW5ba+qkJwEDCxNtxg5H4K/WdkkZtNnVMa+
         1JDQ==
X-Gm-Message-State: AOJu0YxY3q6iKJQPlVG6zDig2akRle3omKB/J0jxkSWK3bK53DaNMMDB
        QtEvLlpm2BP3qMuEAH+Vm621MjP+ERQGBj1klP3CeGFD/wCUYA==
X-Google-Smtp-Source: AGHT+IE4OhI6yZP9cssxOSDHS975tHuzaehs/EPgf/VGtL/c6Tb2ukIGoHi03kD3L21/qZBFRom8VNPHeGeuEhoLYk4=
X-Received: by 2002:a2e:7209:0:b0:2b6:d6e1:a191 with SMTP id
 n9-20020a2e7209000000b002b6d6e1a191mr2968827ljc.23.1695851202840; Wed, 27 Sep
 2023 14:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230927113739.3332-1-iulia.tanasescu@nxp.com> <20230927113739.3332-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230927113739.3332-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Sep 2023 14:46:30 -0700
Message-ID: <CABBYNZJ1AKTiLtnu29Sax9=-R4u0oAGmBiNy6k20aHNVH9aLHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Fix invalid context error
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

On Wed, Sep 27, 2023 at 4:37=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This moves the hci_le_terminate_big_sync call from rx_work
> to cmd_sync_work, to avoid calling sleeping function from
> an invalid context.
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/hci_event.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d242f956dea8..640921358e5f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7020,12 +7020,26 @@ static void hci_le_cis_req_evt(struct hci_dev *hd=
ev, void *data,
>         hci_dev_unlock(hdev);
>  }
>
> +static int hci_iso_term_big_sync(struct hci_dev *hdev, void *data)
> +{
> +       __u8 *handle =3D data;
> +
> +       return hci_le_terminate_big_sync(hdev, *handle,
> +                                        HCI_ERROR_LOCAL_HOST_TERM);
> +}
> +
> +static void hci_iso_term_big_destroy(struct hci_dev *hdev, void *data, i=
nt err)
> +{
> +       kfree(data);
> +}
> +
>  static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *d=
ata,
>                                            struct sk_buff *skb)
>  {
>         struct hci_evt_le_create_big_complete *ev =3D data;
>         struct hci_conn *conn;
>         __u8 i =3D 0;
> +       __u8 *big_handle;
>
>         BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
>
> @@ -7064,16 +7078,25 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
>                 rcu_read_lock();
>         }
>
> -       if (!ev->status && !i)
> +       rcu_read_unlock();
> +
> +       if (!ev->status && !i) {
>                 /* If no BISes have been connected for the BIG,
>                  * terminate. This is in case all bound connections
>                  * have been closed before the BIG creation
>                  * has completed.
>                  */
> -               hci_le_terminate_big_sync(hdev, ev->handle,
> -                                         HCI_ERROR_LOCAL_HOST_TERM);
> +               big_handle =3D kzalloc(sizeof(*big_handle), GFP_KERNEL);
> +               if (!big_handle)
> +                       goto unlock;

You don't need to allocate a pointer to the handle, just pass it with UINT_=
PTR.

>
> -       rcu_read_unlock();
> +               *big_handle =3D ev->handle;
> +
> +               hci_cmd_sync_queue(hdev, hci_iso_term_big_sync, big_handl=
e,
> +                                  hci_iso_term_big_destroy);
> +       }
> +
> +unlock:
>         hci_dev_unlock(hdev);
>  }
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
