Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D73FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 17:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGLR6H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjGLR5z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 13:57:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6112F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 10:57:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so117143381fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689184673; x=1691776673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bNzseOEzJI/IEqjpsh3eUHRT47ND0wnfP+O9/IoxVI=;
        b=JHuQf/W+w3haPv+FBg/kikLHxpfTV4hGFFtcy4oj6DTiP/AN9kbW86lvwJz74CBTb8
         i26uq/bTTV+8k++awvjekbL3yT5m2v2qBmBY3VJUHmbwYZYi5l7jNyUScg5e8PDG2yGb
         fVZ2u1b80fgeGqu6B7oV9KAwnWwFWwy/K6vEdsGxcnyTaFzNc5FbQ8MKekhNtHcNzSJC
         PUY9mN0YXyRIP5rtpq+YVxLboWsvT8vsErfCZPf0l/Z9ERXsLutuo/HVzmN/3C+dKKfN
         pqH5vaEQuQxOImkDVF2/VSkuJCp3ECdeZQl1fi2QHHk8aisVr2QyAJfMa41aRC23P7Rg
         VUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184673; x=1691776673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bNzseOEzJI/IEqjpsh3eUHRT47ND0wnfP+O9/IoxVI=;
        b=Zm9ds/u4xOsShil2ZGl1EaUEnrBMc4AmcrEpVylAG046sHFwGUMwGQeBDrPdq+E0I+
         pD3gm1+zznjVD/WqW/+ymPhptVBZDqyBM00LCWeNp5L3J3CrdOiOEo6ix7GiQxIDhvWb
         ThsFOXP8Y7GjwDggOqvDwYoBYxyiirb+OdUFSGFIyvn5CnR3xJd7wz3CI9Vb1j7UB69W
         n+nCl6m+2BgVa1Y+j8CfXHKF6Md8Xpkq9LvusuJC20KFwkwIX2aPRa2vj1bgrI2ksyk/
         yja++mCemozdLRw80MMSeIaO5hJmbqsexhBdK0X+B2HACv3Qzgr6w6y9Bf65CRTJ7EQD
         nT1w==
X-Gm-Message-State: ABy/qLYBax91A7tBplUam6doJEDztuDRaIivlB0S1tSIPJ0ade0qB27x
        htia83idvj/vXbcT5/0rUn51Jr/v+7pyLs1E3FW+HsPi
X-Google-Smtp-Source: APBJJlHAppZ6kUUHDv/yefiW8VPXj2QqaAv7Kaa54RVYAw492uPoTGD4RNnTG3YxHiQxsUoq0zDKlWDmNReZxmwv4dc=
X-Received: by 2002:a05:651c:120e:b0:2b6:9bd3:840e with SMTP id
 i14-20020a05651c120e00b002b69bd3840emr19358448lja.21.1689184672527; Wed, 12
 Jul 2023 10:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <859a1c176765dbb9ea394dde387b8ed072365ca8.1689180344.git.pav@iki.fi>
In-Reply-To: <859a1c176765dbb9ea394dde387b8ed072365ca8.1689180344.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Jul 2023 10:57:40 -0700
Message-ID: <CABBYNZJu-RmP75pi32jeDPusKOx8L14jkWn0mubG48d_3B-A8g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] test-runner: set non-quiet printk before
 running tests
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jul 12, 2023 at 10:00=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> It is useful to see WARN_ON/bt_dev_err messages when running the tests.
> Enable non-quiet printk levels after boot, so that it is on by default
> and doesn't need to be handled in local test scripts.
> ---
>
> Notes:
>     It could be useful to also check for BUG/WARNING in the bluez test bo=
t.
>
>  tools/test-runner.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index d74bb1087..288901a61 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -136,6 +136,20 @@ static const char *config_table[] =3D {
>         NULL
>  };
>
> +static void enable_printk(void)
> +{
> +       FILE *f;
> +
> +       /* Set non-quiet printk level */
> +       f =3D fopen("/proc/sys/kernel/printk", "w");
> +       if (!f) {
> +               perror("Failed to set printk");
> +               return;
> +       }
> +       fprintf(f, "7 4 1 7");

Can you have a comment on what this 7 4 1 7 is for?

> +       fclose(f);
> +}
> +
>  static void prepare_sandbox(void)
>  {
>         int i;
> @@ -181,6 +195,8 @@ static void prepare_sandbox(void)
>                                 "mode=3D0755") < 0)
>                         perror("Failed to create filesystem");
>         }
> +
> +       enable_printk();
>  }
>
>  static char *const qemu_argv[] =3D {
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
