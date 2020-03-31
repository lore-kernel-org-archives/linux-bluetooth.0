Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDAC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 06:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB782072A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 06:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZwy8jEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCaGaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:30:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44428 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCaGav (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 02:30:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id a49so20881241otc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKRp2C3IHRLgR6p/AFCRRto04TbjF42TpnVVgL9ANXw=;
        b=HZwy8jEhGBgVh1lY2aggdcZyAFxpzAwos86/Pw7+x8FpDNIfgG3necTtrLRk/OLLA3
         NJqDavvIdZTq3OiDQHT0NkSz47LMLrH/7qCjM43oqsAFU1TqnudyxBNYVqUl/Tm2jHPU
         qtpHIt5sBJO7pDXeD1zeMfWN7tgAdrIuztp2rEzKaN0QlwVhtf/FQkZyIcZI8uCmQC96
         EgDujxigoABd3Qw0W8uN5Njx3kqfQ/qQFQCHOyBwMhxw9CXryrBKtSu56i05eyzcWMQp
         vvq2yhPgVZnkWy6KuwkvLsPqp/Zke0EAMPxrH8V8pesQQba1S49Px8E+p/B/vWlZUsR5
         I7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKRp2C3IHRLgR6p/AFCRRto04TbjF42TpnVVgL9ANXw=;
        b=Na0PBSdHT3j0165jndITPgBzYYtW5yFX3qLc/U9KrzyWWwil1eSyEcO43I/4ULahuB
         ASzs0BsnfhHWH8YRhRwDW035ErrQMZnR71zH26GNcG1kNHWo9rW+wLoiqZSrJZuV4UwJ
         l7coSbwrfASrjZ6MKchvlKpkqAvSu/z0W/oC4vxxRrm4uBKCE3dB6MsaacZ2YAmBoXws
         f4I89NqszPdWfItwe3JMaai2bEEpuSFe/tePU1vf6mIQ8zGXPganT31uhpVaA7MvxmZo
         CtOElDSYLoa3nu6vY+ed1bdO1RDRUI0tfYbNWhT1tbFhCXyaDPHrWblYN0dj67QjIJ3B
         MiUQ==
X-Gm-Message-State: ANhLgQ12DUoGCjk7POUbdQ5kwdBaEsO1hd1hWko3GJade9puH/h5OlWo
        f3JUh1nVejKOrUjxqObK+l6rpdOcCa8gk68Pw3E=
X-Google-Smtp-Source: ADFU+vtzw64LfUxbv2OBHBc9qcpnpkNqyTb7hVkFZTzBCs+xkSHtATY4NZa0f1DByp9wHsm9xQuVzQXX7Wg0oYMUkxY=
X-Received: by 2002:a4a:2cc6:: with SMTP id o189mr2023929ooo.20.1585636250938;
 Mon, 30 Mar 2020 23:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003318.13937-1-sonnysasaka@chromium.org>
In-Reply-To: <20200328003318.13937-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Mar 2020 23:30:39 -0700
Message-ID: <CABBYNZK=DSrS7MwrUm9LSPGwUmMzX7KJkf0r80hfduwoDC5KEA@mail.gmail.com>
Subject: Re: [PATCH] core/device: Handle Just-Works auto-accept
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Mar 27, 2020 at 5:36 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> The kernel starts to always request confirmation to BlueZ daemon for
> Just-Works pairing. In this patch the daemon does auto-accept if the
> client has clearly indicated a pairing intent by calling the Pair()
> D-Bus API.
> ---
>  src/device.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 69f98e488..db14cc129 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6168,12 +6168,22 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
>
>         auth->passkey = passkey;
>
> -       if (confirm_hint)
> +       if (confirm_hint) {
> +               if (device->bonding != NULL) {
> +                       /* We know the client has indicated the intent to pair
> +                        * with the peer device, so we can auto-accept. */
> +                       btd_adapter_confirm_reply(device->adapter,
> +                                                 &device->bdaddr,
> +                                                 type, TRUE);
> +                       return 0;
> +               }
> +
>                 err = agent_request_authorization(auth->agent, device,
>                                                 confirm_cb, auth, NULL);
> -       else
> +       } else {
>                 err = agent_request_confirmation(auth->agent, device, passkey,
>                                                 confirm_cb, auth, NULL);
> +       }
>
>         if (err < 0) {
>                 if (err == -EINPROGRESS) {
> --
> 2.17.1
>
Applied.

-- 
Luiz Augusto von Dentz
