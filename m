Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7761C76191
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 03:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC13722BF5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 03:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfGZD6e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:58:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:17573 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfGZD6e (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 23:58:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 20:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,309,1559545200"; 
   d="p7s'?scan'208";a="164452583"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2019 20:58:32 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 25 Jul 2019 20:58:32 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.63]) with mapi id 14.03.0439.000;
 Thu, 25 Jul 2019 20:58:32 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v4 2/5] mesh: Validate application by comparing
 composition data
Thread-Topic: [PATCH BlueZ v4 2/5] mesh: Validate application by comparing
 composition data
Thread-Index: AQHVQyIfSzYHUpDUj0WK/hAA8uKzcqbcu9oA
Date:   Fri, 26 Jul 2019 03:58:31 +0000
Message-ID: <95d9c217acc327860dc72f53bcab03d6439acf76.camel@intel.com>
References: <20190725194933.7321-1-michal.lowas-rzechonek@silvair.com>
         <20190725194933.7321-3-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190725194933.7321-3-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.179.196]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-AFCwfhuBfqULl85MggZN"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-AFCwfhuBfqULl85MggZN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Thu, 2019-07-25 at 21:49 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> Instead of validating application by enumerating D-Bus objects,
> create a
> temporary node instance and check if composition data generated for
> the
> temporary matches the node loaded from storage.
>=20
> This allows node validation logic (primary element, mandatory models
> etc)
> to be confined in node_generate_comp() function.
>=20
> This also streamlines code implementing Attach(), Join() and
> CreateNetwork() calls.
> ---
>  mesh/mesh-defs.h |   2 +
>  mesh/node.c      | 434 +++++++++++++++++++++----------------------
> ----
>  2 files changed, 197 insertions(+), 239 deletions(-)
>=20
> diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
> index 82be91d75..d14aa5af3 100644
> --- a/mesh/mesh-defs.h
> +++ b/mesh/mesh-defs.h
> @@ -79,6 +79,8 @@
>  #define MAX_MODEL_COUNT		0xff
>  #define MAX_ELE_COUNT		0xff
> =20
> +#define MAX_MSG_LEN 380
> +
>  #define IS_UNASSIGNED(x)	((x) =3D=3D UNASSIGNED_ADDRESS)
>  #define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) &&
> \
>  					((x) < VIRTUAL_ADDRESS_LOW))
> diff --git a/mesh/node.c b/mesh/node.c
> index e51913edf..f824d6170 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -112,16 +112,16 @@ struct mesh_node {
>  };
> =20
>  struct managed_obj_request {
> -	union {
> -		const uint8_t *uuid;
> -		struct mesh_node *node;
> -	};
> +	struct mesh_node *node;
>  	union {
>  		node_ready_func_t ready_cb;
>  		node_join_ready_func_t join_ready_cb;
>  	};
>  	struct l_dbus_message *pending_msg;
>  	enum request_type type;
> +	union {
> +		struct mesh_node *attach;
> +	};
>  };
> =20
>  static struct l_queue *nodes;
> @@ -160,14 +160,6 @@ static bool match_element_idx(const void *a,
> const void *b)
>  	return (element->idx =3D=3D index);
>  }
> =20
> -static bool match_model_id(const void *a, const void *b)
> -{
> -	const struct mesh_model *mod =3D a;
> -	uint32_t mod_id =3D L_PTR_TO_UINT(b);
> -
> -	return mod_id =3D=3D mesh_model_get_model_id(mod);
> -}
> -
>  static bool match_element_path(const void *a, const void *b)
>  {
>  	const struct node_element *element =3D a;
> @@ -212,11 +204,6 @@ static struct mesh_node *node_new(const uint8_t
> uuid[16])
>  	node->net =3D mesh_net_new(node);
>  	memcpy(node->uuid, uuid, sizeof(node->uuid));
> =20
> -	if (!nodes)
> -		nodes =3D l_queue_new();
> -
> -	l_queue_push_tail(nodes, node);
> -
>  	return node;
>  }
> =20
> @@ -412,6 +399,11 @@ static bool init_from_storage(struct
> mesh_config_node *db_node,
> =20
>  	struct mesh_node *node =3D node_new(uuid);
> =20
> +	if (!nodes)
> +		nodes =3D l_queue_new();
> +
> +	l_queue_push_tail(nodes, node);
> +
>  	node->comp =3D l_new(struct node_composition, 1);
>  	node->comp->cid =3D db_node->cid;
>  	node->comp->pid =3D db_node->pid;
> @@ -436,7 +428,7 @@ static bool init_from_storage(struct
> mesh_config_node *db_node,
>  	memcpy(node->token, db_node->token, 8);
> =20
>  	num_ele =3D l_queue_length(db_node->elements);
> -	if (num_ele > 0xff)
> +	if (num_ele > MAX_ELE_COUNT)
>  		goto fail;
> =20
>  	node->num_ele =3D num_ele;
> @@ -1140,58 +1132,6 @@ static void app_disc_cb(struct l_dbus *bus,
> void *user_data)
>  	free_node_dbus_resources(node);
>  }
> =20
> -static bool validate_model_property(struct node_element *ele,
> -					struct l_dbus_message_iter
> *property,
> -					uint8_t *num_models, bool
> vendor)
> -{
> -	struct l_dbus_message_iter ids;
> -	uint16_t mod_id, vendor_id;
> -	uint8_t count;
> -	const char *signature =3D !vendor ? "aq" : "a(qq)";
> -
> -	if (!l_dbus_message_iter_get_variant(property, signature,
> &ids)) {
> -		/* Allow empty elements */
> -		if (l_queue_length(ele->models) =3D=3D 0) {
> -			*num_models =3D 0;
> -			return true;
> -		} else
> -			return false;
> -	}
> -
> -	count =3D 0;
> -	if (!vendor) {
> -		/* Bluetooth SIG defined models */
> -		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
> -			struct mesh_model *mod;
> -
> -			/* Skip internally implemented models */
> -			if ((VENDOR_ID_MASK | mod_id) =3D=3D
> CONFIG_SRV_MODEL)
> -				continue;
> -
> -			mod =3D l_queue_find(ele->models, match_model_id,
> -					L_UINT_TO_PTR(VENDOR_ID_MASK |
> mod_id));
> -			if (!mod)
> -				return false;
> -			count++;
> -		}
> -	} else {
> -		/* Vendor defined models */
> -		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
> -								&mod_id
> )) {
> -			struct mesh_model *mod;
> -
> -			mod =3D l_queue_find(ele->models, match_model_id,
> -				L_UINT_TO_PTR((vendor_id << 16) |
> mod_id));
> -			if (!mod)
> -				return false;
> -			count++;
> -		}
> -	}
> -
> -	*num_models =3D count;
> -	return true;
> -}
> -
>  static void get_models_from_properties(struct node_element *ele,
>  					struct l_dbus_message_iter
> *property,
>  								bool
> vendor)
> @@ -1231,94 +1171,60 @@ static void get_models_from_properties(struct
> node_element *ele,
>  }
> =20
>  static bool get_element_properties(struct mesh_node *node, const
> char *path,
> -					struct l_dbus_message_iter
> *properties,
> -								bool
> is_new)
> +					struct l_dbus_message_iter
> *properties)
>  {
> -	struct node_element *ele;
> +	struct node_element *ele =3D l_new(struct node_element, 1);
>  	const char *key;
>  	struct l_dbus_message_iter var;
> -	bool have_index =3D false;
> -	uint8_t idx, mod_cnt, vendor_cnt;
> +	bool idx =3D false;
> +	bool mods =3D false;
> +	bool vendor_mods =3D false;
> =20
>  	l_debug("path %s", path);
> =20
> +	ele->location =3D DEFAULT_LOCATION;
> +
>  	while (l_dbus_message_iter_next_entry(properties, &key, &var))
> {
> -		if (!strcmp(key, "Index")) {
> -			if (!l_dbus_message_iter_get_variant(&var, "y",
> &idx))
> -				return false;
> -			have_index =3D true;
> -			break;
> +		if (!idx && !strcmp(key, "Index")) {
> +			if (!l_dbus_message_iter_get_variant(&var, "y",
> +								&ele-
> >idx))
> +				goto fail;
> +			idx =3D true;
> +			continue;
>  		}
> -	}
> -
> -	if (!have_index) {
> -		l_debug("Mandatory property \"Index\" not found");
> -		return false;
> -	}
> =20
> -	if (!is_new) {
> -		/* Validate composition: check the element index */
> -		ele =3D l_queue_find(node->elements, match_element_idx,
> -							L_UINT_TO_PTR(i
> dx));
> -		if (!ele) {
> -			l_debug("Element with index %u not found",
> idx);
> -			return false;
> +		if (!mods && !strcmp(key, "Models")) {
> +			get_models_from_properties(ele, &var, false);
> +			mods =3D true;
> +			continue;
>  		}
> -	} else {
> -		ele =3D l_new(struct node_element, 1);
> -		ele->location =3D DEFAULT_LOCATION;
> -		ele->idx =3D idx;
> -	}
> =20
> -	mod_cnt =3D 0;
> -	vendor_cnt =3D 0;
> +		if (!vendor_mods && !strcmp(key, "VendorModels")) {
> +			get_models_from_properties(ele, &var, true);
> +			vendor_mods =3D true;
> +			continue;
> +		}
> =20
> -	while (l_dbus_message_iter_next_entry(properties, &key, &var))
> {
>  		if (!strcmp(key, "Location")) {
> -			uint16_t loc;
> -
> -			l_dbus_message_iter_get_variant(&var, "q",
> &loc);
> -
> -			/* Validate composition: location match */
> -			if (!is_new && (ele->location !=3D loc))
> -				return false;
> -
> -			ele->location =3D loc;
> -
> -		} else if (!strcmp(key, "Models")) {
> -
> -			if (is_new)
> -				get_models_from_properties(ele, &var,
> false);
> -			else if (!validate_model_property(ele, &var,
> &mod_cnt,
> -								=09
> false))
> -				return false;
> -
> -		} else if (!strcmp(key, "VendorModels")) {
> -
> -			if (is_new)
> -				get_models_from_properties(ele, &var,
> true);
> -			else if (!validate_model_property(ele, &var,
> -							&vendor_cnt,
> true))
> -				return false;
> -
> +			if (!l_dbus_message_iter_get_variant(&var, "q",
> +							&ele-
> >location))
> +				goto fail;
> +			continue;
>  		}
>  	}
> =20
> -	if (is_new) {
> -		l_queue_push_tail(node->elements, ele);
> -	} else {
> -		/* Account for internal Configuration Server model */
> -		if (idx =3D=3D 0)
> -			mod_cnt +=3D 1;
> +	if (!idx || !mods || !vendor_mods)
> +		goto fail;
> =20
> -		/* Validate composition: number of models must match */
> -		if (l_queue_length(ele->models) !=3D (mod_cnt +
> vendor_cnt))
> -			return false;
> +	l_queue_push_tail(node->elements, ele);
> =20
> -		ele->path =3D l_strdup(path);
> -	}
> +	ele->path =3D l_strdup(path);
> =20
>  	return true;
> +fail:
> +	l_free(ele);
> +
> +	return false;
>  }
> =20
>  static void convert_node_to_storage(struct mesh_node *node,
> @@ -1415,65 +1321,61 @@ static void set_defaults(struct mesh_node
> *node)
>  }
> =20
>  static bool get_app_properties(struct mesh_node *node, const char
> *path,
> -					struct l_dbus_message_iter
> *properties,
> -								bool
> is_new)
> +					struct l_dbus_message_iter
> *properties)
>  {
>  	const char *key;
>  	struct l_dbus_message_iter variant;
> -	uint16_t value;
> +	bool cid =3D false;
> +	bool pid =3D false;
> +	bool vid =3D false;
> =20
>  	l_debug("path %s", path);
> =20
> -	if (is_new) {
> -		node->comp =3D l_new(struct node_composition, 1);
> -		node->comp->crpl =3D DEFAULT_CRPL;
> -	}
> +	node->comp =3D l_new(struct node_composition, 1);
> +	node->comp->crpl =3D DEFAULT_CRPL;
> =20
>  	while (l_dbus_message_iter_next_entry(properties, &key,
> &variant)) {
> -
> -		if (!strcmp(key, "CompanyID")) {
> +		if (!cid && !strcmp(key, "CompanyID")) {
>  			if (!l_dbus_message_iter_get_variant(&variant,
> "q",
> -								=09
> &value))
> -				return false;
> -
> -			if (!is_new && node->comp->cid !=3D value)
> -				return false;
> -
> -			node->comp->cid =3D value;
> +							&node->comp-
> >cid))
> +				goto fail;
> +			cid =3D true;
> +			continue;
> +		}
> =20
> -		} else if (!strcmp(key, "ProductID")) {
> +		if (!pid && !strcmp(key, "ProductID")) {
>  			if (!l_dbus_message_iter_get_variant(&variant,
> "q",
> -								=09
> &value))
> -				return false;
> -
> -			if (!is_new && node->comp->pid !=3D value)
> -				return false;
> -
> -			node->comp->pid =3D value;
> +							&node->comp-
> >pid))
> +				goto fail;
> +			pid =3D true;
> +			continue;
> +		}
> =20
> -		} else if (!strcmp(key, "VersionID")) {
> +		if (!vid && !strcmp(key, "VersionID")) {
>  			if (!l_dbus_message_iter_get_variant(&variant,
> "q",
> -								=09
> &value))
> -				return false;
> -
> -			if (!is_new && node->comp->vid !=3D value)
> +							&node->comp-
> >vid))
>  				return false;
> +			vid =3D true;
> +			continue;
> +		}
> =20
> -			node->comp->vid =3D value;
> -
> -		} else if (!strcmp(key, "CRPL")) {
> +		if (!strcmp(key, "CRPL")) {
>  			if (!l_dbus_message_iter_get_variant(&variant,
> "q",
> -								=09
> &value))
> -				return false;
> -
> -			if (!is_new && node->comp->crpl !=3D value)
> -				return false;
> -
> -			node->comp->crpl =3D value;
> +							&node->comp-
> >crpl))
> +				goto fail;
> +			continue;
>  		}
>  	}
> =20
> +	if (!cid || !pid || !vid)
> +		goto fail;
> +
>  	return true;
> +fail:
> +	l_free(node->comp);
> +	node->comp =3D NULL;
> +
> +	return false;
>  }
> =20
>  static bool add_local_node(struct mesh_node *node, uint16_t unicast,
> bool kr,
> @@ -1552,18 +1454,83 @@ static bool init_storage_dir(struct mesh_node
> *node)
>  	return true;
>  }
> =20
> +static bool check_req_node(struct managed_obj_request *req)
> +{
> +	uint8_t node_comp[MAX_MSG_LEN - 2];
> +	uint8_t attach_comp[MAX_MSG_LEN - 2];
> +
> +	uint16_t node_len =3D node_generate_comp(req->node, node_comp,
> +							sizeof(node_com
> p));
> +
> +	if (!node_len)
> +		return false;
> +
> +	if (req->type =3D=3D REQUEST_TYPE_ATTACH) {
> +		uint16_t attach_len =3D node_generate_comp(req->attach,
> +					attach_comp,
> sizeof(attach_comp));
> +
> +		if (node_len !=3D attach_len ||
> +				memcmp(node_comp, attach_comp,
> node_len)) {
> +			l_debug("Failed to verify app's composition
> data");
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static struct mesh_node *attach_req_node(struct mesh_node *attach,
> +							struct
> mesh_node *node)
> +{
> +	const struct l_queue_entry *attach_entry;
> +	const struct l_queue_entry *node_entry;
> +
> +	attach_entry =3D l_queue_get_entries(attach->elements);
> +	node_entry =3D l_queue_get_entries(node->elements);
> +
> +	/*
> +	 * Update existing node with paths collected in temporary node,
> +	 * then remove the temporary.
> +	 * */

*/ on a separate line

> +	while (attach_entry && node_entry)
> +	{
> +		struct node_element *attach_ele =3D node_entry->data;

attach_ele =3D attach_entry->data

> +		struct node_element *node_ele =3D node_entry->data;
> +
> +		l_free(attach_ele->path);

I don't think we need l_free() here. The element path of the daemon-
owned node should be depopulated at this point. If this is not the
case, we have a logic hole somewhere.

> +		attach_ele->path =3D node_ele->path;
> +		node_ele->path =3D NULL;
> +
> +		attach_entry =3D attach_entry->next;
> +		node_entry =3D node_entry->next;
> +	}
> +
> +	mesh_agent_remove(attach->agent);
+	attach->agent =3D node->agent;
> +	node->agent =3D NULL;
> +
> +	attach->app_path =3D node->app_path;
> +	node->app_path =3D NULL;
> +
> +	attach->owner =3D node->owner;
> +	node->owner =3D NULL;
> +
> +	node_remove(node);
> +
> +	return attach;
> +}
> +
>  static void get_managed_objects_cb(struct l_dbus_message *msg, void
> *user_data)
>  {
>  	struct l_dbus_message_iter objects, interfaces;
>  	struct managed_obj_request *req =3D user_data;
>  	const char *path;
> -	struct mesh_node *node =3D NULL;
> +	struct mesh_node *node =3D req->node;
>  	void *agent =3D NULL;
>  	bool have_app =3D false;
> -	bool is_new;
> -	uint8_t num_ele;
> -
> -	is_new =3D (req->type !=3D REQUEST_TYPE_ATTACH);
> +	unsigned int num_ele;
> =20
>  	if (l_dbus_message_is_error(msg)) {
>  		l_error("Failed to get app's dbus objects");
> @@ -1575,14 +1542,8 @@ static void get_managed_objects_cb(struct
> l_dbus_message *msg, void *user_data)
>  		goto fail;
>  	}
> =20
> -	if (is_new) {
> -		node =3D l_new(struct mesh_node, 1);
> +	if (!node->elements)
>  		node->elements =3D l_queue_new();
> -	} else {
> -		node =3D req->node;
> -	}
> -
> -	num_ele =3D 0;
> =20
>  	while (l_dbus_message_iter_next_entry(&objects, &path,
> &interfaces)) {
>  		struct l_dbus_message_iter properties;
> @@ -1593,21 +1554,14 @@ static void get_managed_objects_cb(struct
> l_dbus_message *msg, void *user_data)
>  			bool res;
> =20
>  			if (!strcmp(MESH_ELEMENT_INTERFACE, interface))
> {
> -
> -				if (num_ele =3D=3D MAX_ELE_COUNT)
> -					goto fail;
> -
>  				res =3D get_element_properties(node,
> path,
> -							&properties,
> is_new);
> +								&proper
> ties);
>  				if (!res)
>  					goto fail;
> -
> -				num_ele++;
> -
>  			} else if (!strcmp(MESH_APPLICATION_INTERFACE,
>  								interfa
> ce)) {
>  				res =3D get_app_properties(node, path,
> -							&properties,
> is_new);
> +								&proper
> ties);
>  				if (!res)
>  					goto fail;
> =20
> @@ -1637,7 +1591,7 @@ static void get_managed_objects_cb(struct
> l_dbus_message *msg, void *user_data)
>  		goto fail;
>  	}
> =20
> -	if (num_ele =3D=3D 0) {
> +	if (l_queue_isempty(node->elements)) {
>  		l_error("Interface %s not found",
> MESH_ELEMENT_INTERFACE);
>  		goto fail;
>  	}
> @@ -1649,17 +1603,23 @@ static void get_managed_objects_cb(struct
> l_dbus_message *msg, void *user_data)
>  		goto fail;
>  	}
> =20
> +	set_defaults(node);
> +	num_ele =3D l_queue_length(node->elements);
> +
> +	if (num_ele > MAX_ELE_COUNT)
> +		goto fail;
> +
> +	node->num_ele =3D num_ele;
> +
> +	if (!check_req_node(req))
> +		goto fail;
> +
>  	if (req->type =3D=3D REQUEST_TYPE_ATTACH) {
> -		if (num_ele !=3D node->num_ele)
> -			goto fail;
> +		struct l_dbus *bus =3D dbus_get_bus();
> =20
> -		if (register_node_object(node)) {
> -			struct l_dbus *bus =3D dbus_get_bus();
> +		node =3D attach_req_node(req->attach, node);
> =20
> -			node->disc_watch =3D
> l_dbus_add_disconnect_watch(bus,
> -					node->owner, app_disc_cb, node,
> NULL);
> -			req->ready_cb(req->pending_msg,
> MESH_ERROR_NONE, node);
> -		} else
> +		if (!register_node_object(node))
>  			goto fail;
> =20
>  		/*
> @@ -1670,30 +1630,24 @@ static void get_managed_objects_cb(struct
> l_dbus_message *msg, void *user_data)
>  		 */
>  		init_storage_dir(node);
> =20
> +		node->disc_watch =3D l_dbus_add_disconnect_watch(bus,
> +				node->owner, app_disc_cb, node, NULL);
> +
>  	} else if (req->type =3D=3D REQUEST_TYPE_JOIN) {
> -		if (!agent) {
> +		if (!node->agent) {
>  			l_error("Interface %s not found",
>  						MESH_PROVISION_AGENT_IN
> TERFACE);
>  			goto fail;
>  		}
> =20
> -		node->num_ele =3D num_ele;
> -		set_defaults(node);
> -		memcpy(node->uuid, req->uuid, 16);
> -
>  		if (!create_node_config(node, node->uuid))
>  			goto fail;
> =20
> -		req->join_ready_cb(node, agent);
>  	} else {
>  		/* Callback for create node request */
>  		struct keyring_net_key net_key;
>  		uint8_t dev_key[16];
> =20
> -		node->num_ele =3D num_ele;
> -		set_defaults(node);
> -		memcpy(node->uuid, req->uuid, 16);
> -
>  		if (!create_node_config(node, node->uuid))
>  			goto fail;
> =20
> @@ -1713,35 +1667,32 @@ static void get_managed_objects_cb(struct
> l_dbus_message *msg, void *user_data)
>  		init_storage_dir(node);
> =20
>  		if (!keyring_put_remote_dev_key(node,
> DEFAULT_NEW_UNICAST,
> -							num_ele,
> dev_key))
> +						node->num_ele,
> dev_key))
>  			goto fail;
> =20
>  		if (!keyring_put_net_key(node, PRIMARY_NET_IDX,
> &net_key))
>  			goto fail;
> =20
> -		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
>  	}
> =20
> +	if (req->type =3D=3D REQUEST_TYPE_JOIN)
> +		req->join_ready_cb(node, node->agent);
> +	else
> +		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
> +
>  	return;
>  fail:
>  	if (agent)
>  		mesh_agent_remove(agent);
> =20
> -	if (!is_new) {
> -		free_node_dbus_resources(node);
> +	/* Handle failed requests */
> +	if (node)
> +		node_remove(node);
> =20
> -		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED,
> node);
> -	} else {
> -		/* Handle failed Join and Create requests */
> -		if (node)
> -			node_remove(node);
> -
> -		if (req->type =3D=3D REQUEST_TYPE_JOIN)
> -			req->join_ready_cb(NULL, NULL);
> -		else
> -			req->ready_cb(req->pending_msg,
> MESH_ERROR_FAILED,
> -								=09
> NULL);
> -	}
> +	if (req->type =3D=3D REQUEST_TYPE_JOIN)
> +		req->join_ready_cb(NULL, NULL);
> +	else
> +		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED,
> NULL);
>  }
> =20
>  /* Establish relationship between application and mesh node */
> @@ -1761,13 +1712,18 @@ int node_attach(const char *app_path, const
> char *sender, uint64_t token,
>  		return MESH_ERROR_ALREADY_EXISTS;
>  	}
> =20
> -	node->app_path =3D l_strdup(app_path);
> -	node->owner =3D l_strdup(sender);
> -
>  	req =3D l_new(struct managed_obj_request, 1);
> -	req->node =3D node;
> +
> +	/*
> +	 * Create a temporary node to collect composition data from
> attaching
> +	 * application. Existing node is passed in req->attach.
> +	 */
> +	req->node =3D node_new(node->uuid);
> +	req->node->app_path =3D l_strdup(app_path);
> +	req->node->owner =3D l_strdup(sender);
>  	req->ready_cb =3D cb;
>  	req->pending_msg =3D user_data;
> +	req->attach =3D node;
>  	req->type =3D REQUEST_TYPE_ATTACH;
> =20
>  	l_dbus_method_call(dbus_get_bus(), sender, app_path,
> @@ -1789,7 +1745,7 @@ void node_join(const char *app_path, const char
> *sender, const uint8_t *uuid,
>  	l_debug("");
> =20
>  	req =3D l_new(struct managed_obj_request, 1);
> -	req->uuid =3D uuid;
> +	req->node =3D node_new(uuid);
>  	req->join_ready_cb =3D cb;
>  	req->type =3D REQUEST_TYPE_JOIN;
> =20
> @@ -1808,7 +1764,7 @@ void node_create(const char *app_path, const
> char *sender, const uint8_t *uuid,
>  	l_debug("");
> =20
>  	req =3D l_new(struct managed_obj_request, 1);
> -	req->uuid =3D uuid;
> +	req->node =3D node_new(uuid);
>  	req->ready_cb =3D cb;
>  	req->pending_msg =3D user_data;
>  	req->type =3D REQUEST_TYPE_CREATE;


Regards,
Inga

--=-AFCwfhuBfqULl85MggZN
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
k3sf6w6ZKbZbz2V54rncMEXM3N/P4C6ZHZR0XYqh5m1vWxZYYVzTuDEH1C8W+b3KzldrAgMBAAGj
ggIwMIICLDAdBgNVHQ4EFgQUcdzZH9M8OSxLujP+AToiD5oYMRkwHwYDVR0jBBgwFoAU2kEjnFqP
ca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVw
b3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIu
Y3JsMIGeBggrBgEFBQcBAQSBkTCBjjAhBggrBgEFBQcwAYYVaHR0cDovL29jc3AuaW50ZWwuY29t
MGkGCCsGAQUFBzAChl1odHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRl
cy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjA0Qi5jcnQwCwYDVR0P
BAQDAgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4He
vTmV8EMCAWQCAQkwHwYDVR0lBBgwFgYIKwYBBQUHAwQGCisGAQQBgjcKAwwwKQYJKwYBBAGCNxUK
BBwwGjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMMMEsGA1UdEQREMEKgJwYKKwYBBAGCNxQCA6AZ
DBdpbmdhLnN0b3RsYW5kQGludGVsLmNvbYEXaW5nYS5zdG90bGFuZEBpbnRlbC5jb20wDQYJKoZI
hvcNAQEFBQADggEBALnl11xd+3X6fVS0VAKeoF0jCPLFZLCk4jMFifFzY2md3MLjVIB3lE5ffNnS
mjG9ErOO6as95K6D6hzCJMqNodOyVPRSrMNey0tzFAPLRG3s2bgfmOcvYr4O3WmpDMx8YmH6O2YI
3Xxjyp11aXl5pk6VjpZV/hjN1jwZ/c/X00KsjoMB8mGSBvbwnV0EFQUJ99xsAlqQ4edj2T9z6pF1
WX189YL64c/t3a9LWNaT2CWbBZLIFoor9TpZsIj0lGObmGA76JKn5yxN+jzxhWIAzPi5KKYgJ9EU
FDn6fGbJHisZdWX3bVamfpmPogThm1khlD7R4USu0eyym3JRh0tXJeAxggIXMIICEwIBATCBkDB5
MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQK
ExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWlu
ZyBDQSA0QgITMwAAeRJvGZxlhdnerwAAAAB5EjAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzI2MDM1ODMwWjAjBgkqhkiG9w0BCQQxFgQU
TmBN5uLvxUEiXgvKaa9daIgEBPcwDQYJKoZIhvcNAQEBBQAEggEAGHW7QPm4qVE50IjymJH6hzz0
wwVOyXzB9wVfv3SZopLdx2rTq8t0zBGDCXuS5rFi97HOG+hCMscZevcQSvHPtAJIkmX7m3QBeAvi
WCngGlBh0aMrxwu/IET3ciw65UnUwKQQQpkBv7O839e6/+uiJ10gvlnuCcIk1M9wGx5xtxfWp/vj
V8b/CQCf3V+MHpKTMSfpXsL7x8JdIXxsOgulWWxa7p4YHZHA+C6SQ5qsROeYop3rW8fqtiGghwTZ
BTUrkK1YU6Zy1ZKvnzowapEi2/StxESRPtrch3CTOSS9JtbcQfN2nA2oUPhhMCFjZW8H762at1wg
Acrta/JJyHb7UAAAAAAAAA==


--=-AFCwfhuBfqULl85MggZN--
