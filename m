Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cvfgha$555$1@sea.gmane.org>
References: <20050222120541.95523.qmail@web26610.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <20050222120541.95523.qmail@web26610.mail.ukl.yahoo.com>
Subject: [Bluez-users] Re: Removing hcid daemon
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Feb 2005 15:48:33 +0100

Hi Benny,

not really sure if I got the point. I think this is no bluetooth
specific question at all!

 > but how could I remove daemons and how could I see
 > daemons that I'm runing and that use bluetooth module
 > such as hcid daemon?
Modules and daemons are two different things! Modules are part of the
kernel whereas daemons run in userspace.

`lsmod' shows the list of loaded modules

`ps' shows the running processes (including daemons...)

# ps ax | grep hcid
25252 ?        Ss     0:00 hcid: processing events
30706 pts/4    D+     0:00 grep hcid

To "remove" this daemon you have to send a kill signal.

# kill 25252

Use the PID (process id) you see on the output on your system.
For more info please have a look at the manpages! (man ps, man kill)

Best regards,
Sebastian






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
