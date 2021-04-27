Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27AC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693E0613F6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 18:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhD0Skf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:40:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60477 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbhD0Ske (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Apr 2021 14:40:34 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 58D0ECED05;
        Tue, 27 Apr 2021 20:47:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [BlueZ] monitor: Update manpage
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210427174310.100632-1-hj.tedd.an@gmail.com>
Date:   Tue, 27 Apr 2021 20:39:49 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C54E48C1-82D5-4F91-8E34-AACB99BE7651@holtmann.org>
References: <20210427174310.100632-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch updates the manpage for btmon.
> ---
> Makefile.am     |  10 +---
> Makefile.tools  |   3 +
> doc/btmon.txt   |  35 -----------
> monitor/btmon.1 | 152 ++++++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 156 insertions(+), 44 deletions(-)
> delete mode 100644 doc/btmon.txt
> create mode 100644 monitor/btmon.1
> 
> diff --git a/Makefile.am b/Makefile.am
> index f98243f72..625a7ce3d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -579,14 +579,6 @@ if LIBRARY
> pkgconfig_DATA = lib/bluez.pc
> endif
> 
> -manual_pages = doc/btmon.1
> -
> -if MANPAGES
> -dist_noinst_MANS += $(manual_pages)
> -endif
> -
> -EXTRA_DIST += $(manual_pages:.1=.txt)
> -
> DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
> 						--enable-health \
> 						--enable-midi \
> @@ -597,7 +589,7 @@ DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
> 						--disable-systemd \
> 						--disable-udev
> 
> -DISTCLEANFILES = $(pkgconfig_DATA) $(unit_tests) $(manual_pages)
> +DISTCLEANFILES = $(pkgconfig_DATA) $(unit_tests)
> 
> MAINTAINERCLEANFILES = Makefile.in \
> 	aclocal.m4 configure config.h.in config.sub config.guess \
> diff --git a/Makefile.tools b/Makefile.tools
> index 57e858290..069f40ec8 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -49,6 +49,9 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
> 				monitor/tty.h
> monitor_btmon_LDADD = lib/libbluetooth-internal.la \
> 				src/libshared-mainloop.la $(UDEV_LIBS) -ldl
> +dist_man_MANS += monitor/btmon.1
> +else
> +EXTRA_DIST += monitor/btmon.1
> endif
> 
> if LOGGER
> diff --git a/doc/btmon.txt b/doc/btmon.txt
> deleted file mode 100644
> index 7a7fc537b..000000000
> --- a/doc/btmon.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -BTMON(1)
> -========
> -:doctype: manpage
> -
> -
> -NAME
> -----
> -btmon - Bluetooth monitor
> -
> -
> -SYNOPSIS
> ---------
> -*btmon* ['OPTIONS']
> -
> -
> -DESCRIPTION
> ------------
> -The btmon(1) command provides access to the Bluetooth subsystem monitor
> -infrastructure for reading HCI traces.
> -
> -
> -AUTHOR
> -------
> -btmon was originally written by Marcel Holtmann.
> -
> -
> -RESOURCES
> ----------
> -See <http://www.bluez.org/>
> -
> -
> -COPYING
> --------
> -Free use of this software is granted under ther terms of the GNU Lesser
> -General Public Licenses (LGPL).
> diff --git a/monitor/btmon.1 b/monitor/btmon.1
> new file mode 100644
> index 000000000..a9d8430c8
> --- /dev/null
> +++ b/monitor/btmon.1
> @@ -0,0 +1,152 @@
> +.\" Manpage for btmon
> +.TH btmon 1 "April 2021" BlueZ "Linux System Administration"
> +
> +.SH NAME
> +btmon - Bluetooth monitor

I rather not do that. Doing manage with troff is crazy. Please write them Restful and then lets use rst2man to create them. See how we do it in iwd repository.

Regards

Marcel

