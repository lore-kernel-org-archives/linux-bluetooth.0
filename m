Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88226C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 16:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjFHQbV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjFHQbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 12:31:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7451FDC
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 09:31:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so7834251fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jun 2023 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241860; x=1688833860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoX8dvL2hg8wOu4Yb3cKNusqmeBx6AACXJ7oe2eKHBg=;
        b=Cku4KkD8L/fX+h8QWwik79Qrk3LD2EKOAX21flpO0ZVVR0nP084e7Y+l5DW7GKot1h
         WlS+Dc5l6BYwOmRy4MUeKiuhJlx+cOMon4+Bi774rTWPQPCl9r0fJ0j1kccxqLp6/hyG
         dACHm8n6sKxv+fv/nWNg93pV2ALuQZPzf2MqPDUTe3QwgB3cVWHWJKEExt5JNPM+XicZ
         GIOYVr1Y7uWnqM+zOwD0F8Bwnsz8iWHzhvQ7BbDTrohJZ8JOhVdrgegp1bCJmZwk5H4G
         HXw3g6Pk2a5vw+uFTjApZP5RSjFpQ4Dx4rYzVOezjMk6i6/zCcRFI3W8AlsMc4b+VxCl
         yikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241860; x=1688833860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoX8dvL2hg8wOu4Yb3cKNusqmeBx6AACXJ7oe2eKHBg=;
        b=UrGzWkg8ZSuDjUym8hzKpPLDlJYXUHHNqoXXlJs5cEor4C4qFH7D2UaivwVZJUGOGi
         05Posp3o3GlvJaab1VUHIm88T5jTNafcoUS5eXXZpfrp5c8oGQj6CPeRDYj38Wqx5HkT
         cjuM8oWhxyn7S4vq2zT14MTrfjiP65Q5i9RUJxFBPtJThdBWhGZWyeo1xiIQgDTEQY5a
         I29p9+hHp/+wguzWmAaSpPoawkP7xOvLi0o4+xnv3s3jxJqnmbexx1H4qCRgA63s2VTK
         rkd8IMFFS8WTZq66C28cLJrgjj3NjVlffpW7N6FO3TG51fdG38dtOYCF8OFJ+JIU6wrI
         f0PA==
X-Gm-Message-State: AC+VfDwnibch+7Vp0G8Mz+JlgCpji0SkKGKGDNJOU+lHF4Pkflv9WRmW
        7oMb+jOZBfn3sbKhvwPKK8w1OdqLogk1yOvHBHi7gvQS
X-Google-Smtp-Source: ACHHUZ7pec275IhwhK7mSONHCcgAPs5r1/GCLatr84Y5yk//Ix/R1qwRKmDzMsPOEanPJ0tNjK2MNEIvEdXJG8tx2jA=
X-Received: by 2002:a2e:9b94:0:b0:2b1:df76:294a with SMTP id
 z20-20020a2e9b94000000b002b1df76294amr4215181lji.43.1686241859890; Thu, 08
 Jun 2023 09:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230608120945.4478-2-nitin.jadhav@nxp.com> <6481d94f.e90a0220.753a5.1152@mx.google.com>
In-Reply-To: <6481d94f.e90a0220.753a5.1152@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Jun 2023 09:30:47 -0700
Message-ID: <CABBYNZKm3wcg8ru4UYoGm7H8VU1uD17x==AfEoVpWispmBf6hg@mail.gmail.com>
Subject: Re: Code handling for VOCS service
To:     linux-bluetooth@vger.kernel.org
Cc:     nitin.jadhav@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nitin,

On Thu, Jun 8, 2023 at 6:47=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D755=
311
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.56 seconds
> GitLint                       PASS      0.73 seconds
> BuildEll                      PASS      27.18 seconds
> BluezMake                     PASS      872.62 seconds
> MakeCheck                     PASS      12.79 seconds
> MakeDistcheck                 PASS      155.29 seconds
> CheckValgrind                 PASS      255.44 seconds
> CheckSmatch                   PASS      341.24 seconds
> bluezmakeextell               PASS      102.91 seconds
> IncrementalBuild              PASS      1436.49 seconds
> ScanBuild                     WARNING   1046.77 seconds
>
> Details
> ##############################
> Test: ScanBuild - WARNING
> Desc: Run Scan Build
> Output:
> src/shared/vcp.c:1273:3: warning: Null pointer passed to 1st parameter ex=
pecting 'nonnull'
>                 memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/vcp.c:1275:39: warning: Dereference of null pointer (loaded fr=
om variable 'vocs_audio_loc_n')
>         DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
>                                              ^~~~~~~~~~~~~~~~~
> src/shared/vcp.c:31:57: note: expanded from macro 'DBG'
>         vcp_debug(_vcp, "%s:%s() " fmt, __FILE__, __func__, ## arg)
>                                                                ^~~
> 2 warnings generated.

Please have a look at these warnings.

>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
