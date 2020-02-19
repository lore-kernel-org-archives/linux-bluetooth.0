Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED429C34022
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 21:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA9A20656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 21:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9rst+hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBSVzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:55:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42185 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSVzw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 16:55:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so25408334oih.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+RWq9TswfCN49mQiwiDUusBdO5Aw6qNTXjzZLPs6WjU=;
        b=u9rst+hrEuFby/iRnQL++g4iuQTEPXIE/2eIdXIok1cNY4nfF1m/YBhB08nM6Np5Mv
         i5PxBro0og7RHeJPajnGc0aYrJsvDHRH3I8Z/L1IHAoqiMpyUFSzloyatJxMQ7rsE+XA
         9TE8VIiL/CE5dR7paMbAPzaenTS9g1icNx/PyslDUvmBV83tN0BAytXvEglK/eyAt86a
         6cIbxnrHOKjaH1NkCJ+36dunEE1o1bpaVjZoCgcOMekxAgfCoCd3pggnB5twkBEXKc24
         DMmTHJjKzdnRcFhRmRavEJLl/h/bdM2eGgG9fqJcSHnGnToMLhkuvl2k2FWFkRngVrpP
         M7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+RWq9TswfCN49mQiwiDUusBdO5Aw6qNTXjzZLPs6WjU=;
        b=tNhtQhk8esYS1UNAciLF533U6SOMr5RZHPArgXhNBtAcdVMO8riSG3sqEzK7JL7BjN
         MLDKDKUpMH9pWLkm/3nsRhth8GHjuojaumHukDP2xv/o7dhjDmuE8XcUsy3bWqQZaVeD
         2NoOniTV33WUt8R2/HmaN/U2nxoSyCoWq0xVZs7ugdsstj6eqmxDBLj6vKrdyMFBR7MR
         av0sxhahIdVvbKem9UjNBKQNZZCkkoEzdlVAjdooA2YfjqYL8DT4aZzjo3CbEFymNuWq
         j1gScp2C4jRy+/Cp5zr93721A6IDuX5eCqe0QM9qbuasf7Qh76+m/oebBcFbKWMZhJrE
         sK5Q==
X-Gm-Message-State: APjAAAVWsvymxTp5o4LXZLhaxLTnAoQJB3X4Om+woi+bWjJxl/w4TZjg
        16st0fnrYY/Mu/F+rY7QrK6TwEVVRpqdInExxl2wwYNc
X-Google-Smtp-Source: APXvYqze6dPiAB1xsRw9T02qAKnG10rF/92XKOKqM24n6flbDIYTA42WuwOAErxHL+euJvWiA1Fqjvq/kdDdMxPu10Y=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr6175181oie.110.1582149351149;
 Wed, 19 Feb 2020 13:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20200219003612.14599-1-luiz.dentz@gmail.com>
In-Reply-To: <20200219003612.14599-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Feb 2020 13:55:39 -0800
Message-ID: <CABBYNZKaY-YqvziiDcOBLKU64FBpmQeCZimXdj8CrCsuWMP0Uw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] lib: Add definition to BT_PHY
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Feb 18, 2020 at 4:36 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds the definition to BT_PHY socket options along with the
> possible bitfields for the return value.
> ---
>  lib/bluetooth.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 756dce164..d14217eac 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -123,6 +123,24 @@ struct bt_voice {
>  #define BT_VOICE_TRANSPARENT                   0x0003
>  #define BT_VOICE_CVSD_16BIT                    0x0060
>
> +#define BT_PHY                 14
> +
> +#define BT_PHY_BR_1M_1SLOT     0x00000001
> +#define BT_PHY_BR_1M_3SLOT     0x00000002
> +#define BT_PHY_BR_1M_5SLOT     0x00000004
> +#define BT_PHY_EDR_2M_1SLOT    0x00000008
> +#define BT_PHY_EDR_2M_3SLOT    0x00000010
> +#define BT_PHY_EDR_2M_5SLOT    0x00000020
> +#define BT_PHY_EDR_3M_1SLOT    0x00000040
> +#define BT_PHY_EDR_3M_3SLOT    0x00000080
> +#define BT_PHY_EDR_3M_5SLOT    0x00000100
> +#define BT_PHY_LE_1M_TX                0x00000200
> +#define BT_PHY_LE_1M_RX                0x00000400
> +#define BT_PHY_LE_2M_TX                0x00000800
> +#define BT_PHY_LE_2M_RX                0x00001000
> +#define BT_PHY_LE_CODED_TX     0x00002000
> +#define BT_PHY_LE_CODED_RX     0x00004000
> +
>  /* Connection and socket states */
>  enum {
>         BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
> --
> 2.21.1

Pushed.

-- 
Luiz Augusto von Dentz
