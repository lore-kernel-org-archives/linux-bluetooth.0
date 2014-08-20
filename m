Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android/avrcp: Register CT record
Date: Wed, 20 Aug 2014 12:15:54 +0200
Message-ID: <5440125.NYeb5SyJSk@leonov>
In-Reply-To: <1408528873-14870-1-git-send-email-luiz.dentz@gmail.com>
References: <1408528873-14870-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday 20 of August 2014 13:01:13 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes TC_SDAS_BV_03_I which requires CT record.
> ---
>  android/avrcp.c | 103
> +++++++++++++++++++++++++++++++++++++++++++++++++++----- 1 file changed, 95
> insertions(+), 8 deletions(-)
> 
> diff --git a/android/avrcp.c b/android/avrcp.c
> index 8c5cf8a..0f4750f 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -55,7 +55,8 @@
>  #define AVRCP_FEATURE_CATEGORY_4	0x0008
> 
>  static bdaddr_t adapter_addr;
> -static uint32_t record_id = 0;
> +static uint32_t record_tg_id = 0;
> +static uint32_t record_ct_id = 0;
>  static GSList *devices = NULL;
>  static GIOChannel *server = NULL;
>  static struct ipc *hal_ipc = NULL;
> @@ -397,7 +398,7 @@ static const struct ipc_handler cmd_handlers[] = {
>  	{ handle_set_volume, false, sizeof(struct hal_cmd_avrcp_set_volume) },
>  };
> 
> -static sdp_record_t *avrcp_record(void)
> +static sdp_record_t *avrcp_tg_record(void)
>  {
>  	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
>  	uuid_t root_uuid, l2cap, avctp, avrtg;
> @@ -465,6 +466,76 @@ static sdp_record_t *avrcp_record(void)
>  	return record;
>  }
> 
> +static sdp_record_t *avrcp_ct_record(void)
> +{
> +	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> +	uuid_t root_uuid, l2cap, avctp, avrct, avrctr;
> +	sdp_profile_desc_t profile[1];
> +	sdp_list_t *aproto, *proto[2];
> +	sdp_record_t *record;
> +	sdp_data_t *psm, *version, *features;
> +	uint16_t lp = AVCTP_CONTROL_PSM;
> +	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0104;
> +	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> +						AVRCP_FEATURE_CATEGORY_2 |
> +						AVRCP_FEATURE_CATEGORY_3 |
> +						AVRCP_FEATURE_CATEGORY_4);
> +
> +	record = sdp_record_alloc();
> +	if (!record)
> +		return NULL;
> +
> +	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> +	root = sdp_list_append(NULL, &root_uuid);
> +	sdp_set_browse_groups(record, root);
> +
> +	/* Service Class ID List */
> +	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
> +	svclass_id = sdp_list_append(NULL, &avrct);
> +	sdp_uuid16_create(&avrctr, AV_REMOTE_CONTROLLER_SVCLASS_ID);
> +	svclass_id = sdp_list_append(svclass_id, &avrctr);
> +	sdp_set_service_classes(record, svclass_id);
> +
> +	/* Protocol Descriptor List */
> +	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> +	proto[0] = sdp_list_append(NULL, &l2cap);
> +	psm = sdp_data_alloc(SDP_UINT16, &lp);
> +	proto[0] = sdp_list_append(proto[0], psm);
> +	apseq = sdp_list_append(NULL, proto[0]);
> +
> +	sdp_uuid16_create(&avctp, AVCTP_UUID);
> +	proto[1] = sdp_list_append(NULL, &avctp);
> +	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
> +	proto[1] = sdp_list_append(proto[1], version);
> +	apseq = sdp_list_append(apseq, proto[1]);
> +
> +	aproto = sdp_list_append(NULL, apseq);
> +	sdp_set_access_protos(record, aproto);
> +
> +	/* Bluetooth Profile Descriptor List */
> +	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
> +	profile[0].version = avrcp_ver;
> +	pfseq = sdp_list_append(NULL, &profile[0]);
> +	sdp_set_profile_descs(record, pfseq);
> +
> +	features = sdp_data_alloc(SDP_UINT16, &feat);
> +	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
> +
> +	sdp_set_info_attr(record, "AVRCP CT", NULL, NULL);
> +
> +	free(psm);
> +	free(version);
> +	sdp_list_free(proto[0], NULL);
> +	sdp_list_free(proto[1], NULL);
> +	sdp_list_free(apseq, NULL);
> +	sdp_list_free(pfseq, NULL);
> +	sdp_list_free(aproto, NULL);
> +	sdp_list_free(root, NULL);
> +	sdp_list_free(svclass_id, NULL);
> +
> +	return record;
> +}
> +
>  static void avrcp_device_free(void *data)
>  {
>  	struct avrcp_device *dev = data;
> @@ -1014,18 +1085,31 @@ bool bt_avrcp_register(struct ipc *ipc, const
> bdaddr_t *addr, uint8_t mode) return false;
>  	}
> 
> -	rec = avrcp_record();
> +	rec = avrcp_tg_record();
>  	if (!rec) {
> -		error("Failed to allocate AVRCP record");
> +		error("Failed to allocate AVRCP TG record");
>  		goto fail;
>  	}
> 
>  	if (bt_adapter_add_record(rec, 0) < 0) {
> -		error("Failed to register AVRCP record");
> +		error("Failed to register AVRCP TG record");
>  		sdp_record_free(rec);
>  		goto fail;
>  	}
> -	record_id = rec->handle;
> +	record_tg_id = rec->handle;
> +
> +	rec = avrcp_ct_record();
> +	if (!rec) {
> +		error("Failed to allocate AVRCP CT record");

Shouldn't TG record be removed here, or maybe in failed label?

> +		goto fail;
> +	}
> +
> +	if (bt_adapter_add_record(rec, 0) < 0) {
> +		error("Failed to register AVRCP CT record");
> +		sdp_record_free(rec);

Ditto.

> +		goto fail;
> +	}
> +	record_ct_id = rec->handle;
> 
>  	hal_ipc = ipc;
> 
> @@ -1051,8 +1135,11 @@ void bt_avrcp_unregister(void)
>  	ipc_unregister(hal_ipc, HAL_SERVICE_ID_AVRCP);
>  	hal_ipc = NULL;
> 
> -	bt_adapter_remove_record(record_id);
> -	record_id = 0;
> +	bt_adapter_remove_record(record_tg_id);
> +	record_tg_id = 0;
> +
> +	bt_adapter_remove_record(record_ct_id);
> +	record_ct_id = 0;
> 
>  	if (server) {
>  		g_io_channel_shutdown(server, TRUE, NULL);

-- 
BR
Szymon Janc
