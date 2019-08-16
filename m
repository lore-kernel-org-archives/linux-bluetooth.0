Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D153C3A59C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514012133F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 11:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJHVFFfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfHPL31 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:29:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36276 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfHPL31 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 07:29:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id k18so9352406otr.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 04:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hf4B+TCFn0aLwKFeXZ7c6BbNprRPxYGB7ZudZlmir6M=;
        b=TJHVFFfqcI2vFNJAkLZNxezpyCyxSn+geuiOeKHAQkvKKRXfhnYu88gQb6hfPsTKKk
         iwMfZJG3Ko0i5fRJytjqHsCc3BSda6M3nx6Myy/0xt1lAYs/PCxMZFeAVixML8pByd4f
         VFSUp+MmpdGBgm24B8Y98UjctdvgQvorSQ21oqIonNN26YIhdLk8IRILCqyloYN6dqbR
         In1m/7s6vu4o5SVkWZ+TFHQz7rZa/QUxdY+dzgj6i2bk17CsOCa7UT3LErlvmeLLfkx4
         +qrSFvzg1tS1boLSRvfEbEzp4KQE3jtor2R+nJR1HqH3zY/HBh+F3e9MzNxPRpMYgKVn
         YgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hf4B+TCFn0aLwKFeXZ7c6BbNprRPxYGB7ZudZlmir6M=;
        b=t0ORgP9loG1dNCgRzbYfbzVXS3NvTY/FInFOKXiWOj1fh4EmSQPjpAMhm6IUlj8aXd
         pZ7jVsidpWi5JTX2HkgotSnNrh7Tk92IDt4EHlmi459f/roW8RbliINvkU000/kB8j3J
         d/0MU8JYY3TtihlcPp8kDDAIOiHmPYCS3Li6JebZlmmpcxXPqMEanLZ87eudiDr1Y998
         J9dsW1hu6kFds/f0BfR6nZAdsAodWrgGs3ts+tKIriNjd9eXK6z7Fa2fG4GcxxjrtsTr
         UEkyOH0ykGgiizkduxRsIXCJjF2fBHnBSdA/BsYf4BAPAfbMXSCZWX+D0/07QBqi3ziP
         4DdQ==
X-Gm-Message-State: APjAAAWgxPPrIfIRRUKL2RvuK9jtkM4+jXGgr1DcnSZsR33e7bNaEyqt
        Sq65udm+yhY7JtJpJ4TcJCkv8Xv4cwidYteCrDg=
X-Google-Smtp-Source: APXvYqyhrE+O1maZTTp36/ahlaDyrXfhNGE/e5HNr07aQlYAsg/BKMN8McdxUmmfHjEIbHOp1iI+PAlrq9CwB6ocfpE=
X-Received: by 2002:a05:6830:1699:: with SMTP id k25mr7380560otr.11.1565954966380;
 Fri, 16 Aug 2019 04:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190816074333.24673-1-rpigott@berkeley.edu> <20190816074333.24673-2-rpigott@berkeley.edu>
In-Reply-To: <20190816074333.24673-2-rpigott@berkeley.edu>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 16 Aug 2019 14:29:13 +0300
Message-ID: <CABBYNZL-Pbwg=DUW5a0Q+Xo7R7KeCMx4KkPHQ5LEaUZttze_2g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] client/main: add help option for available args
To:     Ronan Pigott <rpigott314@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Ronan Pigott <rpigott@berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ronan,

On Fri, Aug 16, 2019 at 10:46 AM Ronan Pigott <rpigott314@gmail.com> wrote:
>
> From: Ronan Pigott <rpigott@berkeley.edu>

Can you a description of what the changes does, perhaps a sample when
uses in some command.

> ---
>  client/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 578b3c7c3..0f810901a 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -800,6 +800,14 @@ static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
>  {
>         const char **opt;
>
> +       if (!strcmp(argv[1], "help")) {
> +               for (opt = arg_table; opt && *opt; opt++) {
> +                       bt_shell_printf("%s\n", *opt);
> +               }
> +               bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +               return FALSE;
> +       }
> +
>         if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes")) {
>                 *value = TRUE;
>                 if (option)
> --
> 2.22.1
>


-- 
Luiz Augusto von Dentz
