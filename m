Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand freezes upon disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: bora@ai.com.tr
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1CABHg-0000WA-SN@paris.servershost.net>
References: <E1CABHg-0000WA-SN@paris.servershost.net>
Content-Type: text/plain
Message-Id: <1095876433.6223.79.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 22 Sep 2004 20:07:13 +0200

Hi,

> when i use sdpd && sdptool add NAP && pand -s -M --role NAP --autozap , 
> I search for bluetooth services from my WinXp client(with sp2).It finds 
> linux, and then connects and bla bla bla.So, what can be the problem, 
> why does linux freezes after windows disconnects????

it got a connection between the Windows machine and my Debian Laptop and
I don't see any freezes. The laptop keeps working.

And btw the command "sdptool add NAP" is not needed. The pand will
register the SDP service record by itself.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
