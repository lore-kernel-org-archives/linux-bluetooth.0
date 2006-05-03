Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0605031035y2f16e8a3h4880c1285fd77bac@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO voice data
In-Reply-To: <fe0a97c20605030507l73658f95j730de48763c5a88e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6030_25559737.1146677731805"
References: <fe0a97c20605030507l73658f95j730de48763c5a88e@mail.gmail.com>
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
Date: Wed, 3 May 2006 13:35:31 -0400

------=_Part_6030_25559737.1146677731805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I believe the answer was along the lines of "That's a really bad idea.
Don't use SCO for transparent data"

If you still persist in this madness, then take a look at hciconfig voice t=
o
change the air coding format.  I've never done this myself...

-albert

On 5/3/06, Sowmya Gattupalli <sowmya.gattupalli@gmail.com> wrote:
>
> Hi ,
> I know this query was posted before....but there was no proper
> answer....or may be I cudn't understand...
>
> How can I get the same data on the other side of the SCO link.??
> Can I just get the actual data by removing the CVSD codec in between??
>
> regards
> Soumya
>
>

------=_Part_6030_25559737.1146677731805
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I believe the answer was along the lines of &quot;That's a really bad idea.=
&nbsp; Don't use SCO for transparent data&quot;<br><br>If you still persist=
 in this madness, then take a look at hciconfig voice to change the air cod=
ing format.&nbsp; I've never done this myself...
<br><br>-albert<br><br><div><span class=3D"gmail_quote">On 5/3/06, <b class=
=3D"gmail_sendername">Sowmya Gattupalli</b> &lt;<a href=3D"mailto:sowmya.ga=
ttupalli@gmail.com">sowmya.gattupalli@gmail.com</a>&gt; wrote:</span><block=
quote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 2=
04); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div style=3D"direction: ltr;">Hi , <br>I know this query was posted before=
....but there was no proper answer....or may be I cudn't understand... <br>=
<br>How can I get the same data on the other side of the SCO link.?? <br>
Can I just get the actual data by removing the CVSD codec in between??=20
<br><br>regards<br>Soumya<br><br>

</div></blockquote></div><br>

------=_Part_6030_25559737.1146677731805--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
