Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050922101225d5ba83@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <1127398388.5344.20.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8866_6162580.1127409147351"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <9307f5f205092106191197c374@mail.gmail.com>
	 <e1effdeb05092106526cd16196@mail.gmail.com>
	 <1127398388.5344.20.camel@blade>
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
Date: Thu, 22 Sep 2005 14:12:27 -0300

------=_Part_8866_6162580.1127409147351
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Sorry, I think have written an unclear text.

The first argument of an error message MUST be a string containing the
error description, this is a D-Bus definition. Regarding the error code
mapping I think my last email make more clear how I intend work
with system, D-Bus and HCI errors. Although I am defining a way to
report HCI error, I think it will not be possible catch this kind of error
without get the hci command complete event.


REgards,
Claudio

On 9/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > An ERROR may have any arguments, but if the first argument is a
> > STRING(error message). Therefore, the signature should be sq (string
> > +uint16).
> > In my opinion the error message string is not relevant, the client
> > applications
> > can use it or not. If we consider internationalization, this string
> > will not
> > the useful.
>
> the Bluetooth status is always uint8_t and I think it is a good idea to
> map these error codes directly. We can define our own codes from 0xff
> onwards if we use a uint16. However we should try to use the Bluetooth
> defined errors whenever possible.
>
> A string would be nice, but in generell these are useless. However for
> application that doesn't consider internationalization it will be easy
> for them to display the errors in clear text.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_8866_6162580.1127409147351
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
Sorry, I think have written an unclear text.<br>
<br>
The first argument of an error message MUST be a string containing the<br>
error description, this is a D-Bus definition. Regarding the error code<br>
mapping I think my last email make more clear how I intend work<br>
with system, D-Bus and HCI errors. Although I am defining a way to<br>
report HCI error, I think it will not be possible catch this kind of error<=
br>
without get the hci command complete event.<br>
<br>
<br>
REgards,<br>
Claudio<br><br><div><span class=3D"gmail_quote">On 9/22/05, <b class=3D"gma=
il_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.or=
g">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; An ERROR may have any arguments, but if the first a=
rgument is a<br>&gt; STRING(error message). Therefore, the signature should=
 be sq (string<br>&gt; +uint16).<br>&gt; In my opinion the error message st=
ring is not relevant, the client
<br>&gt; applications<br>&gt; can use it or not. If we consider internation=
alization, this string<br>&gt; will not<br>&gt; the useful.<br><br>the Blue=
tooth status is always uint8_t and I think it is a good idea to<br>map thes=
e error codes directly. We can define our own codes from 0xff
<br>onwards if we use a uint16. However we should try to use the Bluetooth<=
br>defined errors whenever possible.<br><br>A string would be nice, but in =
generell these are useless. However for<br>application that doesn't conside=
r internationalization it will be easy
<br>for them to display the errors in clear text.<br><br>Regards<br><br>Mar=
cel<br><br><br><br><br>----------------------------------------------------=
---<br>SF.Net email is sponsored by:<br>Tame your development challenges wi=
th Apache's Geronimo App Server.
<br>Download it for free - -and be entered to win a 42&quot; plasma tv or y=
our very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http=
://sourceforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br=
>_______________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_8866_6162580.1127409147351--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
