Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <5307d89f0512200011i7a6784dfie08a56569a90381d@mail.gmail.com>
From: Patrick Libert <patrick.libert@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1125_20269599.1135066296085"
Subject: [Bluez-users] Info a2play
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
Date: Tue, 20 Dec 2005 09:11:36 +0100

------=_Part_1125_20269599.1135066296085
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Bluez-Users

I saw on a website "LiveJournal" that it is possible to
use beep-media-player to stream your mp3 to a bluetooth stereo headset with
a2play.
The syntax is like this:

                       beep-media-player | sox -c 2 -t raw -r 44100 -w -s -
-t au - | ./a2play <http://bluetooth-alsa.sourceforge.net/> -p
00:0D:44:2A:14:66<http://www.shopping.hp.com/webapp/shopping/product_detail=
.do?product_code=3DFA303A%23AC3>

with this in the .asoundrc


          pcm.stdout {
                     type file
                     slave.pcm null
                     file /dev/stdout
                   }


When I do this I get an error:

      couldn't open 00:08:E0:09:75:6F

What does the option "-p" with a2play means?
If I do this without the "-p" option I get the following error:

              out of sync (0x2e)
              couldn't read header on -

When I do this:

            mpg123 --au - file.mp3 | sbc/sbcenc - | ./a2play
00:08:E0:09:75:6F
Then It works with my headset. But the music is interrupted sometimes. How
does it come?

I really appriciate if someone could help me.

Kind regards,

Patrick Libert

------=_Part_1125_20269599.1135066296085
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Bluez-Users<br><br>I saw on&nbsp;a website&nbsp;&quot;LiveJournal&quo=
t; that it is possible to use&nbsp;beep-media-player to stream your mp3 to =
a bluetooth stereo headset with a2play.<br>The&nbsp;syntax is like this:<br=
><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<tt>beep-media-player | sox -c 2 -t raw -r 44100 -w -s - -t au - | <a oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://bluetoot=
h-alsa.sourceforge.net/" target=3D"_blank">./a2play</a> -p <a onclick=3D"re=
turn top.js.OpenExtLink(window,event,this)" href=3D"http://www.shopping.hp.=
com/webapp/shopping/product_detail.do?product_code=3DFA303A%23AC3" target=
=3D"_blank">
00:0D:44:2A:14:66</a><br><br></tt>with this in the .asoundrc<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><pre>          pcm.stdou=
t {<br>                     type file<br>                     slave.pcm nul=
l<br>                     file /dev/stdout
<br>                   }</pre>
<div><br>When I do this I get an error:</div>
<div><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; couldn't open 00:08:E0:09:75:6F</di=
v>
<div>&nbsp;</div>
<div>What does the option &quot;-p&quot; with a2play means?<br>If I do this=
 without the &quot;-p&quot; option I get the following error:</div>
<div><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; out of sync (0x2e)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; couldn't read header on -<br><br>Whe=
n I do this:</div>
<div><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 mpg123 --au - file.mp3 | sbc/sbcenc - | ./a2play 00:08:E0:09:75:6F <br>The=
n It works with my headset. But the music is&nbsp;interrupted&nbsp;sometime=
s. How does it come?<br><br>I really appriciate if&nbsp;someone could help =
me.
<br><br>Kind regards,<br><span></span><span class=3D"sg"><br>Patrick Libert=
<br>&nbsp;</span></div>

------=_Part_1125_20269599.1135066296085--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
