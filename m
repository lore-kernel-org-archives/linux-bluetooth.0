Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <003501c427be$15781fc0$7b6b7b8c@yaya>
From: "guang" <m9187@cn.ee.ccu.edu.tw>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0032_01C42801.2390B160"
Subject: [Bluez-users] SCO question ?
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
Date: Thu, 22 Apr 2004 00:31:22 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0032_01C42801.2390B160
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi all:
I have a apinion about voice data, but I don't know whether it is =
correct or not.
Please give me some comments.

If we type "hciconfig hci0 voice" and it will appear this on my PC:

[root@bluez root]# hciconfig hci0 voice
hci0:   Type: USB
        BD Address: 00:09:DD:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
        Voice setting: 0x0060 (Default Condition)
        Input Coding: Linear
        Input Data Format: 2's complement
        Input Sample Size: 16 bit
        # of bits padding at MSB: 0
        Air Coding Format: CVSD

And my viewpoint is as below:
1. Input Coding : Linear  --> quantification and frequency are  a ratio =
of equality.
2. Input Data Format: 2's complement --> ???? I don't know what's mean.
3. Input Sample Size: 16 bit  --> per sample is used 16 bit to indicate.
4. Air Coding Format: CVSD  --> Voice is sampled by soundcard , then =
Baseband covert these data using CVSD codec and translate these data on =
air.

As above, I give a conclusion:
I can extract voice datas from SCO socket, and these data are coded by =
PCM (linear, 16 bit/per sample, sample rate =3D 8k).
=20
 ex:
 outgoing voice data:
=20
         soundcard             sco socket   Baseband
                |                            |                  |
                |  8k sample rate   |                  |
                |  ,16bit/sample     |                  |
voice --->|-------------------->|----------->|---->CVSD data
                |                             |                 |
                |                             |                 |
=20
=20
=20
 incoming voice data:
=20
             Baseband             sco socket   soundcard        =
Application
                     |                            |               |      =
                      |
                     |    linear PCM     |                |  8k sample =
rate  |
                     |  ,16bit/sample    |                |  16 =
bit/sample    |
 CVSD =
---->|------------------->|---------->|------------------->|---->analogy =
voice
                     |                           |                |      =
                     |
                     |                           |                |      =
                     |
=20
=20
 As above , that are my concept, Is my concept correct?
 Please give me some comments.
=20
 Thank you .
------=_NextPart_000_0032_01C42801.2390B160
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Hi all:<BR>I have a apinion about voice data, but I =
don't know=20
whether it is correct or not.<BR>Please give me some =
comments.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>If we type "hciconfig hci0 voice" and it will appear =
this on=20
my PC:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>[root@bluez root]# hciconfig hci0 =
voice<BR>hci0:&nbsp;&nbsp;=20
Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:=20
00:09:DD:xx:xx:xx ACL MTU: 192:8&nbsp; SCO MTU:=20
64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Voice setting: 0x0060 =

(Default Condition)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Input =
Coding:=20
Linear<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Input Data Format: =
2's=20
complement<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Input Sample =
Size: 16=20
bit<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # of bits padding at =
MSB:=20
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Air Coding Format:=20
CVSD</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>And my viewpoint is as below:<BR>1. Input Coding :=20
Linear&nbsp; --&gt; quantification and frequency are&nbsp; a ratio of=20
equality.<BR>2. Input Data Format: 2's complement --&gt; ???? I don't =
know=20
what's mean.<BR>3. Input Sample Size: 16 bit&nbsp; --&gt; per sample is =
used 16=20
bit to indicate.<BR>4. Air Coding Format: CVSD&nbsp; --&gt; Voice is =
sampled by=20
soundcard , then Baseband covert these data using CVSD codec and =
translate these=20
data on air.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>As above, I give a conclusion:<BR>I can extract =
voice datas=20
from SCO socket, and these data are coded by PCM (linear, 16 bit/per =
sample,=20
sample rate =3D 8k).<BR>&nbsp;<BR>&nbsp;ex:<BR>&nbsp;outgoing voice=20
data:<BR>&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;soundcard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=20
sco socket&nbsp;&nbsp;=20
Baseband<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
&nbsp;=20
|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
&nbsp;|&nbsp; 8k sample=20
rate&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;=20
|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
&nbsp; |&nbsp;=20
,16bit/sample&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;|</FONT></DIV>
<DIV><FONT size=3D2>voice=20
---&gt;|--------------------&gt;|-----------&gt;|----&gt;CVSD=20
data<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;=20
&nbsp;=20
|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
&nbsp;|<BR>&nbsp;<BR>&nbsp;<BR>&nbsp;<BR>&nbsp;incoming voice=20
data:<BR>&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
&nbsp;&nbsp;=20
Baseband&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
sco socket&nbsp;&nbsp; =
soundcard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Application<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
&nbsp;=20
|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp; |&nbsp;&nbsp;&nbsp; linear PCM&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
&nbsp; |&nbsp; 8k sample rate&nbsp;=20
|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp; |&nbsp; ,16bit/sample&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
&nbsp; |&nbsp; 16 bit/sample&nbsp;&nbsp; &nbsp;|<BR>&nbsp;CVSD=20
----&gt;|-------------------&gt;|----------&gt;|-------------------&gt;|-=
---&gt;analogy=20
voice<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
&nbsp;|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
&nbsp;=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|<BR>&nbsp;<BR>&nbsp;<BR>&nbsp;As=20
above , that are my concept, Is my concept correct?<BR>&nbsp;Please give =
me some=20
comments.<BR>&nbsp;<BR>&nbsp;Thank you .</FONT></DIV></BODY></HTML>

------=_NextPart_000_0032_01C42801.2390B160--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
