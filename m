Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271BC47254
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 13:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F445207DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 13:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5SkHhDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgEENLv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgEENLu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 09:11:50 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E232C061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 06:11:50 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q10so805086ile.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2020 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fucoW5ujao0zyyC4glJlshqMypspuFgK8KKeUM/axD8=;
        b=M5SkHhDFXRUpLu645obwIQ8mvwOtG9iX00vtntluBLJoN0RaMTf8ghGMljPu+xi+TC
         liLCkG8QKSv+eP98m1lYf8ySJApVO1SdzdRcYrXjAYUayoG613JWbJhoPPTAtZuFRJzX
         ZICsErd4HWMVK4pCCiVil9Ez5bQeAL44conV1mGtW60zvl/k605RvabqeeraLnF1MDNb
         PQYCx2MJeNC1CJrj1fRnMMSg0tPmgbvG5K9NfW/vJElxaRaPbhah2AZph7dLPYv4tzyY
         1kzKuGGoCm9bnZI+aJDNUAfNjpNSAnyrsul53Zh/zK1ZtR4NOYUsNJmREI4WvZepNHQa
         9ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fucoW5ujao0zyyC4glJlshqMypspuFgK8KKeUM/axD8=;
        b=TLiGLHAPeocBtivJlDoZdQdd6xNO96l1KyRruROq0i+xeCN+dCpWvpe+6odTnSi9jo
         pCerOs/HEZ8qAk53UhszUkC8kgjbxiCJhM5GJargIp3qXZ9g8Hx0rCN+4Ydoj8eWfLIE
         TbbkaZaqHDIorFaVSQDUGwaZ6D3uJJ4N3M8RQuFptq/MCi2Ixw8XK6T+GaGH0bvmLZgj
         sLAE9F1B7U8Y8lWjkEKou8QezqirCw7mRbK3EmvNhY8WrFz+vY00dvBUHUEwoJFLJ7zr
         BW7ZrvLKSKYg+xngRXT20CxAyojNv42U+WAVRpPFyCKcGyIyYLjMYuYHDzQHLdBc2Oxg
         HPpQ==
X-Gm-Message-State: AGi0PuYZCWvYJOwAHTfgyqQACVhTM3DN/zbktZxSBC9jHGae8ClpLrw9
        tJoQmopv4G+QfP1RCyfDnmUPmEJeg+ThzTK56zZgBTj7
X-Google-Smtp-Source: APiQypI4oGfzhfceiiSSRamvpTbNcXNOFhp6vrhbIsUBRPF74Trucj+fW1fe+/U1THXt1ywtjFDvxcZfWIMe9KFSM7Y=
X-Received: by 2002:a05:6e02:f45:: with SMTP id y5mr3485408ilj.199.1588684309656;
 Tue, 05 May 2020 06:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200407205611.1002903-1-marcel@holtmann.org>
In-Reply-To: <20200407205611.1002903-1-marcel@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Tue, 5 May 2020 18:41:37 +0530
Message-ID: <CAOVXEJJeriSp=5ywt4ZxND7mYY=yepShCC5U-8s8=_rWQup3wQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Update resolving list when updating whitelist
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Wed, Apr 8, 2020 at 2:26 AM Marcel Holtmann <marcel@holtmann.org> wrote:
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
Shall we memcpy hdev->irk as local_irk here.
if  privacy (HCI_PRIVACY)  is enabled. also if controller supports
LL_PRIVACY so that stack can utilize it.
else continue with HCI_PRIVACY.
Is there any drawback with this approach. please guide
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

Regards
Sathish N
