Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Where I can find description ??
From: Marcel Holtmann <marcel@holtmann.org>
To: Zbyszek <dzidoz@poczta.fm>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040225141752.2E2977CDE@front.interia.pl>
References: <20040225141752.2E2977CDE@front.interia.pl>
Content-Type: text/plain
Message-Id: <1077719809.2919.99.camel@pegasus>
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
Date: Wed, 25 Feb 2004 15:36:49 +0100

Hi Zbyszek,

> My name is Zbyszek. My final year project includes communication between cell phone and pc via Bluetooth.I have problem with BlueZ. My problem is that, I never programmed in Bluetooth and when I look at source code in directory "test" I see many function f.e. "getsockopt(s, SOL\_L2CAP, L2CAP\_OPTIONS, \&opts, \&opts\_len)" but there is no describtion for them. So I'm asking you, could you tell me, where I can find any documentations describing these functions.

if you want to access your mobile phone you should not look at L2CAP,
you should look at RFCOMM. The RFCOMM socket programming is much simpler
and there are plenty good examples. You can look at attest.c to see how
to read the phonebook using AT commands. Maybe my slides from my last
workshop are also helpful

	http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf

And of course you can look at the Gnokii or MultiSync projects.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
