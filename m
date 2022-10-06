Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625E9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 20:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiJFUlk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiJFUle (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 16:41:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F11C4C0F
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 13:41:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a12so3548680ljr.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Oct 2022 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=A29y1b5mk/Gw4hN+fqsopS/gdOmLKIKcwPixtEr5VAo=;
        b=gniO07Pkb/txUf4HpVo0+pct2YdD5aKTguHjjxWMMn9MshPYLvmbfNqK4+AWADUzde
         NNzgphYahRlluXU66YTzSAbitHoc0j4kZvTvMZ1cCqUPHHBt99dFa6Pqp62K21L27TNX
         Ak3YCLwLKQeqIS32pZrjJNC8dNXchrS5xJnxU62HCmXe3e4e5NYY++rWCEhANBgwSFHp
         LoKSpaLPk6PIY3G3zq98NKzyPgzQf+DLKKFxcAOjIN8ykcmk5x0Hhrd4fFrH9XS09msl
         7juzKlq7sjoZtzlkWNPSXdyVxwF6468/h6QsRkwf/wGzeZh9vHjTBML3VpjnXgWnPId9
         1tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A29y1b5mk/Gw4hN+fqsopS/gdOmLKIKcwPixtEr5VAo=;
        b=hcssIxmPPBZ4++Tsoiwc9tw8+lCUYikA2VnbpoSWQj6mi2S8KmO77PlJ3r6esR7eJ0
         RiJs07cfB6ZSbhTy+++hryOrpKN+QhTOF/CgeppJDKy4PYDK26L7rCxWn/VavQtwPlxH
         11ytIAOTXfk1i2X9qGQ66s2DiPU964A8ymneHMaqdvxQXBtI35fX1pklVj7OW9jz8BNG
         fPAz+w++cQE45VSBxi0nrpVIhYPcZ+WLTy7PXDn3Wm+yaX6rbnYIZJ9hZeGUSHfJzRX0
         eFX0oPgKTrydRCQ+M1s3sfO9Z6H2DBsFRY+V9wi8cBfR/6kL/qwQgAlZ4XLFhxhMh0wF
         b10w==
X-Gm-Message-State: ACrzQf1f/aFATCnb302bkMIt3d7mWq9zATSn+kGI+pzBq/r2QmkuQkmy
        dQu2LFFeZpSGo7LZHMONvvqnOdr9sjStYqt7QcnwO4wq
X-Google-Smtp-Source: AMsMyM5QcqahnO53Ru2JZuNUHSVNAayHsM/xjbrfPz5c0uAKPXjNFjhgoR9JCqPq+TYmrZHx9yrFmE0iPDCS/668o6o=
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id
 m4-20020a2ea884000000b0025dd8a2d18cmr488304ljq.305.1665088859690; Thu, 06 Oct
 2022 13:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221006143343.199055-1-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221006143343.199055-1-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 6 Oct 2022 13:40:48 -0700
Message-ID: <CABBYNZ+5RsGKrMDF8OHX==UxyeAx4vqazkdssxcBqgvUEqBARA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Media Control Profile Client
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Thu, Oct 6, 2022 at 7:39 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> This series of patches adds support for Media Control Profile for LE Audio.
> These patches primarily foces on Media Control Client Role.
>
> Abhay Maheta (4):
>   lib/uuid: Add GMCS UUIDs
>   shared/mcp: Add initial code for handling MCP
>   profiles: Add initial code for mcp plugin
>   monitor/att: Add decoding support for GMCS
>
>  Makefile.am          |    1 +
>  Makefile.plugins     |    5 +
>  configure.ac         |    4 +
>  lib/uuid.h           |   15 +
>  monitor/att.c        |  511 +++++++++++++++
>  profiles/audio/mcp.c |  429 +++++++++++++
>  src/shared/mcp.c     | 1408 ++++++++++++++++++++++++++++++++++++++++++
>  src/shared/mcp.h     |   60 ++
>  src/shared/mcs.h     |   65 ++
>  9 files changed, 2498 insertions(+)
>  create mode 100644 profiles/audio/mcp.c
>  create mode 100644 src/shared/mcp.c
>  create mode 100644 src/shared/mcp.h
>  create mode 100644 src/shared/mcs.h
>
> --
> 2.25.1

Please fix the code style, there are quite a few problems with that,
it would also be great to give some information on how the plugin
works for instance does it work with bluetoothctl player menu?

-- 
Luiz Augusto von Dentz
