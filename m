Return-Path: <SRS0=KRcZ=RD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35738C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1420E218B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 18:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfB1SuS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:50:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:18470 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfB1SuS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Feb 2019 13:50:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 10:50:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="128016085"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2019 10:50:15 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 28 Feb 2019 10:50:14 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.92]) with mapi id 14.03.0415.000;
 Thu, 28 Feb 2019 10:50:09 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: RE: [PATCH BlueZ] mesh: Fix type checking for 32 vs 64 bit systems
Thread-Topic: [PATCH BlueZ] mesh: Fix type checking for 32 vs 64 bit systems
Thread-Index: AQHUzsgYZ4dUKc49l0CVfIm0EVRuh6X1jzPg
Date:   Thu, 28 Feb 2019 18:50:06 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D93A10F@ORSMSX103.amr.corp.intel.com>
References: <20190227181255.5982-1-brian.gix@intel.com>
In-Reply-To: <20190227181255.5982-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGEzYzIzNmEtYjQ4Yy00NDBlLTk1YmQtNTU2NzM0MzY4ZGI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV080SFdVSFI5cTRLd1NmUWNXSE1VdVpwSUtuazRsWmxZSStGTFFKN2VXK2JnOFIwNFpEMk0xQldteXFaaDNMKyJ9
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Applied

> -----Original Message-----
> From: Gix, Brian
> Sent: Wednesday, February 27, 2019 10:13 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Stotland, Inga <inga.stotland@intel.com>; Gix, Brian
> <brian.gix@intel.com>; marcel@holtmann.org
> Subject: [PATCH BlueZ] mesh: Fix type checking for 32 vs 64 bit systems
> 
> ---
>  mesh/cfgmod-server.c | 2 +-
>  mesh/model.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c index
> 992d4ac6a..9dc82eef6 100644
> --- a/mesh/cfgmod-server.c
> +++ b/mesh/cfgmod-server.c
> @@ -1129,7 +1129,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
>  		gettimeofday(&time_now, NULL);
>  		time_now.tv_sec -= hb->sub_start;
> 
> -		if (time_now.tv_sec >= hb->sub_period)
> +		if (time_now.tv_sec >= (long int) hb->sub_period)
>  			time_now.tv_sec = 0;
>  		else
>  			time_now.tv_sec = hb->sub_period -
> time_now.tv_sec; diff --git a/mesh/model.c b/mesh/model.c index
> 1e302b73b..5940f6854 100644
> --- a/mesh/model.c
> +++ b/mesh/model.c
> @@ -414,15 +414,15 @@ static void cmplt(uint16_t remote, uint8_t status,
> 
>  	gettimeofday(&tx_end, NULL);
>  	if (tx_end.tv_sec == tx_start.tv_sec) {
> -		l_debug("Duration 0.%zu seconds",
> +		l_debug("Duration 0.%6.6lu seconds",
>  				tx_end.tv_usec - tx_start.tv_usec);
>  	} else {
>  		if (tx_start.tv_usec > tx_end.tv_usec)
> -			l_debug("Duration %zu.%zu seconds",
> +			l_debug("Duration %lu.%6.6lu seconds",
>  				tx_end.tv_sec - tx_start.tv_sec - 1,
>  				tx_end.tv_usec + 1000000 -
> tx_start.tv_usec);
>  		else
> -			l_debug("Duration %zu.%zu seconds",
> +			l_debug("Duration %lu.%6.6lu seconds",
>  					tx_end.tv_sec - tx_start.tv_sec,
>  					tx_end.tv_usec - tx_start.tv_usec);
>  	}
> --
> 2.14.5

