Return-Path: <SRS0=fr0v=SR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6713C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C9B206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYVpgKw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfDOH7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:59:08 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38009 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOH7I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Apr 2019 03:59:08 -0400
Received: by mail-ot1-f50.google.com with SMTP id e80so13634142ote.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2019 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DFsIT4BImWVUj2IbgvtPizF7+JvgHfNM3g08CLoYGCE=;
        b=gYVpgKw5IqShkZi4dTDZb3aEI3dgbl9B4mWmMxw3wVDOkDsEzyGytQ7eBT1XuDCnRO
         phuOs5xL5dGAyV9OvhGeHkAhFULCiZw6OMf/kaThnMhQnoujzo9tIahmvEvTAn3b1n4k
         MC77pbpYO3iOByZLg+RZO/5RTOBVHfeMRgW67PyDVRWpQSCjSKeF8qyuEruZT333Mzdd
         cgWN6IlVJOJIG2P8nVZW0DC9ADKyeK8X9WUOa8BiYljhYB7njDq9eBT2rVSGiDcilMJL
         6bwLPw5kO4OYtiap2m1JG6E113RjjQsUSi2qz47GF6xELlnhzmkUp/rMluK+7wbQVvQ9
         8cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DFsIT4BImWVUj2IbgvtPizF7+JvgHfNM3g08CLoYGCE=;
        b=bdMi80IzJg3VDJwbJbBeBYScbege0WrrTLOefehzjo8TZ2QCZcxSoH//R2Jd69d7E+
         vPUo4JlZ9tSher4/+1gibJlmc878ACQFTb3s6iFvv1iCD5vejZIND5wE51g/CHhWGRwG
         SKpFaja5yADw2iErtirvnpKfMN8ehFPN7fYa7EZOcBsoj2NwpKxFrYqfRJUscEf1N+dI
         n3oqRrKPVIk8q9zATmedWbjAtPvUJxdOO70C7l950oGFmBXsC+Qvgzvo6Fwb7XYf7qom
         8UKJIiSsyLSohWDyy3IaCNJj9zz5MpcRAP6mBSYjLJXIQHfPLfKhWbI9eQh12g1CsE8K
         6AtQ==
X-Gm-Message-State: APjAAAUrQ8J3q+mWAAQXX/EW5kkPEF85Tl+2635ngtnyy4aKiPq/Layi
        4f59v8MY+9p2a021cUEQjtDGOunxELbVIftFAO075bXa
X-Google-Smtp-Source: APXvYqwD4MnSaZ8idBGGImGjfH4Gew4vXjaxLbP54PRPoN/SUaX1huNIKj1H5hD4rYgRs0Pyg20VeAH2nYENTjOBjto=
X-Received: by 2002:a9d:5d03:: with SMTP id b3mr44539441oti.268.1555315147153;
 Mon, 15 Apr 2019 00:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190324142058.neuunjf46lgwcrgh@pali> <20190406145222.so7oyma2gme67pfn@pali>
In-Reply-To: <20190406145222.so7oyma2gme67pfn@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Apr 2019 10:58:53 +0300
Message-ID: <CABBYNZJvs8SEGVcQPO7ZdkLoKAkWJmjton3wZqOn++u=J6m5=A@mail.gmail.com>
Subject: Re: bluez: install a2dp-codecs.h file
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sat, Apr 6, 2019 at 5:54 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Sunday 24 March 2019 15:20:58 Pali Roh=C3=A1r wrote:
> > Hello, some projects like pulseaudio is re-using a2dp-codecs.h file. It
> > has own private copy of it. To simplify sharing this file between
> > projects, what do you think about exposing this file as part of bluez
> > API? That make install would install this file into system and other
> > projects like pulseaudio could depends on it.
>
> Hello, any idea about exporting this a2dp-codecs.h file?

We don't actually need it in BlueZ, well except for BlueZ for Android
which apparently has no users. But we could have a way to fetch it in
PulseAudio, afaik that was something similar going on some year back.

--=20
Luiz Augusto von Dentz
