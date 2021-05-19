Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B64C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350E761244
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhESSLU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhESSLU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:11:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28980C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:09:59 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w1so7972259ybt.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5DosGjcWl2sSk8kTRSGDWlnAMyHCEEYRXKHA7IOuwA=;
        b=UTn97xd6DQitKGq1EZPUrlJ6qBRq7BwZinoqHRrlF8BM2B7Di0dddtSkKm4gwZ7x3/
         /aXsD5bnU2Vdwz05XK49YFmW90hAx1sxd1J3PlZ4cxIZm/RR4S7fvvIbiA9M3I3tUx+Z
         EubiceUWAoNDdK4P+CvuqBQIoxb25ysNXnukhYB8Boito3dyxR164VQGwGzY/jSFv9xS
         EM0cDWrhjHamu2w/PL6EUX7mdu3pf0OtVIQ6plqUP1Dbw7gE5SLUIe6g3FWy4/mjqwWZ
         3rOCx7mUxSXDloWRjD+7tFAj0cx1EGdXHItzX/tslEiBduB51eErFt40onR+dpF7NcEF
         xpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5DosGjcWl2sSk8kTRSGDWlnAMyHCEEYRXKHA7IOuwA=;
        b=NccoB2nbee0FTjwCppsfh5tZHKUD8s2D8l/GaZ2/QZe5GXKxBksvINCNMV+/ibUAni
         qoC0vBfpsm8FR1fA3P35Z/zixVRChhHdMLTBiVMuf7PxhPtkK8Ahe0H8TYDBO8T7R1Gh
         N1gZ5EaDyypoao7OlcUtwcD7CS68BGUEzWyd+accjcGYBur8nMgb+7h9f648msBRFeOU
         CauWe6OePco4FKh0lN7hbM5bcxIhqYZ7TrUUyuUqlE58pepMIWY6DPCAupUmB6li9mQD
         R1v+xBTMpyu/0GbTrYtQMMuSMrhoIHB+LqbZsDKZYmSIp25YNC32SXQosk4VqkLa/sYH
         HEwA==
X-Gm-Message-State: AOAM533oDE46EyYyT5cH2AQxIoKI1gi2SDAPmI3ZWzEZu9/ANTAhUDXv
        m8TZBEfjDtoI2qJBctVVUyx8+Yzsd4hfFiMlnRw=
X-Google-Smtp-Source: ABdhPJwRjjr18Hth33EqmJEs0v+75iUbmKmHjVuwpsHdKbUBI+G6zqVgPC2qFY0uX3d/BzlE1QU/RgLZLpc7kbtZTGE=
X-Received: by 2002:a25:a466:: with SMTP id f93mr1139218ybi.264.1621447798325;
 Wed, 19 May 2021 11:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210515094307.16fb1572@ivy-bridge>
In-Reply-To: <20210515094307.16fb1572@ivy-bridge>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 May 2021 11:09:47 -0700
Message-ID: <CABBYNZJwxH8qK6d2qNG8aicCTiqKMKPNGi5zWYZ-zxqHFxuH8w@mail.gmail.com>
Subject: Re: [Bluez PATCH ] Fix memory leaks in obex
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

On Sat, May 15, 2021 at 7:16 PM Steve Grubb <sgrubb@redhat.com> wrote:
>
> This patch fixes a couple memory leaks.
>
> In filesystem, g_file_get_contents allocates fresh memory to buf.
> It needs to be freed after conversion to a GString object.
>
> Destination was missed on an error path as is mld.
>
> ---
>  obexd/plugins/filesystem.c     | 2 +-
>  obexd/plugins/ftp.c            | 8 ++++++--
>  obexd/plugins/messages-dummy.c | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> index 09bff8ad0..44e3cf3d2 100644
> --- a/obexd/plugins/filesystem.c
> +++ b/obexd/plugins/filesystem.c@@ -416,6 +416,7 @@ static void *capability_open(const char *name, int oflag, mode_t mode,
>                 }
>
>                 object->buffer = g_string_new(buf);
> +               g_free(buf);
>
>                 if (size)
>                         *size = object->buffer->len;
> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
> index 259bfcae2..4b04bab06 100644
> --- a/obexd/plugins/ftp.c
> +++ b/obexd/plugins/ftp.c
> @@ -386,8 +386,10 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
>         ret = verify_path(destdir);
>         g_free(destdir);
>
> -       if (ret < 0)
> +       if (ret < 0) {
> +               g_free(destination);
>                 return ret;
> +       }
>
>         source = g_build_filename(ftp->folder, name, NULL);
>
> @@ -424,8 +426,10 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
>         ret = verify_path(destdir);
>         g_free(destdir);
>
> -       if (ret < 0)
> +       if (ret < 0) {
> +               g_free(destination);
>                 return ret;
> +       }
>
>         source = g_build_filename(ftp->folder, name, NULL);
>
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
> index 34199fa05..e37b52df6 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -488,6 +488,7 @@ int messages_get_messages_listing(void *session, const char *name,
>                         int err = -errno;
>                         DBG("fopen(): %d, %s", -err, strerror(-err));
>                         g_free(path);
> +                       g_free(mld);
>                         return -EBADR;
>                 }
>         }
> --
> 2.31.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
