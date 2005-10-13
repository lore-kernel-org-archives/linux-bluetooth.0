Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510131036v1ff73b7an369333a71bf0cca8@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Set D-BUS signal paths according to local device
In-Reply-To: <20051013172036.GA24585@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1768_33228099.1129224974502"
References: <20051013172036.GA24585@localhost.localdomain>
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
Date: Thu, 13 Oct 2005 14:36:14 -0300

------=_Part_1768_33228099.1129224974502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Johan,

I didn't analized all the patch content, but I guess it's possible change
the signature of the functions passing the dev id instead of receive the BT
address and convert it.

What do you think?

Regards,
Claudio

On 10/13/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
>
> Hi,
>
> The attached patch sets the object path of D-BUS signals according to
> the local device id, e.g. /org/bluez/Manager/hci0/Controller. It also
> removes the local address arguments from those signals.
>
> Johan
>
>
>


--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_1768_33228099.1129224974502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Johan,<br>
<br>
I didn't analized all the patch content, but I guess it's possible
change the signature of the functions passing the dev id instead of
receive the BT address and convert it.<br>
<br>
What do you think?<br>
<br>
Regards,<br>
Claudio<br><br><div><span class=3D"gmail_quote">On 10/13/05, <b class=3D"gm=
ail_sendername">Johan Hedberg</b> &lt;<a href=3D"mailto:johan.hedberg@nokia=
.com">johan.hedberg@nokia.com</a>&gt; wrote:</span><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>The attached patch sets the object path of D-BUS signals accordi=
ng to<br>the local device id, e.g. /org/bluez/Manager/hci0/Controller. It a=
lso<br>removes the local address arguments from those signals.<br><br>Johan
<br><br><br></blockquote></div><br><br clear=3D"all"><br>-- <br>-----------=
----------------------------------------------<br>Claudio Takahasi<br>Nokia=
's Institute of Technology - INdT<br><a href=3D"mailto:claudio.takahasi@ind=
t.org.br">
claudio.takahasi@indt.org.br</a><br>

------=_Part_1768_33228099.1129224974502--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
