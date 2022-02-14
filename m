Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87BEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiBNOOx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:14:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355001AbiBNOOw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 09:14:52 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B745ACF2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 06:14:40 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id B1B8ACED30;
        Mon, 14 Feb 2022 15:14:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH BlueZ] fix build with glibc < 2.25
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220214131451.2397549-1-fontaine.fabrice@gmail.com>
Date:   Mon, 14 Feb 2022 15:14:39 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <562900D8-1A46-46E4-B31E-FD3FBE9BE2D8@holtmann.org>
References: <20220214131451.2397549-1-fontaine.fabrice@gmail.com>
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fabrice,

> getrandom and sys/random.h are only available since glibc 2.25:
> https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002eh.html
> resulting in the following build failures since version 5.63 and
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/log/?qt=grep&q=getrandom
> so put back rand() as a fallback:
> 
> plugins/autopair.c:20:24: fatal error: sys/random.h: No such file or directory
> #include <sys/random.h>
>                        ^
> 
> Fixes:
> - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c49416c1dc0e2
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
> configure.ac           |  2 ++
> emulator/le.c          |  7 +++++++
> emulator/phy.c         |  7 +++++++
> peripheral/main.c      | 10 ++++++++++
> plugins/autopair.c     |  6 ++++++
> profiles/health/hdp.c  | 11 +++++++++++
> profiles/health/mcap.c | 10 ++++++++++
> tools/btgatt-server.c  |  6 ++++++
> 8 files changed, 59 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 07d068a4d..cdd693da3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,6 +54,8 @@ AC_ARG_ENABLE(threads, AS_HELP_STRING([--enable-threads],
> 
> AC_CHECK_FUNCS(explicit_bzero)
> 
> +AC_CHECK_FUNCS(getrandom)
> +
> AC_CHECK_FUNCS(rawmemchr)
> 
> AC_CHECK_FUNC(signalfd, dummy=yes,
> diff --git a/emulator/le.c b/emulator/le.c
> index f8f313f2c..9ef0636d0 100644
> --- a/emulator/le.c
> +++ b/emulator/le.c
> @@ -20,7 +20,9 @@
> #include <sys/socket.h>
> #include <sys/un.h>
> #include <sys/uio.h>
> +#ifdef HAVE_GETRANDOM
> #include <sys/random.h>
> +#endif
> #include <time.h>
> 
> #include "lib/bluetooth.h"
> @@ -509,10 +511,15 @@ static unsigned int get_adv_delay(void)
> 	/* The advertising delay is a pseudo-random value with a range
> 	 * of 0 ms to 10 ms generated for each advertising event.
> 	 */
> +#ifdef HAVE_GETRANDOM
> 	if (getrandom(&val, sizeof(val), 0) < 0) {
> 		/* If it fails to get the random number, use a static value */
> 		val = 5;
> 	}
> +#else
> +	srand(time(NULL));
> +	val = rand();
> +#endif

you need to introduce a src/missing.h and provide a getrandom fallback. I am not allowing to spread #ifdef around the code for some old glibc compatibility.

Regards

Marcel

