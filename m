Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05092805194782ba65@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch(Error Messages)
In-Reply-To: <1127896709.5321.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2105_7653552.1127909968014"
References: <e1effdeb05092607273355fded@mail.gmail.com>
	 <1127896709.5321.7.camel@localhost.localdomain>
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
Date: Wed, 28 Sep 2005 09:19:28 -0300

------=_Part_2105_7653552.1127909968014
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

it's possible use uint32 without problems.

- 0x00000000 - 0x000000FF Bluetooth error codes (current situation)
- 0x00000100 - 0x0000FFFF Reserved for future Bluetooth error codes
extension
- 0x00010000 - 0x0001FFFF D-Bus errors
- 0x00020000 - 0x0003FFFF System errors (0x00020000 + system error value)
- 0x00040000 - 0xFFFFFFFF Reserved to future error classes

In order to make easier discover the error type, I defined the error values
range
considering bitwise operations.

Regards,
Claudio.


On 9/28/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > 2. Use error ranges
> > Define only one error message name(org.bluez.EFailed), signature:
> > sq
> > - 0x0000 - 0x00FF Bluetooth error codes
> > - 0x0100 - 0x01FF D-Bus errors
> > - 0x0200 - 0x02FF System errors (0x0200 + system error value)
> > - 0x0300 - 0xFFFF reserved to future error classes
>
> I like to go with this approach and a name like org.bluez.Error, because
> this makes it easy to map the Bluetooth errors. Question is if we should
> use uint16 or uint32. Maybe the Bluetooth specification extend their
> error codes to an uint16 instead of an uint8 and then I like to have a
> free space in this range. Do you think this is a problem?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_2105_7653552.1127909968014
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
it's possible use uint32 without problems.<br>
<br>
- 0x00000000 - 0x000000FF Bluetooth error codes (current situation)<br>
- 0x00000100 - 0x0000FFFF Reserved for future Bluetooth error codes extensi=
on<br>
- 0x00010000 - 0x0001FFFF D-Bus errors<br>
- 0x00020000 - 0x0003FFFF System errors (0x00020000 + system error value)<b=
r>
- 0x00040000 - 0xFFFFFFFF Reserved to future error classes<br>
<br>
In order to make easier discover the error type, I defined the error values=
 range <br>
considering bitwise operations.<br>
<br>
Regards,<br>
Claudio.<br>
<br><br><div><span class=3D"gmail_quote">On 9/28/05, <b class=3D"gmail_send=
ername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marc=
el@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi Claudio,<br><br>&gt; 2. Use error ranges<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=
Define only one error message name(org.bluez.EFailed), signature:<br>&gt; s=
q<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;- 0x0000 - 0x00FF Bluetooth error codes<br=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp;- 0x0100 - 0x01FF D-Bus errors
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;- 0x0200 - 0x02FF System errors (0x0200 + s=
ystem error value)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;- 0x0300 - 0xFFFF reserve=
d to future error classes<br><br>I like to go with this approach and a name=
 like org.bluez.Error, because<br>this makes it easy to map the Bluetooth e=
rrors. Question is if we should
<br>use uint16 or uint32. Maybe the Bluetooth specification extend their<br=
>error codes to an uint16 instead of an uint8 and then I like to have a<br>=
free space in this range. Do you think this is a problem?<br><br>Regards
<br><br>Marcel<br><br><br><br><br>-----------------------------------------=
--------------<br>This SF.Net email is sponsored by:<br>Power Architecture =
Resource Center: Free content, downloads, discussions,<br>and more. <a href=
=3D"http://solutions.newsforge.com/ibmarch.tmpl">
http://solutions.newsforge.com/ibmarch.tmpl</a><br>________________________=
_______________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bl=
uez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></di=
v><br>

------=_Part_2105_7653552.1127909968014--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
