Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAFBC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 13:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520462075E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 13:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMnkHfQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgDMNsN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgDMNsM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 09:48:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02FC0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 06:48:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so3295895wrg.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilaMHxzfZVxXfDLWtcZLBUj208g0dYwsTx+UXD78WzE=;
        b=pMnkHfQSZDPADzT11CBpobJfBDOaZQt11Xu3L4Y69SBtPou5MwxHn7eJSFO4pHn3zX
         SpHzG+LBkt9hZ9GI1B8q6gXexaZLVgxs+VCgMq7k2TwDeym3sdosTpqrYRJDTrCNwVr2
         jDLnek2IjY1HiLjpcdFX6QgSybV4+8o8UZ8dStLIHQR+wP/DU0Uj+prOb+tkLdkUlcb+
         ZOMVuUqjYS2pjTxePSYsFsytBVDcjiChmM8MqLNTz6Txb8s6B6+unzYWuNPopafPcrA9
         QgKYUWQDYbQLmQrjygPrVSb8+qEkSyt/1EpYgDWx8JIYaWFAaxJYzmVIk9SqZSkkIDO5
         rD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilaMHxzfZVxXfDLWtcZLBUj208g0dYwsTx+UXD78WzE=;
        b=A0kpCpoV7Sk6PCqX3wVtrXlfrJBMKopHPpEOU6kq1eLSTBAmq694tpZDCxCB2DQDR+
         0Z62yqhHzLi5+XfDmkFycqbgldv4lt0Diigo6oXnnFU4T4CmIQZaQwOvDC1IF+1WumvL
         UUGzaKwuAEBeopbiDLPRpRaXjQ4ALEDXBIRSGrCRzixIPCX3eGrlpQlaMhOaCNucvEJ4
         Z8rEmJ4oD6UaT7LR/kMSKIlOgp/VYIPn4yBE5V2uwBUXa2Rgu//HKcRhTqT9xFhl/qTj
         3Rf3FAUjODAMjYUI6GGA4ZnhLr0G2iGx3AVBWgw49dh9oqaWHO9NeAw3uwwPRnYxySWN
         y14A==
X-Gm-Message-State: AGi0PuY8y1qUsQwycqypmjxNeQntAG02pkt10oU8ACiHmTdC6BIHnPrZ
        ps8cAHKwFSn6oVqRjP7D4mThcHIaCNOev/Y3T+fSp7/sJwn1ng==
X-Google-Smtp-Source: APiQypI+hVg3NAkqtaGOcTYbSfHMkiRAL0un0L85dw0cMLLL4F76kzrwgTePF6miPs30ZoPPlbGE6/ZZaWHAr53oN5M=
X-Received: by 2002:adf:ec02:: with SMTP id x2mr18738818wrn.365.1586785690406;
 Mon, 13 Apr 2020 06:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
 <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com>
 <CAJQfnxEFM81DSvZb+ULG7+nwQuy-GWj26GWn4OP+Bp--24N1CQ@mail.gmail.com>
 <CABBYNZ+=wMNuvjJ5VK2zpd6euqeEZ8JXbd67RmPgxDfdCgce9w@mail.gmail.com>
 <14E46BF4-0688-4A0B-AE84-46C4426C5E9A@holtmann.org> <CAJQfnxELMMDa6nbxRUrW46VjEBj6Txfeym62PKi+R3iXHKU0CQ@mail.gmail.com>
In-Reply-To: <CAJQfnxELMMDa6nbxRUrW46VjEBj6Txfeym62PKi+R3iXHKU0CQ@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 13 Apr 2020 21:47:59 +0800
Message-ID: <CAJQfnxG_AnWArBg8_Pg3coAeFbRuG08KkXh1G==CuXWCvJpf5Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: disconnect intr channel before ctrl channel
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Luiz,

I found out that shutdown second parameter is passed as the "how"
parameter in l2cap_sock_shutdown() [1].
Currently the value of the parameter is unused, but I think we can
assign it to sk->sk_shutdown. Therefore, we can differentiate whether
we are interested to wait for the disconnection reply or not, by
supplying SHUT_RDWR and SHUT_WR, respectively.

Do you think this is a sound idea?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/l2cap_sock.c#n1267

Thanks,
Archie

On Wed, 18 Mar 2020 at 20:41, Archie Pusaka <apusaka@google.com> wrote:
>
> > > I see, we shutdown the socket immediately since the socket API itself
> > > don't seem to have a concept of disconnect syscall not sure if other
> > > values could be passed to shutdown second parameter to indicate we
> > > want to actually wait it to be disconnected.
>
> I don't think the second parameter matters, I tried every possible
> valid values and intr_watch_cb is still called without waiting for the
> response.
>
> >
> > in a blocking synchronous system call world we have SO_LINGER for that. In the world of asynchronous IO handling (what we do), we need to check what is the right way of handling this.
> >
>
> I spot this piece of code [1] which utilizes getsockopt to query
> socket connection information from the kernel space to the user space.
> We can use a similar method to query whether (sk->sk_state ==
> BT_CLOSED), which is only true when we get the response.
> What do you think?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/l2cap_sock.c#n476
