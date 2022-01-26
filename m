Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8BBC28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 11:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiAZLiS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiAZLiS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 06:38:18 -0500
X-Greylist: delayed 95 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jan 2022 03:38:17 PST
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FCC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 03:38:17 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C0D1240011
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 11:38:15 +0000 (UTC)
Message-ID: <78f77f0268ce1b4818c0a0749d3371b825fa1c92.camel@hadess.net>
Subject: Re: [PATCH 1/4] build: Always define confdir and statedir
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Wed, 26 Jan 2022 12:38:15 +0100
In-Reply-To: <20220126113638.1706785-1-hadess@hadess.net>
References: <20220126113638.1706785-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some patches from 2017 to use systemd lockdown. They've been used for 5
years by Fedora and RHEL.

Cheers

On Wed, 2022-01-26 at 12:36 +0100, Bastien Nocera wrote:
> As we will need those paths to lock down on them.
> ---
>  Makefile.am | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index e391d7ae8..2ba25e687 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -28,14 +28,14 @@ AM_CFLAGS = $(MISC_CFLAGS) $(WARNING_CFLAGS)
> $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) \
>                                 $(LIBEDATASERVER_CFLAGS)
> $(ell_cflags)
>  AM_LDFLAGS = $(MISC_LDFLAGS)
>  
> +confdir = $(sysconfdir)/bluetooth
> +statedir = $(localstatedir)/lib/bluetooth
> +
>  if DATAFILES
>  dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
>  dbus_DATA = src/bluetooth.conf
>  
> -confdir = $(sysconfdir)/bluetooth
>  conf_DATA =
> -
> -statedir = $(localstatedir)/lib/bluetooth
>  state_DATA =
>  endif
>  

