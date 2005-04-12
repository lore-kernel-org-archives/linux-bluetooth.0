Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <E73D9A5BC4A2D711BBC600065BF3595F1C66D026@il06exm10>
From: Mandalia Hiren-AHM047 <hirenm@motorola.com>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C53F8F.F924E98A"
Subject: [Bluez-users] compilation errors for btsco
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
Date: Tue, 12 Apr 2005 13:46:44 -0500

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C53F8F.F924E98A
Content-Type: text/plain

Hello,

I'm trying to compile btsco on a FC3 (Kernel 2.6.10). I think I have all the packages that I need. 

The alsa packages I have are:

alsa-lib-devel-1.0.6-7.FC3
alsa-utils-1.0.6-3
alsa-lib-1.0.6-7.FC3

I have already installed the bluez-libs-2.15 package so that should take care about libbluetooth-dev (correct me if I'm wrong here)

when I do a 
%./bootstrap
aclocal: configure.in 21: macro 'AM_PATH_ALSA' not found in library

I was reading the archives which made me check if I had the file /usr/share/aclocal/alsa.m4 and I do have that file. I don't know why do I get this error. Will renaming of packages help? If yes how do I rename them? Please help..

Regards,
Hiren




------_=_NextPart_000_01C53F8F.F924E98A
Content-Type: text/plain;
	name="alsa.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="alsa.txt"

YWxzYS1saWItZGV2ZWwtMS4wLjYtNy5GQzMKYWxzYS11dGlscy0xLjAuNi0zCmFsc2EtbGliLTEu
MC42LTcuRkMzCg==

------_=_NextPart_000_01C53F8F.F924E98A--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
