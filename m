Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121004141722.GA4173@x220>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com> <20121004141722.GA4173@x220>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 4 Oct 2012 11:29:01 -0300
Message-ID: <CAKi4VALefFdx=omzNhY96-Ha4uPZN7n3m_Pu5NomDD5rNeU9eA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 00/15] Properties + ObjectManager
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 4, 2012 at 11:17 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lucas,
>
> On Thu, Oct 04, 2012, Lucas De Marchi wrote:
>> Here is a rebased version of the patches. Most notable change is on patch
>> implementing the Set() method after feedback from Marcel. It doesn't cover the
>> concerns from Luiz about checking privileges per-property since I think this
>> could be added in a separate patch. As far as I could see the only user is
>> MediaTransport interface. The most obvious way would be to add another hook in
>> GDBusPropertyTable in order to check the privileges. Suggestions?
>>
>> First 2 patches could be applied nonetheles. Get and GetAll are well tested,
>> both now and in the previous version of this patch set. Set() is still a
>> bit raw - the users implementing it are very big (adapter, device) so
>> they are not converted yet (previous patch doesn't apply anymore and there's a
>> change in the API that requires them to be rewritten).
>>
>>
>> Lucas De Marchi (10):
>>   gdbus: Move typedefs up
>>   gdbus: Use macros to add annotations
>>   gdbus: Add skeleton of DBus.Properties interface
>>   gdbus: Implement DBus.Properties.Get method
>>   gdbus: Implement DBus.Properties.GetAll method
>>   gdbus: Implement DBus.Properties.Set method
>>   gdbus: Add properties into Introspectable interface
>>   gdbus: Implement PropertiesChanged signal
>>   Use DBus.Properties on Control interface
>>   Use DBus.Properties on Manager interface
>>
>> Luiz Augusto von Dentz (5):
>>   gdbus: Add support for org.freedesktop.DBus.ObjectManager interface
>>   gdbus: Group interface changes to reduce the amount of signals
>>     emitted
>>   gdbus: Only export ObjectManager interface on root path
>>   gdbus: Integrates ObjectManager with Properties interface
>>   gdbus: Simplify code for appending properties
>>
>>  audio/control.c |  57 ++--
>>  gdbus/gdbus.h   |  74 +++--
>>  gdbus/object.c  | 867 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>  src/manager.c   |  81 ++----
>>  4 files changed, 897 insertions(+), 182 deletions(-)
>
> This initial set has been applied. Now let's get testing it and fix any
> pending issues that are found. Also please remember send the adapter and
> device conversions when you've got them ready so that we get them stress
> tested at the UPF next week.

Thanks... I'll submit them soonish.

Should we change the interface names to include a version, too? Or
change the bus name to something like bluez5?

"It is also a good idea to include the major version of the interface
in the name, and increment it if incompatible changes are made; this
way, a single object can implement several versions of an interface in
parallel, if necessary." from
http://dbus.freedesktop.org/doc/dbus-specification.html


Lucas De Marchi
