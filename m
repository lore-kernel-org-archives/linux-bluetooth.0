Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opseq1blhheocfdv@debian>
Subject: [Bluez-users] automatic bnep0 configuration
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
Date: Thu, 23 Sep 2004 00:12:47 +0200

Hello List,

I wonder if there is a way to automatically set up and
configure the bnep0 device that comes into existing after
a pand connection was set up. At the moment I create the
connection and do 'ifconfig bnep0 10.10.0.5'.
But when setting up something like a server you normally
can't do this ifconfig by hand.

I tried to configure this with /etc/network/interfaces
but that didn't help. I also tried to set 'auto bnep0'
but this only works at boot time, when the device is
not there yet.
What's the trick?

By the way: thanks for all the previous help, already :-)

-- 
Regards,
Christoph


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
