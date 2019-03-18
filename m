Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6EC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 14:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A87320850
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 14:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWnPEeDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfCROpj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:45:39 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37881 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfCROpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 10:45:39 -0400
Received: by mail-oi1-f171.google.com with SMTP id v84so6879573oif.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qsl4MwyCd5FT9upAJrgvAT3omQoMOff59xoNbM5xXGY=;
        b=qWnPEeDkDzYuNoxk0onE741+1lgCgi0KXD28rCW55HlVfmgYjqx0AFlRQ9N4rOdfS+
         En1sgHQRiB7f0sWPtDErqTCa/bXZXc8/ibY7ZJYjnfoVGUpnvYHwWc00+kCkLwTeuiKc
         7kTpjCQ+AAFhN3JJaQrZRGInay+CbUmP9EnzX81S1JdajJftQ9cHV1U0MOl52LQHczHI
         nocMLWYuAnjfecAoPeUHPOOopdrRP1xRaPmr4mcIuO/qaaokanMYYVjOHubJLT/jdeQm
         Zad0P6TcuPpJhW+i+EDG+XKbYUQwviJPKALzbD9c/C1mu05UPUmkzR7DzZxLvkUjaOoN
         8RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=qsl4MwyCd5FT9upAJrgvAT3omQoMOff59xoNbM5xXGY=;
        b=erK0vTuGOGZ/K1cZQ89iKABf2NkqKAQQJsDaKAxpxuTEz1K86qivUXaHodFMwVudEA
         iAS9/8umVUFVja4qobQdnsBMXKCc5iYxdExgWCAydDx1Fa0i9dUVMwEJKgqvcb2VK35B
         0SLb3OSmA9BAnaIgDiNfuuS6rdI3VuVYSII3WL5nwV2XvJXpjeOE5hwmAjJUDiNBJnoc
         S6rsJwdvFS+2wpiTf29YfNFwBnU7I+xv0G5R2KHJ3d585vbhYSXxzwFSHSIJTLKdQRwk
         GAtGarT9rpcZN4+sdVohIBvlE3H0Q1bcqwnYNXLgB3GdhcjwUXOazIte5SC65dXRmz2x
         vsdw==
X-Gm-Message-State: APjAAAVhZp5sT2OXIwLXIA9WshiTl5YEnm9kiCEgOQEuQFhCYOzIkuJ0
        /oD6LGng37lBLOHPu3nNSv6nbj4ce8ucElzK7W/+5m5svf4=
X-Google-Smtp-Source: APXvYqxO4MmbE/OnKJrg4BYkXh5dxbeMjYmjei5rFpuD221OaNbm9WlKd+KkuFHjGYX5ywInnpLOV0fV/8G16ltEkFs=
X-Received: by 2002:aca:edc7:: with SMTP id l190mr1700070oih.92.1552920338555;
 Mon, 18 Mar 2019 07:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAGuyqoHmCT7N3JCEr5otjXOvQN-FQhxYjVAb7zT+_Lcc3oTGxg@mail.gmail.com>
In-Reply-To: <CAGuyqoHmCT7N3JCEr5otjXOvQN-FQhxYjVAb7zT+_Lcc3oTGxg@mail.gmail.com>
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Mon, 18 Mar 2019 15:45:27 +0100
Message-ID: <CAGuyqoHSLSZ61jq+4trVoS=Mcm2h3G_FTY_6LXOSxo4fRuMYtQ@mail.gmail.com>
Subject: Re: BlueZ 5.50: Delay in LE Read Remote Used Features response
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We checked further and the delay is caused by a LL_CHANNEL_MAP_IND
that is delaying the scenario:

LL_CHANNEL_MAP_IND (with Instant: 0x0167, it should be 7)
4s delay
LL_FEATURE_REQ
LL_FEATURE_RSP

Any guidance in how to avoid this or force that LL_CHANNEL_MAP_IND instant =
is 7?
Thanks
Miguel

El jue., 14 mar. 2019 a las 12:53, Miguel Sancho
(<miguel.a.sancho@gmail.com>) escribi=C3=B3:
>
> Hi,
> using bluetoothd 5.50 to connect to a paired remote control,
> I see a 4s delay in receiving the response to the LE Read Remote Used
> Features request.
>
> LE Create Connection
> LE Connection Complete
> LE Read Remote Used Features
> ..
> 4s
> ..
> LE Read Remote Used Features Complete
>
> Is there any configuration or work-around in bluetoothd to try to
> overcome this issue? f.e a config to avoid sending the
> ReadRemoteUsedFeatures, or a timer setting that can fix the scenario.
>
> Thanks in advance
