Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A3EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 20:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFZUFP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjFZUEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 16:04:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619726B8
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 13:04:38 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6a152a933so22539591fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687809877; x=1690401877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y9hI5m+9YCKqVHgRpV6LEmudivWd2mAwMbCHqHrjl4=;
        b=EyGj7Ww5FOeUP09b+mLU76Q4UqJFjJ0k3w94p4mqJ/PtLV4YZmsIgyuvXXIryXjUBy
         qNjGf8LIOgx+zrrKj7fnN25sXiK+QoqZSOrg5rEwkxfSrnWHiqqHBq2ToWnaPPNCgQa2
         YqokTJChe7GICSfNh0BmmNmGSlFhpJ7+bY2vplMt8Rfq6jAkfEuIkYbxEN/HyJpa6H/K
         2qDT/KY+yXjn7sqqNU95Iz04AlkGhaovz4t0r3z7tjDzbDaxiRFeeQKT5BMvkUpF0O+M
         OnAskpEd+W7F+kja5iG4zrLOPPi88CWe9SyBS8vc/ZVlsQ03VKaMKAqy4o+Vm+W1YoQS
         uMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809877; x=1690401877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y9hI5m+9YCKqVHgRpV6LEmudivWd2mAwMbCHqHrjl4=;
        b=Eeo1jq38kDUhGWM7QKx16L+yTpvJSLOtsIz19qHBndAORARYES05gGCidydrJ20VMr
         f/X3O4tNrMIMxGAm5hGfCIbJyt/Gtdjl48yIfUc1Kej8J1IMJNlwrcAaX8HHFjS1sx1M
         zzrQ16jjzv79Qs6DIJQq9hL8HgMiTCOwc/+RykMVBj6YNM0KJ/f+kER6zeXEE2dcAN6V
         f5SM026GIq8p/Sx62aIeFdFmILN8Ev1Sx5y9mCjuxR/t6ZV8iVV9alNEtYXT5LbMBUE3
         ux+RcjefTzG1IBg5snRMlZdaQWm3SoP1DDD4KCPpkrBjEU8jbLHMC5t+hYtjK2/+8n+Q
         SRGw==
X-Gm-Message-State: AC+VfDzCZzJh569WJde8n12DXXzjBNUtpe98hy2OH8xwnOyzpyZeRgMd
        RMW44MRf5kgi58Iu2GPGppFHh/CEKN0Mh2iVDlNVGchc7kWPGA==
X-Google-Smtp-Source: ACHHUZ7pLauKXgFumLww5rWAez+tZNokTvA22bS2l2gxGkPdy9SBLjjLErz9TKNVOchZB9WkAA5jpC2NWYIg7H3bb1k=
X-Received: by 2002:a2e:8842:0:b0:2b4:6b64:6855 with SMTP id
 z2-20020a2e8842000000b002b46b646855mr16339706ljj.24.1687809876563; Mon, 26
 Jun 2023 13:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230623074657.16618-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230623074657.16618-1-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Jun 2023 13:04:24 -0700
Message-ID: <CABBYNZJxjggNE45_U+adaLLD1FXstt5U91wKJMy=qJoRoZ09LQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] shared/bass: Introduce Add Source opcode handler
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Fri, Jun 23, 2023 at 12:51=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> This patch series adds the BASS control point handler
> for the Add Source operation.
>
> If instructed by a Client through the Add Source opcode,
> the BASS Server attempts to synchronize to a Broadcast
> Source, by opening a btio channel.
>
> The BT_IO_OPT_ISO_BC_ADDR btio option has been added,
> to allow binding a socket to a broadcast address.

Im having second thoughts on this, Im not sure if it is a good idea to
introduce BT_IO_OPT_ISO_BC_ADDR, there are already options to set the
address and address type, perhaps we should add what is missing e.g.
num of bis, etc. At least on iso-test the logic I used was that if a
destination is given for listen then it must be a broadcast address.

> The BASS adapter_probe callback has been implemented,
> in order to automatically configure BASS into the adapter
> database. The adapter bdaddr is also stored along with the
> BASS database configuration, and this address will be used
> as the source address when binding the btio channel.
>
> Iulia Tanasescu (2):
>   btio: Add option for binding iso broadcast address
>   shared/bass: Introduce Add Source opcode handler
>
>  Makefile.am           |   2 +-
>  btio/btio.c           |  56 +++++-
>  btio/btio.h           |   3 +-
>  profiles/audio/bass.c |  26 ++-
>  src/shared/bass.c     | 424 ++++++++++++++++++++++++++++++++++++++++--
>  src/shared/bass.h     |  14 +-
>  unit/test-bass.c      |   2 +-
>  7 files changed, 498 insertions(+), 29 deletions(-)
>
>
> base-commit: 37042ca9c6ddcdbbb0899b3d62238935cd53f443
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
