Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C00EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 18:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiFUSji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFUSji (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 14:39:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7A10FDF
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 11:39:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so10739361lfe.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=viRAp4gMMQ0ZqzyDeDXgEXnmd89yZs/6hCJtvDrTTsM=;
        b=HbJQhz4DnPBt+sEVwEj1YW8LvUHTA4/pU6qUx1k1ipuirP8B5WwFTZbyV8UDcMg8+5
         7FyClkllZuC5uGuih1GHG8nCJB2rJ6lFRuTur6lsn7BWLDhSUhbPbQIBvcWv81WttrRh
         a1hWsI82wVATXcxULlRrwoBvFwxey/7CD2/IuTPXzLRGeX+X7lXjCgkDQ2Rb7FfkkMX3
         EJgaYeuQMaOSaUhdYya1WK0fJydSg86zxHS7fTAG9ccFhg3CcL/4OQn6zPv1e35i40fY
         ZD7PwMMOe03oK7RjMCYyI4fqKIhAhHzqekJTl5202xlxni2VESrte7XvrZpkzBYxjPY2
         OZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=viRAp4gMMQ0ZqzyDeDXgEXnmd89yZs/6hCJtvDrTTsM=;
        b=3g1bJO1dgOrqz7y/c9ripRRZ279Z4mA327FC31gUUrZJ5bSoSKEtxQHAZYi3vgkCva
         3+XJK/ocxmu44CmF6YccS2T0T/nGQPt6beQsOWyQ20nPBhfJ+LxNSrnvVMjCSTJXep3k
         GfBs/iX1j+JPO7fKgGRTgnrKLbshaRn7RrYf/RB3DFDt/gFwvdco8LzMuoGmhdkWTo/I
         OAQ4sZZEhkQkLfCEh5lAgkXnU5txHK+LK12Aqp1JyTiweOBPn99wkf7YDALDQCXBdsvX
         WajhHa+Klyc1HQqfgajjdhhr7yWndtMOvC04nKDXgzHGl2eJqa/Umzgb3OdgpL7PM/Ea
         6Hyw==
X-Gm-Message-State: AJIora+aGP41DlndYjfwfp5SQorOtIcaBtriWxEL3g45uUUmLAPTy4rC
        RROna1Jf55UV53yxACkUiKGqsNQhDD9MuKCtAx9jNIiEW8dh5Q==
X-Google-Smtp-Source: AGRyM1ulRKi9xLxWt5FCF+w0IRbpUHbxVzoH20OZqTFkeOsu4tlKpCXnSFBY9s5qdjDKJIPAkbXScVyTfu5QiHrsl14=
X-Received: by 2002:a05:6512:3ca4:b0:47f:6e53:fb4 with SMTP id
 h36-20020a0565123ca400b0047f6e530fb4mr7423883lfv.57.1655836774638; Tue, 21
 Jun 2022 11:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220621134818.11515-1-wangyouwan@uniontech.com>
In-Reply-To: <20220621134818.11515-1-wangyouwan@uniontech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jun 2022 11:39:23 -0700
Message-ID: <CABBYNZ+dnTPvOSzPEPNFJQqBaFF9+F5jfhFj9gUf5sAA06kEGQ@mail.gmail.com>
Subject: Re: [PATCH] device: Fix timeout=1 to remove the device immediately
To:     Youwan Wang <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youwan,

On Tue, Jun 21, 2022 at 6:55 AM Youwan Wang <wangyouwan@uniontech.com> wrot=
e:
>
> =E3=80=80When I use bluetoothctl to remove a device,
> =E3=80=80I find that the device has not been deleted.
>
> =E3=80=80static void set_temporary_timer(device, 0)
> =E3=80=80{
>      ......
>         if (!timeout)
>                 return;
> =E3=80=80=E3=80=80 ......
> =E3=80=80 }
>
> =E3=80=80=E3=80=80Now I want to delete the connected device
>     when call remove.
> =E3=80=80=E3=80=80I don't know whether this modification is
>     feasible, please give me some suggestions.
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 7b451e458..d38ad74fc 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3159,7 +3159,7 @@ void device_remove_connection(struct btd_device *de=
vice, uint8_t bdaddr_type)
>                                                 DEVICE_INTERFACE, "Connec=
ted");
>
>         if (remove_device)
> -               set_temporary_timer(device, 0);
> +               set_temporary_timer(device, 1);
>  }

Don't think this is right, in fact the original code could have been
clearer since all we want is to call clear_temporary_timeout thus why
we passed 0, perhaps you are after the following fix:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D5ebc2b5a3e4=
8dbe67a2d315979b096a1b4d1eb99

>  guint device_add_disconnect_watch(struct btd_device *device,
> --
> 2.20.1
>
>
>


--=20
Luiz Augusto von Dentz
