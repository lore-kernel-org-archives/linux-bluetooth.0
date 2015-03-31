Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427758340-14949-7-git-send-email-jpawlowski@google.com>
References: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
	<1427758340-14949-7-git-send-email-jpawlowski@google.com>
Date: Mon, 30 Mar 2015 18:18:22 -0700
Message-ID: <CAHrH25SX6Yd8g9b6CGQXqj0gH-Zq0b48bgrDhN533Y5KN1gd-w@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] core: adapter: filter discovery results when
 filered discovery is used
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Mon, Mar 30, 2015 at 4:32 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch adds filtering to device found event, and enforces lack
> of RSSI delta for filtered scan.
>
> When filtering, we compare against each client filter. That
> additionally removes some of reports.
> ---
>  src/adapter.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 67db99c..8d78e0a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -5297,6 +5297,63 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
>         }
>  }
>
> +static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
> +                                                               int8_t rssi)
> +{
> +       GSList *l, *m;
> +       bool got_match = false;
> +
> +       for (l = discovery_filter; l != NULL && got_match != true;
> +                                                       l = g_slist_next(l)) {
> +               struct watch_client *client = l->data;
> +               struct discovery_filter *item = client->discovery_filter;
> +
> +               /*
> +                * If one of currently running scans is regular scan, then
> +                * return all devices as matches
> +                */
> +               if (!item) {
> +                       got_match = true;
> +                       continue;
> +               }
> +
> +               /* if someone started discovery with empty uuids, he wants all
> +                * devices in given proximity.
> +                */
> +               if (!item->uuids)
> +                       got_match = true;
> +               else
> +                       for (m = item->uuids; m != NULL && got_match != true;
> +                                                          m = g_slist_next(m))
> +                               /* m->data contains string representation of
> +                                * uuid.
> +                                */
> +                               if (g_slist_find_custom(eir_data->services,
> +                                                       m->data,
> +                                                       g_strcmp) != NULL)
> +                                       got_match = true;

Use curly braces for the else statement here. It's contents are
difficult to parse otherwise. Same for the for loop.

> +
> +               if (got_match) {
> +                       /* we have service match, check proximity */
> +                       if (item->rssi != DISTANCE_VAL_INVALID &&
> +                           item->rssi > rssi)
> +                               got_match = false;
> +                       if (item->pathloss != DISTANCE_VAL_INVALID &&
> +                          (eir_data->tx_power == 127 ||
> +                          eir_data->tx_power - rssi > item->pathloss))
> +                               got_match = false;

Just return true if both of these if statements evaluate to false?

> +
> +                       if (got_match)
> +                               return true;
> +               }
> +       }
> +
> +       if (!got_match)
> +               return false;
> +
> +       return true;
> +}
> +
>  static void update_found_devices(struct btd_adapter *adapter,
>                                         const bdaddr_t *bdaddr,
>                                         uint8_t bdaddr_type, int8_t rssi,
> @@ -5363,8 +5420,18 @@ static void update_found_devices(struct btd_adapter *adapter,
>                 return;
>         }
>
> +       if (adapter->filtered_discovery &&
> +           !is_filter_match(adapter->discovery_list, &eir_data, rssi)) {
> +               eir_data_free(&eir_data);
> +               return;
> +       }
> +
>         device_set_legacy(dev, legacy);
> -       device_set_rssi(dev, rssi);
> +
> +       if (adapter->filtered_discovery)
> +               device_set_rssi_with_delta(dev, rssi, 0);
> +       else
> +               device_set_rssi(dev, rssi);
>
>         if (eir_data.appearance != 0)
>                 device_set_appearance(dev, eir_data.appearance);
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
