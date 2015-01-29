Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/pan: Register PANU sdp record while registering PAN
Date: Thu, 29 Jan 2015 16:50:17 +0100
Message-ID: <4419670.K9JxPat6Zm@leonov>
In-Reply-To: <1422362081-24407-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1422362081-24407-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 27 of January 2015 13:34:41 Grzegorz Kolodziejczyk wrote:
> This patch adds support for registering and unregistering PANU sdp
> record.
> It's related with PTS test case: TC_SDP_PANU_BV_01_C, which requires
> PANU sdp record to be registered.
> ---
>  android/pan.c | 98
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++----- 1 file changed,
> 91 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pan.c b/android/pan.c
> index e401001..3471805 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -77,6 +77,7 @@ static bdaddr_t adapter_addr;
>  static GSList *devices = NULL;
>  static uint8_t local_role = HAL_PAN_ROLE_NONE;
>  static uint32_t nap_rec_id = 0;
> +static uint32_t panu_rec_id = 0;
>  static GIOChannel *nap_io = NULL;
>  static bool nap_bridge_mode = false;
>  static struct ipc *hal_ipc = NULL;
> @@ -785,9 +786,84 @@ static sdp_record_t *nap_record(void)
>  	return record;
>  }
> 
> +static sdp_record_t *panu_record(void)
> +{
> +	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
> +	uuid_t root_uuid, panu, l2cap, bnep;
> +	sdp_profile_desc_t profile[1];
> +	sdp_list_t *proto[2];
> +	sdp_data_t *v, *p;
> +	uint16_t psm = BNEP_PSM, version = 0x0100;
> +	uint16_t security = 0x0001, type = 0xfffe;
> +	uint32_t rate = 0;
> +	const char *desc = "PAN User", *name = "Network Service";
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
> +	sdp_uuid16_create(&panu, PANU_SVCLASS_ID);
> +	svclass = sdp_list_append(NULL, &panu);
> +	sdp_set_service_classes(record, svclass);
> +
> +	sdp_uuid16_create(&profile[0].uuid, PANU_PROFILE_ID);
> +	profile[0].version = 0x0100;
> +	pfseq = sdp_list_append(NULL, &profile[0]);
> +	sdp_set_profile_descs(record, pfseq);
> +	sdp_set_info_attr(record, name, NULL, desc);
> +	sdp_attr_add_new(record, SDP_ATTR_NET_ACCESS_TYPE, SDP_UINT16, &type);
> +	sdp_attr_add_new(record, SDP_ATTR_MAX_NET_ACCESSRATE,
> +							SDP_UINT32, &rate);
> +
> +	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> +	root = sdp_list_append(NULL, &root_uuid);
> +	sdp_set_browse_groups(record, root);
> +
> +	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> +	proto[0] = sdp_list_append(NULL, &l2cap);
> +	p = sdp_data_alloc(SDP_UINT16, &psm);
> +	proto[0] = sdp_list_append(proto[0], p);
> +	apseq = sdp_list_append(NULL, proto[0]);
> +
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
>  bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>  {
> -	sdp_record_t *nap_rec;
> +	sdp_record_t *nap_rec, *panu_rec;
>  	int err;
> 
>  	DBG("");
> @@ -795,33 +871,39 @@ bool bt_pan_register(struct ipc *ipc, const bdaddr_t
> *addr, uint8_t mode) bacpy(&adapter_addr, addr);
> 
>  	nap_rec = nap_record();
> -	if (!nap_rec) {
> -		error("Failed to allocate PAN record");
> +	if (bt_adapter_add_record(nap_rec, SVC_HINT_NETWORKING) < 0) {
> +		sdp_record_free(nap_rec);
> +		error("Failed to allocate PAN-NAP sdp record");
>  		return false;
>  	}
> 
> -	if (bt_adapter_add_record(nap_rec, SVC_HINT_NETWORKING) < 0) {
> -		error("Failed to register PAN record");
> +	panu_rec = panu_record();
> +	if (bt_adapter_add_record(panu_rec, SVC_HINT_NETWORKING) < 0) {
>  		sdp_record_free(nap_rec);
> +		sdp_record_free(panu_rec);
> +		error("Failed to allocate PAN-PANU sdp record");
>  		return false;
>  	}
> 
>  	err = bnep_init();
>  	if (err < 0) {
> -		error("bnep init failed");
> +		error("Failed to init BNEP");
>  		bt_adapter_remove_record(nap_rec->handle);
> +		bt_adapter_remove_record(panu_rec->handle);
>  		return false;
>  	}
> 
>  	err = register_nap_server();
>  	if (err < 0) {
> -		error("Failed to register NAP");
> +		error("Failed to register NAP server");
>  		bt_adapter_remove_record(nap_rec->handle);
> +		bt_adapter_remove_record(panu_rec->handle);
>  		bnep_cleanup();
>  		return false;
>  	}
> 
>  	nap_rec_id = nap_rec->handle;
> +	panu_rec_id = panu_rec->handle;
> 
>  	hal_ipc = ipc;
>  	ipc_register(hal_ipc, HAL_SERVICE_ID_PAN, cmd_handlers,
> @@ -845,5 +927,7 @@ void bt_pan_unregister(void)
> 
>  	bt_adapter_remove_record(nap_rec_id);
>  	nap_rec_id = 0;
> +	bt_adapter_remove_record(panu_rec_id);
> +	panu_rec_id = 0;
>  	destroy_nap_device();
>  }

Applied, thanks.

-- 
BR
Szymon Janc
