Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <45A51999.3010108@xmission.com>
References: <042F6BC7-A46A-4D9D-8810-1C66347B60C7@gmail.com>	<45A5105B.7050705@xmission.com>
	<6D8DB734-3C02-4CED-80CE-F770D73FD6BA@gmail.com>
	<45A51999.3010108@xmission.com>
Message-Id: <ABCE48BD-8B79-4C00-9ADE-B7DDB0940DE2@gmail.com>
From: Bas Schulte <basschulte@gmail.com>
Date: Wed, 10 Jan 2007 18:04:04 +0100
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] What happened with pin_helper (hcid.conf)?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Ok, got it. Unsupported but I'll take it:

> Note to the tech-savy:
> If you are stuck in console and absolutely need to pair with your
> bluetooth device have a look at
> /var/lib/bluetooth/<your_device_address>/pincodes. Please note that
> this mode of operation is _not_ _supported_. Don't mess with files in
> /var/lib/bluetooth/ unless you know what you are doing. I repeat:
> manually adding a pincode for a remote device is NOT SUPPORTED.

(my config used to be "supported" by specifying "pin_helper" in  
hcid.conf yet it broke anyway so I may as well use an unsupported  
method)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
