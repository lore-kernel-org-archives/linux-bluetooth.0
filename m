Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C68C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 23:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCNXl5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 19:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNXl4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 19:41:56 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573003D0BD
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 16:41:54 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id n17so4779377uaj.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7u2UoFEleKTHFjM/LoaPFEaAQRIlqZsn3+EJyaN6Ig=;
        b=K+zm8NsO94HaE0zJdZ+ula1tzQ8PDrPrBOU5DBRKtmixneAgHv4Lje7KTJSBb1kGRj
         Ln9B4LQEcLIYiWhf1TeXzjueyirvKcOq0v7kmynMIzoEifO6AVB2tCTkjJ3JJ3dSZLFE
         aeuAYdW/MPh5UDMgB4si2DU3eUcDImVkzOMwppmV1cHEGgDW1TW7v8f2+1ZP7fKn5cvS
         4Xig5CUUsO1QNt4WV5j0Ysz/AjDDIcY8zYrVFFRh+ljwgIyTNTFJHHLoVtCHshx/icC+
         7cqr1LiYw/19Q07/Irhkes+IDLO4seF5CxYx8Q1sGtXj7qNVjQV7Nmglul1r1+5FH8LI
         Icgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7u2UoFEleKTHFjM/LoaPFEaAQRIlqZsn3+EJyaN6Ig=;
        b=jDO69KpOQomzpnQPZTMdIcKK0DBLvNej/MnBUBV8xdw/JeliLAzxKm8JjCBd5RAEa1
         dzggBCVQykRR/48Hp7qGZ8TRhVzfzm/a/MvpqeOzjlsw1kMe/uHywfxLijtkOTKa9juc
         ztg4KyR7yvQBWvaJojmwI5ODOZdMSnlu2A01hAeOS1aCQcd6ulURrYZHRb+OMXlvv4nw
         ZJH/YZaTCu2FBukEtFnFe2kYiDrHf2xlavlPlrWQrUtc2PmMptST5JsFm1oARE9T/m5G
         MdmEruOahD8jTI61OKRXSKEAW4MTUPdDw9uFBaqB2RgrYNeLLlehNyHiuscb44f/rEmM
         PKNQ==
X-Gm-Message-State: AO0yUKWBbntM1bsH9XGZNcorS13pxJHbvGdBIiPgzD/ZSXL5K6bz6mti
        4OM1La3KkYosajoUWWD/ZuBk3qYa5aBBG1suM3I=
X-Google-Smtp-Source: AK7set/TbnWcxh1v/n+w57elpIAE4xsO0V+hQk+R/RTsr0dS4h7MOtqo7x2dSxBmEzNHGAWqve5eXtwGnpsZcuMN/zc=
X-Received: by 2002:ab0:544e:0:b0:68a:5c52:7f2b with SMTP id
 o14-20020ab0544e000000b0068a5c527f2bmr24694038uaa.1.1678837313353; Tue, 14
 Mar 2023 16:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230311003826.454858-1-marijn.suijten@somainline.org> <20230311003826.454858-4-marijn.suijten@somainline.org>
In-Reply-To: <20230311003826.454858-4-marijn.suijten@somainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Mar 2023 16:41:40 -0700
Message-ID: <CABBYNZLif_vF7NrbK=a1TuHRdeZcrDFbykj1jPoL3pCtbLZJXg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 3/3] audio/avrcp: Determine Absolute Volume
 support from feature category 2
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Fri, Mar 10, 2023 at 4:39=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> The AVRCP spec (1.6.2) does not mention anything about a version
> requirement for Absolute Volume, despite this feature only existing
> since spec version 1.4.  Android reports a version of 1.3 [1] for its
> "AVRCP remote" (CT) service and mentions in the comment above it itself
> relies on feature bits rather than the exposed version.  As it stands
> BlueZ requires at least version 1.4 making it unable to communicate
> absolute volume levels with even the most recent Android phones running
> Fluoride (have not checked the version on Gabeldorsche).
>
> The spec states that supporting SetAbsoluteVolume and
> EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
> excluded otherwise.  This feature bit is set on Android and, when used
> by this patch, allows for successfully communicating volume back and
> forth despite the version theoretically being too low.
>
> In order to not affect spec tests too much (which I doubt would catch
> this, and should have otherwise pointed out that Android itself is out
> of spec) this behaviour is guarded behind a config option in main.conf,
> as discussed in [2].
>
> [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0=
_r28/bta/av/bta_av_main.cc#761
> [2]: https://marc.info/?l=3Dlinux-bluetooth&m=3D163463497503113&w=3D2
> ---
>  profiles/audio/avrcp.c | 16 ++++++++++------
>  src/btd.h              |  1 +
>  src/main.c             |  8 ++++++++
>  src/main.conf          |  6 ++++++
>  4 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index c16f9cfef..11f18f25d 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1761,7 +1761,8 @@ static uint8_t avrcp_handle_set_absolute_volume(str=
uct avrcp *session,
>          * The controller on the remote end is only allowed to call SetAb=
soluteVolume
>          * on our target if it's at least version 1.4 and a category-2 de=
vice.
>          */
> -       if (!session->target || session->target->version < 0x0104 ||
> +       if (!session->target ||
> +                       (session->target->version < 0x0104 && !btd_opts.a=
vrcp.allow_volume_changed_on_pre_1_4_ct) ||
>                         !(session->target->features & AVRCP_FEATURE_CATEG=
ORY_2)) {
>                 error("Remote SetAbsoluteVolume rejected from non-categor=
y-2 peer");
>                 goto err;
> @@ -4171,13 +4172,15 @@ static void target_init(struct avrcp *session)
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
>                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
> -       if (target->version < 0x0104)
> -               return;
> -
> -       if (target->features & AVRCP_FEATURE_CATEGORY_2)
> +       /* Remote device supports receiving volume notifications */
> +       if ((target->version >=3D 0x0104 || btd_opts.avrcp.allow_volume_c=
hanged_on_pre_1_4_ct) &&
> +                       target->features & AVRCP_FEATURE_CATEGORY_2)
>                 session->supported_events |=3D
>                                 (1 << AVRCP_EVENT_VOLUME_CHANGED);
>
> +       if (target->version < 0x0104)
> +               return;
> +
>         session->supported_events |=3D
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGE=
D) |
>                                 (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANG=
ED);
> @@ -4595,7 +4598,8 @@ int avrcp_set_volume(struct btd_device *dev, int8_t=
 volume, bool notify)
>                 return -ENOTCONN;
>
>         if (notify) {
> -               if (!session->target || session->target->version < 0x0104=
 ||
> +               if (!session->target ||
> +                               (session->target->version < 0x0104 && !bt=
d_opts.avrcp.allow_volume_changed_on_pre_1_4_ct) ||
>                                 !(session->target->features & AVRCP_FEATU=
RE_CATEGORY_2)) {
>                         error("Can't send EVENT_VOLUME_CHANGED to non-cat=
egory-2 peer");
>                         return -ENOTSUP;
> diff --git a/src/btd.h b/src/btd.h
> index 31c04a990..07d1d961f 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -99,6 +99,7 @@ struct btd_avdtp_opts {
>
>  struct btd_avrcp_opts {
>         gboolean set_absolute_volume_without_target;
> +       gboolean allow_volume_changed_on_pre_1_4_ct;
>  };
>
>  struct btd_advmon_opts {
> diff --git a/src/main.c b/src/main.c
> index 92f74e381..a2b81f940 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -154,6 +154,7 @@ static const char *avdtp_options[] =3D {
>
>  static const char *avrcp_options[] =3D {
>         "SetAbsoluteVolumeWithoutTarget",
> +       "AllowVolumeChangedOnPre1_4Controller",
>         NULL
>  };
>
> @@ -988,6 +989,13 @@ static void parse_config(GKeyFile *config)
>         else
>                 btd_opts.avrcp.set_absolute_volume_without_target =3D boo=
lean;
>
> +       boolean =3D g_key_file_get_boolean(config, "AVRCP",
> +                                               "AllowVolumeChangedOnPre1=
_4Controller", &err);
> +       if (err)
> +               g_clear_error(&err);
> +       else
> +               btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct =3D boo=
lean;
> +
>         val =3D g_key_file_get_integer(config, "AdvMon", "RSSISamplingPer=
iod",
>                                                                         &=
err);
>         if (err) {
> diff --git a/src/main.conf b/src/main.conf
> index ca00ed03e..286d092bf 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -277,6 +277,12 @@
>  # profile.
>  #SetAbsoluteVolumeWithoutTarget =3D false
>
> +# Allow peer AVRCP controller with version 1.3 access to category-2 (abs=
olute volume) features.
> +# This is common for AOSP to not signal the desired minimum version of 1=
.4 while still supporting
> +# absolute volume based on the feature category bit, as mentioned in the=
 comment:
> +# https://android.googlesource.com/platform/system/bt/+/android-12.0.0_r=
1/bta/av/bta_av_main.cc#621
> +AllowVolumeChangedOnPre1_4Controller =3D true

This is too long to my liking, perhaps have VolumeVersion instead and
if it is configured as false we just check the category.

>  [Policy]
>  #
>  # The ReconnectUUIDs defines the set of remote services that should try
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
