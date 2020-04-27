Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669EBC54FD0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B57420663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKE5/OaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD0Qaj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726499AbgD0Qaj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 12:30:39 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712BCC0610D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:30:39 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id b17so4001490ooa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3bHi9POfR43E9SdhhaWXFJRsI9E/hnfA76f7EcvZGaQ=;
        b=XKE5/OaNKinPA+7t4+jUsnToeTu5NNk/wzzYQEhga4PHeLLlo/vNzeIWcORtLXzRU9
         US8xpfe49BZlqGFfrA2xWapDJH11luWF4E+82Hhw9hkHpL13hij6KlzhghJ/qo9vbPl2
         v2pI4eJnLMB9dBl67XbXj8Q2/uQuz2IAVv3IyyFR6REr4uJjTyfpBu+wyFx5yNFDZc2k
         ZYNRRJ2Oqnyi+y6ltxoNpwh86dxmwPm0I/e71LpMDeVQdnc+g5CdP1CGsWTU7KrvKjVn
         W3YqSRmmgnasXFxabAeuJ2KOpTs4oFMl+tm0Gohhj6JJGYK0JnmtCZun+0rFYvA3/rWD
         Du3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3bHi9POfR43E9SdhhaWXFJRsI9E/hnfA76f7EcvZGaQ=;
        b=toWSEhu3vGBGeUP1rJkEz7AAVaeyimMVL1vojP8DGt0gbJNP18hfP1A87omvGYYE1R
         fKHHarbfaAJ1YQqygh71G71P0DjwxjpLgeshP7d39IoOst7ZE02IUYIOq27J+4JHNmZC
         eIu0InGWcQ4S+5FKXd2zmLFmjMi0ZUTHpZeSdulVeCu6+uVWhW3SDphdooQWEX3QBbBO
         OCL4CoDDZjA327Bk1nQ/yM4NKeOqeI1VK1btMn8IF/eVqT6G2JvkiTDgLMM75yk2sB8S
         FqS/D6DjFmK30lxadCMtL9xa61+eplvAkSwrvlpbHHgOsUZegXzpcOpYyzwNFCJC1dLY
         Z69A==
X-Gm-Message-State: AGi0PuZL39lxWQ6BdyYNYrdu3FzrefZv0n0kg6p4BzjEW1pTJEh2w36B
        bJ3D9um2YRbDqY/lU8kd4vi3DRSjtokZyUQy6jQ=
X-Google-Smtp-Source: APiQypIkAVQoW+eYuK+6UFF6a5MS8Y+y2zG9TpoPDVinmrMyzphJ5JSUDy2cxuaHaNmyBOQRCq1BUC3vG7XdAtOvv4w=
X-Received: by 2002:a4a:9c8d:: with SMTP id z13mr18968216ooj.50.1588005038717;
 Mon, 27 Apr 2020 09:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200424231042.127237-1-tedd.an@linux.intel.com> <5ea3a243.1c69fb81.81de.2b47@mx.google.com>
In-Reply-To: <5ea3a243.1c69fb81.81de.2b47@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Apr 2020 09:30:27 -0700
Message-ID: <CABBYNZJJfv8m5ZyUFZrQhvyOxJiMnR61EwTzRA9hK-=Eh9HC0w@mail.gmail.com>
Subject: Re: Test patch: build fail
To:     bluez.test.bot@gmail.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Apr 24, 2020 at 7:38 PM <bluez.test.bot@gmail.com> wrote:
>
>
> This is automated email and please do not replay to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While we are preparing for reviewing the patches, we found the following
> issue/warning.
>
>
> Test Result:
> Checkbuild Failed
>
> Patch Series:
> Test patch: build fail
>
>
> Outputs:
> ar: `u' modifier ignored since `D' is the default (see `U')
> ar: `u' modifier ignored since `D' is the default (see `U')
> ar: `u' modifier ignored since `D' is the default (see `U')
> ar: `u' modifier ignored since `D' is the default (see `U')
> ar: `u' modifier ignored since `D' is the default (see `U')
> tools/btpclient.c: In function =E2=80=98main=E2=80=99:
> tools/btpclient.c:3218:15: error: expected =E2=80=98;=E2=80=99 before =E2=
=80=98return=E2=80=99
>  3218 |  l_main_exit()
>       |               ^
>       |               ;
>  3219 |
>  3220 |  return EXIT_SUCCESS;
>       |  ~~~~~~
> make[1]: *** [Makefile:6791: tools/btpclient.o] Error 1
> make: *** [Makefile:4010: all] Error 2

Nice, really cool that we finally have a CI working.

--=20
Luiz Augusto von Dentz
