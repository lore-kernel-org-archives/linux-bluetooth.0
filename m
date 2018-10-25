Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F429ECDE47
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 01:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAB320832
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 01:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2h2eCwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAB320832
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeJYKSE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:18:04 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51248 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJYKSE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 06:18:04 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so8659884itw.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Oct 2018 18:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FxJReD8xofEikSEgvvyDyj60ZT2x4UJMw6JRT23O/Wc=;
        b=Y2h2eCwrcHflH0i/JcUoUaZlfPkgHdE9xexKdkc+KBMUHCIaAEHg+c9m1K508N/JYC
         ngcbn5tWK87d28W3p5bsvGKjyy3Ejc4w7kN/z3GwJD6iEb8LVhMkQC69IZ5RH5kDieIG
         90qpFWFd7Jt0z3h0NhB9pdl0ltVQ+l4NBMR1f5H+dbT9ryUbiUj1TyE07LDevOFZ2Itg
         hPvF0lwdxPyekkwTPmrfX9B1fEUEtDUArxt17ITzanoGaKOAFEekvJrNDokUlso+gNIY
         ru8Z3j9+z9GSDPazeDftqAPyUok8dVWL0iR+HVA+26TdS5czJgzpY1Br1Tttk4tQsWdT
         AoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=FxJReD8xofEikSEgvvyDyj60ZT2x4UJMw6JRT23O/Wc=;
        b=B8eO6NXg1Q98nKZz2HVU2FwATbPr0278rauzb+AgvDX1n9SPiNkmuFqsS4RTt270q1
         rYc81FAZB18CqR3mn0OnbEuTBOoLNzmrxAhfYZONzcBtB99W0FWm76u+IQKJ3X3m+AN6
         KlRJd0veaMC8cfuAQITHUntTXm35LzsOgzLa3XCA4f3JpcHvHDjChbJdxnsZJYDfle7Z
         eDRF1ddanQlt5vr+cEpZ1I2VUNqZmrlnhOtn6Ec/OW3J/Yt/vGeaPkZOiKt64V77ei+m
         /N4x2ohm7S87LLvI5IzOym0ndM23mcIkbrCGyJicd+KtfzzWF0OmiZI1Yi6dvYcpZycz
         MZrg==
X-Gm-Message-State: AGRZ1gIIt9WyDHzMeF4j1htNi/UKoQNJR9RFFKpuTRbG/79opmNjcgh6
        vhUtZYGVfyfuer2Z8aS4v0tvJ2Aro3my6WUfAuYcf7TAA+N6HA==
X-Google-Smtp-Source: AJdET5f92F7K8lPNGHVf8rTQ9RuFBUqB7tsZPBq8Vpum8+J7qYPH8aPTM6eYFOJmWjg37E/BuiQKAak1HLj70pyBD+s=
X-Received: by 2002:a24:2e4e:: with SMTP id i75-v6mr3772ita.72.1540432051503;
 Wed, 24 Oct 2018 18:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181025004210.177441-1-yunhanw@google.com>
In-Reply-To: <20181025004210.177441-1-yunhanw@google.com>
From:   Yunhan Wang <yunhanw@google.com>
Date:   Wed, 24 Oct 2018 18:47:20 -0700
Message-ID: <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
Subject: Re: [PATCH] gatt: Fix double att_disconnected issue on disconnection
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Luiz

I am observing the multiple crashes when doing BLE disconnection using
latest bluez master..It looks like the two att_disconnect are
triggered from your last gatt commit.. Please help take a look at this
workaround and comments.. the better solution might be to figure out
how to handle the disconnection along with random address and public
address together regarding the previous issue, Gatt: Subscriptions are
not cleared after disconnection from a temporary device

Thanks
Best wishes
Yunhan
On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@google.com> wrote:
>
> When BLE disconnection happens, att_disconnect is triggered from two loca=
tions, the new added location is gatt_server_cleanup, it would cause severa=
l blueetoothd crashes. This bus is introduced from commit 634f0a6e1125af8d5=
959bff119d9336a8d81c028, where gatt fix, gatt subscriptions are not cleared=
 after disconnection from a temporary device with private/random address. I=
n order to workaround this issue, btd_gatt_database_att_disconnected can on=
ly be triggered when address type is random, and for others, it can continu=
e to use original disconnect code path.
>
>     crash 1
>     Program received signal SIGSEGV, Segmentation fault.
>     queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555872a40) at /r=
epo/src/shared/queue.c:256
>     256     for (entry =3D queue->head, prev =3D NULL; entry;
>     (gdb) backtrace
>         at /bluez/repo/src/gatt-database.c:350
>         at bluez/repo/src/shared/queue.c:220
>         at bluez/repo/src/shared/att.c:592
>         at bluez/repo/src/shared/io-glib.c:170
>
>     crash 2
>         at bluez/repo/src/shared/queue.c:220
>         at bluez/repo/src/shared/att.c:592
>         at bluez/repo/src/shared/io-glib.c:170
>
>     (gdb) print state->db->adapter
>     Cannot access memory at address 0x61672f6269727474
> ---
>  src/gatt-database.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 783b692d5..2f0eb83b5 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -3365,6 +3365,8 @@ void btd_gatt_database_att_disconnected(struct btd_=
gatt_database *database,
>
>         addr =3D device_get_address(device);
>         type =3D btd_device_get_bdaddr_type(device);
> +    if (type !=3D BDADDR_LE_RANDOM)
> +        return;
>
>         state =3D find_device_state(database, addr, type);
>         if (!state)
> --
> 2.19.1.568.g152ad8e336-goog
>
