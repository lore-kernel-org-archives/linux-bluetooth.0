Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0609070921q586dfa5coaf5e8cf5eceacecb@mail.gmail.com>
Date: Thu, 7 Sep 2006 12:21:46 -0400
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200609071125.10146.jcuesta@pindiatec.com>
MIME-Version: 1.0
References: <200609071125.10146.jcuesta@pindiatec.com>
Subject: Re: [Bluez-devel] problems starting to work with bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0891159807=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0891159807==
Content-Type: multipart/alternative;
	boundary="----=_Part_124298_4072622.1157646106375"

------=_Part_124298_4072622.1157646106375
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

dd is an HCI socket opened either with socket() or hci_open_dev()

to is a timeout, in milliseconds I think.

-albert

On 9/7/06, Javier Cuesta <jcuesta@pindiatec.com> wrote:
>
> HI jeff and thanks for your answer,
>
> Albert Huang's Web is helping me a lot but i still have some problems, Im
> trying to writte some simple code, just for starting to work with bluez,
> and
> im findin some problems ussing the libraries, for example:
>
> Im trying to writte the class of device using hci_write_class_of_dev(int
> dd,
> uint32_t cls, int to) im having problems ussing the libraries becouse i
> have
> found no documentation about what "dd" and "to" means(whats suposed to be
> sent to those variables and maybe whats that for).
>
> Im more interested in fidnding a documentation about the libraries
> themselfs
> so i can solve the problems that ill find in the future by my own than in
> knowing what those variables means.
>
> Thanks for your help again.
>
> Javier
>
> P.S.: im having lots of problems sending mails to the list, i ussually
> have to
> send the same mail from 3  to  4 times, hope they dont reach all to the
> list,
> =BFany idea why could that be happening?
>
> P.S.S. Im trying to start a new thread ebcouse im unable to answer to the
> mail
> that jeff answered me, maybe starting a new one it works
> --
> ******************************************************
> Javier Cuesta Ca=F1as
>
> PINDIATEC SL
> Cemcam Of. 114
> Pg. Trascueto s/n
> 39600 Camargo -Cantabria- Espa=F1a
> Tel. +34 942059901 Fax: +34 942059902
> email: jcuesta@pindiatec.com
> ******************************************************
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_124298_4072622.1157646106375
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

dd is an HCI socket opened either with socket() or hci_open_dev()<br><br>to=
 is a timeout, in milliseconds I think.<br><br>-albert<br><br><div><span cl=
ass=3D"gmail_quote">On 9/7/06, <b class=3D"gmail_sendername">Javier Cuesta<=
/b>
 &lt;<a href=3D"mailto:jcuesta@pindiatec.com">jcuesta@pindiatec.com</a>&gt;=
 wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">HI =
jeff and thanks for your answer,
<br><br>Albert Huang's Web is helping me a lot but i still have some proble=
ms, Im<br>trying to writte some simple code, just for starting to work with=
 bluez, and<br>im findin some problems ussing the libraries, for example:
<br><br>Im trying to writte the class of device using hci_write_class_of_de=
v(int dd,<br>uint32_t cls, int to) im having problems ussing the libraries =
becouse i have<br>found no documentation about what &quot;dd&quot; and &quo=
t;to&quot; means(whats suposed to be
<br>sent to those variables and maybe whats that for).<br><br>Im more inter=
ested in fidnding a documentation about the libraries themselfs<br>so i can=
 solve the problems that ill find in the future by my own than in<br>knowin=
g what those variables means.
<br><br>Thanks for your help again.<br><br>Javier<br><br>P.S.: im having lo=
ts of problems sending mails to the list, i ussually have to<br>send the sa=
me mail from 3&nbsp;&nbsp;to&nbsp;&nbsp;4 times, hope they dont reach all t=
o the list,<br>=BFany idea why could that be happening?
<br><br>P.S.S. Im trying to start a new thread ebcouse im unable to answer =
to the mail<br>that jeff answered me, maybe starting a new one it works<br>=
--<br>******************************************************<br>Javier Cues=
ta Ca=F1as
<br><br>PINDIATEC SL<br>Cemcam Of. 114<br>Pg. Trascueto s/n<br>39600 Camarg=
o -Cantabria- Espa=F1a<br>Tel. +34 942059901 Fax: +34 942059902<br>email: <=
a href=3D"mailto:jcuesta@pindiatec.com">jcuesta@pindiatec.com</a><br>******=
************************************************
<br><br>-------------------------------------------------------------------=
------<br>Using Tomcat but need to do more? Need to support web services, s=
ecurity?<br>Get stuff done quickly with pre-integrated technology to make y=
our job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D12070=
9&amp;bid=3D263057&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=3D=
lnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-deve=
l@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_124298_4072622.1157646106375--


--===============0891159807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0891159807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0891159807==--
