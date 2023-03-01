Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC06C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 21:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCAVF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAVF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 16:05:28 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520C4ECE2
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 13:05:27 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id n2so19390480lfb.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Mar 2023 13:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BYqWVhhaUCD5gwOz92ODJ7fVQaO7oMM21BkoCV7oWs=;
        b=XnE3RKoftiiMpg54E7c54J0NjYfEQEY8tWrQE+2rCL1own23m+DpUIbZw0uhHb2fA1
         CT+udftjVerx85/6YVdxBzk6+Vt9ny+u+enHD26TUGjVXffpB0b5QJvhGtqP1k1EJ1DX
         ZmrGTQP3zARRFXAGrvEGcR8ON4fhO2V6N8z128HiYtIO8HG9UGaFSDj+Iw81nBTV/io1
         zKggN8ODcCZLeqoohBBfXgxwH53N8GadZadxV1MPssutEjPcqRA54dw7dGSt7o45kD1z
         CJpNgUNuPHIZI4t8HULIfk8Rfm+awFtPRjhDPZSEvJ67r4xM7G3CWCyoSgZ+EgUh5Wk3
         YJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BYqWVhhaUCD5gwOz92ODJ7fVQaO7oMM21BkoCV7oWs=;
        b=iv469arcYs38M9rF72UliFItrRKsYCjSRcGGcGr4cdMWcQRAe83/WrHIYRfmGv2knX
         n72Z4JbJGMJ7B63Sd+DNlT6gL1SAu6kSoPN6dnZmKACX7VnsXWN3je7KakO8FZX3HFX5
         7Bd+Btx1dPbbRvXnkXbAnPJKIKtuilJV/LM3j4R/0VpD3HDYY4z9LMdwvRw6AA7mkbDy
         8nLaOYARD531KROOsqqXjUz246Ou/qL9G8B9c/CKS7MWDvzAdGZ8NcE8AG1BiExlz8i+
         MA8e4BPcu32W/iBaRHtJlZ0pKkaZujAKFeRok1Nawr3g5qZrCJMg0TZZwDColKL4gB04
         NdDQ==
X-Gm-Message-State: AO0yUKUTBSVh56fL/DaX4994A0/9qNw++/t1UETlAfyUSH7yoCLbWJkm
        BrQVXEq1BD9MWPNmQ2AJj+WV2M3F8dMyX6aNMLgjSuZb6Lc=
X-Google-Smtp-Source: AK7set/KBNAI2mKp4NWZcK6RhxzcRE2yRW508UrtlXIBnPtso1LdbS3EN6hoAoCMHql4RcRddfmQLLobY1F6+mul/rA=
X-Received: by 2002:ac2:51ba:0:b0:4d5:ca32:68a3 with SMTP id
 f26-20020ac251ba000000b004d5ca3268a3mr2237301lfk.8.1677704725788; Wed, 01 Mar
 2023 13:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20230301153322.12555-1-iulia.tanasescu@nxp.com> <20230301153322.12555-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230301153322.12555-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Mar 2023 13:05:14 -0800
Message-ID: <CABBYNZK9_McOdhoyC=MaOBSaFVidphpRgnuMZJH7FXXiyWia5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] lib: Add BASS UUIDs and auxiliary defines
To:     iulia-tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, Mar 1, 2023 at 7:41=E2=80=AFAM iulia-tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> Added BASS and Audio Announcement UUIDs, added OCF for
> BIG Create Sync.
>
> ---
>  lib/hci.h  | 2 ++
>  lib/uuid.h | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/lib/hci.h b/lib/hci.h
> index 50f385c1e..d01e6f8ee 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -1731,6 +1731,8 @@ typedef struct {
>  } __attribute__ ((packed)) le_set_address_resolution_enable_cp;
>  #define LE_SET_ADDRESS_RESOLUTION_ENABLE_CP_SIZE 1
>
> +#define OCF_LE_BIG_CREATE_SYNC                 0x006B

We shouldn't be generating HCI commands directly from userspace,
instead we use the so called ISO socket with address set to
00:00:00:00:00:00, see isotest for a reference:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/isotest.rst#n=
180
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/isotest.c#n37=
9

>  /* Vendor specific commands */
>  #define OGF_VENDOR_CMD         0x3f
>
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 84ff46cd8..a6bbc3770 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -164,6 +164,13 @@ extern "C" {
>  #define ASE_SOURCE_UUID                                        0x2bc5
>  #define ASE_CP_UUID                                    0x2bc6
>
> +#define BASS_UUID                                      0x184f
> +#define BCST_AUDIO_SCAN_CP_UUID                                0x2bc7
> +#define BCST_RECV_STATE_UUID                           0x2bc8

It is probably a good idea to start with adding support to decode
these on btmon:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/monitor/att.c#n2475

> +
> +#define BCST_AUDIO_ANNOUNCEMENT_SERVICE_UUID           0x1852
> +#define BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID          0x1851
> +
>  #define VCS_UUID                                       0x1844
>  #define VOL_OFFSET_CS_UUID                             0x1845
>  #define AUDIO_INPUT_CS_UUID                            0x1843
> --
> 2.34.1



--=20
Luiz Augusto von Dentz
