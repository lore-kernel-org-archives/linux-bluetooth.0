Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040921202342.64392.qmail@web53201.mail.yahoo.com>
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20040921190606.GA11925@cirrus.madduck.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] suse9.1personal and bluetooth modprobe
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
Date: Tue, 21 Sep 2004 13:23:42 -0700 (PDT)

Hi all,
I'm new to linux and to bluetooth
and I installed the suse 9.1 personal distro.

the command
modprobe -l | grep bluez
does not report nothing

so I think that there isn't any bluetooth support

but the command 
modprobe -l | grep bluetooth
report a lot of voices
and from the console (if I remember) I can start bt,
so my phone (a Nokia 6600) can see my pc

this mean that there is something ... but what?
if I try hciconfig or hciid or hciemu the system
doesn't recognize the command

have I to install the bluez rpm modules?
or I'm ready to use and develop with bt? (i think no)

thanks


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
