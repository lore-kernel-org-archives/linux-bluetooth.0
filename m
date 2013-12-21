Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pan: Add pan sdp record for NAP role
Date: Sat, 21 Dec 2013 14:38:20 +0100
Message-ID: <2088281.n4DgGCmNhB@athlon>
In-Reply-To: <1387547621-26455-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387547621-26455-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 20 December 2013 15:53:41 Ravi kumar Veeramally wrote:
> ---
>  android/pan.c | 91
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed,
> 91 insertions(+)
> 
> diff --git a/android/pan.c b/android/pan.c
> index 689c7ef..f322f20 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -44,9 +44,12 @@
>  #include "utils.h"
>  #include "bluetooth.h"
> 
> +#define SVC_HINT_CAPTURING 0x08

Shouldn't this be SVC_HINT_NETWORKING 0x02 ?

> +
>  static bdaddr_t adapter_addr;
>  GSList *devices = NULL;
>  uint8_t local_role = HAL_PAN_ROLE_NONE;
> +static uint32_t record_id = 0;
> 
>  struct pan_device {
>  	char		iface[16];
> @@ -335,20 +338,106 @@ static const struct ipc_handler cmd_handlers[] = {
>  	{ bt_pan_disconnect, false, sizeof(struct hal_cmd_pan_disconnect) },
>  };
> 
> +static sdp_record_t *pan_record(void)
> +{
> +	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
> +	uuid_t root_uuid, pan, l2cap, bnep;
> +	sdp_profile_desc_t profile[1];
> +	sdp_list_t *proto[2];
> +	sdp_data_t *v, *p;
> +	uint16_t psm = BNEP_PSM, version = 0x0100;
> +	uint16_t security = 0x0001, type = 0xfffe;
> +	uint32_t rate = 0;
> +	const char *desc = "Network service", *name = "bnep";
> +	sdp_record_t *record;
> +	uint16_t ptype[] = { 0x0800, /* IPv4 */ 0x0806,  /* ARP */ };
> +	sdp_data_t *head, *pseq, *data;
> +
> +	record = sdp_record_alloc();
> +	if (!record)
> +		return NULL;
> +
> +	record->attrlist = NULL;
> +	record->pattern = NULL;
> +
> +	sdp_uuid16_create(&pan, NAP_SVCLASS_ID);
> +	svclass = sdp_list_append(NULL, &pan);
> +	sdp_set_service_classes(record, svclass);
> +	sdp_uuid16_create(&profile[0].uuid, NAP_PROFILE_ID);
> +	profile[0].version = 0x0100;
> +	pfseq = sdp_list_append(NULL, &profile[0]);
> +	sdp_set_profile_descs(record, pfseq);
> +	sdp_set_info_attr(record, name, NULL, desc);
> +	sdp_attr_add_new(record, SDP_ATTR_NET_ACCESS_TYPE, SDP_UINT16, &type);
> +	sdp_attr_add_new(record, SDP_ATTR_MAX_NET_ACCESSRATE,
> +							SDP_UINT32, &rate);
> +	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> +	root = sdp_list_append(NULL, &root_uuid);
> +	sdp_set_browse_groups(record, root);
> +	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> +	proto[0] = sdp_list_append(NULL, &l2cap);
> +	p = sdp_data_alloc(SDP_UINT16, &psm);
> +	proto[0] = sdp_list_append(proto[0], p);
> +	apseq = sdp_list_append(NULL, proto[0]);
> +	sdp_uuid16_create(&bnep, BNEP_UUID);
> +	proto[1] = sdp_list_append(NULL, &bnep);
> +	v = sdp_data_alloc(SDP_UINT16, &version);
> +	proto[1] = sdp_list_append(proto[1], v);
> +
> +	head = sdp_data_alloc(SDP_UINT16, &ptype[0]);
> +	data = sdp_data_alloc(SDP_UINT16, &ptype[1]);
> +	sdp_seq_append(head, data);
> +
> +	pseq = sdp_data_alloc(SDP_SEQ16, head);
> +	proto[1] = sdp_list_append(proto[1], pseq);
> +	apseq = sdp_list_append(apseq, proto[1]);
> +	aproto = sdp_list_append(NULL, apseq);
> +	sdp_set_access_protos(record, aproto);
> +	sdp_add_lang_attr(record);
> +	sdp_attr_add_new(record, SDP_ATTR_SECURITY_DESC, SDP_UINT16, &security);
> +

I would group those calls in similar fashion we have in other service record 
creating functions (browse group, svc, profile id, protocols etc... see 
android/a2dp.c or android/socket.c).

> +	sdp_data_free(p);
> +	sdp_data_free(v);
> +	sdp_list_free(apseq, NULL);
> +	sdp_list_free(root, NULL);
> +	sdp_list_free(aproto, NULL);
> +	sdp_list_free(proto[0], NULL);
> +	sdp_list_free(proto[1], NULL);
> +	sdp_list_free(svclass, NULL);
> +	sdp_list_free(pfseq, NULL);
> +
> +	return record;
> +}
> +
>  bool bt_pan_register(const bdaddr_t *addr)
>  {
> +	sdp_record_t *rec;
>  	int err;
> 
>  	DBG("");
> 
>  	bacpy(&adapter_addr, addr);
> 
> +	rec = pan_record();
> +	if (!rec) {
> +		error("Failed to allocate PAN record");
> +		return false;
> +	}
> +
> +	if (bt_adapter_add_record(rec, SVC_HINT_CAPTURING) < 0) {
> +		error("Failed to register PAN record");
> +		sdp_record_free(rec);
> +		return false;
> +	}
> +
>  	err = bnep_init();
>  	if (err) {
>  		error("bnep init failed");
> +		sdp_record_free(rec);
>  		return false;
>  	}
> 
> +	record_id = rec->handle;
>  	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
>  						G_N_ELEMENTS(cmd_handlers));
> 
> @@ -362,4 +451,6 @@ void bt_pan_unregister(void)
>  	bnep_cleanup();
> 
>  	ipc_unregister(HAL_SERVICE_ID_PAN);
> +	bt_adapter_remove_record(record_id);
> +	record_id = 0;
>  }

-- 
BR
Szymon Janc
szymon.janc@gmail.com
