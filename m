Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D10C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbiBOVpO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:45:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiBOVpO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 16:45:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AB9B3E4C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 13:45:03 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y129so154156ybe.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 13:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=czs/J9RaI+qJ+N+soY6GSVtJL6AV1C9DbecgxRXsAj8=;
        b=NcN2Sc3QvByraC3CB5Hx/IuOwg2yNZmOtPh745yq5D9oiVnkDZNTs6kf3kta3uQHl9
         zbjkYOJTaUJ886dUUXyE+XMNnI8BFcuNUdhWwI9dMvA3XgFebGxYPDKxwUSAHxEvAy6h
         OsDrpkS1yC0BoNMN1ShnoT8/xn4ony+B5MC0IK6nVYSSgxpVZSaUyFBW0G0ePRSWmry3
         FzSa3AlwH5/9U9XMJMUbifxnePfxrYqfV0nycdW1/l+2dkzR0w3AACxZR1c2GlM6GZxw
         Xr8Xik26N6/6cmhoISDJbR7b38OBuTgBCKn954wUFa6b+HasoMGBP0sJHTIb7w5g9Fm6
         LRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=czs/J9RaI+qJ+N+soY6GSVtJL6AV1C9DbecgxRXsAj8=;
        b=QlT0pGRJPklGnwKsMv0ULFS58qf5H60gdeAUWUp34ZSSb716lXyLiYk1+8vH/vvw3h
         3Daaa1aCWgJpZcIQViF7pg6E74YUpKhFTzKsYU8cH1Y2TPx0ZsVlRL0FmfmGomx2wM+G
         JVmXFXdanclRzZSXQnkjf72nCiQ/O/GVr8V1PHoe3Ba+ODZagInoWrjYfdUneDsahUBC
         JPdC+16QpnprtNELk3yZF12DPRqh4zOmrHy3aG8B5pg99vh7Tew2sKi4aHW9L86LLJIh
         YX/ZCj0fX0VZ0Sp6PHlq2LepWMXRRZlMdOJdc317/kiIgGl3XCAejlN2QBhKjfvoCBbZ
         pY8A==
X-Gm-Message-State: AOAM530AOeIoonrXZa+ovBKqpKwgHVZw2iLLOkTjo7Vzq6bH8EhlyUyS
        8NNGbv5FYoxVbP4LCYlyJNCyQKwI0nwokUzJjYe4+6BaKEg=
X-Google-Smtp-Source: ABdhPJzdExG2tE7ACUAoezvdiPOWK6mFYvUoe0tkyORxDUxLSUjY7fCbWDbe0AcoS9mdDJrjW/+LuxHZsRT/VBqv9Ao=
X-Received: by 2002:a25:508b:: with SMTP id e133mr865864ybb.293.1644961502779;
 Tue, 15 Feb 2022 13:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20220215015136.1948793-1-luiz.dentz@gmail.com> <620b1b7c.1c69fb81.6c718.cf49@mx.google.com>
In-Reply-To: <620b1b7c.1c69fb81.6c718.cf49@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Feb 2022 13:44:52 -0800
Message-ID: <CABBYNZ+H6eop0MbewQtii+hogXBY4i7_27AxvXbYB7R9=5NWcg@mail.gmail.com>
Subject: Re: [BlueZ] rfcomm-tester: Increase amount of data from 8k to 32k
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Feb 14, 2022 at 7:18 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614322
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.46 seconds
> GitLint                       PASS      0.98 seconds
> Prep - Setup ELL              PASS      41.39 seconds
> Build - Prep                  PASS      0.69 seconds
> Build - Configure             PASS      8.35 seconds
> Build - Make                  PASS      1247.51 seconds
> Make Check                    PASS      11.71 seconds
> Make Check w/Valgrind         PASS      434.73 seconds
> Make Distcheck                PASS      223.30 seconds
> Build w/ext ELL - Configure   PASS      8.39 seconds
> Build w/ext ELL - Make        PASS      1234.66 seconds
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
