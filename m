Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] android/gatt: Format string with address properly
Date: Fri, 11 Apr 2014 15:56:50 +0200
Message-ID: <1693269.AqOluWevxW@uw000953>
In-Reply-To: <1397155238-8578-3-git-send-email-marcin.kraglak@tieto.com>
References: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com> <1397155238-8578-3-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 10 of April 2014 20:40:37 Marcin Kraglak wrote:
> ---
>  android/gatt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 857ffe0..b246137 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1150,12 +1150,14 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_gatt_client_disconnect *cmd = buf;
>  	struct gatt_device *dev;
> +	bdaddr_t bdaddr;
>  	uint8_t status;
>  	char addr[18];
>  
>  	DBG("");
>  
> -	ba2str((bdaddr_t *)&cmd->bdaddr, addr);
> +	android2bdaddr(cmd->bdaddr, &bdaddr);
> +	ba2str(&bdaddr, addr);
>  
>  	dev = find_device_by_conn_id(cmd->conn_id);
>  	if (!dev) {
> 

I've pushed this patch but should we do at least sanity check on passed
device address in this command ie. check if connection id and address match?

-- 
Best regards, 
Szymon Janc
