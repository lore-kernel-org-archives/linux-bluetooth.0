Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F5AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 23:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUX6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJUX6x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 19:58:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7A51B1D9
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 16:58:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n23so2938940ljc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=igCGN6Avu7oiJd3ESIF8df0kiDpIMQdqpSOH2FnjElA=;
        b=ErExlN412vPan1t1nVf+XCi9RtJ+rJGrVfKapRXFhkcCLLr7VIcTeOQ3A6KT5SqTDm
         48gvdJVcvPtPdlnHX1DP3d/EOFy+ahNmaJMRsazZtBzLp89C/OgG3GfeKfMLo23cC5/r
         BxYxg4jQYRPKAykgTuoLFEYK5968ULVlInGHtlspiT/rD3Fg3DXLxZ3FVXhD23YNUDM+
         Mixd0EdkJfsX+rwmXp30lFyAMnIeU8lse8F5cO63BpSGCBH6EHDz8moXmrymEBIQlRk1
         Ha09jvbwtVlCzKsfxW74cj3EQRyBD1A3Q5TKbrUvOGZdwmhuRgIoT76wjclf2u90Cip4
         8NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igCGN6Avu7oiJd3ESIF8df0kiDpIMQdqpSOH2FnjElA=;
        b=edEczhVP2yEtTybxHDjaFrvYlB5dZcRPm7xjSzP2BfIdPy5Hp9ZsgFABatwzWZPaMh
         rPB7dcTa19AMT0KxZAMej25NAZjLQgPC1j7hZFAGqlmittOHTmDOzBOcAfmpSpRYbj28
         XIHFVvirfOX/1NHabdKq2W8dfLMYatNYwBt51rPi272htpsrUjNDAViAcpNS/oNpL9x6
         LlkAsn4ej4vZVZrgxzr1dyWl/0NR94TMHl7zMG7Fru0XbRjFTlgRIwRiZ6m8N8Q0Mu+M
         M2uLsOGqKd2D2fMQm6KC4gx9KKwTHmuuXPF8V92rnbvwUVzmfsunEiDSqc5s4ckBr0+t
         mp8Q==
X-Gm-Message-State: ACrzQf3ob858L0/rfU2AaY29M5HbJW5uglOm+b+GfXFdt0mE5xQCwp8y
        gTmr1KAg4bD9iJY1bNyIh8eJumlLcGfqM7xIt+j87PpOhFc=
X-Google-Smtp-Source: AMsMyM7UVgwz/A/6erjtfIzzptTIkeBzCfs+Rf8qEl4W7khv3fEJcicTHhx4l69QTg42LrdAvuqwDFuGpSeitkV3szc=
X-Received: by 2002:a2e:9d81:0:b0:266:a1d7:74b4 with SMTP id
 c1-20020a2e9d81000000b00266a1d774b4mr7320658ljj.423.1666396730953; Fri, 21
 Oct 2022 16:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221021234617.28848-1-inga.stotland@intel.com>
In-Reply-To: <20221021234617.28848-1-inga.stotland@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Oct 2022 16:58:39 -0700
Message-ID: <CABBYNZLDtNcr6YUuUXqRzeY2GG=gcf5p5RsELagNDHcShBo23Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Fri, Oct 21, 2022 at 4:50 PM Inga Stotland <inga.stotland@intel.com> wrote:
>
> When validating the parameter length for MGMT_OP_ADD_EXT_ADV_PARAMS
> command, use the correct op code in error status report:
> was MGMT_OP_ADD_ADVERTISING, changed to MGMT_OP_ADD_EXT_ADV_PARAMS.

Please add the Fixes tag:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes

> Signed-off-by: Inga Stotland <inga.stotland@intel.com>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a92e7e485feb..0dd30a3beb77 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -8859,7 +8859,7 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
>          * extra parameters we don't know about will be ignored in this request.
>          */
>         if (data_len < MGMT_ADD_EXT_ADV_PARAMS_MIN_SIZE)
> -               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_PARAMS,
>                                        MGMT_STATUS_INVALID_PARAMS);
>
>         flags = __le32_to_cpu(cp->flags);
> --
> 2.37.3
>


-- 
Luiz Augusto von Dentz
