Return-Path: <cyrus@holtmann.org>
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd 6/9] gobex: add unit test for CONNECT followed by  PUT response
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Thu, 10 Nov 2011 16:25:44 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <1320936238-28360-6-git-send-email-luiz.dentz@gmail.com>
References: <1320936238-28360-1-git-send-email-luiz.dentz@gmail.com>
 <1320936238-28360-6-git-send-email-luiz.dentz@gmail.com>
Message-ID: <8f72b5bd93989eb4d9bd21c40ab4eba6@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 10.11.2011 15:43, schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  unit/test-gobex-transfer.c |   60
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
>
> diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
> index 860f129..f3eb0bf 100644
> --- a/unit/test-gobex-transfer.c
> +++ b/unit/test-gobex-transfer.c
> @@ -73,6 +73,9 @@ static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS |
> FINAL_BIT, 0x00, 0x0c,
>  static guint8 conn_rsp_2[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 
> 0x0c,
>  					0x10, 0x00, 0x10, 0x00, 0xcb, 0x00,
>  					0x00, 0x00, 0x02 };
> +static guint8 conn_rsp_3[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 
> 0x0c,
> +					0x10, 0x00, 0x10, 0x00, 0xcb, 0x00,
> +					0x00, 0x00, 0x03 };
>
>  static guint8 conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT,
> 0x00, 0x28,
>  	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
> @@ -95,6 +98,14 @@ static guint8 conn_put_req_first[] = {
> G_OBEX_OP_PUT, 0x00, 0x35,
>  	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 
> 0,
>  	G_OBEX_HDR_BODY, 0x00, 0x0d,
>  	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
> +static guint8 conn_put_req_first_3[] = { G_OBEX_OP_PUT, 0x00, 0x35,
> +	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x03,
> +	G_OBEX_HDR_TYPE, 0x00, 0x0b,
> +	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
> +	G_OBEX_HDR_NAME, 0x00, 0x15,
> +	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 
> 0,
> +	G_OBEX_HDR_BODY, 0x00, 0x0d,
> +	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };

Not BODY_END header?

HS

