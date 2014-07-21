Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D76A5409-CE06-40FE-8EDC-4EED54659773@holtmann.org>
References: <1405750008-7652-1-git-send-email-armansito@chromium.org>
	<1405750008-7652-2-git-send-email-armansito@chromium.org>
	<BD791E25-F8C4-4A29-A76F-7C6089DF3B29@holtmann.org>
	<D76A5409-CE06-40FE-8EDC-4EED54659773@holtmann.org>
Date: Mon, 21 Jul 2014 14:11:28 -0700
Message-ID: <CAHrH25RzNTfxRbC5i-Hf8iHN61v2i6KwaRT5n44dDX7Nr4a4dw@mail.gmail.com>
Subject: Re: [RFC 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Chaojie,

See my responses inline.

>          We are working on GATT D-Bus API for Tizen LE GATT Client too. F=
or your proposal, I totally agree your part of proposal such as add Primary=
 property into org.bluez.GattService1, because all the hierarchy services c=
annot differentiate between primary and included service. And device proper=
ty is also very useful because It can help user to trace the services belon=
g to which device.
>         However , you add Write/Read/Notify method into GATT-API , I thin=
k it is good proposal but not essential. Because it is about implementation=
 method problem, not the GATT DBus API problem.

I have to disagree here. I think making the DBus.Properties interface
work for this particular case doesn't make the API particularly
simpler, in fact I think it adds unnecessary complexity and ambiguity
to the semantics involved. It's not clear, for instance, if Get should
always return the cached value or if it should issue a Read request to
the remote end. You suggest making an initial read request and storing
that value and updating it on notifications. What if the
characteristic doesn't support notifications but it's value can
change? What if the client is implementing a profile that warrants a
read request to the remote end to get the freshest value on demand?

For example, take the "Device Name" characteristic of the Generic
Access service, which has to support reads, optionally supports
writes, and doesn't support notifications/indications. The client can
write its value but won't be notified of the change. Now, the daemon
could remember that the value was written and update the property
right upon success, but I think this is unnecessary magic.

Same with control point characteristics, that support writes but no
notifications or reads. The external application can call "Set" to
write to the characteristic but does it make sense to send a
PropertiesChanged signal for a value that we cannot read? Should the
daemon cache the write value and return that on Get? Or should it
return an empty value?

The same goes for the PropertyChanged signal, which we will end up
emitting after a successful read, notifications/indications, and
portentially writes. I think it's cleaner to have a distinct signal
that gets only sent on notifications.

We end up with a read-write property that doesn't return a consistent
value on Get and Set calls. We end up making the property interface
work for semantics that it wasn't exactly built for.

I want to have an API where the external application has a clear way
of saying "send a remote read/write request". I'm not opposed to
having a "Value" property but I'd much rather it represent a read-only
property that only returns the most recently cached value.

> >> +            object Device [read-only, optional]
> >> +
> >> +                    Object path of the Bluetooth device the service
> >> +                    belongs to. Only present on services from remote
> >> +                    devices.
> >
> > I am not sure this is needed. What do you want to use it for?

This is very useful to determine which device a service belongs to
when an InterfacesAdded signal is sent for a service. We have an
"Adapter" property for org.bluez.Device1, so why not a "Device"
property for org.bluez.GattService1?

>
> >> +
> >> +            array{object} Characteristics [read-only]
> >> +
> >> +                    Array of object paths representing the characteri=
stics
> >> +                    of this service. This property is set only when t=
he
> >> +                    characteristic discovery has been completed, howe=
ver the
> >> +                    characteristic objects will become available via
> >> +                    ObjectManager as soon as they get discovered.
> >> +
> >
> > I really wonder if this is a good idea. Why not delay announcing any se=
rvice or characteristic via D-Bus as long as the service discovery is still=
 running. I think it makes more sense to allow doing it one way and one way=
 only.
>

I guess I should have said "This property is set only when the
characteristic discovery has been completed AND an InterfacesAdded
signal for all characteristics and descriptors have been sent to
clients". In short, even if we wait until discovery is complete, we
will create service, characteristic, and descriptor objects in some
order but I want to have a way for a client to know that all objects
associated with a service are available via D-Bus. I'm open to
suggestions :)

> >
> > I have objection to adding these two method. However the error codes sh=
ould be a bit more descriptive on the level AuthenticationRequired or Missi=
ngAuthentication. Then again, I think this detail might be better hidden in=
 the daemon.
>
> this should read "no objection". Seems I am swallowing words again ;)
>
> For example if you are not encrypted and the characteristic requires an e=
ncrypted link, we should upgrade the security level and try again. If no LT=
K is available, then org.bluez.Error.NoEncryptionKey or similar should be r=
eturned. I think it is important that we handle all these details in the da=
emon to make it transparent for the end user.
>

I think these should be handled by the daemon too. Then again we
should report errors to the clients when we can. So yes, I agree.


>> +
>> +             void StartNotify()
>> +
>> +                     Starts a notification session from this characteri=
stic
>> +                     if it supports value notifications or indications.
>> +
>> +                     Possible Errors: org.bluez.Error.Failed
>> +                                      org.bluez.Error.InProgress
>> +                                      org.bluez.Error.NotSupported
>> +
>> +             void StopNotify()
>> +
>> +                     This method will cancel any previous StartNotify
>> +                     transaction. Note that notifications from a
>> +                     characteristic are shared between sessions thus
>> +                     calling StopNotify will release a single session.
>> +
>> +                     Possible Errors: org.bluez.Error.Failed
>
> Seems sensible as well to me. However I am little bit debating the naming=
 of the method a bit. I would have to read the spec in detail again which i=
s the best name. EnableNotification comes to mind as well.
>

Yeah, I came up with these names pretty quickly while I was
time-pressed for the Chrome 37 release. I don't have a strong opinion
here; maybe EnableNotifications & DisableNotifications? Or maybe
something that contains the word "session" since these methods behave
like StartDiscovery and StopDiscovery on org.bluez.Adapter1.


>> +
>> +Signals              void ValueUpdated(array{bytes} value)
>> +
>> +                     This signal is launched when a characteristic hand=
le
>> +                     value notification or indication is received.
>
> Why is just sending a PropertyChanged not good enough here? I would consi=
der the property itself the cached value. Extra signals are costing extra o=
verhead.
>

I added this signal because I got rid of the property. Even if we keep
the property, I'm still not convinced that using the PropertyChanged
signal to mean both "cached value updated after read" and
"notification/indication received" is the right idea. I sort of prefer
having a signal that only gets called when there's a notification,
though if we keep this property then I guess we're going to have to
work with that.


>> +             boolean Notifying [read-only]
>>
>> -                     Value read from the remote Bluetooth device or fro=
m
>> -                     the external application implementing GATT service=
s.
>> +                     True, if notifications or indications on this
>> +                     characteristic are currently enabled.
>
> As said above, I would leave the Value here as well. Maybe make it option=
al in case it has not yet been read or does not allow reading at all. It wo=
uld represent the cached value.
>

I'm fine with leaving it. I'm ok with changing it to a read-only &
optional property that represents the cached value.

> I am not fully at ease with the name Notifying yet. Need to think about i=
t a bit or some good convincing.
>

"NotificationsEnabled" maybe? That would make sense if change the
methods to EnableNotifications & DisableNotifications. I guess we all
suck at coming up with names :P


>> +             array{object} Descriptors [read-only]
>> +
>> +                     Array of object paths representing the descriptors
>> +                     of this service. This property is set only when th=
e
>> +                     descriptor discovery has been completed, however t=
he
>> +                     descriptor objects will become available via
>> +                     ObjectManager as soon as they get discovered.
>> +
>
> Why is this needed?
>

Same reason as the "Characteristics" property on GattService1 above.
It's not essential but we should have it for consistency if we keep
"Characteristics".

>> -
>> -             string Permissions [read-only]: To be defined
>> -
>> -                     Defines read/write authentication and authorizatio=
n
>> -                     requirements.
>
> Why is this removed now?

To be honest, I don't think this property is that necessary. GATT/ATT
don't really define a way to obtain these requirements in the
characteristic declaration and leave them up to the upper layer
profile and the only way to find out about these requirements is to
issue a read/write request and see if there's an error. If we properly
report errors to the client on calls to ReadValue and WriteValue, then
this property wouldn't really be needed. Let me know if I'm missing
something though.

Cheers all,
Arman
