Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA02C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6FF2087E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DkIvImZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUSZc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:25:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35711 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSZc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 13:25:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so3874639lja.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wcpe7PcQQp882B3UVOoufxI0c2k9kgxMpzr5GufZDCE=;
        b=DkIvImZ1BVrCq0pw9UvpF8Z2i68PGhdm6+c1ne6lhq4i4wHho7TlFGkJjtViMF47Wb
         rdOKM8xmVMwQA1jML3fKVAdPRbLcsqQwFFWC9VFJv8MlpMvTDmpqRgsI8T9LZoZvc49w
         jIb9bt9iDZrwJSshBq9SSkgd+W5AaCi2uELNg6jWUGWLzNWUL8Eifc2/IPLsPGUQhwDQ
         N+RG9JOo6kdaXlxBNZActuBg9+FXMqE5WDeIuuuXCgvVD/FcoUwpT6AIJQ2Z4QxBI291
         /wiEEkjnHRNO/Jv24tTOSNJekC8VkWMgHuyL0L49xYyizvEmO56CB0MCJrsYjNwSL4PM
         mQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wcpe7PcQQp882B3UVOoufxI0c2k9kgxMpzr5GufZDCE=;
        b=dhAUTUGxmWAOxDPnIjOEfnQgPBN67c3jqOzszSrodk384I4kaQXHaS0iCCbAgp1ZJt
         6Ps0dGAdYrldrW9NiGovqjCUfuOzm/y0k2C3KMWdJON6vBGpQzzwEExPFjfdNMECqFL/
         UKV1b4RGjQ+EdpxzeUZM1VI6tts5guxWGRpiMzcXj13NVwmXvD1YwYX6EWXSGEe31YXj
         4ofDmAIHOA0AK97IND1ZMjGPB53xNMtsJkQm0TpwcywYsJFwQM1JKWWsoSrMgbmyrhcj
         x1DWl8OJUR4gK7ehPLZ4Qe5giyg2ltVpCJlC5FVWcEsQhhsqXNhwgHCZqLCH06ooI/Ab
         tXdA==
X-Gm-Message-State: APjAAAWq3blb8fvzj9aXcJ5a7s4aB+SWXIX5tb+mZz3aQIuTXRwanvVL
        fChEproeDKrecD34Ycjpro5i6xyeZW+V0Rv2xORkHc9sp3Q=
X-Google-Smtp-Source: APXvYqx/A4hJKkV0MJ6J6ypolPedUpzNSvl8UJLXih1pP5A17DUHH7YkvXjcCgV3vr8u2NbEELI94cRIV1TkWHzFddA=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18mr14846191ljj.272.1579631130076;
 Tue, 21 Jan 2020 10:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20200120202708.111383-1-alainm@chromium.org> <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
In-Reply-To: <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 21 Jan 2020 13:25:18 -0500
Message-ID: <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I'm not familiar with the dynamic_debug feature.

On ChromiumOS, the interface proposed here is used by the user
feedback system to allow the collection of BT_DBG output when the user
is trying to send us feedback.  If there is a better way to do this,
we can certainly use that. but may need to be pointed in the right
direction.

Thanks,
Alain


On Tue, Jan 21, 2020 at 11:20 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This command is used to by higher level applications to dynamically
> > control the debug logging level of the kernel module.  This is
> > particularly useful to collect debug information from customers filing
> > feedback reports for issues that are difficult to reproduce outside of a
> > customer's particular environement.
> >
> > ---
> >
> > doc/mgmt-api.txt | 25 +++++++++++++++++++++++++
> > 1 file changed, 25 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 1e59acc54..f2dba64d1 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3047,6 +3047,31 @@ Load Blocked Keys Command
> >       Possible errors:        Invalid Parameters
> >                               Invalid Index
> >
> > +Set Kernel Debug Logging Level Command
> > +=======================
> > +
> > +     Command Code:           0x0047
> > +     Controller Index: <controller id>
> > +     Command Parameters : Debug_Logging_Level (1 octet)
> > +
> > +     This command is used to set the kernel debug logging level. This
> > +     can be by higher level applications to facilitate dynamically
> > +     controlling     the logging level produced by the Bluez kernel module.
> > +
> > +     Supported Debug_Logging_Level values:
> > +             0 : No Logging
> > +             1 : All debug information.
> > +             All other values are reserved for future use.
> > +
> > +     When the kernel receives a value higher than the maximum supported
> > +     value, the kernel module shall set it's logging level to the highest
> > +     value it supports.
> > +
> > +     This command generates a Command Complete event on success or
> > +     a Command Status event on failure.
> > +
> > +     Possible errors:        Invalid Parameters
> > +                             Invalid Index
>
> I need a bit more explanation on how this is suppose to work and why the current dynamic_debug feature is not enough.
>
> Regards
>
> Marcel
>
