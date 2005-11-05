Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0511051410m6f0614dcnf1eb873c33e97a46@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] what is libbluetooth library?
In-Reply-To: <b47e603e0511050301i5e515811y58412c28aa581c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_33799_3359720.1131228656739"
References: <b47e603e0511050301i5e515811y58412c28aa581c8f@mail.gmail.com>
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
Date: Sat, 5 Nov 2005 17:10:56 -0500

------=_Part_33799_3359720.1131228656739
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

you need to install bluez-devel

-albert

On 11/5/05, George Friedman <george.friedman@gmail.com> wrote:
>
> hi
>
> i am installing pjbluez package (add on to jbluez) for location sensing.
> source: http://www.mobilab.unina.it/PJBLUEZ.htm
>
> when i run the shell script that can build the libraries for pjbluez, i
> get an error saying,
>
> checking bluetooth/bluetooth.h usability... no
> checking bluetooth/bluetooth.h presence... no
> checking for bluetooth/bluetooth.h... no
> checking for hci_open_dev in -lbluetooth... no
> configure: error: Sorry, you should install the libbluetooth library
> before trying to compile this package
>
> what does the last line mean?i have installed bluez and jbluez on fc 4 so
> i don't understand what libbluetooth library i'm required to install
>
> thank you
> george
>

------=_Part_33799_3359720.1131228656739
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

you need to install bluez-devel<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 11/5/05, <b class=3D"gma=
il_sendername">George Friedman</b> &lt;<a href=3D"mailto:george.friedman@gm=
ail.com">george.friedman@gmail.com</a>&gt; wrote:</span><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
hi<br>
<br>
i am installing pjbluez package (add on to jbluez) for location sensing. so=
urce: <a href=3D"http://www.mobilab.unina.it/PJBLUEZ.htm" target=3D"_blank"=
 onclick=3D"return top.js.OpenExtLink(window,event,this)">http://www.mobila=
b.unina.it/PJBLUEZ.htm
</a><br>
<br>
when i run the shell script that can build the libraries for pjbluez, i get=
 an error saying, <br>
<br>
checking bluetooth/bluetooth.h usability... no<br>
checking bluetooth/bluetooth.h presence... no<br>
checking for bluetooth/bluetooth.h... no<br>
checking for hci_open_dev in -lbluetooth... no<br>
configure: error: Sorry, you should install the libbluetooth library before=
 trying to compile this package<br>
<br>
what does the last line mean?i have installed bluez and jbluez on fc 4
so i don't understand what libbluetooth library i'm required to install<br>
<br>
thank you<br><span class=3D"sg">
george<br>

</span></blockquote></div><br>

------=_Part_33799_3359720.1131228656739--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
