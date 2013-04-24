Return-Path: <cyrus@holtmann.org>
From: "Amro Mouslli" <amro@clarus-llc.com>
To: "'Lucas De Marchi'" <lucas.demarchi@profusion.mobi>,
	"'Vinicius Costa Gomes'" <vinicius.gomes@openbossa.org>,
	"'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org> <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com> <20130419133459.GA7044@echo> <20130424135855.GA18679@x220> <CAMOw1v5ef6Uwx5t32pMhzzb4gurLuf+K9-iXJmgfdyCAGH+Wjg@mail.gmail.com> <20130424183600.GA29925@x220> <CAMOw1v5PS46KSTEb-7mEySpucEQqB19=iDwvGKSJ3CHKEdJ0Ow@mail.gmail.com>
In-Reply-To: <CAMOw1v5PS46KSTEb-7mEySpucEQqB19=iDwvGKSJ3CHKEdJ0Ow@mail.gmail.com>
Subject: RE: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
Date: Wed, 24 Apr 2013 13:14:24 -0700
Message-ID: <00a801ce4128$5121f400$f365dc00$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All , 

Any straight forward instructions on how to setup Bluetooth PAN on Ubuntu
server 11.04 ? it looks like there is no clear instruction for the new bluez
versions. 
Thank you 

Amro

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org
[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Lucas De Marchi
Sent: Wednesday, April 24, 2013 12:02 PM
To: Lucas De Marchi; Vinicius Costa Gomes; Luiz Augusto von Dentz;
linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] gdbus: Add g_dbus_flush_properties()

On Wed, Apr 24, 2013 at 3:36 PM, Johan Hedberg <johan.hedberg@gmail.com>
wrote:
> Hi Lucas,
>
> On Wed, Apr 24, 2013, Lucas De Marchi wrote:
>> > On Fri, Apr 19, 2013, Vinicius Costa Gomes wrote:
>> >> On 09:30 Fri 19 Apr, Luiz Augusto von Dentz wrote:
>> >> > What about creating a new flag for properties that need to emit a
>> >> > signal immediately when they change?
>> >>
>> >> That would also solve the problem.
>> >>
>> >> The way I see it, we should still not make any guarantees about when
>> >> a propery changed signal will be emitted, only when the API behaviour
>> >> requires, we use some kind of barrier to keep the ordering in check.
>> >>
>> >> And having a function to call we make it easier to detect when this
>> >> is abused, i.e. we know there's something very wrong if there's a
flush
>> >> after each emit.
>> >
>> > Is this where the discussion got stuck? Since this feature is really
>> > only needed for quite exceptional situations if an API change needs to
>> > be done I'd be in favor of a separate flush function.
>> >
>> > Another option is to make *all* D-Bus messages that gdbus sends to use
>> > an idle callback, including method calls and returns. In the idle
>> > callback the messages would be sent in the same order as they were
added
>> > to the send queue. This would not require any changes to the gdbus API.
>>
>> ugh.. no. This doesn't play well with sending the message directly
>> through libdbus.
>
> Is that something we really want to explicitly support instead of
> encouraging code to always use gdbus functions?

Unless we create a complete wrapper over libdbus functions that we
need, there's no encouraging thing here. It's just needed in some
places.


>
>> When we implemented the properties interface, the manner we talked
>> about doing this (if it was indeed needed) was mostly what Luiz is
>> saying now. I think I even sent a patch to this mailing list
>> containing this flag. You would add something like:
>>
>> G_DBUS_PROPERTY_FLAG_IMMEDIATE (or some better naming). Then
>> g_dbus_emit_property_changed() would check this flag, in which case
>> process_changes() would be called synchronously. I don't see why this
>> wouldn't solve your problem and it doesn't require an API change. For
>> the exceptional cases in which this is needed, we add such flag. And
>> if a property needs to be sent immediately in one place I think it
>> always will. Or am I missing something?
>
> The main point I was trying to present is that it would be nice if when
> you have code like:
>
>         foo();
>         bar();
>         baz();
>
> and each of those calls create a D-Bus message (property signal method
> call/return, etc) that needs to be sent, that you could count on the
> messages being sent in the same order that they happen in the code. This
> kind of intuitiveness would be nice to have regardless of whether we're
> dealing with a special case that really needs it or not.

Any of the proposed solutions do this. Your solution involves not
marking the special cases, but on the other hand makes the special
cases the default and needs some more working on gdbus to cover all
the uses of dbus_connection_send_*

I'm not saying it's not a good solution, bit I'm not sure it's the
best one neither.


Lucas De Marchi
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

