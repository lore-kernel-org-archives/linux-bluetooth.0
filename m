Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <469E6A4A.4000804@krevsbech.dk>
References: <469E6A4A.4000804@krevsbech.dk>
Date: Thu, 19 Jul 2007 12:02:42 +0200
Message-Id: <1184839362.6357.29.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BNEP transferrate limitation?
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

Hi Kasper,

> Hey we are using BNEP as a part of our student project but we have 
> reached a limitation on the transfer speed of approx 8 KB/s. We have 
> tried to switch the hardware dongles but it is still the same. We have 
> another scheme where we use the L2CAP layer directly trough a socket 
> with the the BNEP profile. This gives the same limit. If we use the same 
> hardware dongles with a OBEX transfer we can reach much higher limitations.
> Therefore we would like to know if it is a known limitation on the BNEP 
> profile or if there is known limitations with some of the drivers.

there exists no such limitation. The BNEP support works perfectly fine
and you might have messed up the packet type settings. Don't modify
them, because BlueZ knows what to do.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
