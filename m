Return-Path: <SRS0=H/dM=OB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7C4C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 08:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CDF20820
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 08:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="nMIIyYPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CDF20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbeKVS6X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:58:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34043 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeKVS6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Nov 2018 13:58:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so5907834lfc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Nov 2018 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86pZwBE5hIm5IcQt/M6RUQtSZJAkVvIdjoOFBqearhY=;
        b=nMIIyYPACJkFtV/QJ89E9R/mGz6A04gQukyt5mDHDjGdpqh8S6pGbaH12XOKQLmZCj
         FfHRzji9d8hI1fLmQtsFNMMtgLJVVJz9b5grBmsseKPXTPTF2Yr0w7ZbWQ/bI2gpumgg
         9sFBSUhqBOLh2SHSTATo/A1OhihVDu8OJwsWiz1/E9wdvCnpbMoa/xWmOSaixZDZCOLE
         CTITjbe2CCN0irBQzFG4ANmlqZppTEZJoYRi+q10TYaLlcBHcWVSNifVTlQ2nYPH302M
         irFXUip1PLGHumN6HNVXWotB8V/44iC2JgHlVbTITFylET3qYNrPWer6Nvojxbs+fBvP
         GBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=86pZwBE5hIm5IcQt/M6RUQtSZJAkVvIdjoOFBqearhY=;
        b=UkUItX1oWFcC5utdwqeMRTfQB6WBc6pDTIIHmbKDTHYdUKX9NmvJOrSNLWU2/eAZ85
         wbTMJYmMPxm2v/q8Ufpm2OFUeWqQHwwAnTSHtVudBwYz/ZZha6vufncdABJzFVEsHTFK
         X23QMfGQVwDJ4V4fbkD3eE4KAKj064MbKgpOESY6DPsFi5UZJt2S/IwJtSnZxxRoSvYl
         P8CqqobObKCV2Dkq8VT0x0fyusnOTv1IFGaWH6fqek3OS22AGUGvEbMIIDZc12okgOVp
         0PEMpwBmUpDeO6eOx3h/gS5dhziOJeBq05q98/4qf+E37rdPSSTPUO5FgkvdENFhsLz2
         PYpA==
X-Gm-Message-State: AGRZ1gL9iF27SwaDYWiUMek9JjtupynatKk9VFtWESt/N0QfZB2KanGW
        wEu3D7z9LRE3EQRCUlA1kMfUMw==
X-Google-Smtp-Source: AJdET5fo1qIjka0rKl46bqVSSm6tu7CMBIaZ589GNQ4g39+amMwfEInqyeHw6wARwE5BJ06q9R7d6A==
X-Received: by 2002:a19:db82:: with SMTP id t2mr6230998lfi.130.1542874798896;
        Thu, 22 Nov 2018 00:19:58 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id g12-v6sm7009591lja.74.2018.11.22.00.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 00:19:58 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
        inga.stotland@intel.com
Subject: Re: [PATCH BlueZ] mesh: Up-rev ELL dependancies to >= 0.14
Date:   Thu, 22 Nov 2018 09:19:55 +0100
Message-ID: <102860007.z2ZSbi0IGQ@ix>
Organization: CODECOUP
In-Reply-To: <20181121204641.10841-1-brian.gix@intel.com>
References: <20181121204641.10841-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Wednesday, 21 November 2018 21:46:41 CET Brian Gix wrote:
> ---
>  configure.ac |  4 ++--
>  mesh/dbus.c  |  4 ++--
>  mesh/main.c  | 27 ++++++++++-----------------
>  3 files changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index cbc854d62..d22f9d539 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -249,8 +249,8 @@ AC_ARG_ENABLE(btpclient,
> AC_HELP_STRING([--enable-btpclient], AM_CONDITIONAL(BTPCLIENT, test
> "${enable_btpclient}" = "yes")
> 
>  if (test "${enable_btpclient}" = "yes" || test "${enable_mesh}" = "yes");
> then -	PKG_CHECK_MODULES(ELL, ell >= 0.3, enable_ell=yes,
> -			  AC_MSG_ERROR(ell library >= 0.3 is required))
> +	PKG_CHECK_MODULES(ELL, ell >= 0.14, enable_ell=yes,
> +			  AC_MSG_ERROR(ell library >= 0.14 is required))
>  	AC_SUBST(ELL_CFLAGS)
>  	AC_SUBST(ELL_LIBS)
>  fi
> diff --git a/mesh/dbus.c b/mesh/dbus.c
> index a94ba067d..0df664f2b 100644
> --- a/mesh/dbus.c
> +++ b/mesh/dbus.c
> @@ -76,11 +76,11 @@ struct l_dbus_message *dbus_error(struct l_dbus_message
> *msg, int err, if (description)
>  		return l_dbus_message_new_error(msg,
>  				error_table[err].dbus_err,
> -				description);
> +				"%s", description);
>  	else
>  		return l_dbus_message_new_error(msg,
>  				error_table[err].dbus_err,
> -				error_table[err].default_desc);
> +				"%s", error_table[err].default_desc);
>  }
> 
>  struct l_dbus *dbus_get_bus(void)
> diff --git a/mesh/main.c b/mesh/main.c
> index 0722f3af8..96a013510 100644
> --- a/mesh/main.c
> +++ b/mesh/main.c
> @@ -26,6 +26,7 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <ctype.h>
> +#include <signal.h>
> 
>  #include <sys/stat.h>
>  #include <ell/ell.h>
> @@ -96,21 +97,16 @@ static void disconnect_callback(void *user_data)
>  	l_main_quit();
>  }
> 
> -static void signal_handler(struct l_signal *signal, uint32_t signo,
> -							void *user_data)
> +static void signal_handler(void *user_data)
>  {
>  	static bool terminated;
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
>  }
> 
>  int main(int argc, char *argv[])
> @@ -120,7 +116,6 @@ int main(int argc, char *argv[])
>  	bool dbus_debug = false;
>  	struct l_dbus *dbus = NULL;
>  	struct l_signal *signal = NULL;
> -	sigset_t mask;
>  	const char *config_dir = NULL;
>  	int index = MGMT_INDEX_NONE;
> 
> @@ -181,10 +176,8 @@ int main(int argc, char *argv[])
>  		goto done;
>  	}
> 
> -	sigemptyset(&mask);
> -	sigaddset(&mask, SIGINT);
> -	sigaddset(&mask, SIGTERM);
> -	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
> +	signal = l_signal_create(SIGINT, signal_handler, NULL, NULL);
> +	signal = l_signal_create(SIGTERM, signal_handler, NULL, NULL);
> 
>  	umask(0077);

btpclient is also using ELL, should it be updated too?

-- 
pozdrawiam
Szymon Janc


