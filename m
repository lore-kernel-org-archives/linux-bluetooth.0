Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E77CC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 19:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjHOTTe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbjHOTT3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 15:19:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F71FFE
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 12:18:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so85387241fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692127070; x=1692731870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT9RhN8biKhym+6DEpm73zSZsTdklPEko9APDlfwQ/o=;
        b=ZmshoJSnZ3syyBir4buaS7MLdXnKrMO3Shrr+qVmnZN9pZNMqHf1CKhHmWV8G+yZcn
         j3XyBM2S+7jjpl8QK5GcJGwQN+uMzbeFPjg5N115u8FPL9SuFXMxvlI2zd0o7j2ocB0P
         pbKHAEDp4aYvpuzHcgOCZmjM9zMhAn+nAMuYBUbT36NMx8cPs2VmZvUQRGZ8uWYJqxH1
         TttSzYaYmXYSFMIPDXat7wNhXxUd1Pe+UW2OITTJUjFh2KXnrHinklv0dPRpgpOyNKLN
         wvZmTcRUFkYujZeyt7t4OjGFH6cWm8AZLnecZrgz0r6ARBhGiOj3uvhojHS0V55Yzz6k
         QfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692127070; x=1692731870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT9RhN8biKhym+6DEpm73zSZsTdklPEko9APDlfwQ/o=;
        b=gyX+bKP3kfkC7IE4R9HR5sxOaHjCBkwDE9cPhzkb6Yn5wdTgUf48f7AVGiIpW63JRi
         FTKut0BPB22/keF2JdUI/lra40zjm4lRj9O9YA6vtyn5lcKv8kn1LBwrcUSKqYr19qVP
         Uq57qvwPUYTNYlibCN/yGD+t50KikOP5Pofo4jA8BHnsfw2yCHw9igRZMLh2rWE49Zz4
         ee6hvOAjX5yFBosvDnpBoJpAVb5zNA3pGmUWrhPwmHZkbT8pM9coUhjoszkmwXROXY9a
         hV+pP3N7ZYlLbO2w8XWnXrAWRnJnmUbm2/ZYX93mCP+zwVbGefg6cy3Zmh99M5uZOHco
         QjoA==
X-Gm-Message-State: AOJu0YxsekuzfN0ny+nLZ7Ew3LSESyyT53NjIETcmq4+pvKvj30ONTdw
        sG6Ui4inXTTKcwh6D8cC3fFcyxf6Mlu+/ZW9xOLF0Isf
X-Google-Smtp-Source: AGHT+IFatxcSlgRBweF5DY3ljb1sKpC/FaZcIPGVldrR1TVVymU6pIjIHUerxj591GriRhQj+VYJP19MW3lUSJAf77M=
X-Received: by 2002:a2e:b174:0:b0:2b9:cce3:a126 with SMTP id
 a20-20020a2eb174000000b002b9cce3a126mr9686477ljm.21.1692127069521; Tue, 15
 Aug 2023 12:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
 <CABBYNZ+ecHHUfh=3rtXWwp-u2r0kSt-_SRWmYqUJBXgUs6S=oQ@mail.gmail.com> <VI1PR04MB53446602D3975AF7A5548A03EB12A@VI1PR04MB5344.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB53446602D3975AF7A5548A03EB12A@VI1PR04MB5344.eurprd04.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Aug 2023 12:17:37 -0700
Message-ID: <CABBYNZL3SWe_8kn--LY3xvp9pW46xFT4y1ZMXO2dAppK3qo-Rg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 0/2] Configure BASE using separate structure
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Claudia Cristina Draghicescu <claudia.rosu@nxp.com>,
        Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Wed, Aug 9, 2023 at 2:46=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> >From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> >Sent: Monday, August 7, 2023 8:23 PM
> >To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
> >Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu <claud=
ia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>; Vl=
ad Pruteanu <vlad.pruteanu@nxp.com>; Andrei Istodorescu <andrei.istodorescu=
@nxp.com>; Iulia Tanasescu <iulia.tanasescu@nxp.com>
> >Subject: [EXT] Re: [PATCH v2 0/2] Configure BASE using separate structur=
e
> >
> >Caution: This is an external email. Please take care when clicking links=
 or opening attachments. When in doubt, report the message using the 'Repor=
t this email' button
> >
> >
> >Hi Silviu,
> >
> >On Mon, Aug 7, 2023 at 4:11=E2=80=AFAM Silviu Florian Barbulescu <silviu=
.barbulescu@nxp.com> wrote:
> >>
> >> Use preset configuration in capabilities.
> >> Configure BASE using separate structure.
> >
> >Im not really sure why we want to switch to use BASE over Capabilities, =
up until now Capabilities is sort of mandatory and is already profile speci=
fic in case you are wondering how can someone detect what is the format use=
d in Capabilities that is based on the UUID already.
>
> Hi Luiz, we don't intend to switch use BASE over Capabilities, we just wa=
nt to use both for broadcast. Capabilities for codec capabilities from pres=
et that will be used in transport configuration. BASE is used for the over-=
the-air payload in Periodic Adv Data which is conformant to Table 3.15: For=
mat of BASE used in Basic Audio Announcements from BAP Specification, also =
it is used for PTS testing that ask to modify the BASE structure. And we wi=
ll copy the capabilities preset to the base structure to be sure we have th=
e same codec capabilities in both of them.

Not really following you here, if the Capabilities does contain the
codec settings what does the BASE would have, having the same
information twice sounds like a bad idea if this is where you are
heading because it can cause inconsistencies and I'd like to maintain
some symmetry with the unicast so the application have an easier time
to set it up, even though we need to have some work on it for adapting
to BASE format, but this should simplify for example use cases where
the streaming goes from broadcast->unicast and vice-versa.

Btw, we intend to have a release soon, so I hope we can pick up the
pace here, so let me know if you want to sync-up offline.

>
> >
> >> Claudia Draghicescu (2):
> >>   client/player: Use preset configuration in capabilities. Configure
> >>     BASE using separate structure
> >>   bap: Use the BASE structure received from upper layer
> >>
> >>  client/player.c      | 24 +++++++++++++++++-------
> >>  profiles/audio/bap.c | 13 ++++++++++---
> >>  2 files changed, 27 insertions(+), 10 deletions(-)
> >>
> >>
> >> base-commit: 80107630396d3d3a3984c599e0cb9b015be0499c
> >> --
> >> 2.34.1
> >>
> >
> >
> >--
> >Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
