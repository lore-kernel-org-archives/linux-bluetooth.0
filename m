Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421138488-2512-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1421138488-2512-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 13 Jan 2015 14:14:19 -0200
Message-ID: <CABBYNZJRar7eR6u_64Sgqf481sJBYOUBRYeAc61_oFF4kuUcUg@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt-db: Fix crash on find by type search
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Jan 13, 2015 at 6:41 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Make sure all fields in search data are set.
> Without this patch we got:
>
> ==29603== Conditional jump or move depends on uninitialised value(s)
> ==29603==    at 0x409689: find_by_type (gatt-db.c:866)
> ==29603==    by 0x40C1A7: queue_foreach (queue.c:251)
> ==29603==    by 0x40A341: gatt_db_find_by_type (gatt-db.c:889)
> ==29603==    by 0x408E8C: init_complete (gatt-client.c:1225)
> ==29603==    by 0x4073B5: discover_descs_cb (gatt-client.c:690)
> ==29603==    by 0x40CB1C: discover_descs_cb (gatt-helpers.c:1453)
> ==29603==    by 0x405445: can_read_data (att.c:600)
> ==29603==    by 0x40B097: io_callback (io-mainloop.c:123)
> ==29603==    by 0x40BA3B: mainloop_run (mainloop.c:142)
> ==29603==    by 0x401FD7: main (btgatt-client.c:1269)
> ---
>  src/shared/gatt-db.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 9a9cadc..13aa5e4 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -880,6 +880,8 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
>  {
>         struct find_by_type_value_data data;
>
> +       memset(&data, 0, sizeof(data));
> +
>         data.uuid = *type;
>         data.start_handle = start_handle;
>         data.end_handle = end_handle;
> --
> 1.8.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
