Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Audio to headset
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Stadelmann <jerome.stadelmann@hta-bi.bfh.ch>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000a01c3dffa$0e58e230$2d105793@N64101>
References: <000a01c3dffa$0e58e230$2d105793@N64101>
Content-Type: text/plain
Message-Id: <1074688985.7088.67.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 21 Jan 2004 13:43:06 +0100

Hi Jerome,

> I'm actually working on a diploma project with bluetooth and audio. I have
> an Anycom Bluetooth USB adapter and an Ericsson HBH-15 headset. I would use
> first the hstest example in order to send some music to the headset but it
> doesn't work. I only hear some noise but no music.
> 
> Is this command correct ? "hstest play music.mp3 xx:xx:xx:xx:xx:xx"

why don't you try hsplay?

> I have mpg123 and sox installed,
> scoinfo return PSKEY_HOSTIO_MAP_SCO_PCM: 0x00,
> voice setting is 0x0060.
> 
> The pin works and I receive back from the headset the AT commands (AT+VGS=11
> and AT+CKPD=200) but I only hear some noise.
> 
> Could somebody please help me in this?

What kernel version are you using? Try one of my latest patches for 2.4.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
