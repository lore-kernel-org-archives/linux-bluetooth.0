Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT-1.2 spec device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576050103071248159461@mail.gmail.com>
References: <2de46576050103071248159461@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1104776590.8894.57.camel@pegasus>
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
Date: Mon, 03 Jan 2005 19:23:10 +0100

Hi Manjunath,

> I am looking at a BT dongle with Adaptive Frequency Hopping and power
> control. I think I will find both these features in a Class-1 ,1.2
> spec device.

you can update the D-Link DBT-120 Rev. B3.

> I am looking at another feature, that is the device should be able to
> read the piconet clock. i found that DBT-120 did not have this
> feature. But DBT seemed to give a better LQ value. So i am a little
> unsure about which product to purchase.

As far as I know it has support for it after you flashed a HCI 18.x
firmware into it.
 
> can you tell me which BT product with 1.2 spec with the above features
> i can purchase??Will the BT products with EDR hit the market soon..

The number of Bluetooth 1.2 dongles is quite limited. However you can
flash the D-Link with the Apple firmware or get a Anycom based on a
Silicon Wave. These are the only ones I know of. I expect the first EDR
dongles very soon, but actually this depends on how fast CSR can deliver
its BlueCore4 in large quantities.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
