Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76219C49EA6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA7613B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhFXUP1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhFXUP0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 16:15:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD3C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 13:13:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s129so1121255ybf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7V0Dh9pI1Q+r/yo42CJo946ge2GWiuhccIkM5LYG58=;
        b=ZmU2urSuX53mOuKsNkW2AHcZkbgcChO86mXCebjuV6b4gzU01R8t7LqjGg6aw0H9kj
         +dyHy0xzRWZ+OAK9duwEwMRUu+22A6TFEjetXasgAfJMqd+wARtu2uRvGg5a7B9EFGAk
         0ew4lXyWetVzH+bADP1+YwNcr9mwmQmo/Aa+yHTayPBb5FQ1F6F9gIRKdYZFTIks89Jk
         hqv1vd5Bcdkh9r1KyRNJ88FGDzmLxWrCNMcK8W57Taagz4Duv7GoiQb9hw06pli0LCF3
         V5x3Sm0NaqjASHqeTr7sFvPAVkxi03dzxOIp8C6qAe1OIX/YkBatpQJsxkX9AOBeDlZW
         AyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7V0Dh9pI1Q+r/yo42CJo946ge2GWiuhccIkM5LYG58=;
        b=Ng4TjqPozi+PNLeNKDk5BTW5mG8PfaACGZT6Rm1CRSM2k0EJIVpgjFQqDCmeP9Bcdq
         9Kmkc3ruOt7jQCgzvpU0terzcWoYIZbPKXyC7RkuwTY8QTgzHXu7ObYwSHfnxH/3bNYi
         GmjL/CAQLFrHywZJSS66x5mu9yPLkVtNl/CqqM3mljwYJRwsy/0fdFWGhx+BL+2D12x9
         6luArlRB5leONNMmPCqDfrL7ejrmxa4nGkyAJZy9ySl8Yu8zcIsESYcQvojdzKCkHtb/
         +mq1KOkOudqA/49kSiy36yaEwq3rjvtdgJMSX0Bc9b2SZ73Mkf+olGg3rI6atO5dCkOW
         7sBg==
X-Gm-Message-State: AOAM533e+ty7LEItP3ZPuvwezQUwmCPwDmFtP68BRaiZhYJDh4/j6bvO
        RTys5Sk1VEE9sVdYxq1F4Unb6AlEWTOAVenPlPI=
X-Google-Smtp-Source: ABdhPJwQ1C01Fd608yAvIHP9gFJyKPgvA4tDC4E6GomYPBe3OCXFMqRRgcUXfgDOfDs6orKOPfb5Hj1v2E1U5XqK7Wg=
X-Received: by 2002:a25:e80f:: with SMTP id k15mr7245653ybd.432.1624565586603;
 Thu, 24 Jun 2021 13:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210617215758.BlueZ.v1.1.Iaf42bf6ccbc1a06a9fb7f8da55bf7f2ef37349f2@changeid>
 <CAGPPCLCCvnsbgF9x4dFMDq+ZCr5KZ-+-NuSu++8NpFDCM8iiMA@mail.gmail.com>
In-Reply-To: <CAGPPCLCCvnsbgF9x4dFMDq+ZCr5KZ-+-NuSu++8NpFDCM8iiMA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Jun 2021 13:12:55 -0700
Message-ID: <CABBYNZ+aN7+M7Tk36MJewcNMwaTdjBMKuz1LX-Q9J-a864XTAQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adv_monitor: Avoid skipping non-discoverable dev
 on Monitor match
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@google.com>,
        Alain Michaud <alainmichaud@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Thu, Jun 24, 2021 at 10:10 AM Manish Mandlik <mmandlik@google.com> wrote:
>
> Friendly reminder to review this patch.
>
> Regards,
> Manish.
>
>
> On Thu, Jun 17, 2021 at 9:58 PM Manish Mandlik <mmandlik@google.com> wrote:
>>
>> Do no skip a non-discoverable device if it matches any Advertisement
>> Monitor.
>>
>> Reviewed-by: mcchou@google.com
>> Reviewed-by: alainmichaud@google.com
>> Signed-off-by: Manish Mandlik <mmandlik@google.com>
>> ---
>>
>>  src/adapter.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 98fc78f1e..2175120f4 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -6656,7 +6656,7 @@ static void update_found_devices(struct btd_adapter *adapter,
>>
>>         dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
>>         if (!dev) {
>> -               if (!discoverable) {
>> +               if (!discoverable && !matched_monitors) {
>>                         eir_data_free(&eir_data);
>>                         return;
>>                 }
>> --
>> 2.32.0.288.g62a8d224e6-goog
>>

Applied, thanks.

-- 
Luiz Augusto von Dentz
