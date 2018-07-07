Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 BlueZ 1/3] src: provide MTU on GATT value reads and
 writes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <sm7FuU2Jm6ho8hX9S57lb9nA9SC_p-XR3kNb3De0on-YbFe7gLbxkxs3ux1Ib5ltx1g_HVIxCG_Qp0XlDE2MdsdaWAn7WGoxGYqlY4B2KNc=@krauser.org>
Date: Sat, 7 Jul 2018 20:18:40 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <ED91A5E0-1BBB-4740-B5DC-50E54D73B2D8@holtmann.org>
References: <sm7FuU2Jm6ho8hX9S57lb9nA9SC_p-XR3kNb3De0on-YbFe7gLbxkxs3ux1Ib5ltx1g_HVIxCG_Qp0XlDE2MdsdaWAn7WGoxGYqlY4B2KNc=@krauser.org>
To: David Krauser <david@krauser.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> ---
> src/gatt-database.c | 26 ++++++++++----------------
> 1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 99c8ea231..287074f0a 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1932,7 +1932,9 @@ static void append_options(DBusMessageIter *iter, void *user_data)
> {
>        struct pending_op *op = user_data;
>        const char *path = device_get_path(op->device);
> +       struct bt_gatt_server *server;
>        const char *link;
> +       uint16_t mtu;

there are clearly whitespace / tab damages in this patch. They need to be fixed.

Regards

Marcel

