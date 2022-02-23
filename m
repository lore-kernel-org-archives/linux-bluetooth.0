Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D5BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Feb 2022 01:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiBWBvR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 20:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBWBvQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 20:51:16 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF654181
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 17:50:50 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p19so44944580ybc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 17:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vAFnf59NUMGbnfylN1Si4hCPWuQpFgXI4MnZW1deHnA=;
        b=m5nHAVdFDXBRxATpYLo+dBpa5Pb/AnTC+IQ8WMfeAv9feUnHk4MEKzTvvfrDjQSiF8
         3E6c3JtirZN6+FVP/XdTEJHEQFD5G3tpnwNq9jnPtat5rmi7dp7Dyd16mZtmX7bqmBnG
         hKbVE/Qbekj6Z+/5WFdf4Z/DA33NiEhs471YJzYgLDiiC7EUbWIxrIjgCXAPBRptzUXq
         go7ilooGYHnfcYLxWJuuJTuL0uznJlb0vBotHHEeo0SDzzrF2OyWE/0H1qrKGJsw5+aT
         QBvvWCUrR5tUmwiSl6NQk9EJoSomIh7FokWN05zRmrF5r1Ei/qTpHOH5qAsgk9OUNxti
         Q/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vAFnf59NUMGbnfylN1Si4hCPWuQpFgXI4MnZW1deHnA=;
        b=pzTP/z9N+30rjgPNSKJTWJp5KwpZEanSHF70yyIoJq2MeIY0hxlHwVyv5G6VWprg17
         nHCQ3ZrIW2NXZsDhb1iVYtQs10lGtkwiAv7AXJcE9nttAqg7PmEnbT3oOl+Ov8kaK8R1
         yU0zBhiYcX2bXWG4hd9lNW73a3P439hK8B6+/kSfg6swQHSitCXY19OSGbkh26yPPiD4
         YgCfBuRB2eypc48FERywo86naKazG7tFe68p/SCt1Re2ZXgZMXqcCRpLMcwwenjA97w6
         6dfi0sqzrJQvVmayZakWlTEmPl9EaIWGp63Hb5ZJB/mab8R/YPRqr/g4qpn/qKnd3PKq
         Y6kQ==
X-Gm-Message-State: AOAM5302ALvtl5Z7n1404lI3zb1EMN8HxNqRZhgJqIlb0oBEB7UVZ0Rk
        ZnDt+gFg6rUjJXXBIzl8A/1QiAYl+yl/vTIBeoFhbJti
X-Google-Smtp-Source: ABdhPJyd5rznwlEoyfGjWLYne4+xVVKZUNAweSKkTOh7sv4Rb9b75GNF5BLOijZUlxFNx5OJgOGZToirSB7IOxDcIxQ=
X-Received: by 2002:a25:55:0:b0:61a:4d80:55ce with SMTP id 82-20020a250055000000b0061a4d8055cemr25728599yba.41.1645581049060;
 Tue, 22 Feb 2022 17:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20220222193855.301757-1-luiz.dentz@gmail.com> <621557f3.1c69fb81.41410.1fff@mx.google.com>
In-Reply-To: <621557f3.1c69fb81.41410.1fff@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Feb 2022 17:50:37 -0800
Message-ID: <CABBYNZ+SKrmPusXfOkhVL1d+1pVGdxfZfE4OtVoz4Js1-pycnQ@mail.gmail.com>
Subject: Re: [v4,BlueZ] player: Fix Track being emitted with empty metadata
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 1:39 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=616863
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.70 seconds
> GitLint                       PASS      0.38 seconds
> Prep - Setup ELL              PASS      50.46 seconds
> Build - Prep                  PASS      0.61 seconds
> Build - Configure             PASS      9.83 seconds
> Build - Make                  PASS      1752.78 seconds
> Make Check                    PASS      12.36 seconds
> Make Check w/Valgrind         PASS      533.80 seconds
> Make Distcheck                PASS      276.34 seconds
> Build w/ext ELL - Configure   PASS      10.04 seconds
> Build w/ext ELL - Make        PASS      1725.46 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed.

-- 
Luiz Augusto von Dentz
