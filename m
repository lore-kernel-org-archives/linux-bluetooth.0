Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8515EC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 10:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF0F2089F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 10:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAz7Y7Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF0F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeKZVjy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:39:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37344 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeKZVjy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 16:39:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so15348121oia.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 02:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGvCEPAgbpAv8Q/SdX73XLiuMctQqZwcuAAjn0T5F5w=;
        b=lAz7Y7QtYpmInHaUrw51qOn50pmfWMj23FltuJqJ8jGpWwVy1DwguTkYn/TaWJURoK
         C3QjNXPRlP6GHN4NWt1x4deALjlHJ0eu4vH3KDU12vvV2n3kkavOb8FEO7fntSc5ixMB
         drXxqpn3N2H1xQL5sjyRbfRsQDHOOjHgZdBxcLxsiaAS2uhywISgScSVoyRoaPZEi5Su
         COsLI/+KBWmMKMfrz+YovXpvFKBhlLYbektqUItmi4+pLItkhNn0VJxpN3Gnr3m1MN2T
         /l2ZyLs9fT8AnKrvjqMBofx8adAxuaBFZ039gwD+6kKQSQ3fb3FVIRG67WVvDB+9Ytif
         rbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGvCEPAgbpAv8Q/SdX73XLiuMctQqZwcuAAjn0T5F5w=;
        b=poTDdEr5Isn2BNPjBitXVGBooPlo2qxYsy3m5XWn1MykaP3WzAcI9r8MJCZ7fBA6Yl
         dG5wf1xfOLmiGoGdd3fci3nfnNXALwDylBoFNQ+wVg76n59cd1Vssk/Gul3c8FGxIHkh
         L3/RjAmTqnp9rCvQr8sVZG3OefSNvajgGWJUUfeekysZcp5cE6vk6iKwF/r9+c/6/ToP
         xTP/tfJvW3cYKS/zKGgm7JL0fmhOvT99QNjTQStuy8SO8/RqOHktpWihZ+vWUQPAGZLL
         K+T1jxOJTRW8rvl0BoMbzz0KeqW6psPWYbvf7msOvjj5fhRO28BdTcmZf5zL/jovDOKF
         YXjQ==
X-Gm-Message-State: AGRZ1gKrvSp5jpq8mHWE1s7IfVXTNTSE8LeG2zBISc58erNobnti7TCb
        VFCFmhjJlN3a8ZzIEP/3u58gJeCwIu4KUVde916HVQ==
X-Google-Smtp-Source: AJdET5eQ9Gl4kpB6zRfbmh22v+Q51TNxL+tNUrqXhzqoa5v8bZK8Hp9LEDDWpEgCOz50O6WivQ74H/CH2qjbCfJdiSM=
X-Received: by 2002:aca:47c6:: with SMTP id u189mr15357988oia.250.1543229171433;
 Mon, 26 Nov 2018 02:46:11 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
 <20181125092012.8001-1-jengelh@inai.de>
In-Reply-To: <20181125092012.8001-1-jengelh@inai.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Nov 2018 12:45:58 +0200
Message-ID: <CABBYNZ+AY6NPO68P5WJEtL_CKumTEywsuoGC4Roe4evm5mia1w@mail.gmail.com>
Subject: Re: [PATCH bluez] build system refresh (take 3)
To:     jengelh@inai.de
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan,
On Sun, Nov 25, 2018 at 11:20 AM Jan Engelhardt <jengelh@inai.de> wrote:
>
>
> The following changes since commit 9568f4439efdf5daa2f941f544d8a84a2eee5cac:
>
>   doc: Initial Bluetooth Mesh API (2018-11-22 11:15:45 -0800)
>
> are available in the Git repository at:
>
>   git://github.com/jengelh/bluez
>
> for you to fetch changes up to 97561f245b7609e4c041b4083a7922817acc3ae7:
>
>   build: add missing BACKTRACE_CFLAGS (2018-11-24 20:09:10 +0100)
>
> ----------------------------------------------------------------
> Jan Engelhardt (8):
>       build: rename includedir to pkgincludedir
>       build: change @foo@ to $(foo) in automake makefiles
>       build: -l arguments to belong into LDADD/LIBADD not LDFLAGS
>       build: -D/-I arguments go into CPPFLAGS
>       build: add missing ELL_CFLAGS
>       build: add missing UDEV_CFLAGS
>       build: add missing ALSA_CFLAGS
>       build: add missing BACKTRACE_CFLAGS
>
>  Makefile.am         | 84 +++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
>  Makefile.mesh       |  8 ++++++--
>  Makefile.obexd      | 15 ++++++++-------
>  Makefile.plugins    |  9 ++++++---
>  Makefile.tools      | 66 +++++++++++++++++++++++++++++++++++-------------------------------
>  android/Makefile.am | 41 +++++++++++++++++++++--------------------
>  6 files changed, 119 insertions(+), 104 deletions(-)
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
