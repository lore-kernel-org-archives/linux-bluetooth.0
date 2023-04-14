Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFBC77B71
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 21:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDNV44 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDNV44 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 17:56:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEDF1FF0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 14:56:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e8so2188689ljn.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681509412; x=1684101412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNmCfskKK9GGNsHmKHrLQbYRWYOxy3WjWsT63m5qdXM=;
        b=GQsbqYWY2AiQ7D2Gzu19XYxfC9r45jlsnGGMPmrvlk2k/Os868/dsro8uyd2mGBXqJ
         mJ3GBtbVUzwrumx4ansycC0zj5Ea+6rkEWQbXpSAaTgsosGH369LSMD5v7FZK2LRsHtV
         K96h69CXloC5Tffa2PwlV49N/Ipw6SwXLFVWhvVlsI3XuPtWjGSYppCbFAqj3O/lrYmD
         DlP7ka27kY5PNXTqGfFkNTyXKzaAX8QF3F+iHdJuuYwzwUEojjRMV7DN9llludgdWZHj
         lg6sOU0O4NdZlDfXXj2JKOS6PJEMbY2nQAQEVddLfhSJIY0ek0w+zYInrmPhhNERtZde
         WOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681509412; x=1684101412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNmCfskKK9GGNsHmKHrLQbYRWYOxy3WjWsT63m5qdXM=;
        b=PSBsMuWDF7pJkfHel4H/azkalL7l+JdwgXMbYpBOFinJlhGpmCL6vo3snsAow4KQBq
         BUckmF/AiqXDNQulL7hNGd1GSqG03nGOn2SEmSySOGpH7GKRAly35WwVogRQvEzp1OZ1
         3HJSWMvgeDvg+h4QCj+XcZB2jR7V3wDLcfUajhzn5S62sJ8OII3VrQe7+xlHg82Ly8Bb
         iViuhd5fcvxaPdPKXSajX16+F+OxbTswUD8J92shlTlLQ8otVc3ez4XQqYjDkDQ2DsX+
         hqn0qf04Ct3SQ6PpCzxiPBNxDrb7UyoZ29+69AtDuIR0KUL6xw7ZoLUjS2imLJWXX/R8
         8q+A==
X-Gm-Message-State: AAQBX9dQQd8jk10IAKFtCbcPSP2lnj+2VFmWTpsptB/pjAcQFKsgg0lJ
        z9enbLI4QJZyqQSR6OhvgIjtfeZHKR+6RAQyiQ7BYdr9OeeoxQ==
X-Google-Smtp-Source: AKy350Y60H3GM8HkhGjj0V6tI2PfNfcsl3BAEs29uY5d/kv0QFICDR6323ks7oIGd3Q/0FFNkmECOH5LMG1naLUwWX4=
X-Received: by 2002:a2e:804b:0:b0:295:acea:5875 with SMTP id
 p11-20020a2e804b000000b00295acea5875mr2308781ljg.2.1681509412354; Fri, 14 Apr
 2023 14:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
 <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
 <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
 <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi> <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
 <A02E43E3-63E3-4F75-AB99-FB355180DD2B@iki.fi> <CABBYNZJdjq2TZCpNVSC-za6e++GgeL2M3=G=11g7u33NDeEpgg@mail.gmail.com>
 <ca30b39204f49e793317a5008f825656e1f40c3f.camel@iki.fi> <CABBYNZK5h4Vn9_Y8S2WsK_DHb6jvWDMjP-u=Vgos6SO4fRUatA@mail.gmail.com>
 <CABBYNZLbG2iWLUDH6A4Wbdb=o47Un8b_VGVV8y1v4hOwFyok4g@mail.gmail.com> <71f5c4c6615ebce24526ac256f84abb6a2d95534.camel@iki.fi>
In-Reply-To: <71f5c4c6615ebce24526ac256f84abb6a2d95534.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Apr 2023 14:56:40 -0700
Message-ID: <CABBYNZLGP3FPXOfQ1uWF1pSSiWk+1ZBJdxHm9rXSSfEH+7f15Q@mail.gmail.com>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org,
        =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Thu, Apr 13, 2023 at 2:14=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-04-13 kello 11:48 -0700, Luiz Augusto von Dentz kirjoitti:
> [clip]
> > Btw, not sure you if are following the list but I'm working on adding
> > support for handling multiple CIS to the same peer:
> >
> > https://patchwork.kernel.org/project/bluetooth/list/?series=3D739574
> >
> > That should allow you to set a different CIS ID if you want to use
> > different sockets for input and output.
>
> Great, I saw the patchset but didn't yet have time to take a proper look.
>
> > Id also would like to discuss how we do some test automation using
> > pipewire endpoints in the future, we probably want to enable it via
> > test-runner but we probably need to enable it loading pipewire daemons
> > etc under the vm that test-runner creates, Frederic started adding
> > some support but it doesn't look like it loads pipewire so Im not
> > really sure how it supposed to be loaded:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runn=
er.c#n1108
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runn=
er.c#n277
>
> Yes, there'd be two daemons to start in the VM, pipewire and wireplumber,
> and running with default config should then result to the endpoints being
> created.
>
> The interaction is probably simplest via the command-line tools.
> In principle something more clever and better controlled is possible,
> but I'd need to think a bit more what's best here.
>
> Output from `pw-dump -m` can be polled and parsed for determining
> when daemons are ready, what bluetooth sinks/devices appeared after
> connect, etc. `pw-cat` can be used for playback and recording.

Yep, in terms of tests the ideal solution would be simulate BAP
qualification tests:

https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=3D524716

Ive started to write them as unit tests:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/unit/test-bap.c

It is somewhat laborious to write all the PDUs manually like that but
if we managed to write all the tests we could perhaps enable it
working with the full stack rather than limiting it bt_bap instance,
but perhaps it is overkill since we could instead automate
qualification tests via auto-pts.

> Some tests probably can be written along these lines, but without
> trying now I don't know yet how well the above would work.
>
> A separate question is how the virtual BT device that is going to
> interact with the endpoints is going to be implemented. Hand-coded
> data sent via emulator bthost?

We can do both a hand-coded tests with bthost or hook a second
instance of btdev to BlueZ so we test BlueZ vs BlueZ, well in theory
we could even bring another stack as well like zephyr into the
picture, anyway what we need to know is how to setup the environment
for pipewire and wireplumber, note that we don't have the so called
user session under test-runner environment, so I wonder if we need
wireplumber?

>
> --
> Pauli Virtanen
>


--=20
Luiz Augusto von Dentz
