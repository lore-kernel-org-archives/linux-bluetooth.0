Return-Path: <hidave.darkstar@gmail.com>
Message-ID: <a8e1da0711291852t4207f742sbd49dcda838c47c7@mail.gmail.com>
Date: Fri, 30 Nov 2007 10:52:50 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-users] hcitool scan returns wrong bdaddr
Cc: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <B7DDE0E9-17B7-4980-9405-906ED5F56900@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4745D9EE.4020101@uni-koeln.de> <4749FAD6.6080403@uni-koeln.de>
	 <1196055526.4217.44.camel@aeonflux> <474AA430.6010307@uni-koeln.de>
	 <1196080043.17196.4.camel@aeonflux> <474B110A.7000804@uni-koeln.de>
	 <a8e1da0711282343v4397e754qbcedf9f67c94499a@mail.gmail.com>
	 <B7DDE0E9-17B7-4980-9405-906ED5F56900@holtmann.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Nov 30, 2007 4:19 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Dave,
>
>
> >> I found the 3.21 tarball, thanks. Unfortunately the error still
> >> occurs
> >> with the resulting  libbluetooth.so.2.9.1. Because of the output from
> >> ldd, I'm sure that hcitool is linked against the "right" lib. So
> >> the Bug
> >> must be in 3.21 too, or there is an completely different Problem as I
> >> assume, because of the same behavior with libbluetooth.so.2.9.0 from
> >> debian lenny, and because you told me that it should work with an D-
> >> Bus
> >> API, which is installed.
> >> So perhaps the Problem is rooted in my D-Bus setup. I installed it
> >> from
> >> the debian repository and thought it should work without any further
> >> configurations.
> >> I'll search for it,
> >> thank you very much for your time and help,
> >
> > Maybe the Dbus api works for you, but the problem with hcitool is
> > still there.
> >
> > If you could build the bluez-utils/lib with -g and debug the hcitool,
> > you might get the answer then.
>
> don't worry. I fixed that already. It was a stupid thinko on my side.

Thanks :)
