Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1324051799-21439-12-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
	<1324051799-21439-2-git-send-email-sancane@gmail.com>
	<1324051799-21439-3-git-send-email-sancane@gmail.com>
	<1324051799-21439-4-git-send-email-sancane@gmail.com>
	<1324051799-21439-5-git-send-email-sancane@gmail.com>
	<1324051799-21439-6-git-send-email-sancane@gmail.com>
	<1324051799-21439-7-git-send-email-sancane@gmail.com>
	<1324051799-21439-8-git-send-email-sancane@gmail.com>
	<1324051799-21439-9-git-send-email-sancane@gmail.com>
	<1324051799-21439-10-git-send-email-sancane@gmail.com>
	<1324051799-21439-11-git-send-email-sancane@gmail.com>
	<1324051799-21439-12-git-send-email-sancane@gmail.com>
Date: Sat, 17 Dec 2011 10:28:48 +0100
Message-ID: <CACLukzLeRzqP17-T50ib9q2=1r50kdTw4Oqwuju-Q7AM7nBpSA@mail.gmail.com>
Subject: Re: [PATCH 11/11] gatt-example: Use adapter driver to register GATT attributes
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everybody,

2011/12/16 Santiago Carot-Nemesio <sancane@gmail.com>:
> GATT servers should register their attributes on each adapter when
> it is plugged instead of doing that when the plugins is loaded. This
> patch registers a new adapter driver to manage plug and unplug
> events in order to register attributes in each GATT served managed
> in each adapter.
> ---
>  plugins/gatt-example.c |   46 +++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
> index 6d9b6b8..c719697 100644
> --- a/plugins/gatt-example.c
> +++ b/plugins/gatt-example.c
> @@ -29,6 +29,7 @@
>  #include <glib.h>
>  #include <bluetooth/uuid.h>
>  #include <errno.h>
> +#include <adapter.h>
>
>  #include "plugin.h"
>  #include "hcid.h"
> @@ -59,6 +60,8 @@
>
>  static GSList *sdp_handles = NULL;
>
> +static gboolean started = FALSE;
> +
>  static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
>  {
>        uint8_t value;
> @@ -436,19 +439,19 @@ static void register_weight_service(const uint16_t vendor[2])
>                                                GUINT_TO_POINTER(sdp_handle));
>  }
>
> -static int gatt_example_init(void)
> +static int gatt_example_adapter_probe(struct btd_adapter *adapter)
>  {
>        uint16_t manuf1_range[2] = {0, 0}, manuf2_range[2] = {0, 0};
>        uint16_t vendor_range[2] = {0, 0};
>
> -       if (!main_opts.attrib_server) {
> -               DBG("Attribute server is disabled");
> +       /* FIXME: Add support for more than one adapter */
> +
> +       if (started)
>                return -1;
> -       }
>
>        if (!register_battery_service()) {
>                DBG("Battery service could not be registered");
> -               return -EIO;
> +               return -1;
>        }
>
>        register_manuf1_service(manuf1_range);
> @@ -457,12 +460,15 @@ static int gatt_example_init(void)
>        register_vendor_service(vendor_range);
>        register_weight_service(vendor_range);
>
> +       started = TRUE;
>        return 0;
>  }
>
> -static void gatt_example_exit(void)
> +static void gatt_example_adapter_remove(struct btd_adapter *adapter)
>  {
> -       if (!main_opts.attrib_server)
> +       /* FIXME: Add support for more than one adapter */
> +
> +       if (!started)
>                return;
>
>        while (sdp_handles) {
> @@ -471,6 +477,32 @@ static void gatt_example_exit(void)
>                attrib_free_sdp(handle);
>                sdp_handles = g_slist_remove(sdp_handles, sdp_handles->data);
>        }
> +
> +       started = FALSE;
> +}
> +
> +static struct btd_adapter_driver gatt_example_adapter_driver = {
> +       .name   = "hdp-adapter-driver",
> +       .probe  = gatt_example_adapter_probe,
> +       .remove = gatt_example_adapter_remove,
> +};
> +
> +static int gatt_example_init(void)
> +{
> +       if (!main_opts.attrib_server) {
> +               DBG("Attribute server is disabled");
> +               return -1;
> +       }
> +
> +       return btd_register_adapter_driver(&gatt_example_adapter_driver);
> +}
> +
> +static void gatt_example_exit(void)
> +{
> +       if (!main_opts.attrib_server)
> +               return;
> +
> +       btd_register_adapter_driver(&gatt_example_adapter_driver);
>  }
>
>  BLUETOOTH_PLUGIN_DEFINE(gatt_example, VERSION, BLUETOOTH_PLUGIN_PRIORITY_LOW,
> --
> 1.7.8
>

This last patch is only a proof of concept, don't waste your time
rewieging it, just discard it
Regards
