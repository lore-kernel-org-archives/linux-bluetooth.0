Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: "Michal Semler (volny.cz)" <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031126140017.C25686@minotaur.apache.org>
References: <20031105093947.J63252@minotaur.apache.org>
	 <20031126131925.M25686@minotaur.apache.org>
	 <1069882659.9032.54.camel@pegasus> <200311262254.21024.cijoml@volny.cz>
	 <20031126140017.C25686@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1069884432.9032.65.camel@pegasus>
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
Date: Wed, 26 Nov 2003 23:07:12 +0100

Hi Gareth,

> 	I know the ping thing works, however I don't believe that it
> should be necessary. I think there is either something wrong with the
> hardware, bthid or bluez. If it is bthid or bluez then I would like to try
> and fix it so we can all benifit :)

look at my bthid code and see how I have handled it. This was working
for me. You need a sleep() and the correct order of closing the L2CAP
channels. Otherwise the ACL connection would not be terminated.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
