Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510140649h6e9b504es2f1e76d2d622cad8@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS-PATCH] list registered paths
In-Reply-To: <1129293738.5057.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12592_26898634.1129297749015"
References: <e1effdeb0510140530l6055351ak7505758983378586@mail.gmail.com>
	 <1129293738.5057.61.camel@localhost.localdomain>
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
Date: Fri, 14 Oct 2005 10:49:09 -0300

------=_Part_12592_26898634.1129297749015
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/14/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > The attached patch implements the service for list the registered
> > paths under the path /org/bluez/Manager.
> >
> > The message request signature can be:
> > 1. ListPaths() - list all paths under /org/bluez/Manager
> > 2. ListPaths(String), The string is the relative path. eg: "hci0",
> > "default" - list all paths provided by one adapter
>
> do we really need this?


[Claudio Takahasi]
How clients will discover the active paths if we change the format?
eg: "hci0" to "AA_BB_CC_DD_EE_FF"

The developers can use the dbus.h constants to compose the path, but if we
provide this service. It will be possible check if the path is active and/o=
r
check if it provide a specific profile(pan,rfcomm).

When a client send a msg to a unregistered path, it will receive a reply
with "Device path is not registered" message.

I agree that at the moment this service is not much useful, the final
decision is yours :)


> Other minor changes:
> > - removed some logs
> > - added verification for dbus_connection_list_registered function. It
> > can return FALSE if there is no memory
> > to allocate the child entries
>
> Don't send combined patches. If you have cleanups then send them as a
> separate patch.


[Claudio Takahasi]
Ok. I will send soon.

Regards
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



--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_12592_26898634.1129297749015
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 10/14/05, <b class=3D"gmail_sen=
dername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">mar=
cel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">

Hi Claudio,<br><br>&gt; The attached patch implements the service for list =
the registered<br>&gt; paths under the path /org/bluez/Manager.<br>&gt;<br>=
&gt; The message request signature can be:<br>&gt; 1. ListPaths() - list al=
l paths under /org/bluez/Manager
<br>&gt; 2. ListPaths(String), The string is the relative path. eg: &quot;h=
ci0&quot;,<br>&gt; &quot;default&quot; - list all paths provided by one ada=
pter<br><br>do we really need this?</blockquote><div><br>
[Claudio Takahasi]<br>
How clients will discover the active paths if we change the format? <br>eg:=
 &quot;hci0&quot; to &quot;AA_BB_CC_DD_EE_FF&quot;<br>
<br>
The developers can use the dbus.h constants to compose the path, but if
we provide this service. It will be possible check if the path is
active and/or&nbsp; check if it provide a specific profile(pan,rfcomm).<br>
<br>
When a client send a msg to a unregistered path, it will receive a reply wi=
th &quot;Device path is not registered&quot; message. <br>
<br>
I agree that at the moment this service is not much useful, the final decis=
ion is yours :)<br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Ot=
her minor changes:<br>&gt; - removed some logs<br>&gt; - added verification=
 for dbus_connection_list_registered function. It
<br>&gt; can return FALSE if there is no memory<br>&gt;&nbsp;&nbsp; to allo=
cate the child entries<br><br>Don't send combined patches. If you have clea=
nups then send them as a<br>separate patch.</blockquote><div><br>
[Claudio Takahasi]<br>
Ok. I will send soon. <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Regards=
<br><br>Marcel<br><br><br>
<br><br>-------------------------------------------------------<br>This SF.=
Net email is sponsored by:<br>Power Architecture Resource Center: Free cont=
ent, downloads, discussions,<br>and more. <a href=3D"http://solutions.newsf=
orge.com/ibmarch.tmpl">

http://solutions.newsforge.com/ibmarch.tmpl</a><br>________________________=
_______________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bl=
uez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>

<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></di=
v><br><br clear=3D"all"><br>-- <br>----------------------------------------=
-----------------
<br>Claudio Takahasi<br>Nokia's Institute of Technology - INdT<br><a href=
=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@indt.org.br</a><b=
r>


------=_Part_12592_26898634.1129297749015--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
