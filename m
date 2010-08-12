Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Aug 2010 23:07:07 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	marcel@holtmann.org
Subject: Re: why is hciops a plugin ?
Message-ID: <20100812030707.GA17784@jh-x301>
References: <AANLkTino39jMNvdcV=EiekN33vrfNXLyJVNsHcHtq5wz@mail.gmail.com>
 <20100811021610.GA8306@jh-x301>
 <AANLkTimku3Obrb=4KFjD5mapWpYQ0__4UZmzbfadu3WM@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimku3Obrb=4KFjD5mapWpYQ0__4UZmzbfadu3WM@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 11, 2010, Pavan Savoy wrote:
> When you say raw HCI access do you mean doing the
> socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI) and bind/ioctl, writev+poll/read
> lacks few things ?
> but all of these are in lib/hci isn't it ?

Yes, that's the type of socket that I meant. Direct access to the HCI
messages would largely go away from the userspace side. Those
libbluetooth functions you're referring to are just convenience wrappers
for sending HCI commands through raw HCI sockets.

> So even if it was netlink only something like hci_open_dev() would
> have changed to socket(PF_NETLINK, SOCK_RAW, BT_NETLINK ); or
> something right ?

I'm not really familiar enough with netlink to comment on this. Marcel
(whose idea it originally was) would have to comment.

> any pointers out there ? references for such things ?
> I am just curious, don;t want anything specific ...

Right now, not really. The only stack internal messages there are at the
moment are things like HCI_DEV_REG, HCI_DEV_UNREG, HCI_DEV_UP and
HCI_DEV_DOWN and they only go one way (kernel->userspace). This category
of messages will grow in the future and it'll be possible to send them
both ways.

Some HCI messages for which it's already clear now that there will be a
benefit from a higher level abstraction on the userspace side are things
like name resolving and pairing related requests. Also, if I understood
correctly from Marcel, removing userspace processing of HCI events will
result in a considreable reduction of context switches since there wont
anymore be a promiscuous userspace-side socket that needs to
handle/filter all HCI data (Marcel, please correct me if this is
inaccurate or wrong).

Johan
