Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] New pda
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Stadelmann <jerome.stadelmann@hta-bi.bfh.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000001c3f240$a8a3ed50$2d105793@N64101>
References: <000001c3f240$a8a3ed50$2d105793@N64101>
Content-Type: text/plain
Message-Id: <1076685359.2671.78.camel@pegasus>
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
Date: Fri, 13 Feb 2004 16:15:59 +0100

Hi Jerome,

> It's not important. All I want first is to receive some voice from a
> bluetooth transmission and play it threw the speaker of the pda.
> What I saw is that j2me doesn't allow this, then I think embedded linux is a
> good idea for that

actually the BlueZ SCO support is not perfect and I don't know of any
Windows CE based PDA with Headset profile. The bigger problem is to get
a PDA with a good Bluetooth chip and firmware. Even my iPAQ 3970 has an
old 0x72 CSR firmware. The new iPAQ's contain Zeevo chips and I don't
think that it is good to run SCO over H4. Maybe they connected the PCM
interface of the Bluetooth chip to the speaker, but I don't know. You
see, many unknown variables.

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
