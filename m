Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jun 2014 10:20:41 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/17] HDP: Fix checking always constant error code
Message-ID: <20140617072040.GA621@aemeltch-MOBL1>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 16, 2014 at 10:57:36AM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

ping


> 
> sdp_set_access_protos() always returns 0, there is no sense to check for
> error code. Fixes compile warnings.
> ---
>  profiles/health/hdp_util.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
> index 58770b5..ff427a6 100644
> --- a/profiles/health/hdp_util.c
> +++ b/profiles/health/hdp_util.c
> @@ -362,7 +362,7 @@ static gboolean set_sdp_services_uuid(sdp_record_t *record, HdpRole role)
>  static gboolean register_service_protocols(struct hdp_adapter *adapter,
>  						sdp_record_t *sdp_record)
>  {
> -	gboolean ret;
> +	gboolean ret = TRUE;
>  	uuid_t l2cap_uuid, mcap_c_uuid;
>  	sdp_list_t *l2cap_list, *proto_list = NULL, *mcap_list = NULL;
>  	sdp_list_t *access_proto_list = NULL;
> @@ -425,11 +425,7 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
>  		goto end;
>  	}
>  
> -	if (sdp_set_access_protos(sdp_record, access_proto_list) < 0) {
> -		ret = FALSE;
> -		goto end;
> -	}
> -	ret = TRUE;
> +	sdp_set_access_protos(sdp_record, access_proto_list);
>  
>  end:
>  	if (l2cap_list != NULL)
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
