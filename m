Return-Path: <SRS0=7u80=N4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C064FC43610
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4472080F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="sAADNZfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4472080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeKRG7L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:59:11 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33493 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeKRG7L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 01:59:11 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so15729140vsc.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Nov 2018 12:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=botacVcKVdZ8/zPEg1IImV38Y3f8qR1D985emCbZrVM=;
        b=sAADNZfDqHeu4xnZs97YVaFqB03svGKAirhsTApdyhZLayfXyONR4uGQa0p5ZA4+y1
         hXQsJCYNTm7ffJBezCp5DhQSmRXzIZNI1hdh+X/uPldlXoncYswt9UiC8dr3kqyczTpk
         arxIQGCuDlh3XjGgTttgsQiBhI+ctLPvjBBCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=botacVcKVdZ8/zPEg1IImV38Y3f8qR1D985emCbZrVM=;
        b=TK5M9LK7otYElkI3coC3XBe7KadSAor3/q5dC3HjCXXmCcvXMaa9fwYEsxXk7tMxt8
         YqJoj+gJFzbMjL1Asmz1gJsqgpnWw7X2LZVQJIVbN8E3NdraSiKKKTtb1LsgXAqZx9v0
         cgjZKr4ANCth3/J8wV5oM+7jqqsEEP+MG+n04xH5TbrRT14bvCNZXZsF56Mdffr4UhoQ
         SzgGbUGLFFgBbOUsYwUqgD0T3/PFGesT4xuGCPZYbg2m0dQ6LmXyZCnwqKdAZMVdRvoX
         v8TqtbanNF01dTxfdkH+AdMQNoz1X8GZ/mymm+yVYfwKebUyPmlO1AeJwYnFTr3meSK0
         2Qzw==
X-Gm-Message-State: AGRZ1gKXDz22wOAtHDyl7wdHi4CtnCPa5gRmHcu/YH0yPMdJyICfva2i
        8hL2FiY35T0XVF3wyu6ZkRiyEUYHM9/lanmPA7D3kV2v
X-Google-Smtp-Source: AJdET5fwIkDbHZMQomwqGumC7xplMdmw34+wu/UP+YJeGkM3EJFMSXS2obbwj2rXCz6X35EamZLfixmJ7cVr2c5ns7I=
X-Received: by 2002:a67:3144:: with SMTP id x65mr6887895vsx.186.1542487277792;
 Sat, 17 Nov 2018 12:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20181117060024.10390-1-gbenhaim@augury.com>
In-Reply-To: <20181117060024.10390-1-gbenhaim@augury.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Sat, 17 Nov 2018 22:41:06 +0200
Message-ID: <CAHotPr82XDc9tE_76iknhQtbTjEMzXdQa4HpUy7asTZvwjG5ZQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Catch SIGPIPE
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

actually it does not log the broken pipe message, is it because errno
isn't set before the signal handler is done?
what do you think?
On Sat, Nov 17, 2018 at 8:00 AM Gal Ben-Haim <gbenhaim@augury.com> wrote:
>
> bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> was acquired by AcquireNotify and there are no readers. it can be
> reproduced by terminating the reader process without closing the reader
> end of the pipe.
>
> Catching SIGPIPE will cause the write call to return an EPIPE error
> which will be logged as "io_send: Broken pipe".
> ---
>  src/main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/main.c b/src/main.c
> index 4716f5388..54cdb8d3f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -533,6 +533,8 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
>         case SIGUSR2:
>                 __btd_toggle_debug();
>                 break;
> +       case SIGPIPE:
> +               break;
>         }
>
>         return TRUE;
> @@ -549,6 +551,7 @@ static guint setup_signalfd(void)
>         sigaddset(&mask, SIGINT);
>         sigaddset(&mask, SIGTERM);
>         sigaddset(&mask, SIGUSR2);
> +       sigaddset(&mask, SIGPIPE);
>
>         if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
>                 perror("Failed to set signal mask");
> --
> 2.19.1
>
