Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510111307r3bf0822aya57f5003efd8f655@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: hcid patch (remote name and connections)
In-Reply-To: <434C16C4.3040009@csr.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5583_208901.1129061243498"
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com>
	 <e1effdeb0510110749jf47c023ne87567fba3d65937@mail.gmail.com>
	 <434C16C4.3040009@csr.com>
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
Date: Tue, 11 Oct 2005 17:07:23 -0300

------=_Part_5583_208901.1129061243498
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It's from hcitool code :)
I will replace by "7", the maximum number of connections. Is it ok?

Regards,
Claudio

On 10/11/05, Steven Singer <steven.singer@csr.com> wrote:
>
> Claudio Takahasi wrote:
> > + if (!(cl =3D malloc(10 * sizeof(*ci) + sizeof(*cl)))) {
> ...
> > + cl->conn_num =3D 10;
>
> *cough* magic number *cough*
>
> - Steven
> --
>
>
> This message has been scanned for viruses by BlackSpider MailControl -
> www.blackspider.com <http://www.blackspider.com>
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

------=_Part_5583_208901.1129061243498
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It's from hcitool code :)<br>
I will replace by &quot;7&quot;, the maximum number of connections. Is it o=
k?<br>
<br>
Regards,<br>
Claudio<br><br><div><span class=3D"gmail_quote">On 10/11/05, <b class=3D"gm=
ail_sendername">Steven Singer</b> &lt;<a href=3D"mailto:steven.singer@csr.c=
om">steven.singer@csr.com</a>&gt; wrote:</span><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
Claudio Takahasi wrote:<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(cl =3D mall=
oc(10 * sizeof(*ci) + sizeof(*cl)))) {<br>...<br>&gt; +&nbsp;&nbsp;&nbsp;&n=
bsp; cl-&gt;conn_num =3D 10;<br><br>*cough* magic number *cough*<br><br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Steven<br>--<br><br><br>This=
 message has been scanned for viruses by BlackSpider MailControl -=20
<a href=3D"http://www.blackspider.com">www.blackspider.com</a><br><br><br>-=
------------------------------------------------------<br>This SF.Net email=
 is sponsored by:<br>Power Architecture Resource Center: Free content, down=
loads, discussions,
<br>and more. <a href=3D"http://solutions.newsforge.com/ibmarch.tmpl">http:=
//solutions.newsforge.com/ibmarch.tmpl</a><br>_____________________________=
__________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-d=
evel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br=
>
---------------------------------------------------------<br>Claudio Takaha=
si<br>Nokia's Institute of Technology - INdT<br><a href=3D"mailto:claudio.t=
akahasi@indt.org.br">claudio.takahasi@indt.org.br</a><br>

------=_Part_5583_208901.1129061243498--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
