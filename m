Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCV6K3KmRENem=ByCpdkq_hW+05xfqxj6Gg+rVqNBy8g+g@mail.gmail.com>
References: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1360142187-15347-4-git-send-email-mikel.astiz.oss@gmail.com>
	<CAKT1EBd=MpntvH=7ebRHVUpubojjJW1ipda-YbLdvuDcjYjzAw@mail.gmail.com>
	<CANT-zCV6K3KmRENem=ByCpdkq_hW+05xfqxj6Gg+rVqNBy8g+g@mail.gmail.com>
Date: Wed, 27 Feb 2013 08:46:25 +0100
Message-ID: <CANT-zCUZM4oF8T9zHCGD=L+X7rT_09=4hXZ3iqzoQTO0N-Bv0A@mail.gmail.com>
Subject: Re: [RFC v1 3/7] proximity: Split internal monitor registration API
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 15, 2013 at 8:54 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi Claudio,
>
> On Thu, Feb 14, 2013 at 5:37 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Hi Mikel:
>>
>> On Wed, Feb 6, 2013 at 6:16 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>>
>>> Split the monitor registration API into three independent registrations
>>> each of them taking one specific GATT primary.
>>> ---
>>>  profiles/proximity/manager.c |  16 +++-
>>>  profiles/proximity/monitor.c | 220 ++++++++++++++++++++++++++++++++++---------
>>>  profiles/proximity/monitor.h |  17 +++-
>>>  3 files changed, 204 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
>>> index b405f15..1c07267 100644
>>> --- a/profiles/proximity/manager.c
>>> +++ b/profiles/proximity/manager.c
>>> @@ -52,18 +52,30 @@ static int monitor_device_probe(struct btd_profile *p,
>>>                                 struct btd_device *device, GSList *uuids)
>>>  {
>>>         struct gatt_primary *linkloss, *txpower, *immediate;
>>> +       int err = 0;
>>>
>>>         immediate = btd_device_get_primary(device, IMMEDIATE_ALERT_UUID);
>>>         txpower = btd_device_get_primary(device, TX_POWER_UUID);
>>>         linkloss = btd_device_get_primary(device, LINK_LOSS_UUID);
>>>
>>> -       return monitor_register(device, linkloss, txpower, immediate, &enabled);
>>> +       if (linkloss)
>>> +               err = monitor_register_linkloss(device, &enabled, linkloss);
>>> +
>>> +       if (err >= 0 && txpower)
>>> +               err = monitor_register_txpower(device, &enabled, txpower);
>>> +
>>> +       if (err >= 0 && immediate)
>>> +               err = monitor_register_immediate(device, &enabled, immediate);
>>> +
>>
>> I recommend to invert the logic here, checking if immediate alert is
>> available first. Immediate alert service is mandatory for Link Loss,
>> Path Loss(tx power) and find me.
>
> According to the code being removed in monitor_register(), the
> linkloss service seems independent from immediate alert. In fact, I
> tried to clarify this in the spec and what I found is that the
> linkloss service is mandatory while the rest are optional. Am I
> missing something?
>
> In any case, to start with, it makes sense that txpower gets
> registered last to improve readability.
>
> Also note that I tried to express the dependencies you mention in
> update_monitor() and the registration functions assuming that, once
> split, the profiles can be probed in any arbitrary order (i.e. txpower
> probed before immediate alert).
>
>>
>>> +       return err;
>>>  }
>>>
>>>  static void monitor_device_remove(struct btd_profile *p,
>>>                                                 struct btd_device *device)
>>>  {
>>> -       monitor_unregister(device);
>>> +       monitor_unregister_immediate(device);
>>> +       monitor_unregister_txpower(device);
>>> +       monitor_unregister_linkloss(device);
>>>  }
>>>
>>>  static struct btd_profile pxp_monitor_profile = {
>>> diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
>>> index 597f161..489ccdd 100644
>>> --- a/profiles/proximity/monitor.c
>>> +++ b/profiles/proximity/monitor.c
>>> @@ -34,6 +34,7 @@
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <sys/stat.h>
>>> +#include <glib.h>
>>>
>>>  #include <bluetooth/bluetooth.h>
>>>
>>> @@ -83,6 +84,22 @@ struct monitor {
>>>         guint attioid;
>>>  };
>>>
>>> +static GSList *monitors = NULL;
>>> +
>>> +static struct monitor *find_monitor(struct btd_device *device)
>>> +{
>>> +       GSList *l;
>>> +
>>> +       for (l = monitors; l; l = l->next) {
>>> +               struct monitor *monitor = l->data;
>>> +
>>> +               if (monitor->device == device)
>>> +                       return monitor;
>>> +       }
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>>  static void write_proximity_config(struct btd_device *device, const char *alert,
>>>                                         const char *level)
>>>  {
>>> @@ -580,33 +597,25 @@ static void monitor_destroy(gpointer user_data)
>>>  {
>>>         struct monitor *monitor = user_data;
>>>
>>> -       if (monitor->immediateto)
>>> -               g_source_remove(monitor->immediateto);
>>> -
>>> -       if (monitor->attioid)
>>> -               btd_device_remove_attio_callback(monitor->device,
>>> -                                               monitor->attioid);
>>> -       if (monitor->attrib)
>>> -               g_attrib_unref(monitor->attrib);
>>> -
>>>         btd_device_unref(monitor->device);
>>> -       g_free(monitor->linkloss);
>>> -       g_free(monitor->immediate);
>>> -       g_free(monitor->txpower);
>>>         g_free(monitor->linklosslevel);
>>>         g_free(monitor->immediatelevel);
>>>         g_free(monitor->signallevel);
>>>         g_free(monitor);
>>> +
>>> +       monitors = g_slist_remove(monitors, monitor);
>>>  }
>>>
>>> -int monitor_register(struct btd_device *device,
>>> -               struct gatt_primary *linkloss, struct gatt_primary *txpower,
>>> -               struct gatt_primary *immediate, struct enabled *enabled)
>>> +static struct monitor *register_monitor(struct btd_device *device)
>>>  {
>>>         const char *path = device_get_path(device);
>>>         struct monitor *monitor;
>>>         char *level;
>>>
>>> +       monitor = find_monitor(device);
>>> +       if (monitor != NULL)
>>> +               return monitor;
>>> +
>>>         level = read_proximity_config(device, "LinkLossAlertLevel");
>>>
>>>         monitor = g_new0(struct monitor, 1);
>>> @@ -615,6 +624,8 @@ int monitor_register(struct btd_device *device,
>>>         monitor->signallevel = g_strdup("unknown");
>>>         monitor->immediatelevel = g_strdup("none");
>>>
>>> +       monitors = g_slist_append(monitors, monitor);
>>> +
>>>         if (g_dbus_register_interface(btd_get_dbus_connection(), path,
>>>                                 PROXIMITY_INTERFACE,
>>>                                 NULL, NULL, monitor_device_properties,
>>> @@ -622,55 +633,178 @@ int monitor_register(struct btd_device *device,
>>>                 error("D-Bus failed to register %s interface",
>>>                                                 PROXIMITY_INTERFACE);
>>>                 monitor_destroy(monitor);
>>> -               return -1;
>>> +               return NULL;
>>>         }
>>>
>>>         DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE, path);
>>>
>>> -       if (linkloss && enabled->linkloss) {
>>> -               monitor->linkloss = g_new0(struct att_range, 1);
>>> -               monitor->linkloss->start = linkloss->range.start;
>>> -               monitor->linkloss->end = linkloss->range.end;
>>> -
>>> -               monitor->enabled.linkloss = TRUE;
>>> -       }
>>> -
>>> -       if (immediate) {
>>> -               if (txpower && enabled->pathloss) {
>>> -                       monitor->txpower = g_new0(struct att_range, 1);
>>> -                       monitor->txpower->start = txpower->range.start;
>>> -                       monitor->txpower->end = txpower->range.end;
>>> -
>>> -                       monitor->enabled.pathloss = TRUE;
>>> -               }
>>> -
>>> -               if (enabled->pathloss || enabled->findme) {
>>> -                       monitor->immediate = g_new0(struct att_range, 1);
>>> -                       monitor->immediate->start = immediate->range.start;
>>> -                       monitor->immediate->end = immediate->range.end;
>>> -               }
>>> +       return monitor;
>>> +}
>>>
>>> -               monitor->enabled.findme = enabled->findme;
>>> -       }
>>> +static void update_monitor(struct monitor *monitor)
>>> +{
>>> +       if (monitor->txpower != NULL && monitor->immediate != NULL)
>>> +               monitor->enabled.pathloss = TRUE;
>>> +       else
>>> +               monitor->enabled.pathloss = FALSE;
>>>
>>>         DBG("Link Loss: %s, Path Loss: %s, FindMe: %s",
>>>                                 monitor->enabled.linkloss ? "TRUE" : "FALSE",
>>>                                 monitor->enabled.pathloss ? "TRUE" : "FALSE",
>>>                                 monitor->enabled.findme ? "TRUE" : "FALSE");
>>>
>>> -       if (monitor->enabled.linkloss || monitor->enabled.pathloss)
>>> -               monitor->attioid = btd_device_add_attio_callback(device,
>>> +       if (!monitor->enabled.linkloss && !monitor->enabled.pathloss)
>>> +               return;
>>> +
>>> +       if (monitor->attioid != 0)
>>> +               return;
>>> +
>>> +       monitor->attioid = btd_device_add_attio_callback(monitor->device,
>>>                                                         attio_connected_cb,
>>>                                                         attio_disconnected_cb,
>>>                                                         monitor);
>>> +}
>>> +
>>> +int monitor_register_linkloss(struct btd_device *device,
>>> +                                               struct enabled *enabled,
>>> +                                               struct gatt_primary *linkloss)
>>> +{
>>> +       struct monitor *monitor;
>>> +
>>> +       if (!enabled->linkloss)
>>> +               return 0;
>>
>> Link loss requires immediate alert service, it is necessary to
>> investigate if make sense to add this verification here or check the
>> value before calling this function.
>> The same comment is valid for path loss(tx power).
>
> Regarding link-loss, please confirm that this dependency to immediate
> alert actually exists.
>
> Regarding tx-power, as mentioned before, the motivation was the fact
> that, if the profiles get split, the exact order in which they are
> probed is undefined. Therefore, monitor_register_txpower() doesn't
> actually set enabled.pathloss to true, but instead delegates this work
> to update_monitor(), which should gracefully handle both possible
> probe combinations (immediate alert probed before or after txpower).
>
>>
>>> +
>>> +       monitor = register_monitor(device);
>>> +       if (monitor == NULL)
>>> +               return -1;
>>> +
>>> +       monitor->linkloss = g_new0(struct att_range, 1);
>>> +       monitor->linkloss->start = linkloss->range.start;
>>> +       monitor->linkloss->end = linkloss->range.end;
>>> +       monitor->enabled.linkloss = TRUE;
>>> +
>>> +       update_monitor(monitor);
>>>
>>>         return 0;
>>>  }
>>>
>>> -void monitor_unregister(struct btd_device *device)
>>> +int monitor_register_txpower(struct btd_device *device,
>>> +                                               struct enabled *enabled,
>>> +                                               struct gatt_primary *txpower)
>>>  {
>>> +       struct monitor *monitor;
>>> +
>>> +       if (!enabled->pathloss)
>>> +               return 0;
>>> +
>>> +       monitor = register_monitor(device);
>>> +       if (monitor == NULL)
>>> +               return -1;
>>> +
>>> +       monitor->txpower = g_new0(struct att_range, 1);
>>> +       monitor->txpower->start = txpower->range.start;
>>> +       monitor->txpower->end = txpower->range.end;
>>> +
>>> +       update_monitor(monitor);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +int monitor_register_immediate(struct btd_device *device,
>>> +                                               struct enabled *enabled,
>>> +                                               struct gatt_primary *immediate)
>>> +{
>>> +       struct monitor *monitor;
>>> +
>>> +       if (!enabled->pathloss && !enabled->findme)
>>> +               return 0;
>>> +
>>> +       monitor = register_monitor(device);
>>> +       if (monitor == NULL)
>>> +               return -1;
>>> +
>>> +       monitor->immediate = g_new0(struct att_range, 1);
>>> +       monitor->immediate->start = immediate->range.start;
>>> +       monitor->immediate->end = immediate->range.end;
>>> +       monitor->enabled.findme = enabled->findme;
>>> +
>>> +       update_monitor(monitor);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void cleanup_monitor(struct monitor *monitor)
>>> +{
>>> +       struct btd_device *device = monitor->device;
>>>         const char *path = device_get_path(device);
>>>
>>> +       if (monitor->immediate != NULL || monitor->txpower != NULL)
>>> +               return;
>>> +
>>> +       if (monitor->immediateto != 0) {
>>> +               g_source_remove(monitor->immediateto);
>>> +               monitor->immediateto = 0;
>>> +       }
>>> +
>>> +       if (monitor->attioid != 0) {
>>> +               btd_device_remove_attio_callback(device, monitor->attioid);
>>> +               monitor->attioid = 0;
>>> +       }
>>> +
>>> +       if (monitor->attrib != NULL) {
>>> +               g_attrib_unref(monitor->attrib);
>>> +               monitor->attrib = NULL;
>>> +       }
>>> +
>>> +       if (monitor->linkloss != NULL)
>>> +               return;
>>
>> Why this checking is here instead of check in the beginning of this function?
>
> My understanding of the previous code was that the cleanup above
> (before the linkloss check) belonged to immediate alert and txpower.
> Having a careful look at the code I realized that monitor->attioid and
> monitor->attrib should be moved to the end of the function, since
> linkloss makes use of them.
>
> Whether monitor->immediateto should also come after this check or not
> depends again on what the exact dependencies are.
>
>>
>>> +
>>>         g_dbus_unregister_interface(btd_get_dbus_connection(), path,
>>>                                                         PROXIMITY_INTERFACE);
>>>  }
>>> +
>>> +void monitor_unregister_linkloss(struct btd_device *device)
>>> +{
>>> +       struct monitor *monitor;
>>> +
>>> +       monitor = find_monitor(device);
>>> +       if (monitor == NULL)
>>> +               return;
>>> +
>>> +       g_free(monitor->linkloss);
>>> +       monitor->linkloss = NULL;
>>> +       monitor->enabled.linkloss = TRUE;
>>
>> If you are unregistering a service, is it necessary to set
>> enabled.linkloss = TRUE?
>
> My mistake, this should have been FALSE.
>
>>
>>> +
>>> +       cleanup_monitor(monitor);
>>> +}
>>> +
>>> +void monitor_unregister_txpower(struct btd_device *device)
>>> +{
>>> +       struct monitor *monitor;
>>> +
>>> +       monitor = find_monitor(device);
>>> +       if (monitor == NULL)
>>> +               return;
>>> +
>>> +       g_free(monitor->txpower);
>>> +       monitor->txpower = NULL;
>>> +       monitor->enabled.pathloss = FALSE;
>>
>> Same question here.
>
> The unregister function try to support partial unregistration to be
> consistent with the registration procedure, but perhaps this is
> overkill since typically all profiles will be removed at once.
>
> In fact, many other profiles simplify the unregistration by just
> removing more than one profile at the same time (see for example
> audio_device_unregister()). Any thoughts on this? Is such a
> simplification encouraged?
>
>>
>>> +
>>> +       cleanup_monitor(monitor);
>>> +}
>>> +
>>> +void monitor_unregister_immediate(struct btd_device *device)
>>> +{
>>> +       struct monitor *monitor;
>>> +
>>> +       monitor = find_monitor(device);
>>> +       if (monitor == NULL)
>>> +               return;
>>> +
>>> +       g_free(monitor->immediate);
>>> +       monitor->immediate = NULL;
>>> +       monitor->enabled.findme = FALSE;
>>> +       monitor->enabled.pathloss = FALSE;
>>
>> Same question here.
>>
>>
>> Regards,
>> Claudio
>
> Cheers,
> Mikel

Ping.

Cheers,
Mikel
