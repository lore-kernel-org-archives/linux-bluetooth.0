Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310564415-26093-2-git-send-email-dh.herrmann@googlemail.com>
References: <1310564415-26093-1-git-send-email-dh.herrmann@googlemail.com>
	<1310564415-26093-2-git-send-email-dh.herrmann@googlemail.com>
Date: Fri, 15 Jul 2011 13:41:04 +0300
Message-ID: <CABBYNZJXUZHHb8ZZk_wHpFVgO+w1CuE=HPNXwRsK9Z4tB5R5MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Add pin-code hook to adapter api
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Jul 13, 2011 at 4:40 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Plugins may now register pincode callbacks which are called when the
> authentication of a new device requires a pincode. This allows to have
> hard-coded binary pins inside the daemon to circumvent the public dbus
> api restrictions (only valid UTF8 strings).
>
> The callbacks shall check via VID/PID information whether they support
> the device and if not, return 0 so the dbus api is used to query the
> current agent for pin input.
> ---
> V2: Removing get_pin() function and moving all pin handling into
> btd_adapter_get_pin(). Also change callback return type to ssize_t.
> *_pincb_* has been renamed to *_pin_cb_*
>
>  src/adapter.c |   35 +++++++++++++++++++++++++++++++++++
>  src/adapter.h |    9 +++++++++
>  src/event.c   |    2 +-
>  3 files changed, 45 insertions(+), 1 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 0909a22..9fadc1c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -146,6 +146,7 @@ struct btd_adapter {
>        guint off_timer;
>
>        GSList *powered_callbacks;
> +       GSList *pin_callbacks;
>
>        GSList *loaded_drivers;
>  };
> @@ -2573,6 +2574,7 @@ void adapter_remove(struct btd_adapter *adapter)
>        g_slist_free(adapter->devices);
>
>        unload_drivers(adapter);
> +       g_slist_free(adapter->pin_callbacks);
>
>        /* Return adapter to down state if it was not up on init */
>        adapter_ops->restore_powered(adapter->dev_id);
> @@ -3435,6 +3437,39 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
>        return 0;
>  }
>
> +void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> +                                                       btd_adapter_pin_cb_t cb)
> +{
> +       adapter->pin_callbacks = g_slist_prepend(adapter->pin_callbacks, cb);
> +}
> +
> +void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
> +                                                       btd_adapter_pin_cb_t cb)
> +{
> +       adapter->pin_callbacks = g_slist_remove(adapter->pin_callbacks, cb);
> +}
> +
> +ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
> +                                                               char *pin_buf)
> +{
> +       GSList *l;
> +       btd_adapter_pin_cb_t cb;
> +       bdaddr_t sba, dba;
> +       ssize_t ret;
> +
> +       for (l = adapter->pin_callbacks; l != NULL; l = g_slist_next(l)) {
> +               cb = l->data;
> +               ret = cb(adapter, dev, pin_buf);
> +               if (ret > 0)
> +                       return ret;
> +       }
> +
> +       adapter_get_address(adapter, &sba);
> +       device_get_address(dev, &dba);
> +
> +       return read_pin_code(&sba, &dba, pin_buf);
> +}
> +
>  int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority)
>  {
>        if (ops->setup == NULL)
> diff --git a/src/adapter.h b/src/adapter.h
> index 38ea3ca..687275a 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -165,6 +165,15 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter);
>  int btd_adapter_switch_online(struct btd_adapter *adapter);
>  int btd_adapter_switch_offline(struct btd_adapter *adapter);
>
> +typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
> +                                       struct btd_device *dev, char *out);
> +void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> +                                               btd_adapter_pin_cb_t cb);
> +void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
> +                                               btd_adapter_pin_cb_t cb);
> +ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
> +                                                               char *pin_buf);
> +
>  typedef void (*bt_hci_result_t) (uint8_t status, gpointer user_data);
>
>  struct btd_adapter_ops {
> diff --git a/src/event.c b/src/event.c
> index a944248..99d805c 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -134,7 +134,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
>                return -ENODEV;
>
>        memset(pin, 0, sizeof(pin));
> -       pinlen = read_pin_code(sba, dba, pin);
> +       pinlen = btd_adapter_get_pin(adapter, device, pin);
>        if (pinlen > 0 && (!secure || pinlen == 16)) {
>                btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
>                return 0;
> --
> 1.7.6

The idea itself is nice, but having each callback to check for VID/PID
seems inefficient, what could be done instead is to extend the device
driver adding VID and PID so they can be used as device
unique/specific drivers which could deal with predefined/hardcoded
pincodes, how about that?


-- 
Luiz Augusto von Dentz
