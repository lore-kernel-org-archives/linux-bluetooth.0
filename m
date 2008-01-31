Return-Path: <cyrus@holtmann.org>
From: Brian Sammon <bluez-users@brisammon.fastmail.fm>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <200801292219.m0TMJw9k011646@alumnus.caltech.edu> 
References: <200801292219.m0TMJw9k011646@alumnus.caltech.edu>
Mime-Version: 1.0
Date: Wed, 30 Jan 2008 23:08:16 -0500
Message-Id: <E1JKQin-000806-Qm@necz1>
Subject: Re: [Bluez-users] registering a passkey agent with hcid
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

> 	I can't bond to my headset.  If I run hcid with debug output I see:
> 	call_passkey_agent(): no agent available
> 
> when I try to make a connection.  It seems I have no passkey agent.  I
> notice that bluez-utils builds 'passkey-agent' in /daemon but doesn't
> install it.  When I put passkey-agent in the path with the rest of the
> bluez-utils executables it still isn't found.  How do I make hcid find
> the passkey agent?

Well, if it works like the gnome passkey agent, you just run it, and it 
registers itself.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
