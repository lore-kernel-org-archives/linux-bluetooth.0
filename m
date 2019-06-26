Return-Path: <SRS0=cKDh=UZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D27C48BD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AA2208E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFZRxF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:53:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:20710 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZRxF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jun 2019 13:53:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="p7s'?scan'208";a="360389630"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2019 10:53:03 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Jun 2019 10:53:03 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.46]) with mapi id 14.03.0439.000;
 Wed, 26 Jun 2019 10:53:03 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH v2] mesh: Added ImportLocalNode call with its API
Thread-Topic: [PATCH v2] mesh: Added ImportLocalNode call with its API
Thread-Index: AQHVK2POj4hzhF+rz0aEMxASG80hRqauoBIAgAAOfYA=
Date:   Wed, 26 Jun 2019 17:53:02 +0000
Message-ID: <14abe0f2129a2334d32aa14f2167380a5208880b.camel@intel.com>
References: <20190625143855.29889-1-jakub.witowski@silvair.com>
         <1561568468.22940.16.camel@intel.com>
In-Reply-To: <1561568468.22940.16.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.231.9]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-VArs1fZlSgaVrOLyWl+6"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-VArs1fZlSgaVrOLyWl+6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian, Jakub,

On Wed, 2019-06-26 at 10:01 -0700, Gix, Brian wrote:
> Hi Jakub,
>=20
>=20
> On Tue, 2019-06-25 at 16:38 +0200, Jakub Witowski wrote:
> > This implements ImportLocalNode() method on org.bluez.mesh.Network1
> > interface. Invoking this method creates a self-provisioned node
> > based on
> > passed JSON definition. Also full functionality of import local
> > node has
> > been implemented
> > ---
> >  doc/mesh-api.txt |  22 ++++-
> >  mesh/mesh.c      |  63 ++++++++++++--
> >  mesh/node.c      | 212
> > +++++++++++++++++++++++++++++++++++++++++++----
> >  mesh/node.h      |   2 +
> >  4 files changed, 276 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> > index 4e0a8bff1..539fc3e4f 100644
> > --- a/doc/mesh-api.txt
> > +++ b/doc/mesh-api.txt
> > @@ -151,11 +151,21 @@ Methods:
> >  			org.bluez.mesh.Error.InvalidArguments
> >  			org.bluez.mesh.Error.AlreadyExists,
> > =20
> > -	 uint64 token ImportLocalNode(string json_data)
> > +	 uint64 token ImportLocalNode(object app_root, string
> > json_data, array{byte}[16] uuid)
> > =20
> >  		This method creates a local mesh node based on node
> >  		configuration that has been generated outside
> > bluetooth-meshd.
> > =20
> > +		The app_root parameter is a D-Bus object root path of
> > the
> > +		application that implements org.bluez.mesh.Application1
> > +		interface, and a org.bluez.mesh.Provisioner1 interface.
> > The
> > +		application represents a node where child mesh elements
> > have
> > +		their own objects that implement
> > org.bluez.mesh.Element1
> > +		interface. The application hierarchy also contains a
> > provision
> > +		agent object that implements
> > org.bluez.mesh.ProvisionAgent1
> > +		interface. The standard DBus.ObjectManager interface
> > must be
> > +		available on the app_root path.
> > +
> >  		The json_data parameter is a full JSON representation
> > of a node
> >  		configuration file. The format must conform to the
> > schema
> >  		defined in "Mesh Node Configuration Schema" section.
> > Any
> > @@ -1059,4 +1069,12 @@ Properties:
> > =20
> >  Mesh Node Configuration Schema
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > -<TBD>
> > +Example of Json format for ImportLocalNode():
> > +{
> > +  "IVindex":0,
> > +  "IVupdate":0,
> > +  "unicastAddress":"0012",
> > +  "deviceKey":"7daa45cd1e9e11a4b86eeef7d01efa11",
> > +  "netKey":"1234567890abcdef1234567890abcdef",
> > +  "keyRefresh":0
> > +}
> > diff --git a/mesh/mesh.c b/mesh/mesh.c
> > index 26acfd4dc..e0f0e4bf9 100644
> > --- a/mesh/mesh.c
> > +++ b/mesh/mesh.c
> > @@ -22,6 +22,7 @@
> >  #endif
> > =20
> >  #define _GNU_SOURCE
> > +#include <json-c/json.h>
>=20
> We are trying to figure out a way to *isolate* JSON dependancies in
> the Mesh daemon, such that
> if it needs to be ported to a platform that does not support the JSON
> library, it can be easily
> pared out while minimizing impact to the rest of the system.
>=20
> Inga and I have been having conversations about this.
>=20
> * It should be possible to create a JSON-free daemon, if the internal
> JSON storage system is replaced with a
> custom, more space-efficient node storage, or for any other reason.
>=20
> * It should be possible to *remove* the ImportLocalNode() entirely if
> that functionality is not needed, and
> with it the JSON dependancy.
>=20
> * We may want to be able to support *other* formats for this DBUS
> facing interface (perhaps XML, perhaps
> something vendor defined).
>=20
>=20
> I don't think there is any question that the *location* for this
> method belongs exactly where you have it,
> however I think we would like to see the JSON parsing moved to a file
> that already has the JSON dependancy.  We
> may want to let the daemon auto-detect the format (returning an error
> if the format is not understood).=20
> However, then perhaps having a "Table of Parsers" that do not live
> within the mesh.c file...  but perhaps in a
> format-parser.h file which can be easily customized to support other
> parsers.

I just want to point out that maintining several parsers at the runtime
may not be a good idea as it would result in unwarranted code
complexity, e.g., loading node configurations at startup from *all*
supported formats and then writing out each node in its corresponding
format.

My preference would be to have a compile time decision to choose a
supported parser. In addition, standalone format conversion tools may
be provided.

Maybe adding "format" property to /org/bluez/mesh? An app can read the
property, perform the appropriate conversion and then invoke Import
method.

Import method may take an additional string argument "type" to indicate
the type of the format of the imported node configuration, e.g., "json"
or "xml".

>=20
> >  #include <ell/ell.h>
> > =20
> >  #include "mesh/mesh-io.h"
> > @@ -60,7 +61,7 @@ struct bt_mesh {
> >  	uint8_t max_filters;
> >  };
> > =20
> > -struct join_data{
> > +struct join_data {
> >  	struct l_dbus_message *msg;
> >  	struct mesh_agent *agent;
> >  	const char *sender;
> > @@ -365,8 +366,8 @@ static void node_init_cb(struct mesh_node
> > *node, struct mesh_agent *agent)
> > =20
> >  	if (!acceptor_start(num_ele, join_pending->uuid,
> > mesh.algorithms,
> >  				mesh.prov_timeout, agent,
> > prov_complete_cb,
> > -				&mesh))
> > -	{
> > +				&mesh)) {
> > +
> >  		reply =3D dbus_error(join_pending->msg,
> > MESH_ERROR_FAILED,
> >  				"Failed to start provisioning
> > acceptor");
> >  		goto fail;
> > @@ -536,7 +537,7 @@ static struct l_dbus_message *leave_call(struct
> > l_dbus *dbus,
> >  	return l_dbus_message_new_method_return(msg);
> >  }
> > =20
> > -static void create_network_ready_cb(void *user_data, int status,
> > +static void create_node_ready_cb(void *user_data, int status,
> >  							struct
> > mesh_node *node)
> >  {
> >  	struct l_dbus_message *reply;
> > @@ -593,12 +594,58 @@ static struct l_dbus_message
> > *create_network_call(struct l_dbus *dbus,
> > =20
> >  	l_queue_push_tail(pending_queue, pending_msg);
> > =20
> > -	node_create(app_path, sender, uuid, create_network_ready_cb,
> > +	node_create(app_path, sender, uuid, create_node_ready_cb,
> >  								pending
> > _msg);
> > =20
> >  	return NULL;
> >  }
> > =20
> > +static struct l_dbus_message *import_local_node_call(struct l_dbus
> > *dbus,
> > +						struct l_dbus_message
> > *msg,
> > +						void *user_data)
> > +{
> > +	const char *app_path, *sender;
> > +	struct l_dbus_message *pending_msg;
> > +	struct l_dbus_message_iter iter_uuid;
> > +	const char *json_data;
> > +	uint8_t *uuid;
> > +	uint32_t n;
> > +	struct json_object *jnode;
> > +
> > +	l_debug("Import local node request");
> > +
> > +	if (!l_dbus_message_get_arguments(msg, "osay", &app_path,
> > +							&json_data,
> > &iter_uuid))
> > +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> > +
> > +	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
> > ||
> > +								=09
> > n !=3D 16)
> > +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Bad
> > dev UUID");
> > +
> > +	if (node_find_by_uuid(uuid))
> > +		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
> > +							"Node already
> > exists");
> > +
> > +	jnode =3D json_tokener_parse(json_data);
> > +
> > +	sender =3D l_dbus_message_get_sender(msg);
> > +	pending_msg =3D l_dbus_message_ref(msg);
> > +
> > +	if (!pending_queue)
> > +		pending_queue =3D l_queue_new();
> > +
> > +	l_queue_push_tail(pending_queue, pending_msg);
> > +
> > +	if (!node_import(app_path, sender, jnode, uuid,
> > create_node_ready_cb,
> > +								pending
> > _msg)) {
> > +		l_dbus_message_unref(msg);
> > +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
> > +							"Node import
> > failed");
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  static void setup_network_interface(struct l_dbus_interface
> > *iface)
> >  {
> >  	l_dbus_interface_method(iface, "Join", 0, join_network_call,
> > "",
> > @@ -612,8 +659,14 @@ static void setup_network_interface(struct
> > l_dbus_interface *iface)
> > =20
> >  	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
> >  								"token"
> > );
> > +
> >  	l_dbus_interface_method(iface, "CreateNetwork", 0,
> > create_network_call,
> >  					"t", "oay", "token", "app",
> > "uuid");
> > +
> > +	l_dbus_interface_method(iface, "ImportLocalNode", 0,
> > +					import_local_node_call,
> > +					"t", "osay", "token",
> > +					"app", "json_data", "uuid");
> >  }
> > =20
> >  bool mesh_dbus_init(struct l_dbus *dbus)
> > diff --git a/mesh/node.c b/mesh/node.c
> > index e99858623..991802a6f 100644
> > --- a/mesh/node.c
> > +++ b/mesh/node.c
> > @@ -27,6 +27,7 @@
> > =20
> >  #include <ell/ell.h>
> >  #include <json-c/json.h>
> > +#include <stdio.h>
> > =20
> >  #include "mesh/mesh-defs.h"
> >  #include "mesh/mesh.h"
> > @@ -58,9 +59,12 @@
> >  #define DEFAULT_CRPL 10
> >  #define DEFAULT_SEQUENCE_NUMBER 0
> > =20
> > -#define REQUEST_TYPE_JOIN 0
> > -#define REQUEST_TYPE_ATTACH 1
> > -#define REQUEST_TYPE_CREATE 2
> > +enum request_type {
> > +	REQUEST_TYPE_JOIN =3D 0,
> > +	REQUEST_TYPE_ATTACH,
> > +	REQUEST_TYPE_CREATE,
> > +	REQUEST_TYPE_IMPORT,
> > +};
> > =20
> >  struct node_element {
> >  	char *path;
> > @@ -111,7 +115,18 @@ struct managed_obj_request {
> >  	void *data;
> >  	void *cb;
> >  	void *user_data;
> > -	uint8_t type;
> > +	enum request_type type;
> > +};
> > +
> > +struct node_import_request {
> > +	uint8_t uuid[16];
> > +	uint8_t dev_key[16];
> > +	uint8_t net_key[16];
> > +	bool kr;
> > +	uint16_t unicast;
> > +	uint32_t iv_idx;
> > +	bool iv_update;
> > +	void *user_data;
> >  };
> > =20
> >  static struct l_queue *nodes;
> > @@ -851,7 +866,7 @@ element_done:
> >  #define MIN_COMPOSITION_LEN 16
> > =20
> >  bool node_parse_composition(struct mesh_node *node, uint8_t *data,
> > -								uint16_
> > t len)
> > +			    uint16_t len)
> >  {
> >  	struct node_composition *comp;
> >  	uint16_t features;
> > @@ -946,7 +961,7 @@ bool node_parse_composition(struct mesh_node
> > *node, uint8_t *data,
> >  			vendor_id =3D l_get_le16(data);
> >  			mod_id |=3D (vendor_id << 16);
> >  			mod =3D mesh_model_vendor_new(ele->idx,
> > vendor_id,
> > -								=09
> > mod_id);
> > +						    mod_id);
> >  			if (!mod) {
> >  				element_free(ele);
> >  				goto fail;
> > @@ -977,7 +992,6 @@ fail:
> > =20
> >  	return false;
> >  }
> > -
> >  static void attach_io(void *a, void *b)
> >  {
> >  	struct mesh_node *node =3D a;
> > @@ -1078,6 +1092,7 @@ static bool validate_model_property(struct
> > node_element *ele,
> >  		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
> >  								&mod_id
> > )) {
> >  			struct mesh_model *mod;
> > +
> >  			mod =3D l_queue_find(ele->models, match_model_id,
> >  				L_UINT_TO_PTR((vendor_id << 16) |
> > mod_id));
> >  			if (!mod)
> > @@ -1366,17 +1381,92 @@ static bool get_app_properties(struct
> > mesh_node *node, const char *path,
> >  	return true;
> >  }
> > =20
> > -static bool add_local_node(struct mesh_node *node, uint16_t
> > unicast, bool kr,
> > -				bool ivu, uint32_t iv_idx, uint8_t
> > dev_key[16],
> > -				uint16_t net_key_idx, uint8_t
> > net_key[16])
> > +static bool parse_imported_iv_index(json_object *jobj, uint32_t
> > *idx,
> > +								bool
> > *update)
> >  {
> > -	node->net =3D mesh_net_new(node);
> > +	int tmp;
> > +	json_object *jvalue;
> > =20
> > -	if (!nodes)
> > -		nodes =3D l_queue_new();
> > +	if (!json_object_object_get_ex(jobj, "IVindex", &jvalue))
> > +		return false;
> > =20
> > -	l_queue_push_tail(nodes, node);
> > +	tmp =3D json_object_get_int(jvalue);
> > +	*idx =3D (uint32_t) tmp;
> > +
> > +	if (!json_object_object_get_ex(jobj, "IVupdate", &jvalue))
> > +		return false;
> > +
> > +	tmp =3D json_object_get_int(jvalue);
> > +	*update =3D (bool)tmp;
> > +
> > +	return true;
> > +}
> > +
> > +static bool parse_imported_unicast_addr(json_object *jobj,
> > uint16_t *unicast)
> > +{
> > +	json_object *jvalue;
> > +	char *str;
> > +
> > +	if (!json_object_object_get_ex(jobj, "unicastAddress",
> > &jvalue))
> > +		return false;
> > +
> > +	str =3D (char *)json_object_get_string(jvalue);
> > +
> > +	if (sscanf(str, "%04hx", unicast) !=3D 1)
> > +		return false;
> > +
> > +	return true;
> > +}
> > =20
> > +static bool parse_imported_device_key(json_object *jobj, uint8_t
> > key_buf[16])
> > +{
> > +	json_object *jvalue;
> > +	char *str;
> > +
> > +	if (!key_buf)
> > +		return false;
> > +
> > +	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue))
> > +		return false;
> > +
> > +	str =3D (char *)json_object_get_string(jvalue);
> > +
> > +	if (!str2hex(str, strlen(str), key_buf, 16))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static bool parse_imported_net_key(json_object *jobj, uint8_t
> > key_buf[16],
> > +								bool
> > *kr)
> > +{
> > +	json_object *jvalue;
> > +	char *str;
> > +
> > +	if (!key_buf)
> > +		return false;
> > +
> > +	if (!json_object_object_get_ex(jobj, "netKey", &jvalue))
> > +		return false;
> > +
> > +	str =3D (char *)json_object_get_string(jvalue);
> > +
> > +	if (!str2hex(str, strlen(str), key_buf, 16))
> > +		return false;
> > +
> > +	/* Get key refresh */
> > +	if (!json_object_object_get_ex(jobj, "keyRefresh", &jvalue))
> > +		return false;
> > +
> > +	*kr =3D (bool)json_object_get_boolean(jvalue);
> > +	return true;
> > +}
> > +
> > +
> > +static bool add_local_node(struct mesh_node *node, uint16_t
> > unicast, bool kr,
> > +				bool ivu, uint32_t iv_idx, uint8_t
> > dev_key[16],
> > +				uint16_t net_key_idx, uint8_t
> > net_key[16])
> > +{
> >  	if (!storage_set_iv_index(node->net, iv_idx, ivu))
> >  		return false;
> > =20
> > @@ -1444,14 +1534,13 @@ static void get_managed_objects_cb(struct
> > l_dbus_message *msg, void *user_data)
> >  	}
> > =20
> >  	if (is_new) {
> > -		node =3D l_new(struct mesh_node, 1);
> > +		node =3D node_new(req->data);
> >  		node->elements =3D l_queue_new();
> >  	} else {
> >  		node =3D req->data;
> >  	}
> > =20
> >  	num_ele =3D 0;
> > -
> >  	while (l_dbus_message_iter_next_entry(&objects, &path,
> > &interfaces)) {
> >  		struct l_dbus_message_iter properties;
> >  		const char *interface;
> > @@ -1547,6 +1636,44 @@ static void get_managed_objects_cb(struct
> > l_dbus_message *msg, void *user_data)
> > =20
> >  		cb(node, agent);
> > =20
> > +	} else if (req->type =3D=3D REQUEST_TYPE_IMPORT) {
> > +
> > +		node_ready_func_t cb =3D req->cb;
> > +		struct node_import_request *import_data =3D req-
> > >user_data;
> > +		struct keyring_net_key net_key;
> > +
> > +		if (!agent) {
> > +			l_error("Interface %s not found",
> > +						MESH_PROVISION_AGENT_IN
> > TERFACE);
> > +			goto fail;
> > +		}
> > +
> > +		node->num_ele =3D num_ele;
> > +		set_defaults(node);
> > +		memcpy(node->uuid, import_data->uuid, 16);
> > +
> > +		if (!create_node_config(node))
> > +			goto fail;
> > +
> > +		if (!add_local_node(node, import_data->unicast,
> > import_data->kr,
> > +				import_data->iv_update, import_data-
> > >iv_idx,
> > +				import_data->dev_key, PRIMARY_NET_IDX,
> > +							import_data-
> > >net_key))
> > +			goto fail;
> > +
> > +		memcpy(net_key.old_key, import_data->net_key, 16);
> > +		net_key.net_idx =3D PRIMARY_NET_IDX;
> > +		net_key.phase =3D KEY_REFRESH_PHASE_NONE;
> > +
> > +		if (!keyring_put_remote_dev_key(node, import_data-
> > >unicast,
> > +						num_ele, import_data-
> > >dev_key))
> > +			goto fail;
> > +
> > +		if (!keyring_put_net_key(node, PRIMARY_NET_IDX,
> > &net_key))
> > +			goto fail;
> > +
> > +		cb(import_data->user_data, MESH_ERROR_NONE, node);
> > +
> >  	} else {
> >  		/* Callback for create node request */
> >  		node_ready_func_t cb =3D req->cb;
> > @@ -1672,6 +1799,59 @@ void node_join(const char *app_path, const
> > char *sender, const uint8_t *uuid,
> >  					req, l_free);
> >  }
> > =20
> > +
> > +bool node_import(const char *app_path, const char *sender, void
> > *json_data,
> > +		const uint8_t *uuid, node_ready_func_t cb, void
> > *user_data)
> > +{
> > +	struct managed_obj_request *req;
> > +	struct node_import_request *node;
> > +
> > +	l_debug("");
> > +	node =3D l_new(struct node_import_request, 1);
> > +	req =3D l_new(struct managed_obj_request, 1);
> > +
> > +	if (!parse_imported_device_key(json_data, node->dev_key)) {
> > +		l_error("Failed to parse imported device key");
> > +		goto fail;
> > +	}
> > +
> > +	if (!parse_imported_unicast_addr(json_data, &node->unicast)) {
> > +		l_error("Failed to parse imported unicast address");
> > +		goto fail;
> > +	}
> > +
> > +	if (!parse_imported_iv_index(json_data, &node->iv_idx,
> > +							&node-
> > >iv_update)) {
> > +		l_error("Failed to parse imported iv idx");
> > +		goto fail;
> > +	}
> > +
> > +
> > +	if (!parse_imported_net_key(json_data, node->net_key, &node-
> > >kr)) {
> > +		l_error("Failed to parse imported network key");
> > +		goto fail;
> > +	}
> > +
> > +	node->user_data =3D user_data;
> > +
> > +	memcpy(node->uuid, uuid, 16);
> > +	req->data =3D (void *) uuid;
> > +	req->user_data =3D node;
> > +	req->cb =3D cb;
> > +	req->type =3D REQUEST_TYPE_IMPORT;
> > +
> > +	l_dbus_method_call(dbus_get_bus(), sender, app_path,
> > +					L_DBUS_INTERFACE_OBJECT_MANAGER
> > ,
> > +					"GetManagedObjects", NULL,
> > +					get_managed_objects_cb,
> > +					req, l_free);
> > +	return true;
> > +fail:
> > +	json_object_put(json_data);
> > +	l_free(node);
> > +	return false;
> > +}
> > +
> >  void node_create(const char *app_path, const char *sender, const
> > uint8_t *uuid,
> >  					node_ready_func_t cb, void
> > *user_data)
> >  {
> > diff --git a/mesh/node.h b/mesh/node.h
> > index 142527b30..9559f9178 100644
> > --- a/mesh/node.h
> > +++ b/mesh/node.h
> > @@ -91,6 +91,8 @@ void node_build_attach_reply(struct mesh_node
> > *node,
> >  						struct l_dbus_message
> > *reply);
> >  void node_create(const char *app_path, const char *sender, const
> > uint8_t *uuid,
> >  					node_ready_func_t cb, void
> > *user_data);
> > +bool node_import(const char *app_path, const char *sender, void
> > *jnode,
> > +		const uint8_t *uuid, node_ready_func_t cb, void
> > *user_data);
> >  void node_id_set(struct mesh_node *node, uint16_t node_id);
> >  uint16_t node_id_get(struct mesh_node *node);
> >  bool node_dbus_init(struct l_dbus *bus);


--=-VArs1fZlSgaVrOLyWl+6
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNjI2MTc1MzAxWjAjBgkqhkiG9w0BCQQxFgQU
OZF7FAmDZWyBwbGybaRa9iwCWMMwDQYJKoZIhvcNAQEBBQAEggEAXUa3kWvOiOTlB6pkiIYKA35H
iFPRebrgg9tOkbBUTmgAa+ZzbDTJa3c2vM8RhAz5zy+8xcz62+eIsmUiPK74s+d4aBqRFbsqgoMQ
wqCKGC07KjYKkNvnh11sHL+PZ/T7X37CoD6r1j8dMK+ANCISis8qeZxdoaJ+9IYgaZMLVj2CmgSN
8csItZiqAO8sko+nJ2G8Hny+qZOP9R0tz+BSE1UBYZbFrnDNG5sd+hF2WvBQSF8KbZEgy7ElN+pQ
1x3APxa43cmVqtbnBHwIEVxoHrpJ24aIk/A7yGzKwtOXy63jYn7/91qqX0zcf/fnqxtHjSGvPNXx
2nFWq9Xts+VeiQAAAAAAAA==


--=-VArs1fZlSgaVrOLyWl+6--
