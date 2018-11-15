Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2FC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A773E20854
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlBo7OSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A773E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeKOUT6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:19:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46921 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOUT6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 15:19:58 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so16823146otm.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDU4kkeOfHbhis6iNk9BLaB5ti9SRBs2YmEbeibS1Do=;
        b=dlBo7OSFvzh0Nb88VmH1dT0oggNCY7kY6rYVRQTFI92Rlstdmed4lq2NHWlbCXotxq
         ghyoliDOZitZdkSvOugufo/+CPpHqgeXTCc4RrDssVjSY4FbEYJMhFVjCrKF/9EANlu1
         YkiC1ZDKPC209gr40tYpm8WijzgHjfhR65GGxKdVte05hAvIQ0kmYH2f4eTWN9As/Qaw
         Z60XVLOnignJPfzM5/oTvoSHws3fAz/DGhiMI+nAy9k0pMrwdOd0hgn+9nPdPyqfKXC1
         DNgE5d/5xBp44qOmC/Zegbdg3RoQa5D/2XcpwN+l3acTUmuGQMwqwreU5bYPDOQe7Gsh
         x3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDU4kkeOfHbhis6iNk9BLaB5ti9SRBs2YmEbeibS1Do=;
        b=X6giekiks+QBH9O0eEaNgYGXI3IzvJGrWUvGtzylb0fFTT9dMZmA53auuWssyCNbPt
         kIUjiOgwSQOk9UHMki1uOxyJsg87363kPQP/9/7M/8ww+zXpWQCKwEtByd1dE7FgAHR2
         qMlvglptx3BUZW0iUd6zu7mUMPY+SYVrWv9mL6SN5u/M6GnBLwTevQ/yeieVbF+FRXOw
         N7IAPi6A/FVJ2ykkBTFuHYRTiwruuhcMp1xCPJc8ON2ePV6HuexXTSQnWmL+d1+HRENK
         0FFqztPtKoUXAanqtqrL1hdX5zzLxYtkBEfe2cu+vC0iFoWfWCRSyISyqISQnIGGRLC9
         2kNA==
X-Gm-Message-State: AGRZ1gI2LZtSWQ/UEkwDo136UhP9ifXt71d2Vx6rzyI8ceAOcXXeX8kj
        zO7K4Kpw56sl6+QQDdoQ6MRUNVS8bqhBzC4i9jrXmw==
X-Google-Smtp-Source: AJdET5eChZof6+4jntdVKMRB7Sn9dOuoRwJEsnpdHRSyzYB5dExEkgnPfCqJkI/LbwC+f3RO8ex/7VAEitZdbdPxwPE=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr3493058otl.342.1542276766666;
 Thu, 15 Nov 2018 02:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20181115083817.20986-1-gbenhaim@augury.com>
In-Reply-To: <20181115083817.20986-1-gbenhaim@augury.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Nov 2018 12:12:33 +0200
Message-ID: <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
To:     gbenhaim@augury.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Thu, Nov 15, 2018 at 10:41 AM Gal <gbenhaim@augury.com> wrote:
>
> bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> was acquired by AcquireNotify and there are no readers. it can be
> reproduced by terminating the reader process without closing the reader
> end of the pipe.
>
> Ignoring the SIGPIPE will cause the write operation to return a
> "io_send: Broken pipe" error which will be logged.
> ---
>  src/gatt-client.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 234f46ed7..236f38ad5 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1137,6 +1137,9 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
>         if (pipe2(pipefd, O_DIRECT | O_NONBLOCK | O_CLOEXEC) < 0)
>                 return btd_error_failed(msg, strerror(errno));
>
> +       /* Ignore SIGPIPE, a broken pipe error will be returned if the pipe has no readers */
> +       signal(SIGPIPE, SIG_IGN);
> +
>         dir = dbus_message_has_member(msg, "AcquireWrite");
>
>         io = io_new(pipefd[!dir]);
> --
> 2.19.1

I wonder if there is a way to detect that on bluetoothd actually, that
way even if the client don't set it properly it would not make
bluetoothd to exit.


-- 
Luiz Augusto von Dentz
