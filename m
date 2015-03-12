Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426151118-27276-1-git-send-email-luiz.dentz@gmail.com>
References: <1426151118-27276-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 12 Mar 2015 14:06:44 +0200
Message-ID: <CABBYNZKzOUwf2LvFv+t2EcYH2aT4rM4FBLfLEphY9cDceVhgqQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-client: Fix invalid read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 12, 2015 at 11:05 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes the following trace caused by last changes which included
> prepare write support but broke cancel_request code:
>
> Invalid read of size 1
>    at 0x43E726: cancel_request (gatt-client.c:1854)
>    by 0x447E4F: queue_remove_all (queue.c:387)
>    by 0x43F19A: bt_gatt_client_cancel_all (gatt-client.c:1866)
>    by 0x43F250: bt_gatt_client_free (gatt-client.c:1569)
>    by 0x43F3D0: bt_gatt_client_unref (gatt-client.c:1692)
>    by 0x43380C: destroy_context (test-gatt.c:284)
>    by 0x43380C: context_quit (test-gatt.c:312)
>    by 0x433E77: test_read_cb (test-gatt.c:677)
>    by 0x43C260: read_cb (gatt-client.c:1924)
>    by 0x43948B: handle_rsp (att.c:640)
>    by 0x43948B: can_read_data (att.c:813)
>    by 0x446DAA: watch_callback (io-glib.c:170)
>    by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
>    by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
>  Address 0x57f0908 is 8 bytes inside a block of size 40 free'd
>    at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>    by 0x43E06F: request_unref (gatt-client.c:160)
>    by 0x4389C6: cancel_att_send_op (att.c:222)
>    by 0x4389C6: bt_att_cancel (att.c:1194)
>    by 0x43E71D: cancel_request (gatt-client.c:1852)
>    by 0x447E4F: queue_remove_all (queue.c:387)
>    by 0x43F19A: bt_gatt_client_cancel_all (gatt-client.c:1866)
>    by 0x43F250: bt_gatt_client_free (gatt-client.c:1569)
>    by 0x43F3D0: bt_gatt_client_unref (gatt-client.c:1692)
>    by 0x43380C: destroy_context (test-gatt.c:284)
>    by 0x43380C: context_quit (test-gatt.c:312)
>    by 0x433E77: test_read_cb (test-gatt.c:677)
>    by 0x43C260: read_cb (gatt-client.c:1924)
>    by 0x43948B: handle_rsp (att.c:640)
>    by 0x43948B: can_read_data (att.c:813)
> ---
>  src/shared/gatt-client.c | 44 ++++++++++++++++----------------------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 5ee753e..1e7032c 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1815,47 +1815,34 @@ static bool cancel_prep_write_session(struct bt_gatt_client *client,
>                                                         req, request_unref);
>  }
>
> -bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
> +static bool cancel_request(void *data)
>  {
> -       struct request *req;
> -
> -       if (!client || !id || !client->att)
> -               return false;
> -
> -       req = queue_remove_if(client->pending_requests, match_req_id,
> -                                                       UINT_TO_PTR(id));
> -       if (!req)
> -               return false;
> +       struct request *req = data;
>
>         req->removed = true;
>
> -       if (!bt_att_cancel(client->att, req->att_id) && !req->long_write &&
> -                                                       !req->prep_write)
> -               return false;
> -
> -       /* If this was a long-write, we need to abort all prepared writes */
>         if (req->long_write)
> -               return cancel_long_write_req(client, req);
> +               return cancel_long_write_req(req->client, req);
>
>         if (req->prep_write)
> -               return cancel_prep_write_session(client, req);
> +               return cancel_prep_write_session(req->client, req);
>
> -       return true;
> +       return bt_att_cancel(req->client->att, req->att_id);
>  }
>
> -static void cancel_request(void *data)
> +bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
>  {
> -       struct request *req = data;
> -
> -       req->removed = true;
> +       struct request *req;
>
> -       bt_att_cancel(req->client->att, req->att_id);
> +       if (!client || !id || !client->att)
> +               return false;
>
> -       if (req->long_write)
> -               cancel_long_write_req(req->client, req);
> +       req = queue_remove_if(client->pending_requests, match_req_id,
> +                                                       UINT_TO_PTR(id));
> +       if (!req)
> +               return false;
>
> -       if (req->prep_write)
> -               cancel_prep_write_session(req->client, req);
> +       return cancel_request(req);
>  }
>
>  bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
> @@ -1863,7 +1850,8 @@ bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
>         if (!client || !client->att)
>                 return false;
>
> -       queue_remove_all(client->pending_requests, NULL, NULL, cancel_request);
> +       queue_remove_all(client->pending_requests, NULL, NULL,
> +                                       (queue_destroy_func_t) cancel_request);
>
>         if (client->discovery_req) {
>                 bt_gatt_request_cancel(client->discovery_req);
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
