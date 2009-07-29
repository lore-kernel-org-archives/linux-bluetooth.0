Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5d223510907290542oe6fc98fr3c0e0844cdbd3ac5@mail.gmail.com>
References: <5d223510907290542oe6fc98fr3c0e0844cdbd3ac5@mail.gmail.com>
Date: Wed, 29 Jul 2009 11:33:19 -0300
Message-ID: <5d223510907290733w62e4b778jf99b75ae2a82a376@mail.gmail.com>
Subject: Re: Obex with no X
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 29, 2009 at 9:42 AM, Rafael Seste<rseste@gmail.com> wrote:
> Hi all,
>
> I'm trying to use obex to retrieve the contacts from my mobile using PBAP.
> In the test folder I'm only able to run obex-test and it retrieves all
> contacts from my mobile. But I would like to use the python scripts
> and they aren't working.
> I'm running it with bluez 4.42 and kernel 2.6.30 without the X
> installed, I installed libopenobex from ubuntu repo.
>
> When I ran pbab-client the output was:
>
> dbus.exceptions.DBusException:
> org.freedesktop.DBus.Error.Spawn.ExecFailed: dbus-launch failed to
> autolaunch D-Bus session: Autolaunch error: X11 initialization failed.
>
> Googling  I found that SeesionDbus() need the X installed. So I
> changed to SystemDbus(). I don't know if this is right.
> After the output was:
>
> dbus.exceptions.DBusException:
> org.freedesktop.DBus.Error.Spawn.FileInvalid: Cannot do system-bus
> activation with no user
>
> So I added to the file /usr/share/dbus-1/system-services/obex-client.service
> "User=root"
>
> and the error changed again
>
> dbus.exceptions.DBusException:
> org.freedesktop.DBus.Error.Spawn.FailedToSetup: Failed to setup
> environment correctly
>
>
> Is it possible to run obex with dbus with the X installed?
 Sorry, I mean __without__ X installed!!!!

> If so, what am I doing wrong? or what is missing?
>
> thanks in advance
>
> --
> Rafael S. Seste
>



-- 
Rafael S. Seste
