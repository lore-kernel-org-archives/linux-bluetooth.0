Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7F9C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E6920830
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfDJPxZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:53:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:46046 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbfDJPxY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Apr 2019 11:53:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 08:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="163109530"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2019 08:53:23 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 10 Apr 2019 08:53:23 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.86]) with mapi id 14.03.0415.000;
 Wed, 10 Apr 2019 08:53:23 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] mesh: Create and store random token per node
Thread-Topic: [PATCH BlueZ] mesh: Create and store random token per node
Thread-Index: AQHU6zfSCUuskt4eWUe+S//3GBneKqY1lHeA
Date:   Wed, 10 Apr 2019 15:53:22 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CAF5D3E@ORSMSX103.amr.corp.intel.com>
References: <20190404224314.10694-1-brian.gix@intel.com>
In-Reply-To: <20190404224314.10694-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTY5MWY1NTgtMTBmNi00YjMxLWEyOTYtN2Q2YTczMzE4NDVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGF5U0FMVXpHaitwMVwvTlwvY1I4RWNTTWs1SjVzWTNLeVMrTGpQamtWYk1FWmpBWjgxNXZWbCszQ21kN1BxQzBcLyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> -----Original Message-----
> From: Gix, Brian
> Sent: Thursday, April 4, 2019 3:43 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Gix, Brian <brian.gix@intel.com>
> Subject: [PATCH BlueZ] mesh: Create and store random token per node
> 
> Fix issue with device key being used as a token. Token now seperate, and
> with a portable representation in the node database.
> ---
>  mesh/mesh-db.c | 38 ++++++++++++++++++++++++++++++++++++++
>  mesh/mesh-db.h |  2 ++
>  mesh/mesh.c    |  6 +++---
>  mesh/node.c    | 22 ++++++++++++++++++++--
>  mesh/node.h    |  2 ++
>  mesh/storage.c |  5 +++++
>  6 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c index f1bf8d8fa..64e33cd91
> 100644
> --- a/mesh/mesh-db.c
> +++ b/mesh/mesh-db.c
> @@ -51,6 +51,21 @@ static bool get_int(json_object *jobj, const char
> *keyword, int *value)
>  	return true;
>  }
> 
> +static bool add_u64_value(json_object *jobject, const char *desc,
> +					const uint8_t u64[8])
> +{
> +	json_object *jstring;
> +	char hexstr[17];
> +
> +	hex2str((uint8_t *) u64, 8, hexstr, 17);
> +	jstring = json_object_new_string(hexstr);
> +	if (!jstring)
> +		return false;
> +
> +	json_object_object_add(jobject, desc, jstring);
> +	return true;
> +}
> +
>  static bool add_key_value(json_object *jobject, const char *desc,
>  					const uint8_t key[16])
>  {
> @@ -257,6 +272,24 @@ bool mesh_db_read_iv_index(json_object *jobj,
> uint32_t *idx, bool *update)
>  	return true;
>  }
> 
> +bool mesh_db_read_token(json_object *jobj, uint8_t token[8]) {
> +	json_object *jvalue;
> +	char *str;
> +
> +	if (!token)
> +		return false;
> +
> +	if (!json_object_object_get_ex(jobj, "token", &jvalue))
> +		return false;
> +
> +	str = (char *)json_object_get_string(jvalue);
> +	if (!str2hex(str, strlen(str), token, 8))
> +		return false;
> +
> +	return true;
> +}
> +
>  bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])  {
>  	json_object *jvalue;
> @@ -515,6 +548,11 @@ bool mesh_db_write_device_key(json_object
> *jnode, uint8_t *key)
>  	return add_key_value(jnode, "deviceKey", key);  }
> 
> +bool mesh_db_write_token(json_object *jnode, uint8_t *token) {
> +	return add_u64_value(jnode, "token", token); }
> +
>  bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t
> app_idx,
>  							const uint8_t key[16])
>  {
> diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h index b9af1203b..06aba1f31
> 100644
> --- a/mesh/mesh-db.h
> +++ b/mesh/mesh-db.h
> @@ -104,6 +104,7 @@ bool mesh_db_read_node(json_object *jobj,
> mesh_db_node_cb cb, void *user_data);  bool
> mesh_db_add_node(json_object *jnode, struct mesh_db_node *node);
> bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool
> *update);  bool mesh_db_read_device_key(json_object *jobj, uint8_t
> key_buf[16]);
> +bool mesh_db_read_token(json_object *jobj, uint8_t token[8]);
>  bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
>  							uint16_t *interval);
>  bool mesh_db_write_net_transmit(json_object *jobj, uint8_t cnt, @@ -
> 113,6 +114,7 @@ bool mesh_db_read_net_keys(json_object *jobj,
> mesh_db_net_key_cb cb,  bool mesh_db_read_app_keys(json_object
> *jobj, mesh_db_app_key_cb cb,
>  							void *user_data);
>  bool mesh_db_write_device_key(json_object *jobj, uint8_t *key);
> +bool mesh_db_write_token(json_object *jobj, uint8_t *token);
>  bool mesh_db_write_network_key(json_object *jobj, uint16_t idx, uint8_t
> *key,
>  						uint8_t *new_key, int
> phase);
>  bool mesh_db_write_app_key(json_object *jobj, uint16_t net_idx, diff --git
> a/mesh/mesh.c b/mesh/mesh.c index a0a9a7c8e..e7eef0473 100644
> --- a/mesh/mesh.c
> +++ b/mesh/mesh.c
> @@ -487,7 +487,7 @@ static bool prov_complete_cb(void *user_data,
> uint8_t status,
>  	struct l_dbus_message *msg;
>  	const char *owner;
>  	const char *path;
> -	const uint8_t *dev_key;
> +	const uint8_t *token;
> 
>  	l_debug("Provisioning complete %s", prov_status_str(status));
> 
> @@ -506,13 +506,13 @@ static bool prov_complete_cb(void *user_data,
> uint8_t status,
>  		return false;
>  	}
> 
> -	dev_key = node_get_device_key(join_pending->node);
> +	token = node_get_token(join_pending->node);
> 
>  	msg = l_dbus_message_new_method_call(dbus, owner, path,
> 
> 	MESH_APPLICATION_INTERFACE,
>  						"JoinComplete");
> 
> -	l_dbus_message_set_arguments(msg, "t", l_get_u64(dev_key));
> +	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
> 
>  	l_dbus_send(dbus_get_bus(), msg);
> 
> diff --git a/mesh/node.c b/mesh/node.c
> index 79221b5e2..dae9a4b79 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -91,6 +91,7 @@ struct mesh_node {
>  	} relay;
>  	uint8_t dev_uuid[16];
>  	uint8_t dev_key[16];
> +	uint8_t token[8];
>  	uint8_t num_ele;
>  	uint8_t ttl;
>  	uint8_t lpn;
> @@ -132,7 +133,7 @@ static bool match_token(const void *a, const void *b)
> {
>  	const struct mesh_node *node = a;
>  	const uint64_t *token = b;
> -	const uint64_t tmp = l_get_u64(node->dev_key);
> +	const uint64_t tmp = l_get_be64(node->token);
> 
>  	return *token == tmp;
>  }
> @@ -453,6 +454,19 @@ const uint8_t *node_get_device_key(struct
> mesh_node *node)
>  		return node->dev_key;
>  }
> 
> +void node_set_token(struct mesh_node *node, uint8_t token[8]) {
> +	memcpy(node->token, token, 8);
> +}
> +
> +const uint8_t *node_get_token(struct mesh_node *node) {
> +	if (!node)
> +		return NULL;
> +	else
> +		return node->token;
> +}
> +
>  uint8_t node_get_num_elements(struct mesh_node *node)  {
>  	return node->num_ele;
> @@ -1059,7 +1073,7 @@ static void get_managed_objects_attach_cb(struct
> l_dbus_message *msg,
>  	struct attach_obj_request *req = user_data;
>  	struct mesh_node *node = req->node;
>  	const char *path;
> -	uint64_t token = l_get_u64(node->dev_key);
> +	uint64_t token = l_get_be64(node->token);
>  	uint8_t num_ele;
> 
>  	if (l_dbus_message_is_error(msg)) {
> @@ -1748,6 +1762,10 @@ bool node_add_pending_local(struct mesh_node
> *node, void *prov_node_info,
>  	node->primary = info->unicast;
>  	mesh_net_register_unicast(node->net, info->unicast, node-
> >num_ele);
> 
> +	l_getrandom(node->token, sizeof(node->token));
> +	if (!mesh_db_write_token(node->jconfig, node->token))
> +		return false;
> +
>  	memcpy(node->dev_key, info->device_key, 16);
>  	if (!mesh_db_write_device_key(node->jconfig, info->device_key))
>  		return false;
> diff --git a/mesh/node.h b/mesh/node.h
> index 954dfca75..ebc82ffb8 100644
> --- a/mesh/node.h
> +++ b/mesh/node.h
> @@ -47,6 +47,8 @@ bool node_app_key_delete(struct mesh_net *net,
> uint16_t addr,
>  				uint16_t net_idx, uint16_t idx);
>  uint16_t node_get_primary(struct mesh_node *node);  uint16_t
> node_get_primary_net_idx(struct mesh_node *node);
> +void node_set_token(struct mesh_node *node, uint8_t token[8]); const
> +uint8_t *node_get_token(struct mesh_node *node);
>  void node_set_device_key(struct mesh_node *node, uint8_t key[16]);
> const uint8_t *node_get_device_key(struct mesh_node *node);  void
> node_set_num_elements(struct mesh_node *node, uint8_t num_ele); diff
> --git a/mesh/storage.c b/mesh/storage.c index f04e3ec89..8a70b5696 100644
> --- a/mesh/storage.c
> +++ b/mesh/storage.c
> @@ -156,6 +156,11 @@ static bool parse_node(struct mesh_node *node,
> json_object *jnode)
>  	if (!mesh_db_read_net_keys(jnode, read_net_keys_cb, net))
>  		return false;
> 
> +	if (!mesh_db_read_token(jnode, key_buf))
> +		return false;
> +
> +	node_set_token(node, key_buf);
> +
>  	if (!mesh_db_read_device_key(jnode, key_buf))
>  		return false;
> 
> --
> 2.14.5

Applied
