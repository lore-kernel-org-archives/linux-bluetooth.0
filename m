Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com
References: <1432289879-13705-1-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1432289879-13705-1-git-send-email-bharat.panda@samsung.com>
Subject: RE: [PATCH ] unit/sdp: Use update_db_timestamp() of sdpd-service
Date: Mon, 01 Jun 2015 16:09:54 +0530
Message-id: <02e201d09c57$4f4df020$ede9d060$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Bharat Panda
> Sent: Friday, May 22, 2015 3:48 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: cpgs@samsung.com; Bharat Panda
> Subject: [PATCH ] unit/sdp: Use update_db_timestamp() of sdpd-service
> 
> Make update_db_timestamp() as global to use in unit/test-sdp.c
> ---
>  src/sdpd-service.c | 2 +-
>  src/sdpd.h         | 1 +
>  unit/test-sdp.c    | 4 ----
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/src/sdpd-service.c b/src/sdpd-service.c index
c3ee3eb..df8af94
> 100644
> --- a/src/sdpd-service.c
> +++ b/src/sdpd-service.c
> @@ -308,7 +308,7 @@ uint32_t sdp_get_time(void)
>   * Set the SDP server DB. Simply a timestamp which is the marker
>   * when the DB was modified.
>   */
> -static void update_db_timestamp(void)
> +void update_db_timestamp(void)
>  {
>  	if (fixed_dbts) {
>  		sdp_data_t *d = sdp_data_alloc(SDP_UINT32, &fixed_dbts);
> diff --git a/src/sdpd.h b/src/sdpd.h index 49cd98a..bcb6b07 100644
> --- a/src/sdpd.h
> +++ b/src/sdpd.h
> @@ -45,6 +45,7 @@ typedef struct request {  void
> handle_internal_request(int sk, int mtu, void *data, int len);  void
> handle_request(int sk, uint8_t *data, int len);
> 
> +void update_db_timestamp(void);
>  void set_fixed_db_timestamp(uint32_t dbts);
> 
>  int service_register_req(sdp_req_t *req, sdp_buf_t *rsp); diff --git
> a/unit/test-sdp.c b/unit/test-sdp.c index b4ef4d1..fc4b083 100644
> --- a/unit/test-sdp.c
> +++ b/unit/test-sdp.c
> @@ -257,10 +257,6 @@ static gboolean client_handler(GIOChannel
> *channel, GIOCondition cond,
>  	return TRUE;
>  }
> 
> -static void update_db_timestamp(void)
> -{
> -}
> -
>  static void register_serial_port(void)
>  {
>  	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root,
*aproto;
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

