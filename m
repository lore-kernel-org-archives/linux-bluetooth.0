Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20040630112137.GE30504@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout
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
Date: Wed, 30 Jun 2004 21:21:37 +1000

Problem: connection via bnep0 eventually freezes, and one of the two
hosts displays in dmesg;

hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection F5:E5:01:72:02:00

What does this mean?  Is there something I can do to prevent it?  Or
something I can do to gather more information to help explain it?

I've been experimenting with a couple of USB modules, establishing
connections with pand and routing laptop to gateway IP traffic over
bnep0.

Some months ago, I had tried the same thing, but with 2.4.24.  The "ACL
tx timeout" would occur generally within ten minutes if lots of data was
transferred.  Now I'm trying it with 2.6.6, and it had been working fine
for many hours before it happened again, with no heavy data transfer.

I've reviewed kernel ChangeLog-2.6.7 for each of the Bluetooth or BlueZ
changes, but none of the changes seem to cover this problem.  I've
surfed Google for "ACL tx timeout", but nothing springs up as a
solution.

I'm using bluez-utils 2.7, and uhci_hcd.

-- 
James Cameron


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
