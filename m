Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200402170924.31121.jeffs@fairwayacademy.org>
Subject: [Bluez-users] Mysterious problem with l2test on Coldfire 5282
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
Date: Tue, 17 Feb 2004 09:24:31 -0500

Using the l2test program on Motorola 5282 (uClinux) I have a strange behaviour 
when using l2test -s from the Moto board.  Using the -d (dump) mode to 
receive packets from a PC running l2test I see what appears to be the packet 
sequence number in the first 4 bytes of data (little endian), followed by a 2 
byte packet length, then data payload.  When dumping data from the PC the 
packet sequence number increments by 1 each time, which, I believe, is the 
expected behaviour.  However, when sending from the Moto board to the PC, the 
packet sequence number increments by 4 each time. ?????  L2test send looks 
ok, the sequence number is just seq++; so something must be going on in hcid, 
right?  Or maybe it's dropping 3 out of 4 send packets for some reason.  
Maybe something cocked up with the socket ops in l2test?  ?????  Debugging 
pointers, please...

-Jeff
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
