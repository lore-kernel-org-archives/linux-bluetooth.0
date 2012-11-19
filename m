Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ79UfsU9=ejGSEBGueca1FJouKt15LpukEy6TtK+QFYg@mail.gmail.com>
References: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
 <1353314786-11427-2-git-send-email-luiz.dentz@gmail.com> <CAMOw1v7Y3EORhpSyydjhieG4Owx=0d5QAp=G66RweF7-cCshXQ@mail.gmail.com>
 <CABBYNZJ79UfsU9=ejGSEBGueca1FJouKt15LpukEy6TtK+QFYg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 19 Nov 2012 11:18:37 -0200
Message-ID: <CAMOw1v43vHHseyKKXK6t2sooS6dFkQdwbF4nOcCUGojpgbmGzQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] gdbus: Automatically register '/' path
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 19, 2012 at 10:49 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Mon, Nov 19, 2012 at 2:06 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> Hi Luiz,
>>
>> On Mon, Nov 19, 2012 at 6:46 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> This makes g_dbus_setup_bus to automatically register '/' path so
>>> user application that don't export any interface on '/' will have it
>>> registered for ObjectManager.
>>>
>>> Note that it is now required to call g_dbus_close before exit.
>>
>> I'm no really fan of this. Why do we need to register '/' now?  If we
>> are not going to support ObjectManager interfaces in subtrees, it
>> would be easier to just move the ObjectManager to the shortest path
>> registered rather than always registering '/'.
>
> Maybe I should have made clear this in the description, if you look at
> the spec it suggest that each sub-tree root should implement
> ObjectManager, the current implementation does that but if you think
> about it probably doesn't make sense to have sub-trees because that
> would creates extra round trips that ObjectManager was meant to

HUmn... I think you are a bit confused now.

1 entire tree can be managed by a single ObjectManager, or multiple
ones if there are objects that are not interesting to everybody and
only a few types of clients would be interested in the objects changed
beyond that path.

Example:

/org/bluez
  - ObjectManager
/org/bluez/adapter/bla/bli
  - MyInterfaceWithLotsOfObjects

If you put only 1 ObjectManager it means you get called for each
change in /org/bluez/adapter/bla/bli even though most of the clients
will not be interested in that. Therefore the spec allows you to
attach another ObjectManager in /org/bluez/adapter/[...]  so the first
ObjectManager only send updates and "manage" the objects until the
path containing another ObjectManager.

I do think we don't really need that feature right now. I think we are
fine with a single ObjectManager in "/", but always registering "/"
IMO is not the right solution.

> prevent, also Im not completely sure now but I remember someone
> mentioning the '/' is kind special and should always be available no
> matter what, so by registering '/' directly on g_dbus_setup_bus we
> guarantee we have it always and that no sub-tree is going to be
> generated since '/' is the root no matter what path the user code
> register.

Kind of true... what really needs to be treated are calls to
Introspectable interface on "/". This is used by tools like d-feet to
navigate the tree (looking for the "<node ...>" tags) -- I *think*
this is also used by some bindings like python's. If you look in other
projects around, they prefer using the project's namespace rather than
"/"  (examples: systemd, udisks, policykit, dconf).

So, if we register "/", but not an Introspectable interface in there,
it means we will break tools like d-feet. If we don't register it,
libdbus will handle the messages to Introspectable (this is why other
projects don't even bother about "/").


Lucas De Marchi
