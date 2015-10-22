Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJRGytTx=BRD9m4mcdFOTdwsa8k81Mmj-_Jh0pNqYtFqg@mail.gmail.com>
References: <1444944087-9469-1-git-send-email-jpawlowski@google.com>
	<CAD0=r8yohwEOQ0i0MbzzvNSbSH6i0yLAE+NC1aw9xCOT14+Yaw@mail.gmail.com>
	<CABBYNZJRGytTx=BRD9m4mcdFOTdwsa8k81Mmj-_Jh0pNqYtFqg@mail.gmail.com>
Date: Wed, 21 Oct 2015 21:16:45 -0700
Message-ID: <CAD0=r8xb-aO_Byc0J9GN=u-=pF61q9AQ+FPJP0sG6Yyd+W-5VQ@mail.gmail.com>
Subject: Re: [PATCH] profiles: fix device info service triggering auto connect
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 21, 2015 at 3:38 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Wed, Oct 21, 2015 at 6:57 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> ping ?
>>
>> On Thu, Oct 15, 2015 at 2:21 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>> This patch makes sure that device info service is not triggering
>>> auto_connect.
>>> ---
>>>  profiles/alert/server.c              | 2 +-
>>>  profiles/cyclingspeed/cyclingspeed.c | 2 +-
>>>  profiles/deviceinfo/deviceinfo.c     | 2 +-
>>>  profiles/heartrate/heartrate.c       | 2 +-
>>>  profiles/input/hog.c                 | 1 +
>>>  profiles/proximity/immalert.c        | 2 +-
>>>  profiles/proximity/linkloss.c        | 2 +-
>>>  profiles/proximity/monitor.c         | 2 ++
>>>  profiles/scanparam/scan.c            | 1 +
>>>  profiles/thermometer/thermometer.c   | 2 +-
>>>  src/attio.h                          | 1 +
>>>  src/device.c                         | 4 +++-
>>>  12 files changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/profiles/alert/server.c b/profiles/alert/server.c
>>> index 2f6e3cd..9d102ef 100644
>>> --- a/profiles/alert/server.c
>>> +++ b/profiles/alert/server.c
>>> @@ -449,7 +449,7 @@ static void filter_devices_notify(struct btd_device *device, void *user_data)
>>>         cb->notify_data = notify_data;
>>>         cb->device = btd_device_ref(device);
>>>         cb->id = btd_device_add_attio_callback(device,
>>> -                                               attio_connected_cb, NULL, cb);
>>> +                                       attio_connected_cb, NULL, true, cb);
>>>  }
>>>
>>>  static void notify_devices(struct alert_adapter *al_adapter,
>>> diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
>>> index e447725..0cffa54 100644
>>> --- a/profiles/cyclingspeed/cyclingspeed.c
>>> +++ b/profiles/cyclingspeed/cyclingspeed.c
>>> @@ -1208,7 +1208,7 @@ static int csc_device_probe(struct btd_service *service)
>>>         cadapter->devices = g_slist_prepend(cadapter->devices, csc);
>>>
>>>         csc->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
>>> -                                               attio_disconnected_cb, csc);
>>> +                                       attio_disconnected_cb, true, csc);
>>>
>>>         return 0;
>>>  }
>>> diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
>>> index 6ee018c..10e5bd8 100644
>>> --- a/profiles/deviceinfo/deviceinfo.c
>>> +++ b/profiles/deviceinfo/deviceinfo.c
>>> @@ -172,7 +172,7 @@ static int deviceinfo_register(struct btd_service *service,
>>>         btd_service_set_user_data(service, d);
>>>
>>>         d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
>>> -                                               attio_disconnected_cb, d);
>>> +                                       attio_disconnected_cb, false, d);
>>>         return 0;
>>>  }
>>>
>>> diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
>>> index 9e8c499..dcc599e 100644
>>> --- a/profiles/heartrate/heartrate.c
>>> +++ b/profiles/heartrate/heartrate.c
>>> @@ -784,7 +784,7 @@ static int heartrate_device_register(struct btd_device *device,
>>>         hradapter->devices = g_slist_prepend(hradapter->devices, hr);
>>>
>>>         hr->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
>>> -                                               attio_disconnected_cb, hr);
>>> +                                       attio_disconnected_cb, true, hr);
>>>
>>>         return 0;
>>>  }
>>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>>> index e006add..9e7939b 100644
>>> --- a/profiles/input/hog.c
>>> +++ b/profiles/input/hog.c
>>> @@ -949,6 +949,7 @@ static struct hog_device *hog_register_device(struct btd_device *device,
>>>         hogdev->attioid = btd_device_add_attio_callback(device,
>>>                                                         attio_connected_cb,
>>>                                                         attio_disconnected_cb,
>>> +                                                       true,
>>>                                                         hogdev);
>>>
>>>         return hogdev;
>>> diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
>>> index 26a0ac9..37cf94a 100644
>>> --- a/profiles/proximity/immalert.c
>>> +++ b/profiles/proximity/immalert.c
>>> @@ -209,7 +209,7 @@ static uint8_t imm_alert_alert_lvl_write(struct attribute *a,
>>>                 condev->device = btd_device_ref(device);
>>>                 condev->adapter = ia;
>>>                 condev->callback_id = btd_device_add_attio_callback(device,
>>> -                                       NULL, imm_alert_disc_cb, condev);
>>> +                                       NULL, imm_alert_disc_cb, true, condev);
>>>                 ia->connected_devices = g_slist_append(ia->connected_devices,
>>>                                                                 condev);
>>>                 DBG("added connected dev %p", device);
>>> diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
>>> index 2f1ab13..edcfb7a 100644
>>> --- a/profiles/proximity/linkloss.c
>>> +++ b/profiles/proximity/linkloss.c
>>> @@ -254,7 +254,7 @@ static uint8_t link_loss_alert_lvl_write(struct attribute *a,
>>>                 condev->device = btd_device_ref(device);
>>>                 condev->adapter = la;
>>>                 condev->callback_id = btd_device_add_attio_callback(device,
>>> -                                       NULL, link_loss_disc_cb, condev);
>>> +                                       NULL, link_loss_disc_cb, true, condev);
>>>                 condev->local_disc_id = device_add_disconnect_watch(device,
>>>                                         link_loss_local_disc, condev, NULL);
>>>
>>> diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
>>> index a583eb7..da3fad8 100644
>>> --- a/profiles/proximity/monitor.c
>>> +++ b/profiles/proximity/monitor.c
>>> @@ -551,6 +551,7 @@ static void property_set_immediate_alert_level(
>>>                 monitor->attioid = btd_device_add_attio_callback(device,
>>>                                                         attio_connected_cb,
>>>                                                         attio_disconnected_cb,
>>> +                                                       true,
>>>                                                         monitor);
>>>         else if (monitor->attrib)
>>>                 write_immediate_alert(monitor);
>>> @@ -674,6 +675,7 @@ static void update_monitor(struct monitor *monitor)
>>>         monitor->attioid = btd_device_add_attio_callback(monitor->device,
>>>                                                         attio_connected_cb,
>>>                                                         attio_disconnected_cb,
>>> +                                                       true,
>>>                                                         monitor);
>>>  }
>>>
>>> diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
>>> index fbda8a8..7af671f 100644
>>> --- a/profiles/scanparam/scan.c
>>> +++ b/profiles/scanparam/scan.c
>>> @@ -219,6 +219,7 @@ static int scan_register(struct btd_service *service, struct gatt_primary *prim)
>>>         scan->attioid = btd_device_add_attio_callback(device,
>>>                                                         attio_connected_cb,
>>>                                                         attio_disconnected_cb,
>>> +                                                       true,
>>>                                                         scan);
>>>
>>>         btd_service_set_user_data(service, scan);
>>> diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
>>> index b0fc3e0..f64ad5d 100644
>>> --- a/profiles/thermometer/thermometer.c
>>> +++ b/profiles/thermometer/thermometer.c
>>> @@ -1182,7 +1182,7 @@ static int thermometer_register(struct btd_device *device,
>>>         }
>>>
>>>         t->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
>>> -                                               attio_disconnected_cb, t);
>>> +                                               attio_disconnected_cb, true, t);
>>>         return 0;
>>>  }
>>>
>>> diff --git a/src/attio.h b/src/attio.h
>>> index 16e2873..ff35f5a 100644
>>> --- a/src/attio.h
>>> +++ b/src/attio.h
>>> @@ -28,6 +28,7 @@ typedef void (*attio_disconnect_cb) (gpointer user_data);
>>>  guint btd_device_add_attio_callback(struct btd_device *device,
>>>                                                 attio_connect_cb cfunc,
>>>                                                 attio_disconnect_cb dcfunc,
>>> +                                               gboolean set_auto_connect,
>>>                                                 gpointer user_data);
>>>
>>>  gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id);
>>> diff --git a/src/device.c b/src/device.c
>>> index fd177f4..625e8fd 100644
>>> --- a/src/device.c
>>> +++ b/src/device.c
>>> @@ -5990,6 +5990,7 @@ static gboolean notify_attios(gpointer user_data)
>>>  guint btd_device_add_attio_callback(struct btd_device *device,
>>>                                                 attio_connect_cb cfunc,
>>>                                                 attio_disconnect_cb dcfunc,
>>> +                                               gboolean set_auto_connect,
>>>                                                 gpointer user_data)
>>>  {
>>>         struct attio_data *attio;
>>> @@ -6003,7 +6004,8 @@ guint btd_device_add_attio_callback(struct btd_device *device,
>>>         attio->dcfunc = dcfunc;
>>>         attio->user_data = user_data;
>>>
>>> -       device_set_auto_connect(device, TRUE);
>>> +       if (set_auto_connect)
>>> +               device_set_auto_connect(device, TRUE);
>>>
>>>         /* Check if there is no GAttrib associated to the device created by a
>>>          * incoming connection */
>>> --
>>> 2.5.0
>
> Actually the correct way to do it is to use the auto_connect flag and
> accept callback so btd_device_add_attio_callback is no longer called.

I re-wrote deviceinfo profile (made it just like gap is), please check
if that's what you wanted. If yes I will rewrite rest of profiles same
way to make sure they don't triger autoconnect unnecessary (except for
Heart Rate, you mentioned it should be done as external profile)

>
>
> --
> Luiz Augusto von Dentz
