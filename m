Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C283C25B48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 21:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjJZVcS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 17:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJZVcS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 17:32:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4FC1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 14:32:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c5b7764016so3009381fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698355934; x=1698960734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYWNCemP1S/ZSISpqFSzC7Meht4Va/qoVbxQSBGL8bE=;
        b=S8X8HsJ/UoBbH9QRvezGSY65kAEC9evqAAv67kew+ljvqvkgvgIqRm1Y3+Fi6MS76C
         Qp1dtWtCWRWFZqv0b0jvBdzbT0Nipx/Yuvy+QodaxJnpAL8sZLCyWm5fiEv/W7oktnjz
         d3FC2rOuqxbzTMvi3XiDOSpVgRwbIKsKenI6CwfTvLV5JaTNEJCUEL8v8LoTiILXKRuy
         FeBpDNSBlGSMmGEZmHaPZg90m6mF2JPtrcEo+FUQB3hXMwPP8hKrK0bsEMXEi3tI7WmY
         BPaRBbagDYJtchMVqT6S2dUvkDmm0yvuDDE+4PuG7lx5w9r1TfUzPb9/hUPMRfyWJ9Vu
         cviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355934; x=1698960734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYWNCemP1S/ZSISpqFSzC7Meht4Va/qoVbxQSBGL8bE=;
        b=CqUpDfIieN00zS3jXLRdTnhnYIaPPpDKIIaX4njY4FEML9Istfi3maoDhTyHoXWLi0
         jpO73Bkykq9DObpYC4YfadOamgtpcOfseYU4v5m/f8P1MRbfqTx8Dreq3PswwYKWgklS
         a2DdsKwP8qx+Bz7F6t9LBq8JnbfWTCQhd+deSC09u0LghWoWBxZl6CwS860i3lxEuCK0
         fb1sNdME4jHd7t0liyc1MML83EmOOVOgJK87sgoEYutSEukgWQBVBIgUmaslXX97kLQS
         lBumPUx46OrONlC1SSGBinqoMFDtnEs49CHF3q35W60/1DfwT/42I9d2lx5P9v11tjF4
         pzjQ==
X-Gm-Message-State: AOJu0YxqJwqwqlPLCTnd46LxF0/BYX99IeCoj/lYVAUgLrMxxpSWTd4w
        2o1WU/lvnzCaSEYAOuJ+ZRZV1j5VjRMUd6+s338=
X-Google-Smtp-Source: AGHT+IE/qAqI5pMEY3FtTduhH0kiKtCOpgdEJXgvIyrOZTQTGWbOo6QIQQdBJC6qlY8prsDMtIf91ufCTkYqE4IV6Tw=
X-Received: by 2002:a2e:5012:0:b0:2c5:16d0:69ab with SMTP id
 e18-20020a2e5012000000b002c516d069abmr621792ljb.44.1698355933404; Thu, 26 Oct
 2023 14:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Oct 2023 14:32:01 -0700
Message-ID: <CABBYNZ+nFSYXca2izExm0c=-ao2K211O50GzS2EQhZCRHzUHrA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for multiple BISes
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

On Thu, Oct 26, 2023 at 7:51=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Add support for multiple BIS-es
> How to configure multiple BIS-es:
> In main.conf set the number of required BISes in NumberOfBISes field of
> the newly added Bcast section.
> In the base_lc3_48_4_1 struct set the configuration for the base
> Continue with the registering endpoint for the broadcast source
> endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> Use the endpoint.config command to set the BIS codec configuration by
> specifying the BIS when prompted by the command
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] BIG (value): 0
> [/local/endpoint/ep0] BIS (value): 1
> Use this endpoint config command to configure all the BISes
> After all BISes are configured, use the transports to send data

Don't think it is a good idea to use main.conf for entering this, in
fact I think we should get rid of BIS and instead have it as number of
BIS because we no longer use the BIS ID as Adv Set ID, or perhaps we
can use the max transport as number of BIS since each BIS shall have a
correspondent transport/socket, either way it shall be the upper layer
that defines how many BIS to configure.

>
> Claudia Draghicescu (2):
>   bap: Fix source+sink endpoint registration
>   bap: Fix source+sink endpoint registration
>
> Silviu Florian Barbulescu (4):
>   src: Add support for defining the number of BISes in the main.conf
>   Add support for multiple BISes
>   profiles/audio/transport.c: Add support for multiple BISes
>   client/player.c: Add support for multiple BISes
>
>  btio/btio.c                |   4 +-
>  client/player.c            |  57 ++++-
>  profiles/audio/bap.c       | 483 +++++++++++++++++++++++++------------
>  profiles/audio/media.c     |   3 +-
>  profiles/audio/transport.c |  49 ++--
>  src/btd.h                  |   6 +
>  src/main.c                 |  10 +
>  src/main.conf              |   8 +
>  src/shared/bap.c           | 254 ++++++++++++++-----
>  src/shared/bap.h           |  39 ++-
>  unit/test-bap.c            |  12 +-
>  11 files changed, 678 insertions(+), 247 deletions(-)
>
>
> base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
