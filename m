Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131015083556.GA3716@x220.p-661hnu-f1>
References: <1381777790-28891-1-git-send-email-claudio.takahasi@openbossa.org>
	<20131015083556.GA3716@x220.p-661hnu-f1>
Date: Tue, 15 Oct 2013 15:36:30 -0300
Message-ID: <CAKT1EBeJZ3UOOeAtzun0bt4S8aBXuS8+7g9tLZOL1fVRcZt=0g@mail.gmail.com>
Subject: Re: [RFC BlueZ v0] doc: Add GATT API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Tue, Oct 15, 2013 at 5:35 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Mon, Oct 14, 2013, Claudio Takahasi wrote:
>> +Service Manager hierarchy
>> +=========================
>> +
>> +ServiceManager allows external applications to register GATT based services.
>> +Services should follow the API for Service and Characteristic described above.
>> +
>> +For GATT local services, services and characteristics definitions are
>> +discovered automatically using D-Bus Object Manager.
>> +
>> +Service              org.bluez
>> +Interface    org.bluez.ServiceManager1 [Experimental]
>> +Object path  /org/bluez
>> +
>> +Methods              RegisterApplication(object application, dict options)
>> +
>> +                     Registers remote application services exported under
>> +                     the interface Service1. Characteristic objects must
>> +                     be hierarchical to their service and must use the
>> +                     interface Characteristic1. D-Bus Object Manager is
>> +                     used to fetch the exported objects.
>> +
>> +                     "application" object path together with the D-Bus system
>> +                     bus connection ID define the identification of the
>> +                     application registering a GATT based service.
>> +
>> +                     Possible errors: org.bluez.Error.InvalidArguments
>> +                                      org.bluez.Error.AlreadyExists
>> +
>> +             UnregisterApplication(object application)
>> +
>> +                     This unregisters the application that has been
>> +                     previously registered. The object path parameter
>> +                     must match the same value that has been used
>> +                     on registration.
>> +
>> +                     Possible errors: org.bluez.Error.DoesNotExist
>> +
>> +Service Agent hierarchy
>> +=======================
>> +
>> +Service              org.bluez
>
> I suppose this should not be "org.bluez" since it's the agent that's
> providing it.

yup. Copy & paste mistake.

>
>> +Interface    org.bluez.ServiceAgent1 [Experimental]
>> +Object path  freely definable
>
> If this is the object registered by ServiceManager1.RegisterApplication
> I think we need some renaming. Either this interface should be called
> org.bluez.ServiceApplication1 or the registration method shoud be
> renamed to RegisterAgent.
>
> Or is the idea that an "application" is a set of objects and interfaces
> (services, characteristics, etc.) and as a minimum there must be this
> ServiceAgent1 interface at the root object? In that case the naming
> might make sense.

In my opinion we need a more flexible approach, the agent could handle
local and remote services. Replace "Service" by "Application"  seems
to be more suitable.

The same application can run client and server roles. If necessary,
"option"  dictionary could be used to inform wanted UUIDs (GATT
client), and connection/scanning requiments.
For server, "option" dictionary could have ID to allow handle
re-allocation. The plan is to use Object Manager, so services object
paths can be omitted and the agent path is freely definable.

Based on what we discussed my suggestion is:

Interfaces:
s/ServiceManager1/ApplicationManager1
s/ServiceAgent1/ApplicationAgent1

Methods:
s/RegisterApplication/RegisterAgent
s/UnregisterApplication/UnregisterAgent

Regards,
Claudio
