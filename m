Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Smartcard replacement security?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050323094241.380D34A3@arbetsmyra.dyndns.org>
References: <20050323094241.380D34A3@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1111590295.1916.3.camel@pegasus>
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
Date: Wed, 23 Mar 2005 16:04:55 +0100

Hi Ronny,

> I'd like to know your general opinion on using a Bluetooth enabled 
> device (cell phone) as a smart card replacement.
> 
> I'm thinking of using a phone to automaticly unlocking e.g. my computer 
> screensaver when I'm nearby. The devices needs to be paired of course. 
> But then, how "unsafe" is this realy? Can someone else spoof my phone 
> and thus fooling my computer other than using some kind of brute force? 
> Authentication is made two-ways, right?

this depends on how your automatic unlocking is working. If you know the
link key and the BD_ADDR you can spoof anything.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
