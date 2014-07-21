Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FE2B88CC-2B26-4870-82A5-F0D84DC40702@holtmann.org>
References: <1405750008-7652-1-git-send-email-armansito@chromium.org>
	<1405750008-7652-2-git-send-email-armansito@chromium.org>
	<BD791E25-F8C4-4A29-A76F-7C6089DF3B29@holtmann.org>
	<D76A5409-CE06-40FE-8EDC-4EED54659773@holtmann.org>
	<CAHrH25RzNTfxRbC5i-Hf8iHN61v2i6KwaRT5n44dDX7Nr4a4dw@mail.gmail.com>
	<FE2B88CC-2B26-4870-82A5-F0D84DC40702@holtmann.org>
Date: Mon, 21 Jul 2014 15:07:23 -0700
Message-ID: <CAHrH25T3CR96D7mv5n_VGrCVQJ6M=9yfUnVxmL=7eyRbb-79YQ@mail.gmail.com>
Subject: Re: [RFC 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>>>> I am not sure this is needed. What do you want to use it for?
>>
>> This is very useful to determine which device a service belongs to
>> when an InterfacesAdded signal is sent for a service. We have an
>> "Adapter" property for org.bluez.Device1, so why not a "Device"
>> property for org.bluez.GattService1?
>
> the back reference should only be added if someone really uses them.
>

Well, we (the Chrome OS team) do, so that counts for something right
(:P)? We used it in our implementation and Chaojie also seems to be
interested in having this property so I think we should have it.

> So this is problem that InterfacesAdded is only reporting for a single ob=
ject path. Maybe this will actually work out as you described it.
>

Exactly.

> Okay, then make the error really simple. Maybe even on a high-level like =
"not paired". Since the only action from the user here is really to start p=
airing with the device.
>

Sounds good to me.

>> Yeah, I came up with these names pretty quickly while I was
>> time-pressed for the Chrome 37 release. I don't have a strong opinion
>> here; maybe EnableNotifications & DisableNotifications? Or maybe
>> something that contains the word "session" since these methods behave
>> like StartDiscovery and StopDiscovery on org.bluez.Adapter1.
>
> I leave it to others to comment here as well. It is an easy change in the=
 end.
>

I'll leave it as it is for now, unless people object.

>> I added this signal because I got rid of the property. Even if we keep
>> the property, I'm still not convinced that using the PropertyChanged
>> signal to mean both "cached value updated after read" and
>> "notification/indication received" is the right idea. I sort of prefer
>> having a signal that only gets called when there's a notification,
>> though if we keep this property then I guess we're going to have to
>> work with that.
>
> My thinking is that it really does not matter how the value got updated. =
Either by a manual read or by a notification or even by a write. The import=
ance is to get the new value notified to all other applications that are no=
t involved. Doing it only one way seems to make sense. And the applications=
 all already have to listen to the PropertiesChanged signal anyway. Less si=
gnals to listen on the the better.
>

Ok, I guess this isn't so bad.

>> To be honest, I don't think this property is that necessary. GATT/ATT
>> don't really define a way to obtain these requirements in the
>> characteristic declaration and leave them up to the upper layer
>> profile and the only way to find out about these requirements is to
>> issue a read/write request and see if there's an error. If we properly
>> report errors to the client on calls to ReadValue and WriteValue, then
>> this property wouldn't really be needed. Let me know if I'm missing
>> something though.
>
> We might actually update it from the property does not exist to we have f=
igured this out since someone read the property and thus we are reporting i=
t now. I might be wrong, but I think there was some part in GATT that provi=
ded these details.

Yeah, I guess this depends on how badly an application might need this
property. We can just automatically update it after a read/write
request. If we do want to keep it, then this property needs to be
added to org.bluez.GattCharacteristic1 as well. I say we leave this
property out for now and add it later if people feel that it's
valuable to have it.

-Arman
