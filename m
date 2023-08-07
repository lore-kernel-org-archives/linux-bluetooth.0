Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70486C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjHGRXu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjHGRXt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 13:23:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7F107
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 10:23:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso75061371fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429021; x=1692033821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOU5L7LWEIkPaWjX6U2ySnFWYxQ7e3XELLDX5N8LPjk=;
        b=gPZsl/Krnk6Xs9pbwN6q0p8sZpiIne+oWi/l3DmRqrOa9yysB5VH/vcXixs6cwGmff
         PIYtPgghV9o98bmqKsbNAYxmH1w8MYDKV0cMdp/Rvae6pdsZiG0tfU6DtVRqh8QiXJF3
         825N5AB+tcmqoa+gA7nkfXwKym8Z4nZdawxyilDPAy2mMFEeAKLZTKBwKbJ5VFyyULjv
         0r84jXrRWQtKToVqLbGmtnW5/SXFAU3plH1EOUFUyKGJkzbyJ9OeCuAdtENa4rQWLMDS
         Vbt/hOe3hOdd24foOdW+OAf9JegR3uibLx9rDxtb5rHXhzFr6rjrRxuXMbnfpSCi4Boz
         mOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429021; x=1692033821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOU5L7LWEIkPaWjX6U2ySnFWYxQ7e3XELLDX5N8LPjk=;
        b=BVIKwl+T6Kndr5/NKk5dtMg7Ub3KvD72aXI3r38DCEW5T9DqNPGGqr7mId4+NZOGmG
         yLqssOIouANt46sduIBDD1967A+5xwQkDj1uFNRG0aDuZohBfJToYJ299ZNTD4JUHkxV
         X/ePzmI/xfCFegWhX0z8fKj9ct89i+uv7RjfRV8ufCc/MHx4EsMalwxRQb9+HM/4uWqC
         QYfRJM29IQvFXS0nYAmq1sDVT6p+ANmuae/IpcmTGfDQKLoU3sidbM7wOYyfuzF38xJV
         jex7AY/aIOpMyFw5i6QJ6Hy2pHbSOEeJQfsDRgbXiVFwDskEIQjslrcj5b4wStit6SV1
         v/bA==
X-Gm-Message-State: AOJu0YxyO6KEArc0JeFlHgTpX48XoM7nTohwZ4cN3hkiOWfauM6Alkgr
        f+sMRcbo93gVg6HugXaaTMETCMLpokshUtqjB3S9OQFQ
X-Google-Smtp-Source: AGHT+IGf2U9HCMBFRjKBhIQ2BNmrirpzHJfyThkxSEfYVY5vmyX+euejqguFjFoO192y/LO+PMAlUiMKnOcPiv7LmeQ=
X-Received: by 2002:a2e:900c:0:b0:2b6:dac0:affe with SMTP id
 h12-20020a2e900c000000b002b6dac0affemr7235723ljg.31.1691429021205; Mon, 07
 Aug 2023 10:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Aug 2023 10:23:28 -0700
Message-ID: <CABBYNZ+ecHHUfh=3rtXWwp-u2r0kSt-_SRWmYqUJBXgUs6S=oQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Configure BASE using separate structure
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Mon, Aug 7, 2023 at 4:11=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Use preset configuration in capabilities.
> Configure BASE using separate structure.

Im not really sure why we want to switch to use BASE over
Capabilities, up until now Capabilities is sort of mandatory and is
already profile specific in case you are wondering how can someone
detect what is the format used in Capabilities that is based on the
UUID already.

> Claudia Draghicescu (2):
>   client/player: Use preset configuration in capabilities. Configure
>     BASE using separate structure
>   bap: Use the BASE structure received from upper layer
>
>  client/player.c      | 24 +++++++++++++++++-------
>  profiles/audio/bap.c | 13 ++++++++++---
>  2 files changed, 27 insertions(+), 10 deletions(-)
>
>
> base-commit: 80107630396d3d3a3984c599e0cb9b015be0499c
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
