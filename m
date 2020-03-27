Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402CCC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F3C20774
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 02:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMN3xdc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgC0COs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:14:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55969 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0COs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 22:14:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id z5so9948200wml.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLXsFjAt3oyjjpAK/1V/0bvb/EVhlf8iGpvOucwTKQs=;
        b=vMN3xdc3MPeb7YrAWaigcnQdNCc+9/EIu5L4upY6HYmCKRfmf4RmYgp85MgXGFcBLw
         6HatK2ybGRrJiqMqcAMz/slXSY7z8SEbuG2PF2tjB5hQjBjAD3eRQsVN1ldDaexX0Ydv
         o88BYWOOkjOyLeq9wQJ3WTqwXcDEIb5IpxcDuOkD6wql4sv3DFlKg4ina1CajKnKVXZj
         fx7psS1t86Z+DcwXsR6UNkQW7q+ysZMjFZJ9BQqzNaXyXEAsL78FlZC+n4c7+a9nXnO1
         CwsxVeqxIpEWhNaFjSJVfmlZggrst/y41uYB2b1pA/fgajOnD3ODIL7eyFviYEGB/ezh
         QrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLXsFjAt3oyjjpAK/1V/0bvb/EVhlf8iGpvOucwTKQs=;
        b=FllWga6wmex9pKF4SrGzw8ZbqTsBuj6cjCRaPIn2xHdCiR6A8IyeXVoYLvwzBtONQu
         iHOuOXuPB8PSZQSsYzvaB2iqVD1OhiqdfSmIH45x7VV+O9mJYXgPw2wo3CncSSYyF0NI
         8PcjkgBCpiLUmng3ts54347I5ktQXdTZU6gpAIC96HvpWla5k3+bOQ88KCbLmzWrjPgW
         QYtFKtMXIDmmkmmwPeGmZRXYT6N65zFF3cDLAfKPUbLBnYeaOIWKpVMGc9qxw+a3ZYOE
         51q+j504QdasYdHIZdTsi/X1MhKrHU99qT49MVg9D9kZzSJDuViaxda/0uW5gMEIAOVU
         s6wg==
X-Gm-Message-State: ANhLgQ1PX0tcm8joUH9EE3m32uSXpawIMlQNmrCrpC00qyI6x+dzD9Q3
        JN9znxLXohjhcOcx3hE0ZmNCeES7J6fwaVIPlvuLvWaidUFQbA==
X-Google-Smtp-Source: ADFU+vtavwSN+ak2yaOUMwfoe7cJv3YIrqeORSPDSniyzvWUyIZe14hoPmeBFLhNCngeEpsJouo/doGvxCO2Mm+RBiU=
X-Received: by 2002:a1c:456:: with SMTP id 83mr2949618wme.54.1585275285167;
 Thu, 26 Mar 2020 19:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131356.Bluez.v1.1.Ia3d21e293d18f903fa6e54918856e1dd5ffc904f@changeid>
In-Reply-To: <20200320131356.Bluez.v1.1.Ia3d21e293d18f903fa6e54918856e1dd5ffc904f@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 27 Mar 2020 10:14:33 +0800
Message-ID: <CAJQfnxENfZnXq4e-kaeKF2ByhJ089JXZumWc9ydBJBWGQgTiGw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] avdtp: fix delay report valid states
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[re-sending as plain text]
Hi Bluez Maintainers,

Could you take a look at this proposal?

Thank you!


On Fri, 20 Mar 2020 at 13:14, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to AVDTP specification section 6.19,
> avdtp_delayreport_cmd could also be received when the state of SEP
> is open.
>
> Therefore, updating to accommodate such condition.
> ---
>
>  profiles/audio/avdtp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 0e075f9ff..4b0e63384 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1936,6 +1936,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
>         stream = sep->stream;
>
>         if (sep->state != AVDTP_STATE_CONFIGURED &&
> +                                       sep->state != AVDTP_STATE_OPEN &&
>                                         sep->state != AVDTP_STATE_STREAMING) {
>                 err = AVDTP_BAD_STATE;
>                 goto failed;
> --
> 2.25.1.696.g5e7596f4ac-goog
>
