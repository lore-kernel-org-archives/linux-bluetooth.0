Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFComm driver crash with MSI BToes USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Bilien <jobi@via.ecp.fr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040707142839.GA27973@via.ecp.fr>
References: <20040707130012.GC27586@via.ecp.fr>
	 <1089205824.4857.27.camel@pegasus>  <20040707142839.GA27973@via.ecp.fr>
Content-Type: text/plain
Message-Id: <1089210727.4857.37.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 07 Jul 2004 16:32:07 +0200

Hi Johan,

> > disable the preempt support and try again.
> 
> I did so, and it works. However, I'd prefer to have the pre-emptible
> kernel, is that fixed in a later version of the module?

please post your kernel config and try again with preempt enabled and
clean build of 2.6.7-mh1. And you should also try 2.6.7-bk20 to see if
the problem is already solved.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
