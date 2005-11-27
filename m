Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ian Miller <blue5@thetasig.fsnet.co.uk>
To: bluez-users@lists.sourceforge.net
Message-ID: <20051127175239.GA3911@janeway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] pairing Palm Vx (TDK Blue5) with Fedora Core 4 (FC4)
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
Date: Sun, 27 Nov 2005 17:52:39 +0000


Hi all,

Can anyone help me pair my Palm Vx (using a TDK Systems Blue5 attachment)
with FC4 (using a USB bluetooth dongle)?

I've followed the instructions up to step 6 on this page (but no further,
since I'm not interested yet in getting Internet access, I just want to
pair and transfer files over bluetooth):

	http://www.metacon.ca/bcs/view.php?page=bluetooth

I've got to the stage where I can see the linux box from the Palm, and 
I can see the Palm from the linux box, but I can't seem to work out 
how to get them to pair. 

When I select 'Pair' from the Palm menu, I get prompted for a Passkey,
and I give it the passkey in /etc/bluetooth/pin - but it always without
fail returns with either:

	Bluetooth connect failed (L2CAP error) (0x801E)
or
	Bluetooth timeout (0x803C)

I'm definitely giving it the right pin!

Any ideas? Rather than post a whole heap of diagnostic info that may
well be useless to you, I throw myself on the mercy of the list to 
suggest what diagnostics I should be supplying.

Is there any way to initiate the pair from the linux end?

cheers,
ian



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
