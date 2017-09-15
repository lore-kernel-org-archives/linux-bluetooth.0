Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] adapter: Fix not waiting for start discovery result
In-Reply-To: <20170914131509.13624-1-luiz.dentz@gmail.com>
References: <20170914131509.13624-1-luiz.dentz@gmail.com>
Date: Thu, 14 Sep 2017 17:57:22 -0700
Message-ID: <87shfoixsd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> We should not reply until the start discovery completes otherwise
> clients may attempt to stop the discovery before it even has started.
>
> On top of this it will now block clients so they so not be able to
> queue more requests.
> ---
>  src/adapter.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index a571b1870..4b9f5a1cd 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -160,6 +160,7 @@ struct discovery_filter {
>
>  struct watch_client {
>  	struct btd_adapter *adapter;
> +	DBusMessage *msg;
>  	char *owner;
>  	guint watch;
>  	struct discovery_filter *discovery_filter;
> @@ -1421,13 +1422,17 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>  					const void *param, void *user_data)
>  {
>  	struct btd_adapter *adapter = user_data;
> +	struct watch_client *client = adapter->discovery_list->data;

What if the client exits the bus after issuing StartDiscovery(), but
before receiving the reply. It seems that 'adapter->discovery_list'
could be empty, no?


Cheers,
--
Vinicius
