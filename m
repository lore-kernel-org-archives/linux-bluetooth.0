Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<20140722085507.GA29664@t440s.lan>
	<CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
Date: Wed, 23 Jul 2014 07:24:16 +0200
Message-ID: <CABD6X-JthdBhBqfdstMogPsbaHh=Z-KpTJbYut2iDjW-7gsoSw@mail.gmail.com>
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, chao.jie.gu@intel.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On 22 July 2014 22:40, Arman Uguray <armansito@chromium.org> wrote:
> Hi Chaojie, Johan,
>
> Please see my responses inline:
>
>
>>> +             array{object} Characteristics [read-only]
>>> +
>>> +                     Array of object paths representing the characteristics
>>> +                     of this service. This property is set only when the
>>> +                     characteristic discovery has been completed, however the
>>> +                     characteristic objects will become available via
>>> +                     ObjectManager as soon as they get discovered.
>> For this new property, I think there is not essential as other property,
>> because when characteristic discovery happen , all the object path will setup
>> on DBus Hierarchy. And user can get all the characteristic by ObjectManger.
>
> The problem is that ObjectManager has no clear way to tell a client
> that "this subset of object paths have been published" and when they
> are all available via GetManagedObjects. The most a client can do is
> observe the InterfacesAdded signal and that signal is sent on a per
> object path basis. For most external applications, it might be enough
> but I would like application APIs to have to ability to say "all
> objects published, service is ready to use".
>
>
>> Through this, User can use their own structure to get this array of object.
>> That is also why we need object property such as Device, Service and so on.
>>
>> And another reason , it have to wait for characteristic discovery completed, it
>> also can say that it have to wait for characteristic setup DBus Hirarchy is
>> ready. There exists asynchronous issues, if user get this property operation
>> before all the characteristic DBus setup is ready, it will make a mistake.
>>
>
> This is exactly the problem. A simple update of this property lets the
> user know that the hierarchy has been set up. For all I care, this
> could even be a simple boolean property such as "DiscoveryComplete"
> but I kind of like the list of characteristics even though
> GetManagedObjects/InterfacesAdded, as you say, can achieve the same
> result. We have the similar "Includes" property already, so it's not
> entirely inconsistent from an API standpoint.
>
>
>>> +             void StartNotify()
>>> +
>>> +                     Starts a notification session from this characteristic
>>> +                     if it supports value notifications or indications.
>>> +
>>> +                     Possible Errors: org.bluez.Error.Failed
>>> +                                      org.bluez.Error.InProgress
>>> +                                      org.bluez.Error.NotSupported
>> About this method , I think other LE profile offer similar interface to user,
>> such as in heartrate profile. It will give registerwatcher method, in which
>> it will enable notify for heartrate. This will help to trace descriptor
>> including notification bit changed and send Propertychanged signal.
>
> Are you referring to the HeartRateManager1 hierarchy? Since we're now
> building a generic API, we need a proper way of reference-counted,
> per-connection way to access the Client Characteristic Configuration
> descriptor. In this proposal, calling WriteValue on the CCC descriptor
> will always fail with WriteNotPermitted.
>
> Do you have any suggestions for the method name or are you OK with
> StartNotify for now? We can always change it later.
>
>
>> "Insufficient Authorization" seems different from the other two in that
>> it's something that can't be attempted to be "fixed" from the client
>> side. It effectively means that our request was rejected by the remote
>> user, doesn't it?
>
> Good point, there is really not much bluetoothd or the external app
> can do in this case so we should probably propagate the authentication
> error separately from the NotPaired cases. Or do you think that it
> would be beneficial to have separate error definitions for Encryption
> and Authentication as well? Having Error.NotPaired and
> Error.Authentication seems reasonable to me.

Error.Authorization seems to be higher layer specific:

"The authorization requirements for access
to a given attribute are not defined in this specification. Each
device implemen-
tation will determine how authorization occurs. Authorization procedures are
defined in GAP, and may be further refined in a higher layer specification."

so it seems reasonable to send this error to application.
We could also add Invalid Value Length error.

>
> Cheers,
> Arman
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Marcin
