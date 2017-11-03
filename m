Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJC3ApemTSkcb5eC_efoZbzTyUDKgSE62a5OpMnswVzUg@mail.gmail.com>
References: <CAAu3APaxNENrLz0cp+3kk3FEgExw2bhrrRypUYYwPWXqFJkvqw@mail.gmail.com>
 <CABBYNZLKBwLZz69GYTT=w4Ldoz9sZidTtMixDqFcZHR9XGAP=g@mail.gmail.com>
 <CAAu3APbuGmfrH5iNQo2BdaqroBak=3fUvScRgL2wotQHRQGXVw@mail.gmail.com>
 <63A1858D-0254-499A-8BFA-595BDB0AE35F@gmail.com> <CABBYNZJC3ApemTSkcb5eC_efoZbzTyUDKgSE62a5OpMnswVzUg@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Fri, 3 Nov 2017 12:23:39 +0000
Message-ID: <CAAu3APY=sDFkGyhMeNf3tsFvLG+m4L8SH=e00kPbxuCU6+e3-w@mail.gmail.com>
Subject: Re: Feedback on BlueZ DBus API
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Travis Griggs <travisgriggs@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 3 November 2017 at 09:33, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Btw you can check what is happening with Qt which reinforces my view
> why it is not a good idea to start rewriting parts of the stack at
> application level, not only it creates problems later but I fill
> people just don't give a fair chance to BlueZ's APIs and start writing
> their own stack at first chance they have, most of the time using our
> very own kernel interfaces.

I first came here about three years ago looking for a way to scan for
beacon and process their information.
My absolute preference is to use the highest level of API possible.
I am totally in favour in getting things fixed as far upstream as possible.
So I think we are all agreeing on this point.

> In the meantime we had guys from nest/google just working with
> upstream to get their usecases covered, which is all upstream by now,
> and we have updated the adverting APIs and command line tools to make
> use of them.

Those with the skill level required to upstream is always going to be
a subset of those people that want to access Bluetooth from Python.
My gut feeling is that 'skill level' is one reason why people end up
fixing things at the 'wrong' level.
Another is that they can turn things around quicker by doing it in the
user space.
>From Python the two choices of API are DBus or raw HCI sockets. It is
not possible to access the mgmt API.
The problem seems to be that the current Python socket module doesn't
let you get at it. The relevant code appears to be in makesockaddr()
in CPython's socketmodule.c -  see
https://github.com/python/cpython/blob/master/Modules/socketmodule.c#L1276.
- it only ever seems to set the dev and bdaddr members, leaving the
hci_channel field set to 0 (HCI_CHANNEL_RAW).


> pydbus is a different problem though, while having to maintain a D-Bus
> binding can be a problem I guess it still a lot simpler than
> maintaining a Bluetooth stack.

I am going to put this in the same bucket as the previous point, the
skill and knowledge required to submitting fixes to D-Bus binding is
possibly off at a tangent from what many people coming to look at
Bluetooth might have.

I want to be constructive and to help move BlueZ forward in making it
more accessible for people from Python.
Upstreaming fixes has too big a barrier to entry for me and so I don't
know how to help move my issues forward.
I want to be able to build a scanner for beacons, I don't see how I
can do that without accessing the raw HCI sockets from Python.


Human nature is such that people normally take the path of least resistance.
I don't think there is a clear, strong and obvious way to implement
BLE in Python right now.
This seems to be reflected by others judging from the variety of ways
people have tried to do it:
https://github.com/ukBaz/python-bluezero/wiki
As you correctly identify, maintaining a Bluetooth stack is a lot of
work and so none of them really mature in to being really strong and
usable solutions.

People's comment to me is that there is not a good reliable source of
information/documentation which will help them get started when they
want to use BlueZ. As a result there is a lot of (outdated?)
misinformation that people refer to. It would be great if the BlueZ
project could be the source of great documentation when people want to
get started.
An example is the fact that the HCI* tools have been deprecated. I try
to spread the word about not using things like hcitool however there
is no documentation I can easily refer people to on the
correct/current tools to do these things.
It would be great if the reach of BlueZ could influence getting things
fixed in the infrastructure such a D-Bus binding and Python accessing
the mgmt API to make the BlueZ experience better.
Another example is it would be great if btvirt could be better
documented somewhere.
Yunhan Wang did a post to this group of how to reproduce an issue
using bluetoothctl. He used bluetoothctl to create a central and
peripheral on the same machine using btvirt. This seems like it would
be the good basis of an introduction to using bluetoothctl.

Regards,
Barry
