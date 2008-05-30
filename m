Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300805300851x77b16608g4ab85d7128adcd12@mail.gmail.com>
Date: Fri, 30 May 2008 09:51:18 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300805291910n15430303r71fc22c0a1c689ca@mail.gmail.com>
MIME-Version: 1.0
References: <1945.124.170.117.82.1212030264.squirrel@www.magtech.com.au>
	<a481fbf0805290401g57804562h34ef5147852256c9@mail.gmail.com>
	<483F3DE8.5040807@magtech.com.au>
	<d89ddf300805291910n15430303r71fc22c0a1c689ca@mail.gmail.com>
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

fwiw,

this does work with some mods since linux won't bridge ppp. you still
have to ipmasq the 192.168.42.0 subnet in this example... but the
mypppd script can be simplified to a sort of poor man's dhcp server.
(trim the leases if you ever really connect 255 devices over the
lifetime of the server :)

#!/bin/sh
LEASES=/var/run/mypppd.leases
grep -q $DUN_BDADDR $LEASES || echo $DUN_BDADDR >>$LEASES
LOCAL=192.168.32.10
REMOTE=192.168.42.`grep -n $DUN_BDADDR $LEASES | cut -d : -f1`
pppd $LOCAL:$REMOTE $*

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
