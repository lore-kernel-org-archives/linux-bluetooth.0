Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4034CA08.50500@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] sco link help needed
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
Date: Thu, 19 Feb 2004 15:36:56 +0100

Hi,
I desparately need some help with audio links:
I have written two small programs that use my pc to emulate a headset
and a handsfree device. Both work quite nicely, the rfcomm-based initiali=
zation
takes place, and I get an SCO connection, but mysteriously, I don't get a=
 single
byte of audio data (I don't see it with hcidump neither).

my setup:
* Acer usb bluetooth dongle
* test phones used: p800 (headset), p6600/ngage/3650 (handsfree) with no =
luck...
* kernel 2.4.23
* bluez utils&lib from cvs
* and yes, i did register hset profile via sdptool....

I had the program running perfectly already with a T68i....
Any help appreciated heavily (for example a traace of a successful connec=
tion...),
Simon

P.S. Is there a location for such tips anywhere? If not, I am willing to =
donate
space & a wiki on one of our institute servers....

--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=C3=BCr Pervasive Computing, Johannes Kepler Universit=C3=A4t L=
inz
Altenberger Stra=C3=9Fe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/








-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
