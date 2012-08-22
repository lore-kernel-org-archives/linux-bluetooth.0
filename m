Return-Path: <cyrus@holtmann.org>
Message-ID: <1345637062.29868.313.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 22 Aug 2012 14:04:22 +0200
In-Reply-To: <CABBYNZLUS-BrZ=FN28gLgrA=1vS1JA-exECd3xgjj2EfPrAuyw@mail.gmail.com>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1345537878.29868.185.camel@pohly-mobl1.fritz.box>
	 <CABBYNZLUS-BrZ=FN28gLgrA=1vS1JA-exECd3xgjj2EfPrAuyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2012-08-22 at 14:39 +0300, Luiz Augusto von Dentz wrote:
> Hi Patrick,
> 
> On Tue, Aug 21, 2012 at 11:31 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> >> diff --git a/doc/client-api.txt b/doc/client-api.txt
> >> index 839a78c..7ca65cc 100644
> >> --- a/doc/client-api.txt
> >> +++ b/doc/client-api.txt
> >> @@ -466,7 +466,7 @@ Transfer hierarchy
> >>
> >>  Service              org.bluez.obex.client
> >>  Interface    org.bluez.obex.Transfer
> >> -Object path  [variable prefix]/{transfer0,transfer1,...}
> >> +Object path  [variable prefix]/{session0,session1,...}/{transfer0,...}
> >>
> >>  Methods              dict GetProperties()
> >
> > It would be even better to explicitly mention that the "[variable
> > prefix]" here is the same as the "[variable prefix]" in the Session.
> >
> > Or perhaps change it like this?
> >
> > -Object path    [variable prefix]/{transfer0,transfer1,...}
> > +Object path    [session prefix]/{transfer0,...}
> 
> Hmm, I prefer the original proposal since that imo looks more clear
> how the path is formatted, anyway the point here is that the transfers
> are tied to sessions.

But as Marcel said, "variable prefix" means "no guarantee made about its
content, none whatsoever". Without knowing Bluez conventions, that was
also my understand when reading the API description. Assigning some
other meaning to "variable prefix" would break with developer
expectations.

Unless the meaning of "variable prefix" gets redefined, "[variable
prefix]/{session0,session1,...}" still doesn't allow the developer to do
path_namespace filtering.

How about this:

-Object path  [variable prefix]/{transfer0,transfer1,...}
+Object path  [prefix]/{session0,session1,...}/{transfer0,...}"
+             with "prefix" as in the corresponding session

> > Using this knowledge efficiently is not always possible, however. D-Bus
> > itself has a "path_namespace" filter [1], but many D-Bus bindings don't
> > expose it (Python [2], GIO D-Bus [3]). Therefore a client using those
> > bindings still has to receive all Transfer signals and do its own
> > filtering.
> >
> > [1] http://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-routing-match-rules
> > [2] http://dbus.freedesktop.org/doc/dbus-python/api/dbus.connection.Connection-class.html#add_signal_receiver
> > [3] http://developer.gnome.org/gio/stable/GDBusConnection.html#g-dbus-connection-signal-subscribe
> 
> Apparently people are not doing a good job with bindings then, arg
> matching is quite essential to things like NameOwnerChanged, anyway
> for what is worth even properties have this race condition with values
> changing in meantime while GetAll/Get/GetProperties is returning, so
> it seems we need to solve this problem by making the transfer
> properties unlikely to change so the application have enough time to
> subscribe to signals.

"unlikely" doesn't sit well with me. An unlikely failure is still a
failure. Tell me if I'm too pedantic here ;-)

I can imagine three ways to address race conditions:
1. Clients subscribe to signals in advance, before any are sent.
2. Clients subscribe to signals later *and* check the current state.
3. Clients provide a callback object with methods which get invoked by
   obexd.

The second option increases traffic and depends on being able to check
the current state. Currently this approach is not possible for Transfer
objects because they can get removed before the client checked their
state.

The third option has the drawback that there's no standard way of
letting the client declare which of these methods it wants to have
called (in contrast to D-Bus signals). The advantage is that it becomes
possible to clean up temp files after completion of the transfer: add an
explicit "here's your result" callback method and when that fails,
delete the temporary file.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


