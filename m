Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02ADC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 01:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EAE64F92
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 01:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCQBTP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 21:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCQBTH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 21:19:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7D5C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 18:19:07 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w195so33538832oif.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 18:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pVJZjZBtU65vWoM3zStm/kMlpWrA6GHn2ykDMdVs2gY=;
        b=CoPBYl1WydtE33UwlGPHG8p2cQtxEV3wxAbXI8cU0v7FbeQFMxZFu1vxmHy6tQcQ+A
         qNbYJkw5K1ATJVwhdTW/gJD/zI6wRucZDlrk6+cmqbgYhERQ9GrWHbwcZ6MGHnAWimng
         9mrgZaZN7cn2bTb2pwIApRP+8FfQK1Cn7U1zImn+739s5MPWaALLOQC0E/uxFCjY43wE
         fPi8DVFQjOPMH/I2ZllEbXrg5bsJFp1KsUxI2btayeK+O9l8V4w8byyozHve9pEwTZaU
         7N87ni/xAfgfsYkO0SLn2qSd0cazp3uaqwbQqvYN9QeN8ZukKXsZDXaiSkaLbBgsi6UA
         zb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pVJZjZBtU65vWoM3zStm/kMlpWrA6GHn2ykDMdVs2gY=;
        b=sQKC0vY7fDyKeMYta5cGUkGssYb7k232XcCIx/Z5lBXIVja5aaYcIAfr6VRccGizyM
         nRZW0ifnN8YiNE4N5tugGvg48UdKGccr8RBq//+xsrCKpfsmitar2vp/hX3SSuWKH2KW
         dxNcsHlj7EwJfA3M03zvpg6wEko7DTKSNJOESRBV3E7X+gYEEAYOYeMPO/g/CdnBWUvZ
         Fpdmv8pIFP9k3tN/JALmJvXO6F7Vk5Eb17iNQ3KSPh+6nQuCxBApanIKeQNh2WaOQbFb
         mPvWN+W96S5Dn4prvdZlvvAmdPmLX3LjKOXPgVeqMep8KNQkFr6Xw2+ebrL9GdzIQ667
         oAfQ==
X-Gm-Message-State: AOAM532nd9DHxl0gHMuGjm9qWa+G9s40G9+PcJ9fU4wn5bFI2cn/JwNR
        qEHlCTHLNMkYCILPtPSW4vlB4pYD9jkyCyCeUywOeApk7DU=
X-Google-Smtp-Source: ABdhPJwLx2IhR5MSJ4vS8RjXQMVbErMNP0+KBBssfMZfdHPGHvGfQbI1IFb4IcbR5uO0Y4n+jV8QRxqWcBXQNZYdBaw=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr1055829oiw.161.1615943946104;
 Tue, 16 Mar 2021 18:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210316144136.410-2-cdwhite13@gmail.com> <6050c8be.1c69fb81.680f3.60d3@mx.google.com>
In-Reply-To: <6050c8be.1c69fb81.680f3.60d3@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Mar 2021 18:18:55 -0700
Message-ID: <CABBYNZK_97ebCpdDHMSDLubu6o_zJw1W0xndmU3zySMcxjJyDA@mail.gmail.com>
Subject: Re: emulator: Add Create BIG command in emulator
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     cdwhite13@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Tue, Mar 16, 2021 at 3:46 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D449=
125
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - FAIL
> Output:
> emulator/btdev.c: In function =E2=80=98cmd_create_big_complete=E2=80=99:
> emulator/btdev.c:4529:6: error: =E2=80=98struct bt_hci_evt_le_big_complet=
e=E2=80=99 has no member named =E2=80=98big_id=E2=80=99
>  4529 |   evt.big_id =3D cmd->big_id;
>       |      ^
> emulator/btdev.c:4529:19: error: =E2=80=98const struct bt_hci_cmd_le_crea=
te_big=E2=80=99 has no member named =E2=80=98big_id=E2=80=99
>  4529 |   evt.big_id =3D cmd->big_id;
>       |                   ^~
> make[1]: *** [Makefile:6794: emulator/btdev.o] Error 1
> make: *** [Makefile:4023: all] Error 2

There is some build errors, big_id has been renamed to handle at some
point, you should always rebase on top to master before submitting
upstream otherwise these errors could happen.

>
> ##############################
> Test: MakeCheck - SKIPPED
> Output:
> checkbuild not success
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
