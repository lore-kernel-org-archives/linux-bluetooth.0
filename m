Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41AB96DF.4080405@zhwin.ch>
From: Marco Trudel <trudemar@zhwin.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] RE[2]: inquiry scan problems
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
Date: Mon, 29 Nov 2004 22:38:39 +0100

 > > [my description of the inquiry problems with java (jsr82)]
 > can your reproduce it without using any JSR-82 stuff?

yes. i tried the inquiries with "hcitool scan".
again, i do 5 and more inquiries in a row with one second sleep between 
inquiries single "hcitool scan"'s...

here what i noted:
- it needs in average 4 inquiries to get a new device after it's in 
rainge (4 single "hcitool scan" until it's visible).
- it needs in average 2 inquiries to see that a device is no longer in 
rainge (or has bluetooth disabled). the first new inquiry usually gives 
"n/a" as the friendlyName, the second one doesn't list it again.
does maybe bluez or my bluetooth dongle cache old inquiries or is there 
still radiation in the air :-) ?

- during scans, if nothin changes (no new/disappeared devices), the 
friendlyName changes to n/a for a single inquiry (very rare, but it happens)

- if multiple new devices come in rainge, old devices migt have a n/a 
friendlyName (the right one comes back in the next scan)


thanks for your time...

kind regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
