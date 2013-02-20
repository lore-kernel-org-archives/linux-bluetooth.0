Return-Path: <cyrus@holtmann.org>
Message-ID: <1361389393.5261.54.camel@dellpc>
Subject: Re: hidp_get_raw_report source of 5 second delay in device removal
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 20 Feb 2013 19:43:13 +0000
In-Reply-To: <CANq1E4QP3COYCbAK7vmR1ODjZ0t9cTPzOF9GarcpBT-RDQu=bw@mail.gmail.com>
References: <1361356092.2871.13.camel@dellpc>
	 <CANq1E4Q+etVLVL6OxWdC=N+aodvS5sqjKY3ZqJwoGM5gCjdEFw@mail.gmail.com>
	 <1361380641.5261.11.camel@dellpc>
	 <CANq1E4QP3COYCbAK7vmR1ODjZ0t9cTPzOF9GarcpBT-RDQu=bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2013-02-20 at 20:22 +0100, David Herrmann wrote:
> Hi Karl
> 
> On Wed, Feb 20, 2013 at 6:17 PM, Karl Relton
> <karllinuxtest.relton@ntlworld.com> wrote:
> >
> > Why 'HCI device must be deleted here'? I guess there is a reason, but it
> > is not obvious to me.
> 
> Ok let me first explain the device-lifetime concept of the kernel:
>  ... <much excellent explanation> ...

Excellent - thankyou, that puts me properly in the picture and overcomes
my lack of knowledge. Thankyou again.

> 
> So what does that mean for hci_conn? It basically means
> hci_conn_hold_device() and hci_conn_put_device() are bullsh**. Use
> hci_conn_hold() and hci_conn_put() instead.

Fair enough.

> Additionally, we need some way to inform HIDP that the used hci_conn
> is dead _before_ calling device_del() on hci_conn. How do we do that?
> One idea would be to link each hidp object into hci_conn with a
> callback that we call. HIDP can then delete its child devices and
> continue.
> 

OK - understood.

Now over in the '[PATCH] hci: Fix race between hidp_session and hci
code' thread you said:

> So if stuff breaks because we remove the device from sysfs, then fix
> the stuff that breaks! In this case this means removing all
> sub-protocols from sysfs exactly at the same point when we remove the
> hci-dev from sysfs!
> 
Right!

The point is
hci_unregister_dev calls
  hci_dev_do_close calls
    hci_conn_hash_flush calls
      hci_proto_disconn_cfm which triggers (via a 'wakeup' on a sock
waitlist)
        hidp_session running in another thread (a kthread) - which 
                     removes the sub-protocols

... and then hci_unregister_dev, after the above calls, will go on to
call  hci_del_sysfs to remove the 'hci' device

So the existing code does indeed trigger the removal of the
sub-protocols 'theoretically' before the HCI device removal as you
suggest it should.


BUT because hidp_session is running in another thread there will ALWAYS
be a race. The whole 5 second hidp_get_raw_report thing shows up the
race big time, but even without that there is still a race ... and so
sometimes hidp_session will lose, leading to 'bad' udev events (and thus
potential problems for userspace programs that were depending on them).


So ... if the HCI dev must be removed at its current point in the flow
of hci code, then a method of delaying the hci code flow until
sub-protocols (in this case hidp) are truly done is required (compared
to the current 'trigger and forget' scenario). It is not obvious to me
how to do that.


> But more importantly, never ever call "device_del()" from within the
> _release_ callback of the device itself! If you do that, you didn't
> understand the idea behind the _get, _add, _del, _put functions.
> Besides, you are _required_ to hold a reference to a device when
> calling "device_del()". If you do that in the "release" callback, you
> violate this rule.
> 

I wasn't planning on doing that - which is why I re-introduced the hci
local refcnt. Never mind.


> I hope this cleared things up a bit. It's not your code, so you are
> not to blame. And honestly, I don't know who to blame. But IMO this
> needs to be fixed asap.
> 
> Btw., the _ref, _add, _del, _unref cycle is something that is used in
> many other places. Unfortunately, many people get it wrong..
> 
> I will try to fix the mess this week.


Great - sounds like the proper fix is beyond my ability and probably
requires more radical surgery. There are lots of user reports against
distributions that I think stem from this issue. For example Google
Chrome OS hacked their Xorg input driver to try and cope with the
truncated sysfs events that result - when the real issue is the hci/hidp
driver interaction. I'm glad therefore you are on the case.

Many thanks
Karl

