Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F9C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 17:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjG1Rou (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjG1Rot (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 13:44:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F40D10CB
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:44:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso41291701fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690566285; x=1691171085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzm0oomkxL1gjC/VcCD83yTPNS8Z689poUDOoVqpuW0=;
        b=Swsk6GPI+Ln8j0AnZig56ns7hq8Sr5UmOnsM64wphdheyyYw/QpG77zgKTKihTraJg
         meD+oM2ZLFSZgFA4Y44myCDQRuFGq6NTOr7yHdkFbf9rIq7TQgiqBnLPe+0jTicuq2eO
         ly+ChST2V1OJmMPNofksf+nuvV3R62vvdjbps9O25zXd5XrmSnKvTUN4FfQz0A1TB8sW
         3prvep5gBFIzEHsKIvHl/ju5z3itDBFbT03o5iTKqIME1EnDf0tGhfmZ4dfbkvSWL4I+
         3BiX+phV3TuR8JPlIzKhnycixP+s1MLu5i71x0kkE7R73rIdcv9keBg3eJjlbaPSSNEx
         686A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566285; x=1691171085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzm0oomkxL1gjC/VcCD83yTPNS8Z689poUDOoVqpuW0=;
        b=Lu8GqRZ+rS0qujJGV8FDIAExUTNRNhVgIMPeFMSQem/03lI2qPLAexDpAJrds5O8W7
         V9ntwlJJpF9KnbMv9dAd9DvbT2f4uri62M/vmVx9pd+v6vBwKMgUGyDnBafaHx61LK0w
         k5Rr3YfM1vjh+fc9i4PTICPwbyCAKrNzvVQbtyUp16ViSzYLxSILp7u9u9jWyFRnwhD6
         aduiBH0KYrjYRHq/xpcsSgQxkUV2dypQJ+qOXyfXXqzRbBMHLpau6zsPt5A9Oy/Kf6KJ
         3w3R6b3qyerjgmn6LHOwFdg080GVYLh6faoNcFP4wV/5cUD+Ipl+Eyefxn8yevfpzvHS
         djrw==
X-Gm-Message-State: ABy/qLa1GWDLcXykq4zyVOSoWm49XFUTxRekfzHbZicUz3dIyx2wVgL8
        ievJOS3CeH1Mbu2ZxVu0lbNURGk3Av2BxFRoS4Bc164A
X-Google-Smtp-Source: APBJJlG+wmB9n6ivKAz+U4wdWCi7qJTFQUZ1z5pejTF2cTGz9XJZ88JCTXkmQHkENIAoKK4jDmzE9qpX97dIxxNdoH4=
X-Received: by 2002:a2e:b6c8:0:b0:2b4:6a06:4c26 with SMTP id
 m8-20020a2eb6c8000000b002b46a064c26mr1133563ljo.2.1690566284962; Fri, 28 Jul
 2023 10:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230728052506.582394-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230728052506.582394-1-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Jul 2023 10:44:32 -0700
Message-ID: <CABBYNZ+pM9QhWFBPiLSTbcxa2Nz4nTfA36Mr+7HF+zO5hcaPyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/1] Adapter1.ConnectDevice
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Jul 27, 2023 at 11:00=E2=80=AFPM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> I added some minor addition to documentation and also I tested calling
> function via DBus in parallel to same device.
>
> In both case of BR/EDR both DBus calls will be pending and they will
> finish at same time when Page Timeout arrives or connection. I think
> this can be considered as correct behaviour.
>
> In case of LE first one will be pending and second one will get
> "org.bluez.Error.Failed: Connect failed" immediately. Later first
> one will timeout.
>
> Simon Mikuda (1):
>   adapter: Be able to use ConnectDevice for discovered devices
>
>  doc/adapter-api.txt | 2 +-
>  src/adapter.c       | 3 ---

Please split the documentation changes from the code changes.

>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
