Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?iso-8859-1?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Audio to headset
References: <000a01c3dffa$0e58e230$2d105793@N64101>
In-Reply-To: <000a01c3dffa$0e58e230$2d105793@N64101>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401211447.50124.bluez-devel@schaettgen.de>
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
Date: Wed, 21 Jan 2004 14:47:50 +0100

On Wednesday 21 January 2004 09:39, J=E9r=F4me Stadelmann wrote:
> Hello everybody,
>
> I'm actually working on a diploma project with bluetooth and audio. I have
> an Anycom Bluetooth USB adapter and an Ericsson HBH-15 headset. I would u=
se
> first the hstest example in order to send some music to the headset but it
> doesn't work. I only hear some noise but no music.

Do you use an older kernel without Marcel's patches maybe?
I've also had problems with an older Mitsumi Bluetooth adaptor, but with it=
=20
the output sounds a little bit like the expected signal at least.
Do you just get random noise or does it correspond somehow to the music?

> Is this command correct ? "hstest play music.mp3 xx:xx:xx:xx:xx:xx"

I don't have a headset to try, but I thought hstest works with uncompressed=
=20
audio data only. Or I just didn't notice.. I'd try a wave file (16 bit mono=
?)=20
instead.

greetings
=46red



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
