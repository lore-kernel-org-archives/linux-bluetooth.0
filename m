Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6b9433067232482188eacf03ac09d44e@FE-MBX1011.de.bosch.com>
References: <6b9433067232482188eacf03ac09d44e@FE-MBX1011.de.bosch.com>
Date: Fri, 15 Jan 2016 16:14:34 +0200
Message-ID: <CABBYNZ+dGC5mv_AyNeHE4GD4NvkcxOByh0Gz5Fj_HvgZKEHA5A@mail.gmail.com>
Subject: Re: DBUS GATT API via gio - Parsing results of GetManagedObjects fails
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

On Fri, Jan 15, 2016 at 9:24 AM, Kasper Markus (ETAS-PSC/ECE1)
<Markus.Kasper@escrypt.com> wrote:
> Hi,
>
> it seems I‘m among the first users out there using the dbus API for implementing a GATT server via C & gio & gdbus-codegen.
> So first thanks to Luiz for the recent patch and the new great RegisterApp API, which solved some trouble with gio and the contradicting hierarchy requirements for the ObjectManager.
>        I’m using a rather recent checkout of the git.
> Unfortunately I ran into another problem with dbus incompatibilities: When registering an application the gdbus/client.c parses the interfaces and adds proxies based on the results of a GetManagedObjects call.
>
> What happens for me is that the gio implementation does not return the objects in the order I added them, but instead (for whatever reason) in some other order. In my case I get the order
>
> service0/char0
> service0
> service0/char1
>
> Instead of
>
> service0
> service0/char0
> service0/char1.

I bet this is because of the use of hash table by your binding, this
would be fine if the objects don't have a relationship between
themselves.

> When parsing/adding interfaces the order of the objects returned from the GetManagedObjects call is preserved. Thus instead of first adding the service and then adding the characteristics,
> the current implementation starts adding a characteristic and then fails registering the server because the corresponding service is still missing. I expect similar issues with “out of order” descriptors, but did not test it.
> I also didn’t test “shuffling” objects within the Python example-gatt-server, but this should most likely be the fastest way to reproduce the problem and test solutions.

I actually had to fix this with use of OrderedDict to make sure the
order of objects is maintained so we can parse in a single pass the
objects.

> At the end of the day for best interoperability I suggest to avoid relying on the order of the GetManagedObjects reply in bluez, but instead aim for a robust parsing.

It is a bit ridiculous since it is probably easier to implement with a
list and maintain the order as seen in InterfaceAdded, but I have to
agree that we can't rely on the peer to make this easier for us.

> I’m actually not sure what would be the best place and method to fix this. Patching within gdbus/client.c would be quite easy, but I think the dbus implementation shouldn’t care about application requirements. Fixing within the gatt-database.c would most likely be a bit cleaner, but requires (at least at a first glance) moving towards some approach where we first register all interfaces and ignore all errors, and then do a consistency check of the hierarchy afterwards, when all is done.

Yep, we will have to store the proxies and later process them on
ready, so it becomes a little more complex.

>
> Another smaller issue I stumbled upon is the requirement to call RegisterApplication asynchronously to allow for answering the calls to the object manager. While this might be a natural thing for experienced DBUS developers I feel it would help beginners to mention this within the docs (= it would have saved me some hours of debugging).

Most IPC are asynchronous, actually the fact that you notice it and
learn is probably much more valuable than it simple magically working
since the later would mean the IPC library is creating a thread behind
your back which can cause a lot more problems for you.

>
> Thanks for your great efforts on maintaining and extending Bluez.
>
> Btw: is there a good motivation for using strings instead of intergers/enums within the DBUS API (e.g. flags)? I recently read http://dbus.freedesktop.org/doc/dbus-api-design.html and would love to see some of the suggestions being mapped to the API before it leaves experimental status.

D-Bus has integers but not enums as the document seems to suggest, C
enums are integers but you can associate with a symbol at least,
besides it is a lot easier to understand a string than integers with
things like d-feet and dbus-monitor.

-- 
Luiz Augusto von Dentz
