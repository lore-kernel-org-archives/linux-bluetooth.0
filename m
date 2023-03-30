Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC4C761A6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 18:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjC3SSU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjC3SSS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 14:18:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22CC4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:18:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id br6so25624208lfb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680200296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9NZvxLNLeZMvl2FVsapioZoNbxyh1f4JpSQzwsntYM=;
        b=pmhRLUU2WIBGM+TUkMTkUigQe8dVLeDsYrcFcsrI2ZPPgbGO0r2xtOyAkX/PGdqHIL
         WZGea9twxShRczOp/ECy/Sr9gHhimJU0KkauMPe29w8VOnBUp21uuiuxUdz+SfNMfXVf
         AlwqTXIzLdTsCVQLYHWn2H+P6auNaNOyolLCOzSzmJJRKxn3oMEIbYh6U0oljgS9q/7h
         zSbwa2DdvGiJ0QYRLhj87ILD28xENNJozsdnpI2QHxonoFY+0l/AYYZi0r4YL1iu99tk
         mllEel7EYXkLhZ3cgnyFTLdXEYkMVzw5CiaFTb6ZXIjTenUXSD4OiyqrOQoT/5UowTOH
         VAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9NZvxLNLeZMvl2FVsapioZoNbxyh1f4JpSQzwsntYM=;
        b=YNN1239eQf5pmbEZbtOJVDgyia/MW68Sqc/Amel7sPJVaEgltQyHxqD6F2r/hIwCo6
         Ay6rTN2MOF9iTHMwVtQkE8hubPqEIZVP0ZxH4Z3L+DoSqnoaybqRWrERhFRO0jmutk4X
         imoyLSJaUbmUrqq7Yl8KwIjdhu7BLwqtdn2BEw/39bzdb/cRYDz68tsOnFOKq0BkuIX9
         spRuiD547MCoYTjNA8VnbW60utY1HoFHab2MABPpwXwigL369yys4kMG9fAu3DymwN6a
         JOkbftxsjoInWv802O4REmkpQILSWmlZ55Zq4GtJC6xv5yT9A7cnlzrG5p7xAGi2dktF
         L5ag==
X-Gm-Message-State: AAQBX9ckJmoXoH2khperIfULCDqeRTo9QArO/By4UBgawutjfHkThV6I
        9rUcgvZwetBMiRCbGDFWOs3dwultndEkhDX0CHQ=
X-Google-Smtp-Source: AKy350Y9JmSp5JKIjs4a/IYV96ONfUvfu0C1aqJjYXg+o0VzQ57ROMIWwhrF7/zO00BVb30YHm7I+tOHTXgN/Ld3X1A=
X-Received: by 2002:ac2:59c4:0:b0:4eb:d8d:6c17 with SMTP id
 x4-20020ac259c4000000b004eb0d8d6c17mr4937489lfn.10.1680200295583; Thu, 30 Mar
 2023 11:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
 <168019982520.20045.11650139439500360979.git-patchwork-notify@kernel.org>
In-Reply-To: <168019982520.20045.11650139439500360979.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 30 Mar 2023 11:18:04 -0700
Message-ID: <CABBYNZL5Q8cLwNYi_pqHaSSsEet9pLxnVwBh93UPoNUsHCjSwA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 1/2] vhci: Add support to trigger devcoredump and
 read the dump file
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Manish Mandlik <mmandlik@google.com>, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Thu, Mar 30, 2023 at 11:10=E2=80=AFAM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Wed, 29 Mar 2023 23:08:02 -0700 you wrote:
> > Add vhci support to trigger the hci devcoredump by writing to
> > force_devcoredump debugfs entry and read the generated devcoredump
> > file.
> >
> > ---
> >
> > Changes in v5:
> > - Refactor vhci_read_devcd()
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v5,1/2] vhci: Add support to trigger devcoredump and read the =
dump file
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D8bd2f2961774
>   - [BlueZ,v5,2/2] mgmt-tester: Add devcoredump tests
>     (no matching commit)

Note that I did a small change to convert from tester_test_failed to
tester_test_abort that is why the no matching commit is shown above.

> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>


--=20
Luiz Augusto von Dentz
