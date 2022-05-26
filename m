Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DADC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 23:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbiEZXq7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiEZXq4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 19:46:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B999C2FA
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 16:46:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so2959730pfh.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 16:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaM0s8TIabPQd858/Jret+EVrh7RGqRo70hnNtP0A2E=;
        b=SSIR6IM2hZSyRWcbbW/ZngW7KeOc5OS2GsVBc4Lgj7KG/VhTOD3DQAnFerk4uAwXZi
         HSWKanQowJT6z9iMDRGCTWJSyKWBvGQmqpDsoZb1tnSZdihrKFOgCxGS718vPMeFNzLa
         dalcVOjlNarevSVts1T2c7Ml8yIwUGCPj9fdvsxHbBxygYMnknUeZJWoMF3xtIDhWqsl
         onxL3KkUUx0AaVyyr4g0ShircwfcFun7xF1XICUYfPwTGGX14HHEoib6wC0H8ywumaYa
         KGsNGiuAiJVCRcdx5jxMQPsNIM4lz38zuCXk2plCbfKQ30Nmvj2jZTZbURUCJ/yYeBNm
         zLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaM0s8TIabPQd858/Jret+EVrh7RGqRo70hnNtP0A2E=;
        b=Jz2iVzKYajB8pLzXgLawa9Hrio1k5NaU4/lfQxkToyGxNGdReYlRQCqWIG+IcQnH5n
         G3kd2qtJ/K9clpkevyXpd5JTtEA8gef0Ylweht9WoDUPmTofl5c8AKJ2qmfgucTLxMYA
         ShCIhFIdsHwHABuT+Q88bucsZ2FuutDZmc2M4JoXu1dTgciZSOUJB3YX7R5w/mouISKI
         xBPfMg5e347HVNWi800g7QtUv+Hv+dhQMGpPAhiOGPSG5LYiLSf+M4JJVGUz7F1fj7Hb
         Hgwl8a25djigdIRfy/JqAwIaVUgtJvjsZdb7PqiOMomm6HOSw/6J+IIuR5EZRKM8b4Z7
         3/xw==
X-Gm-Message-State: AOAM532Xgche+syrk7MxVkdsvsLQZJ+ZU9Kwq6BYdQvv5p1MRIHoMYem
        EGm3QWDHhKqHjQdrnBKNeOuPQo7IEfhS/X+e9WOsktLI
X-Google-Smtp-Source: ABdhPJz3gUU6ds3YChHWDcwWU4XoNF2UzS9W12HisF39ntPvYIVyiPAD63Kj1xRynRteXTgSFdtbghQGnj9JYYpV8ds=
X-Received: by 2002:a65:4685:0:b0:3da:eb4e:61ed with SMTP id
 h5-20020a654685000000b003daeb4e61edmr34188775pgr.591.1653608815526; Thu, 26
 May 2022 16:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
 <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com>
 <20220524142128.01acb75a@hermes.local> <CABBYNZLs-1Pkf=qKwt7t5b6_wxiZiF4Xzr+K2jMFr_WEDpfaQw@mail.gmail.com>
 <CABBYNZ+gQf-YfT5Kiq6GRFsjhyyF7k0vtEc=Zzkc1O-_dExFVg@mail.gmail.com> <BYAPR03MB3701F946C27811EB60E8502F87D99@BYAPR03MB3701.namprd03.prod.outlook.com>
In-Reply-To: <BYAPR03MB3701F946C27811EB60E8502F87D99@BYAPR03MB3701.namprd03.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 May 2022 16:46:44 -0700
Message-ID: <CABBYNZKnA8qfd+V5Wb6GZ65FVnL2mVz2aifZTS6UmeJ5EUKhfQ@mail.gmail.com>
Subject: Re: [PATCH-stable] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
To:     Tom Unbehau <Tom.Unbehau@verifone.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tom,

On Thu, May 26, 2022 at 1:50 PM Tom Unbehau <Tom.Unbehau@verifone.com> wrote:
>
> Sending this mail again due to HTML mails not being allowed.
>
> Hi Luiz,
>
> The patch did not fix my issue. The issue described in the bugzilla ticket was an error
> in the mgmt.c module. I do not see any direct correlation between your patch and the error i am encountering.
> I have tried your patch on mainline (5.18) and got the same strlen bug when executing the example
> program I have attached to the bugzilla ticket.
>
> I think strlen in the mgmt.c module needs to be replaced by strnlen.
> I have attached a patch with these changes to this mail. After applying this patch the
> error could not be reproduced for me.

Well looks like there are multiple places actually using strlen rather
than strnlen with the likes of dev_name and short_name.

> However, I am not sure, if the changes you have made in the eir.c module are also prudent and could fix
> similar issues (I am not familiar with this).
>
> Regards,
> Tom Unbehau



-- 
Luiz Augusto von Dentz
