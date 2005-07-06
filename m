Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2ping working only in one direction
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.63.0507060942310.7056@block.bubble>
References: <Pine.LNX.4.63.0507060905270.7056@block.bubble>
	 <Pine.LNX.4.63.0507060942310.7056@block.bubble>
Content-Type: text/plain
Message-Id: <1120638405.8967.2.camel@pegasus>
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
Date: Wed, 06 Jul 2005 10:26:45 +0200

Hi Florian,

> How is it determined which side will become master when both try
> to be? Just timing issues?

the side that creates the ACL connection is the master of the piconet by
definition. This can be changes after the piconet has been created. If
the create wants to stay as master and the acceptor mandats the role
switch to become master then this will be fail.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
