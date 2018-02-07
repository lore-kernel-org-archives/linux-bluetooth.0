Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1698030.qWPfoGvGzI@ix>
References: <20180206104306.14895-1-szymon.janc@codecoup.pl>
 <d8f7306b-a4b0-20c2-6423-ff1215a34ea9@jp.fujitsu.com> <1698030.qWPfoGvGzI@ix>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Feb 2018 07:14:33 -0200
Message-ID: <CABBYNZJwcLS_awySWZxpvQ2ZJxLppQv4Z-xaum6uwM569-NGog@mail.gmail.com>
Subject: Re: [PATCH] advertising: Configure discoverable flag based on adapter settings
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon, Eramoto,

On Wed, Feb 7, 2018 at 6:46 AM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi,
>
> On Wednesday, 7 February 2018 02:24:13 CET ERAMOTO Masaya wrote:
>> Hi Szymon,
>>
>> On 02/06/2018 07:43 PM, Szymon Janc wrote:
>> > Until now advertising as peripheral was always setting General
>> > Discoverable
>> > flag set. With this patch this is set based on adapter discoverable
>> > setting. ---
>> >
>> >  src/adapter.c     |  9 +++++++++
>> >  src/adapter.h     |  1 +
>> >  src/advertising.c | 19 +++++++++++++++++--
>> >  src/advertising.h |  1 +
>> >  4 files changed, 28 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/src/adapter.c b/src/adapter.c
>> > index 50cf46b11..5070c0f09 100644
>> > --- a/src/adapter.c
>> > +++ b/src/adapter.c
>> > @@ -543,6 +543,7 @@ static void settings_changed(struct btd_adapter
>> > *adapter, uint32_t settings)>
>> >             g_dbus_emit_property_changed(dbus_conn, adapter->path,
>> >
>> >                                     ADAPTER_INTERFACE, "Discoverable");
>> >
>> >             store_adapter_info(adapter);
>> >
>> > +           btd_adv_manager_refresh(adapter->adv_manager);
>> >
>> >     }
>> >
>> >     if (changed_mask & MGMT_SETTING_BONDABLE) {
>> >
>> > @@ -4108,6 +4109,14 @@ bool btd_adapter_get_connectable(struct btd_adapter
>> > *adapter)>
>> >     return false;
>> >
>> >  }
>> >
>> > +bool btd_adapter_get_discoverable(struct btd_adapter *adapter)
>> > +{
>> > +   if (adapter->current_settings & MGMT_SETTING_DISCOVERABLE)
>> > +           return true;
>> > +
>> > +   return false;
>> > +}
>> > +
>> >
>> >  struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter
>> >  *adapter) {
>> >
>> >     if (!adapter)
>> >
>> > diff --git a/src/adapter.h b/src/adapter.h
>> > index a85327cd1..e619a5be9 100644
>> > --- a/src/adapter.h
>> > +++ b/src/adapter.h
>> > @@ -74,6 +74,7 @@ void adapter_foreach(adapter_cb func, gpointer
>> > user_data);>
>> >  bool btd_adapter_get_pairable(struct btd_adapter *adapter);
>> >  bool btd_adapter_get_powered(struct btd_adapter *adapter);
>> >  bool btd_adapter_get_connectable(struct btd_adapter *adapter);
>> >
>> > +bool btd_adapter_get_discoverable(struct btd_adapter *adapter);
>> >
>> >  struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter
>> >  *adapter);>
>> > diff --git a/src/advertising.c b/src/advertising.c
>> > index 94a8c4050..637445189 100644
>> > --- a/src/advertising.c
>> > +++ b/src/advertising.c
>> > @@ -622,8 +622,12 @@ static int refresh_adv(struct btd_adv_client *client,
>> > mgmt_request_func_t func)>
>> >     DBG("Refreshing advertisement: %s", client->path);
>> >
>> > -   if (client->type == AD_TYPE_PERIPHERAL)
>> > -           flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
>> > +   if (client->type == AD_TYPE_PERIPHERAL) {
>> > +           flags = MGMT_ADV_FLAG_CONNECTABLE;
>> > +
>> > +           if (btd_adapter_get_discoverable(client->manager->adapter))
>> > +                   flags |= MGMT_ADV_FLAG_DISCOV;
>> > +   }
>> >
>> >     flags |= client->flags;
>> >
>> > @@ -1104,3 +1108,14 @@ void btd_adv_manager_destroy(struct btd_adv_manager
>> > *manager)>
>> >     manager_destroy(manager);
>> >
>> >  }
>> >
>> > +void btd_adv_manager_refresh(struct btd_adv_manager *manager)
>> > +{
>> > +   const struct queue_entry *entry;
>> > +
>> > +   for (entry = queue_get_entries(manager->clients); entry;
>> > +                                                   entry = entry->next) {
>> > +           struct btd_adv_client *client = entry->data;
>> > +
>> > +           refresh_adv(client, NULL);
>> > +   }
>> > +}
>>
>> I think that it is more safe to use queue_foreach() instead of for loop.
>
> Why? refresh_adv() doesn't modify queue.

In this specific case it is more a matter of taste but I lean toward
using queue_foreach as much as possible as code may change.

> --
> pozdrawiam
> Szymon Janc
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
