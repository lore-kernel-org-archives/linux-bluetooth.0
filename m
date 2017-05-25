Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170525001054.92520-1-mcchou@chromium.org>
References: <20170523195650.29695-1-mcchou@chromium.org> <20170525001054.92520-1-mcchou@chromium.org>
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Thu, 25 May 2017 10:44:10 +0300
Message-ID: <CACumGO+-WFY9QQWTJJ8NfZzYdeVskY=7fbpC8K+of_Y49fhGHQ@mail.gmail.com>
Subject: Re: [PATCH v3] device: Clear GATT DB after disconnection for unpaired device
To: mcchou@chromium.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        josephsih@chromium.org, sonnysasaka@chromium.org,
        Rahul Chaturvedi <rkc@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 25, 2017 at 3:10 AM,  <mcchou@chromium.org> wrote:
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This patch adds gatt_db_cleanup() function to clear client-role GATT DB f=
or the
> unpaired device. According to Core Specification v4.2 [1] and v5.0 [2], t=
he
> attributes should be cleared between unbonded devices after disconnection=
, since
> the attributes are no long valid.
>
> [1] Page 525, Section 2.5.2 Attribute Caching, Part G, Volume 3: "For cli=
ents
> that do not have a trusted relationship with the server, the attribute ca=
che is
> valid only during the connection."
> [2] Page 2227, Section 2.5.2 Attribute Caching, Part G, Volume 3: "For cl=
ients
> that do not have a trusted relationship with the server, the attribute ca=
che is
> valid only during the connection."

This ignores the fact that devices which don't implement service
changed characteristic shall not change its database so the discovery
may be skipped:

BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C
page 2079
"If the client had previously determined that the server did not have
the =C2=ABService Changed=C2=BB characteristic then service discovery may b=
e
skipped."

Also note that we do persist the cache to be able to persist
configuration such as notifications and indications, perhaps in chrome
you don't really have a use for it but in systems where reconnection
is supported, afaik chrome OS doesn't, it is a must have since
notifications and indications would not work during the discovery if
we remove the cache. And please remember that discovery is a very slow
procedure, in most cases it takes a good 3-5 seconds to rediscover,
depending on db size it may take over 10 seconds and until it is
completed no attribute can be accessed.

We could, however, have a config option to select the behavior of the
cache or have an option for auto-connect so disabling it also disable
caching.

> ---
>  src/device.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 1b05561e4..f8cde0b43 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -267,6 +267,7 @@ struct pending_sdp_query {
>
>  static int device_browse_gatt(struct btd_device *device, DBusMessage *ms=
g);
>  static int device_browse_sdp(struct btd_device *device, DBusMessage *msg=
);
> +static void store_gatt_db(struct btd_device *device);
>
>  static struct pending_sdp_query *pending_sdp_query_new(DBusConnection *c=
onn,
>                                 DBusMessage *msg, const struct btd_device=
 *dev)
> @@ -546,6 +547,15 @@ static void browse_request_free(struct browse_req *r=
eq)
>         g_free(req);
>  }
>
> +static void gatt_db_cleanup(struct btd_device* device)
> +{
> +       if (!device->db)
> +               return;
> +
> +       gatt_db_clear(device->db);
> +       store_gatt_db(device);
> +}
> +
>  static void gatt_client_cleanup(struct btd_device *device)
>  {
>         if (!device->client)
> @@ -578,6 +588,9 @@ static void attio_cleanup(struct btd_device *device)
>                 device->att_io =3D NULL;
>         }
>
> +       if (!device->bredr_state.bonded && !device->le_state.bonded)
> +               gatt_db_cleanup(device);
> +
>         gatt_client_cleanup(device);
>         gatt_server_cleanup(device);
>
> --
> 2.13.0.219.gdb65acc882-goog
>
