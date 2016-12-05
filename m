Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1480961459.2818.49.camel@gentoo.org>
Subject: Re: bluez-5.43: symlink needed for sending files through bluez when
 dbus+user-session is used
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Mon, 05 Dec 2016 19:10:59 +0100
In-Reply-To: <1480960940.2818.47.camel@gentoo.org>
References: <1480960940.2818.47.camel@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El lun, 05-12-2016 a las 19:02 +0100, Pacho Ramos escribió:
> This is an issue we are hitting in Gentoo for a long time:
> https://bugs.gentoo.org/show_bug.cgi?id=577842
> 
> Only when dbus is compiled with user-session support. It seems
> ArchLinux is also suffering this bug:
> https://bugs.archlinux.org/task/45816
> 
> In summary, if we don't manually do this link:
> ln -fs /usr/lib/systemd/user/obex.service /usr/lib/systemd/user/dbus-
> org.bluez.obex.service
> 
> systemd cannot launch obexd when needed and, hence, sending files
> fails
> silently (as opposed to dbus without user-session, that was able to
> launch obexd when needed).
> 
> Then, I am not sure if this link should be provided always or if we
> have something missing in bluez.service file that, even enabling it,
> is
> not enough for "fully" enabling bluetooth (as it seems obexd is not
> handled at all)
> 
> Thanks a lot for your help

And ever more instances of the problem:
https://bugzilla.redhat.com/show_bug.cgi?id=1318441
https://bugzilla.redhat.com/show_bug.cgi?id=1389347 (this points to
gnome-control-center... but the issue is more deep as other packages
like bluedevil and likely anything willing to send files would be
affected too)
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=804908

