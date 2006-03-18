Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20603172308n628c5d32n8d5604dfa1487bdc@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_777_20483468.1142665698496"
Subject: [Bluez-users] Re: Vend/id 0xa12 /0x1
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
Date: Sat, 18 Mar 2006 12:38:18 +0530

------=_Part_777_20483468.1142665698496
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Thomas
my hcitool dev is
root@zin03uislnx-10 root]# hcitool dev
Devices:
        hci0    00:09:DD:10:00:CC
[root@zin03uislnx-10 root]#


and when i typed in the site... it gave:
So what does this mean??


00-09-DD   (hex)=09=09Mavin Technology Inc.
*0009DD*     (base 16)=09=09Mavin Technology Inc.
=09=09=09=09Room 305, Bldg. 52 No. 195-28
=09=09=09=09Sec. 4 Chung-Hsing Rd.
=09=09=09=09Chutung, Hsinchu  310
=09=09=09=09TAIWAN, REPUBLIC OF CHINA



_______________________________________________________
I have Acer and Cellink dongles with this USB id, so this is not
helpful, but you can look at the BD addr:

"hcitool dev" will give you something like
Devices:
       hci0    00:0A:94:xx:xx:xx

Just enter the first three pairs (without colons, i.e. 000A94) in
the OUI search form at:
http://standards.ieee.org/regauth/oui/index.shtml

and you'll get something like:
00-0A-94   (hex)                ShangHai cellink CO., LTD
000A94     (base 16)            ShangHai cellink CO., LTD
                               C3 MeiLong ZhongXin Industrial Park,No.1
                               ShangHai  200237
                               CHINA

Thomas

------=_Part_777_20483468.1142665698496
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br>Hi Thomas <br>my hcitool dev is <br>root@zin03uislnx-10 root]# hcit=
ool dev<br>Devices:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci0&nbsp=
;&nbsp;&nbsp; 00:09:DD:10:00:CC<br>[root@zin03uislnx-10 root]#<br><br><br>a=
nd when i typed in the site... it gave: <br>So what does this mean??
<br><br><br><pre>00-09-DD   (hex)=09=09Mavin Technology Inc.<br><b>0009DD</=
b>     (base 16)=09=09Mavin Technology Inc.<br>=09=09=09=09Room 305, Bldg. =
52 No. 195-28<br>=09=09=09=09Sec. 4 Chung-Hsing Rd.<br>=09=09=09=09Chutung,=
 Hsinchu  310<br>=09=09=09=09TAIWAN, REPUBLIC OF CHINA
<br><br><br></pre><br>_____________________________________________________=
__<br>I have Acer and Cellink dongles with this USB id, so this is not<br>h=
elpful, but you can look at the BD addr:<br><br>&quot;hcitool dev&quot; wil=
l give you something like
<br>Devices:<br> &nbsp; &nbsp; &nbsp; &nbsp;hci0 &nbsp; &nbsp;00:0A:94:xx:x=
x:xx<br><br>Just enter the first three pairs (without colons, i.e. 000A94) =
in<br>the OUI search form at:<br><a onclick=3D"return top.js.OpenExtLink(wi=
ndow,event,this)" href=3D"http://standards.ieee.org/regauth/oui/index.shtml=
" target=3D"_blank">
http://standards.ieee.org/regauth/oui/index.shtml</a><br><br>and you'll get=
 something like:<br>00-0A-94 &nbsp; (hex) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;ShangHai cellink CO., LTD<br>000A94 &nbsp; &nbsp; (ba=
se 16) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ShangHai cellink CO., LTD<b=
r> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;C3 MeiLong ZhongXin Industrial Park,
No.1<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ShangHai &nbsp;200237<br> &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;CHINA<br><br>Thomas<br>

------=_Part_777_20483468.1142665698496--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
