Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Nov 2013 11:28:42 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 16/16] android/socket: Add SDP record for OPP profile
Message-ID: <20131118092840.GA21114@aemeltch-MOBL1>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384763179-2218-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384763179-2218-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 18, 2013 at 10:26:19AM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This adds SDP record for OPP shown below:
> 
> Service Name: OBEX Object Push
> Service RecHandle: 0x10002
> Service Class ID List:
>   "OBEX Object Push" (0x1105)
> Protocol Descriptor List:
>   "RFCOMM" (0x0003)
>     Channel: 9
>   "OBEX" (0x0008)
> Profile Descriptor List:
>   "OBEX Object Push" (0x1105)
>     Version: 0x0100
> ---
>  android/socket.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/android/socket.c b/android/socket.c
> index 6b50014..989b876 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -36,6 +36,7 @@
>  #include "lib/sdp_lib.h"
>  #include "src/sdp-client.h"
>  
> +#include "bluetooth.h"
>  #include "log.h"
>  #include "hal-msg.h"
>  #include "hal-ipc.h"
> @@ -43,6 +44,9 @@
>  #include "utils.h"
>  #include "socket.h"
>  
> +/* Use Object Transfer for all services */
> +#define SVC_HINT_OBEX 0x10
> +
>  static bdaddr_t adapter_addr;
>  
>  /* Simple list of RFCOMM server sockets */
> @@ -56,6 +60,7 @@ struct rfcomm_slot {
>  	int real_sock;	/* real RFCOMM socket */
>  	int channel;	/* RFCOMM channel */
>  	bdaddr_t dst;
> +	uint32_t service_handle;
>  };
>  
>  static struct rfcomm_slot *create_rfslot(int sock, int *hal_fd)
> @@ -86,6 +91,9 @@ static void cleanup_rfslot(struct rfcomm_slot *rfslot)
>  	if (rfslot->real_sock > 0)
>  		close(rfslot->real_sock);
>  
> +	if (rfslot->service_handle)
> +		bt_adapter_remove_record(rfslot->service_handle);
> +
>  	g_free(rfslot);
>  }
>  
> @@ -108,6 +116,90 @@ static struct {
>  	{ {0} }
>  };
>  
> +static sdp_record_t *create_opp_record(uint8_t chan)
> +{
> +	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> +	uuid_t root_uuid, opush_uuid, rfcomm_uuid, obex_uuid;
> +	sdp_profile_desc_t profile[1];
> +	sdp_list_t *aproto, *proto[2];
> +	uint8_t formats[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0xff };
> +	void *dtds[sizeof(formats)], *values[sizeof(formats)];
> +	unsigned int i;
> +	uint8_t dtd = SDP_UINT8;
> +	sdp_data_t *sflist;
> +	sdp_data_t *channel;
> +	sdp_record_t *record;
> +
> +	record = sdp_record_alloc();
> +	if (!record)
> +		return NULL;
> +
> +	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> +	root = sdp_list_append(0, &root_uuid);
> +	sdp_set_browse_groups(record, root);
> +
> +	sdp_uuid16_create(&opush_uuid, OBEX_OBJPUSH_SVCLASS_ID);
> +	svclass_id = sdp_list_append(0, &opush_uuid);
> +	sdp_set_service_classes(record, svclass_id);
> +
> +	sdp_uuid16_create(&profile[0].uuid, OBEX_OBJPUSH_PROFILE_ID);
> +	profile[0].version = 0x0100;
> +	pfseq = sdp_list_append(0, profile);
> +	sdp_set_profile_descs(record, pfseq);
> +
> +	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> +	proto[0] = sdp_list_append(0, &rfcomm_uuid);
> +	channel = sdp_data_alloc(SDP_UINT8, &chan);
> +	proto[0] = sdp_list_append(proto[0], channel);
> +	apseq = sdp_list_append(apseq, proto[0]);

fixed myself to:

@@ -161,7 +161,7 @@ static sdp_record_t *create_opp_record(uint8_t chan)
        proto[0] = sdp_list_append(0, &rfcomm_uuid);
        channel = sdp_data_alloc(SDP_UINT8, &chan);
        proto[0] = sdp_list_append(proto[0], channel);
-       apseq = sdp_list_append(apseq, proto[0]);
+       apseq = sdp_list_append(0, proto[0]);
 
        sdp_uuid16_create(&obex_uuid, OBEX_UUID);
        proto[1] = sdp_list_append(0, &obex_uuid);


Best regards 
Andrei Emeltchenko 

