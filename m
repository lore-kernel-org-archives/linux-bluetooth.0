Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Jun 2012 12:35:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sdp: Prevent duplicate records registration
Message-ID: <20120620093513.GA17683@x220>
References: <1340182921-12448-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1340182921-12448-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Jun 20, 2012, Frédéric Danis wrote:
> Check if a record with same UUID and protocol descriptor already exists
> before adding new record to server
> ---
> 
> When BlueZ is built with --enable-pnat option, it provides DUN support on RFComm
> port 1.
> When current version of oFono is started, it also provides DUN support on same
> port.
> So, we get to 2 SDP records for same UUID and RFComm port.
> This patch prevents this.
> 
> 
>  src/sdpd-service.c |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> index 39e05ab..9e8b90c 100644
> --- a/src/sdpd-service.c
> +++ b/src/sdpd-service.c
> @@ -235,6 +235,9 @@ int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
>  {
>  	sdp_data_t *data;
>  	sdp_list_t *pattern;
> +	sdp_list_t *record;
> +	sdp_list_t *protos;
> +	int port = -1, psm = -1;
>  
>  	if (rec->handle == 0xffffffff) {
>  		rec->handle = sdp_next_handle();
> @@ -245,6 +248,38 @@ int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
>  			return -EEXIST;
>  	}
>  
> +	if (sdp_get_access_protos(rec, &protos) == 0) {
> +		psm = sdp_get_proto_port(protos, L2CAP_UUID);
> +		port = sdp_get_proto_port(protos, RFCOMM_UUID);
> +
> +		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
> +		sdp_list_free(protos, NULL);
> +	}
> +
> +	for (record = sdp_get_record_list(); record; record = record->next) {
> +		sdp_record_t *tmp = record->data;
> +		int tmp_port = -1, tmp_psm = -1;
> +
> +		if (sdp_uuid_cmp(&tmp->svclass, &rec->svclass) != 0)
> +			continue;
> +
> +		if (sdp_get_access_protos(tmp, &protos) == 0) {
> +			tmp_psm = sdp_get_proto_port(protos, L2CAP_UUID);
> +			tmp_port = sdp_get_proto_port(protos, RFCOMM_UUID);
> +
> +			sdp_list_foreach(protos,
> +					 (sdp_list_func_t) sdp_list_free, NULL);
> +			sdp_list_free(protos, NULL);
> +		}
> +
> +		if (psm != tmp_psm || port != tmp_port)
> +			continue;
> +
> +		DBG("Record not added as handle 0x%05x already exists with "
> +				"same uuid and protos", tmp->handle);
> +		return -EEXIST;
> +	}
> +
>  	DBG("Adding record with handle 0x%05x", rec->handle);
>  
>  	sdp_record_add(src, rec);

My initial reaction is that I don't think this is something that needs
to be part of the SDP server. The admin of the system should be smart
enough to not try to configure to identical & conflicting services.

Also, the RFCOMM server socket code in the kernel should already give an
error if binding to the same channel is attempted twice, so this would
look like a bug in one of the DUN implementations that they do not
unregister their service record when binding the server socket fails. So
simply fixing this bug would also make sure that two service records
aren't present (though it would remove the existence of the clueless
admin ;)

However, even if this was introduced it should be in its own function
(e.g. sdpd_check_duplicate() called from within add_record_to_server)
and not unnecessarily bloat the size of add_record_to_server.

Johan
