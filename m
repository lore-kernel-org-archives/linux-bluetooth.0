Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
Message-ID: <20040407214322.GA14396@magma.epfl.ch>
References: <20040407172325.GC9593@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040407172325.GC9593@magma.epfl.ch>
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
Date: Wed, 7 Apr 2004 23:43:22 +0200

Hello again,

I compiled 2.6.5-mm2 again, with all blutooth in, and now I can see my
bluetooth device ;-) I can also scan my Palm device.
I try http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html
and after dund --listen --persist --msdun call dun
I got the following error when I try to connect:
dund[3647]: RFCOMM TTY creation failed. Operation not supported(95)

If I lauch pppd before trying to connect:

pppd[3693]: pppd 2.4.1 started by root, uid 0
pppd[3693]: Using interface ppp0
pppd[3693]: Connect: ppp0 <--> /dev/pts/1
dund[3704]: RFCOMM TTY creation failed. Operation

pppd[3693]: LCP: timeout sending Config-Requests=20
pppd[3693]: Connection terminated.
pppd[3693]: Exit.

Any idea why? And how I could solve this issue?

Thank you very much,

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
