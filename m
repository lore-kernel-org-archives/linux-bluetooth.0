Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040630112137.GE30504@hp.com>
References: <20040630112137.GE30504@hp.com>
Content-Type: text/plain
Message-Id: <1088595657.4540.19.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 30 Jun 2004 13:40:57 +0200

Hi James,

> Problem: connection via bnep0 eventually freezes, and one of the two
> hosts displays in dmesg;
> 
> hci_acl_tx_to: hci0 ACL tx timeout
> hci_acl_tx_to: hci0 killing stalled ACL connection F5:E5:01:72:02:00
> 
> What does this mean?  Is there something I can do to prevent it?  Or
> something I can do to gather more information to help explain it?
> 
> I've been experimenting with a couple of USB modules, establishing
> connections with pand and routing laptop to gateway IP traffic over
> bnep0.
> 
> Some months ago, I had tried the same thing, but with 2.4.24.  The "ACL
> tx timeout" would occur generally within ten minutes if lots of data was
> transferred.  Now I'm trying it with 2.6.6, and it had been working fine
> for many hours before it happened again, with no heavy data transfer.
> 
> I've reviewed kernel ChangeLog-2.6.7 for each of the Bluetooth or BlueZ
> changes, but none of the changes seem to cover this problem.  I've
> surfed Google for "ACL tx timeout", but nothing springs up as a
> solution.

I can't give you a definitv answer for that problem, but it seems that
some Bluetooth dongles are not working very nice under heavy load. This
is actually not a chip problem, because I saw chips working in one
dongle and in another one it produces such timeouts.

You can of course try to increase the ACL tx timeout and see if it still
occurs. Do all of your dongles use the same Bluetooth chip?

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
