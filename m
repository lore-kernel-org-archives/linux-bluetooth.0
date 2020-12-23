Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E6AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6573220729
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 07:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgLWHy3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Dec 2020 02:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgLWHy2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Dec 2020 02:54:28 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA3CC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 23:53:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o19so38106100lfo.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 23:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvds22pi5MEw2ZW5T62SoKKKSYY5H17iYaJRDS7x/JU=;
        b=GIj0NMVn5UTSkYHLvII8fk4jEq5p05+ATlhU62PIA+F1ybnyOk1b3tBMfVpr/6yoqk
         reRUyHTyyMEDIBbvIZ3KFLjNn+lF3VqECY8xyc0QvXVqT9cCBcsf8b33oSAKAaHjOkb0
         E8khP48aJSRGaruivF8F+i4AxGcnsMESKBM6Un8yqSWeMWqX1R8hThrtEahNbb334mOh
         5LkTS6DAezkk9jcOg9GQPf0G++WiFu7RGWwNla5PidbeT7QwW1Jn3GQccmZKWLJzveDr
         KGnSQphSrkJvQC5Tm3kd1lyWH8Rs6h99HXVMobLtKd9pSO4ikP9eQMecytgoiCuN1HW0
         xvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvds22pi5MEw2ZW5T62SoKKKSYY5H17iYaJRDS7x/JU=;
        b=RBO4+Kt5R59hjtuwOaq7rmkMnJeil43Yc/dWfdjwwsU4PkVMYQfzXb95CIAXb0jno9
         eN3FVhjRKUGJfIteB7Os00JwdHBB5rvMEoaqtAJ4hIKDC9PX4xDIRxJkZ8vNYbVvQyy3
         ynwMxWsjfaXoC4b1Eea3a/c+dQMg0u1DeqAZIK+FvD8jxtg0RFEies13pgO/Qr4WpLWs
         H3XaaV/GfqzFbe8eAOHoIgnCc+7cEYwv3yayxazA+YgMGzUGPrrL2O7Go4W9JT09yd/2
         nZAXRlvxpFiq959NTcMAhB4TJ6apTVTvNhio4yusQWzd79qky3hyqfCokZCiJLrh8BZD
         LmCA==
X-Gm-Message-State: AOAM533Pncmzb+vjD6Zl+Uj30Mth3wyi1gximuet+UL9yNwhvfAOrR2o
        OwN+n1mRWlZnF+nvATpPG8NU5lZ9ng4jJzZ6SR4=
X-Google-Smtp-Source: ABdhPJycYUgarBrIXvDXRjMmcVBNDiwNreZuzeLULCObDYSVBLm0omAaJksPIUVEpb6m5SC89e5l/yXF63C7FhlA2uQ=
X-Received: by 2002:ac2:4946:: with SMTP id o6mr9760013lfi.412.1608710026498;
 Tue, 22 Dec 2020 23:53:46 -0800 (PST)
MIME-Version: 1.0
References: <CAG17S_Oy_N_YPo6x5pmZ05p4MqH_gDUrRS0TR3ydQVG9BvmYEw@mail.gmail.com>
In-Reply-To: <CAG17S_Oy_N_YPo6x5pmZ05p4MqH_gDUrRS0TR3ydQVG9BvmYEw@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Wed, 23 Dec 2020 07:53:34 +0000
Message-ID: <CAAu3APaGmCAA8JGKgFcg4wzJLT4y05BhvYu6uA05COdvEyauow@mail.gmail.com>
Subject: Re: Request for help with btmgmt
To:     KeithG <ys3al35l@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Keith,

On Wed, 23 Dec 2020 at 00:34, KeithG <ys3al35l@gmail.com> wrote:
>
> I am developing a RPi based audio player. We are trying to add
> bluetooth capability to this player. We use alsa and not pulse-audio,
> so we need a bit more granular info to get it to run. I have written a
> script which is designed to be triggered by udev when a BT device is
> added or removed. This script will then use bluetoothctl to get the
> capabilities of the device and also add or remove it from a dynamic
> database list of MACs in redis. I have a simple script working as I
> want from the cli. The key command I am using is 'btmgmt con' which is
> the only command I have found that tells me what MACs are currently
> connected. I can run this command from the command line as root. I can
> set the setuid bit of btmgmt and also get it to run as a user (http in
> this case). I cannot, ever, get this command to run when triggered
> from udev. I get no response and no error.
>
> 1) Why is this particular command (query attached BT MACs) not part of
> bluetoothctl?  Is there a security issue?
> 2) Why can I not run 'btmgmt con' in a script (bash or php) triggered
> by udev when the device is added or removed?
> 3) is there a 'better way' for me to know what device MAC addresses
> are attached? I have not found another simple way to get this info.
>
> What I am doing in the script is: if an audio source is attached, I
> want to run a bluealsa-aplay service. When an audio sink is attached,
> I want to re-set my audio output to the bluealsa device. If it is not
> an audio device, I do not care, but do keep track of what is attached
> in my database so that the next time the script runs that it is not
> queried and is 'known'.
>
> Thanks for the help.
>
> Keith

I would suggest that the D-Bus API would be a more appropriate way to
get the information you want.

The "get managed objects" functionality is a good way to iterate
through all the devices that BlueZ knows about.
There are examples at:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/bluezutils.py
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/list-devices

The D-Bus API also allows your code to execute callbacks when a device
is added or its connection state changes.
This is done with the InterfacesAdded and PropertiesChanged signals.

If you are going to use Python I would suggest the
https://pypi.org/project/pydbus/ library is a more "Pythonic" set of
D-Bus bindings.

The API is documented at:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc

Regards,
Barry
