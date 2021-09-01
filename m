Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F153EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 23:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D091E60EE6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 23:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhIAXzS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Sep 2021 19:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIAXzS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Sep 2021 19:55:18 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC9DC061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 16:54:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id v16so1013362ilo.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKiFgubmSEJ3wyF9tmuzMHHQ3/qITRFC8NZeh5D7UEA=;
        b=iXy2A/UzoX74I6wEBor4hq4+rAT57CkeSJjh6j0r/DKqvODyC0cI+6RAqT/fL2rAHZ
         BN2NFdJ04F1WGo+jtGidjO1FEm/nnTnP0DS8ElN1Bg2MOES/3TNc8ZKG1j1HBuD/cPd6
         5hHVNgAAgx3uIOjEASTOEKPaQ/aKuQk8k8ld/F82LG4x06JgOzhRmbJOcmw47MH/8r2g
         xPy0dqeIjk70UmGQxwdVv2aPPM5QY4i25ZJb4IoeuzP0EOUzMFmBB614nyGbd+FyaJ1I
         cW/uqEAmwKlRMH6WHpe9Nve/IuwDeXV1bqOOvxfF+dblCXKxUOPqQQLkqjdeeKWADcPh
         euIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKiFgubmSEJ3wyF9tmuzMHHQ3/qITRFC8NZeh5D7UEA=;
        b=Hc0A3Jup58rxUoa36alQQ/ZzkE2bH0hOBnOhwoHpzs3OlcQxrJRF+BUb8rXdYNUL2w
         /20a0LfiMfFiOkiQtnLfuAnb1z9lFDb2p02qSb9BL0Qe5U2rj1Z8bmE6ue/uurh3qmEB
         FzuawJl+q/TwIbDig4cdfs8GXcwGzi9UM0B/jk+gf7RWpbTDVtjpYTBmIzS5PCpmycAr
         78+jNpIFQ0ENeGQR2zZLE7P4Ap3wfVcww9f1oM5hOMNLJdUl/HQiiRAZNN+kVvjx2Ghd
         56isnhJZ4w6yzjEnKnLJJB2lCgLoux7exdVphCvY7lFALXcP2QyvAGpM+63oGD2IfS89
         /Gzg==
X-Gm-Message-State: AOAM530vU5PcWgySX1gwZNGNG7xlw4zFUhSebhgOGTpHyB3CujQo+lkQ
        1St2k9VCPAO18AtBKXiNbXvfDRq3OSE0v/mBXn6pxOTNQTg=
X-Google-Smtp-Source: ABdhPJwdaHp9Pi8nloPMJnQJxZpEgntoGnQ6v168QTd+xqzF/ROzpJAZWU0gca9CuOmo+3KCrLRV29UnXb5jcVD/Qbs=
X-Received: by 2002:a05:6e02:1a87:: with SMTP id k7mr237215ilv.122.1630540459807;
 Wed, 01 Sep 2021 16:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210831115637.6713-1-kiran.k@intel.com> <20210831115637.6713-12-kiran.k@intel.com>
In-Reply-To: <20210831115637.6713-12-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Sep 2021 16:54:08 -0700
Message-ID: <CABBYNZL3=z6CWj9EAiGnOkcaEmgs1Mq7kc5-fT4Mjk2HCUPsFA@mail.gmail.com>
Subject: Re: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend when SCO
 use non-HCI transport
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Tue, Aug 31, 2021 at 4:54 AM Kiran K <kiran.k@intel.com> wrote:
>
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
>
> Currently usb tranport is not allowed to suspend when SCO over
> HCI tranport is active.
>
> This patch shall enable the usb tranport to suspend when SCO
> link use non-HCI transport
>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>
> Notes:
>     changes in v13:
>     - suspend usb in HFP offload use case
>
>  drivers/bluetooth/btintel.c       |  2 +-
>  include/net/bluetooth/bluetooth.h |  4 ++++
>  net/bluetooth/hci_event.c         | 20 +++++++++++---------
>  net/bluetooth/sco.c               |  2 +-
>  4 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 6091b691ddc2..2d64e289cf6e 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2215,7 +2215,7 @@ static int btintel_get_codec_config_data(struct hci_dev *hdev,
>  static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
>  {
>         /* Intel uses 1 as data path id for all the usecases */
> -       *data_path_id = 1;
> +       *data_path_id = BT_SCO_PCM_PATH;
>         return 0;
>  }
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index c1fa90fb7502..9e2745863b33 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -177,6 +177,10 @@ struct bt_codecs {
>  #define CODING_FORMAT_TRANSPARENT      0x03
>  #define CODING_FORMAT_MSBC             0x05
>
> +/* Audio data transport path used for SCO */
> +#define BT_SCO_HCI_PATH 0x00
> +#define BT_SCO_PCM_PATH 0x01

If this is in fact vendor specific perhaps you should be declared in
btintel.h not here.

> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b48e24629fa4..7ff11cba89cf 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4516,15 +4516,17 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
>
>         bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_mode);
>
> -       switch (ev->air_mode) {
> -       case 0x02:
> -               if (hdev->notify)
> -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
> -               break;
> -       case 0x03:
> -               if (hdev->notify)
> -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
> -               break;
> +       if (conn->codec.data_path == BT_SCO_HCI_PATH) {
> +               switch (ev->air_mode) {
> +               case 0x02:
> +                       if (hdev->notify)
> +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
> +                       break;
> +               case 0x03:
> +                       if (hdev->notify)
> +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
> +                       break;
> +               }

Hmm I think we might need to notify the driver to enable PCM routing
so the likes of btusb can call
usb_disable_endpoint/usb_enable_endpoint for example since in theory
userspace may choose to switch from software to hardware offload and
vice-versa, note without calling usb_disable_endpoint there might not
be much power saving after all since the endpoint will remain active
or do we actually have a good explanation why it shall not be called
when using PCM routing? Note that usb_set_interface will call
usb_enable_interface that will then call usb_enable_endpoint so
perhaps we need to call usb_disable_interface, either way we can't
assume the platform will be restricted to only use one or the other.

>         }
>
>         hci_connect_cfm(conn, ev->status);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 004bce2b5eca..f35c12ca6aa5 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -506,7 +506,7 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
>         sco_pi(sk)->codec.id = CODING_FORMAT_CVSD;
>         sco_pi(sk)->codec.cid = 0xffff;
>         sco_pi(sk)->codec.vid = 0xffff;
> -       sco_pi(sk)->codec.data_path = 0x00;
> +       sco_pi(sk)->codec.data_path = BT_SCO_HCI_PATH;
>
>         bt_sock_link(&sco_sk_list, sk);
>         return sk;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
