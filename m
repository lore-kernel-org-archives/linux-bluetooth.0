Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Automatically accepting pairing from a mouse?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4227A238.5030003@emenaker.com>
References: <4227A238.5030003@emenaker.com>
Content-Type: text/plain
Message-Id: <1109933159.8058.19.camel@pegasus>
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
Date: Fri, 04 Mar 2005 11:45:58 +0100

Hi Joe,

> Please forgive the newbie question... I'm still a little new to how 
> bluetooth devices interact.
> 
> I've got bluez-utils running on my debian laptop and I can use it to 
> find my bluetooth mouse.
> I can run "hcitool scan" and, provided that I've clicked the little 
> "pairing" button on my mouse, the scan finds it.
> Then, I can run "hidd --connect aa:bb:cc:dd:ee:ff" (not the actual hw 
> address I use) and it connects!
> 
> However, I'd like to avoid having to open a konsole window and do this 
> pairing every time I boot my laptop. Furthermore, the mouse I have likes 
> to go to sleep after about 5-10 minutes of inactivity... at which point 
> it requires pairing again.
> 
> It would be nice if I could just click the pairing button on my mouse 
> and have the rest happen automatically.
> 
> In an attempt to do this, I've changed my "HIDD_OPTIONS=--master 
> --server" to "HIDD_OPTIONS=-i aa:bb:cc:dd:ee:ff --server", but this 
> doesn't seem to have done anything.

it is enought to edit /etc/default/bluez-utils to contain

	HIDD_ENABLED=1
	HIDD_OPTIONS="--server"

and then restart the Bluetooth subsystem. The next time your mouse will
reconnect and this will be handled by the running hidd.

> Lastly, does anyone have any suggestions for a better mouse? My current 
> one is pretty nifty, though. It has an on/off switch so that I can save 
> batteries when the laptop is packed away. And it's a mini-style. But the 
> timeout-sleep thing is just killing me....

Run the hidd and the timeout thing is no longer a problem.

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
