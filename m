Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050806030119.GA10008@as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Problem with link keys
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 5 Aug 2005 20:01:19 -0700

My previous problems getting my headset to work were due to stale link keys.
After deleting the old one, I could make a new pairing.  The problem is that
the *new* link key becomes useless as soon as I turn off the headset.

The procedure is something like this:
1) Turn on headset
2) Pair with PC
3) Enter PIN when asked
4) headset works fine
5) shut off headset
6) turn headset back on
7) hcitool commands targeted at the headset all fail with "input/output error"
   now.
8) Delete existing link key
9) Go back to step 2

Why does the link key go bad as soon as I power cycle the headset?  The
hcidump output from step 6 is:

> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11

I do not see any "reply negative" messages in any of the hcidump output yet it
doesn't work until I make a new key.

Am I doing something wrong or in the wrong order?  This is with the current
bluez packages from Debian unstable (amd64 port).


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
