Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CBACCFA0AEB13A41977475BCF3E896FC6674695BEC@SC-VEXCH2.marvell.com>
References: <CBACCFA0AEB13A41977475BCF3E896FC6674695156@SC-VEXCH2.marvell.com>
	<CABBYNZ+MiPy-EnGve37GNiivc2874FvP=fOr2+OJQ9HvH-hyFg@mail.gmail.com>
	<CBACCFA0AEB13A41977475BCF3E896FC6674695BEC@SC-VEXCH2.marvell.com>
Date: Mon, 9 Mar 2015 16:08:13 +0200
Message-ID: <CABBYNZ+ac63VU=2M+Z_947hi15rD5qobP3WkwJrp1GArn6Tr8Q@mail.gmail.com>
Subject: Re: Query: [BLE][PROFILES]Need Suggestion on Implementing/Using
 Immediate_Alert Service(Single Instance Service) used by multiple Profiles
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nitish Wokkadada <nitishw@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nitish,

On Mon, Mar 9, 2015 at 3:04 PM, Nitish Wokkadada <nitishw@marvell.com> wrote:
> Thanks Luiz.
> Please find my comments inline.
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: 04 March 2015 15:06
>> To: Nitish Wokkadada
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: Query: [BLE][PROFILES]Need Suggestion on
>> Implementing/Using Immediate_Alert Service(Single Instance Service)
>> used by multiple Profiles
>>
>> Hi Nitish,
>>
>> On Wed, Mar 4, 2015 at 8:59 AM, Nitish Wokkadada <nitishw@marvell.com>
>> wrote:
>> > Hi All,
>> > Can anyone please comment?
>> >
>> > Regards,
>> > Nitish Wokkadada
>> >
>> > -----Original Message-----
>> > From: Nitish Wokkadada
>> > Sent: 27 February 2015 18:16
>> > To: 'linux-bluetooth@vger.kernel.org'
>> > Subject: Query: [BLE][PROFILES]Need Suggestion on Implementing/Using
>> > Immediate_Alert Service(Single Instance Service) used by multiple
>> > Profiles
>> >
>> > Hello,
>> >
>> > Currently in Bluez5.28, I see the immalert.c & immalert.h files under
>> folder profiles/proximity, wherein just Proximity profile uses/adds the
>> Immediate_Alert Service & hence the immalert.c contains the handling
>> with respect to Proximity Profile.
>> > However Immediate_Alert Service is a common service, and also can be
>> used by FindMe Profile.
>> >
>> > So, if we are implementing the FindMe Profile(FindMeTarget Role/GATT
>> Server Role), then we cannot have another file in profiles/findme/ that
>> adds the immediate_alert service(Considering Device supports both
>> Proximity and FindMe profiles) due to immediate_alert service shall
>> have a Single Instance per Device.
>>
>> I suppose the alert should be a included service to FindME and
>> Proximity, in that case it should not be a problem since the you can
>> register the alert service in the database  and then include it in the
>> other services. Btw, the API for doing this is changing, the plugins
>> will probably have to interface with btd_database to do that, also you
>> might need to do lookup in the database to discover the alert service
>> since it might be implemented in another plugin, the third option is to
>> implement this externally with use of D-Bus GATT APIs, but in that case
>> it is not really possible to include services not bellowing to the same
>> process/bus id.
> [Nitish] 1. At-least for FindMe profile, Immediate_Alert service cannot be a included service because it is the only service in FindMe Profile and there is no other service which can include Immediate_Alert service.

Well I was talking in terms of services, so if FindMe profile don't
actually have a service on its own then we cannot include, but that is
a pretty weird so how can you tell the different between FindMe and
Immediate Alert?

> 2. So, I think we can implement Immediate_Alert service as a Plugin and whose api's can be used by Proximity & FindMe profiles. In this case, we might also have to alter the currently implemented Proximity profile.

Im fine with any changes to make internal changes to make us able to
include services, but check the comments bellow.

> Kindly suggest on point number 2.
>
>>
>> > Also in Client Role case, we need to have common code for Single
>> Instance Services(similar to Immediate_alert service) that does the
>> discovery, read, write operations by providing apis that can be used by
>> Different Profiles(ex: Proximity and FindMe profiles that uses
>> Immediate_alert service), similar to Device Information service.
>>
>> Yep, a simple library in the form we have bt_hog, bt_bas, etc, with
>> proper unit test is probably a good idea if we want this to be a
>> internal plugin. We haven't yet define what service should be
>> implemented as plugin though, usually if we do have as a plugin it
>> might need an API for upper layers but we do have that already with
>> GattService1, GattCharacteristic and GattDescriptor, so I believe only
>> services that require a more tight integration into the system, e.g.
>> HoG, needs to be a plugin.
> [Nitish] 1. Currently which one do you suggest for implementing FindMe Profile(FindMe Locator Role/GATT Client Role) - Internal Plugin or External D-Bus API?
> 2. If Immediate_Alert(peripheral role) is also implemented as a Plugin(as suggested in Point No.2 above), then both client and peripheral role can be implemented in a single file, Else can we implement Immediate_Alert(client role) as a standalone plugin separately or as suggested in above point1?

I guess this is something you will need to figure out, if it doesn't
need any root privileges I had probably suggest it to be implemented
in a external component but perhaps you have other constraints,
actually if you are planning in doing sound alert or displaying
something that is probably easier to be done in a user process.

>
>>
>> > Kindly correct me if my understanding is incorrect and suggest me on
>> > how to go about on implementing FindMe Profile(Whether to make a
>> > common ImmediateAlert file similar to DeviceInfo that can be used by
>> > required profiles)
>> >
>> > Regards,
>> > Nitish W
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-bluetooth" in the body of a message to
>> majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> Regards,
> Nitish Wokkadada



-- 
Luiz Augusto von Dentz
