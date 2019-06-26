Return-Path: <SRS0=cKDh=UZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9BBC48BD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EFE208E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 18:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="0K+18a0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFZShq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:37:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33759 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZShq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jun 2019 14:37:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so3942069wru.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2019 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=D5ww6ja3rS4UuU0ZfXjcLDvyRSMEFyd67OJB/DA/H/Q=;
        b=0K+18a0mBznKawvDXWGtQEpj4OvhyWBR2kRJkyfToAzB6G2sgDHObPrE2TMNb9Jcho
         VrBSPnev3Bnu8R3dGfG84nU0X2riMmGKfndpm0GrkjJMPLYCfhHungngIjxXYChetoHD
         Z/NZs0JJSbIwlY+H5IdV9zxbGU1sYzuCWlEYMwnzTuY+OrOAhkJMlTvvgDyykMFwUDfS
         Hzm4OJ0355Mx/gErxa+zqW045V6MleE1lXyuRuJZVowA5he3UsOIAdS4CyWln/dphrDo
         nxxn7z4bTm1i25JqxP+ht1w+ETOqy3i2wyG/cSvLDy2ILhOKUoawpnkH8xeerUJnKTif
         0bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D5ww6ja3rS4UuU0ZfXjcLDvyRSMEFyd67OJB/DA/H/Q=;
        b=Z5ubBTEJkJKtSuaUAOZQYa6BdlZMiO8qGhG86utZg944wK/NFd8XGe15tXTHs1fA4t
         1PKe01bpZ3Lyr4bnKGKWLSmsG6S1IGceMHjV2KJ64S3MUzDdXYGLHyQvIdOAQJH8x1wc
         nw0Hq/NppLnbw8m1Jyj17+eFg7BKmTMxQM+VOZXvpK7zi6qCAZmIbmbhgsbwLvuY7Fsr
         6Ej1+6LuQlC2Ie2w73EZIY8o/ahpQCLcTFXKMxZTX5wz8Nsf/nrToxr9jI+EYxc9Hd/f
         xl0gwKhn9JvOzP1q54fGznLUib8KIQ6gh0qGKrTO8ARLfhq7aBVpKU9iouTY836OQSqo
         3ylA==
X-Gm-Message-State: APjAAAUFlUdpjbCJRovL/SBHOXc00fqs+JSu5xqzunY/bYDPmkZTgnVk
        teQ7wLNefLxaJIr5cA5UO0e8lw==
X-Google-Smtp-Source: APXvYqwcuB6anmPGUmiQBePVwDPX7en03xoWl9S6tSfot7+kWpSRKMupIQXxn0CLj2VUzswJ6kPRxg==
X-Received: by 2002:adf:f503:: with SMTP id q3mr4753575wro.43.1561574261971;
        Wed, 26 Jun 2019 11:37:41 -0700 (PDT)
Received: from [192.168.1.21] (acqx166.neoplus.adsl.tpnet.pl. [83.10.255.166])
        by smtp.gmail.com with ESMTPSA id f197sm4240860wme.39.2019.06.26.11.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 11:37:41 -0700 (PDT)
Subject: Re: [PATCH v2] mesh: Added ImportLocalNode call with its API
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Cc:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
References: <20190625143855.29889-1-jakub.witowski@silvair.com>
 <1561568468.22940.16.camel@intel.com>
 <14abe0f2129a2334d32aa14f2167380a5208880b.camel@intel.com>
From:   Jakub Witowski <jakub.witowski@silvair.com>
Message-ID: <89c882e9-a64c-b60a-a5ea-5d4436b1cbd3@silvair.com>
Date:   Wed, 26 Jun 2019 20:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <14abe0f2129a2334d32aa14f2167380a5208880b.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 26.06.2019 19:53, Stotland, Inga wrote:
> Hi Brian, Jakub,
>
> On Wed, 2019-06-26 at 10:01 -0700, Gix, Brian wrote:
>> Hi Jakub,
>>
>>
>> On Tue, 2019-06-25 at 16:38 +0200, Jakub Witowski wrote:
>>> This implements ImportLocalNode() method on org.bluez.mesh.Network1
>>> interface. Invoking this method creates a self-provisioned node
>>> based on
>>> passed JSON definition. Also full functionality of import local
>>> node has
>>> been implemented
>>> ---
>>>   doc/mesh-api.txt |  22 ++++-
>>>   mesh/mesh.c      |  63 ++++++++++++--
>>>   mesh/node.c      | 212
>>> +++++++++++++++++++++++++++++++++++++++++++----
>>>   mesh/node.h      |   2 +
>>>   4 files changed, 276 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
>>> index 4e0a8bff1..539fc3e4f 100644
>>> --- a/doc/mesh-api.txt
>>> +++ b/doc/mesh-api.txt
>>> @@ -151,11 +151,21 @@ Methods:
>>>   			org.bluez.mesh.Error.InvalidArguments
>>>   			org.bluez.mesh.Error.AlreadyExists,
>>>   
>>> -	 uint64 token ImportLocalNode(string json_data)
>>> +	 uint64 token ImportLocalNode(object app_root, string
>>> json_data, array{byte}[16] uuid)
>>>   
>>>   		This method creates a local mesh node based on node
>>>   		configuration that has been generated outside
>>> bluetooth-meshd.
>>>   
>>> +		The app_root parameter is a D-Bus object root path of
>>> the
>>> +		application that implements org.bluez.mesh.Application1
>>> +		interface, and a org.bluez.mesh.Provisioner1 interface.
>>> The
>>> +		application represents a node where child mesh elements
>>> have
>>> +		their own objects that implement
>>> org.bluez.mesh.Element1
>>> +		interface. The application hierarchy also contains a
>>> provision
>>> +		agent object that implements
>>> org.bluez.mesh.ProvisionAgent1
>>> +		interface. The standard DBus.ObjectManager interface
>>> must be
>>> +		available on the app_root path.
>>> +
>>>   		The json_data parameter is a full JSON representation
>>> of a node
>>>   		configuration file. The format must conform to the
>>> schema
>>>   		defined in "Mesh Node Configuration Schema" section.
>>> Any
>>> @@ -1059,4 +1069,12 @@ Properties:
>>>   
>>>   Mesh Node Configuration Schema
>>>   ==============================
>>> -<TBD>
>>> +Example of Json format for ImportLocalNode():
>>> +{
>>> +  "IVindex":0,
>>> +  "IVupdate":0,
>>> +  "unicastAddress":"0012",
>>> +  "deviceKey":"7daa45cd1e9e11a4b86eeef7d01efa11",
>>> +  "netKey":"1234567890abcdef1234567890abcdef",
>>> +  "keyRefresh":0
>>> +}
>>> diff --git a/mesh/mesh.c b/mesh/mesh.c
>>> index 26acfd4dc..e0f0e4bf9 100644
>>> --- a/mesh/mesh.c
>>> +++ b/mesh/mesh.c
>>> @@ -22,6 +22,7 @@
>>>   #endif
>>>   
>>>   #define _GNU_SOURCE
>>> +#include <json-c/json.h>
>> We are trying to figure out a way to *isolate* JSON dependancies in
>> the Mesh daemon, such that
>> if it needs to be ported to a platform that does not support the JSON
>> library, it can be easily
>> pared out while minimizing impact to the rest of the system.
>>
>> Inga and I have been having conversations about this.
>>
>> * It should be possible to create a JSON-free daemon, if the internal
>> JSON storage system is replaced with a
>> custom, more space-efficient node storage, or for any other reason.
>>
>> * It should be possible to *remove* the ImportLocalNode() entirely if
>> that functionality is not needed, and
>> with it the JSON dependancy.
>>
>> * We may want to be able to support *other* formats for this DBUS
>> facing interface (perhaps XML, perhaps
>> something vendor defined).
>>
>>
>> I don't think there is any question that the *location* for this
>> method belongs exactly where you have it,
>> however I think we would like to see the JSON parsing moved to a file
>> that already has the JSON dependancy.  We
>> may want to let the daemon auto-detect the format (returning an error
>> if the format is not understood).
>> However, then perhaps having a "Table of Parsers" that do not live
>> within the mesh.c file...  but perhaps in a
>> format-parser.h file which can be easily customized to support other
>> parsers.
> I just want to point out that maintining several parsers at the runtime
> may not be a good idea as it would result in unwarranted code
> complexity, e.g., loading node configurations at startup from *all*
> supported formats and then writing out each node in its corresponding
> format.
>
> My preference would be to have a compile time decision to choose a
> supported parser. In addition, standalone format conversion tools may
> be provided.
>
> Maybe adding "format" property to /org/bluez/mesh? An app can read the
> property, perform the appropriate conversion and then invoke Import
> method.
>
> Import method may take an additional string argument "type" to indicate
> the type of the format of the imported node configuration, e.g., "json"
> or "xml".
>
>>>   #include <ell/ell.h>
>>>   
>>>   #include "mesh/mesh-io.h"
>>> @@ -60,7 +61,7 @@ struct bt_mesh {
>>>   	uint8_t max_filters;
>>>   };
>>>   
>>> -struct join_data{
>>> +struct join_data {
>>>   	struct l_dbus_message *msg;
>>>   	struct mesh_agent *agent;
>>>   	const char *sender;
>>> @@ -365,8 +366,8 @@ static void node_init_cb(struct mesh_node
>>> *node, struct mesh_agent *agent)
>>>   
>>>   	if (!acceptor_start(num_ele, join_pending->uuid,
>>> mesh.algorithms,
>>>   				mesh.prov_timeout, agent,
>>> prov_complete_cb,
>>> -				&mesh))
>>> -	{
>>> +				&mesh)) {
>>> +
>>>   		reply = dbus_error(join_pending->msg,
>>> MESH_ERROR_FAILED,
>>>   				"Failed to start provisioning
>>> acceptor");
>>>   		goto fail;
>>> @@ -536,7 +537,7 @@ static struct l_dbus_message *leave_call(struct
>>> l_dbus *dbus,
>>>   	return l_dbus_message_new_method_return(msg);
>>>   }
>>>   
>>> -static void create_network_ready_cb(void *user_data, int status,
>>> +static void create_node_ready_cb(void *user_data, int status,
>>>   							struct
>>> mesh_node *node)
>>>   {
>>>   	struct l_dbus_message *reply;
>>> @@ -593,12 +594,58 @@ static struct l_dbus_message
>>> *create_network_call(struct l_dbus *dbus,
>>>   
>>>   	l_queue_push_tail(pending_queue, pending_msg);
>>>   
>>> -	node_create(app_path, sender, uuid, create_network_ready_cb,
>>> +	node_create(app_path, sender, uuid, create_node_ready_cb,
>>>   								pending
>>> _msg);
>>>   
>>>   	return NULL;
>>>   }
>>>   
>>> +static struct l_dbus_message *import_local_node_call(struct l_dbus
>>> *dbus,
>>> +						struct l_dbus_message
>>> *msg,
>>> +						void *user_data)
>>> +{
>>> +	const char *app_path, *sender;
>>> +	struct l_dbus_message *pending_msg;
>>> +	struct l_dbus_message_iter iter_uuid;
>>> +	const char *json_data;
>>> +	uint8_t *uuid;
>>> +	uint32_t n;
>>> +	struct json_object *jnode;
>>> +
>>> +	l_debug("Import local node request");
>>> +
>>> +	if (!l_dbus_message_get_arguments(msg, "osay", &app_path,
>>> +							&json_data,
>>> &iter_uuid))
>>> +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
>>> +
>>> +	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
>>> ||
>>> +									
>>> n != 16)
>>> +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Bad
>>> dev UUID");
>>> +
>>> +	if (node_find_by_uuid(uuid))
>>> +		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
>>> +							"Node already
>>> exists");
>>> +
>>> +	jnode = json_tokener_parse(json_data);
>>> +
>>> +	sender = l_dbus_message_get_sender(msg);
>>> +	pending_msg = l_dbus_message_ref(msg);
>>> +
>>> +	if (!pending_queue)
>>> +		pending_queue = l_queue_new();
>>> +
>>> +	l_queue_push_tail(pending_queue, pending_msg);
>>> +
>>> +	if (!node_import(app_path, sender, jnode, uuid,
>>> create_node_ready_cb,
>>> +								pending
>>> _msg)) {
>>> +		l_dbus_message_unref(msg);
>>> +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
>>> +							"Node import
>>> failed");
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>>   static void setup_network_interface(struct l_dbus_interface
>>> *iface)
>>>   {
>>>   	l_dbus_interface_method(iface, "Join", 0, join_network_call,
>>> "",
>>> @@ -612,8 +659,14 @@ static void setup_network_interface(struct
>>> l_dbus_interface *iface)
>>>   
>>>   	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
>>>   								"token"
>>> );
>>> +
>>>   	l_dbus_interface_method(iface, "CreateNetwork", 0,
>>> create_network_call,
>>>   					"t", "oay", "token", "app",
>>> "uuid");
>>> +
>>> +	l_dbus_interface_method(iface, "ImportLocalNode", 0,
>>> +					import_local_node_call,
>>> +					"t", "osay", "token",
>>> +					"app", "json_data", "uuid");
>>>   }
>>>   
>>>   bool mesh_dbus_init(struct l_dbus *dbus)
>>> diff --git a/mesh/node.c b/mesh/node.c
>>> index e99858623..991802a6f 100644
>>> --- a/mesh/node.c
>>> +++ b/mesh/node.c
>>> @@ -27,6 +27,7 @@
>>>   
>>>   #include <ell/ell.h>
>>>   #include <json-c/json.h>
>>> +#include <stdio.h>
>>>   
>>>   #include "mesh/mesh-defs.h"
>>>   #include "mesh/mesh.h"
>>> @@ -58,9 +59,12 @@
>>>   #define DEFAULT_CRPL 10
>>>   #define DEFAULT_SEQUENCE_NUMBER 0
>>>   
>>> -#define REQUEST_TYPE_JOIN 0
>>> -#define REQUEST_TYPE_ATTACH 1
>>> -#define REQUEST_TYPE_CREATE 2
>>> +enum request_type {
>>> +	REQUEST_TYPE_JOIN = 0,
>>> +	REQUEST_TYPE_ATTACH,
>>> +	REQUEST_TYPE_CREATE,
>>> +	REQUEST_TYPE_IMPORT,
>>> +};
>>>   
>>>   struct node_element {
>>>   	char *path;
>>> @@ -111,7 +115,18 @@ struct managed_obj_request {
>>>   	void *data;
>>>   	void *cb;
>>>   	void *user_data;
>>> -	uint8_t type;
>>> +	enum request_type type;
>>> +};
>>> +
>>> +struct node_import_request {
>>> +	uint8_t uuid[16];
>>> +	uint8_t dev_key[16];
>>> +	uint8_t net_key[16];
>>> +	bool kr;
>>> +	uint16_t unicast;
>>> +	uint32_t iv_idx;
>>> +	bool iv_update;
>>> +	void *user_data;
>>>   };
>>>   
>>>   static struct l_queue *nodes;
>>> @@ -851,7 +866,7 @@ element_done:
>>>   #define MIN_COMPOSITION_LEN 16
>>>   
>>>   bool node_parse_composition(struct mesh_node *node, uint8_t *data,
>>> -								uint16_
>>> t len)
>>> +			    uint16_t len)
>>>   {
>>>   	struct node_composition *comp;
>>>   	uint16_t features;
>>> @@ -946,7 +961,7 @@ bool node_parse_composition(struct mesh_node
>>> *node, uint8_t *data,
>>>   			vendor_id = l_get_le16(data);
>>>   			mod_id |= (vendor_id << 16);
>>>   			mod = mesh_model_vendor_new(ele->idx,
>>> vendor_id,
>>> -									
>>> mod_id);
>>> +						    mod_id);
>>>   			if (!mod) {
>>>   				element_free(ele);
>>>   				goto fail;
>>> @@ -977,7 +992,6 @@ fail:
>>>   
>>>   	return false;
>>>   }
>>> -
>>>   static void attach_io(void *a, void *b)
>>>   {
>>>   	struct mesh_node *node = a;
>>> @@ -1078,6 +1092,7 @@ static bool validate_model_property(struct
>>> node_element *ele,
>>>   		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
>>>   								&mod_id
>>> )) {
>>>   			struct mesh_model *mod;
>>> +
>>>   			mod = l_queue_find(ele->models, match_model_id,
>>>   				L_UINT_TO_PTR((vendor_id << 16) |
>>> mod_id));
>>>   			if (!mod)
>>> @@ -1366,17 +1381,92 @@ static bool get_app_properties(struct
>>> mesh_node *node, const char *path,
>>>   	return true;
>>>   }
>>>   
>>> -static bool add_local_node(struct mesh_node *node, uint16_t
>>> unicast, bool kr,
>>> -				bool ivu, uint32_t iv_idx, uint8_t
>>> dev_key[16],
>>> -				uint16_t net_key_idx, uint8_t
>>> net_key[16])
>>> +static bool parse_imported_iv_index(json_object *jobj, uint32_t
>>> *idx,
>>> +								bool
>>> *update)
>>>   {
>>> -	node->net = mesh_net_new(node);
>>> +	int tmp;
>>> +	json_object *jvalue;
>>>   
>>> -	if (!nodes)
>>> -		nodes = l_queue_new();
>>> +	if (!json_object_object_get_ex(jobj, "IVindex", &jvalue))
>>> +		return false;
>>>   
>>> -	l_queue_push_tail(nodes, node);
>>> +	tmp = json_object_get_int(jvalue);
>>> +	*idx = (uint32_t) tmp;
>>> +
>>> +	if (!json_object_object_get_ex(jobj, "IVupdate", &jvalue))
>>> +		return false;
>>> +
>>> +	tmp = json_object_get_int(jvalue);
>>> +	*update = (bool)tmp;
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static bool parse_imported_unicast_addr(json_object *jobj,
>>> uint16_t *unicast)
>>> +{
>>> +	json_object *jvalue;
>>> +	char *str;
>>> +
>>> +	if (!json_object_object_get_ex(jobj, "unicastAddress",
>>> &jvalue))
>>> +		return false;
>>> +
>>> +	str = (char *)json_object_get_string(jvalue);
>>> +
>>> +	if (sscanf(str, "%04hx", unicast) != 1)
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>>   
>>> +static bool parse_imported_device_key(json_object *jobj, uint8_t
>>> key_buf[16])
>>> +{
>>> +	json_object *jvalue;
>>> +	char *str;
>>> +
>>> +	if (!key_buf)
>>> +		return false;
>>> +
>>> +	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue))
>>> +		return false;
>>> +
>>> +	str = (char *)json_object_get_string(jvalue);
>>> +
>>> +	if (!str2hex(str, strlen(str), key_buf, 16))
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static bool parse_imported_net_key(json_object *jobj, uint8_t
>>> key_buf[16],
>>> +								bool
>>> *kr)
>>> +{
>>> +	json_object *jvalue;
>>> +	char *str;
>>> +
>>> +	if (!key_buf)
>>> +		return false;
>>> +
>>> +	if (!json_object_object_get_ex(jobj, "netKey", &jvalue))
>>> +		return false;
>>> +
>>> +	str = (char *)json_object_get_string(jvalue);
>>> +
>>> +	if (!str2hex(str, strlen(str), key_buf, 16))
>>> +		return false;
>>> +
>>> +	/* Get key refresh */
>>> +	if (!json_object_object_get_ex(jobj, "keyRefresh", &jvalue))
>>> +		return false;
>>> +
>>> +	*kr = (bool)json_object_get_boolean(jvalue);
>>> +	return true;
>>> +}
>>> +
>>> +
>>> +static bool add_local_node(struct mesh_node *node, uint16_t
>>> unicast, bool kr,
>>> +				bool ivu, uint32_t iv_idx, uint8_t
>>> dev_key[16],
>>> +				uint16_t net_key_idx, uint8_t
>>> net_key[16])
>>> +{
>>>   	if (!storage_set_iv_index(node->net, iv_idx, ivu))
>>>   		return false;
>>>   
>>> @@ -1444,14 +1534,13 @@ static void get_managed_objects_cb(struct
>>> l_dbus_message *msg, void *user_data)
>>>   	}
>>>   
>>>   	if (is_new) {
>>> -		node = l_new(struct mesh_node, 1);
>>> +		node = node_new(req->data);
>>>   		node->elements = l_queue_new();
>>>   	} else {
>>>   		node = req->data;
>>>   	}
>>>   
>>>   	num_ele = 0;
>>> -
>>>   	while (l_dbus_message_iter_next_entry(&objects, &path,
>>> &interfaces)) {
>>>   		struct l_dbus_message_iter properties;
>>>   		const char *interface;
>>> @@ -1547,6 +1636,44 @@ static void get_managed_objects_cb(struct
>>> l_dbus_message *msg, void *user_data)
>>>   
>>>   		cb(node, agent);
>>>   
>>> +	} else if (req->type == REQUEST_TYPE_IMPORT) {
>>> +
>>> +		node_ready_func_t cb = req->cb;
>>> +		struct node_import_request *import_data = req-
>>>> user_data;
>>> +		struct keyring_net_key net_key;
>>> +
>>> +		if (!agent) {
>>> +			l_error("Interface %s not found",
>>> +						MESH_PROVISION_AGENT_IN
>>> TERFACE);
>>> +			goto fail;
>>> +		}
>>> +
>>> +		node->num_ele = num_ele;
>>> +		set_defaults(node);
>>> +		memcpy(node->uuid, import_data->uuid, 16);
>>> +
>>> +		if (!create_node_config(node))
>>> +			goto fail;
>>> +
>>> +		if (!add_local_node(node, import_data->unicast,
>>> import_data->kr,
>>> +				import_data->iv_update, import_data-
>>>> iv_idx,
>>> +				import_data->dev_key, PRIMARY_NET_IDX,
>>> +							import_data-
>>>> net_key))
>>> +			goto fail;
>>> +
>>> +		memcpy(net_key.old_key, import_data->net_key, 16);
>>> +		net_key.net_idx = PRIMARY_NET_IDX;
>>> +		net_key.phase = KEY_REFRESH_PHASE_NONE;
>>> +
>>> +		if (!keyring_put_remote_dev_key(node, import_data-
>>>> unicast,
>>> +						num_ele, import_data-
>>>> dev_key))
>>> +			goto fail;
>>> +
>>> +		if (!keyring_put_net_key(node, PRIMARY_NET_IDX,
>>> &net_key))
>>> +			goto fail;
>>> +
>>> +		cb(import_data->user_data, MESH_ERROR_NONE, node);
>>> +
>>>   	} else {
>>>   		/* Callback for create node request */
>>>   		node_ready_func_t cb = req->cb;
>>> @@ -1672,6 +1799,59 @@ void node_join(const char *app_path, const
>>> char *sender, const uint8_t *uuid,
>>>   					req, l_free);
>>>   }
>>>   
>>> +
>>> +bool node_import(const char *app_path, const char *sender, void
>>> *json_data,
>>> +		const uint8_t *uuid, node_ready_func_t cb, void
>>> *user_data)
>>> +{
>>> +	struct managed_obj_request *req;
>>> +	struct node_import_request *node;
>>> +
>>> +	l_debug("");
>>> +	node = l_new(struct node_import_request, 1);
>>> +	req = l_new(struct managed_obj_request, 1);
>>> +
>>> +	if (!parse_imported_device_key(json_data, node->dev_key)) {
>>> +		l_error("Failed to parse imported device key");
>>> +		goto fail;
>>> +	}
>>> +
>>> +	if (!parse_imported_unicast_addr(json_data, &node->unicast)) {
>>> +		l_error("Failed to parse imported unicast address");
>>> +		goto fail;
>>> +	}
>>> +
>>> +	if (!parse_imported_iv_index(json_data, &node->iv_idx,
>>> +							&node-
>>>> iv_update)) {
>>> +		l_error("Failed to parse imported iv idx");
>>> +		goto fail;
>>> +	}
>>> +
>>> +
>>> +	if (!parse_imported_net_key(json_data, node->net_key, &node-
>>>> kr)) {
>>> +		l_error("Failed to parse imported network key");
>>> +		goto fail;
>>> +	}
>>> +
>>> +	node->user_data = user_data;
>>> +
>>> +	memcpy(node->uuid, uuid, 16);
>>> +	req->data = (void *) uuid;
>>> +	req->user_data = node;
>>> +	req->cb = cb;
>>> +	req->type = REQUEST_TYPE_IMPORT;
>>> +
>>> +	l_dbus_method_call(dbus_get_bus(), sender, app_path,
>>> +					L_DBUS_INTERFACE_OBJECT_MANAGER
>>> ,
>>> +					"GetManagedObjects", NULL,
>>> +					get_managed_objects_cb,
>>> +					req, l_free);
>>> +	return true;
>>> +fail:
>>> +	json_object_put(json_data);
>>> +	l_free(node);
>>> +	return false;
>>> +}
>>> +
>>>   void node_create(const char *app_path, const char *sender, const
>>> uint8_t *uuid,
>>>   					node_ready_func_t cb, void
>>> *user_data)
>>>   {
>>> diff --git a/mesh/node.h b/mesh/node.h
>>> index 142527b30..9559f9178 100644
>>> --- a/mesh/node.h
>>> +++ b/mesh/node.h
>>> @@ -91,6 +91,8 @@ void node_build_attach_reply(struct mesh_node
>>> *node,
>>>   						struct l_dbus_message
>>> *reply);
>>>   void node_create(const char *app_path, const char *sender, const
>>> uint8_t *uuid,
>>>   					node_ready_func_t cb, void
>>> *user_data);
>>> +bool node_import(const char *app_path, const char *sender, void
>>> *jnode,
>>> +		const uint8_t *uuid, node_ready_func_t cb, void
>>> *user_data);
>>>   void node_id_set(struct mesh_node *node, uint16_t node_id);
>>>   uint16_t node_id_get(struct mesh_node *node);
>>>   bool node_dbus_init(struct l_dbus *bus);


Hello,

I fully agree that maintaining several parsers at the runtime is a quite 
bad idea.

Maybe we should think about using "raw" dbus dictionary for passing data 
for import like it's done with model configuration in Attach() return type.
What do You think ?

BR,
Jakub
