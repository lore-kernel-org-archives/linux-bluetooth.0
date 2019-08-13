Return-Path: <SRS0=11T+=WJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809AC32750
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Aug 2019 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9520665
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Aug 2019 21:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfHMVZf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:25:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:34911 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHMVZe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Aug 2019 17:25:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="167181654"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2019 14:25:34 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 13 Aug 2019 14:25:34 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.225]) with mapi id 14.03.0439.000;
 Tue, 13 Aug 2019 14:25:33 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Rafal Gajda <rafal.gajda@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] mesh: Remove double initialisation and fix typo
 in log
Thread-Topic: [PATCH BlueZ] mesh: Remove double initialisation and fix typo
 in log
Thread-Index: AQHVUQaHevUThiNqWkK12yerPp9wFKb5mSLA
Date:   Tue, 13 Aug 2019 21:25:33 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CBF84FA@ORSMSX101.amr.corp.intel.com>
References: <20190812120656.29494-1-rafal.gajda@silvair.com>
In-Reply-To: <20190812120656.29494-1-rafal.gajda@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGI0NzJjNTktY2QwNi00ZTUxLWIzMWYtZmI1MzY1MTYxNjdhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaXR0Y3NcLzkxXC9qZm9seVRFM1hCbnlNWUlabW1keXRvdTZlZ2VNVlwvVlZPMlVhT2lOc3lVVk5LanpSXC8wSlhRMjgifQ==
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Your two patches applied.... Thanks

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Rafal Gajda
> Sent: Monday, August 12, 2019 5:07 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH BlueZ] mesh: Remove double initialisation and fix typo in log
> 
> ---
>  mesh/node.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mesh/node.c b/mesh/node.c
> index e7e58d9a7..f8b1099e9 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -475,7 +475,6 @@ static bool init_from_storage(struct mesh_config_node
> *db_node,
>  	node->lpn = db_node->modes.lpn;
> 
>  	node->proxy = db_node->modes.proxy;
> -	node->lpn = db_node->modes.lpn;
>  	node->friend = db_node->modes.friend;
>  	node->relay.mode = db_node->modes.relay.state;
>  	node->relay.cnt = db_node->modes.relay.cnt; @@ -483,7 +482,7 @@
> static bool init_from_storage(struct mesh_config_node *db_node,
>  	node->beacon = db_node->modes.beacon;
> 
>  	l_debug("relay %2.2x, proxy %2.2x, lpn %2.2x, friend %2.2x",
> -			node->relay.mode, node->proxy, node->friend, node-
> >lpn);
> +			node->relay.mode, node->proxy, node->lpn, node-
> >friend);
>  	node->ttl = db_node->ttl;
>  	node->seq_number = db_node->seq_number;
> 
> --
> 2.22.0

