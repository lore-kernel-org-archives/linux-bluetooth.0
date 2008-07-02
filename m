Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0807020150p7fa242ecw724c38fa47b956dd@mail.gmail.com>
References: <3e9cdced0807020150p7fa242ecw724c38fa47b956dd@mail.gmail.com>
Date: Wed, 02 Jul 2008 11:12:38 +0200
Message-Id: <1214989958.11537.170.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] CancelBondingProcess -> Not authorized
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

Hi Fritz,

> Want to cancel a running bonding process by sending
> CancelBondingProcess.
> But as a reply I get Not authorized, unfortunately.
> What might be the problem (However, I'm root)? 

only the program (with the unique D-Bus bus id) can call this method.
Same as that we will cancel any attempt automatically if the caller
dies.

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
