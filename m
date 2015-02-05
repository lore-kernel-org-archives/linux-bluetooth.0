Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
References: <1422945043-4387-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1422945043-4387-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] tools/btgatt-server: Fix help message for GATT
Date: Thu, 05 Feb 2015 15:02:03 +0530
Message-id: <000301d04126$9db398a0$d91ac9e0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Tuesday, February 03, 2015 12:01 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
> Babu
> Subject: [PATCH] tools/btgatt-server: Fix help message for GATT
> 
> Added '\n' to make help message looks good as below:
> btgatt-server
> Usage:
> 	btgatt-server [options]
> Options:
> 	-i, --index <id>		Specify adapter index, e.g. hci0
> 	-m, --mtu <mtu>			The ATT MTU to use
> 	-s, --security-level <sec>	Set security level (low|medium|high)
> 	-v, --verbose			Enable extra logging
> 	-r, --heart-rate		Enable Heart Rate service
> 	-h, --help			Display help
> ---
>  tools/btgatt-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c index
> f6ad8c3..d27cf10 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -631,7 +631,7 @@ static void usage(void)
>  		"\t-s, --security-level <sec>\tSet security level (low|"
> 
> 	"medium|high)\n"
>  		"\t-v, --verbose\t\t\tEnable extra logging\n"
> -		"\t-r, --heart-rate\t\tEnable Heart Rate service"
> +		"\t-r, --heart-rate\t\tEnable Heart Rate service\n"
>  		"\t-h, --help\t\t\tDisplay help\n");
>  }
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

