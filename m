Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426180319-16509-10-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
	<1426180319-16509-10-git-send-email-jamuraa@chromium.org>
Date: Thu, 12 Mar 2015 13:16:52 -0700
Message-ID: <CAHrH25SpoqLSN0L24wPvVsdk-CF6XJe0v4+RieANusZ4u6Eyeg@mail.gmail.com>
Subject: Re: [BlueZ 09/12] advertising-manager: Parse SolicitUUIDs
From: Arman Uguray <armansito@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> On Thu, Mar 12, 2015 at 10:11 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Parse the SolicitUUIDs property of the LEAdvertisement1 object.
> ---
>  src/advertising-manager.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tools/advertisement-example |  5 +++++

Patches that touch core and those that touch tools should go in their
separate patches.

>  2 files changed, 48 insertions(+)
>
> diff --git a/src/advertising-manager.c b/src/advertising-manager.c
> index 92e5cad..e7c24c6 100644
> --- a/src/advertising-manager.c
> +++ b/src/advertising-manager.c
> @@ -212,6 +212,44 @@ fail:
>         return false;
>  }
>
> +static bool parse_advertising_solicit_uuids(GDBusProxy *proxy,
> +                                       struct advertising_data *data)
> +{
> +       DBusMessageIter iter, ariter;
> +
> +       if (!g_dbus_proxy_get_property(proxy, "SolicitUUIDs", &iter))
> +               return true;
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
> +               return false;
> +
> +       dbus_message_iter_recurse(&iter, &ariter);
> +
> +       advertising_data_clear_solicit_uuid(data);
> +
> +       while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
> +               const char *uuid_str;
> +               bt_uuid_t uuid;
> +
> +               dbus_message_iter_get_basic(&ariter, &uuid_str);
> +
> +               DBG("Adding SolicitUUID: %s", uuid_str);
> +
> +               if (bt_string_to_uuid(&uuid, uuid_str) < 0)
> +                       goto fail;
> +
> +               advertising_data_add_solicit_uuid(data, &uuid);
> +
> +               dbus_message_iter_next(&ariter);
> +       }
> +
> +       return true;
> +
> +fail:
> +       advertising_data_clear_solicit_uuid(data);
> +       return false;
> +}
> +
>  static void refresh_advertisement(struct advertisement *ad)
>  {
>         DBG("Refreshing advertisement: %s", ad->path);
> @@ -232,6 +270,11 @@ static bool parse_advertisement(struct advertisement *ad)
>                 return false;
>         }
>
> +       if (!parse_advertising_solicit_uuids(ad->proxy, ad->data)) {
> +               error("Property \"SolicitUUIDs\" failed to parse correctly");
> +               return false;
> +       }
> +
>         /* TODO: parse the rest of the properties */
>
>         refresh_advertisement(ad);
> diff --git a/tools/advertisement-example b/tools/advertisement-example
> index fb2bdde..2227009 100644
> --- a/tools/advertisement-example
> +++ b/tools/advertisement-example
> @@ -78,6 +78,11 @@ class Advertisement(dbus.service.Object):
>              self.service_uuids = []
>          self.service_uuids.append(uuid)
>
> +    def add_solicit_uuid(self, uuid):
> +        if not self.solicit_uuids:
> +            self.solicit_uuids = []
> +        self.solicit_uuids.append(uuid)
> +
>      def add_manufacturer_data(self, manuf_code, data):
>          if not self.manufacturer_specific_data:
>              self.manufacturer_specific_data = dict()
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
