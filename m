Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC224C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843B22081C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 17:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843B22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeK2EIP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:08:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:21338 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbeK2EIP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 23:08:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 09:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="104505525"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2018 09:05:51 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.161]) with mapi id 14.03.0415.000;
 Wed, 28 Nov 2018 09:05:51 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: RE: [PATCH BlueZ v2] mesh: Up-rev ELL dependancies to >= 0.14
Thread-Topic: [PATCH BlueZ v2] mesh: Up-rev ELL dependancies to >= 0.14
Thread-Index: AQHUgptlC+wySPvAqkSNLfn0GP95dKVlc7lw
Date:   Wed, 28 Nov 2018 17:05:50 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375C139680@ORSMSX103.amr.corp.intel.com>
References: <20181122194119.24617-1-brian.gix@intel.com>
In-Reply-To: <20181122194119.24617-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTQ2NDFmYzItYTBhOS00MzUwLTliODMtNzMzNzdkOWI5NDgyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM0t2UFAxbVlpREFrek51ekJQNVJ1K1lXeXdJQ2IyNm03RVhJeTk3ZTV1K2tMQk92T3VsU0p2WndocjVkb0FnOSJ9
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch has been applied, and Mesh now requires an ELL version >= 0.14 to build.

> -----Original Message-----
> From: Gix, Brian
> Sent: Thursday, November 22, 2018 11:41 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: johan.hedberg@gmail.com; Stotland, Inga <inga.stotland@intel.com>;
> marcel@holtmann.org; Gix, Brian <brian.gix@intel.com>
> Subject: [PATCH BlueZ v2] mesh: Up-rev ELL dependancies to >= 0.14
> 
> ---
>  configure.ac |  4 ++--
>  mesh/main.c  | 31 +++++++++----------------------
>  2 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac index ec810fcf4..ee4199f4d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -249,8 +249,8 @@ AC_ARG_ENABLE(btpclient, AC_HELP_STRING([--
> enable-btpclient],
>  AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
> 
>  if (test "${enable_btpclient}" = "yes" || test "${enable_mesh}" = "yes");
> then
> -	PKG_CHECK_MODULES(ELL, ell >= 0.3, enable_ell=yes,
> -			  AC_MSG_ERROR(ell library >= 0.3 is required))
> +	PKG_CHECK_MODULES(ELL, ell >= 0.14, enable_ell=yes,
> +			  AC_MSG_ERROR(ell library >= 0.14 is required))
>  	AC_SUBST(ELL_CFLAGS)
>  	AC_SUBST(ELL_LIBS)
>  fi
> diff --git a/mesh/main.c b/mesh/main.c
> index 289b0582b..97f506a75 100644
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
> @@ -59,29 +60,22 @@ static void usage(void)
>  	       "\t--help            Show %s information\n", __func__);
>  }
> 
> -static void signal_handler(struct l_signal *signal, uint32_t signo,
> -							void *user_data)
> +static void signal_handler(uint32_t signo, void *user_data)
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
>  {
>  	int status;
>  	bool detached = true;
> -	struct l_signal *signal;
> -	sigset_t mask;
>  	struct bt_mesh *mesh = NULL;
>  	const char *config_file = NULL;
>  	int index = MGMT_INDEX_NONE;
> @@ -140,11 +134,6 @@ int main(int argc, char *argv[])
>  		goto done;
>  	}
> 
> -	sigemptyset(&mask);
> -	sigaddset(&mask, SIGINT);
> -	sigaddset(&mask, SIGTERM);
> -	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
> -
>  	umask(0077);
> 
>  	if (detached) {
> @@ -155,9 +144,7 @@ int main(int argc, char *argv[])
>  		}
>  	}
> 
> -	status = l_main_run();
> -
> -	l_signal_remove(signal);
> +	status = l_main_run_with_signal(signal_handler, NULL);
> 
>  done:
>  	mesh_unref(mesh);
> --
> 2.14.5

