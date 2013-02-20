Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361380641.5261.11.camel@dellpc>
References: <1361356092.2871.13.camel@dellpc>
	<CANq1E4Q+etVLVL6OxWdC=N+aodvS5sqjKY3ZqJwoGM5gCjdEFw@mail.gmail.com>
	<1361380641.5261.11.camel@dellpc>
Date: Wed, 20 Feb 2013 20:22:16 +0100
Message-ID: <CANq1E4QP3COYCbAK7vmR1ODjZ0t9cTPzOF9GarcpBT-RDQu=bw@mail.gmail.com>
Subject: Re: hidp_get_raw_report source of 5 second delay in device removal
From: David Herrmann <dh.herrmann@gmail.com>
To: Karl Relton <karllinuxtest.relton@ntlworld.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl

On Wed, Feb 20, 2013 at 6:17 PM, Karl Relton
<karllinuxtest.relton@ntlworld.com> wrote:
>
> Why 'HCI device must be deleted here'? I guess there is a reason, but it
> is not obvious to me.

Ok let me first explain the device-lifetime concept of the kernel:

A device is an object with at least 4 functions on it:
 - get_device()
     Increases the reference-count of the device object. This
     guarantees that the memory-object of the device itself
     is not free()'ed as long as you hold that reference. Nothing
     else is guaranteed about the object!
 - put_device()
     Decreases the reference-count of the device object. You _must_
     have called get_device() before! If the reference-count drops
     to 0, there are no more users and the object is freed.
 - device_add()
     Puts 'life' into the object. This adds the object to the global
     tree of _living_ objects. You must hold a reference to the
     device when calling this.
     User-space is informed at this time about the object.
 - device_del()
     'Kills' an object. The object is not deleted but killed. That
     is, it is no longer linked into the tree of living objects, but
     the object still exists.
     User-space is informed at this time that the object is gone.

All other calls like "register_device()", "unregister_device()", ...
are based on these four calls. There is one more,
"device_initialize()", but this is basically "get_device()" and should
be used during device initialization _instead_ of the first call to
"get_device()".

So how are these calls supposed to be used?
When you create a device, you call "device_initialize()", set the
device up, initialize everything and keep it around for your own use.
When the device wakes up and you want to put life into it, you call
"device_add()". This is equivalent to saying: "this device is now
ready for operation and the underlying hardware is fully functional".
You now operate on the device, pass it around and do a lot of
get_device() and put_device().
Now, when the underlying hardware shuts down, the device shouldn't be
used anymore. So what do you do? You call "device_del()". This
notifies all users of the device, that it is dead. Any operation on it
that requires a _living_ device, will then _probably_ fail with
-ENODEV. However, any operation that _doesn't_ require a living device
will still work. This is, because "device_del()" doesn't destroy
devices, it just marks them as dead.
After you called "device_del()", a device is normally supposed to
eventually fade away and get destroyed. This is, because you normally
_never_ revive an object (you create a new object instead). So with a
call to "device_del()" you should also inform all its users that the
device is gone. Bus systems do this by unloading the driver of the
device, other systems do this by notifying the users via some other
way. However, every user that holds the device must somehow be
informed, that it's dead and they should release it.
After all users released it (while maybe asynchronously waiting for
user-space or hardware reactions), the device gets deleted when the
last user calls put_device().

As you might notice, there is always _one_ piece of (maybe virtual)
hardware that controls the device. When the hardware shows up, you
call device_add(), when the hardware goes away, you call device_del().
You cannot control when hardware goes away, so it does *never* *ever*
makes sense to delay a device_del() call for an unknown amount of
time. The hardware is _gone_, so why should the device stay? Really,
try to find any _logical_ reason why the device should stay?

So what does that mean for hci_conn? It basically means
hci_conn_hold_device() and hci_conn_put_device() are bullsh**. Use
hci_conn_hold() and hci_conn_put() instead.
Additionally, we need some way to inform HIDP that the used hci_conn
is dead _before_ calling device_del() on hci_conn. How do we do that?
One idea would be to link each hidp object into hci_conn with a
callback that we call. HIDP can then delete its child devices and
continue.

But more importantly, never ever call "device_del()" from within the
_release_ callback of the device itself! If you do that, you didn't
understand the idea behind the _get, _add, _del, _put functions.
Besides, you are _required_ to hold a reference to a device when
calling "device_del()". If you do that in the "release" callback, you
violate this rule.

> My suggested fix simply follows the same logic as hci_conn_put_device,
> which only does sysfs removal once all users of the HCI_CONN device have
> finished.

Yeah, hci_conn is the culprit here. It's broken. Don't copy its behavior.

>
>> > *** Note the 5 SECOND gap ... thats the timeout value in hidp_get_raw_report!
>> > *** having timed out, the hidp_session thread gets underway again
>> > *** the various devices are now removed (input, event, hidraw, hci_conn)
>> > *** and life can go on
>> > Feb 20 09:31:15 laptop2 kernel: [  339.372148] hidp_get_raw_report timed out!
>> > Feb 20 09:31:15 laptop2 kernel: [  339.372153] power_supply hid-60:c5:47:1b:07:b8-battery: driver failed to report `capacity' property: -5
>> > Feb 20 09:31:15 laptop2 kernel: [  339.376347] PM: resume of devices complete after 5491.694 msecs
>> > Feb 20 09:31:15 laptop2 kernel: [  339.376362] hidp_session Done hid_destry_device
>> > Feb 20 09:31:15 laptop2 kernel: [  339.376366] hci_conn_del_sysfs: conn e000bc00
>> > Feb 20 09:31:15 laptop2 kernel: [  339.376392] hci_dev_put: hci0 orig refcnt 1
>> > *** a new hci device is registered, and a new hci_conn, and sub-tree of input devices
>> > *** will be added, which is normal and to be expected.
>> > *** NOTE though whilst the new registration occurs here in this log, I have seen it
>> > *** occur much earlier in other logs (different versions of kernel), leading to
>> > *** various problems when a new hci_conn is added whilst the old one has yet to be deleted.
>>
>> No! There is no problem with adding a new hci_conn while another one
>> is still to be removed. This totally normal and _must_ be supported.
>> As long as both hci_conn objects have different IDs this is correctly
>> understood by user-space, too.
>>
>> We fixed the ID issue two years ago and this is no longer a problem
>> here. If you see a bug where a hci_conn with an equal ID is
>> registered, please report it. This would be a bug then.
>>
>
> Fair enough - I have seen a new hci_conn with an equal ID, but I have
> been playing with different kernels between 3.2 and 3.8. So unless I see
> it again with 3.8 or later I'll trust that particular issue is indeed
> resolved.

It might not be solved, yet. But it's definitely some other bug then.

I hope this cleared things up a bit. It's not your code, so you are
not to blame. And honestly, I don't know who to blame. But IMO this
needs to be fixed asap.

Btw., the _ref, _add, _del, _unref cycle is something that is used in
many other places. Unfortunately, many people get it wrong..

I will try to fix the mess this week.
Cheers
David
