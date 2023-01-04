Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659CC3DA7D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 00:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbjADA05 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Jan 2023 19:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjADA0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Jan 2023 19:26:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96E41705F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 16:26:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bq39so40398140lfb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jan 2023 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gdrGstZF3psu54q04ekSD2mwgEIBYlZ0VjpdX/8+fTk=;
        b=om7UjQKA1ib5S6Zr5CIJWclYBRwiC0/+38EXhNuF3uJUZqQGo3K5LpYQAlL/2a3ci2
         5rgXxWkozXR0zrKiSwtlWk97T3/yTOLFkOYehKW3kOpuqlGMnI5eaB9mevopJAuX0T2u
         j2exCrDbBUSRIGyKjRu5r6YWdIO7RVC36BhG5BSkqD+31RLru22lMYHXHEesJSPnuMtr
         6PZWwQViR1JlwYwNMhZw5sqmNjpE56U38bfCX/IbQ8SmtX1mLwK6Bq/NcDFcpS3ZFR2e
         q0OWicVaIaOq73LDXzm6M9c2m7/0cS9bPkgWFU69ub52C9MO7b0h7RY7DGblc//oHhcZ
         MzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdrGstZF3psu54q04ekSD2mwgEIBYlZ0VjpdX/8+fTk=;
        b=Uigt02bbvoOaTcO6glVegs1oIyoTwMAemMMGTvqW0RVrbW6vunCsmtQEVBit0P0sw5
         w25i1ydsFp44ffghL9yyjcbritG7TQNOwq5uA0cMU6EG9bhSRWVoylmQe7c+X9FQtaiG
         yPJ2GrWz9PriMofEhLc7uwAq3kqMU6urw+7yw/ohfYIvXebCg39HN64W8PV65hQL3I3d
         ILtpiD+Gl+pp0yn+kp2EcyaLKq7QxxuIi135LQZ5pnaa+Kj1DV1tH9+CmQ1/7AAWA/RN
         rrwTzQj5q8fVEPF2U1RmuAjTovgXCg0/ZwOTnJ4Q3bCHsU31hAg8QVsPx0OiWUnHU2w9
         +9bw==
X-Gm-Message-State: AFqh2kqN8t8ehb8u2jBZkEA+1GI0cSEEV87V785qKDtoKb5gGGtYCkJV
        /TbN9Fo5axeqYr46oimtyWJ03nSgLoxPWhtIkPDqPHq+
X-Google-Smtp-Source: AMrXdXuFM32qjLY2SfgRhMozefmQE8xMB4euQ/LTObVMSuYLcSxmr/0sud4Wr0xklo3VVUsMa4nIS5zg2ddUQEYJCsc=
X-Received: by 2002:ac2:5588:0:b0:4cb:33a:9386 with SMTP id
 v8-20020ac25588000000b004cb033a9386mr3084819lfg.198.1672791983126; Tue, 03
 Jan 2023 16:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com> <20221229155257.341327-5-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221229155257.341327-5-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 3 Jan 2023 16:26:11 -0800
Message-ID: <CABBYNZ+Ny-0a2xkRp=-ND_kLHGNu6bKrpsSYBb4Ba5SGbgvvYA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/6] media-api: Add CompanyID, VendorCodecID, Metadata
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, Abhay Maheta <mabhay125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Thu, Dec 29, 2022 at 7:58 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> This adds CompanyID, VendorCodecID, Metadata for RegisterEndpoint method
> ---
>  doc/media-api.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index 847f8bee7..7bfa8a52b 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -34,11 +34,29 @@ Methods             void RegisterEndpoint(object endpoint, dict properties)
>                                         match the profile specification which
>                                         is indicated by the UUID.
>
> +                               uint16_t CompanyID [BAP only]:
> +
> +                                       Assigned number of Company ID that the
> +                                       endpoint implements. It should be set to
> +                                       appropriate value when Vendor Specific
> +                                       Codec is used.
> +
> +                               uint16_t VendorCodecID [BAP only]:
> +
> +                                       Vendor-specific codec ID that the endpoint
> +                                       implements. It should be set to appropriate
> +                                       value when Vendor Specific Codec is used.
> +

Check the version Ive pushed, I end up merging these 2 into a single
property called Vendor which is a tuple of Company ID, Vendor Codec
ID, so you will need to adjust the changes to bluetoothctl.

>                                 array{byte} Capabilities:
>
>                                         Capabilities blob, it is used as it is
>                                         so the size and byte order must match.
>
> +                               array{byte} Metadata [BAP only]:
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
