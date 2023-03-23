Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD62BC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCWRUk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWRUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 13:20:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22A52686C
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:20:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g17so28804239lfv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679592037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noADxvVZGzG524wNY29+MYK3uk/CTEYh2NGgaqzuY0c=;
        b=ZH6QgJrsK2p4uhc1RT2lrj52S5l5JnKSM59OtxJh7H6gsvLzKi9VTLiHM8t/1pFsj8
         tL5FgJhzjHdUfU6xBl3QAJi6kNXenqhTYLsbKhmOR/OWbnFt6twYWNsCObbOjvpwzHs8
         2+I+pwTbj64P0l5Sw8YukHSrXie8pofZo54ADSRKz/GSu3SPt3ADcBsm/Goo5xmI5EhO
         TIX+vDfb5ynq5ZVmvr43VI/cZxkWnnIz3RKuXr6REicrvL9hbjvyKGQDLoFl3AxEPyW8
         IsuDLBjgQLBC7+/dz3194nb7kZoWgmQfAyZdKfvWV1ydlPZJ2WCPlgUoteM5PR2O+up6
         FRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noADxvVZGzG524wNY29+MYK3uk/CTEYh2NGgaqzuY0c=;
        b=Z4QjQ32AUFK3Y2BWr/0gVS6Z9Pp+xdvpR+EFNsCeuSVjLemsPC66h56TRnPMnC/JbQ
         NmB/rTz3EnJHJUuDoT0wwdMMYAruQobIBB+Bk6WFt2f9FdVO/q8bcXjH7msXRH8JOw4f
         CnkUh4GJ92iQaKFMRE/t0NQ4qUUurp69N7jGHKJIEEOHgpsMP/C2slIY1rpnQ5MTKQSz
         ZJ1C39ThmICjysyE891zsp7hnMUp4ffJ7ESRHbfYA0KlcwDfPB4+lVKOUgmSAkB4aEmn
         XXWMmi21uADD8oJJ7y50nO7M8IasFb7JKVJhgW1cUUqgkb93XyoBhgDuTWJBZ12A8yTA
         QPCg==
X-Gm-Message-State: AO0yUKXglzpQtsal4sntDubH5T3LmFKctL/QEUiDo//Ig4xnM14LWgM9
        xGna9L1xV1Js3grq8HzHUiIanwis72hX4knlQXuolQs2KMA=
X-Google-Smtp-Source: AK7set9bgWVtn1ktHE1s5599OZOZ5Ks94RrsAH4aqcBisrx1d39f96/hcRjA7UgGHhIjqt3LZLGIg7iAjFE9EMUSS70=
X-Received: by 2002:ac2:44c1:0:b0:4db:b4:c8d7 with SMTP id d1-20020ac244c1000000b004db00b4c8d7mr2045336lfm.2.1679592036868;
 Thu, 23 Mar 2023 10:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230323102732.566440-1-simon.mikuda@streamunlimited.com> <20230323102732.566440-2-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230323102732.566440-2-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Mar 2023 10:20:25 -0700
Message-ID: <CABBYNZLyQkvU1uzV8WF9n54FC43OvFzNne6XJcAUj2yCB8dVbw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] l2test: Enable hex input for PSM
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Mar 23, 2023 at 3:39=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> ---
>  tools/l2test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/l2test.c b/tools/l2test.c
> index 5aae4b687..595f1dab2 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -1416,7 +1416,10 @@ int main(int argc, char *argv[])
>                         break;
>
>                 case 'P':
> -                       psm =3D atoi(optarg);
> +                       if (!strncasecmp(optarg, "0x", 2))
> +                               psm =3D strtoul(&optarg[2], NULL, 16);

strtoul should be able to autodetect the base and parse 0x if you give
0 as base:

https://linux.die.net/man/3/strtoul

> +                       else
> +                               psm =3D atoi(optarg);
>                         break;
>
>                 case 'I':
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
