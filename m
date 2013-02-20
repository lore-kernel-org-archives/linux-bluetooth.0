Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361389393.5261.54.camel@dellpc>
References: <1361356092.2871.13.camel@dellpc>
	<CANq1E4Q+etVLVL6OxWdC=N+aodvS5sqjKY3ZqJwoGM5gCjdEFw@mail.gmail.com>
	<1361380641.5261.11.camel@dellpc>
	<CANq1E4QP3COYCbAK7vmR1ODjZ0t9cTPzOF9GarcpBT-RDQu=bw@mail.gmail.com>
	<1361389393.5261.54.camel@dellpc>
Date: Wed, 20 Feb 2013 21:15:09 +0100
Message-ID: <CANq1E4QNuj_7phM_rkG4jdZxjpJ9hozwmaiZ9oP3TsACSxagNg@mail.gmail.com>
Subject: Re: hidp_get_raw_report source of 5 second delay in device removal
From: David Herrmann <dh.herrmann@gmail.com>
To: Karl Relton <karllinuxtest.relton@ntlworld.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl

On Wed, Feb 20, 2013 at 8:43 PM, Karl Relton
<karllinuxtest.relton@ntlworld.com> wrote:
[...]
> Right!
>
> The point is
> hci_unregister_dev calls
>   hci_dev_do_close calls
>     hci_conn_hash_flush calls
>       hci_proto_disconn_cfm which triggers (via a 'wakeup' on a sock
> waitlist)
>         hidp_session running in another thread (a kthread) - which
>                      removes the sub-protocols
>
> ... and then hci_unregister_dev, after the above calls, will go on to
> call  hci_del_sysfs to remove the 'hci' device
>
> So the existing code does indeed trigger the removal of the
> sub-protocols 'theoretically' before the HCI device removal as you
> suggest it should.

The way to fix that is to add "hidp_remove" or something similar,
which locks the HIDP device, then removes the input-device/hid-device,
unlocks the HIDP device and returns. This then needs to be called
during hci_conn_del().

We currently remove input-devices/hid-devices in the HIDP session
itself. We can keep that if we make "hidp_remove" signal "terminate++"
and then wait for the thread to stop. But I think the other way is
better as it allows runtime-removal even though the sockets are still
alive. For instance, we could make hidp_delconn() synchronous with
this.

>
> BUT because hidp_session is running in another thread there will ALWAYS
> be a race. The whole 5 second hidp_get_raw_report thing shows up the
> race big time, but even without that there is still a race ... and so
> sometimes hidp_session will lose, leading to 'bad' udev events (and thus
> potential problems for userspace programs that were depending on them).

My bad. The 5s gap does indeed increase the possibility of that race
so it's definitely the more important fix.

>
> So ... if the HCI dev must be removed at its current point in the flow
> of hci code, then a method of delaying the hci code flow until
> sub-protocols (in this case hidp) are truly done is required (compared
> to the current 'trigger and forget' scenario). It is not obvious to me
> how to do that.
>
>> But more importantly, never ever call "device_del()" from within the
>> _release_ callback of the device itself! If you do that, you didn't
>> understand the idea behind the _get, _add, _del, _put functions.
>> Besides, you are _required_ to hold a reference to a device when
>> calling "device_del()". If you do that in the "release" callback, you
>> violate this rule.
>>
>
> I wasn't planning on doing that - which is why I re-introduced the hci
> local refcnt. Never mind.

hci_dev_hold() and hci_dev_put() are the _only_ place where we call
get_device() and put_device(), so if you introduce a refcnt in these
functions, you simply extend the device-refcnt.
This isn't obvious from the name of the functions so I'm sorry if that
was rude. It wasn't supposed to be rude, sorry.

>
>> I hope this cleared things up a bit. It's not your code, so you are
>> not to blame. And honestly, I don't know who to blame. But IMO this
>> needs to be fixed asap.
>>
>> Btw., the _ref, _add, _del, _unref cycle is something that is used in
>> many other places. Unfortunately, many people get it wrong..
>>
>> I will try to fix the mess this week.
>
>
> Great - sounds like the proper fix is beyond my ability and probably
> requires more radical surgery. There are lots of user reports against
> distributions that I think stem from this issue. For example Google
> Chrome OS hacked their Xorg input driver to try and cope with the
> truncated sysfs events that result - when the real issue is the hci/hidp
> driver interaction. I'm glad therefore you are on the case.

I know. This problem gets reported since at least 4 years here and
no-one fixed it properly. I'm not working on the Bluetooth layer,
either, but the bug bothers me as my HID drivers don't work over
Bluetooth.

Regards
David
