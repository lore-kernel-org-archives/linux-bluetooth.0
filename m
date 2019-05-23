Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3434EC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122FD2186A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfEWR6P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 13:58:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:58153 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731239AbfEWR6P (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 13:58:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 10:58:15 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2019 10:58:14 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 23 May 2019 10:58:14 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.150]) with mapi id 14.03.0415.000;
 Thu, 23 May 2019 10:58:14 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: RE: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
Thread-Topic: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
Thread-Index: AQHVEZBzEH3OQE0cFU+dUfs5UeuEwaZ4/rtw
Date:   Thu, 23 May 2019 17:58:13 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CB5FA78@ORSMSX103.amr.corp.intel.com>
References: <20190523175321.13094-1-brian.gix@intel.com>
In-Reply-To: <20190523175321.13094-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzcwZTUxZTItMzQ5NS00MjQxLTgwNTYtZTBhYzgwNDZlYzAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaG8zYVRpTlwvZnRSWitqRXJ4N3BpXC9cL3djU2xSZm5pOUFJMkdoaXpjUTFodnFqZmdFZ01TRmNtU0VHTjc0eTQ3ayJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub and Michal,

If you have no objections, this will be the version of the Long MIC patch I will be applying.

> -----Original Message-----
> From: Gix, Brian
> Sent: Thursday, May 23, 2019 10:53 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Stotland, Inga <inga.stotland@intel.com>; Gix, Brian
> <brian.gix@intel.com>; jakub.witowski@silvair.com; michal.lowas-
> rzechonek@silvair.com
> Subject: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
> 
> From: Jakub Witowski <jakub.witowski@silvair.com>
> 
> Contrary to the comment, implementation used a 8-byte MIC even if this
> generated an additional segment.
> ---
>  mesh/model.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mesh/model.c b/mesh/model.c index 034d54496..90bb62db8
> 100644
> --- a/mesh/model.c
> +++ b/mesh/model.c
> @@ -40,6 +40,9 @@
>  #include "mesh/util.h"
>  #include "mesh/model.h"
> 
> +/* Divide and round to ceiling (up) to calculate segment count */
> +#define CEILDIV(val, div) (((val) + (div) - 1) / (div))
> +
>  struct mesh_model {
>  	const struct mesh_model_ops *cbs;
>  	void *user_data;
> @@ -451,7 +454,7 @@ static bool msg_send(struct mesh_node *node, bool
> credential, uint16_t src,
> 
>  	/* Use large MIC if it doesn't affect segmentation */
>  	if (msg_len > 11 && msg_len <= 376) {
> -		if ((out_len / 12) == ((out_len + 4) / 12)) {
> +		if (CEILDIV(out_len, 12) == CEILDIV(out_len + 4, 12)) {
>  			szmic = true;
>  			out_len = msg_len + sizeof(uint64_t);
>  		}
> --
> 2.14.5

