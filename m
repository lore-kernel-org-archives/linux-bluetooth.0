Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0605232128n66fd4ce3oc05e542f037f02e9@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Found -undefined reference-
In-Reply-To: <e85851c20605232041n2570cf9bk7a3f279358a63676@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_80040_28039600.1148444934571"
References: <e85851c20605230329s754c5187sf2528816a0e64d@mail.gmail.com>
	 <e85851c20605232040h2cb185bp780b724e667fc84d@mail.gmail.com>
	 <e85851c20605232041n2570cf9bk7a3f279358a63676@mail.gmail.com>
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
Date: Wed, 24 May 2006 00:28:54 -0400

------=_Part_80040_28039600.1148444934571
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

you need to link against libopenobex.

it's either

gcc -o code code.c -lbluetooth -lopenobex

or

gcc -o code codec.c -lbluetooth -lopenobex-1.0

or something like that.

-albert

On 5/23/06, Gloria Saripah Patara <glowz.saripah@gmail.com> wrote:
>
> Have u ever met the error messages like these :
>
> undefined reference to 'OBEX_Cleanup'
>
> i used the command line below:
>
> gcc -o code code.c -lbluetooth
>
> it's occur when i try to call certain function or procedure which
> declarated in obex.h file (header file in Openobex libraries).
>
> file code.c is attached inside this message.
> -----------------------
> Thanks in advance....
>
>
>

------=_Part_80040_28039600.1148444934571
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

you need to link against libopenobex.<br>
<br>
it's either<br>
<br>
gcc -o code code.c -lbluetooth -lopenobex<br>
<br>
or <br>
<br>
gcc -o code codec.c -lbluetooth -lopenobex-1.0<br>
<br>
or something like that.<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 5/23/06, <b class=3D"gma=
il_sendername">Gloria Saripah Patara</b> &lt;<a href=3D"mailto:glowz.saripa=
h@gmail.com">glowz.saripah@gmail.com</a>&gt; wrote:</span><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Have u ever met the error messages like these :<br><br>undefined reference =
to 'OBEX_Cleanup'<br><br>i used the command line below:<br><br>gcc -o code =
code.c -lbluetooth<br><br>it's occur when i try to call certain function or=
 procedure which
<br>declarated in obex.h file (header file in Openobex libraries).<br><br>f=
ile code.c is attached inside this message.<br>-----------------------<br>T=
hanks in advance....<br><br><br></blockquote></div><br>

------=_Part_80040_28039600.1148444934571--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
