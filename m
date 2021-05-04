Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E0EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 23:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C30D60FD9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 23:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhEDXwf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEDXwe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 19:52:34 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5367C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 16:51:38 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e190so322916ybb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VtbYOclylgGaCHiUhGLeuhFs1CwS3TfeZZzh4Bnhf8=;
        b=Fr3mXAI/pby7hNmmv3q5tvW0nTLNNtnR5FlHN6CpNJlV2M1PvN0Zxu0CUIKrMj9RI9
         Caer5RdzZnsqfZbvEOsxDR+vWG3Oj+YWOC9vG5dcfqeGA3/QWO2N+hN2dj8CM/KInkM9
         OgvXh5wfwzz4NzJOfsXISy6ZoHQT3hJl4cLHJF+HZQL/ObDafBiXmbam43n/AcDvVsxT
         EkBolxfhfLZbsQALpfPlHdEULPM9HQOY3Eci9KqMU55JPKbLzG59aj0CwdIZKUbudFyN
         d2/jUbcOXpsUVJBcBWrsPa4wrWjnPAmdkH3v55rgqbxGoxUQVr6/Fok8ZETMasFVNNXx
         8DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VtbYOclylgGaCHiUhGLeuhFs1CwS3TfeZZzh4Bnhf8=;
        b=VG7bCLz+60Ez66R8jxeA9GN1VwkAJ1KiD/fNoq4SEaTEdhgwwmhCtYpYePJXCITUct
         +zDvk6zvbfSo6pD67qQ3TXqyJzDZ9br0WedY90gub9eTj5oRPlEW0KfUKHIZfrGBZ0CE
         hWbQJK9OMrfaSXgk6pBxUg40vBb34mS8IFunvIMnwQpsjuidnYN0JyWu/XP5FR88pR8J
         dn5+0CwGp7SKlEzdRwTTA30y6DHvkijktaPmLQII7qZqyKxwhvLNwMR8eyRMPzbj+BfQ
         T9q0QIt0rBusgppYTG5GU1bHMYdT/V2gWDUzqR//ASjHYGJwfJ6ZSTOl1NcDXGqg0oSL
         E5VA==
X-Gm-Message-State: AOAM53098VP3mrGAW69tCFIlmKwDErYTrh61lc/1DBANckb9/JNkpa2j
        KLheuVHXrrrE78ygrQlS1Iykwh9bD3/9OzHRMcE=
X-Google-Smtp-Source: ABdhPJzGUZ/rtLcSntRIyyFEvwGmiKK1DvY29hyD2X39cx0NPnYteBYW7+uCpdEByB+kGv3VkwEXhpdLlOcp6daKRrY=
X-Received: by 2002:a25:ac94:: with SMTP id x20mr2790697ybi.432.1620172297786;
 Tue, 04 May 2021 16:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210504050207.841261-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210504050207.841261-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 May 2021 16:51:27 -0700
Message-ID: <CABBYNZLfX8iBp-j18pBPqYeS5yPiSiVxkEWdOQr1pWjNRngmsQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 0/4] Convert manpages to rst format
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, May 3, 2021 at 10:09 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch set converts the existing troff fomatted manpages into
> reStructuredText format, which is easier to write and manage.
>
> Also, it fixes the issue which the manpages are alwasy installed by
> default regardless of "enable-manpages" option is not set during
> configuration.
>
> In order to convert .rst to manpages(.1/.8), it requires rst2man tool
> and now this tool is checked during configuration if the manpages is
> enabled.
>
> The contents of the manpages were not changed or updated while
> converting the old manpages into .rst format.
>
> Tedd Ho-Jeong An (4):
>   build: Fix manpage enable flag
>   monitor: Convert manpage to rst format
>   src: Convert manpage to rst format
>   tools: Convert manpages to rst format
>
>  Makefile.am           |  37 +++---
>  Makefile.tools        |  33 +++--
>  configure.ac          |   6 +-
>  doc/btmon.txt         |  35 ------
>  monitor/btmon.rst     | 171 ++++++++++++++++++++++++++
>  src/bluetoothd.8.in   |  63 ----------
>  src/bluetoothd.rst.in |  84 +++++++++++++
>  tools/bdaddr.1        |  68 -----------
>  tools/bdaddr.rst      |  76 ++++++++++++
>  tools/btattach.1      |  53 --------
>  tools/btattach.rst    |  79 ++++++++++++
>  tools/ciptool.1       |  68 -----------
>  tools/ciptool.rst     |  71 +++++++++++
>  tools/hciattach.1     | 158 ------------------------
>  tools/hciattach.rst   | 166 ++++++++++++++++++++++++++
>  tools/hciconfig.1     | 272 ------------------------------------------
>  tools/hciconfig.rst   | 271 +++++++++++++++++++++++++++++++++++++++++
>  tools/hcidump.1       | 118 ------------------
>  tools/hcidump.rst     | 119 ++++++++++++++++++
>  tools/hcitool.1       | 255 ---------------------------------------
>  tools/hcitool.rst     | 213 +++++++++++++++++++++++++++++++++
>  tools/hid2hci.1       |  46 -------
>  tools/hid2hci.rst     |  50 ++++++++
>  tools/l2ping.1        |  76 ------------
>  tools/l2ping.rst      |  69 +++++++++++
>  tools/rctest.1        |  90 --------------
>  tools/rctest.rst      |  81 +++++++++++++
>  tools/rfcomm.1        | 113 ------------------
>  tools/rfcomm.rst      | 100 ++++++++++++++++
>  tools/sdptool.1       | 132 --------------------
>  tools/sdptool.rst     | 103 ++++++++++++++++
>  31 files changed, 1701 insertions(+), 1575 deletions(-)
>  delete mode 100644 doc/btmon.txt
>  create mode 100644 monitor/btmon.rst
>  delete mode 100644 src/bluetoothd.8.in
>  create mode 100644 src/bluetoothd.rst.in
>  delete mode 100644 tools/bdaddr.1
>  create mode 100644 tools/bdaddr.rst
>  delete mode 100644 tools/btattach.1
>  create mode 100644 tools/btattach.rst
>  delete mode 100644 tools/ciptool.1
>  create mode 100644 tools/ciptool.rst
>  delete mode 100644 tools/hciattach.1
>  create mode 100644 tools/hciattach.rst
>  delete mode 100644 tools/hciconfig.1
>  create mode 100644 tools/hciconfig.rst
>  delete mode 100644 tools/hcidump.1
>  create mode 100644 tools/hcidump.rst
>  delete mode 100644 tools/hcitool.1
>  create mode 100644 tools/hcitool.rst
>  delete mode 100644 tools/hid2hci.1
>  create mode 100644 tools/hid2hci.rst
>  delete mode 100644 tools/l2ping.1
>  create mode 100644 tools/l2ping.rst
>  delete mode 100644 tools/rctest.1
>  create mode 100644 tools/rctest.rst
>  delete mode 100644 tools/rfcomm.1
>  create mode 100644 tools/rfcomm.rst
>  delete mode 100644 tools/sdptool.1
>  create mode 100644 tools/sdptool.rst
>
> --
> 2.26.3

Applied, thanks.

-- 
Luiz Augusto von Dentz
