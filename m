Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <b47e603e0511060338n7bb0b02h95433510442897a8@mail.gmail.com>
From: George Friedman <george.friedman@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] what is libbluetooth library?
In-Reply-To: <ef9938ec0511051410m6f0614dcnf1eb873c33e97a46@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17456_23437463.1131277099269"
References: <b47e603e0511050301i5e515811y58412c28aa581c8f@mail.gmail.com>
	 <ef9938ec0511051410m6f0614dcnf1eb873c33e97a46@mail.gmail.com>
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
Date: Sun, 6 Nov 2005 19:38:19 +0800

------=_Part_17456_23437463.1131277099269
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

thank you.yeah it worked.but i still cannot run the pjbluez.have you used
this before?
 since jbluez does not provide the programs for getting RSSI,is there any
where i can get the JNI and the C program from so that i can use jbluez to
get RSSI?
 George

 On 11/6/05, Albert Huang <ashuang@gmail.com> wrote:
>
> you need to install bluez-devel
>
> -albert
>
> On 11/5/05, George Friedman <george.friedman@gmail.com> wrote:
> >
> > hi
> >
> > i am installing pjbluez package (add on to jbluez) for location sensing=
.
> > source: http://www.mobilab.unina.it/PJBLUEZ.htm
> >
> > when i run the shell script that can build the libraries for pjbluez, i
> > get an error saying,
> >
> > checking bluetooth/bluetooth.h usability... no
> > checking bluetooth/bluetooth.h presence... no
> > checking for bluetooth/bluetooth.h... no
> > checking for hci_open_dev in -lbluetooth... no
> > configure: error: Sorry, you should install the libbluetooth library
> > before trying to compile this package
> >
> > what does the last line mean?i have installed bluez and jbluez on fc 4
> > so i don't understand what libbluetooth library i'm required to install
> >
> > thank you
> > george
> >
>
>

------=_Part_17456_23437463.1131277099269
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>thank you.yeah it worked.but i still cannot run the pjbluez.have you u=
sed this before?</div>
<div>&nbsp;</div>
<div>since jbluez does not provide the programs for getting RSSI,is there a=
ny where i can get the JNI and the C program from so that i can use jbluez =
to get RSSI?</div>
<div>&nbsp;</div>
<div>George<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 11/6/05, <b class=3D"gmail_sendername">=
Albert Huang</b> &lt;<a href=3D"mailto:ashuang@gmail.com">ashuang@gmail.com=
</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">you need to install bluez-devel<=
br><span class=3D"sg"><br>-albert</span>=20
<div><span class=3D"e" id=3D"q_107627c175c68b2d_2"><br><br>
<div><span class=3D"gmail_quote">On 11/5/05, <b class=3D"gmail_sendername">=
George Friedman</b> &lt;<a onclick=3D"return top.js.OpenExtLink(window,even=
t,this)" href=3D"mailto:george.friedman@gmail.com" target=3D"_blank">george=
.friedman@gmail.com
</a>&gt; wrote:</span>=20
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0=
pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">hi<br><br>i am insta=
lling pjbluez package (add on to jbluez) for location sensing. source: <a o=
nclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://www.=
mobilab.unina.it/PJBLUEZ.htm" target=3D"_blank">
http://www.mobilab.unina.it/PJBLUEZ.htm </a><br><br>when i run the shell sc=
ript that can build the libraries for pjbluez, i get an error saying, <br><=
br>checking bluetooth/bluetooth.h usability... no<br>checking bluetooth/blu=
etooth.h presence... no
<br>checking for bluetooth/bluetooth.h... no<br>checking for hci_open_dev i=
n -lbluetooth... no<br>configure: error: Sorry, you should install the libb=
luetooth library before trying to compile this package<br><br>what does the=
 last line mean?i have installed bluez and jbluez on fc 4 so i don't unders=
tand what libbluetooth library i'm required to install
<br><br>thank you<br><span>george<br></span></blockquote></div><br></span><=
/div></blockquote></div><br>

------=_Part_17456_23437463.1131277099269--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
