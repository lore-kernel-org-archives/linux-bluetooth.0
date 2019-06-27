Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F73C48BD6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 15:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677420656
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 15:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0PiT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:38:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:53161 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfF0PiT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 11:38:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 08:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="361198575"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2019 08:38:18 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Jun 2019 08:38:18 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.150]) with mapi id 14.03.0439.000;
 Thu, 27 Jun 2019 08:38:18 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ v3 2/2] mesh: Use current IV Index when relaying
Thread-Topic: [PATCH BlueZ v3 2/2] mesh: Use current IV Index when relaying
Thread-Index: AQHVLLum3Lk9ZQv0r0GsXMB/v28S/qavoLnQ
Date:   Thu, 27 Jun 2019 15:38:17 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CBB1464@ORSMSX103.amr.corp.intel.com>
References: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
 <20190627074043.22891-3-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190627074043.22891-3-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjZhMGU3NGUtYTFlYS00Y2YxLThkYTMtZjVlY2E0N2Q5NDU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiazV2UGpIZzMwc0Vmcm5ZV1FGYUx4cWRjT3VlbzJyM0t4MUZOUGhZTXFZdjkxTXhyRUtZaW8yS0cxK0wrbEZuZyJ9
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michal,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Michal Lowas-Rzechonek
> Sent: Thursday, June 27, 2019 12:41 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Gix, Brian <brian.gix@intel.com>
> Subject: [PATCH BlueZ v3 2/2] mesh: Use current IV Index when relaying
> 
> If we are in IV Update state, packets shall be transmitted using IV Index - 1,
> including relayed packets.
> ---
>  mesh/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mesh/net.c b/mesh/net.c
> index a5693f154..0a6ff8eac 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -2512,7 +2512,7 @@ static void net_rx(void *net_ptr, void *user_data)
>  	relay_advice = packet_received(net, key_id, iv_index,
>  							out, out_size, rssi);
>  	if (relay_advice > data->relay_advice) {
> -		data->iv_index = iv_index;
> +		data->iv_index = mesh_net_get_iv_index(net);

I don't think this is correct.  *relayed* packets must preserve the originators IV_Index...

At most, two different IV_Index values are considered valid at any time in the mesh.  Each node has it's own sense as to what the *Network* IV_Index is, and it shall accept that IV_Index, and 1 less...  With this difference reflected in the IVI bit of the first octet.

When acting as a relay, incoming messages must be one of these two settings to be recognized, but after decrementing TTL and re-encrypting, the IV_Index of the original sender must be preserved.  The iv_index is part of both the Network nonce and the Access layer nonce.  If a relay uses a different nonce than the originator (SRC), then the receiving DST device will be unable to decrypt the Access layer using the same nonce as the repackaged Network layer.



>  		data->relay_advice = relay_advice;
>  		data->key_id = key_id;
>  		data->net = net;
> --
> 2.19.1

