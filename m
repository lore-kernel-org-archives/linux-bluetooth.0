Return-Path: <SRS0=9bU/=4O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26750C4BA1E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 17:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE03224681
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 17:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwj0gcWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgBZRgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:36:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35887 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgBZRgy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Feb 2020 12:36:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so342935oic.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2020 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b1C47BEOxTbwzNv0yHCTbQuCroA6+Sc1C3CEMriE6K8=;
        b=gwj0gcWCvN2gnKg0UovzVPgdwkjoUiOoXpwwWN9v4hZxCmVHYXrYW/FLBMgw2wFAqT
         rNgDrKOkobfn6/Kp9T/DIONucIWrYUCqczmZgQu8Sa22RmYGNPwkbuNuyeOVq28I7sZw
         JdaV6kaPLeeLyobYjF7G/KOLljOHvFr44NdPCDald+/kSnXEu0irFk+TBuJqnUb8pk0M
         EOOlbDr+PBBAaTeP7i4wu/nOy8rwJ8jQKAL3aqaID2YYbppM3WGkdQh6YuxRY+sE8lul
         a0M+YXVoFtcYHzLBxqhCJ9QlNVbrZ6CtEGVcgcK+DCO3n2RO62DfSY9p1vmIPuGD2oH7
         fCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b1C47BEOxTbwzNv0yHCTbQuCroA6+Sc1C3CEMriE6K8=;
        b=KdUNaacakMLe4Ejrjm7XRTZfWJTmK2ho3fa1yZBRqOyR/KZkQkS6v/5lQ5e0vsUwD6
         vsHPW5y7USg4EDXXrcsLOxYxsUtHfYWFGA9IsCssh/mJd7bZK1+mcjgm4v/nJ3J0gygP
         y2xo/m7h33/U54NH1zUjJxFSeFGQWG42KkdAUqa068c3XdIyKXjad/c9zKEKR28mnxRj
         6/+BlIbEVyJMhZoEmFy29wz7hSwuuSbC9oZPdx6IEKi5smX+9FGaSaoYSTaPKv2mZ9Ew
         bldFnj2OqY9vh0mFO6QOamPE3dX/ZD5FGZR7bSjO7vlE2J8J/mFvXZWcK6e+VaOpaUyK
         aqZg==
X-Gm-Message-State: APjAAAXGEwsOMRvirmkrXJ6PPg1TY9DIhTZqLjEHl7YH8KdOgS2TuwCD
        8qJDkV1TthG/fuNd3giEknJ9wU5U5FzKXwIRf2LtEfCv
X-Google-Smtp-Source: APXvYqxZ/qu0QQvPkNxnPU8Zsqw7RI46R0NshTHY7R7FnGxC9iwllrnjlrTao2cWluUbesY1FzVqcTt7csN81FnZeTg=
X-Received: by 2002:aca:ab51:: with SMTP id u78mr81566oie.21.1582738611681;
 Wed, 26 Feb 2020 09:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20200220002835.8929-1-luiz.dentz@gmail.com>
In-Reply-To: <20200220002835.8929-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 26 Feb 2020 09:36:40 -0800
Message-ID: <CABBYNZLKV7suLo_LfH9GisiEfKmTPrds6nSPHc85WHr97Cz9yA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] doc/adapter-api: Add pattern filter
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Feb 19, 2020 at 4:28 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a pattern filter which can be used to filter devices by
> address or name prefix which is quite convenient on a crowded
> environment.
> ---
>  doc/adapter-api.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 2afd61bc3..acae032d9 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -119,6 +119,21 @@ Methods            void StartDiscovery()
>                                 if the adapter is already discoverable setting
>                                 this filter won't do anything.
>
> +                       string Pattern (Default: none)
> +
> +                               Discover devices where the pattern matches
> +                               either the prefix of the address or
> +                               device name which is convenient way to limited
> +                               the number of device objects created during a
> +                               discovery.
> +
> +                               When set disregards device discoverable flags.
> +
> +                               Note: The pattern matching is ignored if there
> +                               are other client that don't set any pattern as
> +                               it work as a logical OR, also setting empty
> +                               string "" pattern will match any device found.
> +
>                         When discovery filter is set, Device objects will be
>                         created as new devices with matching criteria are
>                         discovered regardless of they are connectable or
> --
> 2.21.1

Applied.

-- 
Luiz Augusto von Dentz
