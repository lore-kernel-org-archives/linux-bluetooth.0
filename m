Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/28] shared/gatt-client: Expose gatt_db
Date: Thu, 02 Apr 2015 16:20:26 +0200
Message-ID: <3161016.OXAJy3G5XP@leonov>
In-Reply-To: <1427906444-11769-4-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com> <1427906444-11769-4-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 01 of April 2015 18:40:19 Mariusz Skamra wrote:
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
> index 729bd87..877abea 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1760,6 +1760,14 @@ uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client
> *client) return bt_att_get_mtu(client->att);
>  }
> 
> +struct gatt_db *bt_gatt_client_get_db(struct bt_gatt_client *client)
> +{
> +	if (!client || !client->db)
> +		return 0;

Should be NULL instead of 0. I wonder why GCC didn't warn on this since
Wint-to-pointer-cast is enabled by default.

> +
> +	return gatt_db_ref(client->db);

I'd leave getting reference to the user instead of doing this implicitly in 
bt_gatt_client_get_db.

> +}
> +
>  static bool match_req_id(const void *a, const void *b)
>  {
>  	const struct request *req = a;
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 8e5e0f5..f539a61 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -70,6 +70,7 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client
> *client, bt_gatt_client_destroy_func_t destroy);
> 
>  uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client);
> +struct gatt_db *bt_gatt_client_get_db(struct bt_gatt_client *client);
> 
>  bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id);
> bool bt_gatt_client_cancel_all(struct bt_gatt_client *client);

-- 
BR
Szymon Janc
