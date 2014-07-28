Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com>
Date: Mon, 28 Jul 2014 15:34:25 -0700
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <409335B4-82B3-40D2-970A-D39416F02591@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org> <1405986034-29122-2-git-send-email-armansito@chromium.org> <3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com> <CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>        In this weekend, I think about this API again , and there is one question for you:
>>        In your new proposal , bluez offer two ways for application to read characteristic value, one is to get property array of value, the other is to use ReadValue method.
>>        For applications, in which condition they use property array of value and in which condition they use ReadValue ? will it cause a confusion for user when offer two ways for user at the same time?
>> 
> 
> In this new proposal, the "Value" property simply stores the most
> recently cached value after the most recent read procedure or
> notification/indication. So, Get will simply return this cached value.
> If an application wants to issue a read request to the remote
> peripheral, then they will call ReadValue.

I think one detail that has to be clear os that most likely nobody is calling Get directly. I will be available, but mostly all applications will get the value from calling GetManagedObjects.

So lets say we talk about standard service like Device Information or Battery Status etc., every application gets these information in one go. This is comparing to x number of application calling ReadValue for each value individually. For values that do not change at all or change only every x days this is something that makes sense and I really want. It means that applications do not have to do anything extra for these values. They are just available and they are most likely recent or recent enough.

>> You said "What if the characteristic doesn't support notifications but it's value can change?" It means cached array of value cannot be trusted in the condition you said exist if this value changes happen not result from writing to the remote end device.
> 
> This is why the property is optional and wouldn't exist if the value
> cannot be read or notified.

Your proposal also had the Notifying property in there. Which means an application can know if it is cached value where the up-to-date status is either valid or it is unknown.

And of course if the value can not be read, then as you said, the property just does not exist at all.

>> So in my understanding, there is no worth to read characteristic value by property array of value, the property's role is just to emit propertychanged signal when write/read/notification operation changes its value. If so, we just define a signal such as ValueUpdated to tell user value has been changed is ok.
>> 
> 
> I only added this property back after initial feedback, which seemed
> to suggest that having this cached property might have some value for
> certain profile implementations. In short, if an application is always
> interested in the latest, most accurate characteristic value, then
> yeah, they would use ReadValue and not bother with the property at
> all, as you said. I personally find that caching the value after a
> write request is a bad idea, since bluetoothd can only guess what the
> new value of the remote characteristic is based on the write value
> that it just sent. My proposal is to only set this property and emit a
> PropertiesChanged after a successful read request and on
> notifications/indications. If we use PropertiesChanged this way, then
> there wouldn't be a need for ValueUpdated.

I think this depends a little bit. Most values will be return the exact same value that you write into it. That is what they are suppose to do anyway. The only exception here are control endpoints. So I would agree that for control endpoints we do not expose the Value property at all.

> I agree that this might be confusing, especially for applications that
> didn't issue a read request. If one application performs a read, all
> applications will then receive a PropertiesChanged signal, yet it is
> not clear to them if this was due to a notification or because
> somebody performed a read.

Does this really matter for an application that is not actively interested in interacting with that remote service. Why would it care what triggered the update.

Lets say you just want to monitor your temperature sensor and its battery status. So even if you are a single application and only your application is using that sensor. You just enable notifications for the values you care about and then sit back. Meaning a GetManagedObjects gets you started and PropertiesChanged notification will keep you updated. That sounds like a really nice and simple application interface to me.

> This is why, in my initial proposal, I removed the "Value" property
> entirely, since any caching needed by an application can be performed
> directly by them as necessary, since most apps will be interested in
> getting the value directly from the remote peripheral via a call to
> ReadValue anyway. Then we would just have a ValueUpdated (or
> ValueNotified) signal which would only be emitted on
> notifications/indications. Marcel, any thoughts on this?

I do not like having extra signals that you need to monitor and that do not fit into the standard model of the Object Manager. There is really no point in that we keep playing ping-pong with the remote device to all values some application is interested in. Some stuff should just come with a single call or should be notified once the device connects.

This is especially important when you think about the latency to connect to a sensor and get all information back to the application. The user interface should be able to show all information right away and then just update the ones that changed a few seconds later. However if another application or some system service has already updated these, why would the application need to request them again. It does not make sense to me. Especially once we have sensors that can provide valuable information to more than just one application.

>> So there are two API design can be used:
>> 1. array of value property  Get/Set  (This design just happen only one condition that client write the value to remote, not in which remote change its value itself spontaneously and not send notification.)
>> 2. ReadValue /WriteValue method and signal ValueUpdated
>> 
>> However, in the conclusion, array of value property and ReadValue/WriteValue can not be coexist, otherwise that design will result in ambiguity and not make sense.
>> 
> 
> Aside from the ambiguity that I mentioned above, these CAN nicely
> coexist. Again, the latest proposal is to add a read-only "Value"
> property which represents the cached value and have
> ReadValue/WriteValue for the remote procedures on the peripheral. Set
> is not allowed in this scenario and no read semantics are bound to
> Get/GetAll.

I think this is how we should start right now. If we figure out later that this makes no sense, then we correct it. However only after we get some testing applications talking to some sensors or devices, we will see how this works out.

Please keep in mind that I want to make applications simpler. The less they have to do to get things right, the better. And D-Bus is not a low-level API for me. It is high-level API that an application can use directly without having to pull in a binding or framework to make us of it.

Regards

Marcel

