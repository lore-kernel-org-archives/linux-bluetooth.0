Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100907291046v5f9ba227oe8e113c667c7ab29@mail.gmail.com>
References: <5d223510907290542oe6fc98fr3c0e0844cdbd3ac5@mail.gmail.com>
	 <2d5a2c100907291046v5f9ba227oe8e113c667c7ab29@mail.gmail.com>
Date: Wed, 29 Jul 2009 16:28:57 -0300
Message-ID: <5d223510907291228u11ad1b94xbb132d1e60a028ae@mail.gmail.com>
Subject: Re: Obex with no X
From: Rafael Seste <rseste@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 29, 2009 at 2:46 PM, Luiz Augusto von
Dentz<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Wed, Jul 29, 2009 at 9:42 AM, Rafael Seste<rseste@gmail.com> wrote:
>> Hi all,
>>
>> I'm trying to use obex to retrieve the contacts from my mobile using PBAP.
>> In the test folder I'm only able to run obex-test and it retrieves all
>> contacts from my mobile. But I would like to use the python scripts
>> and they aren't working.
>> I'm running it with bluez 4.42 and kernel 2.6.30 without the X
>> installed, I installed libopenobex from ubuntu repo.
>>
>> When I ran pbab-client the output was:
>>
>> dbus.exceptions.DBusException:
>> org.freedesktop.DBus.Error.Spawn.ExecFailed: dbus-launch failed to
>> autolaunch D-Bus session: Autolaunch error: X11 initialization failed.
>
> I don't think buses really depend on X, what happen is that normally a
> session bus created by login. Please take a look at man page of
> dbus-launch the section AUTOMATIC LAUNCHING seems to tell about the
> relation of X and --autolaunch.

I read the man page and found that the environment variable
DBUS_SESSION_BUS_ADDRESS is not exported.
I exported it with the same value from ~/.dbus/session-bus/ but it
still does not work. I got this error

dbus.exceptions.DBusException: org.freedesktop.DBus.Error.NoServer:
Failed to connect to socket /tmp/dbus-EtKMcBkowv: Connection refused

>
> OTOH it shouldn't be difficult to have obexd on system bus so you
> wouldn't have to bother creating an session exclusively for obexd.

Could you help me with that? I don't know much about dbus.

I changed to system bus and got an error;
Cannot do system-bus activation with no user

>
> Regards,
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computação
>

Regards,

-- 
Rafael S. Seste
