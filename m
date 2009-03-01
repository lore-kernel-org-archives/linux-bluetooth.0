Return-Path: <cyrus@holtmann.org>
Message-ID: <49AAEF55.7060303@powercraft.nl>
Date: Sun, 01 Mar 2009 21:25:57 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bnep networking with bluez-4
References: <200902282011.48655.alon.barlev@gmail.com>	 <20090228200342.GA19865@jh-x301> <9e0cf0bf0903011138i13124a07q9067c59ef20b397c@mail.gmail.com>
In-Reply-To: <9e0cf0bf0903011138i13124a07q9067c59ef20b397c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Alon Bar-Lev wrote:
> On Sat, Feb 28, 2009 at 10:03 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi,
>>
>> On Sat, Feb 28, 2009, Alon Bar-Lev wrote:
>>> I am sorry I post here, but there is no user mailing list specified at
>>> [1] while both links at [2] refer to this list. I will appreciate if
>>> you forward me to the right place.
>> Nope, as far as I understand this list is intended for both developer
>> and user issues.
> 
> Oh..
> """linux-bluetooth
> This mailing list is for the kernel developer."""
> 
> Needs an update :)
> 
> 
>>> I try to figure out how to create bnep interface. It looks like one
>>> should have vast knowledge in dbus
>> If you're a developer, then yes. If you're a user the interface has already
>> failed at the point where it requires you to know what "bnep" is :)
> 
> I think that you have incorrect view of users/integrators/sysadmins.
> There are many levels of complexity... One is to write something like
> bluz, and the other is to create a single working entity out of many
> components.
> So developer of one solution can be a user of the other, and
> sysadmin can be a user of many etc...
> 
> Imagin you are a sysadmin or a user of all solutions but bluez,
> and need to setup a working machine, if you don't have simple
> utilities you end up in being an expert in each of the components,
> or ends up with incomplete solution as you don't have enough time.
> 
> Back in the CORBA time, at least we had decent command-line interface
> so that I could enumerate, create and call methods. dbus failed
> to provide such interface for automation.
> 
> All I wanted is to connect two devices using bluez, using command-line.
> Using the basic layout, automation and no UI...
> 
> tun, ppp, bridge are all working great, providing decent command-line
> interface and no extra dependencies (dbus).
> 
>> As a user, you should ultimately be using some *user* interface (either
>> graphical or command line) which hides any complexities of the D-Bus
>> interface.
> 
> All I know is dbus-send, do you have any other tool?
> 
>> The big fault from the BlueZ project's side is that it hasn't
>> provided proper command-line user tools for its D-Bus interface. I think
>> one of the reasons for this is that the existing tools like hcitool and
>> hciconfig along with the python scripts that come with the source have
>> been regarded as "good enough".
> 
> Can you please point me to a script in source tarball to created bnep
> interface?
> 
>>> and/or python in order to achieve this goal.
>> Why especially python? There's a plethora of different language bindings
>> available for D-Bus. You can find a list of them here:
>> http://www.freedesktop.org/wiki/Software/DBusBindings
> 
> Again, there is a major difference between a simple script and starting
> dbus development. Why do I need to know dbus if I want to USE
> bluez? Well... I understand I need to start learning or just use
> PPP over rfcomm... At least I know how to set this up without
> dbus knowledge.
> 
>>> Does anyone has a sample without python dependency (shell script) that
>>> can create bnep interface on both ends for hidden (explicit mac) devices?
>> I'm not aware of any D-Bus binding for shell languages (like bash).
>> There's the generic dbus-send command line tool provided by D-Bus but it
>> won't get you very far with the more complex interfaces. Just out of
>> curiosity, what kind of system are you using that doesn't have python
>> available? Some embedded device perhaps? (in which case the border
>> between a user and developer starts to get quite blurred).
> 
> A user is a user of a component, he can be a developer of other software.
> Nothing blurred. I just wanted to know that I understand correctly and
> I need to develop my own software in order to use basic functionality.
> 
> I thought that like iproute2 support tan/tap it can support bnep and
> then all be happy :) But adding dbus dependency to core is not
> wise.
> 
>>> Alternatively, can anyone please tell me what is the uuid parameter
>>> for org.bluez::org.bluez.Network::Connect?
>> That's the Bluetooth UUID of the service you want to use. However the
>> interface will also accept "friendly" strings such as "nap" and "panu".
>> Admittedly doc/network-api.txt should be updated to list all of these
>> possibilities. It's much terse right now.
> 
> Can you please tell me what is the friendly string to set up bnep interface
> to a specific device?
> 
>>> Anyway... I think the requirement for people to use dbus is truly
>>> unusable...
>> I'll assume you mean "user" when you say "people". You're right of
>> course. The D-Bus interface was never intended for users. It was created
>> for developers to build user interfaces and while GUI's are out of scope
>> for the BlueZ project at least a command-line tool should be available
>> for users not wanting or being able to deal with GUI's.
> 
> Great... Need a sample... :)
> 
>>> Providing simple solutions/scripts for common tasks is required.
>> Agreed. Right now for many tasks you can use the legacy command line
>> tools and even the old daemons like pand if you wish. For the D-Bus
>> interface there are the python scripts within the source tree and in the
>> long run we should hopefully have a proper command line user tool for
>> the D-Bus interface.
> 
> I don't understand, I thought the pand is not needed anymore, no daemon
> is needed, right? Or I miss something. Anyway, most distribution do not
> install pand anymore...
> 
> Thank you,
> Alon.

Hi Alon,

Maybe this tool can help you for the gui side of your problems, yes I
know its no command-line tool but its the best I can do for you.

It's about the blueman tool:
http://lists.debian.org/debian-mentors/2009/02/msg00277.html
http://lists.debian.org/debian-mentors/2009/03/msg00004.html

I provide the link to the archive, because I sent some mail to the
thread. Maybe the bluez-gnome bluetooth-applet developers can read the
thread too and provide there opinion about the issues?

Best regards,

Jelle de Jong

