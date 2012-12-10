Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/4] sap-u8500: Fix build errors due to unaligned memory access
Date: Mon, 10 Dec 2012 15:12:42 +0100
Message-ID: <1614369.eQZKrof3SG@uw000953>
In-Reply-To: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
References: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 23 of November 2012 12:09:11 Janc Szymon wrote:
> This fix following compilation error on ARM.
> 
>   CC     profiles/sap/sap-u8500.o
> profiles/sap/sap-u8500.c: In function recv_card_status:
> profiles/sap/sap-u8500.c:323:16: error: cast increases required
> 	alignment of target type [-Werror=cast-align]
> profiles/sap/sap-u8500.c: In function recv_response:
> profiles/sap/sap-u8500.c:423:12: error: cast increases required
> 	alignment of target type [-Werror=cast-align]
> cc1: all warnings being treated as errors
> ---
>  profiles/sap/sap-u8500.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/profiles/sap/sap-u8500.c b/profiles/sap/sap-u8500.c
> index f07209d..b1aee57 100644
> --- a/profiles/sap/sap-u8500.c
> +++ b/profiles/sap/sap-u8500.c
> @@ -313,16 +313,16 @@ static void recv_status(uint32_t status)
>  
>  static void recv_card_status(uint32_t status, uint8_t *param)
>  {
> -	uint32_t *card_status;
> +	uint32_t card_status;
>  	uint8_t result;
>  	uint8_t iccrs;
>  
>  	if (status != STE_STATUS_OK)
>  		return;
>  
> -	card_status = (uint32_t *)param;
> +	memcpy(&card_status, param, sizeof(card_status));
>  
> -	if (get_sap_reader_status(*card_status, &iccrs) < 0)
> +	if (get_sap_reader_status(card_status, &iccrs) < 0)
>  		result = SAP_RESULT_ERROR_NO_REASON;
>  	else
>  		result = get_sap_result(STE_GET_STATUS_MSG, status);
> @@ -420,7 +420,7 @@ static void recv_response(struct ste_message *msg)
>  	}
>  
>  	param = msg->payload;
> -	status = *(uint32_t *)param;
> +	memcpy(&status, param, sizeof(status));
>  	param += sizeof(status);
>  
>  	SAP_VDBG("status 0x%x", status);
> 

ping
