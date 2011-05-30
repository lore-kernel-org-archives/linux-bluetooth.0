Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTim2-LiAO4UdoU0+UT92_JAtxZ+XFw@mail.gmail.com>
References: <1302892422-32206-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110415184728.GA2359@joana>
	<1302915790.2503.31.camel@aeonflux>
	<20110416070006.GA10860@jh-x301>
	<BANLkTi=QNU7MS80fKfsAvRRKAX+80hmQtA@mail.gmail.com>
	<BANLkTim2-LiAO4UdoU0+UT92_JAtxZ+XFw@mail.gmail.com>
Date: Mon, 30 May 2011 20:27:22 +0300
Message-ID: <BANLkTikX=20uaMWDrUQssMUSH23KtGHAcA@mail.gmail.com>
Subject: Re: [RFC] Proposal to distinguish address device types
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 18, 2011 at 9:20 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Marcel/Johan/Gustavo,
>
> On Sat, Apr 16, 2011 at 5:04 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Hi Marcel,
>>
>> On Sat, Apr 16, 2011 at 7:00 AM, Johan Hedberg <johan.hedberg@gmail.com>=
 wrote:
>>> Hi Marcel,
>>>
>>> On Fri, Apr 15, 2011, Marcel Holtmann wrote:
>>>> > > + BDADDR_TYPE_LE_PUBLIC,
>>>> > > + BRADDR_TYPE_LE_RANDOM
>>>> > > +};
>>>>
>>>> I am also not sure the we should have this BR/EDR differentiation sinc=
e
>>>> the specification only talks about public and random addresses. And we
>>>> should follow the specification type value here. I am against
>>>> introducing our enum here.
>>>
>>> The HCI specification only has values for public and random because
>>> everywhere they are used it is already clear from the context (the HCI
>>> command or event in question) if we're talking about LE or BR/EDR. We o=
n
>>> the other hand don't have this contextual information with the
>>> mgmt_pair_device command. Saying "public" there could mean both BR/EDR
>>> public or LE public, i.e. an enum with just two possible values is not
>>> going to be of much use to us. Because of this difference between our
>>> API and that of HCI I don't think it's fair to apply the HCI
>>> convention/restriction to us.
>>>
>>> Johan
>>>
>>
>> I added 3 values because it gives more flexibility. Possible use cases:
>> - Whitelist needs the address type
>> - SMP
>> - As input to decide to store or not information about the device
>> since private address can change every 15minutes
>>
>> =A0At the moment we only need to know if the address is basic rate or LE
>> to select the discovery type: SDP or LE Discovery primary. For
>> pairing, Vinicius is using the kernel advertising cache to discover
>> the address type, passing the address type could avoid wrong fallback
>> to basic rate if the entry is not found in the cache.
>>
>> Claudio
>>
>
> Any objection to add the address type in the MGMT_EV_DEVICE_CONNECTED eve=
nt?
> Inside event.c there are a lot of get_adapter_and_device calls, for
> some contexts it creates a new device object if it doesn't exist(eg:
> incoming pairing). But the type is required to create a new device,
> otherwise it will not be possible to trigger the reverse service
> search. Obtain the type later based on the link key type will not
> work, unless we create a device with unknown type to be able to call
> the agent methods.
>
> BTW, is there a reason why it is necessary to "force" device
> creation(get_adapter_and_device option)? In my opinion we could create
> the device(if it doesn't exist) it inside btd_event_conn_complete
> only. There is a potential race condition: other application calling
> RemoveDevice, but for this case reference counting should work.
>
> Currently, controllers doesn't support simultaneous BR/EDR/LE, this is
> another argument to export the address type or connection type through
> management interface avoiding future changes on the API.

What about having a different socket family for le e.g.
AF_BLUETOOTH_LE? With that we could have more direct mapping with the
spec, with proper 49 bit addresses and things like that so we don't
have to break existing code.


--=20
Luiz Augusto von Dentz
Computer Engineer
