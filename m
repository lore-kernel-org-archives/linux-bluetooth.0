Return-Path: <edd@usefulinc.com>
Subject: Re: Release of new BlueZ libs and utils
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>,
   Stephen Crane <steve.crane@rococosoft.com>
In-Reply-To: <1071791711.6635.18.camel@pegasus>
References: <1071791711.6635.18.camel@pegasus>
Content-Type: text/plain
Message-Id: <1072989541.2634.154.camel@saag>
Mime-Version: 1.0
Date: Thu, 01 Jan 2004 20:39:02 +0000
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, 2003-12-18 at 23:55, Marcel Holtmann wrote:
> Hi Folks,
> 
> I don't wanna make big words about it, but after 8 months there are new
> releases of the BlueZ libs and utils packages.

I just uploaded these to Debian sid.  Sorry for the delay, but the
holiday season and the recent Debian break-in delayed me.

> For the BlueZ libs I don't plan another release, because the new major
> version of the Bluetooth library is making good progress. But for the
> BlueZ Utils I want to make another release that addresses the problems
> with the pin_helper program. I think the C based bluez-pin is a good
> idea and maybe we should also integrate the DBus support into the next
> release. So I like to get comments on this and if you have patches,
> please resend them.

For a while now the Debian packages have brought in the DBUS/GTK
bluez-pin implementation as the default, and I've had no complaints at
all. DBUS seems to be really catching on as the way to do things like
this.

-- Edd
