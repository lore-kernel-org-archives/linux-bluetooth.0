Return-Path: <cyrus@holtmann.org>
Date: Sun, 30 Sep 2012 13:56:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 01/10] battery: Add generic device battery
 documentation
Message-ID: <20120930105621.GA30560@x220.Elisa>
References: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
 <1348470919-25567-2-git-send-email-chen.ganir@ti.com>
 <20120928105937.GA14450@x220>
 <5067ED60.1080202@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5067ED60.1080202@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Sun, Sep 30, 2012, Chen Ganir wrote:
> >On Mon, Sep 24, 2012, chen.ganir@ti.com wrote:
> >>+BlueZ D-Bus Battery API description
> >>+****************************************
> >
> >Please keep the "underline" consistent with the length of the text above
> >it.
> >
> >>+	Texas Instruments, Inc. <chen.ganir@ti.com>
> >
> >What's this supposed to be? If you want a copyright statement here then
> >make it of the proper format. Author info is not needed as we have the
> >AUTHORS file and the commit history.
> >
> Would you please specify what is the proper copyright message format
> ? doc/adapter-api.txt, doc/health-api.txt have two different styles.
> doc/oob-api.txt has a third style (AUTHOR <author@email> for
> COMPANY),
> doc/media-api.txt for example does not have any copyright
> information. In addition - you say author information is not
> required, yet all other copyright messages contain this. Is this a
> new policy ? If so, please specify the proper copyright message.

How about git grep "Texas Instruments"? None of the entries contain
author information so your assertion makes it look like you didn't
really dig too deep. The policy has always been to keep author info in
AUTHORS and the commit history and have copyright statements only for
the sake of copyright information. Exceptions do of course slip through
as the maintainers are humans and not robots ;)

Ultimately you need to ask your employer for what kind of copyright
statement you should use, e.g. some prefer to have a "All rights
reserved" at the end whereas others don't care.

> >>+		array{object} Batteries [readonly]
> >
> >I guess you should mark this with [experimental] since it'll be removed
> >with the advent of ObjectManager.
> >
> What is the difference between the Batteries property and the
> services or UUIDs property in device-api.txt ? Should all of them
> get marked with experimental ?

The Services property will probably be removed for 5.0 but the UUIDs
will stay (not sure why you brought it up anyway?). Just mark this new
property as experimental since it'll likely be gone by the time 5.0 goes
out.

Johan
