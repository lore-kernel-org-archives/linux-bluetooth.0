Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B946AC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9045821900
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 16:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCVQiv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:38:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:60709 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCVQiu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 12:38:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="125002781"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2019 09:38:50 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 22 Mar 2019 09:38:49 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.126]) with mapi id 14.03.0415.000;
 Fri, 22 Mar 2019 09:38:49 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [PATCH BlueZ] mesh: Fix adding model app key binding
Thread-Topic: [PATCH BlueZ] mesh: Fix adding model app key binding
Thread-Index: AQHU4FakGgflVz/WNUOEDMo7ikGBU6YX2n7w
Date:   Fri, 22 Mar 2019 16:38:49 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CAD9F61@ORSMSX103.amr.corp.intel.com>
References: <20190322022610.5047-1-inga.stotland@intel.com>
In-Reply-To: <20190322022610.5047-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmQzZGFhZjktMWNlYy00YTQxLTkwNjYtZTE4NTUxN2QyMjQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTU5hbmZudmQ1MzZGRXF0QkFWdEN0eU4xNk9YM3pETzZybjJIZzRrdStxSk5iZTVQbTJCaThUaVgzdjBzSitRTiJ9
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

patch applied

> -----Original Message-----
> From: Stotland, Inga
> Subject: [PATCH BlueZ] mesh: Fix adding model app key binding
> 
> This fixes the situation when a new app key binding is being added to a
> model and the list of bindings does not exist yet.
> If the list does not exist, it is created and the binding is added to it.
> 
> Also, remove unnecessary memory alloc check when model subscriptions are
> added.
> ---
>  mesh/model.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mesh/model.c b/mesh/model.c index 80c30edba..a632d80e1
> 100644
> --- a/mesh/model.c
> +++ b/mesh/model.c
> @@ -522,6 +522,9 @@ static void model_unbind_idx(struct mesh_node
> *node, struct mesh_model *mod,  static void model_bind_idx(struct
> mesh_node *node, struct mesh_model *mod,
>  								uint16_t idx)
>  {
> +	if (!mod->bindings)
> +		mod->bindings = l_queue_new();
> +
>  	l_queue_push_tail(mod->bindings, L_UINT_TO_PTR(idx));
> 
>  	l_debug("Add %4.4x to model %8.8x", idx, mod->id); @@ -689,8
> +692,6 @@ static int add_sub(struct mesh_net *net, struct mesh_model
> *mod,
> 
>  	if (!mod->subs)
>  		mod->subs = l_queue_new();
> -	if (!mod->subs)
> -		return MESH_STATUS_STORAGE_FAIL;
> 
>  	if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(grp)))
>  		/* Group already exists */
> --
> 2.17.2

