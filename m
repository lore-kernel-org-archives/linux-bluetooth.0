Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: =?iso-8859-1?Q?J=E9r=F4me_Stadelmann?= <jerome.stadelmann@hta-bi.bfh.ch>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <000a01c3dffa$0e58e230$2d105793@N64101>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] Audio to headset
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
Date: Wed, 21 Jan 2004 09:39:17 +0100


Hello everybody,

I'm actually working on a diploma project with bluetooth and audio. I =
have
an Anycom Bluetooth USB adapter and an Ericsson HBH-15 headset. I would =
use
first the hstest example in order to send some music to the headset but =
it
doesn't work. I only hear some noise but no music.

Is this command correct ? "hstest play music.mp3 xx:xx:xx:xx:xx:xx"

I have mpg123 and sox installed,
scoinfo return PSKEY_HOSTIO_MAP_SCO_PCM: 0x00,
voice setting is 0x0060.

The pin works and I receive back from the headset the AT commands =
(AT+VGS=3D11
and AT+CKPD=3D200) but I only hear some noise.

Could somebody please help me in this?

Jerome



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
