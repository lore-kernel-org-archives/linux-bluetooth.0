Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <cone.1089163591.829830.5657.500@commodore.email-scan.com>
From: Sam Varshavchik <mrsam@courier-mta.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Subject: [Bluez-users] Trouble connecting to a Sony Ericsson T610 phone.
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
Date: Tue, 06 Jul 2004 21:26:31 -0400

I'm using a Belkin USB dongle to try to connect to my T610 phone.  I'm 
running bluez 2.5 on Fedora Core 2 x86_64.

"hcitool scan" does list the phone.  And the "Add New Device" option on the 
phone does show the PC, after a brief delay.  But if I tell the phone to go 
ahead and connect to the PC, enter a PIN, the phone spins for a while, then 
reports "Bluetooth connection failed" .  On the PC side nothing happens.

Trying it the other way around also fails.  "sdptool browse" reports an 
error: "Failed to connect to SDP server on 00:0A:D9:79:1B:B3: Connection 
timed out".  Nautilus does show an icon for the T610 (but only if I'm 
logged in as root) for "bluetooth:///", but either double-clicking on the 
icon, or dragging a file into it, reports an error saying that the device is 
read-only.  Meanwhile, the phone is not doing anything.

So the phone and PC can see each other, but are not talking.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
