Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768DEEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 06:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjHIGCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjHIGCO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 02:02:14 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8C1BFA
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 23:02:13 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5bf3a6.dynamic.kabel-deutschland.de [95.91.243.166])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 632F561E5FE01;
        Wed,  9 Aug 2023 08:02:08 +0200 (CEST)
Message-ID: <a22d3ca8-2ec8-4968-801e-2bbc3b8e4d09@molgen.mpg.de>
Date:   Wed, 9 Aug 2023 08:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2] configure.ac: Install D-Bus policy in
 /usr/share, not /etc
Content-Language: en-US
To:     Gioele Barabucci <gioele@svario.it>
References: <20230808200022.2001329-1-gioele@svario.it>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230808200022.2001329-1-gioele@svario.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Gioele,


Thank you very much for your patch.

Am 08.08.23 um 22:00 schrieb Gioele Barabucci:
>  From https://bugs.debian.org/1006631:
> 
>> dbus supports policy files in both `/usr/share/dbus-1/system.d` and
>> `/etc/dbus-1/systemd`. [The] recently released dbus 1.14.0, officially
>> deprecates installing packages' default policies into
>> `/etc/dbus-1/systemd`, instead reserving it for the sysadmin.
>> This is the same idea as the difference between `/usr/lib/udev/rules.d`
>> and `/etc/udev/rules.d`.
> ---
> v2: bump D-Bus min version, derive DBUS_CONFDIR from datadir

It’d be great if you mentioned the D-Bus version bump explicitly in the 
commit message, and the years of the release (2012 and 2015). (Maybe 
even make it a separate commit.)


Kind regards,

Paul


> ---
>   configure.ac | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index bc7edfcd3..ad864dea7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -82,23 +82,23 @@ if (test "${enable_threads}" = "yes"); then
>   	PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= 2.16, dummy=yes,
>   				AC_MSG_ERROR(GThread >= 2.16 is required))
>   	GLIB_CFLAGS="$GLIB_CFLAGS $GTHREAD_CFLAGS"
>   	GLIB_LIBS="$GLIB_LIBS $GTHREAD_LIBS"
>   fi
>   
> -PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.6, dummy=yes,
> -				AC_MSG_ERROR(D-Bus >= 1.6 is required))
> +PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.10, dummy=yes,
> +				AC_MSG_ERROR(D-Bus >= 1.10 is required))
>   AC_SUBST(DBUS_CFLAGS)
>   AC_SUBST(DBUS_LIBS)
>   
>   AC_ARG_WITH([dbusconfdir], AS_HELP_STRING([--with-dbusconfdir=DIR],
>   				[path to D-Bus configuration directory]),
>   					[path_dbusconfdir=${withval}])
>   if (test -z "${path_dbusconfdir}"); then
>   	AC_MSG_CHECKING([D-Bus configuration directory])
> -	path_dbusconfdir="`$PKG_CONFIG --variable=sysconfdir dbus-1`"
> +	path_dbusconfdir="`$PKG_CONFIG --variable=datadir dbus-1`"
>   	if (test -z "${path_dbusconfdir}"); then
>   		AC_MSG_ERROR([D-Bus configuration directory is required])
>   	fi
>   	AC_MSG_RESULT([${path_dbusconfdir}])
>   fi
>   AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
