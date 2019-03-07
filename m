Return-Path: <SRS0=Hm6j=RK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9A1C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDF920675
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 21:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCGVNF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:13:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:24086 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfCGVNE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Mar 2019 16:13:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 13:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,453,1544515200"; 
   d="scan'208";a="325216050"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2019 13:13:03 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.106]) with mapi id 14.03.0415.000;
 Thu, 7 Mar 2019 13:13:02 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: RE: [PATCH BlueZ] mesh: Fix array processing in Send, Publish, Join
Thread-Topic: [PATCH BlueZ] mesh: Fix array processing in Send, Publish, Join
Thread-Index: AQHU0Inz4XNjlrdtnU2nqaU0rRb54aYAs/JQ
Date:   Thu, 7 Mar 2019 21:13:02 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CAB9156@ORSMSX101.amr.corp.intel.com>
References: <20190301235315.12770-1-inga.stotland@intel.com>
In-Reply-To: <20190301235315.12770-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNThmMDA2ZmQtZDlhNS00YzdkLTlkZmMtYTRiMTJjMzliZTlmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUUhWUkQ0ajY2RlkybkRuZ0ZPVkRzSVFnd0VQQ08rME5UNUN6YjBFSDVVeGtKRU54MlVReXBLcWRtWURlNGNRcSJ9
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

applied

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Inga Stotland
> Sent: Friday, March 1, 2019 3:53 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Gix, Brian <brian.gix@intel.com>; johan.hedberg@gmail.com;
> luiz.dentz@gmail.com; Stotland, Inga <inga.stotland@intel.com>
> Subject: [PATCH BlueZ] mesh: Fix array processing in Send, Publish, Join
> 
> Use correct parameters when calling
> l_dbus_message_iter_get_fixed_array().
> Also, check the return value and the length of the processed array and return
> an error if the checks fail.
> ---
>  mesh/mesh.c | 11 ++++-------
>  mesh/node.c | 26 +++++++++++++-------------
>  2 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/mesh/mesh.c b/mesh/mesh.c
> index 8db83b7c3..a0a9a7c8e 100644
> --- a/mesh/mesh.c
> +++ b/mesh/mesh.c
> @@ -73,7 +73,7 @@ struct join_data{
>  	const char *app_path;
>  	struct mesh_node *node;
>  	uint32_t disc_watch;
> -	uint8_t uuid[16];
> +	uint8_t *uuid;
>  };
> 
>  struct attach_data {
> @@ -561,7 +561,6 @@ static struct l_dbus_message
> *join_network_call(struct l_dbus *dbus,  {
>  	const char *app_path, *sender;
>  	struct l_dbus_message_iter iter_uuid;
> -	uint8_t *uuid;
>  	uint32_t n;
> 
>  	l_debug("Join network request");
> @@ -576,17 +575,15 @@ static struct l_dbus_message
> *join_network_call(struct l_dbus *dbus,
> 
>  	join_pending = l_new(struct join_data, 1);
> 
> -	l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n);
> -
> -	if (n != 16) {
> +	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid,
> +						&join_pending->uuid, &n)
> +								|| n != 16) {
>  		l_free(join_pending);
>  		join_pending = NULL;
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
>  							"Bad device UUID");
>  	}
> 
> -	memcpy(join_pending->uuid, uuid, 16);
> -
>  	sender = l_dbus_message_get_sender(msg);
> 
>  	join_pending->sender = l_strdup(sender); diff --git a/mesh/node.c
> b/mesh/node.c index 6a7b4a260..761a67af4 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -1537,7 +1537,7 @@ static struct l_dbus_message *send_call(struct
> l_dbus *dbus,
>  	struct l_dbus_message_iter iter_data;
>  	struct node_element *ele;
>  	uint16_t dst, app_idx, src;
> -	uint8_t data[MESH_MAX_ACCESS_PAYLOAD];
> +	uint8_t *data;
>  	uint32_t len;
>  	struct l_dbus_message *reply;
> 
> @@ -1559,10 +1559,10 @@ static struct l_dbus_message *send_call(struct
> l_dbus *dbus,
> 
>  	src = node_get_primary(node) + ele->idx;
> 
> -	l_dbus_message_iter_get_fixed_array(&iter_data, data, &len);
> -	if (!len)
> +	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len)
> ||
> +					!len || len >
> MESH_MAX_ACCESS_PAYLOAD)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
> -						"Mesh message is empty");
> +							"Incorrect data");
> 
>  	if (!mesh_model_send(node, src, dst, app_idx,
>  				mesh_net_get_default_ttl(node->net), data,
> len)) @@ -1583,7 +1583,7 @@ static struct l_dbus_message
> *publish_call(struct l_dbus *dbus,
>  	struct l_dbus_message_iter iter_data;
>  	uint16_t mod_id, src;
>  	struct node_element *ele;
> -	uint8_t data[MESH_MAX_ACCESS_PAYLOAD];
> +	uint8_t *data;
>  	uint32_t len;
>  	struct l_dbus_message *reply;
>  	int result;
> @@ -1606,10 +1606,10 @@ static struct l_dbus_message *publish_call(struct
> l_dbus *dbus,
> 
>  	src = node_get_primary(node) + ele->idx;
> 
> -	l_dbus_message_iter_get_fixed_array(&iter_data, data, &len);
> -	if (!len)
> +	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len)
> ||
> +					!len || len >
> MESH_MAX_ACCESS_PAYLOAD)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
> -						"Mesh message is empty");
> +							"Incorrect data");
> 
>  	result = mesh_model_publish(node, VENDOR_ID_MASK | mod_id,
> src,
>  				mesh_net_get_default_ttl(node->net), data,
> len); @@ -1634,7 +1634,7 @@ static struct l_dbus_message
> *vendor_publish_call(struct l_dbus *dbus,
>  	uint16_t model_id, vendor;
>  	uint32_t vendor_mod_id;
>  	struct node_element *ele;
> -	uint8_t data[MESH_MAX_ACCESS_PAYLOAD];
> +	uint8_t *data = NULL;
>  	uint32_t len;
>  	struct l_dbus_message *reply;
>  	int result;
> @@ -1657,10 +1657,10 @@ static struct l_dbus_message
> *vendor_publish_call(struct l_dbus *dbus,
> 
>  	src = node_get_primary(node) + ele->idx;
> 
> -	l_dbus_message_iter_get_fixed_array(&iter_data, data, &len);
> -	if (!len)
> +	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len)
> ||
> +					!len || len >
> MESH_MAX_ACCESS_PAYLOAD)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
> -						"Mesh message is empty");
> +							"Incorrect data");
> 
>  	vendor_mod_id = (vendor << 16) | model_id;
>  	result = mesh_model_publish(node, vendor_mod_id, src, @@ -
> 1686,7 +1686,7 @@ static void setup_node_interface(struct l_dbus_interface
> *iface)
>  						"", "oqqay", "element_path",
>  						"vendor", "model_id",
> "data");
> 
> -	/*TODO: Properties */
> +	/* TODO: Properties */
>  }
> 
>  bool node_dbus_init(struct l_dbus *bus)
> --
> 2.17.2

