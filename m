Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349374268.27233.38.camel@aeonflux>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
 <20121004141722.GA4173@x220> <CAKi4VALefFdx=omzNhY96-Ha4uPZN7n3m_Pu5NomDD5rNeU9eA@mail.gmail.com>
 <1349374268.27233.38.camel@aeonflux>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 4 Oct 2012 15:27:18 -0300
Message-ID: <CAKi4VA+KNR4zD4V4z6PQokDXnHQ15Re-RzoTkL6dC5xDwuKSPA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 00/15] Properties + ObjectManager
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 4, 2012 at 3:11 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lucas,
>
>> >> Here is a rebased version of the patches. Most notable change is on patch
>> >> implementing the Set() method after feedback from Marcel. It doesn't cover the
>> >> concerns from Luiz about checking privileges per-property since I think this
>> >> could be added in a separate patch. As far as I could see the only user is
>> >> MediaTransport interface. The most obvious way would be to add another hook in
>> >> GDBusPropertyTable in order to check the privileges. Suggestions?
>> >>
>> >> First 2 patches could be applied nonetheles. Get and GetAll are well tested,
>> >> both now and in the previous version of this patch set. Set() is still a
>> >> bit raw - the users implementing it are very big (adapter, device) so
>> >> they are not converted yet (previous patch doesn't apply anymore and there's a
>> >> change in the API that requires them to be rewritten).
>> >>
>> >>
>> >> Lucas De Marchi (10):
>> >>   gdbus: Move typedefs up
>> >>   gdbus: Use macros to add annotations
>> >>   gdbus: Add skeleton of DBus.Properties interface
>> >>   gdbus: Implement DBus.Properties.Get method
>> >>   gdbus: Implement DBus.Properties.GetAll method
>> >>   gdbus: Implement DBus.Properties.Set method
>> >>   gdbus: Add properties into Introspectable interface
>> >>   gdbus: Implement PropertiesChanged signal
>> >>   Use DBus.Properties on Control interface
>> >>   Use DBus.Properties on Manager interface
>> >>
>> >> Luiz Augusto von Dentz (5):
>> >>   gdbus: Add support for org.freedesktop.DBus.ObjectManager interface
>> >>   gdbus: Group interface changes to reduce the amount of signals
>> >>     emitted
>> >>   gdbus: Only export ObjectManager interface on root path
>> >>   gdbus: Integrates ObjectManager with Properties interface
>> >>   gdbus: Simplify code for appending properties
>> >>
>> >>  audio/control.c |  57 ++--
>> >>  gdbus/gdbus.h   |  74 +++--
>> >>  gdbus/object.c  | 867 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>> >>  src/manager.c   |  81 ++----
>> >>  4 files changed, 897 insertions(+), 182 deletions(-)
>> >
>> > This initial set has been applied. Now let's get testing it and fix any
>> > pending issues that are found. Also please remember send the adapter and
>> > device conversions when you've got them ready so that we get them stress
>> > tested at the UPF next week.
>>
>> Thanks... I'll submit them soonish.
>>
>> Should we change the interface names to include a version, too? Or
>> change the bus name to something like bluez5?
>
> I am not in favor of that actually. Since this the reverse domain name.
> And we do not own bluez5.org and I am not planning to get a new domain
> name for every major release.
>
> We need to think about the versioning at some point, but maybe we leave
> that for BlueZ 6.x then. At some point we need to finish this one first.


Then if you are going to support both bluez4 and bluez5, there's no
way  at runtime to determine which backend to use.
We already suffered from that with connman, for example. But it had
not hit 1.0 so we couldn't do much.

Reverse domain name is just a convention, as is the major version
number. I'd prefer breaking the former convention rather than screwing
with the users or let them checking at compile time.

For example, I have this on my desktop:

org.freedesktop.PolicyKit1,
org.freedesktop.RealtimeKit1,
org.freedesktop.login1
org.freedesktop.systemd1
fi.w1.wpa_supplicant1

Do they all have these domains?

Another option is to go with subdomains: org.bluez.v5 ;-)

Lucas De Marchi
