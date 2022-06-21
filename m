Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F8C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 23:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353748AbiFUXk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 19:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiFUXkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 19:40:55 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3703121A
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 16:40:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a11so8515681ljb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 16:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUD+UjyD/NSD9D/g3plwiCtj21dUlFc91dHWmSM+r7U=;
        b=aEBX6wXE+Eq5LNfh7Mozw5ZI0xV1Gr9rEeuD0PU8zHDk5qDZnFEibS+vPJdOY7kCd9
         RI6HjjPUuUKbSqQvpy6onOg4PTFtfK34GvW6IJkViXWV73IEortCk+yINKEZz10JfP2D
         kkXN7TLb57JkKAcanCAmr0UjW8HMeUAFJWwdX2cV4DrS7QroFOvXVxcktjGWkBNOdYS+
         LI1TVjuNRhXQ3lf5Bsy4DDqUrHnCNoxUbksBSX2luVTgW11aRgAauLktunBI0z8CZVaW
         kuipd6nAGqayJvkpmv813pja+7oOqzIXMQ7Viii+NhK9CGcuujBFwaGpc1HTASG1I9w7
         l/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUD+UjyD/NSD9D/g3plwiCtj21dUlFc91dHWmSM+r7U=;
        b=bxPMOqvS49rfo5dNNdBOmFWjulPI0xdoXRrpAs43f3fsEyI0hKfn/ApnCvQeOMckLA
         nZVnlTwyhEsopUvdSYWPRRFwITyr54F+YFlXEtegQYjbDiypmX6rrTlEbCzE7y7Aqme9
         gukqUdtxq9PjXA6+Yw+Fq16G+hRklrnQWgW/7+ghLlNHaS3HcUwUFEaX2bk4LNWE58pW
         /Nz34PdSgU5Vw8Z+FJAtB1+Mw9nqmSmkYD2VgYYdvC5kB7AiFn26wEpz306cIj8Y07Bg
         Tt1XU2S/4EtCGXD60og6yJrKDcMrDT8/qZVTpEnsJ+GIlcoOYGaG6CjfkjLlrKZnFD/2
         tkNQ==
X-Gm-Message-State: AJIora8JOxyWMcfukwDcVRnnBF/Thlvn4knEoXaVDZ4aaWUIF/JaAu5m
        D4cmOEtSab9melqVa09qB40j/9wqeuPYV8FwVDp5eTmDhkg=
X-Google-Smtp-Source: AGRyM1tOYR+4gItXCCzGmnhlZyWGo28wGMgQZU8SPVOBZlIozxwxOCDjlS0045LMZ6NZftVRcaFXLVsRx015uWtoG4Y=
X-Received: by 2002:a2e:9191:0:b0:25a:8858:f60d with SMTP id
 f17-20020a2e9191000000b0025a8858f60dmr297757ljg.423.1655854852964; Tue, 21
 Jun 2022 16:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755B778B99B396FF0FF6E55FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755B778B99B396FF0FF6E55FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jun 2022 16:40:41 -0700
Message-ID: <CABBYNZL=kGNjpR-E94tuTtU23PYn0d4qyxoDkc-O_EuxS6eZMA@mail.gmail.com>
Subject: Re: Is there an attribute for the name field in bluetoothctl?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Tue, Jun 21, 2022 at 4:05 PM John Klug <John.Klug@multitech.com> wrote:
>
> Gatttool Example:
>
>    [CC:78:AB:7E:87:07][LE]> char-read-uuid 2a00
>    handle: 0x0003   value: 53 65 6e 73 6f 72 54 61 67 20 32 2e 30
>    [CC:78:AB:7E:87:07][LE]> char-read-uuid 00002a00-0000-1000-8000-00805f9b34fb
>    handle: 0x0003   value: 53 65 6e 73 6f 72 54 61 67 20 32 2e 30
>
> From Bluetoothctl:
>
>   [CC2650 SensorTag]# attribute-info 2a00
>   Attribute 2a00 not available
>   [CC2650 SensorTag]# attribute-info 00002a00-0000-1000-8000-00805f9b34fb
>   Attribute 00002a00-0000-1000-8000-00805f9b34fb not available

Certain attributes are controlled by the daemon so they are not
exposed over D-Bus, this is not unique to BlueZ since I remember
saying that on iOS it also don't allow applications to access some
attributes directly.

Anyway the name is actually parsed and you can even see it on your
prompt and you can also give it an alias with set-alias command.

> John Klug



-- 
Luiz Augusto von Dentz
