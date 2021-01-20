Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDAC43142
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4512360D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbhATWez (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jan 2021 17:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbhATWHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jan 2021 17:07:51 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF2C0613C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 14:07:11 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id x71so10945148oia.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c+NgzyMq2Ii5kUOhahZpRstWFfTJ+eL264mJgOSdQKU=;
        b=PkOqpJTCUrjJlrLwIJQVudSUwkxh198V/EiQ5oTKtJLnFr5JtUHgZKUYObxbd686fq
         LzT4AetuO9+ensai9TenH/AVgV6uxBXdOvJrlN16BAsfQx6fZq57JDB3TVWV+rjJbzpN
         04VVjckfI5nelAOOGqoFhP+qwLOlYXaxXVvyrN7QIDopg2NjpVS+XB2Q+O7cBpOyuiB6
         HD2hvtEGYqUmUF0QYeMwbTu7wgfX9rtNi67L+w22Vj9SOfPz/+hynAG4rAuccK9b5gSy
         lXPKIMI4BpRVetB9qhMAxpDfPD9N6ISkEwnF8YK97esoKzj5BaLHLbvgSaoBkkFAFhf7
         Ox6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c+NgzyMq2Ii5kUOhahZpRstWFfTJ+eL264mJgOSdQKU=;
        b=nWYZwXTY3zHnjM+vrNre0iM/7AqzGO4xOtAZH3UoJVtewhx98rW6ggxdrWmUXlx/CI
         IT5BXmpfhk8hhoYF9rLnE+I3cUF3J0P0Oiy7Re91tR4xmPCxsaNIrY1xkgqx4M3+tWpU
         lW7/ujE2LGRTFE5kFdGWGCPobeEYf/afQmu28e3hJmevfsPD3kCiRwRceqpcgr3aDdXm
         PuLLGo7v586H+2h4LD3qbI2fjIUeqRYE0PQuDDjBVNGeJoHneK9tpEZ6H4Wtzf3f6yu+
         g9Q80PtesnlNI67gouYTUNz9DfSxas5fYNGjOHK/ewGizeB96jHlX7fxGNiUU4/0EKvI
         hrRA==
X-Gm-Message-State: AOAM532ug/FKDmRzg+cf9rjhIWJp2B/SV7sx3v17lC9n9HmvO1d+iCgR
        seVw48K5viW4CCBpAH1e2d8OvoXo2Qgl8zjUzlN45zGFHeY=
X-Google-Smtp-Source: ABdhPJwfcvBKstQrtx7Eu/q4s75p3i5OgsrTot5An4A+B0UIOUdy4MJ3vzO2KokQ/8PEmj0ykkxfmQ5hXsGxhi76kJU=
X-Received: by 2002:aca:fd0d:: with SMTP id b13mr4153282oii.64.1611180430562;
 Wed, 20 Jan 2021 14:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20210119193512.821918-1-luiz.dentz@gmail.com> <600740c1.1c69fb81.b7d5d.524e@mx.google.com>
In-Reply-To: <600740c1.1c69fb81.b7d5d.524e@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 20 Jan 2021 14:06:59 -0800
Message-ID: <CABBYNZL9LBdRnOGR9TsAGLzUAFf40ydKaiab=7bGBKqV=kzmjQ@mail.gmail.com>
Subject: Re: [BlueZ] gatt: Fix crash when a device is removed
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jan 19, 2021 at 12:27 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=417643
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
