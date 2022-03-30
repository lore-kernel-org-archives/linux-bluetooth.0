Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54374C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 20:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351173AbiC3U65 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351162AbiC3U6z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 16:58:55 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4031E3F330
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:57:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2db2add4516so233687207b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Fx25hFD20meOXNUwIGy4GCfNiOmBSL2zXAJi1OjzMw=;
        b=e3Nx/tiIjwe3+Ul8sSlpjuRZRrYg+2iQbEvkPI4w6TuLrORKxaNceVy8eW79TWq50e
         I/vR7QzK9jcH7VnfO1fxn4PZNx4xeH6D9nufit+bFrJ40Y9JDeBYEdu012iJg8C86lER
         kIH98/MvPX8OFWAcqThpMJb2cPIiLHPRO3aFLh0WtTAcsKJSEqb83URbnnvJSzYsFp5/
         V7HVHjREHqL/vQpPMG2Ju9hJUpS9sE+HLjKnLAhutSmhqSMELeF5iZzgiS5XwZyZdf4E
         JMsGSEAF4zI5Wr3ySNE2aw9NdQHdNK5kPcIYhMV1O2eSjai8ClDPkDBX+auSNPVBsCDV
         UYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fx25hFD20meOXNUwIGy4GCfNiOmBSL2zXAJi1OjzMw=;
        b=iWhdw2WRItk1gRc+OV71lWC+QvVr+uCKQYiHphVvKpeJsnMuNLK+2Uk8hWiHWYedXn
         HJpUc1y0ACVcLaayV1hdTQIQdyE4jS+dcT9Z7dtUOFPMPxhHfJxUichIRWCUoHNbyzMU
         DIYtkiBApqjWwZIy6c5yFQ7DTqh+IRUTqndICjza/fwzVPxnDt14zwXtSFJ9ZfObetHn
         lidZhYE3X8JBpRceALtavJJiga28sM0QE+jTkUug3/6JWuVyY/1YF0wO4u/3LVJs3Xoz
         omIKp0X2VlalGz1lKej26w2JmHRKSdL3TK9AUhKetqc6sBC/OBcSVJKocVS7E0QX5XuJ
         4N8Q==
X-Gm-Message-State: AOAM532+GoER9Ka3OYIknn7AlYqoxJ62hqgaqw/stMy5sLqGMitcs+5h
        SwySQHdBGNUzhHwngsipjmVT0DWiPv5z432v+uQMEjpmp2s=
X-Google-Smtp-Source: ABdhPJwekh6cxixnHEdsA2EsDOCsuHydN31uMeo8EgBAzjhxWb3zkEoimBQ+YV/aqASayhf8SpzGhRfydLB24ShlWjs=
X-Received: by 2002:a81:f0c:0:b0:2d6:83ab:7605 with SMTP id
 12-20020a810f0c000000b002d683ab7605mr1852363ywp.150.1648673828378; Wed, 30
 Mar 2022 13:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220329052801.28748-1-wangxinpeng@uniontech.com>
In-Reply-To: <20220329052801.28748-1-wangxinpeng@uniontech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 30 Mar 2022 13:56:57 -0700
Message-ID: <CABBYNZKDdRLEk7NEHoZ_uJV2cUNm9qHuWvaiqDotWpSL=LnLQg@mail.gmail.com>
Subject: Re: [PATCH v4] obexd: Fix can't receive small files sent by windows
To:     xinpeng wang <wangxinpeng@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Mar 28, 2022 at 11:02 PM xinpeng wang <wangxinpeng@uniontech.com> wrote:
>
> When obexd receives a file, it parses the filename and other parameters
> when processing the packet for the first time, store filename in
> obex_session and emit the dbus signal, The signal will be pending first.
> then when this file is received, transfer_complete reset obex_session
> is called.

So if I understand you correctly the problem is that Status does
transit directly to complete and end up swallowing the active state?
That is not necessarily a bug since the file would still be saved.

> When using a computer with Windows 10 installed to send a file to bluez,
> obexd will read the data through read_stream; if it is a small file, the
> data processed for the first time is marked as final, and
> transfer_complete reset obex_session will be called when the data is
> processed for the first time. At this point, the dbus signal is still
> pending, and the dbus method that requests the file path has not been
> processed. This will cause the upper application to not be able to
> transfer files from the cache directory to the directory specified by
> the user.

This doesn't sound right, we have chk_put callback that calls into
manager_request_authorization and that blocks untils the
agent->auth_pending responds, so it sounds like the agent is not
responding in time or windows is using ftp instead of opp? Well ftp
doesn't even use AuthorizePush, I'm also confused about the mention of
a cache directory and user specified directory, there are no such
things there only the root directory option which is used as default
location and AuthorizePush can opt to store in a different location if
necessary, but the transfer doesn't start until the agent reply
AuthorizePush or at least that what the code assumes with:

/* Workaround: process events while agent doesn't reply */
while (agent && agent->auth_pending)
g_main_context_iteration(NULL, TRUE);

> To solve this problem, emit Filename's dbus signal and force it when
> status=active.
>
> Ways to reproduce the problem:
> 1. Use the computer with windows 10 installed to send a small file to
> the computer with ubuntu installed;
> 2. file size < 10k;
> 3. After sending, in most cases, the file is located in the
> ~/.cache/obexd/ directory. Normally, the file should be located in the
> ~/Download directory.

Is ~/.cache/obexd its passed as -r/--root to obexd? Could it be that
the agent doesn't respond for some reason? e.g. the transfer status is
not active?

> To fix this, after applying this commit, it also needs to be modified by
> the upper-level application. Modified to read Filename from dbus signal
> if there is Filename in dbus signal. Otherwise, use the dbus method to
> request Filename.

The method is used to accept the request, so something else is broken
if the file ends up being accepted before the user is able to accept
it, also it is probably a security breach if small files can bypass
the user authorization.

> ---
> v4: fix COMMIT_LOG_LONG_LINE error of checkpatch
>
>  obexd/src/manager.c | 6 +++++-
>  obexd/src/obex.c    | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 01741fe62..2c180dc44 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -533,8 +533,12 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
>  void manager_emit_transfer_started(struct obex_transfer *transfer)
>  {
>         transfer->status = TRANSFER_STATUS_ACTIVE;
> +       if (!transfer->path)
> +               return;
>
> -       manager_emit_transfer_property(transfer, "Status");
> +       g_dbus_emit_property_changed_full(connection, transfer->path,
> +                                       TRANSFER_INTERFACE, "Status",
> +                                       G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
>  }
>
>  static void emit_transfer_completed(struct obex_transfer *transfer,
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index 3a68fd66c..c0d9e160a 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -720,6 +720,7 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
>                 manager_emit_transfer_property(os->service_data, "Size");
>
>         os->path = g_strdup(filename);
> +       manager_emit_transfer_property(os->service_data, "Filename");
>
>         return 0;
>  }
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
