Return-Path: <SRS0=sa2S=XB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1184C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 08:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD62206A1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 08:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mABUHKQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbfIFINx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:13:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36112 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfIFINx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Sep 2019 04:13:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so4966583oto.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Sep 2019 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucwosGH1h8SReABlboIL+xKWQdhdnQ/qj6M+nidklpc=;
        b=mABUHKQwPydKxQYNRVu7y9XEj2f+AgEs3ALdkiL0E/lA4epvRPj7BZIx7geGgXx307
         hIzJqDR+7Rcv8YRUHLbPT8wDiNyF8DVPD8mdqY6RkHQNblewPGdc3/babs9YeaD+HyGH
         fNp3PgGl5Ey4m0p05nZbcqyajMqdQNlSUrt9N6rA4A7vE6X3pMCOUbfRNGq0V80GGyjR
         P/yXHrVvhRuRZ1T2oSjBAj4mkUacaDA1dTUAdHFoo0mj7nYl79oSWbz2BAgbUamXJRGp
         3lXdI3n1x7+/7qYW48VWyLHBY3uhLMgqSKwmK3v3EX7CINNJY7oYV7lRUNGbKhAg/p2R
         XINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucwosGH1h8SReABlboIL+xKWQdhdnQ/qj6M+nidklpc=;
        b=FU8xg3ZUbqOWEkUhe7+QeqXHRTSEkQEpQdHoYQm6x2qh59zSiA/H1/O+eEhKQryOwx
         aQmZgCb0TsmVXi3xAIFkpoout1XmiyGjQFmnTuJi5f/1mvnN+2VRAgeHu/UkXBIytCNr
         xMG5jIr3WxUSKwW5c+V/Q3qpssxQHpTE29V04Z/ugAFWJ/UYQfmg+yJUvcgAAZRlW72x
         cdeHk0fCYaWp99GkNe06eMB/XfFA3/UBPPbvYzoheBgxZMz0arKUGt7tunGSzOFi+wGG
         Tl/wilLVHrajPl12YgHpnU7yDXnroPpXdnSCCrmQWqKua64IaWoR12euZM3yKVTBanS6
         Ue+A==
X-Gm-Message-State: APjAAAUEbqIRJTXqQPxBHhWltcX2Vd0wgiv5Ezki+wzNdAOU1xMVqkgP
        rRraEbGM3gX49duZyuK7LbHhvE88enQKUE+4W4k=
X-Google-Smtp-Source: APXvYqy0+P7X5X0UEHduWDwDH3DkP0zS4JWX6CjY4siOBOzXhZSEzQ4smJyAyRt5GbBD+ihAeRoHqgm3Ft51+xekSag=
X-Received: by 2002:a9d:58c7:: with SMTP id s7mr6301576oth.11.1567757632206;
 Fri, 06 Sep 2019 01:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190817063452.23273-1-rpigott@berkeley.edu>
In-Reply-To: <20190817063452.23273-1-rpigott@berkeley.edu>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 6 Sep 2019 11:13:39 +0300
Message-ID: <CABBYNZJXrh_DZkdaiD1AnkJ3uH7WyMa7TP9YWy2_Kw6hmqckOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] Add zsh completions for bluetoothctl
To:     Ronan Pigott <rpigott314@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Ronan Pigott <rpigott@berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ronan,

On Sat, Aug 17, 2019 at 9:41 AM Ronan Pigott <rpigott314@gmail.com> wrote:
>
> From: Ronan Pigott <rpigott@berkeley.edu>
>
> V2 of zsh completions for bluetoothctl
>
> bluetoothctl has a nice interactive interface, but some of its functions
> can be accessed quicker non-interactively, straight from the command
> line. I made these zsh completions to facilitate that.
>
> If you are a zsh user, try them out!
>
> Ronan Pigott (4):
>   client/main: add help option for available args
>   shared/shell: add --zsh-complete option
>   completion: add bluetoothctl zsh completions
>   build: install zsh completions
>
>  Makefile.tools               |  5 ++
>  client/main.c                |  8 +++
>  completion/zsh/_bluetoothctl | 98 ++++++++++++++++++++++++++++++++++++
>  configure.ac                 | 12 +++++
>  src/shared/shell.c           | 27 ++++++++++
>  5 files changed, 150 insertions(+)
>  create mode 100644 completion/zsh/_bluetoothctl
>
> --
> 2.22.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
