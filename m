Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130424175650.GD11434@samus>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
 <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com>
 <20130419133459.GA7044@echo> <20130424135855.GA18679@x220>
 <CAMOw1v5ef6Uwx5t32pMhzzb4gurLuf+K9-iXJmgfdyCAGH+Wjg@mail.gmail.com> <20130424175650.GD11434@samus>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 24 Apr 2013 15:09:05 -0300
Message-ID: <CAMOw1v5jGPnmukDOjdGGUZ3k=aJqvyx97mw4Uk0owt=5K3ApfA@mail.gmail.com>
Subject: Re: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 24, 2013 at 2:56 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Lucas,
>
> On 14:33 Wed 24 Apr, Lucas De Marchi wrote:
>> On Wed, Apr 24, 2013 at 10:58 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> > Hi,
>> >
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
>> >> is abused, i.e. we know there's something very wrong if there's a flush
>> >> after each emit.
>> >
>> > Is this where the discussion got stuck? Since this feature is really
>> > only needed for quite exceptional situations if an API change needs to
>> > be done I'd be in favor of a separate flush function.
>> >
>> > Another option is to make *all* D-Bus messages that gdbus sends to use
>> > an idle callback, including method calls and returns. In the idle
>> > callback the messages would be sent in the same order as they were added
>> > to the send queue. This would not require any changes to the gdbus API.
>>
>>
>> ugh.. no. This doesn't play well with sending the message directly
>> through libdbus.
>>
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
> I understand the problem a little differently. To solve this problem in the
> general sense, I want the remote application to have an updated view of the
> device object before receiving the NewConnection() call.
>
> Having some properties (Paired and UUIDs) marked as immediate would only solve
> this particular problem.

if "Paired" is marked as IMMEDIATE, this would work fine:

g_dbus_emit_property_changed(conn, path, iface, "Paired");
dbus_message_send_with_reply(conn, msg, &pending, -1);


All properties set until now would be sent, and then the call to
NewConnection().

Lucas De Marchi
