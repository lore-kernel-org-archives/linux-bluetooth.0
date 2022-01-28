Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E608C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 02:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbiA1CCb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 21:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiA1CCb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 21:02:31 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1916FC061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:02:31 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id k17so14202204ybk.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4O1H+Zjq1efAjTJm35vZ3cTUrF526URxOfmum6VsXY8=;
        b=J2GXHdmPy+kQcmGcgT8RjmGo5LpjLuvZIYbf2n+t4rj8VpxVxTW0tdmuNaAReGeCAs
         JNh/KXpvYCOW//QQ/cr6S90awlHZHYaEsU2llO4rpgdOyzk5kc4JoLIXody0k75Z8ceR
         Xc/gA97EnJc41vlid/G8Md7AYNllqYmGaTPwJHUyKYRGgA4WUDACM5aEBbZjl6FgWsay
         /jyNrXjqd7A3suIi+hFzJe9RtJUjn9Bbtt5NdnGcNEyZj7E7T+xxru2Cei7UIlNUOZzn
         xeFrW+uKWMK6m9X5tz00YLQpzhCaB3TmK9srRwG3FoFH106nvykW/61BB7tv6QR6JNL2
         lUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4O1H+Zjq1efAjTJm35vZ3cTUrF526URxOfmum6VsXY8=;
        b=G42coO2szzWJOs1H+14tKzCFdCFRa1cD3p6Txsj1qnc/BY5yk/q/sM33IFaOfWSINV
         gXk00Iq+PYLqt16XziLsMguFauUch6IecWMU58BlGyML2pViFrdog7iDQa53eJFjCEsu
         akRaZ/WR7kp/mL1TpWIbk+B1qgDuQaoplN8Q7SBjJH9PIGl6YvnuN+TQ7ADBP+7rNeA5
         goyRJWa4emM9jviOX4PtfqqfTyQryRvteNb1noAGW+8k40B6/su7+7Ol/RJmKCFo02/L
         MBAAwfdgY7snuSeq27DQUXYFzMmlX4JcEmELQYYFtwxA8kD81aotuZkogOw/eG23hI2W
         UZxw==
X-Gm-Message-State: AOAM530yOmRqE43s/qsP4Gi/NIt9GP84J5EDRNMCPGANY2d36Z3+UFOS
        h65p+NqLhPywE/fo4ASSeEkMLefQUMDLqiunafwv/mqRCRw=
X-Google-Smtp-Source: ABdhPJwrQLKnr9NVAOMR+6w8kTAezQlB3KyTkn+Kq1O66QtEqPyocQMrCU9USxZ74Bja7D7fhsQQ9O+UR2nWRtdbrss=
X-Received: by 2002:a25:50cf:: with SMTP id e198mr9673351ybb.398.1643335350116;
 Thu, 27 Jan 2022 18:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20220121205454.1413365-1-luiz.dentz@gmail.com> <61eb4467.1c69fb81.d7452.7d3b@mx.google.com>
In-Reply-To: <61eb4467.1c69fb81.d7452.7d3b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jan 2022 18:02:19 -0800
Message-ID: <CABBYNZKkwqLQi+ybQf46Uvy9f2iGJXfzLkMwAGRvdUTjp5X_HA@mail.gmail.com>
Subject: Re: [BlueZ,1/4] shared/gatt-db: Introduce gatt_db_service_add_ccc
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jan 21, 2022 at 3:40 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607383
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.01 seconds
> GitLint                       PASS      1.36 seconds
> Prep - Setup ELL              PASS      38.22 seconds
> Build - Prep                  PASS      0.41 seconds
> Build - Configure             PASS      7.70 seconds
> Build - Make                  PASS      1301.25 seconds
> Make Check                    PASS      11.02 seconds
> Make Check w/Valgrind         PASS      399.26 seconds
> Make Distcheck                PASS      212.75 seconds
> Build w/ext ELL - Configure   PASS      7.61 seconds
> Build w/ext ELL - Make        PASS      1290.35 seconds
> Incremental Build with patchesPASS      5245.61 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
