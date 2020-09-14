Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACDC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 19:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E280E215A4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 19:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdTd919W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgINTci (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 15:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINTcg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 15:32:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA806C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 12:32:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d189so1053396oig.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klkmiZuflFnynmQu7+bx3xxH+rD82oKvx4CnHuw6du8=;
        b=YdTd919WQh8TI0cn+Uzmz+bFN1nZce8+7WNgw+E1Bs55Nu8L4KOD7+V+KbZvp9xOrz
         ELDXsrHLnZk9UofBpEuiRCmvltjTdLBsggBKvpbieOX/rwnGMNiiD+K9pytP+u9EsSPU
         HS9D3yR7z1JZJPpi+AcmHIl1GUCKe3ZyT8314ZsmE/Mpq8wtWHjrgpdGfOds3sX8S/HL
         oWPsgJNB80+v3L66MICzTl4dOU+SRKSuoHy3+eXTLHZcvtVw39sWJXRCpKC7EkfvYMBh
         j1fOSWoZKMuZmJhoZURfyj2VyGMz28XWeyradUS0dMz3o5ZcmbL+iJHNQnX05KEcRpvH
         OTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klkmiZuflFnynmQu7+bx3xxH+rD82oKvx4CnHuw6du8=;
        b=OxhTS92x85wyhSg5jeN2kEK+21LKQwgvLFTmNs+LXfXHUxFj04A7JWMSwn7N5tPcN/
         ajl248UirPOPa0OPz67gYA0UEfDdNvMsfpZfrhkwLf97Arp+KK001sWI0TEuDqP8WC0Q
         7ha8wIxM5kLl9Ib1WLp2Yb3JiIPysukAvpn+NXHoYRhyYoq6qyym5JsgIBDzGrbBGi4t
         OIIP5h6uzKSEMTOdgXAwNniDViyaj5O16UL4RZ+OMZX+jZx5khuuouvaWYGte6BXFaX9
         LlphEj5N0QxXEpYE8f+MlZTHDqH536asbzhvCbnVCvVfw7HLeH+kdbxoUCoZ3u2e9H8I
         4BSw==
X-Gm-Message-State: AOAM531mLxkhMJxlwQCG8WGjrYEkoVufxjJoPLgsnI1o8UXlyqZMyyxS
        Z+4En8iaj83Zu88ll2G4068VBz25s2XrBvS6iusXBMM7
X-Google-Smtp-Source: ABdhPJyekD3EXYCRh/p+frBYmg/6G54DO69AmFQOp2fEaA/l/IslSMOC12FdZv41ID3/2zqVW2sAG63JwgoIv3aFmD4=
X-Received: by 2002:aca:a9c9:: with SMTP id s192mr626656oie.152.1600111954835;
 Mon, 14 Sep 2020 12:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200829000803.20286-1-tedd.an@intel.com>
In-Reply-To: <20200829000803.20286-1-tedd.an@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Sep 2020 12:32:23 -0700
Message-ID: <CABBYNZ+sz2Gik0EEnA529igypkAYA_G+ZZo8bXh9ThZXOjvO8A@mail.gmail.com>
Subject: Re: [V3 1/3] btp: Update connect event structure
To:     "An, Tedd" <tedd.an@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Aug 28, 2020 at 5:12 PM <tedd.an@intel.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch updates the connect event struct to align withe the btp spec.
>
>  Opcode 0x82 - Device Connected event
>     Controller Index:   <controller id>
>     Event parameters:   Address_Type (1 octet)
>                         Address (6 octets)
>                         Connection Interval (2 octets)
>                         Connection Latency (2 octets)
>                         Supervision Timeout (2 octets)
> ---
>  src/shared/btp.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/shared/btp.h b/src/shared/btp.h
> index f0ac3a1ee..cc71a71df 100644
> --- a/src/shared/btp.h
> +++ b/src/shared/btp.h
> @@ -259,6 +259,9 @@ struct btp_device_found_ev {
>  struct btp_gap_device_connected_ev {
>         uint8_t address_type;
>         bdaddr_t address;
> +       uint16_t connection_interval;
> +       uint16_t connection_latency;
> +       uint16_t supervision_timeout;
>  } __packed;
>
>  #define BTP_EV_GAP_DEVICE_DISCONNECTED         0x83
> --
> 2.25.4
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
