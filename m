Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E2E776C5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 21:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjJBVbC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJBVbA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 17:31:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C43AAB
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 14:30:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3231df054c4so251597f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696282254; x=1696887054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9WILgfxQci2o0sSf8xLlgJ5L8zQRDgClu+/cg3XqgY=;
        b=FykA9GorqRl9lNRl3uZSCfjmRnvKvGc5U21ZZNyEtZ29LiSaobulDbre0EjHNsNekY
         M5+BX//WUJkj/0obrs67k7lFKhRsvaELpqDEElAf0N/dEe5UFSLVoS3FVbld8GOMQnFA
         vdKpoGbTXtxbQ2kcos3eJfMwmcmy1OJMtkFe4lHx/e8IaY8vG4Bne34nH/m/wMj1dILX
         mzZZyGb6tUZr8r1N4aeJLGuntxCflFwobbHLGmDZxdbqA+DeOPTy6RJo+o0yniAgEXz0
         LcYxDZIz1G0We2NUhzSbICd4L5qOyFc6Zpm8L9D/9VOGNHEEW7muSsG1W+YVS/iFoLGV
         u5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696282254; x=1696887054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9WILgfxQci2o0sSf8xLlgJ5L8zQRDgClu+/cg3XqgY=;
        b=ZEsAs7WwNInEsu/+LEf+UKTfVYNnGmWhiTOy+8WjU7Z+hxxgJoQQKrhHZNmQ2S0EPF
         NK7riKD/B50obqvuBHTspxqGKPgPIF1aqDhcHkTYQvrnJccaDvv4W78EQIITo6TCzzYp
         f4tmstbT0zy7p4qaiIQfshYEgJw6OcTsoDdRqb3QPFLo6ajTnWUJSlNeKI/LVjSrxJ3Z
         Gm/yEK0U8hpCOlvaMJVqMuLh1SpJKq4Acv77sSTF9CzDY40n0l/NZHdulE7Lk6iq7c0u
         N/iqOCfqobc1NOqKW26TOFz7IOHemzpSXZLAyQ6e2BBWYx7WSRJxqgOUdEBpyF7j0poq
         EdXQ==
X-Gm-Message-State: AOJu0YzKRjuvqUWdn0cvY9KyKt9p+5+Bz5igTEb1DWJZxcMqmZ627tiK
        y+xXQYvCS7AzcEm2fVbJ47jGeSUsPBzpvDw811s=
X-Google-Smtp-Source: AGHT+IFQtvJ2+14SSBFaIRyuzvpeor/YJfyRKZe9si/GbH22kZWx8Iost/zx8gPXzKFfoeuZ5+/rFK7+RI0ezEhKaWk=
X-Received: by 2002:a5d:5253:0:b0:317:573c:1314 with SMTP id
 k19-20020a5d5253000000b00317573c1314mr11655692wrc.58.1696282253347; Mon, 02
 Oct 2023 14:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231002153352.3163-1-iulia.tanasescu@nxp.com> <20231002153352.3163-4-iulia.tanasescu@nxp.com>
In-Reply-To: <20231002153352.3163-4-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Oct 2023 14:30:40 -0700
Message-ID: <CABBYNZKiTS9herQBkMZge3CienN46_1TDcjdFUPf+yw05ESwtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] bap:Update transport acquire/release flow for
 bcast src
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Mon, Oct 2, 2023 at 8:34=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
>
> Update transport acquire/release flow for BAP bcast source
>
> ---
>  profiles/audio/bap.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 48a1a4f86..9a46b16ab 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1328,6 +1328,10 @@ static void iso_connect_cb(GIOChannel *chan, GErro=
r *err, gpointer user_data)
>         fd =3D g_io_channel_unix_get_fd(chan);
>
>         if (bt_bap_stream_set_io(stream, fd)) {
> +               if (bt_bap_stream_get_type(stream) =3D=3D
> +                                               BT_BAP_STREAM_TYPE_BCAST)=
 {
> +                       bt_bap_stream_start(stream, NULL, NULL);
> +               }

Perhaps it would be a better idea to have a dedicated callback for
broadcast in this case, so we don't mix the flows with unicast, since
the handling is quite different. In fact I was going to suggest we
change the broadcast code to live on bcaa driver rather than bap, so
we can move the handing on adapter_probe/adapter_remove there instead
of messing up with bap.

>                 g_io_channel_set_close_on_unref(chan, FALSE);
>                 return;
>         }
> @@ -1887,18 +1891,16 @@ static void bap_state(struct bt_bap_stream *strea=
m, uint8_t old_state,
>                 }
>                 break;
>         case BT_BAP_STREAM_STATE_QOS:
> -               bap_create_io(data, ep, stream, true);
> +               if (bt_bap_stream_get_type(stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST) {
> +                       bap_create_io(data, ep, stream, true);
> +               }
>                 break;
>         case BT_BAP_STREAM_STATE_ENABLING:
>                 if (ep)
>                         bap_create_io(data, ep, stream, false);
>                 break;
>         case BT_BAP_STREAM_STATE_STREAMING:
> -               if (bt_bap_stream_get_type(stream) =3D=3D
> -                               BT_BAP_STREAM_TYPE_BCAST) {
> -                       if (ep)
> -                               bap_create_io(data, ep, stream, false);
> -               }
>                 break;
>         }
>  }
> @@ -2116,6 +2118,8 @@ static void bap_connecting(struct bt_bap_stream *st=
ream, bool state, int fd,
>
>                         ep->qos.bcast.big =3D qos.bcast.big;
>                         ep->qos.bcast.bis =3D qos.bcast.bis;
> +                       bt_bap_stream_config(ep->stream, &ep->qos,
> +                                       ep->caps, NULL, NULL);
>                 }
>
>                 DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
