Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C8C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2B020663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 17:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2B020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeK0Et6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:49:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37819 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeK0Et6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 23:49:58 -0500
Received: from marcel-macbook.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id C5F95CEEB1;
        Mon, 26 Nov 2018 19:02:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ 1/6] share/mainloop: Add handling of NOTIFY_SOCKET
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181126162438.27872-1-luiz.dentz@gmail.com>
Date:   Mon, 26 Nov 2018 18:54:55 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <27978B59-0DF8-42D9-90F6-086FF3FFA386@holtmann.org>
References: <20181126162438.27872-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds handling of systemd NOTIFY_SOCKET so application using
> mainloop instance do properly notify systemd what is their state.
> ---
> Makefile.am                  |   8 ++-
> src/shared/mainloop-glib.c   |   8 +++
> src/shared/mainloop-notify.c | 104 +++++++++++++++++++++++++++++++++++
> src/shared/mainloop-notify.h |  25 +++++++++
> src/shared/mainloop.c        |  12 ++++
> src/shared/mainloop.h        |   1 +
> 6 files changed, 156 insertions(+), 2 deletions(-)
> create mode 100644 src/shared/mainloop-notify.c
> create mode 100644 src/shared/mainloop-notify.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 0b26ccc3e..124c32482 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -130,12 +130,16 @@ endif
> src_libshared_glib_la_SOURCES = $(shared_sources) \
> 				src/shared/io-glib.c \
> 				src/shared/timeout-glib.c \
> -				src/shared/mainloop-glib.c
> +				src/shared/mainloop-glib.c \
> +				src/shared/mainloop-notify.h \
> +				src/shared/mainloop-notify.c
> 
> src_libshared_mainloop_la_SOURCES = $(shared_sources) \
> 				src/shared/io-mainloop.c \
> 				src/shared/timeout-mainloop.c \
> -				src/shared/mainloop.h src/shared/mainloop.c
> +				src/shared/mainloop.h src/shared/mainloop.c \
> +				src/shared/mainloop-notify.h \
> +				src/shared/mainloop-notify.c
> 
> if ELL
> src_libshared_ell_la_SOURCES = $(shared_sources) \
> diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
> index 8436969bb..9d588e8c5 100644
> --- a/src/shared/mainloop-glib.c
> +++ b/src/shared/mainloop-glib.c
> @@ -36,6 +36,7 @@
> #include <glib.h>
> 
> #include "mainloop.h"
> +#include "mainloop-notify.h"
> 
> static GMainLoop *main_loop;
> static int exit_status;
> @@ -43,6 +44,7 @@ static int exit_status;
> void mainloop_init(void)
> {
> 	main_loop = g_main_loop_new(NULL, FALSE);
> +	mainloop_notify_init();
> }
> 
> void mainloop_quit(void)
> @@ -70,11 +72,17 @@ int mainloop_run(void)
> 	if (!main_loop)
> 		return -EINVAL;
> 
> +	mainloop_notify("READY=1");
> +
> 	g_main_loop_run(main_loop);
> 
> +	mainloop_notify("STOPPING=1");
> +

I actually think this is too simple. Frankly what we want is some generic code that runs the mainloops and handles the terminations signals and also brings you onto D-Bus. And only then signal READY=1.

If you look at iwd and wired/dbus.c then I have started something in that direction with dbus_app_run. That needs to be a bit more unified and turned into l_dbus_run or some similar name.

My thinking really is that the main() function should be just deal with argument parsing and then getting you on the system or session bus. It should not be bothered with all the signal setup or the duplicated code for handling the asynchronous shutdown. And if you have that, then you do a nice integration with NOTIFY_SOCKET.

Regards

Marcel

