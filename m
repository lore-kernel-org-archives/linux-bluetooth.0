Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05092106526cd16196@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <9307f5f205092106191197c374@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_834_9015266.1127310775478"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <9307f5f205092106191197c374@mail.gmail.com>
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
Date: Wed, 21 Sep 2005 10:52:55 -0300

------=_Part_834_9015266.1127310775478
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

An ERROR may have any arguments, but if the first argument is a
STRING(error message). Therefore, the signature should be sq
(string+uint16).
In my opinion the error message string is not relevant, the client
applications
can use it or not. If we consider internationalization, this string will no=
t
the useful.

Regards,
Claudio.

On 9/21/05, P. Durante <shackan@gmail.com> wrote:
>
> Hi,
>
> > org.bluez.hci.error.Failed /* here we can add the bluetooth error code
> */
>
> Just an idea, keep it simple, if you give the clients just the
> bluetooth error code they'll have to decode its meaning using
> something like strerror( bt_error( error_code )) every time they make
> a request, quite boring, even worse, bt_error is bluez-specific and if
> the client wants to use something like that in a language which is not
> C, they should grab the bluetooth specification write their own
> function which tells what each error code means...
>
> or
>
> since dbus errors consist of error_name + error_message you could put
> something meaningful in the error_message, and eventually append an
> additional field with the error code to the message as well ( if the
> application wants to treat some error codes in a particular way ) this
> seems ok with the dbus specification which only says (if I remember
> correctly) that if the first field in an error message is of type
> 'string' that string will be treated as the error message, and doesn't
> say anything about additional fields.
>
> regards
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

------=_Part_834_9015266.1127310775478
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,<br>
<br>
An ERROR may have any arguments, but if the first argument is a <br>
STRING(error message). Therefore, the signature should be sq (string+uint16=
).<br>
In my opinion the error message string is not relevant, the client applicat=
ions<br>
can use it or not. If we consider internationalization, this string will no=
t<br>
the useful.<br>
<br>
Regards,<br>
Claudio.<br><br><div><span class=3D"gmail_quote">On 9/21/05, <b class=3D"gm=
ail_sendername">P. Durante</b> &lt;<a href=3D"mailto:shackan@gmail.com">sha=
ckan@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi,<br><br>&gt;&nbsp;&nbsp;org.bluez.hci.error.Failed&nbsp;&nbsp;/* here we=
 can add the bluetooth error code */<br><br>Just an idea, keep it simple, i=
f you give the clients just the<br>bluetooth error code they'll have to dec=
ode its meaning using
<br>something like strerror( bt_error( error_code )) every time they make<b=
r>a request, quite boring, even worse, bt_error is bluez-specific and if<br=
>the client wants to use something like that in a language which is not
<br>C, they should grab the bluetooth specification write their own<br>func=
tion which tells what each error code means...<br><br>or<br><br>since dbus =
errors consist of error_name + error_message you could put<br>something mea=
ningful in the error_message, and eventually append an
<br>additional field with the error code to the message as well ( if the<br=
>application wants to treat some error codes in a particular way ) this<br>=
seems ok with the dbus specification which only says (if I remember<br>
correctly) that if the first field in an error message is of type<br>'strin=
g' that string will be treated as the error message, and doesn't<br>say any=
thing about additional fields.<br><br>regards<br><br><br>------------------=
-------------------------------------
<br>SF.Net email is sponsored by:<br>Tame your development challenges with =
Apache's Geronimo App Server.<br>Download it for free - -and be entered to =
win a 42&quot; plasma tv or your very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click =
here to play:=20
<a href=3D"http://sourceforge.net/geronimo.php">http://sourceforge.net/gero=
nimo.php</a><br>_______________________________________________<br>Bluez-de=
vel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bl=
uez-devel@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_834_9015266.1127310775478--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
