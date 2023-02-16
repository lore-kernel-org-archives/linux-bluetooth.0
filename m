Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE87C636D6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Feb 2023 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBPVE0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Feb 2023 16:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBPVEZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Feb 2023 16:04:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F037505D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Feb 2023 13:04:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so4346132lfv.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Feb 2023 13:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eIeU9ZMoRh18beZ88mIVfQBocKS7mUhsKJyVztE4Qkk=;
        b=nKRu36MtAziI9tKIWK+vArhBU+1aMoKRCFcrzKg/yOWaA0Qt57oXgoQ7D3f03AjlZK
         VidXIYLW7gjDPF9K1A9m10yJeN1vcCNXHnZTw+HQhLrfpnYFa9U6Jcb0M1sI/V5PWkh4
         Bt78YrMsStVP/X3jp0HfUri4lKtAGv77V/Qqf+YFHHYrQ//cGKMZt8qiZimFZBaO+5Go
         6eQfozuZ6QgHg2HIPDMUS0whzRAf6jtv7piwSa/uLeAnNyago+ZFUp3I9Tq/UD6QHrl4
         dVssfXgMcpZPaGVl1hkuJE+/1jeMeFBOMfryyeYK1+7CtwxXqe3DicXo3z6M1xpGz0TQ
         pj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIeU9ZMoRh18beZ88mIVfQBocKS7mUhsKJyVztE4Qkk=;
        b=jqWMXb21LJdd0RrlskqukbVTYV4i/+cYJ02Jc7AV3pUm6tlrmNLWO+Y0gpoilqzP1r
         M1lPrRQIjUvBDG5OkoMp79W9dBtJuEA3U9pAyb8H9QamiDudmRIVcYd6DSNiaj2JQr6Y
         owJqe7BU3jEDdsYFuDxDw7GBdMxEFivXodMreCAOfluMPCOKczjFGxVf5kWdH9FE1wS6
         SgJw2w0H/N6QvqQmOxy1FLMe42ly05DAK4IWDrtGVTwEdwYmg39T7G10LZJj7//gCZVI
         zIW4kVTS/VgUVui/i0MOBLNCeZRjNqpzku0OtJXszhRbAJB0/kHmpexLTNQBfUhNNjH1
         Z4eA==
X-Gm-Message-State: AO0yUKVQ9cxJGw1hqIf0k42sGGKzWa+c0lv1VZ5Ob+kPSsAs0woqKWUh
        B4fC6Jv6hOluOghrZFLy5xV0aNJ2YfnaA8c99GUAb3Q9
X-Google-Smtp-Source: AK7set8/elg49oyJvtj92U3T+GSBsloGmbXJuq9kpSXNoUJpNhylM8/v1x+48ry2rpSztF4s/b57Tg/WSgawCZj0Ztw=
X-Received: by 2002:ac2:5296:0:b0:4db:173e:812a with SMTP id
 q22-20020ac25296000000b004db173e812amr2043627lfm.8.1676581462606; Thu, 16 Feb
 2023 13:04:22 -0800 (PST)
MIME-Version: 1.0
References: <CADBWZmXM7NO_mbw-ka9WYg2fMVhxD2ByFR1PJBDVc2e1yf_8Tw@mail.gmail.com>
In-Reply-To: <CADBWZmXM7NO_mbw-ka9WYg2fMVhxD2ByFR1PJBDVc2e1yf_8Tw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 Feb 2023 13:04:11 -0800
Message-ID: <CABBYNZK_O5bnmE4ONOQiB-RgUjWwqvQrD8euNqpKAOcUSzER5A@mail.gmail.com>
Subject: Re: Need a BLE socket to connect to a nRF52832 Nordic (Low energy BT 5)
To:     Neacsu Cristian <neacsu.cristianstefan@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Neacsu,

On Thu, Feb 16, 2023 at 11:20 AM Neacsu Cristian
<neacsu.cristianstefan@gmail.com> wrote:
>
> Hello,
>
>     Long story short, I am trying to connect with a linux PC using a
> Bluetooth 5 universal adapter (Asus USB-BT500) to a Bluetooth 5 module
> PCB, called BT832X which is using a Bluetooth Low Energy Technology
> that is using a chip Nordic nRF52832 (see url for the module
> documentation https://static1.squarespace.com/static/561459a2e4b0b39f5cefa12e/t/63de8b578e4d7813cde64445/1675529048975/BT832X-p+Product+Specifications.pdf).
>     Therefore I tried everything, reading docs, sniffing through the
> bluetoothctl sources, gatttools sources, and I am not able to open and
> connect on a socket on my PC to connect properly.
> Usually for legacy Bluetooth stuff, I create a RF_COMM socket, and the
> magic is done by itself. No biggie.
>     Here I tried an L2CAP approach (not sure if I had a proper
> configuration), I tried to use the gatttool as it is, without success.
> I feel a bit lost.
>     The remote device is working properly, because using the Nordic
> demo Android app (downloadable from Google Play Store), I am able to
> communicate with the PCB and exchange packages.
>     Do you have a functional, very simple sample, or suggestion,
> preferably in C, to help me to open a socket and send a data package?
> I mean, you have a BLE module, you want to connect with it using
> BlueZ, how do you open a socket, how do you configure it, connect to
> it and send a byte through it?
>     Let's keep in mind that I am already able to scan for the
> destination address (I created a custom agent in bluetoothctl that is
> fishing data using the "scan on" command), so the address that I'm
> connecting to is already known.
>
> Thank you and I'm really really looking forward to your reply.

I guess for LE what you really want is to use GATT procedures, which
are available via bluetoothctl> menu gatt

> Cristian-Stefan



-- 
Luiz Augusto von Dentz
