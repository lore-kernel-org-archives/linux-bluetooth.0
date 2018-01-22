Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB_54W7fp1tcQm3H872bKm-sTG+YKo_RKupCH8ZugNGwojAOSw@mail.gmail.com>
References: <CGME20180117034755epcas5p1437f6831b91eb594a1106f0960204b81@epcas5p1.samsung.com>
 <1516160848-471-1-git-send-email-yi2010.guo@samsung.com> <CABBYNZJjOEandxFeqbnei3bWpsNetWTbnna+7zGi5FofzcS59g@mail.gmail.com>
 <CAB_54W6dSUbybTyWq+Bap0KqCLZGcgSbrJrFGLY_VLPHOC9DJw@mail.gmail.com>
 <CABBYNZL9Xc5619AYf7Lqm3CPRG=ALQp9bLqbBKnJXVN6Bn0_Kg@mail.gmail.com> <CAB_54W7fp1tcQm3H872bKm-sTG+YKo_RKupCH8ZugNGwojAOSw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2018 18:11:19 -0200
Message-ID: <CABBYNZL2UZSY6PnY30DV_BxDw8J8DvDiQvSuemxQwO+RnLFrGA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix disconnect bug in 6lowpan
To: Alexander Aring <alex.aring@gmail.com>
Cc: Guo Yi <yi2010.guo@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, Jan 22, 2018 at 5:33 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> 2018-01-22 8:00 GMT-05:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>> Hi Alex,
>>
> ...
>>>
>>> or is there a special bluetooth API call needed, like the current case
>>> with debugfs.
>>> I know hcis are not netdevs, but it bothers me that we running into
>>> two different worlds on how to deal with that and it just requires
>>> "more" special bluetooth specific handling in user space applications.
>>> Later more "netdev" capable link layers will maybe support 6LoWPAN and
>>> then bluetooth might the only subsystem where different handling is
>>> needed to do such job like that.
>>
>> Keep in mind that the transport on Bluetooth happens to be in a
>> different layer, so you are basically suggesting that the kernel
>> maintain a L2CAP connection, similar to TCP, which has several
>> security implications.
>>
>
> no, I didn't said to change something in protocol handling etc.
> I just wanted to say that I am aware that hci is not netdev and it's
> hard to use net core api on these "interface types", because net core
> knows netdevs only.
>
>>> We maybe need to support a special handling in "ip link add" to map to
>>> bluetooth instead moving that to people in user space?
>>
>> Afaik ip tool cannot support any tunnel interface since the kernel
>> cleanup any socket opened when the tool exit. Btw, with the patches
>> above bluetoothd would take care of adding/removing the links
>> automatically so at least this step will not be necessary. Other ip
>> commands should work though.
>>
>
> not tunneling, etc. I just want to know how you create a netdev
> capable 6LoWPAN interface, it is not done by net core API so far I see
> and it will never be done?
> You say bluetoothd will care about it, but then bluetoothd will call
> the right bluetooth API (not net core API, e.g. netlink (what iproute
> uses))
> Example:
>
> ip link add link hci0 name 6lo0 type 6lowpan

Again this wouldn't work since hci0 is not the transport, it has to go
via L2CAP which is already maintained at userspace. Maintaining the
L2CAP connection at kernel level is not an option, the cover letter
should be clear about it.

> This cannot work because the net core API will not work on HCI
> "devices", I see..., but it highly bothers me that we cannot use
> similar API to add or delete such interfaces with netlink API and
> iproute2 -> you are forced to use bluetooth API with everything behind
> it. At least a delete should work... (I am currently not sure if "ip
> link del" would work with bluetooth 6LoWPAN).

Bluetooth has its own management interface, it doesn't use netlink and
I don't think we will be changing this anytime soon, that said the
link add/remove would not work like that anyway since one would have
to specify the L2CAP scid/dcid of connection or make the ip tool
create a L2CAP connection itself, so lets stop right here and not
continue since it would probably mess up the ip tool so bad no one
would accept this upstream.

> According to adding a 6LoWPAN interface, so far I see it will never be
> handled by net core API and creating a mapping from net core API to
> bluetooth sounds fragile...

We are proposing the introducing of tunnel like interface using 6lo
adaptation, this obviously would require a proper driver that deal
interface with net core using the 6lowpan internals which has
advantages over doing it completely on userspace for handling
contexts, etc, since icmpv6 implementation happens to be already in
the kernel, not to mention it would further fragment the community
working on 6lowpan.

> At least there is some command "create an 6LoWPAN interface for my
> link layer hci device" or it's still magically created/removed by if
> there exists a connection or not (I highly don't recommend it, because
> user space applications cannot simple deal with dynamically creation
> and removal of netdevs (and at the end it should be act like the
> removed one again)), ifup/ifdown -> that's okay...
> We already had this discussion once if I remember correctly.

The interfaces are _not_ dynamically created, bluetoothd plugin
creates one interface per adapter at startup and manages the up
status, that is it. Perhaps you should check how it is working before
assuming such things, there is nothing magical or anything, there are
plenty of daemons using TUN/TAP for tunnels for the exact same reason.

I will refrain to repeat myself next time, so if you have comments
around the code please comment on the patches themselves so we keep
this more productive.


-- 
Luiz Augusto von Dentz
