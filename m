Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF70C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 06:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B291A61289
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 06:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhD1G26 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhD1G25 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 02:28:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29800C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 23:28:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h11so3391011pfn.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 23:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jJY/dFUkpjxYmvau5YLBdrdrXdQHXHk0R3XBMLK7Xls=;
        b=IvHfdZTi9b/6P4Y7ZxDPkW2xG7Mr+2jNORppFi56UI5qM0dNK4+p81BfQ4K1j1MTIu
         JRAXgP67qfCyebZvXWH0LsL/8IjCvpbG62E64chEUitqstDiMCLIm7+JmEIMJe4m5Tkm
         4d2Xs8+Fi0mhkDhk0mw05WQAwGsE6gnRbvM07vyP/NAIlFbErVx7OrrDh9ULNl+Zr1IP
         SsI9N0EjMlisQA4d5HuV4690rM0F+9HvrBUQOj9LRNfsBOlGrebgJEc4mpmp15bG8YCo
         6JgDIJHs0qvyjVtLBJTPHYJFDYxrh6sBU/H5Vi/kw/hzkpVXeyV8QSMl9SJt8vukm4Kh
         aHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jJY/dFUkpjxYmvau5YLBdrdrXdQHXHk0R3XBMLK7Xls=;
        b=WAgyJQBKf7lrP0wrL6TZzvWUmc1HLiHT8sQZeRabTONSeZd7buOwwsDfuBIyXrYSIl
         VVQ5kyXohmIyFS6Z++MJX6DgppTYhcLhCebfj/hIWR3PUwypPJlGGBkLObRlst9arieN
         A916X2X6IrCj7Y37/enB2KRAw2/eSlKeKnKJ1GpJpeGDRnVmpPdbmT/d56Ib+dDmYCHG
         gpetbOH4UUIqseoZiFaw5xGmdKvd0qoPPTim/Tr8K7EiFJph28oXAAGCAa/ogsoyT29a
         FPelm6C/FvJaOB1mGCHqZ75kRkhPzSMKtH7v3ZYrVmyaEsub9ggQR62dSURKW2a+9LyZ
         5GGw==
X-Gm-Message-State: AOAM531LjE4B4bR4LAH9Dnu+TpqZn77KhnoOVaGBCS9ta5fa0+YDZ3y4
        /nTP4GZVF/dq8V/sm/HNYTlHe25b4dQ=
X-Google-Smtp-Source: ABdhPJy/ogVYgKEEA0aq/ycKEgd+N4ks7iIgDYI03ygNgTBsQICBEej5qE+eIbgaVs238PZiRgb3ag==
X-Received: by 2002:a65:4548:: with SMTP id x8mr25397350pgr.413.1619591291765;
        Tue, 27 Apr 2021 23:28:11 -0700 (PDT)
Received: from han1-XPS-13-9350 ([2601:1c0:6a01:d830:6e5:bd32:3019:cc30])
        by smtp.gmail.com with ESMTPSA id w17sm4120332pfq.187.2021.04.27.23.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:28:11 -0700 (PDT)
Message-ID: <761c1b9fc3f3e22bed2596261b902280d31ae0bf.camel@gmail.com>
Subject: Re: [BlueZ] monitor: Update manpage
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 27 Apr 2021 23:28:10 -0700
In-Reply-To: <C54E48C1-82D5-4F91-8E34-AACB99BE7651@holtmann.org>
References: <20210427174310.100632-1-hj.tedd.an@gmail.com>
         <C54E48C1-82D5-4F91-8E34-AACB99BE7651@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Tue, 2021-04-27 at 20:39 +0200, Marcel Holtmann wrote:
> Hi Tedd,
> 
> > This patch updates the manpage for btmon.
> > ---
> > Makefile.am     |  10 +---
> > Makefile.tools  |   3 +
> > doc/btmon.txt   |  35 -----------
> > monitor/btmon.1 | 152 ++++++++++++++++++++++++++++++++++++++++++++++++
> > 4 files changed, 156 insertions(+), 44 deletions(-)
> > delete mode 100644 doc/btmon.txt
> > create mode 100644 monitor/btmon.1
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index f98243f72..625a7ce3d 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -579,14 +579,6 @@ if LIBRARY
> > pkgconfig_DATA = lib/bluez.pc
> > endif
> > 
> > -manual_pages = doc/btmon.1
> > -
> > -if MANPAGES
> > -dist_noinst_MANS += $(manual_pages)
> > -endif
> > -
> > -EXTRA_DIST += $(manual_pages:.1=.txt)
> > -
> > DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
> > 						--enable-health \
> > 						--enable-midi \
> > @@ -597,7 +589,7 @@ DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --
> > enable-library \
> > 						--disable-systemd \
> > 						--disable-udev
> > 
> > -DISTCLEANFILES = $(pkgconfig_DATA) $(unit_tests) $(manual_pages)
> > +DISTCLEANFILES = $(pkgconfig_DATA) $(unit_tests)
> > 
> > MAINTAINERCLEANFILES = Makefile.in \
> > 	aclocal.m4 configure config.h.in config.sub config.guess \
> > diff --git a/Makefile.tools b/Makefile.tools
> > index 57e858290..069f40ec8 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -49,6 +49,9 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
> > 				monitor/tty.h
> > monitor_btmon_LDADD = lib/libbluetooth-internal.la \
> > 				src/libshared-mainloop.la $(UDEV_LIBS) -ldl
> > +dist_man_MANS += monitor/btmon.1
> > +else
> > +EXTRA_DIST += monitor/btmon.1
> > endif
> > 
> > if LOGGER
> > diff --git a/doc/btmon.txt b/doc/btmon.txt
> > deleted file mode 100644
> > index 7a7fc537b..000000000
> > --- a/doc/btmon.txt
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -BTMON(1)
> > -========
> > -:doctype: manpage
> > -
> > -
> > -NAME
> > -----
> > -btmon - Bluetooth monitor
> > -
> > -
> > -SYNOPSIS
> > ---------
> > -*btmon* ['OPTIONS']
> > -
> > -
> > -DESCRIPTION
> > ------------
> > -The btmon(1) command provides access to the Bluetooth subsystem monitor
> > -infrastructure for reading HCI traces.
> > -
> > -
> > -AUTHOR
> > -------
> > -btmon was originally written by Marcel Holtmann.
> > -
> > -
> > -RESOURCES
> > ----------
> > -See <http://www.bluez.org/>
> > -
> > -
> > -COPYING
> > --------
> > -Free use of this software is granted under ther terms of the GNU Lesser
> > -General Public Licenses (LGPL).
> > diff --git a/monitor/btmon.1 b/monitor/btmon.1
> > new file mode 100644
> > index 000000000..a9d8430c8
> > --- /dev/null
> > +++ b/monitor/btmon.1
> > @@ -0,0 +1,152 @@
> > +.\" Manpage for btmon
> > +.TH btmon 1 "April 2021" BlueZ "Linux System Administration"
> > +
> > +.SH NAME
> > +btmon - Bluetooth monitor
> 
> I rather not do that. Doing manage with troff is crazy. Please write them
> Restful and then lets use rst2man to create them. See how we do it in iwd
> repository.
> 
Thanks for the comment. I just sent the v2 for review.

Using RST is way more quick and easy to write the manpage.
To be honest with you, it was a painful to use troff for manpage.


> Regards
> 
> Marcel
> 

Regards,
Tedd

