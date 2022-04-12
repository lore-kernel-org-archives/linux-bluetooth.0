Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5085FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Apr 2022 19:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiDLT4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiDLTzX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Apr 2022 15:55:23 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6769CFA
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 12:48:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ebf3746f87so118528237b3.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRks0/ntxXNc5+ERqFgIMVaFbMGHLMxyKZMpvhFga6k=;
        b=ZeVhGXiqKe9EsuQS6VS/1VVhcFz/IVLGlKC0/LDvQroOBj8KoxPsVuNJ5iLcUFEzlD
         4o3HRXVRv4lVpWB3id4Rik0AYpZXtuk/7TCEvwO4DsvFw96qp0mcT3gwbIffr+4Wc54y
         7DTuG0gpjhS0/tP/yXsqR9yiEbJccmcbAohhS6kWqeeayhtzT5b4X0lovFd04HuUEWXa
         +OEdgQ09hLwVS3ZtVh7S2CMzDIoAMDepyIGnQbZ18p+lcPpZt4Jbo7cvmQvvGg/v4D2f
         HYXOMIJLsFNbxKFhlKKrSQ1FYOtBs5x51x8MaddKjwekHwJtxBu7hdS19m6LB9sCsxAI
         wl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRks0/ntxXNc5+ERqFgIMVaFbMGHLMxyKZMpvhFga6k=;
        b=kreVOICp1h11pVkuyXLKbYbY8fotXeKWghOP42fwmEcqn8BAlrk3O9uPIDwLDr89L4
         9RCogUAOygm4i8Cfb8zaRU4G53GziS0QPqWcDu5p9bi3GCd7MF7UndspZYnuYGDehPhb
         Ovsm/CkCQmofmIChBz4jFc2ROxgCg8E8WfTtNbwxM2YcZYP4xNCTBYWcEMawbRKgnijB
         Fn3L86DYrLIEC7TaRiC39Zpt8Ne97NaKPIbbtq3u/p7e0cI/3xmg5Yv3aJuinFn4U43l
         GVDTE8F+kGn9sZnUu9UopBcUxwIQ+MxdUeaoI+GOFI2QLb5RO75TBvGSFrUH4HFua0bE
         MHlQ==
X-Gm-Message-State: AOAM53005rh42jwuBi5LxWJu+pNyoppG/CYeFbhcnJBiBZoThpuL5mAN
        QN+j1WW7LVjxGKwL/8092WLrxLHtnHCFavlHlG95853vGRQ=
X-Google-Smtp-Source: ABdhPJxn1ZPZ+EUNxrS4tVkfyxXgXiNxHzLSlzYdEBE4HUGdgRoqx69TjWdqpn9ylxGvjS6CAaAvw/w+jrI73IlTT6E=
X-Received: by 2002:a0d:cc83:0:b0:2ec:1f2d:b527 with SMTP id
 o125-20020a0dcc83000000b002ec1f2db527mr10674474ywd.376.1649792910734; Tue, 12
 Apr 2022 12:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220126113638.1706785-1-hadess@hadess.net> <78f77f0268ce1b4818c0a0749d3371b825fa1c92.camel@hadess.net>
 <390473B8-2187-4C84-B319-9D4A8FB6ED0A@holtmann.org> <61d3fea272805d6bfb1a6cf5883404ea7e294e7c.camel@hadess.net>
 <de2e9b1426587214fcb1b28bb3bec265fd8f9044.camel@hadess.net>
In-Reply-To: <de2e9b1426587214fcb1b28bb3bec265fd8f9044.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Apr 2022 12:48:20 -0700
Message-ID: <CABBYNZLDNAzxeLhbNSkT=sW8YFkLQxMZcingqw+GiWvqzuJBog@mail.gmail.com>
Subject: Re: [PATCH 1/4] build: Always define confdir and statedir
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Wed, Feb 2, 2022 at 5:55 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-01-26 at 14:45 +0100, Bastien Nocera wrote:
> > This change specifically? Check the next patches in the series, and
> > you'll see pretty quickly.
> >
> > For the rest of the patchset, check this man page for details on each
> > of the directives:
> > https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Security
> >
> > There's a fair amount of other directives we could use on top of
> > those
> > ones, but we can add them iteratively (and it makes bisecting easier,
> > in case we forget about a particular use case).
>
> Did you have any more questions about this patchset?

Looks like we have some problems with these changes:

https://github.com/bluez/bluez/issues/329

-- 
Luiz Augusto von Dentz
