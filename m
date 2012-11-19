Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+oP-2YarvFndGCrUeGAqb=Nt7CxQ=1ULasaRXqvRy68A@mail.gmail.com>
References: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
 <1353314786-11427-2-git-send-email-luiz.dentz@gmail.com> <CAMOw1v7Y3EORhpSyydjhieG4Owx=0d5QAp=G66RweF7-cCshXQ@mail.gmail.com>
 <CABBYNZJ79UfsU9=ejGSEBGueca1FJouKt15LpukEy6TtK+QFYg@mail.gmail.com>
 <CAMOw1v43vHHseyKKXK6t2sooS6dFkQdwbF4nOcCUGojpgbmGzQ@mail.gmail.com> <CABBYNZ+oP-2YarvFndGCrUeGAqb=Nt7CxQ=1ULasaRXqvRy68A@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 19 Nov 2012 13:38:03 -0200
Message-ID: <CAMOw1v4wXywKcjgNOJ+THM4SX6nwWs31GzSXhFA7V5USMzd_sg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] gdbus: Automatically register '/' path
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 19, 2012 at 1:08 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Mon, Nov 19, 2012 at 3:18 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> On Mon, Nov 19, 2012 at 10:49 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Lucas,
>>>
>>> On Mon, Nov 19, 2012 at 2:06 PM, Lucas De Marchi
>>> <lucas.demarchi@profusion.mobi> wrote:
>>>> Hi Luiz,
>>>>
>>>> On Mon, Nov 19, 2012 at 6:46 AM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>
>>>>> This makes g_dbus_setup_bus to automatically register '/' path so
>>>>> user application that don't export any interface on '/' will have it
>>>>> registered for ObjectManager.
>>>>>
>>>>> Note that it is now required to call g_dbus_close before exit.
>>>>
>>>> I'm no really fan of this. Why do we need to register '/' now?  If we
>>>> are not going to support ObjectManager interfaces in subtrees, it
>>>> would be easier to just move the ObjectManager to the shortest path
>>>> registered rather than always registering '/'.
>>>
>>> Maybe I should have made clear this in the description, if you look at
>>> the spec it suggest that each sub-tree root should implement
>>> ObjectManager, the current implementation does that but if you think
>>> about it probably doesn't make sense to have sub-trees because that
>>> would creates extra round trips that ObjectManager was meant to
>>
>> HUmn... I think you are a bit confused now.
>>
>> 1 entire tree can be managed by a single ObjectManager, or multiple
>> ones if there are objects that are not interesting to everybody and
>> only a few types of clients would be interested in the objects changed
>> beyond that path.
>>
>> Example:
>>
>> /org/bluez
>>   - ObjectManager
>> /org/bluez/adapter/bla/bli
>>   - MyInterfaceWithLotsOfObjects
>>
>> If you put only 1 ObjectManager it means you get called for each
>> change in /org/bluez/adapter/bla/bli even though most of the clients
>> will not be interested in that. Therefore the spec allows you to
>> attach another ObjectManager in /org/bluez/adapter/[...]  so the first
>> ObjectManager only send updates and "manage" the objects until the
>> path containing another ObjectManager.
>>
>> I do think we don't really need that feature right now. I think we are
>> fine with a single ObjectManager in "/", but always registering "/"
>> IMO is not the right solution.
>
> As far I know /org/bluez/adapter/bla/bli is a child of /org/bluez thus
> you don't need another ObjectManager, anyway the point is that

Sure we don't need it, but it was made that way so projects could
actually use multiple object managers for the reasons pointed out in
the previous email. Projects could even have separate ObjectManagers
for completely different things, like one in /org/bluez/bla and
another in /org/bluez/bli instead of 1 in /org/bluez. But it's an
application decision where to put the ObjectManager.

If all projects using gdbus decide to have a single ObjectManager on
"/" because it's simpler and fit the needs for everybody, then fine.
I'd suggest to even register it earlier than it is. Otherwise we might
choose to let the application (bluez, connman, ofono, etc) decide
where to put it, by adding a "g_dbus_attach_object_manager(conn,
path)" or the like.


> multiple ObjectManagers for the same connection might not make sense
> as it will create more round trips to discover the object tree e.g:
> /org/bluez vs /org/somethingelse

I'm not arguing about one object manager per object path component.

>
> There is also the problem of supporting changing the root, the spec
> doesn't mention anything about that even though it says it can support
> sub-trees thus the application could in theory register a new root
> e.g. /org at any point which basically invalidates the entire
> sub-trees which I don't think would be convenient for anyone watching
> it.

then it's a misuse of object manager by the application, not a problem
with the spec. We need to define in the API where the object
manager(s) will be and not randomly adding/removing them.

Lucas De Marchi
