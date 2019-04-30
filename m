Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF651C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 12:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9F72075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 12:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ0lLk5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfD3MmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:42:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46423 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfD3MmE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 08:42:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id 77so5564148otu.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=StKv2mM8EhI4p50Xov2TxAjIxZQLhaX2UxwxXon7EJs=;
        b=SQ0lLk5ahnXyH+n8ue1qt9LLCvrsEI7t06XOX4wrR8M8FYVdOv/WA6nuQ+rjOFG928
         bMnQabTspw7uZuZbAlwIVrEBvmblztwAw6gG7xcLbo5YzQP9WzUqU8FXrUQ6e8FKOayQ
         0k2utr+l7937nvpfHtYQI06a7uyzPUEwK85C9Gf6WauWXwSgfkaGxQ5zOvXX8zaqEaHP
         l4uS20BWASqfZ+IuJi9CHbNchTZThgVRDyXR9Vz6NjxZmmj1oIqCNerG5kpr0yVEG6dV
         jU5qvhuksrp1iIbLd39cakQkm0Z+fzoBDFk1JLhbJSGDfKmaWytUxFX8P0Ix6SadRbfB
         o3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=StKv2mM8EhI4p50Xov2TxAjIxZQLhaX2UxwxXon7EJs=;
        b=ssQ7mSuNDpxlEsTw4pIA+pGFpLoVKj2TuHZwSUKAutddEVB75SgWnBVHZSe/oTt/iP
         nk0jPpHI0zLJOpANYlMcogBNR7TLivBHCjc3eqwIPKFEE+RS3bvImAYElsoaIOBzXWr5
         C3p0a4ThMfN0RceT0tULfERYWb/IRtHQC9tpfqt6n9C4qb+ubR+/iIFlfxb+QlIYLnD/
         RRI00l8KUXzWfEMAH2eNrcWODf2crqcQRE794SFrZUNcrDUcg7UPW2l7HkF/aC10aqem
         Z+Dz+K1BBWHS5eYTBV+uvVOz4EPIReFKDxdXWofYqUE23CXwsKlcbdbO3bmuoD+xinBX
         Nnwg==
X-Gm-Message-State: APjAAAV+Qjpbi7PXoENS7fMldhvNrtXydQkA6e8pe+066MhC/+N3tZvj
        er3qsntu9zE4BJGwke4GcAXn0jQm/iVzLN34zyzo1kahe8g=
X-Google-Smtp-Source: APXvYqyn+eR3EVjE6OlDOw+zXpgMmRRb+zNrUFNcCABXhwQXeknja5rN1JYkiJm145vM1DnN5nIvPKG77A8fG3Au8tI=
X-Received: by 2002:a9d:6d83:: with SMTP id x3mr1810369otp.84.1556628124080;
 Tue, 30 Apr 2019 05:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190430103001.30661-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190430103001.30661-1-michal.lowas-rzechonek@silvair.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Apr 2019 15:41:51 +0300
Message-ID: <CABBYNZK8RJ4+oiTz2jFKoA7GyRgCBLMjm3FVtQ_=-twEuTLvNg@mail.gmail.com>
Subject: Re: [PATCH v2] a2dp: Fixed warn_unused_result warning
To:     =?UTF-8?Q?Micha=C5=82_Lowas=2DRzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Micha=C5=82,

On Tue, Apr 30, 2019 at 1:31 PM Micha=C5=82 Lowas-Rzechonek
<michal.lowas-rzechonek@silvair.com> wrote:
>
> This used to break builds when using maintainer mode via
> ./bootstrap-configure:
>
> profiles/audio/a2dp.c:1775:2: error: ignoring return value of
>     =E2=80=98asprintf=E2=80=99, declared with attribute warn_unused_resul=
t
>     [-Werror=3Dunused-result]
>   asprintf(&sep->path, "%s/sep%d",
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ---
>  profiles/audio/a2dp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 8f141739c..5f5ad508d 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1772,8 +1772,15 @@ static void register_remote_sep(void *data, void *=
user_data)
>         if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
>                 goto done;
>
> -       asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
> -                                                       avdtp_get_seid(rs=
ep));
> +       if (asprintf(&sep->path, "%s/sep%d",
> +                               device_get_path(chan->device),
> +                               avdtp_get_seid(rsep)) < 0) {
> +               error("Could not allocate path for remote sep %s/sep%d",
> +                               device_get_path(chan->device),
> +                               avdtp_get_seid(rsep));
> +               sep->path =3D NULL;
> +               goto done;
> +       }
>
>         if (g_dbus_register_interface(btd_get_dbus_connection(),
>                                 sep->path, MEDIA_ENDPOINT_INTERFACE,
> --
> 2.19.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
