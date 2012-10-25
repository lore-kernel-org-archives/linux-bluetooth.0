Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 23:12:36 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Marti Raudsepp <marti@juffo.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] systemd: prevent duplicate logging messages in journal
Message-ID: <20121025021236.GA12303@echo>
References: <1349884769-5157-1-git-send-email-marti@juffo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349884769-5157-1-git-send-email-marti@juffo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marti,

On 18:59 Wed 10 Oct, Marti Raudsepp wrote:
> By default, both stdout and syslog messages go to the systemd journal,
> which results in duplicate messages being logged.
> ---

Patch looks good.

Ack.

On a side note: seems that connman and ofono have the same problem, would you
be interested on sending the respective fixes?

>  src/bluetooth.service.in | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> index 2a576a3..a8442a9 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -5,6 +5,7 @@ Description=Bluetooth service
>  Type=dbus
>  BusName=org.bluez
>  ExecStart=@prefix@/sbin/bluetoothd -n
> +StandardOutput=null
>  
>  [Install]
>  WantedBy=bluetooth.target
> -- 
> 1.7.12.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
