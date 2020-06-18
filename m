Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EA1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5F92082F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFEpeObP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgFRM72 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbgFRM7Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 08:59:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B91C06174E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 05:59:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so7105756ljv.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kX+2vne+jkdoNchWYpH9zx0FwV8hi+bqEcEygiN+2TA=;
        b=tFEpeObPE1mNxZgKf8okj7+Vwyh38NDr2Wj776osHcph9O6CDutxy7pqeNeEbDREAY
         xkTw4oG4VwNsDXpqW7XrAvSMKWbblw6F3xmUwNjxWz0WJcDF1bFz21vG6jGkPOz8H3ch
         jVWBw8l0tqoxqqFia0XK9XHSoPEs3IK9I8e+V6sHGlGHuOEDJZJHoDeyLLFtauG5DuXi
         /wNGAIJwsxga70fcFPYtgMDrkWh9i4i+OxipbZhnJl0oELy8ZJE71Bgj7AT4y9Fm3NvQ
         fVwwUa27hnmtsU4EoO4phk2v1GDwFedC04XgP4q/kcbBI1fFUzKttdNnG6PpsmOPttpu
         xMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kX+2vne+jkdoNchWYpH9zx0FwV8hi+bqEcEygiN+2TA=;
        b=T5yr00mpv8pwut8XZAgbtm0eJWBfN2kgOGzMdIb2P1hsPkeJcKYF6ES72SY9AlhAuK
         dtEOwhN+sN52nynRDiK40oq9W3QEP92czy5JbbhuikTJaKn/45f8NtF2hOawxSJGbuef
         mI/KC3LlK+UqazNUBBelfyhkHevAFJ+oZBwZ4/fqyTRj+EZFDlcajJmzu3lmyj6uIDsh
         NRk/GPTw2iaZ3sZiN24wDSulqfIffl4O55hdIUmyu/IVpmlIEingf2ImU1et7nBePuXN
         nm1IiG12T+lWbKV9ekUbJfGakl+HVlyVZdPZWFq5bCOtwqCsj8Q5Ppyxw8iG75EvjIWM
         HD3g==
X-Gm-Message-State: AOAM532Pdkqpe21ZD6EZMIzVeAZQAgg16sIOK8dxZVPKToXcgaf5/J+H
        FaYMrq7edyY+dOSJVA7NCHL3+UKeiUmG3OQYLy7Inw==
X-Google-Smtp-Source: ABdhPJxtc6h7AF+1+UK9Sk8j9IijIVlPTM60ApFz+GcIIhEbZWuVEs9saznWHm27BJppVTTC+29CO6ly2L6bCrbYjvo=
X-Received: by 2002:a2e:890d:: with SMTP id d13mr2353198lji.75.1592485162259;
 Thu, 18 Jun 2020 05:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200615145252.259971-1-alainm@chromium.org> <CABBYNZK=-_uN=Z==-vi3rKaAFzEWmKn2c2eXSsMMWJXTQFiJ_g@mail.gmail.com>
In-Reply-To: <CABBYNZK=-_uN=Z==-vi3rKaAFzEWmKn2c2eXSsMMWJXTQFiJ_g@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 18 Jun 2020 08:59:10 -0400
Message-ID: <CALWDO_XVhu3iHO7i-j+6Xjq19ZMBEt8HWc0EY=+in-JUvUj5_A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adding a configurable le autoconnect timeout value
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

thanks Luiz


On Thu, Jun 18, 2020 at 12:43 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Mon, Jun 15, 2020 at 7:57 AM Alain Michaud <alainm@chromium.org> wrote:
> >
> > This patch adds support for a configurable le autoconnect timer.
> >
> > ---
> >
> >  doc/mgmt-api.txt | 1 +
> >  src/adapter.c    | 8 ++++++++
> >  src/hcid.h       | 1 +
> >  src/main.c       | 5 +++++
> >  src/main.conf    | 1 +
> >  5 files changed, 16 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 80c483f8b..ca0d38469 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3278,6 +3278,7 @@ Read Default System Configuration Command
> >                 0x0018  LE Max Connection Interval
> >                 0x0019  LE Connection Latency
> >                 0x001a  LE Connection Supervision Timeout
> > +               0x001b  LE Autoconnect Timeout
> >
> >         This command can be used at any time and will return a list of
> >         supported default parameters as well as their current value.
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 92002673b..9ce351893 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -4423,6 +4423,14 @@ static void load_default_system_params(struct btd_adapter *adapter)
> >                 len += sizeof(params[i].u16);
> >         }
> >
> > +       if (main_opts.default_params.le_autoconnect_timeout) {
> > +               params[i].entry.type = 0x001b;
> > +               params[i].entry.length = sizeof(params[i].u16);
> > +               params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
> > +               ++i;
> > +               len += sizeof(params[i].u16);
> > +       }
> > +
> >         err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> >                         adapter->dev_id, len, params, NULL, NULL, NULL);
> >         if (!err)
> > diff --git a/src/hcid.h b/src/hcid.h
> > index 1b2714b1d..c21ac9980 100644
> > --- a/src/hcid.h
> > +++ b/src/hcid.h
> > @@ -91,6 +91,7 @@ struct main_opts {
> >                 uint16_t        le_max_conn_interval;
> >                 uint16_t        le_conn_latency;
> >                 uint16_t        le_conn_lsto;
> > +               uint16_t        le_autoconnect_timeout;
> >         } default_params;
> >
> >
> > diff --git a/src/main.c b/src/main.c
> > index e51f614b3..77886d58e 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -120,6 +120,7 @@ static const char *controller_options[] = {
> >         "LEMaxConnectionInterval",
> >         "LEConnectionLatency",
> >         "LEConnectionSupervisionTimeout",
> > +       "LEAutoconnecttimeout",
> >         NULL
> >  };
> >
> > @@ -410,6 +411,10 @@ static void parse_controller_config(GKeyFile *config)
> >                   &main_opts.default_params.le_scan_win_connect,
> >                   0x0004,
> >                   0x4000},
> > +               { "LEAutoconnecttimeout",
> > +                 &main_opts.default_params.le_autoconnect_timeout,
> > +                 0x0001,
> > +                 0x4000},
> >         };
> >         uint16_t i;
> >
> > diff --git a/src/main.conf b/src/main.conf
> > index 92d937f0c..6a6f7d4b4 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -141,6 +141,7 @@
> >  #LEMaxConnectionInterval=
> >  #LEConnectionLatency=
> >  #LEConnectionSupervisionTimeout=
> > +#LEAutoconnecttimeout=
> >
> >  [GATT]
> >  # GATT attribute cache.
> > --
> > 2.27.0.290.gba653c62da-goog
> >
> Applied, thanks. Note that it might be better to send the
> documentation changes as a separate patch next time.
>
> --
> Luiz Augusto von Dentz
