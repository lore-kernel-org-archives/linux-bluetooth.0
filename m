Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08DC169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CB6218AC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUzK3dpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfAaKvG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:51:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36622 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAaKvG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 05:51:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so2353146oix.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l1KZ14nWHdwrhvul2mSEXynmf9y8Ds47wIZuCeMlcS0=;
        b=QUzK3dpxoFXbjqFPcSJrl0MLJW7rOeumle2Xu0sRDGG3WKPQYP12kY6UvgPOoR6r8f
         s8qhDSYP8b6mlgsnOEd/8rGVYFirc0iYTtfDbcWRcnOi97kTgOpbHVhy4JIVNoJomojT
         N211Sqpn6KlHAq7W5xoRkRCshzH5y+qZQRdk4xJ/r2xMRRs2Elp22kOYIq8vQD5QHwha
         ghksgZb/5Tw+XFp1pudEQ2QWk9sZNSkc9EohiMAD64rxs6sVxgItjLEawUtwMEz4uKBh
         GgJrMigvqu2Eb4fmeJlqmhDB1/gkhi4ropPvF47ZAPMUl80uRKb6Fe9mbS0ePuEx/1EM
         SpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l1KZ14nWHdwrhvul2mSEXynmf9y8Ds47wIZuCeMlcS0=;
        b=Q3VI/LFUiJEIy6eq4Bxz1S9z7Odf+oJP7Nc7QaGyoIAA+I3RxREOolHDmGB6RGQpz9
         qRWGIAgh1RcktmouehZrsq71rFDpMpq9gVXhtOpBc1voPx1YK9u9JIjumf6un1GbyWqe
         4RLxXOtsFxEKJWhjzEGlTTi1udLxOE1LGAGSCLtWAMW8MRCsw1dMd4HKGV1UapVEJkwz
         JwfEI9rSfnmMRIMrMRi1YfkMBPnVYmJLvJpzhBUknSt646FIY3ck5wobHlSUMBaVCWU2
         Y31cTAoN+oeH9x6ze61yoWiQtvzN1c7mj25jj2m1SQy3lFn5t2Qcoc2kb/P2ArFkrGEs
         Y73w==
X-Gm-Message-State: AJcUukecoFcRDWEQ4B6CiWir6/e1IZ3Nk7+LdBqFZok6ujZJFjXoV7qr
        h1rQhGuSoNEs0aTAMgTQcC+/V0UJIqIyHKKawFGyQA==
X-Google-Smtp-Source: AHgI3IZJeuQK2SOVEVmBxfpzrcHVxQybeZckEZyBNKfTYBE4+CcbpIYVnHIcGoEgoJGjy4t9STTkMrpblZkD070/5nk=
X-Received: by 2002:aca:3dc5:: with SMTP id k188mr15341602oia.108.1548931864771;
 Thu, 31 Jan 2019 02:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20190126104606.26486-1-pali.rohar@gmail.com>
In-Reply-To: <20190126104606.26486-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Jan 2019 12:50:52 +0200
Message-ID: <CABBYNZKqVmFGEXKRfo=w=NCn_fqc-Dc2WsAD8vQdkcRZsGL8yw@mail.gmail.com>
Subject: Re: [PATCH] a2dp-codecs & avinfo: Simplify defintions and parsing of
 aptX family
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,
On Sat, Jan 26, 2019 at 12:48 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> Reuse whole a2dp_aptx_t structure and defines as they are same for aptX L=
ow
> Latency and aptX HD.
> ---
>  profiles/audio/a2dp-codecs.h | 46 ++++++--------------------------------
>  tools/avinfo.c               | 53 +++++++++++++-------------------------=
------
>  2 files changed, 22 insertions(+), 77 deletions(-)
>
> diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
> index f31f3a311..4789e27ed 100644
> --- a/profiles/audio/a2dp-codecs.h
> +++ b/profiles/audio/a2dp-codecs.h
> @@ -213,14 +213,6 @@
>  #define APTX_LL_VENDOR_ID              0x0000000a
>  #define APTX_LL_CODEC_ID               0x0002
>
> -#define APTX_LL_CHANNEL_MODE_MONO      0x01
> -#define APTX_LL_CHANNEL_MODE_STEREO    0x02
> -
> -#define APTX_LL_SAMPLING_FREQ_16000    0x08
> -#define APTX_LL_SAMPLING_FREQ_32000    0x04
> -#define APTX_LL_SAMPLING_FREQ_44100    0x02
> -#define APTX_LL_SAMPLING_FREQ_48000    0x01
> -
>  /* Default parameters for aptX Low Latency encoder */
>
>  /* Target codec buffer level =3D 180 */
> @@ -244,14 +236,6 @@
>  #define APTX_HD_VENDOR_ID              0x000000D7
>  #define APTX_HD_CODEC_ID               0x0024
>
> -#define APTX_HD_CHANNEL_MODE_MONO      0x1
> -#define APTX_HD_CHANNEL_MODE_STEREO    0x2
> -
> -#define APTX_HD_SAMPLING_FREQ_16000    0x8
> -#define APTX_HD_SAMPLING_FREQ_32000    0x4
> -#define APTX_HD_SAMPLING_FREQ_44100    0x2
> -#define APTX_HD_SAMPLING_FREQ_48000    0x1
> -
>  #define LDAC_VENDOR_ID                 0x0000012d
>  #define LDAC_CODEC_ID                  0x00aa
>
> @@ -360,25 +344,13 @@ typedef struct {
>  } __attribute__ ((packed)) a2dp_faststream_t;
>
>  typedef struct {
> -       a2dp_vendor_codec_t info;
> -       uint8_t channel_mode:4;
> -       uint8_t frequency:4;
> +       a2dp_aptx_t aptx;
>         uint8_t bidirect_link:1;
>         uint8_t has_new_caps:1;
>         uint8_t reserved:6;
>         a2dp_aptx_ll_new_caps_t new_caps[0];
>  } __attribute__ ((packed)) a2dp_aptx_ll_t;
>
> -typedef struct {
> -       a2dp_vendor_codec_t info;
> -       uint8_t channel_mode:4;
> -       uint8_t frequency:4;
> -       uint8_t reserved0;
> -       uint8_t reserved1;
> -       uint8_t reserved2;
> -       uint8_t reserved3;
> -} __attribute__ ((packed)) a2dp_aptx_hd_t;
> -
>  #elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && \
>         __BYTE_ORDER =3D=3D __BIG_ENDIAN
>
> @@ -430,25 +402,21 @@ typedef struct {
>  } __attribute__ ((packed)) a2dp_faststream_t;
>
>  typedef struct {
> -       a2dp_vendor_codec_t info;
> -       uint8_t frequency:4;
> -       uint8_t channel_mode:4;
> +       a2dp_aptx_t aptx;
>         uint8_t reserved:6;
>         uint8_t has_new_caps:1;
>         uint8_t bidirect_link:1;
>         a2dp_aptx_ll_new_caps_t new_caps[0];
>  } __attribute__ ((packed)) a2dp_aptx_ll_t;
>
> +#else
> +#error "Unknown byte order"
> +#endif
> +
>  typedef struct {
> -       a2dp_vendor_codec_t info;
> -       uint8_t frequency:4;
> -       uint8_t channel_mode:4;
> +       a2dp_aptx_t aptx;
>         uint8_t reserved0;
>         uint8_t reserved1;
>         uint8_t reserved2;
>         uint8_t reserved3;
>  } __attribute__ ((packed)) a2dp_aptx_hd_t;
> -
> -#else
> -#error "Unknown byte order"
> -#endif
> diff --git a/tools/avinfo.c b/tools/avinfo.c
> index 42f539f43..852d7b67e 100644
> --- a/tools/avinfo.c
> +++ b/tools/avinfo.c
> @@ -168,15 +168,8 @@ struct avdtp_content_protection_capability {
>         uint8_t data[0];
>  } __attribute__ ((packed));
>
> -static void print_aptx(a2dp_aptx_t *aptx, uint8_t size)
> +static void print_aptx_common(a2dp_aptx_t *aptx)
>  {
> -       printf("\t\tVendor Specific Value (aptX)");
> -
> -       if (size < sizeof(*aptx)) {
> -               printf(" (broken)\n");
> -               return;
> -       }
> -
>         printf("\n\t\t\tFrequencies: ");
>         if (aptx->frequency & APTX_SAMPLING_FREQ_16000)
>                 printf("16kHz ");
> @@ -192,6 +185,18 @@ static void print_aptx(a2dp_aptx_t *aptx, uint8_t si=
ze)
>                 printf("Mono ");
>         if (aptx->channel_mode & APTX_CHANNEL_MODE_STEREO)
>                 printf("Stereo ");
> +}
> +
> +static void print_aptx(a2dp_aptx_t *aptx, uint8_t size)
> +{
> +       printf("\t\tVendor Specific Value (aptX)");
> +
> +       if (size < sizeof(*aptx)) {
> +               printf(" (broken)\n");
> +               return;
> +       }
> +
> +       print_aptx_common(aptx);
>
>         printf("\n");
>  }
> @@ -242,21 +247,7 @@ static void print_aptx_ll(a2dp_aptx_ll_t *aptx_ll, u=
int8_t size)
>                 return;
>         }
>
> -       printf("\n\t\t\tFrequencies: ");
> -       if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_16000)
> -               printf("16kHz ");
> -       if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_32000)
> -               printf("32kHz ");
> -       if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_44100)
> -               printf("44.1kHz ");
> -       if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_48000)
> -               printf("48kHz ");
> -
> -       printf("\n\t\t\tChannel modes: ");
> -       if (aptx_ll->channel_mode & APTX_LL_CHANNEL_MODE_MONO)
> -               printf("Mono ");
> -       if (aptx_ll->channel_mode & APTX_LL_CHANNEL_MODE_STEREO)
> -               printf("Stereo ");
> +       print_aptx_common(&aptx_ll->aptx);
>
>         printf("\n\t\tBidirectional link: %s",
>                         aptx_ll->bidirect_link ? "Yes" : "No");
> @@ -292,21 +283,7 @@ static void print_aptx_hd(a2dp_aptx_hd_t *aptx_hd, u=
int8_t size)
>                 return;
>         }
>
> -       printf("\n\t\t\tFrequencies: ");
> -       if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_16000)
> -               printf("16kHz ");
> -       if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_32000)
> -               printf("32kHz ");
> -       if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_44100)
> -               printf("44.1kHz ");
> -       if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_48000)
> -               printf("48kHz ");
> -
> -       printf("\n\t\t\tChannel modes: ");
> -       if (aptx_hd->channel_mode & APTX_HD_CHANNEL_MODE_MONO)
> -               printf("Mono ");
> -       if (aptx_hd->channel_mode & APTX_HD_CHANNEL_MODE_STEREO)
> -               printf("Stereo ");
> +       print_aptx_common(&aptx_hd->aptx);
>
>         printf("\n");
>  }
> --
> 2.11.0

Applied, thanks.

--=20
Luiz Augusto von Dentz
