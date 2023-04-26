Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17057C77B78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 16:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbjDZQFO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZQFN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 12:05:13 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923125FD4
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 09:05:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a7ac8a2c8bso70478241fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682525111; x=1685117111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n560bpEsDZ7fauK3KikHW8gRFkcyXz3589ZSgBZpOZU=;
        b=F7pE8/g5mJbGAvn0K8KMlE38wpMjQ/RpuNgrNgJgLyatNNyTP2ChNOMFmpytNg2eoo
         CrrukXlWyAYKAZ4I42efGxYIbnFMp5Or4m2JLSg5Co1mK4smA7TslzMNciFc3OrfyhoW
         G1ge0YSZYnm+yWkHh1+NLmwoD0fHgzY6W9JVmFxQ4HneOEOPIWeR/xJFJU+yiIGqW3+S
         CLRCut1mWw0x6H/pJGPOptKsw6MKXAfc1LB4oMuvRwy8dGqEjNQj8wc9zXcxqUICy3FE
         gu5quIQkfXE1HYbSDUqyHq0msWhisQ2gUkqoULAslvhuBknxtErPBMkM2Uh0RDQRxayo
         Hdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525111; x=1685117111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n560bpEsDZ7fauK3KikHW8gRFkcyXz3589ZSgBZpOZU=;
        b=cFTDy6KsZ1dogifPusNAQZP9BnvWE9E/rZjTOhUmn45QRW5oi/ZYqL4VSpPlKIsNWO
         eADfo7yGJm6DgvIfBOPWRndZq0APIs4srW7BzNLmb55IonH7dJ3MhmRafwVws2pyYRWF
         XVejhHmhc1u2np0oDUAAQM7wXVED9Nce/x6Q2WK/nR8pT9l1zkEVHo9BLF6UeeOGcSsI
         WEMdil+Si9QifLNyp7JlZ8FkstDSrMI8SSc2Xg0dsl/sY88tMeKz/opV3DOJLRuJsZSg
         h5qWhBPADgvmJ3Edghe4UqvEozBPxpHuL8ANOQVZHosNTAteqzeEJA73h+UzNylljq5n
         7Ysw==
X-Gm-Message-State: AAQBX9d9JN2cet5fgC8L5fk0/9r3KDur2YBTeoh0LxSV5gUr8mAqm3H/
        c7J4bVEJigojnurksOub7ENIIUPxIZ+Uio5PGUqalFhB
X-Google-Smtp-Source: AKy350a5tWVLA9LxUVTIzgMxG03eXvta7nDCMUaQ7gOG+4tg9H5UjjeMvesbt5Y+YuHsPsbOguFfAABrGM/rbbVA0Fo=
X-Received: by 2002:a2e:7d07:0:b0:2a8:bf09:b1bb with SMTP id
 y7-20020a2e7d07000000b002a8bf09b1bbmr5201282ljc.15.1682525110582; Wed, 26 Apr
 2023 09:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZK70qisom+iSyCoTh2XF70zNAcZUN6bKT2G6k2RoBRq8g@mail.gmail.com>
 <20230426124033.22297-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230426124033.22297-1-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 26 Apr 2023 09:04:58 -0700
Message-ID: <CABBYNZ+dzTYahh6cuFLuFbQQfF_F0h9udWgRuB_AVKMX385Qcw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] shared/bass: Add initial code for handling BASS
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, Apr 26, 2023 at 5:40=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Hi Luiz,
>
> Thank you for the review, I agree that it would be better to implement BA=
SS as
> a standalone plugin, in my opinion, instead of incorporating BASS Client =
as
> part of BAP and separating BASS Server, it would be even better to comple=
tely
> decouple BASS from BAP, so that both Scan Delegator (BASS Server) and
> Broadcast Assistant (BASS Client) roles will be implemented as a separate
> plugin that may or may not be loaded along with the BAP plugin.
>
> What do you think about this?

Yep, go for it, this should also make it easier to create proper unit
tests without having to involve bt_bap instances.

> Regards,
> Iulia



--=20
Luiz Augusto von Dentz
