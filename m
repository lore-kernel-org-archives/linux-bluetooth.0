Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313502238-7581-4-git-send-email-prasadbhat22@gmail.com>
References: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
	<1313502238-7581-4-git-send-email-prasadbhat22@gmail.com>
Date: Thu, 18 Aug 2011 10:20:35 +0300
Message-ID: <CABBYNZJ84=wcfnmY0QGtf4Zm8JCGqL4bAgARQiGMZHa19KFcOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/6] The changes in media.c required for VDP.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prasad Bhat <prasadbhat22@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 16, 2011 at 4:43 PM, Prasad Bhat <prasadbhat22@gmail.com> wrote:
> ---
>  audio/media.c |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 141 insertions(+), 1 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index 42d8637..0aff0d4 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -42,6 +42,7 @@
>  #include "media.h"
>  #include "transport.h"
>  #include "a2dp.h"
> +#include "vdp.h"
>  #include "headset.h"
>  #include "manager.h"
>
> @@ -71,6 +72,7 @@ struct endpoint_request {
>
>  struct media_endpoint {
>        struct a2dp_sep         *sep;
> +       struct vdp_sep          *vdp_sep;
>        char                    *sender;        /* Endpoint DBus bus id */
>        char                    *path;          /* Endpoint object path */
>        char                    *uuid;          /* Endpoint property UUID */
> @@ -141,6 +143,10 @@ static void media_endpoint_remove(struct media_endpoint *endpoint)
>                return;
>        }
>
> +       if (endpoint->vdp_sep) {
> +               vdp_remove_sep(endpoint->vdp_sep);
> +               return;
> +       }
>        info("Endpoint unregistered: sender=%s path=%s", endpoint->sender,
>                        endpoint->path);
>
> @@ -539,6 +545,113 @@ static struct a2dp_endpoint a2dp_endpoint = {
>        .set_delay = set_delay
>  };
>
> +static const char *vdp_get_name(struct vdp_sep *sep, void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +
> +       return endpoint->sender;
> +}
> +
> +static size_t vdp_get_capabilities(struct vdp_sep *sep, uint8_t **capabilities,
> +                                                       void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +
> +       *capabilities = endpoint->capabilities;
> +       return endpoint->size;
> +}
> +
> +struct vdp_config_data {
> +       guint setup_id;
> +       vdp_endpoint_config_t cb;
> +};
> +
> +struct vdp_select_data {
> +       guint setup_id;
> +       vdp_endpoint_select_t cb;
> +};
> +
> +static void vdp_select_cb(struct media_endpoint *endpoint, void *ret, int size,
> +                                                       void *user_data)
> +{
> +       struct vdp_select_data *data = user_data;
> +
> +       data->cb(endpoint->vdp_sep, data->setup_id, ret, size);
> +}
> +
> +static int vdp_select_config(struct vdp_sep *sep, uint8_t *capabilities,
> +                               size_t length, guint setup_id,
> +                               vdp_endpoint_select_t cb, void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +       struct vdp_select_data *data;
> +
> +       data = g_new0(struct vdp_select_data, 1);
> +       data->setup_id = setup_id;
> +       data->cb = cb;
> +
> +       if (select_configuration(endpoint, capabilities, length,
> +                                       vdp_select_cb, data, g_free) == TRUE)
> +               return 0;
> +
> +       g_free(data);
> +       return -ENOMEM;
> +}
> +
> +static void vdp_config_cb(struct media_endpoint *endpoint, void *ret, int size,
> +                                                       void *user_data)
> +{
> +       struct vdp_config_data *data = user_data;
> +
> +       data->cb(endpoint->vdp_sep, data->setup_id, ret ? TRUE : FALSE);
> +}
> +
> +static int vdp_set_config(struct vdp_sep *sep, struct audio_device *dev,
> +                               uint8_t *configuration, size_t length,
> +                               guint setup_id, vdp_endpoint_config_t cb,
> +                               void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +       struct vdp_config_data *data;
> +
> +       data = g_new0(struct vdp_config_data, 1);
> +       data->setup_id = setup_id;
> +       data->cb = cb;
> +
> +       if (set_configuration(endpoint, dev, configuration, length,
> +                                       vdp_config_cb, data, g_free) == TRUE)
> +               return 0;
> +
> +       g_free(data);
> +       return -ENOMEM;
> +}
> +
> +static void vdp_clear_config(struct vdp_sep *sep, void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +
> +       clear_configuration(endpoint);
> +}
> +
> +static void vdp_set_delay(struct vdp_sep *sep, uint16_t delay, void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +
> +       if (endpoint->transport == NULL)
> +               return;
> +
> +       media_transport_update_delay(endpoint->transport, delay);
> +}
> +
> +static struct vdp_endpoint vdp_endpoint = {
> +       .get_name = vdp_get_name,
> +       .get_capabilities = vdp_get_capabilities,
> +       .select_configuration = vdp_select_config,
> +       .set_configuration = vdp_set_config,
> +       .clear_configuration = vdp_clear_config,
> +       .set_delay = vdp_set_delay
> +};
> +
>  static void a2dp_destroy_endpoint(void *user_data)
>  {
>        struct media_endpoint *endpoint = user_data;
> @@ -552,6 +665,19 @@ static void a2dp_destroy_endpoint(void *user_data)
>        release_endpoint(endpoint);
>  }
>
> +static void vdp_destroy_endpoint(void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +
> +       if (endpoint->transport) {
> +               media_transport_destroy(endpoint->transport);
> +               endpoint->transport = NULL;
> +       }
> +
> +       endpoint->sep = NULL;
> +       release_endpoint(endpoint);
> +}
> +
>  static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
>                                                const char *sender,
>                                                const char *path,
> @@ -592,7 +718,21 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
>                                        endpoint, a2dp_destroy_endpoint, err);
>                if (endpoint->sep == NULL)
>                        goto failed;
> -       } else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
> +       } else if (strcasecmp(uuid, VDP_SOURCE_UUID) == 0) {
> +               endpoint->vdp_sep = vdp_add_sep(&adapter->src,
> +                                       AVDTP_SEP_TYPE_SOURCE, codec,
> +                                       delay_reporting, &vdp_endpoint,
> +                                       endpoint, vdp_destroy_endpoint, err);
> +               if (endpoint->vdp_sep == NULL)
> +                       goto failed;
> +       } else if (strcasecmp(uuid, VDP_SINK_UUID) == 0) {
> +               endpoint->vdp_sep = vdp_add_sep(&adapter->src,
> +                                       AVDTP_SEP_TYPE_SINK, codec,
> +                                       delay_reporting, &vdp_endpoint,
> +                                       endpoint, vdp_destroy_endpoint, err);
> +               if (endpoint->vdp_sep == NULL)
> +                       goto failed;
> +       }else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
>                                        g_strcmp0(uuid, HSP_AG_UUID) == 0) {
>                struct audio_device *dev;
>
> --
> 1.7.6

This is another reason why we want a common code to handle the seps,
so a2dp_sep and vdp_sep could be merged, in fact they represent the
same thing an AVDTP sep.

-- 
Luiz Augusto von Dentz
