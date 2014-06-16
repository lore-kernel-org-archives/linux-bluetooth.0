Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] android/health: Add HDP SDP record
Date: Mon, 16 Jun 2014 10:57:43 +0200
Message-ID: <25055319.SA5P6PKI9t@uw000953>
In-Reply-To: <1402578618-31484-5-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1402578618-31484-5-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thursday 12 of June 2014 16:10:16 Ravi kumar Veeramally wrote:
> SDP record preparation code copied from profiles/health/hdp_uitl.c.
> So applying GSyC copyrights.
> ---
>  android/health.c | 479 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 478 insertions(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 397cef6..45255df 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -3,6 +3,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.

Add info in commit message why this is added ie. copied code?

>   *
>   *
>   *  This library is free software; you can redistribute it and/or
> @@ -31,6 +32,7 @@
>  #include <unistd.h>
>  #include <glib.h>
>  
> +#include "btio/btio.h"
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
>  #include "lib/sdp_lib.h"
> @@ -44,10 +46,18 @@
>  #include "utils.h"
>  #include "bluetooth.h"
>  #include "health.h"
> +#include "mcap-lib.h"
> +
> +#define SVC_HINT_HEALTH			0x00
> +#define HDP_VERSION			0x0101
> +#define DATA_EXCHANGE_SPEC_11073	0x01
>  
>  static bdaddr_t adapter_addr;
>  static struct ipc *hal_ipc = NULL;
>  static struct queue *apps = NULL;
> +static struct mcap_instance *mcap = NULL;
> +static uint32_t record_id = 0;
> +static uint32_t record_state = 0;
>  
>  struct mdep_cfg {
>  	uint8_t role;
> @@ -95,6 +105,14 @@ static void free_health_app(void *data)
>  	free(app);
>  }
>  
> +static bool mdep_by_mdep_role(const void *data, const void *user_data)
> +{
> +	const struct mdep_cfg *mdep = data;
> +	uint16_t role = PTR_TO_INT(user_data);
> +
> +	return mdep->role == role;
> +}
> +
>  static bool app_by_app_id(const void *data, const void *user_data)
>  {
>  	const struct health_app *app = data;
> @@ -103,6 +121,418 @@ static bool app_by_app_id(const void *data, const void *user_data)
>  	return app->id == app_id;
>  }
>  
> +static int register_service_protocols(sdp_record_t *rec,
> +					struct health_app *app)
> +{
> +	uuid_t l2cap_uuid, mcap_c_uuid;
> +	sdp_list_t *l2cap_list, *proto_list = NULL, *mcap_list = NULL;
> +	sdp_list_t *access_proto_list = NULL;
> +	sdp_data_t *psm = NULL, *mcap_ver = NULL;
> +	uint32_t ccpsm;
> +	uint16_t version = MCAP_VERSION;
> +	GError *err = NULL;
> +	int ret = -1;
> +
> +	DBG("");
> +
> +	/* set l2cap information */
> +	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> +	l2cap_list = sdp_list_append(NULL, &l2cap_uuid);
> +	if (!l2cap_list)
> +		goto fail;
> +
> +	ccpsm = mcap_get_ctrl_psm(mcap, &err);
> +	if (err)
> +		goto fail;
> +
> +	psm = sdp_data_alloc(SDP_UINT16, &ccpsm);
> +	if (!psm)
> +		goto fail;
> +
> +	if (!sdp_list_append(l2cap_list, psm))
> +		goto fail;
> +
> +	proto_list = sdp_list_append(NULL, l2cap_list);
> +	if (!proto_list)
> +		goto fail;
> +
> +	/* set mcap information */
> +	sdp_uuid16_create(&mcap_c_uuid, MCAP_CTRL_UUID);
> +	mcap_list = sdp_list_append(NULL, &mcap_c_uuid);
> +	if (!mcap_list)
> +		goto fail;
> +
> +	mcap_ver = sdp_data_alloc(SDP_UINT16, &version);
> +	if (!mcap_ver)
> +		goto fail;
> +
> +	if (!sdp_list_append(mcap_list, mcap_ver))
> +		goto fail;
> +
> +	if (!sdp_list_append(proto_list, mcap_list))
> +		goto fail;
> +
> +	/* attach protocol information to service record */
> +	access_proto_list = sdp_list_append(NULL, proto_list);
> +	if (!access_proto_list)
> +		goto fail;
> +
> +	sdp_set_access_protos(rec, access_proto_list);
> +	ret = 0;
> +
> +fail:
> +	sdp_list_free(l2cap_list, NULL);
> +	sdp_list_free(mcap_list, NULL);
> +	sdp_list_free(proto_list, NULL);
> +	sdp_list_free(access_proto_list, NULL);
> +
> +	if (psm)
> +		sdp_data_free(psm);
> +
> +	if (mcap_ver)
> +		sdp_data_free(mcap_ver);
> +
> +	if (err)
> +		g_error_free(err);
> +
> +	return ret;
> +}
> +
> +static int register_service_profiles(sdp_record_t *rec)
> +{
> +	int ret;
> +	sdp_list_t *profile_list;
> +	sdp_profile_desc_t hdp_profile;
> +
> +	DBG("");
> +
> +	/* set hdp information */
> +	sdp_uuid16_create(&hdp_profile.uuid, HDP_SVCLASS_ID);
> +	hdp_profile.version = HDP_VERSION;
> +	profile_list = sdp_list_append(NULL, &hdp_profile);
> +	if (!profile_list)
> +		return -1;
> +
> +	/* set profile descriptor list */
> +	if (sdp_set_profile_descs(rec, profile_list) < 0)
> +		ret = -1;
> +	else
> +		ret = 0;

Why not just  ret = sdp_set_profile_descs() ?

> +
> +	sdp_list_free(profile_list, NULL);
> +
> +	return ret;
> +}
> +
> +static int register_service_additional_protocols(sdp_record_t *rec,
> +						struct health_app *app)
> +{
> +	int ret = -1;
> +	uuid_t l2cap_uuid, mcap_d_uuid;
> +	sdp_list_t *l2cap_list, *proto_list = NULL, *mcap_list = NULL;
> +	sdp_list_t *access_proto_list = NULL;
> +	sdp_data_t *psm = NULL;
> +	uint32_t dcpsm;
> +	GError *err;
> +
> +	DBG("");
> +
> +	/* set l2cap information */
> +	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> +	l2cap_list = sdp_list_append(NULL, &l2cap_uuid);
> +	if (!l2cap_list)
> +		goto fail;
> +
> +	dcpsm = mcap_get_ctrl_psm(mcap, &err);
> +	if (err)
> +		goto fail;
> +
> +	psm = sdp_data_alloc(SDP_UINT16, &dcpsm);
> +	if (!psm)
> +		goto fail;
> +
> +	if (!sdp_list_append(l2cap_list, psm))
> +		goto fail;
> +
> +	proto_list = sdp_list_append(NULL, l2cap_list);
> +	if (!proto_list)
> +		goto fail;
> +
> +	/* set mcap information */
> +	sdp_uuid16_create(&mcap_d_uuid, MCAP_DATA_UUID);
> +	mcap_list = sdp_list_append(NULL, &mcap_d_uuid);
> +	if (!mcap_list)
> +		goto fail;
> +
> +	if (!sdp_list_append(proto_list, mcap_list))
> +		goto fail;
> +
> +	/* attach protocol information to service record */
> +	access_proto_list = sdp_list_append(NULL, proto_list);
> +	if (!access_proto_list)
> +		goto fail;
> +
> +	sdp_set_add_access_protos(rec, access_proto_list);
> +	ret = 0;
> +
> +fail:
> +	sdp_list_free(l2cap_list, NULL);
> +	sdp_list_free(mcap_list, NULL);
> +	sdp_list_free(proto_list, NULL);
> +	sdp_list_free(access_proto_list, NULL);
> +
> +	if (psm)
> +		sdp_data_free(psm);
> +
> +	if (err)
> +		g_error_free(err);
> +
> +	return ret;
> +}
> +
> +static sdp_list_t *mdeps_to_sdp_features(struct mdep_cfg *mdep)
> +{
> +	sdp_data_t *mdepid, *dtype = NULL, *role = NULL, *descr = NULL;
> +	sdp_list_t *f_list = NULL;
> +
> +	DBG("");
> +
> +	mdepid = sdp_data_alloc(SDP_UINT8, &mdep->id);
> +	if (!mdepid)
> +		return NULL;
> +
> +	dtype = sdp_data_alloc(SDP_UINT16, &mdep->data_type);
> +	if (!dtype)
> +		goto fail;
> +
> +	role = sdp_data_alloc(SDP_UINT8, &mdep->role);
> +	if (!role)
> +		goto fail;
> +
> +	if (mdep->descr) {
> +		descr = sdp_data_alloc(SDP_TEXT_STR8, mdep->descr);
> +		if (!descr)
> +			goto fail;
> +	}
> +
> +	f_list = sdp_list_append(NULL, mdepid);
> +	if (!f_list)
> +		goto fail;
> +
> +	if (!sdp_list_append(f_list, dtype))
> +		goto fail;
> +
> +	if (!sdp_list_append(f_list, role))
> +		goto fail;
> +
> +	if (descr && !sdp_list_append(f_list, descr))
> +		goto fail;
> +
> +	return f_list;
> +
> +fail:
> +	sdp_list_free(f_list, NULL);
> +
> +	if (mdepid)
> +		sdp_data_free(mdepid);
> +
> +	if (dtype)
> +		sdp_data_free(dtype);
> +
> +	if (role)
> +		sdp_data_free(role);
> +
> +	if (descr)
> +		sdp_data_free(descr);
> +
> +	return NULL;
> +}
> +
> +static void free_hdp_list(void *list)
> +{
> +	sdp_list_t *hdp_list = list;
> +
> +	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
> +	hdp_list = NULL;
> +}
> +
> +static void register_features(void *data, void *user_data)
> +{
> +	struct mdep_cfg *mdep = data;
> +	sdp_list_t **sup_features = user_data;
> +	sdp_list_t *hdp_feature;
> +
> +	DBG("");
> +
> +	hdp_feature = mdeps_to_sdp_features(mdep);
> +	if (!hdp_feature)
> +		return;
> +
> +	if (!*sup_features) {
> +		*sup_features = sdp_list_append(NULL, hdp_feature);
> +		if (!*sup_features) {
> +			sdp_list_free(hdp_feature,
> +					(sdp_free_func_t)sdp_data_free);
> +		}

{} are not needed for this if()

> +	} else if (!sdp_list_append(*sup_features, hdp_feature)) {
> +		sdp_list_free(hdp_feature,
> +					(sdp_free_func_t)sdp_data_free);
> +	}
> +}
> +
> +static int register_service_sup_features(sdp_record_t *rec,
> +						struct health_app *app)
> +{
> +	sdp_list_t *sup_features = NULL;
> +
> +	DBG("");
> +
> +	queue_foreach(app->mdeps, register_features, &sup_features);
> +	if (!sup_features)
> +		return -1;
> +
> +	if (sdp_set_supp_feat(rec, sup_features) < 0) {
> +		sdp_list_free(sup_features, free_hdp_list);
> +		return -1;
> +	}
> +
> +	sdp_list_free(sup_features, free_hdp_list);
> +	return 0;
> +}
> +
> +static int register_data_exchange_spec(sdp_record_t *rec)
> +{
> +	sdp_data_t *spec;
> +	uint8_t data_spec = DATA_EXCHANGE_SPEC_11073;
> +	/* As of now only 11073 is supported, so we set it as default */
> +
> +	DBG("");
> +
> +	spec = sdp_data_alloc(SDP_UINT8, &data_spec);
> +	if (!spec)
> +		return -1;
> +
> +	if (sdp_attr_add(rec, SDP_ATTR_DATA_EXCHANGE_SPEC, spec) < 0) {
> +		sdp_data_free(spec);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int register_mcap_features(sdp_record_t *rec)
> +{
> +	sdp_data_t *mcap_proc;
> +	uint8_t mcap_sup_proc = MCAP_SUP_PROC;
> +
> +	DBG("");
> +
> +	mcap_proc = sdp_data_alloc(SDP_UINT8, &mcap_sup_proc);
> +	if (!mcap_proc)
> +		return -1;
> +
> +	if (sdp_attr_add(rec, SDP_ATTR_MCAP_SUPPORTED_PROCEDURES,
> +							mcap_proc) < 0) {
> +		sdp_data_free(mcap_proc);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int set_sdp_services_uuid(sdp_record_t *rec, uint8_t role)
> +{
> +	uuid_t source, sink;
> +	sdp_list_t *list = NULL;
> +
> +	sdp_uuid16_create(&sink, HDP_SINK_SVCLASS_ID);
> +	sdp_uuid16_create(&source, HDP_SOURCE_SVCLASS_ID);
> +	sdp_get_service_classes(rec, &list);
> +
> +	switch (role) {
> +	case HAL_HEALTH_MDEP_ROLE_SOURCE:
> +		if (!sdp_list_find(list, &source, sdp_uuid_cmp))
> +			list = sdp_list_append(list, &source);
> +		break;
> +

This empty line is not needed.

> +	case HAL_HEALTH_MDEP_ROLE_SINK:
> +		if (!sdp_list_find(list, &sink, sdp_uuid_cmp))
> +			list = sdp_list_append(list, &sink);

add break here.

> +	}
> +
> +	if (sdp_set_service_classes(rec, list) < 0) {
> +		sdp_list_free(list, NULL);
> +		return -1;
> +	}
> +
> +	sdp_list_free(list, NULL);
> +
> +	return 0;
> +}
> +
> +static int health_sdp_record(struct health_app *app)
> +{
> +	sdp_record_t *rec;
> +	uint8_t role;
> +
> +	DBG("");
> +
> +	if (record_id > 0) {
> +		bt_adapter_remove_record(record_id);
> +		record_id = 0;
> +	}

Why is this needed?

> +
> +	rec = sdp_record_alloc();
> +	if (!rec)
> +		return -1;
> +
> +	role = HAL_HEALTH_MDEP_ROLE_SOURCE;
> +	if (queue_find(app->mdeps, mdep_by_mdep_role, INT_TO_PTR(role)))
> +		set_sdp_services_uuid(rec, role);
> +
> +	role = HAL_HEALTH_MDEP_ROLE_SINK;
> +	if (queue_find(app->mdeps, mdep_by_mdep_role, INT_TO_PTR(role)))
> +		set_sdp_services_uuid(rec, role);
> +
> +	sdp_set_info_attr(rec, app->service_name, app->provider_name,
> +							app->service_descr);
> +
> +	if (register_service_protocols(rec, app) < 0)
> +		goto fail;
> +
> +	if (register_service_profiles(rec) < 0)
> +		goto fail;
> +
> +	if (register_service_additional_protocols(rec, app) < 0)
> +		goto fail;
> +
> +	if (register_service_sup_features(rec, app) < 0)
> +		goto fail;
> +
> +	if (register_data_exchange_spec(rec) < 0)
> +		goto fail;
> +
> +	if (register_mcap_features(rec) < 0)
> +		goto fail;
> +
> +	if (sdp_set_record_state(rec, record_state++) < 0)
> +		goto fail;
> +
> +	if (bt_adapter_add_record(rec, SVC_HINT_HEALTH) < 0) {
> +		error("Failed to register HEALTH record");
> +		goto fail;
> +	}
> +
> +	record_id = rec->handle;
> +
> +	return 0;
> +
> +fail:
> +	sdp_record_free(rec);
> +
> +	return -1;
> +}
> +
>  static void bt_health_register_app(const void *buf, uint16_t buf_len)
>  {
>  	const struct hal_cmd_health_reg_app *cmd = buf;
> @@ -222,7 +652,13 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
>  		goto end;
>  	}
>  
> -	/* TODO: Create MCAP instance and prepare SDP profile */
> +	/* add sdp record from app data */
> +	if (health_sdp_record(app) < 0) {
> +		error("Error creating HDP SDP record");
> +		status = HAL_STATUS_FAILED;
> +		goto fail;
> +	}
> +
>  	status = HAL_STATUS_SUCCESS;
>  
>  fail:
> @@ -250,6 +686,11 @@ static void bt_health_unregister_app(const void *buf, uint16_t len)
>  		return;
>  	}
>  
> +	if (record_id > 0) {
> +		bt_adapter_remove_record(record_id);
> +		record_id = 0;
> +	}
> +
>  	free_health_app(app);
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>  				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_SUCCESS);
> @@ -289,14 +730,49 @@ static const struct ipc_handler cmd_handlers[] = {
>  				sizeof(struct hal_cmd_health_destroy_channel) },
>  };
>  
> +static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
> +{
> +	DBG("Not implemented");
> +}
> +
> +static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
> +{
> +	DBG("Not implemented");
> +}
> +
> +static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
> +{
> +	DBG("Not implemented");
> +}
> +
> +static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
> +{
> +	DBG("Not implemented");
> +}
> +
>  bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>  {
> +	GError *err = NULL;
> +
>  	DBG("");
>  
>  	bacpy(&adapter_addr, addr);
>  
> +	mcap = mcap_create_instance(&adapter_addr, BT_IO_SEC_MEDIUM, 0, 0,
> +					mcl_connected, mcl_reconnected,
> +					mcl_disconnected, mcl_uncached,
> +					NULL, /* CSP is not used right now */
> +					NULL, &err);
> +
> +	if (!mcap) {
> +		error("Error creating MCAP instance : %s", err->message);
> +		g_error_free(err);
> +		return false;
> +	}
> +
>  	hal_ipc = ipc;
>  	apps = queue_new();
> +

Move this in patch that added queue_new().

>  	ipc_register(hal_ipc, HAL_SERVICE_ID_HEALTH, cmd_handlers,
>  						G_N_ELEMENTS(cmd_handlers));
>  
> @@ -307,6 +783,7 @@ void bt_health_unregister(void)
>  {
>  	DBG("");
>  
> +	mcap_instance_unref(mcap);
>  	queue_destroy(apps, free_health_app);
>  	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HEALTH);
>  	hal_ipc = NULL;
> 

-- 
Best regards, 
Szymon Janc
