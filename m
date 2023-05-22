Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFE5C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjEVU2a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjEVU2F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 16:28:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23568C2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 13:28:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3bb395e69so2586759e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684787282; x=1687379282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwl8V7kMKtXwYqWAIQt9Nxhin8Pl0m0WhMCHGNUOw8c=;
        b=oU7OV+sL+e4Q3CIp0dA8v3Q/3RPKuc14UeCgbuPAhyfbvqtsLtiNh3dk2V6XnpYFUB
         UQ0dOqRP+/nEW+PYC5GrjRPhhvAQCaZoSyAcb0v735dU8xdFVSl7/DsT3afvgSLd3kR5
         LRmjFTit9eT0AfJ67ow7erSBTKsMBRvTtcgvry3HKFQcXtWWiczicdrgDlEEHWKQW4my
         bWGu30Gt9gMNw4uiriSiXbvbp/B7HS1tMzT3mBWY6SYX4bDY4c25Rrq9Hipv+JzJXjfJ
         uhQsAMMX5zoRVuxMrBrWAOdCbORvGt+eRpuNDBD119i6tTBh77RPOg63YHBW+4WDG0cJ
         lfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787282; x=1687379282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwl8V7kMKtXwYqWAIQt9Nxhin8Pl0m0WhMCHGNUOw8c=;
        b=ekRq94meX0tWLG/b/Be9OfrkMdPkKH8fhwZhbveGT9cCLMPWvNnpRhKHkmC4v03G3t
         nofxIj6COOsGDO1nmsq3haistcNO3i3lwWRaY7B1Ll334G/XniYiDGuyCFVx4m9CO7EC
         kDbEKqwbDdebXjzke+Xfxv2+WREKiHDbjNAS46en4ZNubqeUsoSG/xDCPt09gx/GTP8C
         4xDu7AfKTlSaxDcLmfYFVs96LG4F92s4LTRxUQLT8hk7xG+19rDu8pHB1gEYpJzHw02k
         rDvGM5MdRywcCmLHHcjwjqAvvDRsNDueGdmxW79KDoiOsf26PXfwq7R7fDLyf6Z3ft5z
         yLeA==
X-Gm-Message-State: AC+VfDwE6PsUa9TSMwTbK+n5WwYy2o5znnyTR3DiiNlghU5FWTDXrqkV
        UqpkjjaHm2fBNZlbXVGCwfbiFsgJFV+ceDIUQuE=
X-Google-Smtp-Source: ACHHUZ7cWByFh6SdeH0ibdc+t26ep8puAXlZoyi43rdS6CJROIdXkE3uBXK5uDFE5LWt5xOmhe76sblC6V1W2/zL93o=
X-Received: by 2002:a2e:8e89:0:b0:2b0:259d:f670 with SMTP id
 z9-20020a2e8e89000000b002b0259df670mr1258700ljk.4.1684787281967; Mon, 22 May
 2023 13:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
 <168478682055.7079.605631444073463509.git-patchwork-notify@kernel.org>
In-Reply-To: <168478682055.7079.605631444073463509.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 May 2023 13:27:49 -0700
Message-ID: <CABBYNZ+2X1k9J0QJVwBTi9yP3inTOmoroAtovHgv0XZbdBCpPQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] iso-tester: always use DEFER_SETUP for multiple
 CIS in same CIG
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, May 22, 2023 at 1:20=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Sun, 21 May 2023 15:27:34 +0000 you wrote:
> > There is a race between multiple connect() for CIS in the same CIG.
> > connect() will both reconfigure the CIG and connect the CIS, but CIG
> > cannot be reconfigured once one CIS has already connected.  That these
> > tests pass currently relies on some timing/event ordering in the
> > emulator.
> >
> > Connecting multiple CIS in same CIG is meant to be done using
> > DEFER_SETUP, so change the tests to use it, so we test the intended
> > usage.
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,1/5] iso-tester: always use DEFER_SETUP for multiple CIS in sa=
me CIG
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Da88c74e29b6e
>   - [BlueZ,2/5] shared/tester: retain test failure status
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D195b9abbae0e
>   - [BlueZ,3/5] btdev: support multiple CIG
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D678265f37c28
>   - [BlueZ,4/5] btdev: report right reason for local Disconnect complete
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D0c32cfdf9462
>   - [BlueZ,5/5] iso-tester: add tests for multiple simultaneous CIG
>     (no matching commit)

Ive ended up making some changes to patch 5/5 so it combines AC 1 with
AC 2, we can probably extend these tests to have more combinations of
different AC, etc, just to make sure the code can handle them
properly.


--=20
Luiz Augusto von Dentz
