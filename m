Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] What's the best way to go about device detection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Rob Raper <djrobx@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY14-F3781Np7vXee40004099a@hotmail.com>
References: <BAY14-F3781Np7vXee40004099a@hotmail.com>
Content-Type: text/plain
Message-Id: <1084738824.4184.47.camel@pegasus>
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
Date: Sun, 16 May 2004 22:20:24 +0200

Hi Rob,

> Thanks for your reply.   I'll have a look into RSSI.   Is it 
> possible to use RSSI for detection, but then use RFCOMM to do the actual 
> communications?    Once "linked" to a server they don't ever need to talk to 
> multiple servers at the same time.  It's just that other servers need to 
> determine signal strength in order to decide when to perform a hand off.

this is what I said. The RSSI comes for free with an inquiry with RSSI
command from the Bluetooth 1.2 specification. And while a connection is
active you can retrieve it without any extra cost. Look at the hcitool
info command and see how it finds the needed ACL handle of an existing
connection.

And btw check your devices that they really support inquiry while they
maintain an open ACL connection.

> Here's the block of code that I'm currently using to do a scan.  The old 
> version which worked better was simply a verison of the "hcitool scan" 
> routine modified to connect and check singal strength.

Sorry, but I won't read that code. It is too much nested and actually
code that needs more than 80 chars in a row is way too complex.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
