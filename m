Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A3C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9043D2080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iYXB6J/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfD3Jrq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:47:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36111 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfD3Jrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 05:47:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so10367430lfi.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JjRNJLtUSgoC+0R1X+gJCjM1Wi008HGHt7YHZf4XgkA=;
        b=iYXB6J/VoFudtx7g9T6jE+6EwQVtbpu4wq/fGjNpskBPuejplTSfUnWPCEaRsyfBC0
         TSssm+yVCPZgmuEYelwOM2QOvy1lDDVAXqeZmr+lfzhXlqo2csZnNh41Mg4nS2W6/WMF
         esQWu4W9KxLGXvL3nnvoCC1Uuw9dHl4JfwUx4/c+380HW/MSpDScHvW5q9d4YElRjgfQ
         mkIGbXiF6qa5Sm8lRLQha/Ib3+onrM850QdVDHomTo2VW/ouh/ygo/iNzsGywnzcJhqX
         MLOqKBcr3+Ogoy121PZ3H5xSE1aEqHEyPh0vPPkZE492NNNCbF2PYegZ9CT+ZA0KXPY3
         voxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JjRNJLtUSgoC+0R1X+gJCjM1Wi008HGHt7YHZf4XgkA=;
        b=TLXUut9XlkOj7dN9nXQ4c7XNj/zf+GZ2N5VRTP83nnrzHDSYBcc5IhXKTN6pek3eOP
         2NVJIcOoaI1hDg5DWq6CnWI/sA7ODJZxpnaWOlTcsBm9qkF7bAWtign2iKfNsPEQj+2T
         LrD4q8vJVhW+CsryLk4yjismDcWfFHkuCAt6sYWR9gr76i1ORMc7tlEOC78JrR78y3yh
         /9Jf4b4axswjrLFkhE+O85ZycHAg+qgSqTDvMynmJOX3OAFFUX3va9ZEj4MGbrpa/OUh
         ulD6NPAMC9geruS+zxHAatytO0z6uIbsrmDEU3XfHEGygDlYlNy79b7hN10/F+uaThiw
         8MbA==
X-Gm-Message-State: APjAAAXXkg5GcT7/uHdlqtKvt/cqSL/7jZ8moK3kHK2tOM0XbX0ftIdZ
        6pYqb8BZtmtyIEOpz+shsoFDDoFmVE8cZrXHXrQ70w==
X-Google-Smtp-Source: APXvYqyITLnmQJ+7Hzal6w1MfsjxAxO4ZSI9zUpgM5sr4oQ5VDIpVeIJf/bcme89ZmAawfOp6MiY84RDIcltg3zg1Bc=
X-Received: by 2002:ac2:4943:: with SMTP id o3mr4577935lfi.61.1556617663486;
 Tue, 30 Apr 2019 02:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190430094446.26135-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190430094446.26135-1-michal.lowas-rzechonek@silvair.com>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Tue, 30 Apr 2019 12:47:31 +0300
Message-ID: <CACumGO+O22aUhb8J-R5pf=hzG8Two-3KzC62+A9Sfg9D0oY8OA@mail.gmail.com>
Subject: Re: [PATCH] a2dp: Fixed warn_unused_result warning
To:     =?UTF-8?Q?Micha=C5=82_Lowas=2DRzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Micha=C5=82,

On Tue, Apr 30, 2019 at 12:45 PM Micha=C5=82 Lowas-Rzechonek
<michal.lowas-rzechonek@silvair.com> wrote:
>
> This used to break builds when using maintainer mode via
> ./bootstrap-configure

Thanks, could you include the compiler error in the commit message.

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
>
