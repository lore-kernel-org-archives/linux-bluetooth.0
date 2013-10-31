Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 10:34:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Add initial sdp implementation
Message-ID: <20131031083401.GB1271@x220.p-661hnu-f1>
References: <1383146314-13456-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383146314-13456-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Oct 30, 2013, Marcin Kraglak wrote:
> Add and remove records to sdp server. This api will
> be used in android's profiles implementations.
> ---
>  android/adapter.c | 11 +++++++++++
>  android/adapter.h |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index 15b65e5..325d0f0 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -26,6 +26,7 @@
>  #include <glib.h>
>  
>  #include "lib/bluetooth.h"
> +#include "src/sdpd.h"
>  #include "src/shared/mgmt.h"
>  #include "lib/mgmt.h"
>  #include "log.h"
> @@ -528,6 +529,16 @@ error:
>  	ipc_send_rsp(io, HAL_SERVICE_ID_BLUETOOTH, status);
>  }
>  
> +int bt_adapter_service_add(sdp_record_t *rec)
> +{
> +	return add_record_to_server(&adapter->bdaddr, rec);
> +}
> +
> +void bt_adapter_service_remove(uint32_t handle)
> +{
> +	remove_record_from_server(handle);
> +}
> +
>  const bdaddr_t *bt_adapter_get_address(void)
>  {
>  	return &adapter->bdaddr;
> diff --git a/android/adapter.h b/android/adapter.h
> index 2afc67a..c5ba76b 100644
> --- a/android/adapter.h
> +++ b/android/adapter.h
> @@ -27,6 +27,7 @@
>  #include <glib.h>
>  
>  #include "lib/bluetooth.h"
> +#include "lib/sdp.h"
>  
>  typedef void (*bt_adapter_ready)(int err);
>  
> @@ -38,5 +39,8 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
>  
>  const bdaddr_t *bt_adapter_get_address(void);
>  
> +int bt_adapter_service_add(sdp_record_t *rec);
> +void bt_adapter_service_remove(uint32_t handle);
> +
>  bool bt_adapter_register(GIOChannel *io);
>  void bt_adapter_unregister(void);

I'd like to see some code that actually uses these functions before
applying this patch.

Johan
