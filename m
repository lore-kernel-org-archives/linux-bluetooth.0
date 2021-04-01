Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BE2C001B6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A2361286
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhDARqU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbhDARlV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:21 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5288C031177
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 10:08:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n8so2435711oie.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skCt7+CxeB8IWIVaS0koQ6wJu9+jbKTTpOOOGB9f6EE=;
        b=AUXjFNfg5EOIovy8kLRCKnpZLEecxf6sSxDsb0AFTKGYYzcTUqWq1BCfBYsjN4OY0q
         LUTtw5l2WLZI3TclVvYbfnCM5UJr903+wfnrR4Lg1X1WIfRLIqXtx8CFelhACpHdvrgn
         9iITom2yjIflE/38IlR8cq/GQZPR7Xzi/hxIVC6/CERsE4hkGcyASvL9nUs2iBFrd2pS
         Qr/0ezo0Ji2uFyPgwjiqN/XFobe0G1Z5JIJj94cTE4cuN0vppQ7h1yI0vVt/V5beByMx
         aFvGkJRVYZsaQFF96B1ABMoSgLulNAbQ8OtzGid2AUvPpWxffR6+CsMHCPx7lA2EEPmz
         8b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skCt7+CxeB8IWIVaS0koQ6wJu9+jbKTTpOOOGB9f6EE=;
        b=TqoHBPjeTnVKKI7m4XEUVol/khgHmfTM4Lbf2ZkjQGI68nuq7fPaUvVRp1eIH3bPVW
         7wWRx+Mtwo5edL1HcaLB7dmT9ssC+HMAvjK68EYmkFTJC8FqDu7741QPGbPZLsM7zPhM
         M3rVXvemk4CCNQSsAuNLuBmQbDAyVypeL2hFKkTjT2eUxQ3AwWliVXOPYBEyD63kuwhv
         dupNUa97DF4/BPpxpLEmWTCQLX2NSLu96YZ1dn/wAMuuZrGh0+X9c/lECf6UZtnFamkx
         whEbZHF61iHLq3vfNqkfeLzHwLEJn+xqAHsaO0ghkNI9IgG+Pw4rvAKgMl3rrtqHuvxN
         QYyw==
X-Gm-Message-State: AOAM5325/bFAqACr2T5WtG+2Rmnt0QsA1t7JzTWYKN5ZpeI2aN+arqw7
        PbXeX8Q03XaAFfA+xgCgJ7XLnSNPjn8Tga60SUI=
X-Google-Smtp-Source: ABdhPJyDZfd/pwzJBg7d3gdl5ZHjavImuB4OzSB1Nlq7wbQ432L0dXTX9eD02sPXk3DcQSudQq2b9WgSUBGXPzsvevo=
X-Received: by 2002:aca:b645:: with SMTP id g66mr6544073oif.64.1617296909157;
 Thu, 01 Apr 2021 10:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Apr 2021 10:08:18 -0700
Message-ID: <CABBYNZ+6XXN0KLhW+WfFgYjBYjQcWRhWdOfwU_PyB49gHBU_Tg@mail.gmail.com>
Subject: Re: [Bluez PATCH 0/8] Hi Linux-bluetooth,
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Apr 1, 2021 at 3:25 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
>
> This series is to add a new method |SetServiceAllowList| in D-Bus API to
> control what services can be connected by specifying UUID allow list.
> Users can query a device property |IsBlockedByPolicy| to tell if some
> of the services are currently restricted. Since we plan to add more
> methods to limit different bluetooth functionalities, we also introduce
> a new interface for this purpose. This series has been tested via sending
> commands with dbus-send manually on chromebook octopus and eve.
>
> Thanks,
> Howard
>
>
> Howard Chung (7):
>   doc: add description of SetServiceAllowList
>   lib: add hash functions for bt_uuid_t
>   core: add AdminPolicy Interface
>   input/hog: block connection by policy
>   audio: Remove Media1 interface when a2dp source disallowed
>   core: add properties IsBlockedByPolicy and ServiceAllowList
>   core: store ServiceAllowList into settings
>
> Sonny Sasaka (1):
>   core: Initialize uuid_str_arr to NULL
>
>  Makefile.am              |   3 +-
>  doc/admin_policy-api.txt |  34 +++++
>  doc/device-api.txt       |   7 +
>  lib/uuid.c               |  21 +++
>  lib/uuid.h               |   3 +
>  profiles/audio/a2dp.c    |   2 +
>  profiles/audio/avrcp.c   |   3 +
>  profiles/input/hog.c     |  22 +++
>  src/adapter.c            | 148 +++++++++++++++++++-
>  src/adapter.h            |   5 +
>  src/admin_policy.c       | 292 +++++++++++++++++++++++++++++++++++++++
>  src/admin_policy.h       |  23 +++
>  src/device.c             |  79 ++++++++++-
>  src/device.h             |   2 +
>  src/profile.c            |  39 ++++++
>  src/profile.h            |   5 +
>  src/service.c            |  21 +++
>  src/service.h            |   1 +
>  18 files changed, 705 insertions(+), 5 deletions(-)
>  create mode 100644 doc/admin_policy-api.txt
>  create mode 100644 src/admin_policy.c
>  create mode 100644 src/admin_policy.h
>
> --
> 2.31.0.291.g576ba9dcdaf-goog

I think I mentioned to one of you guys before so sorry I will be
repeating myself, we did in the past have control over
blocking/connection on a per service level using a plugin:

https://github.com/Vudentz/BlueZ/commits/service_api
https://github.com/Vudentz/BlueZ/blob/service_api/plugins/service.c

It probably need some rebasing to be applied on top but it already
gives upper layer control over things like auto-connect and blocked
properties, I've didn't add support for persisting the setting on
storage though since this use case was limited to car industry but if
we go into this direction I rather have this plugin instead.

-- 
Luiz Augusto von Dentz
