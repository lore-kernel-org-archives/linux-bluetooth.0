Return-Path: <SRS0=FZvY=36=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BBEC35254
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6262082F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qll1/1NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgBJRdW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:33:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38725 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgBJRdW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Feb 2020 12:33:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so7161946oth.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2020 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nie52YFpAQnDBr57W+SkUNBQswk9jy0X58TknritOc=;
        b=Qll1/1NSg6W4lFnwsR5m/CIWomyGoL/P1a3ywdR0y+PYGmdw1mbF65t/O47tx+7rWv
         9tgUkrgyrmGPiTlpr307hJ/HtiCLMo5TOCcWShJqsTSIg3MacXK9DAw8eX5PAH2kiIMY
         2JbuI0nQKIMMr0Yi/VzT3L4V61WAlo88oyEYLYai0+8QfgkvbVvn5cetWzb/tVvo0ayF
         pFRFIju4zKkVsBUeWfu1/tG+QIytrMQN/ZsJZOKVhhZoyCk3fYUf1ArgibVjEVZsT1V/
         ukvV3TwgvzE5nBiI5BSMX3EyuCEBjCsba+3QMfRZg9OzZEg+OjzwWZMYszNERL3UC/+R
         zFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nie52YFpAQnDBr57W+SkUNBQswk9jy0X58TknritOc=;
        b=SBtpK1HMSGyr93xo4TUY1tg9KEPrshE/Z9XTOz4B/MQI7kauczD7O0IhQ5mbmvVTR0
         XkGKs31AKRQ23HgOLpyvtchYyuiOzA5laX/Bv58pPJre4LjPmLyrIxIVJ/RRwBqfDxjD
         aeY8aNTt4aSVqGqfmnJczvieoCsctJRvnDTfQ+lqNg2EUyqywhAwjJd2yWG6pJWgsf71
         zk5kqf7WSlDV2USruzGM4ojEOl6Si5ib0StwhA0aAYU3f50dwcG/fEPgWuDIMzn6Rhv3
         U9Rh+E5MpI0h47PeHsQmD7wCjurobMAun87CCsP1g6mWZ+GJssShFopxkSlB+uVpZhT5
         TDEQ==
X-Gm-Message-State: APjAAAWIB/sQrZL/jVnUJ/xPoTV9Af77Jo+28k6R4HyZbJo/OngM8XEM
        zT+2KcNqfYgoFQd5ispkyazzIjwdMoR3MUC5Ogg=
X-Google-Smtp-Source: APXvYqw8T8nYuRt23vf60Pjcb+wDY410mVJmHqvdJf3fipiXTlKR26bOwRjKt4O99queQcWrqbK0ECQP+kwJ1PcBXVo=
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr1906018otf.11.1581356001485;
 Mon, 10 Feb 2020 09:33:21 -0800 (PST)
MIME-Version: 1.0
References: <CAANRJtzBpw__m0ymcXJu1VhYhGcVT=AkLYpwHaahT=F4xKo+Wg@mail.gmail.com>
In-Reply-To: <CAANRJtzBpw__m0ymcXJu1VhYhGcVT=AkLYpwHaahT=F4xKo+Wg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Feb 2020 09:33:09 -0800
Message-ID: <CABBYNZLngK1F_=fVYhCJNJGnkR+oK93-rN2MTN4z3dMFTP+E3Q@mail.gmail.com>
Subject: Re: OPP throughput is low in ubuntu 18.04
To:     Amit K Bag <amit.k.bag@intel.corp-partner.google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

On Mon, Feb 10, 2020 at 3:20 AM Amit K Bag
<amit.k.bag@intel.corp-partner.google.com> wrote:
>
> Hello All,
>
> I am tring to test the OPP throughput in linux.
> I transferred between 2 machines having ubuntu 16.04 with bluez
> version 5.44 in that I am getting 1.4mbps speed.
>
> Kernel : 4.14.13
> OS : ubuntu 18.04.2 LTS
> Bluez -5.44
>
> I am using a 12 MB of audio file.
> But the same file when I transferred between  2 machines having ubuntu
> 18.04 the speed is significantly reduced.
>
> Kernel : 4.18.0-15-generic
> OS : ubuntu 18.04.2 LTS
> Bluez -5.48
>
> Could someone tell me why its reduced in ubuntu 18.04

I don't think we change anything on Obexd related to that so perhaps
it is something related to the L2CAP MTU? We could try setting the MTU
to 0 so it automatically picks the matching MTU if you do have the
following patch applied to your kernel:

Bluetooth: Auto tune if input MTU is set to 0


-- 
Luiz Augusto von Dentz
