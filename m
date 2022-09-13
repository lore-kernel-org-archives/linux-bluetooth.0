Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD7C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIMRI2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiIMRIH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 13:08:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D55C6953
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 08:57:11 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b136so18488797yba.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foxdogstudios-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oK2fqA+eJKlumJ2qthC6U57tIYT5sBlUkTZFBDaw+Xk=;
        b=HAzIwEgoJAormss7IKkQ2Qwbhm2SIl+Y9QWUlEEieDsvbYZXn6VWIbxaQGw906iMU+
         8Ip8PntZ8Pb/dx27QWf4RUx5YkLlgYk+U/m4gdZXXxat6y3MzKFyUYpOnZoIyyAYcpsp
         BRX09IIVkaudWHHEDRn4jHYpkwqY94OBLceFJlnA41Yp30vCui+u7cc8Q4TvoQbfqfnz
         YB40h0wos7bwjhoALTYLWoxX5tjFnvkJFwURFd/M5vcwpGPQSJOncG6ysgknRgkZke8F
         eKExiMV2PdiJIyto7p1lNqXd02cQXlEyF3CcaczX8Jsf70LqPYEWtTZXY4+rTn+xjzrS
         4Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oK2fqA+eJKlumJ2qthC6U57tIYT5sBlUkTZFBDaw+Xk=;
        b=zcUGy8Xd7C7cu0dsRdaPAjtLrmYLbsKFnuekmWrnkD44vmN5NNWaZphCFMTM+PNhQS
         qccX9VZZ11m+JGQ9L9YTj67J+dv4SPjJkpUK0xSGAY+YRL4TpE4CRXT7GD/jGcXgNKV2
         qxwL0RPhTkp2t2K8Oxa6lbjF3DzJw8mOI6DHaGcffV0M0elCK5ItgLOakq0koAbRG2mM
         CoN8bFmsWlVXKycADcOmvMcfm7DfSJgKfo0orACAIvsG8hKNEqG/I56LZfWftfg1jXbI
         wzdjybtkdfcbqhqn5KT+Nm5sqH3MhYSqUd/gfg6Y1QhIP9vod1sdTG/YvlVgAkTyxNe7
         3Buw==
X-Gm-Message-State: ACgBeo0c5hbPQfCPPooektwBOBSNaZaIbOksN5LLPJ9HJXR1YeOcQAYg
        hwikJ22rXkWk4VjOezSYONUlcpjZDgU7pNxRzAvYEF6YME1ZtA==
X-Google-Smtp-Source: AA6agR6NY/3UU9zrqaNS5yAb0QpJicAq5lXoS0luByiv4kIrxPAThnRhcDbDQMuE+smHtJXkUEbuVgZ8dmDyoBs8q6I=
X-Received: by 2002:a05:6130:1102:b0:38c:49b4:bbc3 with SMTP id
 ce2-20020a056130110200b0038c49b4bbc3mr11332022uab.107.1663082441639; Tue, 13
 Sep 2022 08:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com>
 <24e95c8b-dc05-0d00-50bb-58b71c5baf94@molgen.mpg.de> <CAD+dNTuRThoa2OSzQ27tENB29GJ4oD0j3D+P4k42HzopEeTJMw@mail.gmail.com>
 <CAD+dNTsqBEjzG7BinKtxveH9faJqss89WPufbSsaB5FZRDgOPA@mail.gmail.com>
 <ef7a1421-06c5-f3b7-8c7f-7fdfd7862c96@molgen.mpg.de> <e7c8127a-d561-3a3d-f208-770f3abbee17@leemhuis.info>
In-Reply-To: <e7c8127a-d561-3a3d-f208-770f3abbee17@leemhuis.info>
From:   Peter Sutton <peter@foxdogstudios.com>
Date:   Tue, 13 Sep 2022 16:20:30 +0100
Message-ID: <CAD+dNTsnVpyFKyZcAgnqAZz-e2upjFd3NGWV=hPhywL8k0g6Nw@mail.gmail.com>
Subject: Re: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket release
 when connect interrupted
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>  a fix for a deadlock for RFCOMM sk state change was posted last year already:
>
> https://lore.kernel.org/all/20211004180734.434511-1-desmondcheongzx@gmail.com/
>
> It seems it never went anywhere, unless I'm missing something. Is that
> maybe the same problem or somehow related?

I mentioned this on the Arch Linux Matrix channel. The `linux` package
maintainer said they had encountered the same and added the linked
patch to the Arch Linux kernel package but removed it because it
wasn't merged (which explains why my issue went way then came back).
Anyway, we compiled a 5.19.8 `linux` package with the patch (which
fixes my issue) and they said they'll add the patch back to the linux
package.
