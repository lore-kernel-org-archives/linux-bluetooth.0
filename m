Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] obexd: Fix property Size of server transfer
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20180124130930.1539-1-luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <79ff061a-46ad-a0b9-70f6-16d407b9170f@jp.fujitsu.com>
Date: Thu, 25 Jan 2018 13:43:57 +0900
MIME-Version: 1.0
In-Reply-To: <20180124130930.1539-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for your great work.

After applying this patch, on my box obexctl retrieves the Size property
correctly even if it is run before starting to transfer a file.


Regards,
Eramoto

On 01/24/2018 10:09 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> OBJECT_SIZE_DELETE is shall not be consider a valid size.
> ---
>  obexd/src/manager.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 78b138c85..70265e445 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -377,7 +377,8 @@ static gboolean transfer_size_exists(const GDBusPropertyTable *property,
>  	struct obex_transfer *transfer = data;
>  	struct obex_session *session = transfer->session;
>  
> -	return session->size != OBJECT_SIZE_UNKNOWN;
> +	return (session->size != OBJECT_SIZE_UNKNOWN &&
> +				session->size != OBJECT_SIZE_DELETE);
>  }
>  
>  static gboolean transfer_get_size(const GDBusPropertyTable *property,
> @@ -386,7 +387,8 @@ static gboolean transfer_get_size(const GDBusPropertyTable *property,
>  	struct obex_transfer *transfer = data;
>  	struct obex_session *session = transfer->session;
>  
> -	if (session->size == OBJECT_SIZE_UNKNOWN)
> +	if (session->size == OBJECT_SIZE_UNKNOWN ||
> +				session->size == OBJECT_SIZE_DELETE)
>  		return FALSE;
>  
>  	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64, &session->size);
> 

