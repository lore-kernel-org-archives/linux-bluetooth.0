Return-Path: <cyrus@holtmann.org>
Message-ID: <4D5ED4A9.9060308@codeaurora.org>
Date: Fri, 18 Feb 2011 12:20:57 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Brian Gix <bgix@codeaurora.org>
CC: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com,
	padovan@profusion.mobi, anderson.lizardo@openbossa.org
Subject: Re: [PATCH 1/1] Add SDP registration of Primary GATT services
References: <1298059898-27366-1-git-send-email-bgix@codeaurora.org> <1298059898-27366-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1298059898-27366-2-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please ignore --> I have some merging to do.


On 2/18/2011 12:11 PM, Brian Gix wrote:
> Add capability to register SDP record for Primary Services.
> ---
>   attrib/example.c    |   29 +++++++++-
>   src/attrib-server.c |  162 +++++++++++++++++++++++++++++++++++++++------------
>   src/attrib-server.h |    2 +
>   3 files changed, 155 insertions(+), 38 deletions(-)
>
> diff --git a/attrib/example.c b/attrib/example.c
> index 1911912..f0648e4 100644
> --- a/attrib/example.c
> +++ b/attrib/example.c
> @@ -59,6 +59,9 @@
>   #define FMT_KILOGRAM_UUID		0xA010
>   #define FMT_HANGING_UUID		0xA011
>
> +#define SDP_RECORD_COUNT 10
> +uint32_t sdp_handles[SDP_RECORD_COUNT];
> +
>   static int register_attributes(void)
>   {
>   	const char *desc_out_temp = "Outside Temperature";
> @@ -77,6 +80,7 @@ static int register_attributes(void)
>   	uint8_t atval[256];
>   	uuid_t uuid;
>   	int len;
> +	int i = 0;
>
>   	/* Battery state service: primary service definition */
>   	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> @@ -101,6 +105,11 @@ static int register_attributes(void)
>   	atval[1] = 0x00;
>   	attrib_db_add(0x0111,&uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
>
> +	/* Add an SDP record for the above service */
> +	sdp_handles[i] = attrib_create_sdp(0x0100, "Battery State Service");
> +	if (sdp_handles[i])
> +		i++;
> +
>   	/* Thermometer: primary service definition */
>   	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>   	att_put_u16(THERM_HUMIDITY_SVC_UUID,&atval[0]);
> @@ -116,7 +125,8 @@ static int register_attributes(void)
>   	/* Thermometer: Include */
>   	att_put_u16(0x0550,&atval[0]);
>   	att_put_u16(0x0568,&atval[2]);
> -	attrib_db_add(0x0202,&uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
> +	att_put_u16(VENDOR_SPECIFIC_SVC_UUID,&atval[4]);
> +	attrib_db_add(0x0202,&uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
>
>   	/* Thermometer: temperature characteristic */
>   	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
> @@ -173,6 +183,11 @@ static int register_attributes(void)
>   	strncpy((char *) atval, desc_out_hum, len);
>   	attrib_db_add(0x0214,&uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
>
> +	/* Add an SDP record for the above service */
> +	sdp_handles[i] = attrib_create_sdp(0x0200, "Thermometer");
> +	if (sdp_handles[i])
> +		i++;
> +
>   	/* Secondary Service: Manufacturer Service */
>   	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
>   	att_put_u16(MANUFACTURER_SVC_UUID,&atval[0]);
> @@ -299,6 +314,11 @@ static int register_attributes(void)
>   	strncpy((char *) atval, desc_weight, len);
>   	attrib_db_add(0x0685,&uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
>
> +	/* Add an SDP record for the above service */
> +	sdp_handles[i] = attrib_create_sdp(0x0680, "Weight Service");
> +	if (sdp_handles[i])
> +		i++;
> +
>   	return 0;
>   }
>
> @@ -309,4 +329,11 @@ int server_example_init(void)
>
>   void server_example_exit(void)
>   {
> +	int i;
> +
> +	for (i = 0; i<  SDP_RECORD_COUNT; i++)
> +		if (sdp_handles[i]) {
> +			attrib_free_sdp(sdp_handles[i]);
> +			sdp_handles[i] = 0;
> +		}
>   }
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 85b39a8..c6438bd 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -70,7 +70,8 @@ struct group_elem {
>   static GIOChannel *l2cap_io = NULL;
>   static GIOChannel *le_io = NULL;
>   static GSList *clients = NULL;
> -static uint32_t sdp_handle = 0;
> +static uint32_t gatt_sdp_handle = 0;
> +static uint32_t gap_sdp_handle = 0;
>
>   static uuid_t prim_uuid = {
>   			.type = SDP_UUID16,
> @@ -81,14 +82,19 @@ static uuid_t snd_uuid = {
>   			.value.uuid16 = GATT_SND_SVC_UUID
>   };
>
> -static sdp_record_t *server_record_new(void)
> +static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
>   {
> -	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
> +	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
>   	uuid_t root_uuid, proto_uuid, gatt_uuid, l2cap;
> -	sdp_profile_desc_t profile;
>   	sdp_record_t *record;
>   	sdp_data_t *psm, *sh, *eh;
> -	uint16_t lp = GATT_PSM, start = 0x0001, end = 0xffff;
> +	uint16_t lp = GATT_PSM;
> +
> +	if (uuid == NULL)
> +		return NULL;
> +
> +	if (start>  end)
> +		return NULL;
>
>   	record = sdp_record_alloc();
>   	if (record == NULL)
> @@ -99,17 +105,10 @@ static sdp_record_t *server_record_new(void)
>   	sdp_set_browse_groups(record, root);
>   	sdp_list_free(root, NULL);
>
> -	sdp_uuid16_create(&gatt_uuid, GENERIC_ATTRIB_SVCLASS_ID);
> -	svclass_id = sdp_list_append(NULL,&gatt_uuid);
> +	svclass_id = sdp_list_append(NULL, uuid);
>   	sdp_set_service_classes(record, svclass_id);
>   	sdp_list_free(svclass_id, NULL);
>
> -	sdp_uuid16_create(&profile.uuid, GENERIC_ATTRIB_PROFILE_ID);
> -	profile.version = 0x0100;
> -	profiles = sdp_list_append(NULL,&profile);
> -	sdp_set_profile_descs(record, profiles);
> -	sdp_list_free(profiles, NULL);
> -
>   	sdp_uuid16_create(&l2cap, L2CAP_UUID);
>   	proto[0] = sdp_list_append(NULL,&l2cap);
>   	psm = sdp_data_alloc(SDP_UINT16,&lp);
> @@ -127,11 +126,6 @@ static sdp_record_t *server_record_new(void)
>   	aproto = sdp_list_append(NULL, apseq);
>   	sdp_set_access_protos(record, aproto);
>
> -	sdp_set_info_attr(record, "Generic Attribute Profile", "BlueZ", NULL);
> -
> -	sdp_set_url_attr(record, "http://www.bluez.org/",
> -			"http://www.bluez.org/", "http://www.bluez.org/");
> -
>   	sdp_set_service_id(record, gatt_uuid);
>
>   	sdp_data_free(psm);
> @@ -176,6 +170,40 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
>   	return 0;
>   }
>
> +static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
> +{
> +	struct attribute *a, *attrib = NULL;
> +	GSList *l;
> +	gboolean found = FALSE;
> +
> +	if (end == NULL)
> +		return NULL;
> +
> +	for (l = database; l; l = l->next) {
> +		a = l->data;
> +
> +		if (a->handle<  start)
> +			continue;
> +
> +		if ((a->handle == start)&&
> +				sdp_uuid_cmp(&a->uuid,&prim_uuid) == 0) {
> +			found = TRUE;
> +			*end = start;
> +			attrib = a;
> +			continue;
> +		} else if (!found)
> +			break;
> +
> +		if (sdp_uuid_cmp(&a->uuid,&prim_uuid) == 0 ||
> +				sdp_uuid_cmp(&a->uuid,&snd_uuid) == 0)
> +			break;
> +		else
> +			*end = a->handle;
> +	}
> +
> +	return attrib;
> +}
> +
>   static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
>   						uint16_t end, uuid_t *uuid,
>   						uint8_t *pdu, int len)
> @@ -607,7 +635,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
>   static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
>   		uint8_t *pdu, int len)
>   {
> -	channel->mtu = MIN(mtu, ATT_MAX_MTU);
> +	channel->mtu = MIN(mtu, channel->mtu);
>
>   	return enc_mtu_resp(channel->mtu, pdu, len);
>   }
> @@ -794,7 +822,7 @@ static void confirm_event(GIOChannel *io, void *user_data)
>   	return;
>   }
>
> -static void register_core_services(void)
> +static gboolean register_core_services(void)
>   {
>   	uint8_t atval[256];
>   	uuid_t uuid;
> @@ -820,17 +848,37 @@ static void register_core_services(void)
>
>   	/* TODO: Implement Appearance characteristic. It is mandatory for
>   	 * Peripheral/Central GAP roles. */
> +	gap_sdp_handle = attrib_create_sdp(0x0001, "Generic Access Profile");
> +
> +	if (gap_sdp_handle == 0) {
> +		error("Failed to register GAP service record");
> +		goto failed;
> +	}
>
>   	/* GATT service: primary service definition */
>   	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>   	att_put_u16(GENERIC_ATTRIB_PROFILE_ID,&atval[0]);
>   	attrib_db_add(0x0010,&uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
> +
> +	gatt_sdp_handle = attrib_create_sdp(0x0010,
> +						"Generic Attribute Profile");
> +	if (gatt_sdp_handle == 0) {
> +		error("Failed to register GATT service record");
> +		goto failed;
> +	}
> +
> +	return TRUE;
> +
> +failed:
> +	if (gap_sdp_handle)
> +		remove_record_from_server(gap_sdp_handle);
> +
> +	return FALSE;
>   }
>
>   int attrib_server_init(void)
>   {
>   	GError *gerr = NULL;
> -	sdp_record_t *record;
>
>   	/* BR/EDR socket */
>   	l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
> @@ -846,21 +894,8 @@ int attrib_server_init(void)
>   		return -1;
>   	}
>
> -	record = server_record_new();
> -	if (record == NULL) {
> -		error("Unable to create GATT service record");
> +	if (!register_core_services())
>   		goto failed;
> -	}
> -
> -	if (add_record_to_server(BDADDR_ANY, record)<  0) {
> -		error("Failed to register GATT service record");
> -		sdp_record_free(record);
> -		goto failed;
> -	}
> -
> -	sdp_handle = record->handle;
> -
> -	register_core_services();
>
>   	if (!main_opts.le)
>   		return 0;
> @@ -919,8 +954,61 @@ void attrib_server_exit(void)
>
>   	g_slist_free(clients);
>
> -	if (sdp_handle)
> -		remove_record_from_server(sdp_handle);
> +	if (gatt_sdp_handle)
> +		remove_record_from_server(gatt_sdp_handle);
> +
> +	if (gap_sdp_handle)
> +		remove_record_from_server(gap_sdp_handle);
> +}
> +
> +uint32_t attrib_create_sdp(uint16_t handle, const char *name)
> +{
> +	sdp_record_t *record;
> +	struct attribute *a;
> +	uint16_t end = 0;
> +	uuid_t svc;
> +
> +	a = find_primary_range(handle,&end);
> +
> +	if (a == NULL)
> +		goto failed;
> +
> +	if (a->len == 2) {
> +		svc.type = SDP_UUID16;
> +		svc.value.uuid16 = att_get_u16(a->data);
> +	} else if (a->len == 16) {
> +		svc.type = SDP_UUID128;
> +		memcpy(&svc.value.uuid128, a->data, sizeof(uint128_t));
> +	} else
> +		goto failed;
> +
> +	record = server_record_new(&svc, handle, end);
> +
> +	if (record == NULL)
> +		goto failed;
> +
> +	if (name)
> +		sdp_set_info_attr(record, name, "BlueZ", NULL);
> +
> +	if (svc.type == SDP_UUID16&&
> +			svc.value.uuid16 == GENERIC_ACCESS_PROFILE_ID) {
> +		sdp_set_url_attr(record, "http://www.bluez.org/",
> +				"http://www.bluez.org/",
> +				"http://www.bluez.org/");
> +	}
> +
> +	if (add_record_to_server(BDADDR_ANY, record)<  0)
> +		sdp_record_free(record);
> +	else
> +		return record->handle;
> +
> +failed:
> +	return 0;
> +}
> +
> +void attrib_free_sdp(uint32_t sdp_handle)
> +{
> +	remove_record_from_server(sdp_handle);
>   }
>
>   int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
> diff --git a/src/attrib-server.h b/src/attrib-server.h
> index ba90ff4..34236e4 100644
> --- a/src/attrib-server.h
> +++ b/src/attrib-server.h
> @@ -30,3 +30,5 @@ int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
>   int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
>   								int len);
>   int attrib_db_del(uint16_t handle);
> +uint32_t attrib_create_sdp(uint16_t handle, const char *name);
> +void attrib_free_sdp(uint32_t sdp_handle);


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
