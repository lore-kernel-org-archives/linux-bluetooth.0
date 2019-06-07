Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51DDC2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B593620840
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khbRymck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfFGPEB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:04:01 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39892 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfFGPEB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 11:04:01 -0400
Received: by mail-ot1-f45.google.com with SMTP id r21so2129651otq.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bset/w0T2uxEYdgdK6IJlzbHrr81AMBFg++BAKqs2VU=;
        b=khbRymcklKB0mBQmnuMgJXUOJfg8/UN+3uj0KL+0Y9O0oUTPBLQ3tWpi0SQeHgjQ/W
         sCgqXomfUhIh8zq0gQ/ZgFR4jGmwnn0BfvfdS2YgAYzLRK5C+6OK4jaGBrNCvcCVo+84
         LZY18LT0scs96UidI9Rs2ATHbKoNUC7PcG4cgf8G7871p9v92zqGRCXRkHb4VWLpCklc
         BgsonAphyu6aikiwLQcq97i1OvG7QjEWrPmFb3Gt7uUrgn6kusSsdwu8JIuQswiFDhdG
         9HnRNYsdc+wtIizJMwn/vyifoFrhgaqQHGwrm21k1WWQPqz5/sz0Q9vdi3BqEiv6lzJZ
         DmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bset/w0T2uxEYdgdK6IJlzbHrr81AMBFg++BAKqs2VU=;
        b=V9l65jyeZtVjcy+s1xiMJUaU81ZWIbYri/L9DepgW2l/TE9WL3salVLMmUHUBTs9CQ
         Ar0MaedkvSjh6zGXmwjxF0VEwQ6gK/UKCMMax6hvgwo4D820U3ZvoWWcaWhqedqawS/X
         iOcurl2xilz1FxcHk37ExfBAzKReow8/lFaEmnxx/AJhdeHBOuTKFgYJYLQVyHsew144
         XYM+mE8+sTB/7BFBX3F4wGRYWOT4dePJKULFL1q/a2womoK6wF9u6cYBhkq1vETye4SH
         yAVkhzWKXMshyXVHgFhiesrbrfNehwLq9qqmgs24DMkrWZE0dcUjKwHh5IViawQb7aP1
         Bz6Q==
X-Gm-Message-State: APjAAAXFIadrAUVzoN+oeOpwuNAGBtVAfB4LArvBkoIt84gXCSxuPqLn
        fPDWKFJDUJG9R8JP/5Ky06MQv+0PuXTup/ugdRBj1WIAjUw=
X-Google-Smtp-Source: APXvYqwyyP3qFVcHnKVikRWMNb6NHqqn6plTtzwmj0McGhstLomRf34iJpNYw9pj1hNT5T62j9Jl37+vOP4IZPhyjeQ=
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr5643545ota.79.1559919839928;
 Fri, 07 Jun 2019 08:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190519101854.2ygwxeqbixappks4@pali> <20190607125916.wswblh5nxrx7hapm@pali>
In-Reply-To: <20190607125916.wswblh5nxrx7hapm@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jun 2019 18:03:50 +0300
Message-ID: <CABBYNZ+JPvvk1eACkp+cM9MtDZq+M78QLAtFcq-qrhR+8DsjnA@mail.gmail.com>
Subject: Re: Is BT_VOICE_TRANSPARENT correctly defined?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Jun 7, 2019 at 4:43 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Sunday 19 May 2019 12:18:54 Pali Roh=C3=A1r wrote:
> > Hello!
> >
> > Now I'm looking at BT_VOICE_TRANSPARENT definition which comes from fil=
e
> > include/net/bluetooth/bluetooth.h and it has value 0x0003. It is really
> > correct? Because it means following format:
> >
> >   Linear Coding, 8-bit without padding bits, 1's complement
> >
> > I think that usage of 1's complement is not easy as there is no C type
> > which matches it. Should not it be 2's complement or rather Unsigned
> > type?
> >
> > Seems that main usage of BT_VOICE_TRANSPARENT is mSBC codec and I doubt
> > that it uses 1's complement signed format (specially as it should be
> > modification of SBC codec which encode bytes as unsigned type).
> >
> > There is another define BT_VOICE_CVSD_16BIT with value 0x0060 which
> > seems to be correct as it means Linear Coding, 16-bit without padding
> > bits, 2's complement and encoded by CVSD codec.
>
> Hello, can somebody look at this BT_VOICE_TRANSPARENT definition and
> verify that it really should be defined as unsigned or 2's complement?

Are you talking about these:

https://elixir.bootlin.com/linux/latest/source/include/net/bluetooth/blueto=
oth.h#L119

Which is used in ofono:

https://github.com/DynamicDevices/ofono/blob/master/src/handsfree-audio.c#L=
93

Afaik these values work as intended with mSBC/WBS.

--=20
Luiz Augusto von Dentz
