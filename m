Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FCDC0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211F420B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGATo3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:44:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:7357 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfGATo3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 15:44:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 12:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="186589526"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2019 12:44:14 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jul 2019 12:44:15 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.180]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 12:44:15 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: RE: [PATCH BlueZ 2/2] mesh: Register D-Bus management interface
Thread-Topic: [PATCH BlueZ 2/2] mesh: Register D-Bus management interface
Thread-Index: AQHVLYteDVrKNOM1e0mwB1SM8/Jqe6a2L5hw
Date:   Mon, 1 Jul 2019 19:44:14 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CBB5340@ORSMSX103.amr.corp.intel.com>
References: <20190628082734.18809-1-michal.lowas-rzechonek@silvair.com>
 <20190628082734.18809-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190628082734.18809-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjEzMmQ0MTktZDczMy00ZWIxLWI2NWEtYTNlOTFiMjJlYjU3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjlGZmN5K2kyVXFVRmpKMWxLdlwvV0JlaTE0Z01adVlXK0tDNGdhOFkrVW9iNVZVd1E2c0JYd2hFMDF3dENtQmEifQ==
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Applied, Thanks.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Michal Lowas-Rzechonek
> Sent: Friday, June 28, 2019 1:28 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Stotland, Inga <inga.stotland@intel.com>
> Subject: [PATCH BlueZ 2/2] mesh: Register D-Bus management interface
> 
> When application Attach()es itself, start exposing both Node1 and
> Management1 D-Bus interfaces.
> ---
>  mesh/node.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/mesh/node.c b/mesh/node.c
> index 45383b7d5..a2ac747a1 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -259,9 +259,14 @@ static void free_node_resources(void *data)
>  	if (node->disc_watch)
>  		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
> 
> -	if (node->path)
> +	if (node->path) {
>  		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
> 
> 	MESH_NODE_INTERFACE);
> +
> +		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
> +
> MESH_MANAGEMENT_INTERFACE);
> +	}
> +
>  	l_free(node->path);
> 
>  	l_free(node);
> @@ -434,6 +439,7 @@ void node_cleanup_all(void)  {
>  	l_queue_destroy(nodes, cleanup_node);
>  	l_dbus_unregister_interface(dbus_get_bus(),
> MESH_NODE_INTERFACE);
> +	l_dbus_unregister_interface(dbus_get_bus(),
> +MESH_MANAGEMENT_INTERFACE);
>  }
> 
>  bool node_is_provisioned(struct mesh_node *node) @@ -1024,7 +1030,11
> @@ static bool register_node_object(struct mesh_node *node)
>  								"%s", uuid);
> 
>  	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
> -					MESH_NODE_INTERFACE, node))
> +						MESH_NODE_INTERFACE,
> node))
> +		return false;
> +
> +	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
> +					MESH_MANAGEMENT_INTERFACE,
> node))
>  		return false;
> 
>  	return true;
> @@ -1046,6 +1056,9 @@ static void app_disc_cb(struct l_dbus *bus, void
> *user_data)
>  	if (node->path) {
>  		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
> 
> 	MESH_NODE_INTERFACE);
> +
> +		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
> +
> 	MESH_MANAGEMENT_INTERFACE);
>  		l_free(node->app_path);
>  		node->app_path = NULL;
>  	}
> --
> 2.19.1

