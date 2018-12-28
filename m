Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FCEC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED0820873
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6JEpMsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbeL1SYI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:24:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38846 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeL1SYI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 13:24:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so19266619otl.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L/TR4JshW0dqXV+NzvtT1Qc8Ieed9NDfJXWuSFGlg7c=;
        b=W6JEpMsQuedS+Z4hvjkqIulmewH5LE5pWjj8XoGOGm0VvJrCqQ0xVY9lhzW6G89Bid
         Us8xsaMKyJo8K0/fYjlDl530yG5B8G/nqJ/wqpgb+kNN4KFM9yH6PvxnTEE83ZIIHKe5
         Iifvx5Ezwjyutccyv8h1GWy6xG/6O6uNBtReK+wqvEoExMKR7jRdmKlGKRcn/1ZWA4cd
         wRS+73ZNoDLRbNZbGxCmRhTskvg/d/J1Z4L1/si+2urcA5xyLESCGb3hgl5o1+CsELfb
         z8TQf1CBjRG5ndCJi2Q7KDKx9+AroFG1GTjdWVatkuJbqb0lQ45VomBLwom/52qMlpdF
         cN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L/TR4JshW0dqXV+NzvtT1Qc8Ieed9NDfJXWuSFGlg7c=;
        b=oevFDsYJdwedixXe3QFdww8koiiIDi6aaHjRXXx4c/9jmmEfY/hLKzZnnUI+ZJyddP
         6oiq8KtK94kxJqur9B87H72e31AhRcFN9vomH3GGvxbJPFqAaKB+aXb70Pn9aKmh4pNo
         MN4GuRVcJhG7HfqwOVispfLtIYeQNmi8yXEEZF/mbFoxuKIaFc75AdsiBl59IHqv840t
         frC+meCzRnU4cuj3Bj9bhTHkFDXG5NLViKrvsnA1ujNgQwGLjBbKgNCcHBEUY/6Wk5G0
         FF5rkRbeAmQ23VvFs85+U0gi4TQR711BC3fO9M0WWKrTLJwrtCTu0eI2dqp8+fGAyslc
         5UVA==
X-Gm-Message-State: AJcUukdw4Cf4AnN1m1052BJ+aF51WH+Js1Wb6vBwwbSy9703qa14uuEI
        IJyKwlfH2QQP0VUk9fPd+bueaeySeclZfMUO+BU=
X-Google-Smtp-Source: ALg8bN7FSoTcUVevB2/tgBQTCa2ssYXbg7ckxsRIFY7xyGhLCMZJrEZo7Yf2c5FAOSIK0SZRLrnZChu1T/IZEMpESRk=
X-Received: by 2002:a9d:3426:: with SMTP id v35mr1693157otb.71.1546021447028;
 Fri, 28 Dec 2018 10:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20181219165109.29088-1-pali.rohar@gmail.com> <20181223104021.18620-1-pali.rohar@gmail.com>
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Dec 2018 15:23:53 -0300
Message-ID: <CABBYNZ+T5ZVaneY8mvVDGZ9Bj4FAj24sDUJ5p4RsyuDhfDKnAA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] A2DP: Fix endianity and define new A2DP codecs
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Dec 23, 2018 at 1:43 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> This patch series try to fix endianity problems in a2dp-codecs.h file,
> then fixes parsing MPEG bit rate values, extend a2dp-codecs.h file for
> new A2DP codecs FastStream, aptX Low Latency, aptX HD and finally adds
> support for parsing information about FastStream, aptX Low Latency,
> aptX HD and LDAC codecs in avinfo utility.
>
> Changes since v1:
> * Fix style issues
>
> Pali Roh=C3=A1r (10):
>   avinfo: Fix buffer overflow when parsing broken/malicious data
>   avinfo: Show Vendor Specific Data
>   a2dp-codecs: Add SBC prefix for MIN/MAX_BITPOOL constants
>   a2dp-codecs: Fix codec id for ATRAC
>   a2dp-codecs & avinfo: Fix parsing MPEG bit rate values
>   a2dp-codecs: Define a2dp_vendor_codec_t struct in endian neutral way
>   a2dp-codecs: Add needed includes and properly check for endian macros
>   a2dp-codecs: Properly define macros and struct for LDAC codec
>   a2dp-codecs: Add macros and structures for new codecs
>   avinfo: Parse new A2DP codecs
>
>  android/a2dp.c               |   8 +-
>  android/avdtp.c              |   6 +-
>  android/hal-audio-aptx.c     |  18 +-
>  android/hal-audio-sbc.c      |  12 +-
>  profiles/audio/a2dp-codecs.h | 267 ++++++++++++++++++++++++++----
>  profiles/audio/a2dp.c        |   9 +-
>  tools/avinfo.c               | 380 ++++++++++++++++++++++++++++++++++++-=
------
>  7 files changed, 586 insertions(+), 114 deletions(-)
>
> --
> 2.11.0

Applies, thanks. Note that I had to fix some patches since they didn't
compile when applying one by one.


--=20
Luiz Augusto von Dentz
