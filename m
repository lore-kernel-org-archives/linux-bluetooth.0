Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD246FA3741
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 20:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJaU5w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJaU5u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 16:57:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094FF12762
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:57:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u2so18265416ljl.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nv+um2iHootXO2ohoNURrDQrq8avbiRP9ra/LyIjPj8=;
        b=EhPLOh/DhuuH/nSHEn0t1orfBVqYL9hoiDnEiUrDJmNuKI1UduqzXOHFGsZunrv4za
         mNkaa2jfPCdRcxw5u4bWEMKc+4C0mmNq5Oofcb+d1wpDZ0twxc74djNN8jtoGFj19pta
         eHQ/ANm4HpQw4mt0yQ41DdIPT6yhwPtSjRRyG7zAsolwi2cjC6VcWA+/Cm9hmglvyzTg
         ne/fjApyo8ER7JDayBp3N+Jlkpu/5TkdqoE7PdePaLRm87bH/f7xVzp+2JgZulJY8mCO
         UXLVnywhdqkGuB2ung+itkB75Mp6GTFYTNJFoCU0ddQGd0W6crJG2UQQ2sLE7xnD+eok
         GsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nv+um2iHootXO2ohoNURrDQrq8avbiRP9ra/LyIjPj8=;
        b=Xhru3w5B1YIb573PfwO9SuNi4cNdmMs3Cn2AhsKQijEzJkfIreOqPWCYCNbRUhgfuy
         lj9NKU69iH1NVLX3z+YfE4n5+pPHnPkXVxzU7CUzysMwkFvfKiJFF5spUIJVaWR0rMCX
         5l8TDFYBD9S1A029Vanh63YAv0W1Dq+brhvm8bstvYrA6IWSgFYUZABEcpUAnimMX45Y
         3TgHvZsPxSHl7SqvPA3T714r/br5nbnDFw9UXjK7OTKMO1DUSN5nWJxQvZQXoWP2p90Z
         FveeipfU6xyhdYmnz7VQiFy0b6Dl8R5Un081bXMrdhU0FwBulxmM3NBaOsGsTY+FyckE
         +Egg==
X-Gm-Message-State: ACrzQf1Il+uH/7oYoDiKTiyIo/BgXURglt6KYMj2Y3KCRadL+ufbgOij
        VCTEcvSSB40rOuQOljR0MMksCe+EbeQbpBwWUdDaMXY1KNI=
X-Google-Smtp-Source: AMsMyM63RPWe7kk6TGFn/bH11f9CoYroliRjnVnb0biRaGLxhFjnmNx59KOInfw0zEArdkF68zzer5BwegsEuxNPiJQ=
X-Received: by 2002:a2e:9208:0:b0:277:46da:16d2 with SMTP id
 k8-20020a2e9208000000b0027746da16d2mr4819756ljg.161.1667249867312; Mon, 31
 Oct 2022 13:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com> <20221029170408.175533-5-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221029170408.175533-5-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Oct 2022 13:57:35 -0700
Message-ID: <CABBYNZ+vgDyaAw9oLZpSMs8NXyrttLD7g7AzBYs8pedDRkQRDQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] media-api: Add CompanyID, VendorCodecID, Metadata
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Sat, Oct 29, 2022 at 9:54 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
>
> This adds CompanyID, VendorCodecID, Metadata for RegisterEndpoint method
> ---
>  doc/media-api.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index 847f8bee7..ce2b74e53 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -34,11 +34,29 @@ Methods             void RegisterEndpoint(object endpoint, dict properties)
>                                         match the profile specification which
>                                         is indicated by the UUID.
>
> +                               uint16_t CompanyID:
> +
> +                                       Assigned number of Company ID that the
> +                                       endpoint implements. It should be set to
> +                                       appropriate value when Vendor Specific
> +                                       Codec is used.
> +
> +                               uint16_t VendorCodecID:
> +
> +                                       Vendor-specific codec ID that the endpoint
> +                                       implements. It should be set to appropriate
> +                                       value when Vendor Specific Codec is used.

I think we can be a less confusing with respect to CodecID, so instead
of using the special 0xff to determine the endpoint is registering a
vendor codec we can use the CompanyID directly, so if it is present
(D-Bus property exists) then codec ID is used a vid and the codec id
is set to 0x0ff.

We also need to document if CompanyID is BAP only or not, afaik for
A2DP we do have this information prepended into the Capabilities, but
I think adding the CompanyID is better so I wouldn't oppose adding
support for it also in A2DP.

>                                 array{byte} Capabilities:
>
>                                         Capabilities blob, it is used as it is
>                                         so the size and byte order must match.
>
> +                               array{byte} Metadata:
> +
> +                                       Metadata blob, it is used as it is
> +                                       so the size and byte order must match.
> +
>                         Possible Errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.NotSupported - emitted
>                                          when interface for the end-point is
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
