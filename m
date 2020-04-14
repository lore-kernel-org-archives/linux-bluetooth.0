Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5BC2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7AF2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 21:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxUpAKpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633589AbgDNVE3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633557AbgDNVEL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 17:04:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE3C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 14:04:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k21so1213321otl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5vxTJBcu0nBxrCg4v5d2k4tFGyhewk2CkYEkKQ9CPL8=;
        b=dxUpAKpBCw/nq0kaIgY6pVql5PfjnZlh32KY7lj5Ubb9/BP6/VFlKvPRcyEWSlPaYk
         BFQFhaeWyw0j+1X5c/VOTGLOmJ1nzeGmyebMsKtTfXzkYWeALDfuxF7CSWA3ZNshKHtx
         EtwOp/DU2RofQbhSdufcadpSPolAcLTHa6pNPCUgRwvxczUwR8zsrsfxpiepBnCAxLFp
         7K6+IsdtUxmYXqJn3XA0ULQjawHhA9TinRDJLdGU0nyAUVgTn8KLCyeBK0hjL9ItKZ4e
         LIA2hbjm8X2VddhTRm6d8OODP1z7ktNnwWEIXQRsVcRlYiYMf5F9PmswcohzUKRZ25T0
         E2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5vxTJBcu0nBxrCg4v5d2k4tFGyhewk2CkYEkKQ9CPL8=;
        b=LDUG3AUKA8U8xHaa0zaKViDzUqk31KycPJug4QQxtTzkA9ai1xwSJS81QKBSROEG7A
         rFpnAYeB55DvHIO9CJrlzyLCa84DUUbEmtpyhIkCru1qTqVhACJN3tIXWTTnGbW1YoQk
         +KyPyctrnfIFCffXuBExcgFrT4F59Ks8bajJhVt+mO66su5ku05fMnaXIr1vdIJAEMEG
         yzR3lZ6dqHYXIOYgTXPjuaEc9Rdl+Z+EWMzYbjYxsJMssN6Jnr1B8C05G1V3IQ3P9wRj
         Ao12qAIOAZUtUEYWHCfXcAQuWX9U263o0NF418phipopLR1TMN9J8HqIzy3odfJMAQrT
         NmIw==
X-Gm-Message-State: AGi0PuYgD9jXTHoaL2MnahvSDv0qX7NIIBWYt5KY5LjT1agM0W2SrTY/
        mqa9XnrAyWoWKDROEkdjPzhJVo9askHEohM93u4=
X-Google-Smtp-Source: APiQypKjE2KZ0ys1tja/j9TjtOO/xY1nh1LkjEil/OkPKXNZSn8s3ljqwtlSSWcppvMlQjX+Qo8KEDizGOLSqgH/HGk=
X-Received: by 2002:a9d:644:: with SMTP id 62mr18257118otn.177.1586898249731;
 Tue, 14 Apr 2020 14:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZ+BD2g35wWHocp25kK_s07y7Yec8+51pEv37bh3U-fR-Q@mail.gmail.com>
 <20200414204602.29215-1-pali@kernel.org>
In-Reply-To: <20200414204602.29215-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Apr 2020 14:03:58 -0700
Message-ID: <CABBYNZ+eHqcTbh8-Zqh7Hk158GyBpq7H3bmO02We2rDRbPvuTg@mail.gmail.com>
Subject: Re: [PATCH] doc: Update documentation for HSP and HFP profiles
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Tue, Apr 14, 2020 at 1:46 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Fix information about default rfcomm channel number in HFP HS role
> (it is 7, not 6) and add documentation about default values.
> ---
>  doc/profile-api.txt | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/doc/profile-api.txt b/doc/profile-api.txt
> index ec18034..183c6c1 100644
> --- a/doc/profile-api.txt
> +++ b/doc/profile-api.txt
> @@ -16,10 +16,33 @@ Object path /org/bluez
>                         If an application disconnects from the bus all
>                         its registered profiles will be removed.
>
> +                       Some predefined services:
> +
> +                       HFP AG UUID: 0000111f-0000-1000-8000-00805f9b34fb
> +
> +                               Default profile Version is 1.7, profile F=
eatures
> +                               is 0b001001 and RFCOMM channel is 13.
> +                               Authentication is required.
> +
>                         HFP HS UUID: 0000111e-0000-1000-8000-00805f9b34fb
>
> -                               Default RFCOMM channel is 6. And this req=
uires
> -                               authentication.
> +                               Default profile Version is 1.7, profile F=
eatures
> +                               is 0b000000 and RFCOMM channel is 7.
> +                               Authentication is required.
> +
> +                       HSP AG UUID: 00001112-0000-1000-8000-00805f9b34fb
> +
> +                               Default profile Version is 1.2, RFCOMM ch=
annel
> +                               is 12 and Authentication is required. Doe=
s not
> +                               support any Features, option is ignored.
> +
> +                       HSP HS UUID: 00001108-0000-1000-8000-00805f9b34fb
> +
> +                               Default profile Version is 1.2, profile F=
eatures
> +                               is 0b0 and RFCOMM channel is 6. Authentic=
ation
> +                               is required. Features is one bit value, s=
pecify
> +                               capability of Remote Audio Volume Control
> +                               (by default turned off).
>
>                         Available options:
>
> --
> 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
