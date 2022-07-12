Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C848C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 18:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGLSSF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jul 2022 14:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiGLSSF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jul 2022 14:18:05 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A881C3AE5
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 11:18:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r9so10824947ljp.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nxf+87OhgA12F+c0Lng35R5NitZOqX4C7qFtQ0tdVak=;
        b=T/EdcjE/Qj40vZYa8IxvcgyH6oc/cwUjdBM1uY5DqR3dEHfB3+dB5zIzJCkc8mSRgq
         hZ7PhASvXm7aWosyqi5qJCEysMBqoqc/Se/Fw7ldFZ6gpBuwrdRLIfXBh52k8Pc+p/n7
         6FKMt9jlLENtZOkRsMMz098nHzPRPXknkZxiQlivnt3QUGSZe9Q16FBGz8b9n1VIN/eb
         NR03TSD9JaqcPV0tnnoQmC5k2tewEUEXzGC2AlWU74Swwq38earCr+6VCspI1atUp6Qb
         hWBwh54ujagMDday7SQSOzPqqzY6JtWMEV/sQpWPee2nxUFKTcZR0uduzZNwmNSwmCVf
         VNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nxf+87OhgA12F+c0Lng35R5NitZOqX4C7qFtQ0tdVak=;
        b=14UxnqJYr/07c+WxPdf6Z2tjn+COUPZ8iN80dEpatwlXwt9dAjsdbvhHSP7wdWmmnm
         gEQsmlemtnPoLOLega22unRg3wmy5fdgMWU5PKohc6qHz7kBYFOOEkOYDPmNALQ1OGgX
         Y5g2dHQJy8BXX9UJOHZvMl3KAHYybIGzgbijtjjQiKjUyY3+vgP/sEvEQ2eF2lg2xlZj
         t7aBlZEbv+S7M4VUQ3epPJHbnu8YuSTuqEbYfNUDg5LbaZY1ulCX9cw98GmKeUjblzFS
         eSdX7NnOrB/NT0MXmE7XDkfbnyZ488UHn/y4QZ50A6ZTIN0OhhCa60KebPEF1Vgx1/in
         GryA==
X-Gm-Message-State: AJIora/2xNczU5HGcg/kM3SpeBwcUn05U3yvsgsmnL8qZeh3rFpG8XSJ
        tMiw5jvvZphQK+CQtRZFIYJHWVm0l3xwUzhcs9A=
X-Google-Smtp-Source: AGRyM1sNH6/JJLdQ4mZzFlRecr4rUyBYwidbKqdKQh3M5bQYfRF3p+CEWGOg+5KsaY2T9CzrYL5zsqwX32IGRtl9WKU=
X-Received: by 2002:a05:651c:545:b0:25b:c791:816c with SMTP id
 q5-20020a05651c054500b0025bc791816cmr14056209ljp.161.1657649882146; Tue, 12
 Jul 2022 11:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220709183524.13900-1-shwoseph@gmail.com>
In-Reply-To: <20220709183524.13900-1-shwoseph@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Jul 2022 11:17:50 -0700
Message-ID: <CABBYNZKPmGza6LUyq=izDiGUBYOnY6BhF_GxxB-TPHRL4QeXMQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/1] [v2] ExcludeAdapter configuration setting for
 input plugin
To:     shwoseph <shwoseph@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Jul 9, 2022 at 11:38 AM shwoseph <shwoseph@gmail.com> wrote:
>
> As a bluez user I have run into cases where the input plugin can be probl=
ematic because it binds both HID PSMs on all bluetooth adapters. Simply dis=
abling the plugin is not an ideal solution if you want to, for example, run=
 an application that binds PSMs 17 and 19 on adapterA while using a bluetoo=
th input device on adapterB. This proposed feature would allow users to det=
ermine which of their adapters can be engaged by the input plugin. Using th=
e ExcludeAdapters key in input.conf a comma separated list of bdaddrs can b=
e specified that the input plugin will not start a server on.
>
> shwoseph (1):
>   ExcludeAdapter configuration setting for input profile
>
>  profiles/input/device.c   | 22 ++++++++++++++++++++++
>  profiles/input/device.h   |  4 ++++
>  profiles/input/input.conf |  4 ++++
>  profiles/input/manager.c  | 34 +++++++++++++++++++++++++++++++++-
>  4 files changed, 63 insertions(+), 1 deletion(-)
>
> --
> 2.32.0

Well those PSM would require root to bind anyway so if the intention
is to allow implementing something like an HID device perhaps we would
better off allowing RegisterProfile with HID UUID that way the daemon
still have control of these PSMs but it can dispatch the connections
to an application that has registered:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt

On the plus side you can register an SDP record for it, but we may
need to do some changes if we want profile to be registered only to a
specific adapter.

--=20
Luiz Augusto von Dentz
