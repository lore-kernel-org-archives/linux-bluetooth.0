Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 6/8] sdpd: Remove 'register' and 'remove' requests
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379599248-7923-7-git-send-email-szymon.janc@tieto.com>
Date: Sat, 21 Sep 2013 12:25:18 -0500
Cc: <linux-bluetooth@vger.kernel.org>
Message-Id: <B644016C-2B90-426E-AD70-EDC2F36407B4@holtmann.org>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com> <1379599248-7923-7-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> sdpd is now controlled by adapters and should not be modified with
> other means.
> ---
> src/sdpd-request.c |  14 --------
> src/sdpd-service.c | 100 -----------------------------------------------------
> src/sdpd.h         |   2 --
> 3 files changed, 116 deletions(-)
> 
> diff --git a/src/sdpd-request.c b/src/sdpd-request.c
> index fbeb488..5b88a10 100644
> --- a/src/sdpd-request.c
> +++ b/src/sdpd-request.c
> @@ -997,13 +997,6 @@ static void process_request(sdp_req_t *req)
> 		rsphdr->pdu_id = SDP_SVC_SEARCH_ATTR_RSP;
> 		break;
> 	/* Following requests are allowed only for local connections */
> -	case SDP_SVC_REGISTER_REQ:
> -		SDPDBG("Service register request");
> -		if (req->local) {
> -			status = service_register_req(req, &rsp);
> -			rsphdr->pdu_id = SDP_SVC_REGISTER_RSP;
> -		}
> -		break;
> 	case SDP_SVC_UPDATE_REQ:
> 		SDPDBG("Service update request");
> 		if (req->local) {
> @@ -1011,13 +1004,6 @@ static void process_request(sdp_req_t *req)
> 			rsphdr->pdu_id = SDP_SVC_UPDATE_RSP;
> 		}
> 		break;
> -	case SDP_SVC_REMOVE_REQ:
> -		SDPDBG("Service removal request");
> -		if (req->local) {
> -			status = service_remove_req(req, &rsp);
> -			rsphdr->pdu_id = SDP_SVC_REMOVE_RSP;
> -		}
> -		break;

we can not take these out. We need a way to pass qualification.

Regards

Marcel

