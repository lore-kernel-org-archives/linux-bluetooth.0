Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20041125064110.GA2505@frostnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Chris Frost <chris@frostnet.net>
Subject: [Bluez-users] Pairing a keyboard
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
Date: Wed, 24 Nov 2004 22:41:10 -0800

When trying to pair with an apple wireless keyboard, hcitool cc errors
"Can't create connection: Input/output error". I was hoping someone
might have a suggestion on what to look into.

The details:
I'm kernel 2.6.9-mh4 and bluez 2.11 on an x86 with a D-Link DBT-120.
After starting hcid I run "hcitool cc <addr>" and get the error above.
I've included "hcidump -x"'s transcript at the bottom of this email.
bluepin does not work on my installation (pygtk seems broken), so I wrote
a script to echo "0000" to stdout. This may well be my problem? I do not know
if this is the format hcid is expecting or if it is the initial pin apple
sets. I did read that the mouse uses this pin, this is the only reason for
my choice. For my hcid.conf file, security is auto, pin_helper is set to this
script, and auth and encrypt are commented out.

I am able "hcitool scan" to see the keyboard. I'm also able to pair with
an ericsson phone. The phone, however, may not use a pin?


hcidump output:

< HCI Command: Create Connection (0x01|0x0005) plen 13
  4B 9A 3B 95 0A 00 18 CC 02 00 00 00 01 
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04 
> HCI Event: PIN Code Request (0x16) plen 6
  4B 9A 3B 95 0A 00 
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  4B 9A 3B 95 0A 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0E 04 00 4B 9A 3B 95 0A 00 
> HCI Event: Connect Complete (0x03) plen 11
  18 29 00 4B 9A 3B 95 0A 00 01 00 


thanks for any suggestions or pointers!
-- 
Chris Frost  |  <http://www.frostnet.net/chris/>
-------------+----------------------------------
Public PGP Key:
   Email chris@frostnet.net with the subject "retrieve pgp key"
   or visit <http://www.frostnet.net/chris/about/pgp_key.phtml>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
