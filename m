Return-Path: <cyrus@holtmann.org>
From: "Caleb Reinhold" <creinhold@lampreynetworks.com>
To: "'Claudio Takahasi'" <claudio.takahasi@openbossa.org>,
	"'Scott James Remnant'" <keybuk@google.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1381777790-28891-1-git-send-email-claudio.takahasi@openbossa.org>	<1381862383-9866-1-git-send-email-claudio.takahasi@openbossa.org>	<CAHZ1yCmTdG_ynyfXj0CYhRsPWdM5MBeySvG1Wd5Xb+nEvCVH0A@mail.gmail.com> <CAKT1EBc2d3VkiUF705aNY79YDmL5ZRX75fg=a4a_ZfTPt4zoDA@mail.gmail.com>
In-Reply-To: <CAKT1EBc2d3VkiUF705aNY79YDmL5ZRX75fg=a4a_ZfTPt4zoDA@mail.gmail.com>
Subject: RE: [RFC BlueZ v1] doc: Add GATT API
Date: Thu, 14 Nov 2013 15:13:52 -0500
Message-ID: <000001cee176$13fe5a70$3bfb0f50$@lampreynetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio and Scott,

While having minimal familiarity with the workings of BlueZ, I have a fair degree of familiarity with the various health related BTLE specifications.
Because of this, and because of a desire to make use of a more complete GATT API for BlueZ, I thought I might be able to offer some worthwhile insight on useful ways for the API to behave. 

I think that while discussing the reading of characteristics, considering the information available to the client side at the time of connection due to advertisements would be useful. Since UUIDs for a given service being included in an advertisement are only at the level of a "should" it may be useful for an application to be able to decide to abort a connection after discovering only the service declarations. 

As far as the behavior of enabling Notifications or Indications, while in most circumstances it would be possible to draw appropriate information from the corresponding characteristic declaration's properties, if a situation occurred in which both options were for some reason viable selections it could be quite frustrating for the developer making use of the API. Manual control of the state of the client characteristic configuration descriptors also allows a developer to ensure that data will not be lost due to arriving before the client program is ready to handle it. 

Regarding the caching of attributes we were wondering if there is a method for removing the stored data, at least for the purposes of testing.

Regards,

Caleb Reinhold

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Claudio Takahasi
Sent: Tuesday, November 12, 2013 1:49 PM
To: Scott James Remnant
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ v1] doc: Add GATT API

Hi Scott,

On Mon, Nov 11, 2013 at 3:56 PM, Scott James Remnant <keybuk@google.com> wrote:
> On Tue, Oct 15, 2013 at 11:39 AM, Claudio Takahasi 
> <claudio.takahasi@openbossa.org> wrote:
>
>> +GATT local and remote services share the same high-level D-Bus API. 
>> +Local refers to local GATT based service exported by a BlueZ plugin 
>> +or an external application. Remote refers to GATT services exported by the peer.
>
> If this object format also be used to describe the services and 
> characteristics of a remote device, how will those be handled? I 
> assume that we don't want to get the value of every single 
> characteristic on connection - that seems wasteful, and would quite 
> rapidly drain the batteries of smaller devices.

Declarations are stored/cached. All attributes are discovered only once in the first connection or after bonding.
When re-connecting, value is read on demand when the user calls Properties Get (if value is not cached).
Another point is: Notification or Indication are automatically enabled after the discovery procedure.

>
>
> How will service changed be handled? How will BlueZ track the set of 
> applications, and the set of services etc. defined by those 
> applications in a manner that keeps handles consistent? How will it 
> handle generating the Services Changed notification in the cases where 
> the set of applications and/or services change, or the handles change?

We implemented a hash of declarations. Using the "Id"  provided in the options dictionary (see RegisterAgent) we are able to identity if the external service changed its attributes.
However, I don' t think we will upstream this approach soon, Marcel wants a simpler approach: always send ServiceChanged.

If you want to understand more details of the implementation see:
https://db.tt/FkWob6jw

>
>
>> +Characteristic hierarchy
>> +========================
>   :
>> +Service                org.bluez
>> +Interface      org.bluez.Characteristic1 [Experimental]
>> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
>
> This would also need a "Permissions" property akin to the one you have 
> for Descriptors - characteristics can be "not accessible", read-only, 
> write-only, read/write - and can also require authorization, 
> authentication, encryption and minimum encryption key sizes - as with 
> descriptors.

It is implemented already, there is an optional "Flags" property :
"array{string} Flags [read-only, optional]"

But this is not enough, there are some cases that the permissions are defined by the external application.

>
>> +               array{byte} Value [read-write]
>> +
>> +                       Cached Value of the characteristic. If present, the
>> +                       value will be cached by bluetoothd and updated when the
>> +                       PropertiesChanged signal is emitted.
>> +
>> +                       External services must emit this signal when the
>> +                       characteristic supports notification/indication, so
>> +                       that clients can be notified of the new value.
>
> The PropertiesChanged signal explains how Notification will be handled
> - but how will Indication? How will a service receive the Indication 
> Confirmation from the remote devices?

The bluetoothd core manages the Confirmation. In my opinion clients listening for PropertiesChanged don' t need to know the difference between notification and indication.
Allow an external client to manage the Confirmation will insert additional complexity without giving real benefits.

>
>
>> +Application Manager hierarchy
>> +=============================
>   :
>> +Service                org.bluez
>> +Interface      org.bluez.ApplicationManager1 [Experimental]
>> +Object path    /org/bluez
>> +
>> +Methods                RegisterAgent(object application, dict options)
>
> Shouldn't this be "RegisterApplication" ?
>
> I assume that the object path is the one to which D-Bus Object Manager 
> queries are sent, allowing a single process to implement multiple 
> "applications"?

The name is still open, but remember that this method might be used to register client and servers.

At the moment "object path" together with DBus BUS id are used for identification only. Multiple GATT services can be registered independently of the application object path.
Application object path can be used to manage *groups* of services exposed by the single process.

>
>> +               UnregisterAgent(object application)
>
> Likewise, "UnregisterApplication" ?
>
>> +Application Agent hierarchy
>> +===========================
>> +
>> +Service                unique name
>> +Interface      org.bluez.ApplicationAgent1 [Experimental]
>> +Object path    freely definable
>> +
>
> "Agent" seems unnnecessary here - if the object is an Application, 
> then org.bluez.Application1 would be a decent enough name. Thus an 
> "Application" consists of multiple Services, each of which consists of 
> multiple Characteristics, each of which has multiple Descriptors

IMO "Agent" gives a better association with its functionality, it reminds me org.bluez.Agent1.
Let's wait the opinion of the others developers...

Regards,
Claudio
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

