Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: [Bluez-devel] rfcomm patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Huang <alanh@tuks.co.za>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1068150549.3faaaf153cd2c@student.up.ac.za>
References: <200311050945.34166.sybren@thirdtower.com>
	 <004101c3a3b4$81f42dd0$dc01a8c0@alan> <1068107961.1284.123.camel@pegasus>
	 <1068150549.3faaaf153cd2c@student.up.ac.za>
Content-Type: text/plain
Message-Id: <1068162278.25167.85.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 07 Nov 2003 00:44:39 +0100

Hi Alan,

>   Thanks again Marcel, for your reply! Can you tell me a bit more how to 
> switch to raw terminal mode? Does it mean that I'll have to skip the bind 
> action and directly connect after I created the socket?

look at the code ;) And the raw stuff is only for TTY terminals and the
RFCOMM emulation of it. If you connect through a socket you won't have
problems with it.

> Hmm... it really seems like I should enhance my socket programming 
> knowledge...Any good online guides/tuts or books anyone can recommend ;-)

The source code of any socket based program ;)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
