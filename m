Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4981CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 21:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiFMVT6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiFMVTr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 17:19:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FE3F8A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:02:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h23so7542921ljl.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbcIIk9gfGFD0ZXQuxM4aGGXSleceqbNW+g4AXRk1Mg=;
        b=JUjovLf/ftLomn3CfF8hwtXeuAEnKXyerjN7ti5s00P7eNnfPPNjN5H/FK3XxglMOg
         tGm/YgCJgDtogS3wEqgMiCXKSC71S3kB/J8O0dL7v+Kultlan7YjVs3PDJUqmcSgwYIK
         /NiSWsTMdArTluVIP6XIHUx7+a1wLEE/Z7nQkPBCwwGQW0sFjtj0hA+b6TaB1oPALeOr
         Hr+i0zdL24DqoCAiRn0VYt0u9sb8mNj5VMAQTSLLP0abiTqm4V77HUi5Op2xKy7OqLkB
         BkL+1kLbJw6hy/hDKQEZFiCDp2fphaV5FGw5zjdploZyVam5VHkWZyn4hmD6k5qUTKM5
         b4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbcIIk9gfGFD0ZXQuxM4aGGXSleceqbNW+g4AXRk1Mg=;
        b=hzUEPFTS71aH8cHvWxIvGBcONaVI+lnDAtAZX0lNnmt4lhgtOApvLFx3f4hYLU0MEe
         wjRNU+CIA5hvA2nZv9m+788qbKxTZuNrsFdM3NTS2rEYEXbeu4ylD35J+CkXlYLbsxYu
         iWR4D4xUbx83lhwuvLtcp04vcadANblLSMCzMZ8p/NbHeoJywxo3iY4/uHyTWl6OqBck
         9XB0gGiEWrKsQNtcvEABDc+XEAfjjjc3ihPtWmBiaoCQv+N+BfcLo0u+Tj6MIt4dDKBa
         /8wKto95vMypSqtgxX5dv0pNSXUTrU4p79JpHwkRZHWSvdmMEXO5GD22/heghxwmLvbd
         bcfw==
X-Gm-Message-State: AJIora8QbMxILqKUkcCM74mpXw/gzPKInV72T4LnxTWBe1/+9k5SgGjW
        O47S/V8kN1/zAdycidcwwvhM+A8QcSq2nByj5Vk=
X-Google-Smtp-Source: AGRyM1syqouo58/QMW/d1dfjWFczL2S8Hwa2aZCIpdhC0pkZ0kn65zeMirk6HNinTNjX3/dIQjvJibqOg0FJmiHlSjM=
X-Received: by 2002:a2e:a4c2:0:b0:258:e71c:8693 with SMTP id
 p2-20020a2ea4c2000000b00258e71c8693mr706392ljm.65.1655154161131; Mon, 13 Jun
 2022 14:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220605122927.110627-1-pav@iki.fi> <165514381522.24573.3468564396925092282.git-patchwork-notify@kernel.org>
In-Reply-To: <165514381522.24573.3468564396925092282.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jun 2022 14:02:29 -0700
Message-ID: <CABBYNZ+c0uTY0KfW-p48B1VDViKchQNm87B+eM2gLP1k9X+2LA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] a2dp: disallow multiple SetConfiguration to
 same local SEP
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Jun 13, 2022 at 12:47 PM <patchwork-bot+bluetooth@kernel.org> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Sun,  5 Jun 2022 15:29:26 +0300 you wrote:
> > Using the remote SEP SetConfiguration DBus API, it's possible to make
> > multiple remote endpoints use the same local SEP, if they are endpoints
> > from different connected devices. This is invalid: successful
> > configuration shall prevent a different device configuring the same SEP
> > (AVDTP v1.3 Sec. 5.3).  Moreover, this breaks the assumption in the
> > AVDTP code that each SEP has at most a single stream, and causes
> > misbehavior later on (subsequent transport acquires fail with EPERM).
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,1/2] a2dp: disallow multiple SetConfiguration to same local SEP
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f9d9a9a0b38
>   - [BlueZ,2/2] a2dp: error return paths in a2dp_reconfig must free allocated setup
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c288dd23a3b
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>

Ive ended applying since I'm not sure you would be working on
supporting reusing the same endpoint properly and leaving the code as
is not working properly.



-- 
Luiz Augusto von Dentz
