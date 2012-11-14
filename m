Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352105705-13988-12-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com> <1352105705-13988-12-git-send-email-andrzej.kaczmarek@tieto.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 13 Nov 2012 22:31:59 -0200
Message-ID: <CAMOw1v7c0kzuGeGejKeKKX2BsctYdfFF6GTx-nLOd1n8JAO+rg@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] cyclingspeed: Add stub to use SC Control Point
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 5, 2012 at 6:54 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> This patch implements common functions to use SC Control Point.
> Individual procedures will be implemented in subsequent patches.
> ---
>  profiles/cyclingspeed/cyclingspeed.c | 145 +++++++++++++++++++++++++++++++++--
>  1 file changed, 140 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
> index 5a65507..ffef6ae 100644
> --- a/profiles/cyclingspeed/cyclingspeed.c
> +++ b/profiles/cyclingspeed/cyclingspeed.c
> @@ -41,6 +41,11 @@
>  #include "log.h"
>  #include "cyclingspeed.h"
>
> +/* min length for ATT indication or notification: opcode (1b) + handle (2b) */
> +#define ATT_HDR_LEN 3
> +
> +#define ATT_TIMEOUT 30
> +
>  #define CYCLINGSPEED_INTERFACE         "org.bluez.CyclingSpeed"
>  #define CYCLINGSPEED_MANAGER_INTERFACE "org.bluez.CyclingSpeedManager"
>  #define CYCLINGSPEED_WATCHER_INTERFACE "org.bluez.CyclingSpeedWatcher"
> @@ -52,6 +57,25 @@
>  #define WHEEL_REV_PRESENT      0x01
>  #define CRANK_REV_PRESENT      0x02
>
> +#define SET_CUMULATIVE_VALUE           0x01
> +#define START_SENSOR_CALIBRATION       0x02
> +#define UPDATE_SENSOR_LOC              0x03
> +#define REQUEST_SUPPORTED_SENSOR_LOC   0x04
> +#define RESPONSE_CODE                  0x10
> +
> +#define RSP_SUCCESS            0x01
> +#define RSP_NOT_SUPPORTED      0x02
> +#define RSP_INVALID_PARAM      0x03
> +#define RSP_FAILED             0x04
> +
> +struct csc;
> +
> +struct controlpoint_req {
> +       struct csc              *csc;
> +       uint8_t                 opcode;
> +       guint                   timeout;
> +};
> +
>  struct csc_adapter {
>         struct btd_adapter      *adapter;
>         GSList                  *devices;       /* list of registered devices */
> @@ -66,6 +90,8 @@ struct csc {
>         guint                   attioid;
>         /* attio id for measurement characteristics value notifications */
>         guint                   attio_measurement_id;
> +       /* attio id for SC Control Point characteristics value indications */
> +       guint                   attio_controlpoint_id;
>
>         struct att_range        *svc_range;
>
> @@ -75,6 +101,8 @@ struct csc {
>         uint16_t                feature;
>         gboolean                has_location;
>         uint8_t                 location;
> +
> +       struct controlpoint_req *pending_req;
>  };
>
>  struct watcher {
> @@ -216,6 +244,7 @@ static void destroy_csc(gpointer user_data)
>
>         if (csc->attrib != NULL) {
>                 g_attrib_unregister(csc->attrib, csc->attio_measurement_id);
> +               g_attrib_unregister(csc->attrib, csc->attio_controlpoint_id);
>                 g_attrib_unref(csc->attrib);
>         }
>
> @@ -235,6 +264,35 @@ static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
>         g_free(msg);
>  }
>
> +static gboolean controlpoint_timeout(gpointer user_data)
> +{
> +       struct controlpoint_req *req = user_data;
> +
> +       req->csc->pending_req = NULL;
> +       g_free(req);
> +
> +       return FALSE;
> +}
> +
> +__attribute__((unused)) /* TODO: remove once controlpoint ops are implemented */

This is a weird way to split the patches... but I don't care that much
for a bootstrap

Lucas De Marchi
