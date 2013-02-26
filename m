Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2013 13:51:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH BlueZ 1/2] adapter: add a
 btd_adapter_get_default_address() call
Message-ID: <20130226115122.GA2750@x220>
References: <1361699686-12341-1-git-send-email-ospite@studenti.unina.it>
 <1361699686-12341-2-git-send-email-ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361699686-12341-2-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Sun, Feb 24, 2013, Antonio Ospite wrote:
> Add a new btd_* call to get the default adapter address as a string.
> 
> This is meant to be used, for instance, by _external_ plugins which want
> to know the default adapter address for some reason (e.g. to send it to
> a device for some custom pairing scheme like in the case of Playstation
> peripherals).
> 
> External plugins can only use symbols marked as "global" in
> src/bluetooth.ver, this patch avoids making global these symbols:
> 
>   adapter_get_address
>   bt_malloc
>   ba2str
> ---
>  src/adapter.h |    1 +
>  src/adapter.c |   17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/src/adapter.h b/src/adapter.h
> index 8d23a64..cb6d0d6 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -38,6 +38,7 @@
>  struct btd_adapter;
>  
>  struct btd_adapter *btd_adapter_get_default(void);
> +char *btd_adapter_get_default_address(void);
>  bool btd_adapter_is_default(struct btd_adapter *adapter);
>  uint16_t btd_adapter_get_index(struct btd_adapter *adapter);

Please fix adapter_get_address to have a btd_ prefix instead. There's no
reason why that should be hidden from plugins.

As for the libbluetooth symbols, I don't get what the issue is. Those
should always be available to any binary that links with libbluetooth.
If they don't work then I think we need to fix something in the way the
plugins and/or bluetoothd are built.

Johan
