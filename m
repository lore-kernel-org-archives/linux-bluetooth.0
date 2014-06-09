Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/2] HDP: Fix checking always constant error code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402315699-30381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 9 Jun 2014 14:11:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DAB243FF-0783-4067-BABB-A7AF93F3E71A@holtmann.org>
References: <1402315699-30381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> sdp_set_access_protos() always returns 0, there is no sense to check for
> error code. Fixes compile warnings.
> ---
> profiles/health/hdp_util.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
> index 58770b5..ff427a6 100644
> --- a/profiles/health/hdp_util.c
> +++ b/profiles/health/hdp_util.c
> @@ -362,7 +362,7 @@ static gboolean set_sdp_services_uuid(sdp_record_t *record, HdpRole role)
> static gboolean register_service_protocols(struct hdp_adapter *adapter,
> 						sdp_record_t *sdp_record)
> {
> -	gboolean ret;
> +	gboolean ret = TRUE;
> 	uuid_t l2cap_uuid, mcap_c_uuid;
> 	sdp_list_t *l2cap_list, *proto_list = NULL, *mcap_list = NULL;
> 	sdp_list_t *access_proto_list = NULL;
> @@ -425,11 +425,7 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
> 		goto end;
> 	}
> 
> -	if (sdp_set_access_protos(sdp_record, access_proto_list) < 0) {
> -		ret = FALSE;
> -		goto end;
> -	}
> -	ret = TRUE;

might better just a comment here explaining that the call always returns success.

> +	sdp_set_access_protos(sdp_record, access_proto_list);
> 
> end:
> 	if (l2cap_list != NULL)

Regards

Marcel

