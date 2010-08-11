Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100811021610.GA8306@jh-x301>
References: <AANLkTino39jMNvdcV=EiekN33vrfNXLyJVNsHcHtq5wz@mail.gmail.com>
	<20100811021610.GA8306@jh-x301>
Date: Wed, 11 Aug 2010 14:41:06 -0500
Message-ID: <AANLkTimku3Obrb=4KFjD5mapWpYQ0__4UZmzbfadu3WM@mail.gmail.com>
Subject: Re: why is hciops a plugin ?
From: Pavan Savoy <pavan_savoy@sify.com>
To: Pavan Savoy <pavan_savoy@sify.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 10, 2010 at 9:16 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Aug 10, 2010, Pavan Savoy wrote:
>> Any reason behind making hciops a plugin and bluetoothd making use of
>> that plugin, wasn't everything straight up in hcid before ?
>
> We're planning on redoing the kernel-userspace interface and in the long
> run the traditional raw HCI access wont exist anymore in userspace. In
> order to accommodate both old and new kernels in a clean way the
> interface towards the kernel needs to be easily interchangable, which is
> what hciops is trying to do (it's just a first step in that direction
> though). One of the drivers for this change is the need to have the
> security logic in one place instead of it being split between kernel and
> userspace (this has caused all sorts of trouble with SSP for us).

When you say raw HCI access do you mean doing the
socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI) and bind/ioctl, writev+poll/read
lacks few things ?
but all of these are in lib/hci isn't it ?

> Originally the plan for the new kernel interface was netlink but now the

So even if it was netlink only something like hci_open_dev() would
have changed to
socket(PF_NETLINK, SOCK_RAW, BT_NETLINK ); or something right ?

> idea is to simply extend the stack internal messages of raw HCI sockets
> with a more complete two-way protocol between the kernel and userspace.
> You should (hopefully) be seeing more patches for this still during this
> year.

any pointers out there ? references for such things ?
I am just curious, don;t want anything specific ...

> Johan
>
