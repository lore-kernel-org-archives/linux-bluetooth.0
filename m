Return-Path: <SRS0=1nTO=O7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C550C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Dec 2018 23:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC39218E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Dec 2018 23:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKrA/ZuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbeLVXEe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:04:34 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37426 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLVXEe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Dec 2018 18:04:34 -0500
Received: by mail-ot1-f45.google.com with SMTP id 40so8331176oth.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Dec 2018 15:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l17be5uc9Xrk0ALe+IieWWmNQlQupzPwdOdQApZF9ig=;
        b=XKrA/ZuJe/nL1yYZ4zyHKwZoi911TOHYGe0kAeOigOyJn7nBH69qcSivYImJF0vY+1
         2Yyp/Ium6XG8/viFpF/VY8PRigeusqvkjOGi9PUlFAGMl8lD/vkUYWsDKKa6LiUDkdb3
         UZnYh2Szlw0oai79L9znmdRMQMihlxeFrXnmQ6vRkaeMz63ZzxedqjbA5QK+tsDBe0SM
         /1dHTWKd+kVRXHCK73gc3GA46WnlOpqG79BC0VG2B7wCn3byIEuIB9gX/eWSg7ac/Ktz
         8vJTmoTLw00TosK7dCLbDYMjgFHlAC0EKTBYKoHvGzVtg3K2aZTTbb/ULoAQVqCzHtjz
         S++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l17be5uc9Xrk0ALe+IieWWmNQlQupzPwdOdQApZF9ig=;
        b=Z0ai04LxLmjCvzzHiyxcEOwHVjXkdUyOPQE2oBjSG4aHFgMns0H/ZGNT3668vKL8Pj
         pFzAVO1qBS6XrnLkCdPz4jcrB+VqfI9Taso3VoEPUAaoInvFX2ecGr6kmgnSV+j/yLmQ
         fgxSDynOBtarCjPFP8TueGZzpIWetSEsrQ2LE4Mh/Mj433RWCGnlD+3XWR1GkJrd+uX+
         HWQoOk8lAymGXMIW4Fgv23DVGz9EuocmPRxZ0A/BG1nMqkVgy9s/EbRpz51KV895RfSv
         +LlGiO4BHH7+Thgg/hzVbXaQvnADpdK+xO7sfS9eR5nTLt8foLoHJ97OTiv4MlXd9b14
         e4Ew==
X-Gm-Message-State: AJcUukclqFU9PV3n1rq2xXFaZEImzcAdAM54YIe31OUx5AG3oMOM0oNl
        rifsUaZhDAM/b0zbONWbux+jdX8ThYu45/94Fc4=
X-Google-Smtp-Source: ALg8bN4EnIaut2B1fU01QYoIEvI6BLDdnIA8dueXHt0R2W2TV8xXMTmoRlB5XLLCNII6gFlv1qNBrJ3WnegJBLQ60RU=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr5369010otf.242.1545519873029;
 Sat, 22 Dec 2018 15:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20181219211735.17563-1-pali.rohar@gmail.com>
In-Reply-To: <20181219211735.17563-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 22 Dec 2018 20:04:21 -0300
Message-ID: <CABBYNZ+ntTPASbv4434zJf7q_KRtiGbduSORbhNoC__ihZW-cA@mail.gmail.com>
Subject: Re: [PATCH] btmon: Parse information about A2DP codecs: FastStream,
 aptX Low Latency and aptX HD
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Dec 19, 2018 at 7:17 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> ---

The commit message should be formated to fit in 80 columns including
the spaces/tabs added by the likes of git shortlog, you can probably
move part of the subject like to the actual description.

>  monitor/a2dp.c | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 230 insertions(+)
>
> diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> index 6a271217b..6e82500d4 100644
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
> @@ -215,6 +239,12 @@ static const char *vndcodec2str(uint32_t vendor_id, =
uint16_t codec_id)
>  {
>         if (vendor_id =3D=3D APTX_VENDOR_ID && codec_id =3D=3D APTX_CODEC=
_ID)
>                 return "aptX";
> +       else if (vendor_id =3D=3D FASTSTREAM_VENDOR_ID && codec_id =3D=3D=
 FASTSTREAM_CODEC_ID)
> +               return "FastStream";
> +       else if (vendor_id =3D=3D APTX_LL_VENDOR_ID && codec_id =3D=3D AP=
TX_LL_CODEC_ID)
> +               return "aptX Low Latency";
> +       else if (vendor_id =3D=3D APTX_HD_VENDOR_ID && codec_id =3D=3D AP=
TX_HD_CODEC_ID)
> +               return "aptX HD";
>         else if (vendor_id =3D=3D LDAC_VENDOR_ID && codec_id =3D=3D LDAC_=
CODEC_ID)
>                 return "LDAC";

I wonder if it wouldn't be better to have a table with these as well,
so we define a struct with vendor id, codec id and string name.

> @@ -508,6 +538,98 @@ static bool codec_vendor_aptx_cap(uint8_t losc, stru=
ct l2cap_frame *frame)
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
> +       print_field("%*cSink Frequency: 0x%02x", BASE_INDENT + 2, ' ', ca=
p & 0x0f);
> +       print_value_bits(BASE_INDENT + 2, cap & 0x0f, faststream_sink_fre=
quency_table);
> +
> +       print_field("%*cSource Frequency: 0x%02x", BASE_INDENT + 2, ' ', =
cap & 0xf0);
> +       print_value_bits(BASE_INDENT + 2, cap & 0xf0, faststream_source_f=
requency_table);
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
> +       print_field("%*cBidirectional link: %s", BASE_INDENT, ' ', (cap &=
 1) ? "Yes" : "No");
> +
> +       if ((cap & 2) && losc =3D=3D 11) {
> +               /* reserved */
> +               l2cap_frame_get_u8(frame, &cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cTarget codec buffer level: %u (0x%02x)", =
BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cInitial codec buffer level: %u (0x%02x)",=
 BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA max rate: %g (0x%02x)", BASE_INDENT +=
 2, ' ', cap / 10000.0, cap);
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA averaging time: %us (0x%02x)", BASE_I=
NDENT + 2, ' ', cap, cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cGood working codec buffer level: %u (0x%0=
2x)", BASE_INDENT + 2, ' ', level, level);

I suspect many of these lines are above 80 columns, please fix them.

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
> @@ -543,6 +665,12 @@ static bool codec_vendor_cap(uint8_t losc, struct l2=
cap_frame *frame)
>
>         if (vendor_id =3D=3D APTX_VENDOR_ID && codec_id =3D=3D APTX_CODEC=
_ID)
>                 return codec_vendor_aptx_cap(losc, frame);
> +       else if (vendor_id =3D=3D FASTSTREAM_VENDOR_ID && codec_id =3D=3D=
 FASTSTREAM_CODEC_ID)
> +               return codec_vendor_faststream_cap(losc, frame);
> +       else if (vendor_id =3D=3D APTX_LL_VENDOR_ID && codec_id =3D=3D AP=
TX_LL_CODEC_ID)
> +               return codec_vendor_aptx_ll_cap(losc, frame);
> +       else if (vendor_id =3D=3D APTX_HD_VENDOR_ID && codec_id =3D=3D AP=
TX_HD_CODEC_ID)
> +               return codec_vendor_aptx_hd_cap(losc, frame);
>         else if (vendor_id =3D=3D LDAC_VENDOR_ID && codec_id =3D=3D LDAC_=
CODEC_ID)
>                 return codec_vendor_ldac(losc, frame);

If we go ahead with the idea of defining a table of vendor codecs the
struct could also define a function callback which parses these so one
just have to include new entries to table.

> @@ -572,6 +700,102 @@ static bool codec_vendor_aptx_cfg(uint8_t losc, str=
uct l2cap_frame *frame)
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
> +                       find_value_bit(cap & 0x0f, faststream_sink_freque=
ncy_table),
> +                       cap & 0x0f);
> +
> +       print_field("%*cSource Frequency: %s (0x%02x)", BASE_INDENT + 2, =
' ',
> +                       find_value_bit(cap & 0xf0, faststream_source_freq=
uency_table),
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
> +       print_field("%*cBidirectional link: %s", BASE_INDENT, ' ', (cap &=
 1) ? "Yes" : "No");
> +
> +       if ((cap & 2) && losc =3D=3D 11) {
> +               l2cap_frame_get_u8(frame, &cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cTarget codec buffer level: %u (0x%02x)", =
BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cInitial codec buffer level: %u (0x%02x)",=
 BASE_INDENT + 2, ' ', level, level);
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA max rate: %g (0x%02x)", BASE_INDENT +=
 2, ' ', cap / 10000.0, cap);
> +
> +               l2cap_frame_get_u8(frame, &cap);
> +               print_field("%*cSRA averaging time: %us (0x%02x)", BASE_I=
NDENT + 2, ' ', cap, cap);
> +
> +               l2cap_frame_get_le16(frame, &level);
> +               print_field("%*cGood working codec buffer level: %u (0x%0=
2x)", BASE_INDENT + 2, ' ', level, level);
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
> @@ -593,6 +817,12 @@ static bool codec_vendor_cfg(uint8_t losc, struct l2=
cap_frame *frame)
>
>         if (vendor_id =3D=3D APTX_VENDOR_ID && codec_id =3D=3D APTX_CODEC=
_ID)
>                 return codec_vendor_aptx_cfg(losc, frame);
> +       else if (vendor_id =3D=3D FASTSTREAM_VENDOR_ID && codec_id =3D=3D=
 FASTSTREAM_CODEC_ID)
> +               return codec_vendor_faststream_cfg(losc, frame);
> +       else if (vendor_id =3D=3D APTX_LL_VENDOR_ID && codec_id =3D=3D AP=
TX_LL_CODEC_ID)
> +               return codec_vendor_aptx_ll_cfg(losc, frame);
> +       else if (vendor_id =3D=3D APTX_HD_VENDOR_ID && codec_id =3D=3D AP=
TX_HD_CODEC_ID)
> +               return codec_vendor_aptx_hd_cfg(losc, frame);
>         else if (vendor_id =3D=3D LDAC_VENDOR_ID && codec_id =3D=3D LDAC_=
CODEC_ID)
>                 return codec_vendor_ldac(losc, frame);

Ditto.

>
> --
> 2.11.0
>


--=20
Luiz Augusto von Dentz
