Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Issues with multiple (concurrent) rfcomm
	connections
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20050110T223207-471@post.gmane.org>
References: <loom.20050109T210055-110@post.gmane.org>
	 <1105305890.8637.5.camel@pegasus> <loom.20050110T223207-471@post.gmane.org>
Content-Type: text/plain
Message-Id: <1105438396.8056.9.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 11 Jan 2005 11:13:16 +0100

Hi George,

> you're right, 2.6.10-mh works fine; no problems and reasonably fast 
> reconnects after all kinds of reset, power loss, etc. Very well done!
> 
> also, it seems to be independent of SiW or CSR chip set... (changed the bt
> adapter too...)
> 
> Is there a chance to seperate this issue and have it back-ported to 2.4?

there are so many changes that are not backported to 2.4 and at the
moment I have to no idea which one will help you. Why don't you use a
2.6 kernel?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
