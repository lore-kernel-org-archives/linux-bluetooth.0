Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42313C5AC75
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 23:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiAYXTB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiAYXTA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 18:19:00 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A733DC06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:19:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id k17so11036664ybk.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xwsx0Wn2ij+9OgFqc3wCI6Rj5prDrGXEzA8YW/ProsY=;
        b=p9JjQCM5JrYKbc96bDZtBWM9EUTtfcWUYITctMOZYO7Uv4fyJxLOFGHo96cGs7C6VS
         QCFs1rZjGnf7G2slkeXeN6ljWG2kcfMUGWvxr41lRp53OCTk5hnFwIs31GztpbxYlFKM
         zYczSeRQZ/M+qKZsF5hAhNLHeCempB3vv9XzZmF9+0k8NP/aduiBO6sWnmXGa00NZr2k
         H1EDSfb1ca/iwIrLtI/ZsE9NvdpGLhIcqMyJqed1m5fo9ANxsW9EuluYFwGs32dcYEu1
         IiPlSkvyWK6UVVIPlojiRfHYvuyoEMWgjv5K9iynoKjTdEPE33Uqcv/SIvB2/UsiBTHC
         SoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xwsx0Wn2ij+9OgFqc3wCI6Rj5prDrGXEzA8YW/ProsY=;
        b=t8O2RotT0aMAJzNRuDQmkH8PMj64CYgzs0hLtSxaUP0tyUiTknxahCJ47TAvLIqULD
         35gLRmb3z/AzDUtmZdgXaOzuwIBfD9Go6+28A7ZW+Id8eUX25z7KkDq6tzrAjAj+HUZy
         XfT1YCP96kOGB/2QQeJIgukXEGmGioGCJUAJog91oOCZUCVhcye/+IeAvyW5/ka37Rdi
         Aw1XHvatICXbTgBZmGZSSGWxn5OXqma0dkoX2cCIk+sDiN71r0XWrLOQEP7MeWDfNBWI
         yiOz/dX8DXWbVTtOQ5NJNLUIRFetpuqG++XqlOVQpRoD1z0NvIFYEAvkKOUq+0qgCLx7
         r9sg==
X-Gm-Message-State: AOAM533/AZ0H1Bw9gcO5ZXgot1NriVELbDt5M2GC6mX5FTalfLqPa53O
        KIo/TJ1zwfpzDiCxE8ecjvwyR3S/I4QVfkDfWK2ScfDrh8Y=
X-Google-Smtp-Source: ABdhPJwI48YeqgMU9+3heT1qkANWdPML41VMplumLayTBb8rcxKIoZc0vtiDHFmMByE/cDnpgK1viFyb5cJ3ra7O1SE=
X-Received: by 2002:a5b:14a:: with SMTP id c10mr31234017ybp.752.1643152739721;
 Tue, 25 Jan 2022 15:18:59 -0800 (PST)
MIME-Version: 1.0
References: <YfAdnWn21MEHnwot@beta.private.mielke.cc>
In-Reply-To: <YfAdnWn21MEHnwot@beta.private.mielke.cc>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Jan 2022 15:18:49 -0800
Message-ID: <CABBYNZJEB7-m38wktA4iK-HAy=9JLU9a7Y66MqXe6XEQwUx03Q@mail.gmail.com>
Subject: Re: bluetoothctl set-alias - how to select the device
To:     Dave Mielke <Dave@mielke.cc>
Cc:     Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dave,

On Tue, Jan 25, 2022 at 2:55 PM Dave Mielke <Dave@mielke.cc> wrote:
>
> Hi:
>
> It isn't clear to me how bluetoothctl set-alias decides which device to r=
ename. From a bit of a look at the code, it seemed like it might be the mos=
t recent connect, but that proved to be an incorrect conclusion. In the sam=
e way that select can be used to pick the active controller, is there a way=
 to explicitly pick the active device?

It only works while connected currently, we could in theory extend the
command to have an optional 2 parameter so one can enter an address.

> --
> I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
> Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
> EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
> Phone: +1 613 726 0014 | Canada  K2A 1H7   |



--=20
Luiz Augusto von Dentz
