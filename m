Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1281613392.12579.267.camel@localhost.localdomain>
References: <AANLkTino39jMNvdcV=EiekN33vrfNXLyJVNsHcHtq5wz@mail.gmail.com>
	<20100811021610.GA8306@jh-x301>
	<AANLkTimku3Obrb=4KFjD5mapWpYQ0__4UZmzbfadu3WM@mail.gmail.com>
	<20100812030707.GA17784@jh-x301>
	<1281613392.12579.267.camel@localhost.localdomain>
Date: Fri, 13 Aug 2010 06:05:12 +0530
Message-ID: <AANLkTikX4JoPR3qOoc1MtHheGXKZzNPhfDgp5VUFO=ha@mail.gmail.com>
Subject: Re: why is hciops a plugin ?
From: Pavan Savoy <pavan_savoy@sify.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel, Johan,

On Thu, Aug 12, 2010 at 5:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>> > When you say raw HCI access do you mean doing the
>> > socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI) and bind/ioctl, writev+poll/read
>> > lacks few things ?
>> > but all of these are in lib/hci isn't it ?
>>
>> Yes, that's the type of socket that I meant. Direct access to the HCI
>> messages would largely go away from the userspace side. Those
>> libbluetooth functions you're referring to are just convenience wrappers
>> for sending HCI commands through raw HCI sockets.
>>
>> > So even if it was netlink only something like hci_open_dev() would
>> > have changed to socket(PF_NETLINK, SOCK_RAW, BT_NETLINK ); or
>> > something right ?
>>
>> I'm not really familiar enough with netlink to comment on this. Marcel
>> (whose idea it originally was) would have to comment.
>>
>> > any pointers out there ? references for such things ?
>> > I am just curious, don;t want anything specific ...
>>
>> Right now, not really. The only stack internal messages there are at the
>> moment are things like HCI_DEV_REG, HCI_DEV_UNREG, HCI_DEV_UP and
>> HCI_DEV_DOWN and they only go one way (kernel->userspace). This category
>> of messages will grow in the future and it'll be possible to send them
>> both ways.

Yes, this explains why hciops is a a plugin now, thanks...

>> Some HCI messages for which it's already clear now that there will be a
>> benefit from a higher level abstraction on the userspace side are things
>> like name resolving and pairing related requests. Also, if I understood
>> correctly from Marcel, removing userspace processing of HCI events will
>> result in a considreable reduction of context switches since there wont
>> anymore be a promiscuous userspace-side socket that needs to
>> handle/filter all HCI data (Marcel, please correct me if this is
>> inaccurate or wrong).
>
> this is correct. We will not require userspace to do HCI event
> processing and filtering anymore. It will be a dedicated side channel.

Side channel ? But there would still be some way to bring out events
onto user-space right ?
As in application which do and ONLY do HCI-VS commands, and are
interested in HCI-VS events...

> Regards
>
> Marcel
>
>
>
