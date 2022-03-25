Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD7FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 19:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiCYTpV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiCYTov (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 15:44:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B03E384A1F
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 12:16:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so6192880otj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5e5pvBCeVeqsUw76FxgekZHP2EUDGb9Nk57JJkFelw=;
        b=FrOk7kmPBiTuda1APnGy4tNh8bkeTElMyJGrftazV5vNDLSfg7flW+bG5udaavBSpN
         QT81AO0sS9DmnlVgdC2/3fPB/pGlawtqD0nebIl5LrEztH1jiIOoJ1ZFhkbNfmNxsT/p
         ihq3lvRbY4edXGVxRLaw6BEdUJEk4WLiNgSAs2sfelhJUa7ynbzJuO4NJgq6Vd6BN+gc
         Anh9DJicm5gFZOoGGagrUxRnms9AEFWNXKtJhlDeB/7WoN+n7968w5r2TRZhL+XzUviX
         dOJS/n79f5dG+OEDAtMKFRwd6MdsX74v8tvgv9d6QbaaMz6sd3nBiJ79zPdeHG8RSZLP
         PINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5e5pvBCeVeqsUw76FxgekZHP2EUDGb9Nk57JJkFelw=;
        b=ztkzprutxymHMVjNoPw1/8rwksF2kjjFt0E1CAxCRZ878jQkkn18ZYrDxQtqBTPwYS
         9CAfFWwE89IgJg54OgXssK409SaAsXQXg2vxUywX3711swcd+K3CTR23IWb4QL0Hm3+N
         R6Zdzrugqz0GRWEuyQPXDN4AYum2Fip6PXgz/HU7mg/SrHIwOA62VwSQNmHpHcLWuLV2
         Cj9DUEk3I7/ztgHaxOnDns3sRxd9TRbrrBoYMTSmSQH9pmGud+uvTp5GZSyLgOOp+An3
         zJLVt3WNcOlUxtWN0ac1wJP+jBWoyB0+51aEOwp74PT0ooX1C9yTA+CajTOqy2jr7mES
         lZKg==
X-Gm-Message-State: AOAM530WU6TfenJXniG/kgXiokthpHbvDXAAO11R+rqu/uXXIY7TmCFr
        x89/U3ve7D9ivwaPV5WwzRKRp7y6vWcU17vxp2MvBrWq
X-Google-Smtp-Source: ABdhPJyPSi42kULjUP2U44DMJgUvDYNjaXWhDf6bDsxVKVBUB+IIEkmZ1wx1ZKqy1pCM6enxmXILhYP/LxFrqPcr9MQ=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr10866994ybn.259.1648233905989; Fri, 25
 Mar 2022 11:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220325071350.26668-1-wangxinpeng@uniontech.com> <c9c39f53-86cb-c4d3-5a6b-15852a765d79@molgen.mpg.de>
In-Reply-To: <c9c39f53-86cb-c4d3-5a6b-15852a765d79@molgen.mpg.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Mar 2022 11:44:55 -0700
Message-ID: <CABBYNZLV0M4-zW4bgHXK7v0YuW33_ifB1SYw4=i9N6Y=r9zwHQ@mail.gmail.com>
Subject: Re: [PATCH v2] obexd: Fix can't receive small files sent by windows
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Xinpeng Wang <wangxinpeng@uniontech.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul, Xinpeng,

On Fri, Mar 25, 2022 at 10:28 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Xinpeng,
>
>
> Am 25.03.22 um 08:13 schrieb xinpeng wang:
> > When obexd receives a file, it parses the filename and other parameters
> > when processing the packet for the first time, store filename in
> > obex_session and emit the dbus signal, The signal will be pending first.
> > then when this file is received, transfer_complete reset obex_session
> > is called.
> >
> > When using a computer with Windows 10 installed to send a file to bluez,
> > obexd will read the data through read_stream; if it is a small file, the
> > data processed for the first time is marked as final, and transfer_complete
> > reset obex_session will be called when the data is processed for the first
> > time. At this point, the dbus signal is still pending, and the dbus method
> > that requests the file path has not been processed. This will cause the upper
> > application to not be able to transfer files from the cache directory to the
> > directory specified by the user.
> >
> > To solve this problem, emit Filename's dbus signal and force it when
> > status=active.

It would be great to have the obexctl output with and without the
change, also does it change anything with respect of bigger files that
are not completed with a single packet?

> > Ways to reproduce the problem:
> > 1. Use the computer with windows 10 installed to send a small file to the
> > computer with ubuntu installed;
> > 2. file size < 10k;
> > 3. After sending, in most cases, the file is located in the ~/.cache/obexd/
> > directory. Normally, the file should be located in the ~/Download directory.
> >
> > To fix this, after applying this commit, it also needs to be modified by
> > the upper-level application. Modified to read Filename from dbus signal if
> > there is Filename in dbus signal. Otherwise, use the dbus method to request
> > Filename.
> >
> > Signed-off-by: xinpeng wang <wangxinpeng@uniontech.com>

We don't use Signed-off-by for userspace.

> > ---
> > v2: Add the steps to reproduce the bug in the submission information.
> >
> >   obexd/src/manager.c | 6 +++++-
> >   obexd/src/obex.c    | 1 +
> >   2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> > index 01741fe62..2c180dc44 100644
> > --- a/obexd/src/manager.c
> > +++ b/obexd/src/manager.c
> > @@ -533,8 +533,12 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
> >   void manager_emit_transfer_started(struct obex_transfer *transfer)
> >   {
> >       transfer->status = TRANSFER_STATUS_ACTIVE;
> > +     if (!transfer->path)
> > +             return;
> >
> > -     manager_emit_transfer_property(transfer, "Status");
> > +     g_dbus_emit_property_changed_full(connection, transfer->path,
> > +                                     TRANSFER_INTERFACE, "Status",
> > +                                     G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
> >   }
> >
> >   static void emit_transfer_completed(struct obex_transfer *transfer,
> > diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> > index 3a68fd66c..c0d9e160a 100644
> > --- a/obexd/src/obex.c
> > +++ b/obexd/src/obex.c
> > @@ -720,6 +720,7 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
> >               manager_emit_transfer_property(os->service_data, "Size");
> >
> >       os->path = g_strdup(filename);
> > +     manager_emit_transfer_property(os->service_data, "Filename");
> >
> >       return 0;
> >   }
>
> Awesome. Thank you.
>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul



-- 
Luiz Augusto von Dentz
