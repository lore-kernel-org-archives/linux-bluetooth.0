Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93AC2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327BA20730
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw+8f9QR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDGXAw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:00:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42255 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGXAw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 19:00:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id e4so3046302oig.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qV6TXQkzHkiRIUhyoCGqKTEynJsBU9vf8h9IEYjHuc=;
        b=Kw+8f9QRHFNbmFZa+6MkO21fXqgZFhNv49+8aqUSMJQqX9Kgb8ayUZnfreiSB56bex
         IXO1l9O675wOsEyrpcKzy2s7zrKhY2UY3kminemTaR2dqk1nqHMF8NABFLp6fnX/rVA8
         uG2N2glicYL23PeB3wwQZ+NXagFgKX0OomyafyymGZySlqD872uAldFmsu5KL0zjAFAG
         qc9A4oLgyPbpkjWFW9pJjcYc6Yrm0Tv5dUF7wcisluQA4yYU2hQ9cacQFnZEDwUHoQ2G
         uZgn7gZL8OmeTK/VOgLskOTVnq5csmZmut1CJ8wmec47U0tEGNYmluF2iclKZ7GLceEw
         jN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qV6TXQkzHkiRIUhyoCGqKTEynJsBU9vf8h9IEYjHuc=;
        b=i17qRewJT+NspOySHLFV3tbI1v7sIIPAs3BLmI2D1f9PJ0dChml2g3hJ5fptUCT2HK
         Nsp4KUWf6bJVXUDCaGk1qmOpE9jlT0V2nZ9ZXK3kxqU+DasPYSI+C6ySLq1SLwZPZfly
         5Ka4TKu07KaaqrCXCu2D/dKIn8kympxgnvLUtXwXUC3uPUF7aLqUnt5ySuNBO/7jmih6
         TU/yTxVeNZVNnMKBreIeTYAfI/T8Ayg/Q20SwwhAp/DsZO4M1FhfFV38j6+IE3+vS3hp
         jY5jWdzZEmspYu3kAeXHusWKgDqkXrXiFEsXkDOGjUjLvypCiZHW+qczk6O7aNoy1+ss
         HDOA==
X-Gm-Message-State: AGi0PuYSFB9AqkOlvds573EvqbqkUeNGauFpigdHd7bgiDCnjnwvDMB8
        ZiIMB45iisZjCUUVHANDZbADDm1SiSC2b9iQeHp0ZFpH
X-Google-Smtp-Source: APiQypIFMxJWW9/nB+AKN5QJvgIg3ewGWpg74xffhAGg6yrmfDySI7abL3xEHTcSeoOy6E8wsN0aKklOqmmS1Nk7a7M=
X-Received: by 2002:a54:4e13:: with SMTP id a19mr404997oiy.108.1586300451658;
 Tue, 07 Apr 2020 16:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200407205611.1002903-1-marcel@holtmann.org>
In-Reply-To: <20200407205611.1002903-1-marcel@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Apr 2020 16:00:40 -0700
Message-ID: <CABBYNZKsT9Svp7kKPfQkQZWPo2+KeokM0yHet6de=LjeANumMQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Update resolving list when updating whitelist
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 7, 2020 at 1:57 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> When the whitelist is updated, then also update the entries of the
> resolving list for devices where IRKs are available.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_request.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index efec2a0bb824..45fbda5323af 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -695,6 +695,21 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
>         bt_dev_dbg(req->hdev, "Remove %pMR (0x%x) from whitelist", &cp.bdaddr,
>                    cp.bdaddr_type);
>         hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
> +
> +       if (use_ll_privacy(req->hdev)) {
> +               struct smp_irk *irk;
> +
> +               irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
> +               if (irk) {
> +                       struct hci_cp_le_del_from_resolv_list cp;
> +
> +                       cp.bdaddr_type = bdaddr_type;
> +                       bacpy(&cp.bdaddr, bdaddr);
> +
> +                       hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
> +                                   sizeof(cp), &cp);
> +               }
> +       }
>  }
>
>  /* Adds connection to white list if needed. On error, returns -1. */
> @@ -715,7 +730,7 @@ static int add_to_white_list(struct hci_request *req,
>                 return -1;
>
>         /* White list can not be used with RPAs */
> -       if (!allow_rpa &&
> +       if (!allow_rpa && !use_ll_privacy(hdev) &&
>             hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
>                 return -1;
>         }
> @@ -732,6 +747,24 @@ static int add_to_white_list(struct hci_request *req,
>                    cp.bdaddr_type);
>         hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
>
> +       if (use_ll_privacy(hdev)) {
> +               struct smp_irk *irk;
> +
> +               irk = hci_find_irk_by_addr(hdev, &params->addr,
> +                                          params->addr_type);
> +               if (irk) {
> +                       struct hci_cp_le_add_to_resolv_list cp;
> +
> +                       cp.bdaddr_type = params->addr_type;
> +                       bacpy(&cp.bdaddr, &params->addr);
> +                       memcpy(cp.peer_irk, irk->val, 16);
> +                       memset(cp.local_irk, 0, 16);
> +
> +                       hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST,
> +                                   sizeof(cp), &cp);

Shouldn't we be checking if there is any space left in the list before
trying to send the command? I wonder what would happen if there is too
many IRKs, I guess that means we would still have to resolve them in
the host.

> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -772,7 +805,7 @@ static u8 update_white_list(struct hci_request *req)
>                 }
>
>                 /* White list can not be used with RPAs */
> -               if (!allow_rpa &&
> +               if (!allow_rpa && !use_ll_privacy(hdev) &&
>                     hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
>                         return 0x00;
>                 }
> --
> 2.25.2
>


-- 
Luiz Augusto von Dentz
