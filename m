Return-Path: <SRS0=ddeR=OI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139FDC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 11:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADFE2148E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 11:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqijBWjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADFE2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeK2XCW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:02:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36534 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeK2XCW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Nov 2018 18:02:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so1373709oix.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Nov 2018 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+qGP/kAbnFczqyDHRXIsfHZ/wTyQNFoV8hOF4hd54o=;
        b=CqijBWjmh820ZBHh3D/cptJheRkbLQ2I/Y3iBHNcaM2fwL/5K225EKFrMM4ZnL+rYF
         qroDM0durdWhoYwPHoOOjH94//ivue3JyC28+9KpdkF12c9ha8XeYBW5D0hGCxkmEB4P
         Sd3oAU7eXQ9Hk72PD4aEb1oa1Vqce/kiqeqpjyktz4Ng8RAK+d9We/4US3zRmgZh6ks/
         OLVQQcQbpsQhV3cP4bn9I5tfImD5Nwhfw/2d/sfW/sBl1Q4eggHAnB7uNwrPEToetISh
         lJPjre9zHoQsCriW8U7o+owpP21xmtarjoXYZxvvS+nPSyN/a9HILwjQBGJGT6S1NBrT
         6m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+qGP/kAbnFczqyDHRXIsfHZ/wTyQNFoV8hOF4hd54o=;
        b=V8iUkSf18RdNpxQ9QcZv2DqytZK6MxjLwRooBSbzssXBClwqfCDA77xwDjuYyUt0Lx
         F6YIGLlJsZpeAKNSaO4NMIV6iuTnqNPYioA1KZW/jYYCxOWb7nvxTvz5IRi2WU9U9mC/
         lxoIhH7nSLajCv2bAadWoXeUbeGKY7rCJLncI+gliQaaYSJDKWZE2fQ5jJMGr/Vt/iMi
         LLuegD9fTqAt3ZhXDXisC+PLBhCXtpG9GPvhVmqV2D0azqtDOGGD+/BeCmmNeePFI3Fp
         M8V8QKocRatTwXPUP4pFVw/96t6atktk25LZgqu5uiqp+rcdBHluFeohmrY9+VqIcgce
         5KdQ==
X-Gm-Message-State: AA+aEWaYDFPtnkB47gXIcpNuW3BvQdYFdt0x6RjrtCgh48H7bNJ8VAC5
        r5wdedzmi8XcEsK5GaeGzZI3Q80hxfGdiJr8wuESLg==
X-Google-Smtp-Source: AFSGD/XYLzQ3ZiRRsUnaA/zfaP/9/BI2P4Yzc4O2RG1Ydw1DZHsVOI+5QNqDVbg96OGeOgZneesRc5qsmuqAYYskc1s=
X-Received: by 2002:a05:6808:97:: with SMTP id s23mr618265oic.251.1543492634856;
 Thu, 29 Nov 2018 03:57:14 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZ+EmmyGU2_ktS237iCjrEa1d7=ODCy_nmNerXmCuX7tsg@mail.gmail.com>
 <20181128154514.17315-1-jengelh@inai.de>
In-Reply-To: <20181128154514.17315-1-jengelh@inai.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Nov 2018 13:57:01 +0200
Message-ID: <CABBYNZ+Wqp5wFnTLuduAzJ7-k_hS+0H4T_JCfVuxYNtH0b6qnw@mail.gmail.com>
Subject: Re: [PATCH] build: make building with --coverage work again
To:     jengelh@inai.de
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan,
On Wed, Nov 28, 2018 at 5:45 PM Jan Engelhardt <jengelh@inai.de> wrote:
>
> When `./configure --enable-coverage` is given and lcov is present,
> MISC_CFLAGS and MISC_LDFLAGS will be set to --coverage. However,
>
> 1. obexd uses per-target LDFLAGS and, in doing so, forget to re-mention
> $(AM_LDFLAGS). This problem existed for a long time.
>
> 2. obexd uses per-target CFLAGS and, in doing so, forgot to re-mention
> $(AM_CFLAGS). This got broken in 06dbb223fbe50acc48b3ba1d33cb424275b4baaa.
>
> This led to no --coverage showing up in the linker line for obexd,
> causing a link failure indicating unresolved symbols like
> __gcov_exit.
> ---
>  Makefile.obexd      | 6 +++---
>  android/Makefile.am | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 22a4977ef..1c1e500fe 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -81,15 +81,15 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
>                         gdbus/libgdbus-internal.la \
>                         $(ICAL_LIBS) $(DBUS_LIBS) $(GLIB_LIBS) -ldl
>
> -obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
> +obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
>
> -obexd_src_obexd_CPPFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
> +obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
>                                 $(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
>                                 -DPLUGINDIR=\""$(obex_plugindir)"\" \
>                                 -D_FILE_OFFSET_BITS=64 \
>                                 -I$(builddir)/lib -I$(builddir)/obexd/src
>
> -obexd_src_obexd_CFLAGS = -fPIC
> +obexd_src_obexd_CFLAGS = $(AM_CFLAGS) -fPIC
>
>  endif
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 5dd1adf9d..a370598a2 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -142,7 +142,7 @@ android_haltest_SOURCES = android/client/haltest.c \
>                                 android/hal-utils.h android/hal-utils.c
>  android_haltest_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
>                                 -DPLUGINDIR=\""$(android_plugindir)"\"
> -android_haltest_LDFLAGS = -pthread
> +android_haltest_LDFLAGS = $(AM_LDFLAGS) -pthread
>  android_haltest_LDADD = -ldl -lm
>
>  noinst_PROGRAMS += android/android-tester
> @@ -167,7 +167,7 @@ android_android_tester_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
>                                 -DPLUGINDIR=\""$(android_plugindir)"\"
>  android_android_tester_LDADD = lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS) -ldl
> -android_android_tester_LDFLAGS = -pthread
> +android_android_tester_LDFLAGS = $(AM_LDFLAGS) -pthread
>
>  noinst_PROGRAMS += android/ipc-tester
>
> --
> 2.19.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
