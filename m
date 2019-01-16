Return-Path: <SRS0=3VKx=PY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F1C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jan 2019 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C2E20868
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jan 2019 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfAPUGO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:06:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:26344 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfAPUGO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jan 2019 15:06:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 12:06:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="267666402"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2019 12:06:14 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 16 Jan 2019 12:06:13 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.107]) with mapi id 14.03.0415.000;
 Wed, 16 Jan 2019 12:06:13 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: RE: [PATCH BlueZ] mesh: Cleanup PB-ADV transport on Prov Close
Thread-Topic: [PATCH BlueZ] mesh: Cleanup PB-ADV transport on Prov Close
Thread-Index: AQHUrF2pSSjeX1js+k6webuQckGSR6WyVPkg
Date:   Wed, 16 Jan 2019 20:06:12 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D90B8F2@ORSMSX103.amr.corp.intel.com>
References: <20190114230524.22506-1-brian.gix@intel.com>
In-Reply-To: <20190114230524.22506-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjE5N2IwMjUtODQxZi00MjBmLWE5OGEtZWFlNjkyOWIwNmE3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS0QzTzZEY3hnXC9wZXV3eGp5MlZwTUV6OVNJdlI0ZmljMWZNcmUrY3pRYzNBVEs3OERRQkRRS3VkbFRwRDdnWGEifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Applied upstream

> -----Original Message-----
> From: Gix, Brian
> Sent: Monday, January 14, 2019 3:05 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Stotland, Inga <inga.stotland@intel.com>; Gix, Brian
> <brian.gix@intel.com>
> Subject: [PATCH BlueZ] mesh: Cleanup PB-ADV transport on Prov Close
> 
> PB-ADV always used for provisioning, so must always  be cleaned up.
> ---
>  mesh/prov-acceptor.c  | 5 +----
>  mesh/prov-initiator.c | 2 ++
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c index
> d983991d4..3d4d93ba4 100644
> --- a/mesh/prov-acceptor.c
> +++ b/mesh/prov-acceptor.c
> @@ -126,10 +126,7 @@ static void acceptor_free(void)
>  	mesh_send_cancel(bec_filter, sizeof(bec_filter));
>  	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
> 
> -	if (prov->trans_tx) {
> -		if (prov->transport == PB_ADV)
> -			pb_adv_unreg(prov->trans_data);
> -	}
> +	pb_adv_unreg(prov);
> 
>  	l_free(prov);
>  	prov = NULL;
> diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c index
> 669cf340d..d915f2aaf 100644
> --- a/mesh/prov-initiator.c
> +++ b/mesh/prov-initiator.c
> @@ -122,6 +122,8 @@ static void initiator_free(void)
> 
>  	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
> 
> +	pb_adv_unreg(prov);
> +
>  	l_free(prov);
>  	prov = NULL;
>  }
> --
> 2.20.1

