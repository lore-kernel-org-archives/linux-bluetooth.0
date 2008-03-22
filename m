Return-Path: <cyrus@holtmann.org>
Message-ID: <1ffb4b070803220226n35f4363dpd63491528914ab74@mail.gmail.com>
Date: Sat, 22 Mar 2008 05:26:57 -0400
From: "Mike Lee" <eemike@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100803210641h220d4de2md9392f7752796169@mail.gmail.com>
MIME-Version: 1.0
References: <1ffb4b070803202045w31d2ca9lcc66d0a51aef8c@mail.gmail.com>
	<2d5a2c100803210641h220d4de2md9392f7752796169@mail.gmail.com>
Subject: Re: [Bluez-devel] Is there any bluez audio source(a2src)
	implementation
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1428107694=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1428107694==
Content-Type: multipart/alternative;
	boundary="----=_Part_10848_8427806.1206178017320"

------=_Part_10848_8427806.1206178017320
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Luiz

Thanks, i found the audio source code. But when i compile the source, it
seems there are missing files. I search over the repository and git
snapshot, i could not find gsta2dpbin.c/h. but audio/Makefile refer to thes=
e
two files.

mv -f .deps/libgstbluetooth_la-gstrtpsbcpay.Tpo .deps/libgstbluetooth_la-
gstrtpsbcpay.Plo
make: *** No rule to make target `gsta2dpbin.c', needed by
`libgstbluetooth_la-gsta2dpbin.lo'.  Stop.

Regards,
Mike,Lee
On Fri, Mar 21, 2008 at 9:41 AM, Luiz Augusto von Dentz <
luiz.dentz@gmail.com> wrote:

> I've been working in the audio sink implementation (...Audio.Source
> interface),
> but because of the changes we are now doing for bluez 4.0 I left that
> unfinished.
>
> The code is available in my branch audio-source:
>
> http://git.infradead.org/users/vudentz/bluez-utils.git?a=3Dlog;h=3Drefs/h=
eads/audio-source
>
> I was already able to configure streams between 2 linux boxes, but
> there is no plugin to
> handle the streams yet.
>
> This task is also available in gsoc page, so any student interested may
> apply:
> http://wiki.bluez.org/wiki/GSoC2008
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computa=E7=E3o
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--=20
-----------
Mike Lee

------=_Part_10848_8427806.1206178017320
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Luiz<br><br>Thanks, i found the audio source code. But when i compile th=
e source, it seems there are missing files. I search over the repository an=
d git snapshot, i could not find gsta2dpbin.c/h. but audio/Makefile refer t=
o these two files. <br>
<br>mv -f .deps/libgstbluetooth_la-gstrtpsbcpay.Tpo .deps/libgstbluetooth_l=
a-gstrtpsbcpay.Plo<br>make: *** No rule to make target `gsta2dpbin.c&#39;, =
needed by `libgstbluetooth_la-gsta2dpbin.lo&#39;.&nbsp; Stop.<br><br>Regard=
s,<br>
Mike,Lee<br><div class=3D"gmail_quote">On Fri, Mar 21, 2008 at 9:41 AM, Lui=
z Augusto von Dentz &lt;<a href=3D"mailto:luiz.dentz@gmail.com">luiz.dentz@=
gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
I&#39;ve been working in the audio sink implementation (...Audio.Source int=
erface),<br>
but because of the changes we are now doing for bluez 4.0 I left that<br>
unfinished.<br>
<br>
The code is available in my branch audio-source:<br>
<a href=3D"http://git.infradead.org/users/vudentz/bluez-utils.git?a=3Dlog;h=
=3Drefs/heads/audio-source" target=3D"_blank">http://git.infradead.org/user=
s/vudentz/bluez-utils.git?a=3Dlog;h=3Drefs/heads/audio-source</a><br>
<br>
I was already able to configure streams between 2 linux boxes, but<br>
there is no plugin to<br>
handle the streams yet.<br>
<br>
This task is also available in gsoc page, so any student interested may app=
ly:<br>
<a href=3D"http://wiki.bluez.org/wiki/GSoC2008" target=3D"_blank">http://wi=
ki.bluez.org/wiki/GSoC2008</a><br>
<br>
--<br>
Luiz Augusto von Dentz<br>
Engenheiro de Computa=E7=E3o<br>
<br>
-------------------------------------------------------------------------<b=
r>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=
=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sour=
ceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br=
>
</blockquote></div><br><br clear=3D"all"><br>-- <br>-----------<br>Mike Lee

------=_Part_10848_8427806.1206178017320--


--===============1428107694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1428107694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1428107694==--
