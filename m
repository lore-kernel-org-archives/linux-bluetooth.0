Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C46C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 19:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjHOTVm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbjHOTVM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 15:21:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D221BD8
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 12:20:31 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b703a0453fso86789811fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692127170; x=1692731970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC1d5t7NZcOc2HNZuL4PCzkWVV3GuYKKN1PQ2xa3zwk=;
        b=jnzs+GqTR+8Lar68JwZ2DtjpNuz7YYivFrKoGgzQrnh6Zkllq5NXozmkPRnOzWBfuL
         EZHqrr+ayM+rb62Vinvem2TWtBpQckWHjF2ikoTRTw6NYrnq/6nrGCAICDPpB3hFlmtx
         GTj6EGK1LG22ada0HRUh/+mBAMUYa+L6VFl1PNFUQfMcfjt6s5UEWZNwhF6zZ7ZWyivq
         uT2ngygzEb9RSqjCc6waZ8C4KH8JRr6MBZt3SHwCfBRrQYFCEDLaStoBu4keJo6tB8Qs
         3D/aFJtYdw6Qap5Lh8OIarkixkFc06kB0R44iY/IBxJ/0Ra0NJ9gFy3/lVrulDsl/omt
         e7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692127170; x=1692731970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC1d5t7NZcOc2HNZuL4PCzkWVV3GuYKKN1PQ2xa3zwk=;
        b=ILJoos/0pNHV9UZYaRNYlpwDSRWOYbL70M+C+PS2PoEnaUOcI0+QFO3fehOmaY6T9A
         fdIVZImn/LVK52rCkeKTFw1PDtE9gGehNUgBFzFV/EaMn7iavdIVC5QLLHWJB7b3qR7D
         Vxs0BaWllxEhsffOJFpZiBn7V7OUheHmWw45964s3val21q/xVEnsNtiy4p76Mngw6S3
         YLl+1/Aec/5R534Scljrkz6qiWYcfxFWJj/HSOhnY0w+FPo+K9RruKblGCoLxfK3Fqx9
         m18zAsPsXrndrjitJAlHGUiKu5aEF7PjlLsuPS1GSHYq2W6BibufGYUtS22qVoxypyXQ
         tgTg==
X-Gm-Message-State: AOJu0YzyrqFAnxPKpVwWL0Ao1iX1vgluggHaxJT4awHJ78/K5dDAaoTa
        2vdJv+9FaIl6p3yH8w0I5ZyF9Q+RqzcDTJsXhgY=
X-Google-Smtp-Source: AGHT+IH/Z+oU16dnQL1Kww5DR++4+X5FFvRgF7bwfKjHAv1riB1mgNcbOL5Uv5M2A3BJRzYzRyLihqJjDq/Egcaop6o=
X-Received: by 2002:a2e:a308:0:b0:2b9:ebcb:9c80 with SMTP id
 l8-20020a2ea308000000b002b9ebcb9c80mr9737813lje.39.1692127170177; Tue, 15 Aug
 2023 12:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230808115040.4403-1-claudia.rosu@nxp.com> <169160162069.13361.8621022436013059913.git-patchwork-notify@kernel.org>
In-Reply-To: <169160162069.13361.8621022436013059913.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Aug 2023 12:19:18 -0700
Message-ID: <CABBYNZKMQGOonJtN-jorJiFu6OZhegA0wyK0s9=Z5fAWvizSnA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 0/7] Add support for BAP broadcast sink
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>,
        linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Wed, Aug 9, 2023 at 10:40=E2=80=AFAM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue,  8 Aug 2023 14:50:33 +0300 you wrote:
> > This series of patches adds support for BAP broadcast sink.
> > It consists in registering a broadcastsink endpoint using the
> > Basic Audio Announcement Service UUID,
> > discovering of broadcast advertisers that announce the
> > Broadcast Audio Announcement Service, synchronizes to the Periodic
> > advertisements of the source and synchronizes to the BIG advertised
> > in the PA train.
> > To retrieve the BASE info advertised in the PA train, the patch
> > Bluetooth: ISO: Add support for periodic adv reports processing
> > was used.
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v5,1/7] client/player: Add broadcast sink endpoint
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D4352a42ec1e2
>   - [BlueZ,v5,2/7] btio: Add support for getsockopt(BT_ISO_BASE)
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7b3aa05323f2
>   - [BlueZ,v5,3/7] adapter: Do not filter out broadcast advertiser
>     (no matching commit)
>   - [BlueZ,v5,4/7] profile: Add probe_on_discover flag
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D67a26abe53bf
>   - [BlueZ,v5,5/7] bap: Add support for BAP broadcast sink
>     (no matching commit)
>   - [BlueZ,v5,6/7] media: Add broadcast sink media endpoint
>     (no matching commit)
>   - [BlueZ,v5,7/7] transport: Update transport properties for a broadcast=
 stream
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Let me know if you need more feedback for this set, we do intend to
have a release soon, so I hope we can have the broadcast sink working
as well.

--=20
Luiz Augusto von Dentz
