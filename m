Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
From: Nigel Sim <nigel.sim@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1883_10274066.1135052294508"
Subject: [Bluez-devel] A2DP w/ Blueant headset
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Dec 2005 14:18:14 +1000

------=_Part_1883_10274066.1135052294508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A2DP with the bluetooth-alsa project doesn't work with the Blueant stereo
headphones, and by looking at this page it appears that it might be because
these headphones don't support AVDTP (
http://www.robertwebbe.nl/extendedA2DP.html) Is this possible?

I tried running using a2play (below) and sbcenc+rcplay. The second option
doesn't crash out, but no sound is heard at the headphones. sco sound works
fine, as does the mic.

Is there anyone working on this area at the moment who could suggest
something to try?

Thanks

Bluez 2.23
bluetooth-alsa CVS 20051220

mpg123 --au - /home/nigel/03\ -\ They\ Got\ Lost.mp3 | ./a2play
00:0A:56:00:B5:91 - High Performance MPEG 1.0/2.0/2.5 Audio Player for Laye=
r
1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
...
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo
subbands =3D 8 blocks =3D 16 bitpool =3D 32

len=3D2048
Header size=3D28
Sample Rate:44100
Channels:2
Using address: 00:0A:56:00:B5:91
Found A2DP Sink

Found A2DP Sink at the destination
Connected [imtu 672, omtu 672, flush_to 65535]

couldn't get avdtp_discover
Sent the Stream End Point Discovery Command

------=_Part_1883_10274066.1135052294508
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A2DP with the bluetooth-alsa project doesn't work with the Blueant
stereo headphones, and by looking at this page it appears that it might
be because these headphones don't support AVDTP
(<a href=3D"http://www.robertwebbe.nl/extendedA2DP.html" target=3D"_blank" =
onclick=3D"return top.js.OpenExtLink(window,event,this)">http://www.robertw=
ebbe.nl/extendedA2DP.html</a>) Is this possible? <br>
<br>
I tried running using a2play (below) and sbcenc+rcplay. The second
option doesn't crash out, but no sound is heard at the headphones. sco
sound works fine, as does the mic.<br>
<br>
Is there anyone working on this area at the moment who could suggest someth=
ing to try?<br>
<br>
Thanks<br>
<br>
Bluez 2.23<br>
bluetooth-alsa CVS 20051220<br>
<br>
mpg123 --au - /home/nigel/03\ -\ They\ Got\ Lost.mp3 | ./a2play
00:0A:56:00:B5:91 - High Performance MPEG 1.0/2.0/2.5 Audio Player for
Layer 1, 2, and 3.<br>
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.<br>
...<br>
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo<br>
subbands =3D 8 blocks =3D 16 bitpool =3D 32<br>
<br>
len=3D2048<br>
Header size=3D28<br>
Sample Rate:44100<br>
Channels:2<br>
Using address: 00:0A:56:00:B5:91<br>
Found A2DP Sink<br>
<br>
Found A2DP Sink at the destination<br>
Connected [imtu 672, omtu 672, flush_to 65535]<br>
<br>
couldn't get avdtp_discover<br>
Sent the Stream End Point Discovery Command<br>
<br>
<br>


------=_Part_1883_10274066.1135052294508--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
