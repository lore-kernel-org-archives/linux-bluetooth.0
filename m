Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AFEC282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 20:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495AF217D6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 20:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfAVUum convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:50:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:54635 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfAVUum (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 15:50:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 12:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,508,1539673200"; 
   d="scan'208";a="313909325"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2019 12:50:42 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.140]) with mapi id 14.03.0415.000;
 Tue, 22 Jan 2019 12:50:41 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] mesh: Fix logic when cleaning up incomplete
 provisioning
Thread-Topic: [PATCH BlueZ] mesh: Fix logic when cleaning up incomplete
 provisioning
Thread-Index: AQHUr8OpBC96c4WKzEC+Qv2yJDAMXaW7yLPA
Date:   Tue, 22 Jan 2019 20:50:40 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D90E2DD@ORSMSX103.amr.corp.intel.com>
References: <20190119065318.9203-1-inga.stotland@intel.com>
In-Reply-To: <20190119065318.9203-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmVkZjFhM2EtN2E0ZS00OTQ5LWE4NzUtMTkyNDU3MTRlMzg3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaStIdk9iYkxOc1hHS2R4Z1l6UlUzbGhaSXJuMWNcL1BYclBiU05iais5aHlSdVdweFBYWFRaNkJKV1NBcGtFaVAifQ==
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
> Sent: Friday, January 18, 2019 10:53 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Gix, Brian <brian.gix@intel.com>; Stotland, Inga
> <inga.stotland@intel.com>
> Subject: [PATCH BlueZ] mesh: Fix logic when cleaning up incomplete
> provisioning
> 
> Do not call acceptor_cancel() if the provisioning has been completed, either
> fail or success. Acceptor automatically takes care of cleanup on completion,
> either successful or not.
> ---
>  mesh/mesh.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mesh/mesh.c b/mesh/mesh.c
> index a1c26e77c..881b6ed73 100644
> --- a/mesh/mesh.c
> +++ b/mesh/mesh.c
> @@ -354,8 +354,6 @@ static void free_pending_join_call(bool failed)
>  		l_dbus_remove_watch(dbus_get_bus(),
>  						join_pending->disc_watch);
> 
> -	acceptor_cancel(&mesh);
> -
>  	mesh_agent_remove(join_pending->agent);
> 
>  	if (failed) {
> @@ -375,11 +373,14 @@ void mesh_cleanup(void)
>  	mgmt_unref(mgmt_mesh);
> 
>  	if (join_pending) {
> -		/* The Join() call failed since it has not been completed */
> -		reply = dbus_error(join_pending->msg,
> MESH_ERROR_FAILED,
> +
> +		if (join_pending->msg) {
> +			reply = dbus_error(join_pending->msg,
> MESH_ERROR_FAILED,
>  							"Failed. Exiting");
> -		l_dbus_send(dbus_get_bus(), reply);
> +			l_dbus_send(dbus_get_bus(), reply);
> +		}
> 
> +		acceptor_cancel(&mesh);
>  		free_pending_join_call(true);
>  	}
> 
> @@ -428,6 +429,7 @@ static void prov_disc_cb(struct l_dbus *bus, void
> *user_data)
>  	if (join_pending->msg)
>  		l_dbus_message_unref(join_pending->msg);
> 
> +	acceptor_cancel(&mesh);
>  	join_pending->disc_watch = 0;
> 
>  	free_pending_join_call(true);
> --
> 2.17.2

