Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCmKocpuqhZXA_-=sxR6SPmfB1UdcRYH93evneM_nCqU7Q@mail.gmail.com>
References: <1381777790-28891-1-git-send-email-claudio.takahasi@openbossa.org>
	<1381862383-9866-1-git-send-email-claudio.takahasi@openbossa.org>
	<CAHZ1yCmTdG_ynyfXj0CYhRsPWdM5MBeySvG1Wd5Xb+nEvCVH0A@mail.gmail.com>
	<CAKT1EBc2d3VkiUF705aNY79YDmL5ZRX75fg=a4a_ZfTPt4zoDA@mail.gmail.com>
	<CAHZ1yCmKocpuqhZXA_-=sxR6SPmfB1UdcRYH93evneM_nCqU7Q@mail.gmail.com>
Date: Wed, 27 Nov 2013 17:45:05 -0200
Message-ID: <CAKT1EBdB7cvhmnqf2FV-F=RWwdnvhpUuc3AENHaYCao_dNyH_w@mail.gmail.com>
Subject: Re: [RFC BlueZ v1] doc: Add GATT API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott:

On Fri, Nov 15, 2013 at 4:47 PM, Scott James Remnant <keybuk@google.com> wrote:
> On Tue, Nov 12, 2013 at 10:49 AM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>
>> On Mon, Nov 11, 2013 at 3:56 PM, Scott James Remnant <keybuk@google.com> wrote:
>>> How will service changed be handled? How will BlueZ track the set of
>>> applications, and the set of services etc. defined by those
>>> applications in a manner that keeps handles consistent? How will it
>>> handle generating the Services Changed notification in the cases where
>>> the set of applications and/or services change, or the handles change?
>>
>> We implemented a hash of declarations. Using the "Id"  provided in the
>> options dictionary (see RegisterAgent) we are able to identity if the
>> external service changed its attributes.
>> However, I don' t think we will upstream this approach soon, Marcel
>> wants a simpler approach: always send ServiceChanged.
>>
>
> While this is probably "spec sufficient", and probably sufficient for
> passing qualification, I'm not sure that this is necessarily the best
> approach since this means that BlueZ when acting as a GATT Server
> wouldn't be behaving quite the same as, say, a commodity BTLE device.
>
>>>> +Characteristic hierarchy
>>>> +========================
>>>   :
>>>> +Service                org.bluez
>>>> +Interface      org.bluez.Characteristic1 [Experimental]
>>>> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
>>>
>>> This would also need a "Permissions" property akin to the one you have
>>> for Descriptors - characteristics can be "not accessible", read-only,
>>> write-only, read/write - and can also require authorization,
>>> authentication, encryption and minimum encryption key sizes - as with
>>> descriptors.
>>
>> It is implemented already, there is an optional "Flags" property :
>> "array{string} Flags [read-only, optional]"
>>
>
> Flags seemed to correspond to the Flags characteristic descriptor and
> not the simple permissions of the characteristic itself.

"Flags" refers to Core SPEC page 1898: "3.3.1.1 Characteristic Properties"
The naming is not helping here. The original suggestion was
"Properties", but it may mislead to D-Bus Properties.

>
>>>> +               array{byte} Value [read-write]
>>>> +
>>>> +                       Cached Value of the characteristic. If present, the
>>>> +                       value will be cached by bluetoothd and updated when the
>>>> +                       PropertiesChanged signal is emitted.
>>>> +
>>>> +                       External services must emit this signal when the
>>>> +                       characteristic supports notification/indication, so
>>>> +                       that clients can be notified of the new value.
>>>
>>> The PropertiesChanged signal explains how Notification will be handled
>>> - but how will Indication? How will a service receive the Indication
>>> Confirmation from the remote devices?
>>
>> The bluetoothd core manages the Confirmation. In my opinion clients
>> listening for PropertiesChanged don' t need to know the difference
>> between notification and indication.
>> Allow an external client to manage the Confirmation will insert
>> additional complexity without giving real benefits.
>>
>
> I'm thinking of the opposite way around - not the clients, but the services.
>
> If I implement a service over the D-Bus API, and a characteristic
> supports Indication, then is it not important that the service be
> informed when the clients confirm the Indication that is sent out?

I understand your concerns. However, moving this control to the
servers may require persistence, and access to device and connection
information in the server implementation.
One alternative could be extend the ApplcationAgent1 interface adding
a method to inform timeout (confirmation not received for a given
characteristic).

>
> Otherwise it makes Indications identical to Notifications when
> implementing a service using the BlueZ D-Bus API, which may cause
> issues with implementing certain profiles.

We can assume that Indication has higher priority, and the Properties
( Indication/Notification) can be inferred during the declaration.

>
>
>>>> +Application Agent hierarchy
>>>> +===========================
>>>> +
>>>> +Service                unique name
>>>> +Interface      org.bluez.ApplicationAgent1 [Experimental]
>>>> +Object path    freely definable
>>>> +
>>>
>>> "Agent" seems unnnecessary here - if the object is an Application,
>>> then org.bluez.Application1 would be a decent enough name. Thus an
>>> "Application" consists of multiple Services, each of which consists of
>>> multiple Characteristics, each of which has multiple Descriptors
>>
>> IMO "Agent" gives a better association with its functionality, it
>> reminds me org.bluez.Agent1.
>> Let's wait the opinion of the others developers...
>>
>
> I was more thinking that we have "AgentManager" -> "Agent",
> "ProfileManager" -> "Profile", "ServiceManager" -> "Service" ... all
> of those use the agent-style pattern, but only "Pairing" Agent is
> called Agent.
>
> But honestly, bike shedding ;-)  I'm only complaining because calling
> it "ApplicationAgent" would slightly screw up my naming convention
> inside Chromium

My first proposal was ServiceManager1 and Service1.

Maybe renaming the registration method to RegisterService() and moving
Release method to Service1 will make it similar to Profile1, and
easier to understand. Potential errors can be reported through a
method under Service1 interface.

However, this last suggestion will trigger unneeded calls of
GetManagedObjects(), basically one call per service registration.

I will try a new round based on your inputs and wait for feedbacks.

Regards,
Claudio
