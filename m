Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062D3E776C2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 21:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjJBVHn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 17:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjJBVHj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 17:07:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E67E1
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 14:07:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c186ea81c7so2089671fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696280854; x=1696885654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBslQK7WVL4OH3i7rxkt5y9WULvpul8FN533k76aoVI=;
        b=nVTm3n4Jd2W8EMh82lU+t4Yb5LMzqC4u69IXU9pi2BWds7gHeN/xotm8tYQJ8AaL6g
         NiIst7axLEkLBRHxDJOh73C2UUYy6oQUwPoJYHIlhCst4zgbLJvsJpECys4loeuvUQ00
         hEiPpZFIPrKHafZZzaje9t9utxjEkZOaSltGJvNQj7DUclDNmGyG8wpfa/cHKo3WAtGp
         eIhaqSSAM4s5uli5E/fhiomcSqsvTi5muXLhKfJl6tcqNtzlevm9/5g2XQm9jzmWEkwP
         dygigaqQf9F/e8MBu71fE5NL0+2HYJsEdRhi/EPZXrAZFCQvtkazN3Rbh2IZsSmBZIko
         AwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696280854; x=1696885654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBslQK7WVL4OH3i7rxkt5y9WULvpul8FN533k76aoVI=;
        b=BuM2Ct9SOI/oN87psiXNV4htogYEPakp9mHZQvw48yhQT+Z5DitDfaAlYnh4DG6tEv
         fQkoswR9HH+D0W1jPxE358B8NqcRd69D4qKGvI2NGv+Ff3QOCzYpNNH3dpKI6wBybZno
         l0LAccUdfaZxDXKrIPjfSUFcN8zqiDSmqwSi5i/lJXiw+sBAYPtthsimbmBB7zy/4ezm
         jtkIA2+IYl2vNNVqe22NyNfNu+lTHOlS1z3fzfZc+rl8YJUmdG4JhZJQt/oGhetLqoZ7
         bfoisHikAoAOIZta+Dzi2KmMt1/eflQyBfGLumfihgYfCJooD8lQ0vafkeTpI/Hei+Q0
         iiaw==
X-Gm-Message-State: AOJu0YyjE4WzAg1ekoQNfq53FuZ7alILRxCqgG3/SygUPMMzl2I/F9Io
        TVFWMDOGf0QsSTCx04YEGjpGQxW3WvfXHnwkX+YOvNzlz9Q08g==
X-Google-Smtp-Source: AGHT+IHIxz6HA4pz9i8ObE2Qs/klVkT1QroLDc2MKL2uRNZdXRfgoUuteU/Q72Ao5FQ+GQ+HFDDh0veLecCGCW7Ds1w=
X-Received: by 2002:a2e:3a10:0:b0:2bf:fae0:5cf1 with SMTP id
 h16-20020a2e3a10000000b002bffae05cf1mr10028481lja.14.1696280854145; Mon, 02
 Oct 2023 14:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <3358dfd1591df242507755cea63d00db3d2c959e.1696157794.git.pav@iki.fi>
 <d5bf0d4ac79bd447d78adad743ed5ae7e8f47048.1696157794.git.pav@iki.fi>
In-Reply-To: <d5bf0d4ac79bd447d78adad743ed5ae7e8f47048.1696157794.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Oct 2023 14:07:21 -0700
Message-ID: <CABBYNZJKOk6KCnnRoSfra8RLDeDV_cVWdYv5Np84nsPxKPHKAA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] doc: clarify org.bluez.MediaEndpoint documentation
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Oct 1, 2023 at 5:06=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Document the actual input and output parameter values used in
> SelectProperties. These differ from SetConfiguration.
>
> Mention SelectProperties is used for unicast only.
>
> Document SetConfiguration input parameters.
> ---
>  doc/org.bluez.MediaEndpoint.rst | 42 ++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoin=
t.rst
> index 0e201ff9d..11b7280bd 100644
> --- a/doc/org.bluez.MediaEndpoint.rst
> +++ b/doc/org.bluez.MediaEndpoint.rst
> @@ -24,14 +24,24 @@ Interface
>  Methods
>  -------
>
> +.. _SetConfiguration:
> +
>  void SetConfiguration(object transport, dict properties)
>  ````````````````````````````````````````````````````````
>
>         Set configuration for the transport.
>
> -       For client role transport must be set with a server endpoint ojec=
t which
> -       will be configured and the properties must contain the following
> -       properties:
> +       :object transport:
> +
> +               Configured transport object.
> +
> +       :dict properties:
> +
> +               Configured **org.bluez.MediaTransport(5)** properties.
> +
> +       For client role transport must be set with a server endpoint
> +       object which will be configured and the properties must
> +       contain the following properties:
>
>         :array{byte} Capabilities [Mandatory]:
>
> @@ -59,13 +69,29 @@ array{byte} SelectConfiguration(array{byte} capabilit=
ies)
>  dict SelectProperties(dict capabilities)
>  ````````````````````````````````````````
>
> -       Select configuration from the supported capabilities:
> +       Select BAP unicast configuration from the supported capabilities:
>
> -       :object Endpoint [ISO only]:
> -       :Refer to SetConfiguration for the list of other possible propert=
ies.:
> +       :object Endpoint:
> +       :array{byte} Capabilities:
> +       :array{byte} Metadata:
> +       :uint32 Locations:

The idea is these below are passed as in one container as in
MediaEndpoint.QoS, looks like I missed changing the handling on
pac_select since bluetoothctl doesn't check it but most likely
pipewire does.

> +       :byte Framing:
> +       :byte PHY:
> +       :uint16 MaximumLatency:
> +       :uint32 MinimumDelay:
> +       :uint32 MaximumDelay:
> +       :uint32 PreferredMinimumDelay:
> +       :uint32 PreferredMaximumDelay:
>
> -       Returns a configuration which can be used to setup a transport, s=
ee
> -       **org.bluez.MediaTransport(5)** for possible values.
> +       See `MediaEndpoint Properties`_ for their possible values.
> +
> +       Returns a configuration which can be used to setup a transport:
> +
> +       :array{byte} Capabilities:
> +       :array{byte} Metadata [optional]:
> +       :dict QoS:
> +
> +       See `SetConfiguration`_ for their possible values.

Interesting, need to check if the references works on manpages as well.

>         Note: There is no need to cache the selected properties since on
>         success the configuration is send back as parameter of SetConfigu=
ration.
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
