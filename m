Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040927191505.32405.qmail@web53202.mail.yahoo.com>
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
To: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>,
   bluez-users@lists.sourceforge.net
In-Reply-To: <20040926113702.53408.qmail@web53210.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] compiling bluez/obex (btobex)
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
Date: Mon, 27 Sep 2004 12:15:05 -0700 (PDT)

> the INSTALL document says to execute ./configure,
> but
> the file is not included.
OK, reading some documentation about autoconf I have
found that is needed to run aclocal before running
autoconf.
So now I have a file named configure obtained without
any error message.
Then I try to run it.
the response is that "install.sh is missing"
I can't find that file in the obex dir
I controlled in the CVS, but the file isn't there.
... In other dirs of bluez I can find several files
named install.sh that seems equals ...
So i copyed the file from the bluefw dir in the obex
dir.
Now I run again the ./configure and it writes several
messages, then stops his execution saying that
"config.h is missing"

... and now?
how can I resolve these stopping points?

PS be patient with me, I am at the first packages
compilation in linux

for jouni: thanks, I will try gnome-obex-send later



		
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
