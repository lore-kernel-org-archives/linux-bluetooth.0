Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DA6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 22:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA58861439
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 22:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbhI2Wsy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346734AbhI2Wsy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 18:48:54 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF7EC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 15:47:12 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id 64so2745214uab.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sIbQ/ee8lsT1u69FQZUM/MlcxSG2d2zzf7wj1zG2r68=;
        b=bAni+PcZDzRy7WYrbA8L1U1BOz5Pu60TCMMq3r6BwvhzaVeHiZFWt+TGug/fG3gLuv
         jpXdIDDImQcwCyS+84aKjqItUhmuHCYsN4LD7NdujRW/aSxi9+RhSJn1ju/XuUzXEbVF
         G9Jgsv2kqyA4loPdACzVg8rvOMOzbTA8rjQFDG7E3BG05QRusKgzbBA1B1UUHRby8x8n
         xcMFm6FTSGHzMNb0KalcCI07c/S9R5axY92GEPo7kgQyBPiYnj0PgYo+Q4kbxskmi89r
         wBV+sXaNEdFI1hOW8fK2xd8TbJNIldC2/KqL2pny7St6iioI7BbclDqWQCyvEVgdlErk
         Vg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sIbQ/ee8lsT1u69FQZUM/MlcxSG2d2zzf7wj1zG2r68=;
        b=j9ad8Nxw/7PDx8sj5uqMqqaUgZreLmVMVbQTA8rOx3k/14TgSYPlaGvoNhpXcAZCLu
         k3NDXzJQl+UWfGZKurBghpYMydCFE/dI/kQ75lrY5H4wCIbM3PvERM/VhL5mnrA+MKP+
         SFu8GHXbugkTeRLGnqLyM+/lI9G+Ygj3geadFEf6afN0xy7Wk/f9FS+FlRYZbG2etvKi
         uCC9EP/5D7WZh+G2XJSQAQCMgjqDb32Rq7EsywUiO6VUbNes4p7Yx/p7DkCKCnqSzCGq
         Z1TDI2XvNtW3avqxOgYAZ0KDfG9lDVXB5mQVNEWiupPngYaBR1GimLatLlT4giVQiQTg
         N6Jw==
X-Gm-Message-State: AOAM530wbWiu9dY+w67W6hvpLlCxgFCjFlVlG7g+7TwT0Lb3CZW2yzyJ
        GqmLpx+jHQ+YKcxcFjtEzpbg9cswVFx1V7lHGPkeAhxz
X-Google-Smtp-Source: ABdhPJxQxXHGhqfQKnySmZaJLhsR9fDbP2unTOnQ7tTbDyS4CEBb2aprpzNMPUNgK5EnoTjbACRT+2+bH69gQIueERk=
X-Received: by 2002:ab0:5b89:: with SMTP id y9mr2759125uae.47.1632955631463;
 Wed, 29 Sep 2021 15:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210928235447.3077055-1-luiz.dentz@gmail.com> <6153c08d.1c69fb81.f5831.4749@mx.google.com>
In-Reply-To: <6153c08d.1c69fb81.f5831.4749@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 15:47:00 -0700
Message-ID: <CABBYNZLKvLjzrTbG5Uvy8T49cOMOcRUJOUr0qo620CV8vd_WVA@mail.gmail.com>
Subject: Re: [BlueZ,1/5] gatt-api: Add MTU property to GattCharacteristic1
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Sep 28, 2021 at 6:25 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=554631
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      6.84 seconds
> GitLint                       PASS      4.61 seconds
> Prep - Setup ELL              PASS      50.24 seconds
> Build - Prep                  PASS      0.49 seconds
> Build - Configure             PASS      9.07 seconds
> Build - Make                  PASS      219.53 seconds
> Make Check                    PASS      9.21 seconds
> Make Distcheck                PASS      256.90 seconds
> Build w/ext ELL - Configure   PASS      9.34 seconds
> Build w/ext ELL - Make        PASS      205.94 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
