Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20605182346v6992b72fn430f9d1dbb68b769@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Ask again
In-Reply-To: <e85851c20605182333w24f22d1aic9f76733f693b29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_64112_31782535.1148021195713"
References: <e85851c20605182333w24f22d1aic9f76733f693b29@mail.gmail.com>
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
Date: Fri, 19 May 2006 12:16:35 +0530

------=_Part_64112_31782535.1148021195713
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

do u have hci_usb module inserted in ur kernel??
whats ur kernel version??
do a "lsmod" and search for hci_usb driver...

On 5/19/06, Gloria Saripah Patara <glowz.saripah@gmail.com> wrote:
>
> Thanks for your reply to my previous email.
> Now,i get a problem again. There are some error messages that looks like
> say that something wrong with the libraries that i use that is bluetooth.=
hand hci_lib.h.
> It's looks like below (not at all mentioned) :
>
> /usr/include/bluetooth/bluetooth.h:118:error:syntax error before "int"
> ........
> ........
> and also at file hci_lib.h.
> It's always wrong if the row contain the "INLINE" reserved word.
> What will i do?
>
> ----------------------------------
> thanks
>

------=_Part_64112_31782535.1148021195713
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

do u have hci_usb module inserted in ur kernel?? <br>whats ur kernel versio=
n?? <br>do a &quot;lsmod&quot; and search for hci_usb driver...<br><br><div=
><span class=3D"gmail_quote">On 5/19/06, <b class=3D"gmail_sendername">Glor=
ia Saripah Patara
</b> &lt;<a href=3D"mailto:glowz.saripah@gmail.com">glowz.saripah@gmail.com=
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
<div>Thanks for your reply to my previous email.<br>Now,i get a problem aga=
in. There are some error messages that looks like say that something wrong =
with the libraries that i use that is bluetooth.h and hci_lib.h.<br>It's lo=
oks like below (not at all mentioned) :
<br><br>/usr/include/bluetooth/bluetooth.h:118:error:syntax error before &q=
uot;int&quot;<br>........<br>........<br>and also at file hci_lib.h.<br>It'=
s always wrong if the row contain the &quot;INLINE&quot; reserved word.
<br>What will i do?<br><br>----------------------------------<br>thanks<br>

</div></blockquote></div><br>

------=_Part_64112_31782535.1148021195713--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
