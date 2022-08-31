Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A9CECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 20:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiHaUSP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaUSO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 16:18:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF03E68F7
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 13:18:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bx38so15755983ljb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=qJtnhpfjcSKcKkWcizj49TDhfJ/Uolrgxrb9/jRud/Q=;
        b=XihAgR9fSFCC7Ep2HzD4MfH2ZlleWGyaXXawYWWJ0ZLQ9hyO8vZIHc0S+XSKYnzLuZ
         Av0uH27VUs9D+Uc1OjW/66dtgBc+najyhKi5hFF0RZLL4uQTCAvdUiMfjzXYiWlTXS39
         tEy8gqpPoNDyQnnas/Lfy8VKNLkJ8EMFm3ytILMwlFN6XgWb+/uhdHIgNFslmhSqOcGJ
         PqnFjgbb7NcEpdtL7BNbrQJp2nO26EpxaopkGSIKZQiffVjrEsgSqlTx3b5I373UUCmH
         ngpAVcWZiSO1YjKngEz/H5UXgWLvusm2FhYRhLq5M/qIxIUU9gVztdhJJ97FbRFUc1zu
         4W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=qJtnhpfjcSKcKkWcizj49TDhfJ/Uolrgxrb9/jRud/Q=;
        b=7dnVmC86FkBd40dwGu/1gNJ8EJSDZ5t7RrKPRXIe0eVFtdSXEjz/uVnuU+9HLjXUiJ
         dOn3x+UHKwJB6h2bf2kWQKqGnNqYIPP1vpr6A/cZgfEYFoYAcelK28zwKKOyDXSfZ8xZ
         iPxXtx81YyC4bQgj94iu3N2/mk6hFkuJl5VHKXeYHAGXRk6HGHkfB1/nstPIK+ausE+N
         L8JVDNePndMvK9ZuIOvfN6rdpHp9HrzbU1YjlLN3+ib3omccocsDBtOgM6bWpYRw25jy
         aH2i23NUVowHQTbhdKp/uea+VhH4c11UTUVHO3+kAnvm6nwPNby4wsp9f8L13Un4oK/P
         vGow==
X-Gm-Message-State: ACgBeo3+POpeRWZxHK2oHNc0N24DFjOQQJgxy7S+tJTGKkl9kevYAoVf
        rUq+tmE/hJ5ZlokzCdoqRngsKQEucVcqWb7sGOJv86PTqzc=
X-Google-Smtp-Source: AA6agR420/ZESif3SWpfNquhYo1hPO4NpJzHp2W9FnEwruUGzYG4gRwAamzDafdN0XXafo7MoIctGUNw9bFRA+7ymoc=
X-Received: by 2002:a2e:9d81:0:b0:266:a1d7:74b4 with SMTP id
 c1-20020a2e9d81000000b00266a1d774b4mr3475758ljj.423.1661977091730; Wed, 31
 Aug 2022 13:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 Aug 2022 13:18:00 -0700
Message-ID: <CABBYNZJGc2Y3UULighw95un9mb8khLM2dfTOB3jRV8D3ksVDXg@mail.gmail.com>
Subject: Re: [PATCH] plugins: Do not try to autopair with Nissan Connect devices
To:     Florian Leeber <florian@ubports.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Florian,

On Wed, Aug 31, 2022 at 12:44 PM Florian Leeber <florian@ubports.com> wrote=
:
>
> It seems that Nissan Connect carkits a) do not use 0000 but 1234 as
> default code
> but also b) the autopair plugin is not allowed to make a second attempt
> to pair.
> Let=C2=B4s try to not use the autopairing at all for those devices.
> ---
>   plugins/autopair.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> index 0b09e89..6bf07e3 100644
> --- a/plugins/autopair.c
> +++ b/plugins/autopair.c
> @@ -66,6 +66,9 @@ static ssize_t autopair_pincb(struct btd_adapter *adapt=
er,
>          /* The iCade shouldn't use random PINs like normal keyboards */
>          if (strstr(name, "iCade") !=3D NULL)
>                  return 0;
> +       /* Nissan Connect carkits use PIN 1234 but refuse a retry */
> +       if (strstr(name, "NISSAN CONNECT") !=3D NULL)
> +               return 0;

Well this is already starting to grow which imo defeats the purpose of
hardcoding directly on the code so perhaps we could have a section
e.g. [Autopair] where one can enter device names that shall not use
defaults PINs, or may an entry where one can add its own specific PIN
sequence for a given device name including none:

[Autopair]
PIN=3D0000,1234
# The iCade shouldn't use random PINs like normal keyboards
iCade=3D
# Nissan Connect carkits use PIN 1234 but it refuses retries
NISSAN CONNECT=3D1234

With this the logic is check if there is an entry for the device name
and then use as PIN otherwise use the PIN entry (if not defined use
the current settings as default).

>          /* This is a class-based pincode guesser. Ignore devices with an
>           * unknown class.
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
