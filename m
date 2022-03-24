Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E1BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 20:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353233AbiCXUM5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346425AbiCXUM4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 16:12:56 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA5AD137
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 13:11:23 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2d07ae0b1c4so62593437b3.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rLlHUa6mruozhGdNEmCmSWCKfYaQNwMU6nryUSMZZCA=;
        b=N/pNPd6MssvFlQqlgqyzjJTkf4PdebIX9nuZYbKIAqATXRpIx/qgA6hpaP3IQ6sq0J
         INMeSJHmnisZCZxwwt7xjptmOmzTW2vKsSrIA0v/Sqg1TlbIU+4Zo4QQF8tqzRpWibSL
         falFjs0c4nz2HPjSY/qokbYF9gwGwQQFDUkF5WeDGDkXkdXSjkfCtLjzPwVXVvHbLnyI
         nsEMP4XYvPpFDYMZwC/0SkpoPvUgI64PBQAPOAP1MKA+KOlyDrE8XTWCyd1t01DJSaVI
         2bheOcifE4uB7fZPhgVRJxJOukKoX1LrBOxbFXqIxg4pRZSzc+5OX5X+BXwZxM8ps/Yw
         sKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rLlHUa6mruozhGdNEmCmSWCKfYaQNwMU6nryUSMZZCA=;
        b=6EAorSb7Ck9SuX4ubFOlc011ZAItc9oZG8zpFkz/0gRhCpN97sfxOefwUAKfWxX3vS
         mKVQa/SNW7qEvVYn/zzBv5EYiI18H1ZLV07RoSo6VH5PhcmW6pkSzUhFf5RjljV8WF3Z
         lcPUPZhixKOWACRsDTB7D5kzV91NIbG+NOIyv/314pr5kQN8/p2ecsUy9zp059ZG78sA
         QqtshxcQYUJO1MjNA5OQP1j0u+7mNiQ9ZFFLiZLMsKjol8hd6Lj3c2YUVxxIPRZH0m12
         7CrF417W16KjyA1jUnMDXNkqmGXVmKV0kV1d6ZA2u+01+cDxjNCjHflfUIEfTI6DoCgw
         2uBA==
X-Gm-Message-State: AOAM532EERcq0qzRsF2OUxMHH7RXr0sA6mJxvqqAnKc9HOOwjcKaN7rs
        7yyVYMrPUufkh2qKlqKH3lm9cyuUrBAgDR3G5DUrdKwT
X-Google-Smtp-Source: ABdhPJymGMZiAMihiDPEVHFG4MFG3TkqreuxIauDLyFTkIZaiefRGNike/1/qjB/yBZM05eNSfJln3YhGYwk93zUyfo=
X-Received: by 2002:a0d:dd8f:0:b0:2e5:b961:4098 with SMTP id
 g137-20020a0ddd8f000000b002e5b9614098mr6672488ywe.233.1648152682729; Thu, 24
 Mar 2022 13:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220323224003.3736525-2-luiz.dentz@gmail.com> <623bafb0.1c69fb81.caf17.82f9@mx.google.com>
In-Reply-To: <623bafb0.1c69fb81.caf17.82f9@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Mar 2022 13:11:11 -0700
Message-ID: <CABBYNZKGgcMPSrnwrm_i6wDRzc2C5ogsR2xurzAn8ec=DL+bNg@mail.gmail.com>
Subject: Re: [BlueZ,v4,1/9] log: Don't log __FILE__ and __func__ with DBG_IDX
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Mar 23, 2022 at 4:39 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625873
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.36 seconds
> GitLint                       PASS      0.96 seconds
> Prep - Setup ELL              PASS      42.81 seconds
> Build - Prep                  PASS      0.72 seconds
> Build - Configure             PASS      8.56 seconds
> Build - Make                  PASS      1291.43 seconds
> Make Check                    PASS      11.92 seconds
> Make Check w/Valgrind         PASS      440.83 seconds
> Make Distcheck                PASS      226.74 seconds
> Build w/ext ELL - Configure   PASS      8.66 seconds
> Build w/ext ELL - Make        PASS      1251.70 seconds
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
