Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D46C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 00:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F1A61185
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 00:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhEOALC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 20:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhEOALB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 20:11:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F74DC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 17:09:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f9so1161298ybo.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3kZ1+vNrRPCPmoLp2v6S00Lb4r6G2+yE2b74wUvKYE=;
        b=KsXI2vg27YEx03Zch10UZYYTmcGSx4tfxG4+dDYKIhnnQCq+NbZw94rsgJ3wvAYwiX
         sXsJkQ3dxqbCh65+RDj8E07E4CPWlShMWByOmX/14Z/Eue8zZAix7cqapuZNZe5pKBrq
         66sWud2m6d0QaWFyD/IitB6FHBOX+02vAT0qTHSQM4y9RohhvpBYp//Jn498IOZs4spL
         3Zq1qgsxJNf3cL1c14g56e2/pEmGZPg0G1wkfKATIytsJEtg9wubQOK0+vd3t6Gzbq5b
         1uqxjN83x7KE5xXy8QSrHV+pyWsB5NRjP9xxGC8xkl8F7Dq8W3mb6OUuT3nXL2k4z0s8
         ZO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3kZ1+vNrRPCPmoLp2v6S00Lb4r6G2+yE2b74wUvKYE=;
        b=YbyfPQC4+NLxrWKQY1GL92g+hEa47iWY/9EXAyr0cfZlTHxpV7LgeFGQaR2my/ijnR
         +muwO0/lSMCLgdRPcTqjOuJLkHuMYjxGDnpJGl/hy4DB9FJ4EyialELFGNYoSly/ju8Y
         3o6MaiofsqGzcn3F+jbs+jWYm/Ndqw7UpM8d6dD62MO6MZFTam02QTp+l64D9Ol8jIUQ
         Qfk+qQxeZEtFNXKmgYMi0lOTQ72vG5yZxmKh8abYrYv51um7HC8c8IDkzdAlEDU4pfQL
         eu+ADjXk5lm9UvUBouB2ifzuz2T3lQ67nEEIbR5i+RwXVb47Vbpqw5Y0zj1xHRt02leI
         rG8w==
X-Gm-Message-State: AOAM533THhKP49uE4KtpZY0SOGuXGTdv2RGopkJ1OT6iqVJiUJ2vKiv8
        MtUQGppQ8oS6VRDM14nEeh4Bgwt04OdBVF12Rzc=
X-Google-Smtp-Source: ABdhPJzJIBQTMaHlg0vaj+hJ6sXgMTXSWQjPVABFjSj2dHDuLnygaffrL9gLfRFjpR5o7myp7Cf/gigtkYGfhMEUiJE=
X-Received: by 2002:a5b:286:: with SMTP id x6mr69769510ybl.347.1621037387767;
 Fri, 14 May 2021 17:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210514095728.2b7cbef5@ivy-bridge>
In-Reply-To: <20210514095728.2b7cbef5@ivy-bridge>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 May 2021 17:09:37 -0700
Message-ID: <CABBYNZ+rOBwOshPR7hdb9QCqDSgb2oALfKcpY63oa2oBkMFk2Q@mail.gmail.com>
Subject: Re: [Bluez PATCH 0/6] Fix various memory leaks
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

On Fri, May 14, 2021 at 11:50 AM Steve Grubb <sgrubb@redhat.com> wrote:
>
> Hello,
>
> I was checking the code via static analysis and found a number of
> leaks throughout the code. This patch should address most of what
> was discovered.
>
> Steve Grubb (6):
>   Fix leak in mesh
>   Fix leaks in obex
>   Fix leaks in plugin
>   Fix leaks in profiles
>   Fix leaks in src
>   Fix leaks in tools
>
>  mesh/rpl.c                     |  4 +++-
>  obexd/plugins/filesystem.c     |  2 +-
>  obexd/plugins/ftp.c            |  8 ++++++--
>  obexd/plugins/messages-dummy.c |  1 +
>  plugins/hostname.c             |  3 +--
>  profiles/audio/avrcp.c         |  4 +++-
>  src/main.c                     |  1 +
>  src/shared/shell.c             |  1 +
>  tools/mesh-cfgclient.c         |  2 +-
>  tools/mesh-gatt/gatt.c         |  1 +
>  tools/mesh-gatt/node.c         | 12 +++++++++---
>  11 files changed, 28 insertions(+), 11 deletions(-)
>
> --
> 2.31.1

Applied (excluding 2/6), thanks.


-- 
Luiz Augusto von Dentz
