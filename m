Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130626194958.GA4727@x220.P-661HNU-F1>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
 <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com>
 <20130419133459.GA7044@echo> <20130424135855.GA18679@x220>
 <CAMOw1v5ef6Uwx5t32pMhzzb4gurLuf+K9-iXJmgfdyCAGH+Wjg@mail.gmail.com>
 <20130424183600.GA29925@x220> <CAMOw1v5PS46KSTEb-7mEySpucEQqB19=iDwvGKSJ3CHKEdJ0Ow@mail.gmail.com>
 <CA+A7VXV9sHvBDcP2XxrAGrVriv=FD6is90gauC-cVHnbjCHTXg@mail.gmail.com> <20130626194958.GA4727@x220.P-661HNU-F1>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 26 Jun 2013 19:09:50 -0300
Message-ID: <CAMOw1v7d=8qdBdFWKLbF0-v53=_aKe5Q50kF4O5z9gXYPmUARg@mail.gmail.com>
Subject: Re: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 26, 2013 at 4:49 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi João Paulo,
>
> On Wed, Jun 26, 2013, João Paulo Rechi Vita wrote:
>> >>> When we implemented the properties interface, the manner we talked
>> >>> about doing this (if it was indeed needed) was mostly what Luiz is
>> >>> saying now. I think I even sent a patch to this mailing list
>> >>> containing this flag. You would add something like:
>> >>>
>> >>> G_DBUS_PROPERTY_FLAG_IMMEDIATE (or some better naming). Then
>> >>> g_dbus_emit_property_changed() would check this flag, in which case
>> >>> process_changes() would be called synchronously. I don't see why this
>> >>> wouldn't solve your problem and it doesn't require an API change. For
>> >>> the exceptional cases in which this is needed, we add such flag. And
>> >>> if a property needs to be sent immediately in one place I think it
>> >>> always will. Or am I missing something?
>> >>
>> >> The main point I was trying to present is that it would be nice if when
>> >> you have code like:
>> >>
>> >>         foo();
>> >>         bar();
>> >>         baz();
>> >>
>> >> and each of those calls create a D-Bus message (property signal method
>> >> call/return, etc) that needs to be sent, that you could count on the
>> >> messages being sent in the same order that they happen in the code. This
>> >> kind of intuitiveness would be nice to have regardless of whether we're
>> >> dealing with a special case that really needs it or not.
>> >
>> > Any of the proposed solutions do this. Your solution involves not
>> > marking the special cases, but on the other hand makes the special
>> > cases the default and needs some more working on gdbus to cover all
>> > the uses of dbus_connection_send_*
>> >
>> > I'm not saying it's not a good solution, bit I'm not sure it's the
>> > best one neither.
>>
>> Can we get back to this topic? This problem is still present in the
>> master branch and affecting our support for HFP in oFono.
>
> The last chat I had with Marcel about this was that he also preferred to
> have a method call sending gdbus API that guarantees the ordering of
> messages (including method calls, replies and signals). We don't have to
> convert absolutely everything immediately to use the API but just the
> critical places where the order is actually causing bad behavior right
> now.
>
> Technical detail-wise this is not completely trivial since the pending
> signal handling is part of the gdbus context data for the local object
> path that emits them, whereas method calls do not have any associated
> local object path (they're tied to a *remote* object path), i.e. the
> same gdbus context data can't be used. One option would be to track
> pending method calls in the context data for the root path which is
> available as the static "root" variable in gdbus/object.c. Another
> technical detail that needs deciding is whether sending a method call
> should cause a forceful sending of any pending signals, or whether the
> call should also be put behind an idle callback.

If you really want to do this (which I don't completely agree with), I
think the only option is to send pending signals when there's a
method-{reply,call}. And delay sending only the signals that do need
to be delayed. The only one I remember off is the
org.freedesktop.DBus.PropertiesChanged() signal.  We delay sending
this signal to an idler exactly because we want to group all pending
properties into only 1 signal. But if in the meantime there's another
d-bus message, if you want to guarantee the order you need to "flush
pending property changes". All the other signals, method returns and
calls can be sent right away. Putting a method call behind an idler
doesn't really solve the problem since it doesn't guarantee the order.
E.g.:

1) g_dbus_property_changed(A);
2) g_dbus_property_changed(B);
3) g_dbus_send_method_call(...);
4) g_dbus_property_changed(C);

Because of the fact that we group property changes, it doesn't matter
how you treat the pending messages in the idler, property C will be
sent together with A and B, either before or after the method call,
thus not guaranteeing the order.

On the other hand, if you make method calls and replies to force
pending signals to be sent, in the case above you will have the
messages as below and this doesn't need the idler thing.

=> signal org.freedesktop.DBus.PropertiesChanged(A, B)
=> method-call
=> signal org.freedesktop.DBus.PropertiesChanged(C)

And if you reorder 3 and 4 it also works:

=> signal org.freedesktop.DBus.PropertiesChanged(A, B, C)
=> method-call

This is the first problem to solve. The second one, and more tricky is
regarding property changes on different interfaces/objects. Should we
also guarantee the order? E.g:

1) g_dbus_property_changed(obj, ifaceA, "Bla");
2) g_dbus_property_changed(obj, ifaceB, "Bla");

Right now the order is not guaranteed and depend on the object path
and the order in which the interfaces were registered. I think this is
not really important and it's one thing we should never give
guarantees API-wise, so IMO it can stays as such.

The third problem is about how we coalesce property changes. E.g:

obj->state = "a";
g_dbus_property_changed("State");
obj->state = "b";
g_dbus_property_changed("State");

The user ends up never seeing State="a" because we only get the value
in an idler, when it already changed. I think one user that would need
this to be changed is oFono, that may need to report specific
transitions in voice call states. However this is only one example,
I'm not sure if oFono is planning to change its interface. I  think we
can change this by start constructing the signal right when the
property changes. AFAIR we do what we do now because of the libdbus
API, that don't let we append properties in the changed_properties
dict after we have already started appending properties to the
invalidated_properties array.  Without changing libdbus (or using
another library like ell/systemd-bus*) what we can do is to force
sealing the message when there's an invalidated property to be sent,
or....  if there's a changed property to be sent, but pending
invalidated properties already.

Lucas De Marchi

* I'm not sure if they provide such a thing though.
