Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: tmp@nitwit.de
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No working Bluetooth adapter found
References: <200503271708.10663.tmp@nitwit.de> <200503271804.03641.tmp@nitwit.de> <1111939622.9195.238.camel@pegasus>
In-Reply-To: <1111939622.9195.238.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200503271812.30938.tmp@nitwit.de>
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
Date: Sun, 27 Mar 2005 18:12:30 +0200

On Sunday 27 March 2005 18:07, Marcel Holtmann wrote:
> so you can try "hciconfig hci0 up" and you should maybe activate the

Hey, great. Thanks a lot! However it didn't get that I changed the name of the 
device and still displays the old vendor one. Hmm, some caching issue? I can 
even access the device via the faulty name (?).

> autostart function of the Bluetooth subsystem in YaST.

I apologize the stupid question but I don't see any autostart option in YaST..


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
