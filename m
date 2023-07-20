Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA8EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 21:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGTVaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGTVaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 17:30:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE02111;
        Thu, 20 Jul 2023 14:30:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so18972211fa.1;
        Thu, 20 Jul 2023 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689888615; x=1690493415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxacXEluGsGwpl2y8KBqRJGU84iXk47vfx9ORCjxHug=;
        b=BWhxz3Fxm6dt/q5VVnJfBAeJZoMc4now6fB/IKNk3qldSPc86WYzZS/WBYZI0wuflB
         AH8z1qtD7vCeys0zPjm2F/GMHZY6Un1g5vFriZAiTNXDUz4ZazKZZGXIgoYGv54vibfX
         97O5pHUEk1p9pYUhMxywfAdNrnSu37cF1PR3nT1fY6ubkuAMHHhxEzUWx/gYcDasIklO
         Oylz8SSrhK1eRojLi9N6by1gveu+7rFo9U4VhK7MNX4x48tJRvTT4T62Bg3Vi4bKV3Ul
         4dPUPP9dfJBBHKJuAEbPb5zVsWHMI/MxS8IsaE9gDWu/eN7MVIMpsPrzjdzaQlitoymI
         37cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888615; x=1690493415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxacXEluGsGwpl2y8KBqRJGU84iXk47vfx9ORCjxHug=;
        b=MPhhBB6R36hzi7w8iqFn/S6b2M1CYoLUZ7USDVg72JVvmYH59iGS/L5FaIAWPL8ySK
         3te0KTIcPSNS6wR4qRVl5pKQek/z+boHoSeB2xBZ37QZcaClF/Z7SB0vBdyH36s+SQw7
         veAiPRvJ/PXgtc3lRPRSl7gQCtDxnx1Mt1MGmOJ3UHYw1ih8olS/t4ABXTJpolJTtq8y
         SRCJSgvEAow0X5PfjWAG30VXjPFxaHwDWb2Y6vd4Xn52qyFj9dOiDO3E33emthW1SNCU
         edMjHUkTywn14UQd/KDa187WJaLg09cpALwY2lOjl6z5IVO+Z1C/1SXinMP1+WifpebS
         KJMg==
X-Gm-Message-State: ABy/qLZGsp+Z80tAwKnxeeKNcBgss0/8H2JW1LVqZ6PBI/HQiHMylmKk
        FWCNDDwp5Wa7/3ET8XtEm3QC8JOugCdT6dy9yz4=
X-Google-Smtp-Source: APBJJlF0tBQwm3aAgU4xLvrl9FRsgqh6fbCAmH5vuDHhVR+v70O9f7Qa8yGqIx7YbxtLlSLDUEcjzaSmbA4MnYuCtdI=
X-Received: by 2002:a2e:a178:0:b0:2b3:47b3:3c39 with SMTP id
 u24-20020a2ea178000000b002b347b33c39mr104443ljl.23.1689888614781; Thu, 20 Jul
 2023 14:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230720190201.446469-1-luiz.dentz@gmail.com> <20230720142552.78f3d477@kernel.org>
In-Reply-To: <20230720142552.78f3d477@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 20 Jul 2023 14:30:02 -0700
Message-ID: <CABBYNZL9puVzX7ELtR7UQGSU1=YFVWfdKWBmcGf4X5m3bRCS3w@mail.gmail.com>
Subject: Re: pull-request: bluetooth 2023-07-20
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

On Thu, Jul 20, 2023 at 2:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Jul 2023 12:02:00 -0700 Luiz Augusto von Dentz wrote:
> > bluetooth pull request for net:
> >
> >  - Fix building with coredump disabled
> >  - Fix use-after-free in hci_remove_adv_monitor
> >  - Use RCU for hci_conn_params and iterate safely in hci_sync
> >  - Fix locking issues on ISO and SCO
> >  - Fix bluetooth on Intel Macbook 2014
>
> One bad fixes tag here, but good enough.
> Hopefully the big RCU-ifying patch won't blow up :)

Weird, I'd run verify-fixes and it didn't show up anything. As for the
RCU changes, yeah I was considering pulling it out but since it is a
single commit with no other dependencies we can always just revert it
if it causes problems.

--=20
Luiz Augusto von Dentz
