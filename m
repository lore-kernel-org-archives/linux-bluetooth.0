Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with Microsoft Keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <424C0E8C.4060806@sbox.tugraz.at>
References: <424C0E8C.4060806@sbox.tugraz.at>
Content-Type: text/plain
Message-Id: <1112554579.8263.10.camel@pegasus>
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
Date: Sun, 03 Apr 2005 20:56:19 +0200

Hi Thomas,

> I'm using Debian (Kernel 2.6.11 with the mh2 patch) and my Microsoft 
> Bluetooth Mouse works fine. After hidd --search it is found and also 
> connected so I'm able to use it. However my Keyboard is not found (tried 
> it 1000 times...). Shouldn't it also work with hidd --search? Is there a 
> way to get the address from the keyboard and connect it manually? (It 
> works fine under windows)

is this the first or the second generation of the Microsoft keyboard.

What does "hciconfig -a" tells you? Do you find it with "hcitool scan"?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
