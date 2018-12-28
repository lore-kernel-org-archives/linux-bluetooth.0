Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE6FC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE06C20873
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4yVseFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeL1SYm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:24:42 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41825 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeL1SYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 13:24:42 -0500
Received: by mail-ot1-f48.google.com with SMTP id u16so19252031otk.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y4t7L9J47mmoVX7RTilLzlfm3N0MLvRz8PZmoRIzdN8=;
        b=D4yVseFdSGWQeAcfj5ygAOmpmh6GzHUf81iQky5tSc0FbvjyNNsqAlO/eXLHRheAUS
         fQ1HJsd3Gq18mSWgF+7bqKNsHecjjDNOe1rMB5x2U3uUd7AVyYH0WWJjmMfO0d8SdtMZ
         /NwCRDZle742v0piXZkc+eLwRnqEiJk16fRpAswBdR1UauuhhMsxBtvCvftnY+QaHzAq
         OiA+H4ZTqEGDFTmRUKW0FttJkfv1mr/2Rqsi4ryaCTdFiaVSQyPWmThCafAKpjvfD1uk
         yoL8a7zbu26iSQLCs+n91omzi1+VkPqxJvySIrbYYVHam4Purl4awj48APjupcOjXVcF
         e1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y4t7L9J47mmoVX7RTilLzlfm3N0MLvRz8PZmoRIzdN8=;
        b=UtUlFe+jowdE4wIm6kQ7kA6xfuFMFlz1t9MxIUioPGRm25inGatQXwl88CuSouSq4c
         A+t/c/59t2f28cAXHswXeOPo/mjqaGqMu7pn8frreTBzBf2YDyl2S7nnXRKf6p37bYxm
         wSi7sWo5nMZk/+/s65ixWuVQzbXRghE6kfIrvjXkBHJiOtX/1StWRJsPoTpCufjzbklJ
         nNKzHFGJlkB6bhePVpikPMkClWQXzcGtGCEDkTQlZAg88Xkuvopf7Fv7DONKL3533JcY
         32i8kpX/SP5v8/7hPp1EhvCncAgAYTPJMtN4r/Y+nejHew0tEPwe/jAIlUPi0RhXjjXu
         x7iQ==
X-Gm-Message-State: AJcUukfxrlAxWqnLx74JMJ70l6c0EGZaEDPnOiPGu/OndIRurjqBe4nc
        zJtYX+lFZuOP2a+IFHoXv2Nnhk0P7Ft20g9t0N+7sTcI
X-Google-Smtp-Source: ALg8bN63B3oFysNpZypgN1jqdsbv9WF0D9JNrNm4ZMOlgU5UTu5zVCuJZCxi/S8FbGyzJdO9fTV93YGsBXliLgyBX8w=
X-Received: by 2002:a9d:18f:: with SMTP id e15mr20527401ote.84.1546021480682;
 Fri, 28 Dec 2018 10:24:40 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZ+ntTPASbv4434zJf7q_KRtiGbduSORbhNoC__ihZW-cA@mail.gmail.com>
 <20181223100043.11505-1-pali.rohar@gmail.com>
In-Reply-To: <20181223100043.11505-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Dec 2018 15:24:29 -0300
Message-ID: <CABBYNZLa4asvyr3F1m8qE3uuYEWVXKMFt=u_S7OJ5HMd_UiNuA@mail.gmail.com>
Subject: Re: [PATCH v2] btmon: Parse new A2DP codecs
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Dec 23, 2018 at 1:42 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> Parse information about additional A2DP codecs: FastStream, aptX Low
> Latency and aptX HD.
> ---
> Changes since v1:
> * Fix style issues
> * Define struct vndcodec
> ---
>  monitor/a2dp.c | 296 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 284 insertions(+), 12 deletions(-)
>
> diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> index 6a271217b..ffdcbb962 100644
> --- a/monitor/a2dp.c
> +++ b/monitor/a2dp.c
> @@ -3,6 +3,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2015  Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl=
>
> + *  Copyright (C) 2018  Pali Roh=C3=A1r <pali.rohar@gmail.com>
>   *
>   *
>   *  This library is free software; you can redistribute it and/or
> @@ -51,6 +52,12 @@
>  /* Vendor Specific A2DP Codecs */
>  #define APTX_VENDOR_ID         0x0000004f
>  #define APTX_CODEC_ID          0x0001
> +#define FASTSTREAM_VENDOR_ID   0x0000000a
> +#define FASTSTREAM_CODEC_ID    0x0001
> +#define APTX_LL_VENDOR_ID      0x0000000a
> +#define APTX_LL_CODEC_ID       0x0002
> +#define APTX_HD_VENDOR_ID      0x000000D7
> +#define APTX_HD_CODEC_ID       0x0024
>  #define LDAC_VENDOR_ID         0x0000012d
>  #define LDAC_CODEC_ID          0x00aa
>
> @@ -187,6 +194,23 @@ static const struct bit_desc aptx_channel_mode_table=
[] =3D {
>         { }
>  };
>
> +static const struct bit_desc faststream_direction_table[] =3D {
> +       {  0, "Sink" },
> +       {  1, "Source" },
> +       { }
> +};
> +
> +static const struct bit_desc faststream_sink_frequency_table[] =3D {
> +       {  1, "44100" },
> +       {  0, "48000" },
> +       { }
> +};
> +
> +static const struct bit_desc faststream_source_frequency_table[] =3D {
> +       {  5, "16000" },
> +       { }
> +};
> +
>  static void print_value_bits(uint8_t indent, uint32_t value,
>                                                 const struct bit_desc *ta=
ble)
>  {
> @@ -211,12 +235,49 @@ static const char *find_value_bit(uint32_t value,
>         return "Unknown";
>  }
>
> +struct vndcodec {
> +       uint32_t vendor_id;
> +       uint16_t codec_id;
> +       char *codec_name;
> +       bool (*codec_vendor_cap)(uint8_t losc, struct l2cap_frame *frame)=
;
> +       bool (*codec_vendor_cfg)(uint8_t losc, struct l2cap_frame *frame)=
;
> +};
> +
> +static bool codec_vendor_aptx_cap(uint8_t losc, struct l2cap_frame *fram=
e);
> +static bool codec_vendor_aptx_cfg(uint8_t losc, struct l2cap_frame *fram=
e);
> +static bool codec_vendor_faststream_cap(uint8_t losc,
> +                                       struct l2cap_frame *frame);
> +static bool codec_vendor_faststream_cfg(uint8_t losc,
> +                                       struct l2cap_frame *frame);
> +static bool codec_vendor_aptx_ll_cap(uint8_t losc, struct l2cap_frame *f=
rame);
> +static bool codec_vendor_aptx_ll_cfg(uint8_t losc, struct l2cap_frame *f=
rame);
> +static bool codec_vendor_aptx_hd_cap(uint8_t losc, struct l2cap_frame *f=
rame);
> +static bool codec_vendor_aptx_hd_cfg(uint8_t losc, struct l2cap_frame *f=
rame);
> +static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame);
> +
> +static const struct vndcodec vndcodecs[] =3D {
> +       { APTX_VENDOR_ID, APTX_CODEC_ID, "aptX",
> +         codec_vendor_aptx_cap, codec_vendor_aptx_cfg },
> +       { FASTSTREAM_VENDOR_ID, FASTSTREAM_CODEC_ID, "FastStream",
> +         codec_vendor_faststream_cap, codec_vendor_faststream_cfg },
> +       { APTX_LL_VENDOR_ID, APTX_LL_CODEC_ID, "aptX Low Latency",
> +         codec_vendor_aptx_ll_cap, codec_vendor_aptx_ll_cfg },
> +       { APTX_HD_VENDOR_ID, APTX_HD_CODEC_ID, "aptX HD",
> +         codec_vendor_aptx_hd_cap, codec_vendor_aptx_hd_cfg },
> +       { LDAC_VENDOR_ID, LDAC_CODEC_ID, "LDAC",
> +         codec_vendor_ldac, codec_vendor_ldac },
> +       { }
> +};
> +
>  static const char *vndcodec2str(uint32_t vendor_id, uint16_t codec_id)
>  {
> -       if (vendor_id =3D=3D APTX_VENDOR_ID && codec_id =3D=3D APTX_CODEC=
_ID)
> -               return "aptX";
> -       else if (vendor_id =3D=3D LDAC_VENDOR_ID && codec_id =3D=3D LDAC_=
CODEC_ID)
> -               return "LDAC";
> +       size_t i;
> +
> +       for (i =3D 0; i < sizeof(vndcodecs)/sizeof(*vndcodecs); i++) {
> +               if (vndcodecs[i].vendor_id =3D=3D vendor_id &&
> +                   vndcodecs[i].codec_id =3D=3D codec_id)
> +                       return vndcodecs[i].codec_name;
> +       }
>
>         return "Unknown";
>  }
> @@ -508,6 +569,108 @@ static bool codec_vendor_aptx_cap(uint8_t losc, str=
uct l2cap_frame *frame)
>         return true;
>  }
>
> +static bool codec_vendor_faststream_cap(uint8_t losc, struct l2cap_frame=
 *frame)
> +{
> +       uint8_t cap =3D 0;
> +
> +       if (losc !=3D 2)
> +               return false;
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cDirection: 0x%02x", BASE_INDENT + 2, ' ', cap);
> +       print_value_bits(BASE_INDENT + 2, cap, faststream_direction_table=
);
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cSink Frequency: 0x%02x", BASE_INDENT + 2, ' ',
> +                       cap & 0x0f);
> +       print_value_bits(BASE_INDENT + 2, cap & 0x0f,
> +                       faststream_sink_frequency_table);
> +
> +       print_field("%*cSource Frequency: 0x%02x", BASE_INDENT + 2, ' ',
> +                       cap & 0xf0);
> +       print_value_bits(BASE_INDENT + 2, cap & 0xf0,
> +                       faststream_source_frequency_table);
> +
> +       return true;
> +}
> +
> +static bool codec_vendor_aptx_ll_cap(uint8_t losc, struct l2cap_frame *f=
rame)
> +{
> +       uint8_t cap =3D 0;
> +       uint16_t level =3D 0;
> +
> +       if (losc !=3D 2 && losc !=3D 11)
> +               return false;
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0=
xf0);
> +       print_value_bits(BASE_INDENT + 2, cap & 0xf0, aptx_frequency_tabl=
e);
> +
> +       print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ',
> +                                                               cap & 0x0=
f);
> +       print_value_bits(BASE_INDENT + 2, cap & 0x0f, aptx_channel_mode_t=
able);
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cBidirectional link: %s", BASE_INDENT, ' ',
> +                       (cap & 1) ? "Yes" : "No");
> +
> +       if ((cap & 2) && losc =3D=3D 11) {
> +               /* reserved */
> +               l2cap_frame_get_u8(frame, &cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cTarget codec buffer level: %u (0x%02x)",
> +                               BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cInitial codec buffer level: %u (0x%02x)",
> +                               BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA max rate: %g (0x%02x)",
> +                               BASE_INDENT + 2, ' ', cap / 10000.0, cap)=
;
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA averaging time: %us (0x%02x)",
> +                               BASE_INDENT + 2, ' ', cap, cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cGood working codec buffer level: %u (0x%0=
2x)",
> +                               BASE_INDENT + 2, ' ', level, level);
> +       }
> +
> +       return true;
> +}
> +
> +static bool codec_vendor_aptx_hd_cap(uint8_t losc, struct l2cap_frame *f=
rame)
> +{
> +       uint8_t cap =3D 0;
> +
> +       if (losc !=3D 5)
> +               return false;
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0=
xf0);
> +       print_value_bits(BASE_INDENT + 2, cap & 0xf0, aptx_frequency_tabl=
e);
> +
> +       print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ',
> +                                                               cap & 0x0=
f);
> +       print_value_bits(BASE_INDENT + 2, cap & 0x0f, aptx_channel_mode_t=
able);
> +
> +       /* reserved */
> +       l2cap_frame_get_u8(frame, &cap);
> +       l2cap_frame_get_u8(frame, &cap);
> +       l2cap_frame_get_u8(frame, &cap);
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       return true;
> +}
> +
>  static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame)
>  {
>         uint16_t cap =3D 0;
> @@ -526,6 +689,7 @@ static bool codec_vendor_cap(uint8_t losc, struct l2c=
ap_frame *frame)
>  {
>         uint32_t vendor_id =3D 0;
>         uint16_t codec_id =3D 0;
> +       size_t i;
>
>         if (losc < 6)
>                 return false;
> @@ -541,10 +705,11 @@ static bool codec_vendor_cap(uint8_t losc, struct l=
2cap_frame *frame)
>         print_field("%*cVendor Specific Codec ID: %s (0x%04x)", BASE_INDE=
NT,
>                         ' ', vndcodec2str(vendor_id, codec_id), codec_id)=
;
>
> -       if (vendor_id =3D=3D APTX_VENDOR_ID && codec_id =3D=3D APTX_CODEC=
_ID)
> -               return codec_vendor_aptx_cap(losc, frame);
> -       else if (vendor_id =3D=3D LDAC_VENDOR_ID && codec_id =3D=3D LDAC_=
CODEC_ID)
> -               return codec_vendor_ldac(losc, frame);
> +       for (i =3D 0; i < sizeof(vndcodecs)/sizeof(*vndcodecs); i++) {
> +               if (vndcodecs[i].vendor_id =3D=3D vendor_id &&
> +                   vndcodecs[i].codec_id =3D=3D codec_id)
> +                       return vndcodecs[i].codec_vendor_cap(losc, frame)=
;
> +       }
>
>         packet_hexdump(frame->data, losc);
>         l2cap_frame_pull(frame, frame, losc);
> @@ -572,10 +737,116 @@ static bool codec_vendor_aptx_cfg(uint8_t losc, st=
ruct l2cap_frame *frame)
>         return true;
>  }
>
> +static bool codec_vendor_faststream_cfg(uint8_t losc, struct l2cap_frame=
 *frame)
> +{
> +       uint8_t cap =3D 0;
> +
> +       if (losc !=3D 2)
> +               return false;
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cDirection: %s (0x%02x)", BASE_INDENT + 2, ' ',
> +                       find_value_bit(cap, faststream_direction_table),
> +                       cap);
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cSink Frequency: %s (0x%02x)", BASE_INDENT + 2, ' =
',
> +                       find_value_bit(cap & 0x0f,
> +                               faststream_sink_frequency_table),
> +                       cap & 0x0f);
> +
> +       print_field("%*cSource Frequency: %s (0x%02x)", BASE_INDENT + 2, =
' ',
> +                       find_value_bit(cap & 0xf0,
> +                               faststream_source_frequency_table),
> +                       cap & 0xf0);
> +
> +       return true;
> +}
> +
> +static bool codec_vendor_aptx_ll_cfg(uint8_t losc, struct l2cap_frame *f=
rame)
> +{
> +       uint8_t cap =3D 0;
> +       uint16_t level =3D 0;
> +
> +       if (losc !=3D 2 && losc !=3D 11)
> +               return false;
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
> +                       find_value_bit(cap & 0xf0, aptx_frequency_table),
> +                       cap & 0xf0);
> +
> +       print_field("%*cChannel Mode: %s (0x%02x)", BASE_INDENT + 2, ' ',
> +                       find_value_bit(cap & 0x0f, aptx_channel_mode_tabl=
e),
> +                       cap & 0x0f);
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cBidirectional link: %s", BASE_INDENT, ' ',
> +                       (cap & 1) ? "Yes" : "No");
> +
> +       if ((cap & 2) && losc =3D=3D 11) {
> +               /* reserved */
> +               l2cap_frame_get_u8(frame, &cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cTarget codec buffer level: %u (0x%02x)",
> +                               BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cInitial codec buffer level: %u (0x%02x)",
> +                               BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA max rate: %g (0x%02x)",
> +                               BASE_INDENT + 2, ' ', cap / 10000.0, cap)=
;
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA averaging time: %us (0x%02x)",
> +                               BASE_INDENT + 2, ' ', cap, cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cGood working codec buffer level: %u (0x%0=
2x)",
> +                               BASE_INDENT + 2, ' ', level, level);
> +       }
> +
> +       return true;
> +}
> +
> +static bool codec_vendor_aptx_hd_cfg(uint8_t losc, struct l2cap_frame *f=
rame)
> +{
> +       uint8_t cap =3D 0;
> +
> +       if (losc !=3D 5)
> +               return false;
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
> +                       find_value_bit(cap & 0xf0, aptx_frequency_table),
> +                       cap & 0xf0);
> +
> +       print_field("%*cChannel Mode: %s (0x%02x)", BASE_INDENT + 2, ' ',
> +                       find_value_bit(cap & 0x0f, aptx_channel_mode_tabl=
e),
> +                       cap & 0x0f);
> +
> +       /* reserved */
> +       l2cap_frame_get_u8(frame, &cap);
> +       l2cap_frame_get_u8(frame, &cap);
> +       l2cap_frame_get_u8(frame, &cap);
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       return true;
> +}
> +
>  static bool codec_vendor_cfg(uint8_t losc, struct l2cap_frame *frame)
>  {
>         uint32_t vendor_id =3D 0;
>         uint16_t codec_id =3D 0;
> +       size_t i;
>
>         if (losc < 6)
>                 return false;
> @@ -591,10 +862,11 @@ static bool codec_vendor_cfg(uint8_t losc, struct l=
2cap_frame *frame)
>         print_field("%*cVendor Specific Codec ID: %s (0x%04x)", BASE_INDE=
NT,
>                         ' ', vndcodec2str(vendor_id, codec_id), codec_id)=
;
>
> -       if (vendor_id =3D=3D APTX_VENDOR_ID && codec_id =3D=3D APTX_CODEC=
_ID)
> -               return codec_vendor_aptx_cfg(losc, frame);
> -       else if (vendor_id =3D=3D LDAC_VENDOR_ID && codec_id =3D=3D LDAC_=
CODEC_ID)
> -               return codec_vendor_ldac(losc, frame);
> +       for (i =3D 0; i < sizeof(vndcodecs)/sizeof(*vndcodecs); i++) {
> +               if (vndcodecs[i].vendor_id =3D=3D vendor_id &&
> +                   vndcodecs[i].codec_id =3D=3D codec_id)
> +                       return vndcodecs[i].codec_vendor_cfg(losc, frame)=
;
> +       }
>
>         packet_hexdump(frame->data, losc);
>         l2cap_frame_pull(frame, frame, losc);
> --
> 2.11.0

Applied, thanks.


--=20
Luiz Augusto von Dentz
