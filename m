Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5A0C2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D9D206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c8xasDmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDGXnW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:43:22 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41312 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGXnV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 19:43:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id a63so3591917vsa.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5sjHFFsxbku6QcEI+FyhoEB+p/8KKsAmGhEW48J20A=;
        b=c8xasDmOZTvdq0ZJy2sPog6e8Oi0rbzAHUA90qNfIW4zhYhQHs5DlBaJQHiRJDDt2V
         Yl7mBAlUZFzzDpoFgz6QXhs1JXzj4DcVpv4kEbCiBOQOqGvL9L10gGz57nwwaGs+V9Th
         S1XIyZ2FYAWaUYx6ZpT07qND4D++TDGYn5a58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5sjHFFsxbku6QcEI+FyhoEB+p/8KKsAmGhEW48J20A=;
        b=couElXlO8Cd6oPuhZSj5iPjukiHjKOof0KUsZ7IKZOOdWNMAb7MDqcOXF5xOIKpRtU
         UaAy7pquM0htAk3unwhqxwyWujvRCZ/4eOnW97dnH0M4QF8JOxvrTmC9W28gg3BtcXry
         y9f5VSIEaEirb6TInDyLIIZ4sTGZdugIDW6I4aPEDZlwdovJ6Wt1kjfu1q42h/rfQoaS
         jAXBjVe3seRm0IUwYXIXb+pfsB+WcH/0GBgMaUfF5FhS/8sPRzhsLfb1yNsgTZ00p0x8
         rnexWBZ2cOvK1tBr+LLeEva1AEv8fLYrTIMvTouQq7SNHQnuRY9TEMe1zFpLV7aRZpyk
         p/yA==
X-Gm-Message-State: AGi0PuZw0RMo1nfwt7EcbRsw3acQLGrOdRssuXpIWr6wtlJhlxz0X+DT
        GqsbXY/3TwGuHd+RrSmyR+4j9tx0z72tS4u3mzeA5gYI
X-Google-Smtp-Source: APiQypINl/ahTJcAkJ5IYFdVIPsL5z5aO+6a0QqWrJ6Xvq5pQhMcUAYl2LAYyyBpIc5I/jwdU4hleuR66gsECSuXmO0=
X-Received: by 2002:a67:b60c:: with SMTP id d12mr3628019vsm.196.1586303000376;
 Tue, 07 Apr 2020 16:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200407205611.1002903-1-marcel@holtmann.org>
In-Reply-To: <20200407205611.1002903-1-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Apr 2020 16:43:08 -0700
Message-ID: <CANFp7mXR+N7syYE6EdNH-+jE9r-uPHHfN8EvAFSUFUT7sbGVCw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Update resolving list when updating whitelist
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Since the resolv list is tied directly to the whitelist, do we still
need hdev->le_resolv_list? Maybe we should remove it.

Abhishek

On Tue, Apr 7, 2020 at 1:56 PM Marcel Holtmann <marcel@holtmann.org> wrote:
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
