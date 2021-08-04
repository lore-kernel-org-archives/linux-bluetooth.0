Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC63C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 22:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1894D61073
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 22:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhHDWHR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhHDWF3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 18:05:29 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA9C061799
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 15:05:15 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id k65so5908299yba.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvdAuZMwvx4/bGaUn0WGVJBHpvTUpDRyXvINUKXbHnM=;
        b=gGPLcGDcEFqZ/M3c4vfYEgMSnk/8w8qCTOfQPRvqwTPgjZ518gcf9X3WyPu2PUybXp
         V3Rvp5tRNEz0EhoIiQhP1+/CYT3P3yAPKKbZXaa8qh1ZruCs56UlHfhTeNkYVUzJSaUn
         CJjvrxuJ//csd3BXjIJRolf8O44A0hCGjfTTbnTejlngrQ9rzCYCH1K06fj7VR6IEZQJ
         QjuQaqJOpTp51uZ2uwJwLmEYUY+WCojZyViHgKC12b2SVj/zL3cQTqa44HstBuUC2TUO
         Zfb3R3zTm9dwtMd4oo37gcwa/O28tCtNgN5JR/GY7u5DwPMZH9dHKEpDDusVT7JZQmqi
         Uk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvdAuZMwvx4/bGaUn0WGVJBHpvTUpDRyXvINUKXbHnM=;
        b=iaJB/S1Q0WsxQSIsSfqeyzsVIaWhprLFYnBXpfS6L/nST6Fraqy77XC0SITMXVLq/W
         aokbObL8Hs8RqicYuRxSPq9FZUScmdAPIsMLmKPPwCIrN+sMcElSbVT5qXvzcdWFZ9sL
         9meSc/h/J9i+c9+Hp4UAfLZVdvvHKSEv1thMPpux8xwaV9i727oFC9GW3wV5bW29Z8en
         XOZt43VyW/7t8pPoGWph4eGKgqqt2A8KDlfzzfLQ2RzVCtNWw6I1OcRu05s4UVK7Pb83
         yDXvtMprAJWqzaR8TVDEAJZWTVUtlHGKI4DYMYXnHBeLkO1w7uZkOZTIqL8yKDXod3Ug
         zYcw==
X-Gm-Message-State: AOAM532Mz/Bky6mCZG1UcX/xpyDWyrbF3v+NXlp/oNMicT/UXTE/3UN1
        20NN0ka60BLlMDfG6u/XDXjnIARe+SB2oJ5etG4=
X-Google-Smtp-Source: ABdhPJziYB6rprlB5jMAN272UBoExmdb9hhB1K3o/b9bqFefA2tyIrZBJG5tJnCoeYdFat3m3Ag5EOWr7ctknuqgSMM=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr2112504ybu.282.1628114714832;
 Wed, 04 Aug 2021 15:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Aug 2021 15:05:03 -0700
Message-ID: <CABBYNZL9eY0ux92AMLZosUXa1p9t8d62WqLoTnrkxNg4Vq=3Ew@mail.gmail.com>
Subject: Re: [Bluez PATCH v9 00/13] Admin policy series
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, Aug 3, 2021 at 4:43 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
>
> Hi manintainers,
>
> This series is to
> 1. Implement a few methods in core so that a plugin can have control of
>    allowing / disallowing certain service connections.
> 2. Implement the AdminPolicy plugin. The plugin provides interfaces
>    AdminPolicySet and AdminPolicyStatus. For each policy, users should
>    set the value thorugh AdminPolicySet and query the current setting
>    through AdminPolicyStatus. We separeted these two interfaces so that
>    developers can assign different groups of users to these interfaces.
>    Currently the only policy is ServiceAllowList, which make bluez only
>    allow a list of service by specified their UUIDs, but the plugin is
>    also expected to provide more controls over other bluez behaviors.
> Since the second part is a plugin, it might not be necessary to land in
> upstream tree.
>
> Thanks.
>
> Changes in v9:
> - Fix gitlint error in patch 'core: add device callbacks to adapter
>   driver'
>
> Changes in v8:
> - Remove changes in profiles/health/
>
> Changes in v7:
> - Fix compiler errors in profiles/hdp.c
>
> Changes in v6:
> - include <errno.h> instead of <error.h> in plugins/admin.c
>
> Changes in v5:
> - Fix compiler errors in plugins/admin.c
>
> Changes in v4:
> - Update commit message (admin_policy -> admin)
> - remove old plugins/admin_policy.c
>
> Changes in v3:
> - Rename plugins/admin_policy.c -> plugins/admin.c
> - Use device_added callback in btd_adapter_driver instead of listen for
>   dbus
> - Add authorization method in profiles/health/mcap.c and block incoming
>   connections in adapter authorization function.
>
> Changes in v2:
> - Move bt_uuid_hash and bt_uuid_equal functions to adapter.c.
> - Modify the criteria to say a device is `Affected` from any-of-uuid
>   to any-of-auto-connect-profile.
> - Remove the code to remove/reprobe disallowed/allowed profiles,
>   instead, check if the service is allowed in bt_io_accept connect_cb.
> - Fix a typo in emit_property_change in
>   plugin/admin_policy.c:set_service_allowlist
> - Instead of using device_state_cb, utilize D-BUS client to watch device
>   added/removed.
> - Add a document in doc/
>
> Yun-Hao Chung (13):
>   core: add is_allowed property in btd_service
>   core: add device callbacks to adapter driver
>   core: add adapter and device allowed_uuid functions
>   core: block not allowed UUID connect in auth
>   plugins: new plugin
>   plugins/admin: add admin_policy adapter driver
>   plugins/admin: add ServiceAllowList method
>   plugins/admin: add ServiceAllowList property
>   plugins/admin: add device callbacks
>   plugins/admin: add AffectedByPolicy property
>   plugins/admin: persist policy settings
>   doc: add description of admin policy
>   doc: add admin policy file storage description
>
>  Makefile.plugins         |   5 +
>  bootstrap-configure      |   1 +
>  configure.ac             |   4 +
>  doc/admin-policy-api.txt |  65 +++++
>  doc/settings-storage.txt |  20 ++
>  plugins/admin.c          | 590 +++++++++++++++++++++++++++++++++++++++
>  src/adapter.c            | 169 ++++++++++-
>  src/adapter.h            |  22 +-
>  src/device.c             |  65 ++++-
>  src/device.h             |   2 +
>  src/profile.c            |  11 +
>  src/service.c            |  33 +++
>  src/service.h            |   2 +
>  13 files changed, 980 insertions(+), 9 deletions(-)
>  create mode 100644 doc/admin-policy-api.txt
>  create mode 100644 plugins/admin.c
>
> --
> 2.32.0.554.ge1b32706d8-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
