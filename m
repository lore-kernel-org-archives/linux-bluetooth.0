Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Russell Neches <russell@ccs.neu.edu>
To: bluez-users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] crash on remove
Message-ID: <20040310223504.GA3398@omocha.vort.org>
References: <20040310182158.GA9279@naginata.ccs.neu.edu> <404F84BC.4020406@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <404F84BC.4020406@xmission.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 17:35:04 -0500

> >Every time I remove a bluetooth USB key from my desktop machine, I
> >get a hard lock. I'm running kernel 2.6.3 with no patches applied on
> >both systems. 
> 
> I also see something similar on 2.6.3-mh4. I think the only way I can
> safely remove a usb adapter is to stop the bluetooth daemons, force
> remove hci_usb (there always seems to be one reference pinning it down
> that I can't find), then unplug the adapter.

Do you have to do a force remove, or will it unload cleanly? I have
forced module unloading turned off in my kernel, which may be the cause
of my problem...

What do you mean by a "reference"? Does it claim to be in use when you
you rmmod it?

> I'm using a toshiba m200. The internal adapter is also USB so I think
> I have to do that before (ACPI-)suspending the laptop. I haven't tried
> the external since I got internal working. Lately either suspending or
> resuming crashes my machine so that may not be helping.

Yeah, I get crashes on resume too... Sigh. I never thought I would, but
I actually miss APM. The lack of APM support on my laptop has been a
never-ending headache.

Russell


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
