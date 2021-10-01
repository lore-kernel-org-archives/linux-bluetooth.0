Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3232CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 18:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A0861ABE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 18:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355474AbhJASDD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355611AbhJASDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 14:03:03 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97476C061775
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Oct 2021 11:01:18 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id g15so4787696vke.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Oct 2021 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf1WwQIhnsDypuFvYqxkOy8qckLm01xWnZ81vQq4G7w=;
        b=SKzOGYI8s64Fz0p8Q49X6/PDpxHyDYHdfve5u9kSZ06QLN+J4TZL49mhgkroK7PMSA
         5kJxTyBmI52Y806JZZzkkH4vNAmdjht9fzUJGKMLFxdK6J5APJbeWB+eNjfkFKg50IWP
         ljcg78+P7VQuDRGSW0Kp+avN/MDSyAYDKg5GsoZDeSvnOjQI3WqqiyN3ZTHLaVMbGmOW
         Cbfrh4JDE820ku7RKJRyZqsyNOX7b417hCrzsSeyf7W23kEB0rNHFNI4zP4lBRWZkir7
         H/Gu9x71sPp5ZjHqyQvwnyexO8CObm+XE/57soI8MwbR+2Ztj+dHHdv92VSknwUg2iuR
         nFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf1WwQIhnsDypuFvYqxkOy8qckLm01xWnZ81vQq4G7w=;
        b=S7tLivDb9HdFvVDeftsz7MPAwtW26sHWIYFQOLyxn89/IurxT+mHZce9IokMd8CajP
         K1kqlpIFK6puVJUJKw9r4ey5g/Vi3IPWuw6eZtTG1Sqqh7miAUTIZsVmDLhrJ0FliCbg
         wu8tJYRzUpXMTIOqqtu0KbqpeHRMHh92OSR//hk5A9jhjaT35l50p2CxEtaLYTFQcMmk
         LvZqiHd6qVQR9+fCXmyDHdEsXCRqqDlY2MGIQ1q7pRJhoDF7fz1qGRcsJLl58H+mMuP6
         KknP4T5CbAO/BA1EymNWIidgujU1MNeDvIfpTtkAJAlqMdR5CsU2lfEH7ymJ7+rx+vFW
         fkWw==
X-Gm-Message-State: AOAM531O5LDuDtBou7bfC0aV7/VDkoBdMezeUhPA2CWTEFT3ZGSF73IN
        BkwjwF3DKffsjOMZqNDRUqM2uf3+1QF/XWdN0oc3aNH5
X-Google-Smtp-Source: ABdhPJzYrKqGQaPTG7ApGsWxyIruTjBugDK2BMnd/Tjoq9u90XaDsPhqioWePMangf+o8kowSAr6Y/BOcyyAwGP8wHA=
X-Received: by 2002:a1f:d782:: with SMTP id o124mr8545771vkg.6.1633111277634;
 Fri, 01 Oct 2021 11:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211001141719.180087-1-dmartinez@starry.com>
In-Reply-To: <20211001141719.180087-1-dmartinez@starry.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 Oct 2021 11:01:06 -0700
Message-ID: <CABBYNZ+_EXbqi5FzOTLsyC5D6C6DR106C7NdOkhj6CoAybdUpg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 0/2] Optionally require security for notify/indicate
To:     Dagan Martinez <dmartinez@starry.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dagan,

On Fri, Oct 1, 2021 at 7:19 AM Dagan Martinez <dmartinez@starry.com> wrote:
>
> In some cases, it is desirable to require encryption and/or
> authentication for server-initiated updates, as they may contain
> sensitive data.
>
> Currently, there is no way to do this with BlueZ.
>
> Here is a query about this feature from 2019:
> https://stackoverflow.com/questions/55884233
>
> This patch implements this feature by introducing new `x-notify` and
> `x-indicate` flags that allow a user to restrict access to a
> characteristic's CCCD (as well as documentation for those flags).
>
> Note that `x-notify` and `x-indicate` each enforce security for ALL
> server-initiated updates. That is, you cannot require one level of
> security for notifications and another security level for indications on
> the same CCCD. I could not think of a reason why somebody would want
> that feature, and did not think the accuracy of terms would be worth the
> introduced complexity, so I didn't implement it.
>
> ---
> Changes in v4:
> - Directly set flags on CCCD instead of having new intermediate
>     permissions
>
> Changes in v3:
> - Split the `x-asynchronous` flags into `x-notify` and `x-indicate`
> - Fix a mixed code and declaration error
>
> Changes in v2:
> - Fix line-width issues brought up by CI
>
> Dagan Martinez (2):
>   gatt: Allow GATT server to dicate CCC permissions
>   doc/gatt-api: Add 'X-notify`/`X-indicate`
>
>  doc/gatt-api.txt    | 15 ++++++++++++-
>  src/gatt-database.c | 52 ++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 56 insertions(+), 11 deletions(-)
>
> --
> 2.31.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
