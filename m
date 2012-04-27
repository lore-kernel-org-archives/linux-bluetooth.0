Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335524387-22831-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1335524387-22831-5-git-send-email-mikel.astiz.oss@gmail.com>
Date: Fri, 27 Apr 2012 14:45:51 +0300
Message-ID: <CABBYNZ+9a7RNc23Tcf=PS6oEND2b9dNg6OKiKGb8cGnK18vCfg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 4/5] media: Create multiple transports if needed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Apr 27, 2012 at 1:59 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:

> -static struct media_transport *get_unique_transport(
> -                                       struct media_endpoint *endpoint)
> -{
> -       if (endpoint->transports == NULL)
> -               return NULL;
> -
> -       if (endpoint->transports->next != NULL)
> -               return NULL;
> -
> -       return endpoint->transports->data;
> -}

This shouldn't be here in the first place.

>        } else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
>                                        strcasecmp(uuid, HSP_AG_UUID) == 0) {
> -               struct audio_device *dev;
> +               GSList *list;
> +               GSList *l;
>
>                endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
>                                                                endpoint);
> -               dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
> +               list = manager_find_devices(NULL, &adapter->src, BDADDR_ANY,
>                                                AUDIO_HEADSET_INTERFACE, TRUE);
> -               if (dev)
> +
> +               for (l = list; l != NULL; l = l->next) {
> +                       struct audio_device *dev = l->data;
> +
>                        set_configuration(endpoint, dev, NULL, 0,
>                                                headset_setconf_cb, dev, NULL);
> +               }
> +
> +               g_slist_free(list);
>        } else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
>                                        strcasecmp(uuid, HSP_HS_UUID) == 0) {
> -               struct audio_device *dev;
> +               GSList *list;
> +               GSList *l;
>
>                endpoint->ag_watch = gateway_add_state_cb(gateway_state_changed,
>                                                                endpoint);
> -               dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
> +               list = manager_find_devices(NULL, &adapter->src, BDADDR_ANY,
>                                                AUDIO_GATEWAY_INTERFACE, TRUE);
> -               if (dev)
> +
> +               for (l = list; l != NULL; l = l->next) {
> +                       struct audio_device *dev = l->data;
> +
>                        set_configuration(endpoint, dev, NULL, 0,
>                                                gateway_setconf_cb, dev, NULL);
> +               }
> +
> +               g_slist_free(list);
>        } else {
>                if (err)
>                        *err = -EINVAL;

This function is becoming too big/complex, please split it per
uuid/role whenever possible.


-- 
Luiz Augusto von Dentz
