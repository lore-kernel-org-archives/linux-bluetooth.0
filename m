Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Apr 2012 22:35:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] adapter: Fix segfault when icon is uninitialized
Message-ID: <20120402193520.GA7348@x220.ger.corp.intel.com>
References: <1333394427-9803-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333394427-9803-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Mon, Apr 02, 2012, Bruna Moreira wrote:
> If device type is LE and GAP Appearance characteristic does not exist,
> the icon will not be initialized.
> ---
>  src/adapter.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index f8f46f8..9ebfe66 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2664,7 +2664,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
>  {
>  	struct btd_device *device;
>  	char peer_addr[18], local_addr[18];
> -	const char *icon, *paddr = peer_addr;
> +	const char *icon = NULL, *paddr = peer_addr;
>  	dbus_bool_t paired = FALSE, trusted = FALSE;
>  	dbus_int16_t rssi = dev->rssi;
>  	char *alias;

I'd rather do this within the code than by initializing upon
declaration:

                if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
                                                                &app) == 0)
                        icon = gap_appearance_to_icon(app);
+               else
+                       icon = NULL;


Johan
