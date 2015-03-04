Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CBACCFA0AEB13A41977475BCF3E896FC6674695156@SC-VEXCH2.marvell.com>
References: <CBACCFA0AEB13A41977475BCF3E896FC6674695156@SC-VEXCH2.marvell.com>
Date: Wed, 4 Mar 2015 11:36:21 +0200
Message-ID: <CABBYNZ+MiPy-EnGve37GNiivc2874FvP=fOr2+OJQ9HvH-hyFg@mail.gmail.com>
Subject: Re: Query: [BLE][PROFILES]Need Suggestion on Implementing/Using
 Immediate_Alert Service(Single Instance Service) used by multiple Profiles
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nitish Wokkadada <nitishw@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nitish,

On Wed, Mar 4, 2015 at 8:59 AM, Nitish Wokkadada <nitishw@marvell.com> wrote:
> Hi All,
> Can anyone please comment?
>
> Regards,
> Nitish Wokkadada
>
> -----Original Message-----
> From: Nitish Wokkadada
> Sent: 27 February 2015 18:16
> To: 'linux-bluetooth@vger.kernel.org'
> Subject: Query: [BLE][PROFILES]Need Suggestion on Implementing/Using Immediate_Alert Service(Single Instance Service) used by multiple Profiles
>
> Hello,
>
> Currently in Bluez5.28, I see the immalert.c & immalert.h files under folder profiles/proximity, wherein just Proximity profile uses/adds the Immediate_Alert Service & hence the immalert.c contains the handling with respect to Proximity Profile.
> However Immediate_Alert Service is a common service, and also can be used by FindMe Profile.
>
> So, if we are implementing the FindMe Profile(FindMeTarget Role/GATT Server Role), then we cannot have another file in profiles/findme/ that adds the immediate_alert service(Considering Device supports both Proximity and FindMe profiles) due to immediate_alert service shall have a Single Instance per Device.

I suppose the alert should be a included service to FindME and
Proximity, in that case it should not be a problem since the you can
register the alert service in the database  and then include it in the
other services. Btw, the API for doing this is changing, the plugins
will probably have to interface with btd_database to do that, also you
might need to do lookup in the database to discover the alert service
since it might be implemented in another plugin, the third option is
to implement this externally with use of D-Bus GATT APIs, but in that
case it is not really possible to include services not bellowing to
the same process/bus id.

> Also in Client Role case, we need to have common code for Single Instance Services(similar to Immediate_alert service) that does the discovery, read, write operations by providing apis that can be used by Different Profiles(ex: Proximity and FindMe profiles that uses Immediate_alert service), similar to Device Information service.

Yep, a simple library in the form we have bt_hog, bt_bas, etc, with
proper unit test is probably a good idea if we want this to be a
internal plugin. We haven't yet define what service should be
implemented as plugin though, usually if we do have as a plugin it
might need an API for upper layers but we do have that already with
GattService1, GattCharacteristic and GattDescriptor, so I believe only
services that require a more tight integration into the system, e.g.
HoG, needs to be a plugin.

> Kindly correct me if my understanding is incorrect and suggest me on how to go about on implementing FindMe Profile(Whether to make a common ImmediateAlert file similar to DeviceInfo that can be used by required profiles)
>
> Regards,
> Nitish W
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
