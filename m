Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/btgatt-client: print error string and code
To: linux-bluetooth@vger.kernel.org
Cc: Biman Paul <biman.paul@samsung.com>,
        Syam Sidhardhan <s.syam@samsung.com>
References: <1499438042-4741-1-git-send-email-biman.paul@samsung.com>
 <CGME20170707142625epcas5p3f3cb0fdf883a357af4bca919ff5c52fb@epcas5p3.samsung.com>
 <1499438042-4741-2-git-send-email-biman.paul@samsung.com>
From: Biman Paul <biman.innovative@gmail.com>
Message-ID: <8065cdde-e6d9-48a6-abb4-56f9ee8efae9@gmail.com>
Date: Sun, 20 May 2018 19:58:29 +0530
MIME-Version: 1.0
In-Reply-To: <1499438042-4741-2-git-send-email-biman.paul@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping


On Friday 07 July 2017 08:04 PM, Biman Paul wrote:
> It is difficult to remember each and every error code.
> Printing the error string reduces some effort to refer
> error codes and their meaning every time.
> ---
>   tools/btgatt-client.c |   11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 51bc362..2fb1a31 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -365,8 +365,8 @@ static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
>   	struct client *cli = user_data;
>   
>   	if (!success) {
> -		PRLOG("GATT discovery procedures failed - error code: 0x%02x\n",
> -								att_ecode);
> +		PRLOG("GATT discovery procedures failed: %s (0x%02x)\n",
> +				ecode_to_string(att_ecode), att_ecode);
>   		return;
>   	}
>   
> @@ -480,7 +480,8 @@ static void read_multiple_cb(bool success, uint8_t att_ecode,
>   	int i;
>   
>   	if (!success) {
> -		PRLOG("\nRead multiple request failed: 0x%02x\n", att_ecode);
> +		PRLOG("\nRead multiple request failed: %s (0x%02x)\n",
> +				ecode_to_string(att_ecode), att_ecode);
>   		return;
>   	}
>   
> @@ -1109,8 +1110,8 @@ static void notify_cb(uint16_t value_handle, const uint8_t *value,
>   static void register_notify_cb(uint16_t att_ecode, void *user_data)
>   {
>   	if (att_ecode) {
> -		PRLOG("Failed to register notify handler "
> -					"- error code: 0x%02x\n", att_ecode);
> +		PRLOG("Failed to register notify handler: %s (0x%02x)\n",
> +				ecode_to_string(att_ecode), att_ecode);
>   		return;
>   	}
>   

