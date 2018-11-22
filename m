Return-Path: <SRS0=H/dM=OB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCAC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED69520831
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 07:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED69520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbeKVRv6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:51:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60127 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbeKVRv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Nov 2018 12:51:58 -0500
Received: from marcel-macbook.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 73298CF30D;
        Thu, 22 Nov 2018 08:21:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ] mesh: Up-rev ELL dependancies to >= 0.14
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181121204641.10841-1-brian.gix@intel.com>
Date:   Thu, 22 Nov 2018 08:13:50 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <FDBF83E3-6D9E-4294-8CF9-D3CBB202AA0D@holtmann.org>
References: <20181121204641.10841-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> ---
> configure.ac |  4 ++--
> mesh/dbus.c  |  4 ++--
> mesh/main.c  | 27 ++++++++++-----------------
> 3 files changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index cbc854d62..d22f9d539 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -249,8 +249,8 @@ AC_ARG_ENABLE(btpclient, AC_HELP_STRING([--enable-btpclient],
> AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
> 
> if (test "${enable_btpclient}" = "yes" || test "${enable_mesh}" = "yes"); then
> -	PKG_CHECK_MODULES(ELL, ell >= 0.3, enable_ell=yes,
> -			  AC_MSG_ERROR(ell library >= 0.3 is required))
> +	PKG_CHECK_MODULES(ELL, ell >= 0.14, enable_ell=yes,
> +			  AC_MSG_ERROR(ell library >= 0.14 is required))
> 	AC_SUBST(ELL_CFLAGS)
> 	AC_SUBST(ELL_LIBS)
> fi
> diff --git a/mesh/dbus.c b/mesh/dbus.c
> index a94ba067d..0df664f2b 100644
> --- a/mesh/dbus.c
> +++ b/mesh/dbus.c
> @@ -76,11 +76,11 @@ struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
> 	if (description)
> 		return l_dbus_message_new_error(msg,
> 				error_table[err].dbus_err,
> -				description);
> +				"%s", description);
> 	else
> 		return l_dbus_message_new_error(msg,
> 				error_table[err].dbus_err,
> -				error_table[err].default_desc);
> +				"%s", error_table[err].default_desc);
> }
> 
> struct l_dbus *dbus_get_bus(void)
> diff --git a/mesh/main.c b/mesh/main.c
> index 0722f3af8..96a013510 100644
> --- a/mesh/main.c
> +++ b/mesh/main.c
> @@ -26,6 +26,7 @@
> #include <stdio.h>
> #include <unistd.h>
> #include <ctype.h>
> +#include <signal.h>
> 
> #include <sys/stat.h>
> #include <ell/ell.h>
> @@ -96,21 +97,16 @@ static void disconnect_callback(void *user_data)
> 	l_main_quit();
> }
> 
> -static void signal_handler(struct l_signal *signal, uint32_t signo,
> -							void *user_data)
> +static void signal_handler(void *user_data)
> {
> 	static bool terminated;
> 
> -	switch (signo) {
> -	case SIGINT:
> -	case SIGTERM:
> -		if (terminated)
> -			return;
> -		l_info("Terminating");
> -		l_main_quit();
> -		terminated = true;
> -		break;
> -	}
> +	if (terminated)
> +		return;
> +
> +	l_info("Terminating");
> +	l_main_quit();
> +	terminated = true;
> }
> 
> int main(int argc, char *argv[])
> @@ -120,7 +116,6 @@ int main(int argc, char *argv[])
> 	bool dbus_debug = false;
> 	struct l_dbus *dbus = NULL;
> 	struct l_signal *signal = NULL;
> -	sigset_t mask;
> 	const char *config_dir = NULL;
> 	int index = MGMT_INDEX_NONE;
> 
> @@ -181,10 +176,8 @@ int main(int argc, char *argv[])
> 		goto done;
> 	}
> 
> -	sigemptyset(&mask);
> -	sigaddset(&mask, SIGINT);
> -	sigaddset(&mask, SIGTERM);
> -	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
> +	signal = l_signal_create(SIGINT, signal_handler, NULL, NULL);
> +	signal = l_signal_create(SIGTERM, signal_handler, NULL, NULL);

why not switch to l_main_run_with_signal() instead. We will be hiding the whole signal handling eventually anyway.

Regards

Marcel

