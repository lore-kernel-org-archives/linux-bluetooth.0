Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428068636-13073-4-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
	<1428068636-13073-4-git-send-email-mariusz.skamra@tieto.com>
Date: Tue, 7 Apr 2015 11:01:14 +0300
Message-ID: <CABBYNZKYNKz_WNrdYqj+7+NRvuSa_mWZMZjM1z0QePXC8gk92g@mail.gmail.com>
Subject: Re: [PATCHv2 03/27] shared/gatt-client: Expose gatt_db
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Fri, Apr 3, 2015 at 4:43 PM, Mariusz Skamra <mariusz.skamra@tieto.com> wrote:
> This patch adds the bt_gatt_client_get_db function, which allows
> to get a reference to db from client structure. This is useful
> when as a client we need to have an access db, to explore some
> attributes.
> ---
>  src/shared/gatt-client.c | 8 ++++++++
>  src/shared/gatt-client.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 729bd87..f006ae6 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1760,6 +1760,14 @@ uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client)
>         return bt_att_get_mtu(client->att);
>  }
>
> +struct gatt_db *bt_gatt_client_get_db(struct bt_gatt_client *client)
> +{
> +       if (!client || !client->db)
> +               return NULL;
> +
> +       return client->db;
> +}
> +
>  static bool match_req_id(const void *a, const void *b)
>  {
>         const struct request *req = a;
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 8e5e0f5..f539a61 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -70,6 +70,7 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
>                                         bt_gatt_client_destroy_func_t destroy);
>
>  uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client);
> +struct gatt_db *bt_gatt_client_get_db(struct bt_gatt_client *client);
>
>  bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id);
>  bool bt_gatt_client_cancel_all(struct bt_gatt_client *client);
> --
> 1.9.1

I went ahead and applied this one.


-- 
Luiz Augusto von Dentz
