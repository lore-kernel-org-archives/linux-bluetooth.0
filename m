Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25QZ=MGsY0UmiNL8pTA+3JS0E4dko485ZnTNmR_uGM93gg@mail.gmail.com>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
	<1418782038-10999-6-git-send-email-armansito@chromium.org>
	<CABBYNZJB4NZuKwQ-r64Te03QwSHi50quQ=Ka4UBhFLcORuufgw@mail.gmail.com>
	<CAHrH25QZ=MGsY0UmiNL8pTA+3JS0E4dko485ZnTNmR_uGM93gg@mail.gmail.com>
Date: Wed, 17 Dec 2014 18:00:09 -0200
Message-ID: <CABBYNZK+7EsbGe49hYVOcrnrkcce-Ok06RG3XzSvvRpremr=hw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 05/10] core: device: Don't disconnect if attios
 not set
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Dec 17, 2014 at 3:42 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>> On Wed, Dec 17, 2014 at 5:08 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Arman,
>>
>> On Wed, Dec 17, 2014 at 4:07 AM, Arman Uguray <armansito@chromium.org> wrote:
>>> Currently there is no way for external applications to claim ownership
>>> on a GATT connection and as profiles move away from attio.h it doesn't
>>> make much sense to immediately disconnect if no attio callbacks have
>>> been set after probing the profiles (as this will always immediately
>>> disconnect the device). This patch removes this logic from btd_device.
>>
>> I was thinking that if no driver accepts the connection we should
>> disconnect but it doesn't look like you had done anything in this
>> direction, for external client using the D-Bus API maybe we need some
>> method for registering client making only the services with clients
>> visible.
>>
>
> I discussed how to make this possible for external applications on the
> mailing list with Marcel and Johan by extending the Profile API
> concept to GATT (org.bluez.GattProfile1 or sorts) but this will only
> happen down the line.
>
> For profiles, maybe btd_device can choose to disconnect if no profile
> returned success during probing? Then again, we end up having a
> mundane profile like GAP behave like the rest of the profiles this
> way.

Im not really following here, probing stage is to detect a driver can
be used and on success we create a service instance so it happen only
once, accept in the other hand would be triggered every time the
device connects. Anyway my comments was regarding the fact that we
need to detect if there are multiple clients for the same profile we
would need to do some conflict resolution, since we cannot track D-Bus
client right now I think it is better to not expose services which
have built-in driver such as HoG, etc, later once we introduce
org.bluez.GattProfile1 or similar we may favor external apps if that
makes more sense.

> For now, I figured we can remove this logic and keep the device
> connected (since the user called Connect, it seems reasonable to make
> the assumption that they want the device to be connected). In the
> future, we'll want to revisit this and perhaps combine btd_profile and
> GattProfile1 state to determine auto-connect, keeping the connection
> alive, and so on.

Well in case of classic if the user call Connect and there is no
driver matching/probed we don't attempt to connect at all, except to
update the services, but with LE it is much more common that we got
connected by the remote via advertising and passive scanning, thus it
would look like as an incoming connection, and then we could request
each probed driver to accept the connection.

> Though initially I still want to have the basic doc/gatt-api.txt
> implemented before we go down the GattProfile path. I'm open to
> suggestions in general though.

I guess it is fine to leave it for later but we should keep in mind
what we gonna do about conflicting clients, I figure this patch might
actually be necessary since we cannot track D-Bus clients we may keep
the connection even if no driver accepts it.

>
>>> ---
>>>  src/device.c | 8 --------
>>>  1 file changed, 8 deletions(-)
>>>
>>> diff --git a/src/device.c b/src/device.c
>>> index e8bdc18..64591d0 100644
>>> --- a/src/device.c
>>> +++ b/src/device.c
>>> @@ -3642,9 +3642,6 @@ static void register_gatt_services(struct browse_req *req)
>>>
>>>         device_probe_profiles(device, req->profiles_added);
>>>
>>> -       if (device->attios == NULL && device->attios_offline == NULL)
>>> -               attio_cleanup(device);
>>> -
>>>         device_svc_resolved(device, device->bdaddr_type, 0);
>>>
>>>         store_services(device);
>>> @@ -5069,11 +5066,6 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
>>>
>>>         g_free(attio);
>>>
>>> -       if (device->attios != NULL || device->attios_offline != NULL)
>>> -               return TRUE;
>>> -
>>> -       attio_cleanup(device);
>>> -
>>>         return TRUE;
>>>  }
>>>
>>> --
>>> 2.2.0.rc0.207.ga3a616c
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> Arman



-- 
Luiz Augusto von Dentz
