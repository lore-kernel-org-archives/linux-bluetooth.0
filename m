Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Correct UUIDs list to EIR
From: Marcel Holtmann <marcel@holtmann.org>
To: Francisco Alecrim <francisco.alecrim@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1270591520-2078-2-git-send-email-francisco.alecrim@openbossa.org>
References: <1270591520-2078-1-git-send-email-francisco.alecrim@openbossa.org>
	 <1270591520-2078-2-git-send-email-francisco.alecrim@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Apr 2010 05:59:16 +0200
Message-ID: <1270699156.6375.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francisco,

> Correct create_ext_inquiry_response to response only UUIDs per-adapter.
> ---
>  src/adapter.c      |    3 ++-
>  src/sdpd-service.c |    5 +++--
>  src/sdpd.h         |    3 ++-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 47cef90..9e94d86 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -816,7 +816,8 @@ static void update_ext_inquiry_response(struct btd_adapter *adapter)
>  
>  	if (dev->ssp_mode > 0)
>  		create_ext_inquiry_response((char *) dev->name,
> -						adapter->tx_power, data);
> +						adapter->tx_power, adapter->services,
> +						data);
>  
>  	if (hci_write_ext_inquiry_response(dd, fec, data,
>  						HCI_REQ_TIMEOUT) < 0)
> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> index a8f7d47..4551577 100644
> --- a/src/sdpd-service.c
> +++ b/src/sdpd-service.c
> @@ -167,9 +167,10 @@ uint8_t get_service_classes(const bdaddr_t *bdaddr)
>  }
>  
>  void create_ext_inquiry_response(const char *name,
> -					int8_t tx_power, uint8_t *data)
> +					int8_t tx_power, sdp_list_t *services,
> +					uint8_t *data)
>  {
> -	sdp_list_t *list = sdp_get_record_list();
> +	sdp_list_t *list = services;
>  	uint8_t *ptr = data;
>  	uint16_t uuid[24];
>  	int i, index = 0;
> diff --git a/src/sdpd.h b/src/sdpd.h
> index 1352a83..1f0a229 100644
> --- a/src/sdpd.h
> +++ b/src/sdpd.h
> @@ -95,4 +95,5 @@ int remove_record_from_server(uint32_t handle);
>  
>  uint8_t get_service_classes(const bdaddr_t *bdaddr);
>  void create_ext_inquiry_response(const char *name,
> -					int8_t tx_power, uint8_t *data);
> +					int8_t tx_power, sdp_list_t *services,
> +					uint8_t *data);

and this reminds me, that the list of UUIDs for local adapter and
inquiry response should be actually sorted. Currently we are a bit lazy
in that area. So please go ahead and fix that as well.

Regards

Marcel


