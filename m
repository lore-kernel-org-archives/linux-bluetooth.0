Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300805291910n15430303r71fc22c0a1c689ca@mail.gmail.com>
Date: Thu, 29 May 2008 20:10:40 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <483F3DE8.5040807@magtech.com.au>
MIME-Version: 1.0
References: <1945.124.170.117.82.1212030264.squirrel@www.magtech.com.au>
	<a481fbf0805290401g57804562h34ef5147852256c9@mail.gmail.com>
	<483F3DE8.5040807@magtech.com.au>
Subject: Re: [Bluez-users] DUND pre-pppd script
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Aras

> I think that I can solve this problem by configuring dund to call a pppd
> wrapper which calculates the correct, non-colliding, subnet and then
> passed on the arguments to pppd.

although there is no way to coax dund to pass the remote btaddr
address on to a wrapper script, we should be able to figure it out.

tell dund to use the wrapper:
dund --pppd=mypppd ...

in the mypppd wrapper:
#!/bin/sh
BTADDR=`rfcomm show $2 | cut -d ' ' -f2`
# set LOCAL, REMOTE based on the BTADDR
pppd LOCAL:REMOTE $*

if dund were changed then the tty might no longer be on $2.
in my scenario at least, LOCAL would always be 0.0.0.0 and something
like /etc/ppp/ip-up.d/bridge would bridge pppX:

#!/bin/sh
# $2 is the ppp interface name
brctl addif pan0 $2

should be fun to see if any of this works :)

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
