Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
In-Reply-To: <1129986496.11428.36.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5812_7493715.1130159182986"
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
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
Date: Mon, 24 Oct 2005 11:06:22 -0200

------=_Part_5812_7493715.1130159182986
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I will send a cleanup patch before send the authentication improvements
patch.
Regarding the variable name, It should be better change to "dd" instead of
sock or sk. If you see the hcitool code standard you will notice that.

I noticed that there is a HCI raw socket created in the main.c file that
belongs to hcid structure.
Can I use it in the functions handle_display_conn_req and
handle_get_devices_req instead of create
a new one?

I will try apply you other suggestions.


Another point is the reply method for authentication. We need discuss how w=
e
should design it.
I am not a hcid expert therefore I would like ask you how we should
implement the authentication stuff.

Currently, the METHOD REPLY of the authentication doesn't consider the
authentication complete event.
In order to check it and reply after the authentication finishes it is
required store some D-Bus message
attributes(sender, serial, destination, ...). Another approach is send a
SIGNAL. Which approach do you prefer
send send a peer message(method reply) or a signal?

Regarding the pin helper. Are you planning support the "normal" helper and
the dbus helper? I am asking
this because the call_pin_helper function is blocking. If you are planning
support both, we have to try add
the pin helper file descriptor inside the hcid main loop.

Regards,
Claudio.

On 10/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > This is the initial patch to support authentication. There are
> > improving points
> > that I am planning send soon if everybody agree with my proposal.
>
> I applied the patch, but please do the coding style right. It seems that
> you still copy some parts for your old patches.
>
> if (sock > 0)
> close (sock);
>
> I first prefer to use "sk" instead of "sock", but this hasn't been used
> in full consistency and so I didn't corrected it. However you need to
> check for (sock >=3D 0) in case of a socket or file descriptor and we
> don't put a space between the function name and its parameters. So it
> must be called "close(sock);" in any case.
>
> It is also better to introduce more error labels than using another if
> statement to check for state of a file descriptor. We now if the file
> descriptor is valid or not.
>
> Regards
>
> Marcel
>
>
>


--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_5812_7493715.1130159182986
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I will send a cleanup patch before send the authentication improvements pat=
ch.<br>
Regarding the variable name, It should be better change to &quot;dd&quot; i=
nstead of <br>
sock or sk. If you see the hcitool code standard you will notice that. <br>
<br>
I noticed that there is a HCI raw socket created in the main.c file that be=
longs to hcid structure.<br>
Can I use it in the functions handle_display_conn_req and handle_get_device=
s_req instead of create <br>
a new one?<br>
<br>
I will try apply you other suggestions.<br>
<br>
<br>
Another point is the reply method for authentication. We need discuss how w=
e should design it.<br>
I am not a hcid expert therefore I would like ask you how we should impleme=
nt the authentication stuff.<br>
<br>
Currently, the METHOD REPLY of the authentication doesn't consider the auth=
entication complete event.<br>In order to check it and reply after the auth=
entication finishes it is required store some D-Bus message<br>
attributes(sender, serial, destination, ...). Another approach is send a SI=
GNAL.  Which approach do you prefer<br>
send send a peer message(method reply) or a signal?<br>
<br>
Regarding the pin helper. Are you planning support the &quot;normal&quot; h=
elper and the dbus helper? I am asking <br>
this because the call_pin_helper function is blocking. If you are planning =
support both, we have to try add<br>
the pin helper file descriptor inside the hcid main loop.<br>
<br>
Regards,<br>
Claudio.<br>
<br><div><span class=3D"gmail_quote">On 10/22/05, <b class=3D"gmail_sendern=
ame">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@=
holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">

Hi Claudio,<br><br>&gt; This is the initial patch to support authentication=
. There are<br>&gt; improving points<br>&gt; that I am planning send soon i=
f everybody agree with my proposal.<br><br>I applied the patch, but please =
do the coding style right. It seems that
<br>you still copy some parts for your old patches.<br><br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (sock &gt; 0)<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cl=
ose (sock);<br><br>I first prefer to use &quot;sk&quot; instead of &quot;so=
ck&quot;, but this hasn't been used<br>in full consistency and so I didn't =
corrected it. However you need to
<br>check for (sock &gt;=3D 0) in case of a socket or file descriptor and w=
e<br>don't put a space between the function name and its parameters. So it<=
br>must be called &quot;close(sock);&quot; in any case.<br><br>It is also b=
etter to introduce more error labels than using another if
<br>statement to check for state of a file descriptor. We now if the file<b=
r>descriptor is valid or not.<br><br>Regards<br><br>Marcel<br><br><br></blo=
ckquote></div><br><br clear=3D"all"><br>-- <br>----------------------------=
-----------------------------
<br>Claudio Takahasi<br>Nokia's Institute of Technology - INdT<br><a href=
=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@indt.org.br</a><b=
r>


------=_Part_5812_7493715.1130159182986--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
