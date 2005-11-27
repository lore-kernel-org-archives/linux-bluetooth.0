Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing Palm Vx (TDK Blue5) with Fedora Core 4
	(FC4)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051127175239.GA3911@janeway>
References: <20051127175239.GA3911@janeway>
Content-Type: text/plain
Message-Id: <1133116533.13629.9.camel@blade>
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
Date: Sun, 27 Nov 2005 19:35:33 +0100

Hi Ian,

> Can anyone help me pair my Palm Vx (using a TDK Systems Blue5 attachment)
> with FC4 (using a USB bluetooth dongle)?
> 
> I've followed the instructions up to step 6 on this page (but no further,
> since I'm not interested yet in getting Internet access, I just want to
> pair and transfer files over bluetooth):
> 
> 	http://www.metacon.ca/bcs/view.php?page=bluetooth
> 
> I've got to the stage where I can see the linux box from the Palm, and 
> I can see the Palm from the linux box, but I can't seem to work out 
> how to get them to pair. 
> 
> When I select 'Pair' from the Palm menu, I get prompted for a Passkey,
> and I give it the passkey in /etc/bluetooth/pin - but it always without
> fail returns with either:
> 
> 	Bluetooth connect failed (L2CAP error) (0x801E)
> or
> 	Bluetooth timeout (0x803C)
> 
> I'm definitely giving it the right pin!
> 
> Any ideas? Rather than post a whole heap of diagnostic info that may
> well be useless to you, I throw myself on the mercy of the list to 
> suggest what diagnostics I should be supplying.

run "hcidump -X -V" as root while trying to pair.

> Is there any way to initiate the pair from the linux end?

Yes, but in general Linux only pairs when needed. Send your data and if
pairing is needed the PIN will be requested.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
