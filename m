Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <45bf5ff80512101055p7ae07d0bp6063dc667b3d2425@mail.gmail.com>
From: Artur Almeida <fidalgo.a@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Inquiry Time
In-Reply-To: <439823BF.1@csr.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21758_29654475.1134240958420"
References: <45bf5ff80512070503g6cfc5189hec21ab22768ed9cd@mail.gmail.com>
	 <439823BF.1@csr.com>
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
Date: Sat, 10 Dec 2005 18:55:58 +0000

------=_Part_21758_29654475.1134240958420
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Steven

 Thank you for your email, that clear my doubt. Now my question is, can i
edit or have any sort of control over that parameter? Sometimes this
inquirie lasts forever (Over a minute) and causes a functional problem in
the application that im developing since i only receive the list of
discovered macaddress=B4s once the inquiry complete event arrives. At work
where we have a lot of bluetooth devices from mobiles to headsets,laptops ,
keyboards ...etc ...the inquirie process can take more then 5 minutes and
sometimes it doesnt finish, i have to cancel it manually.

Thank you
Regards
Artur

On 12/8/05, Steven Singer <steven.singer@csr.com> wrote:
>
> Artur Almeida wrote:
> >  The Bt specification says that once you send a inquiry request, you
> should
> > get all the responses +-11 seconds. Many times i send an inquiry and it
> > lasts a lot more then that (Sometimes it goes over a minute). Can
> someone
> > explain how can i limit the inquiry time to the 11 sec window? Why does
> this
> > happens?  Also, where can i find a detailed document with all the
> features
> > and parameters of the hciconfig?
>
> I think the way the spec phrases it is that you must inquire for at least
> 10.24 seconds to have a good probability of picking up all devices.
> However, it doesn't say that the inquiry process will stop after 10.24
> seconds. The host specifies how long it wants to inquire for in one of
> the parameters to HCI_Inquiry. If the host says to inquire for 30
> seconds (or whatever) then the chip quite happily will.
>
> hcidump -X -V should reveal the parameters to the HCI_Inquiry command.
> From there you should be able to work out how long the chip has been
> told to inquire for.
>
>         - Steven
> --
>
>
> This message has been scanned for viruses by BlackSpider MailControl -
> www.blackspider.com
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_21758_29654475.1134240958420
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Steven<br><br>&nbsp;Thank you for your email, that clear my doubt. No=
w my question is, can i edit or have any sort of control over that paramete=
r? Sometimes this inquirie lasts forever (Over a minute) and causes a funct=
ional problem in the application that im developing since i only receive th=
e list of discovered macaddress=B4s once the inquiry complete event arrives=
. At work where we have a lot of bluetooth devices from mobiles to headsets=
,laptops , keyboards ...etc ...the inquirie process can take more then 5 mi=
nutes and sometimes it doesnt finish, i have to cancel it manually.
<br><br>Thank you<br>Regards<br>Artur<br><br><div><span class=3D"gmail_quot=
e">On 12/8/05, <b class=3D"gmail_sendername">Steven Singer</b> &lt;<a href=
=3D"mailto:steven.singer@csr.com">steven.singer@csr.com</a>&gt; wrote:</spa=
n><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Artur Almeida wrote:<br>&gt;&nbsp;&nbsp;The Bt specification says that once=
 you send a inquiry request, you should<br>&gt; get all the responses +-11 =
seconds. Many times i send an inquiry and it<br>&gt; lasts a lot more then =
that (Sometimes it goes over a minute). Can someone
<br>&gt; explain how can i limit the inquiry time to the 11 sec window? Why=
 does this<br>&gt; happens?&nbsp;&nbsp;Also, where can i find a detailed do=
cument with all the features<br>&gt; and parameters of the hciconfig?<br><b=
r>I think the way the spec phrases it is that you must inquire for at least
<br>10.24 seconds to have a good probability of picking up all devices.<br>=
However, it doesn't say that the inquiry process will stop after 10.24<br>s=
econds. The host specifies how long it wants to inquire for in one of<br>
the parameters to HCI_Inquiry. If the host says to inquire for 30<br>second=
s (or whatever) then the chip quite happily will.<br><br>hcidump -X -V shou=
ld reveal the parameters to the HCI_Inquiry command.<br>From there you shou=
ld be able to work out how long the chip has been
<br>told to inquire for.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;- Steven<br>--<br><br><br>This message has been scanned for viruses by=
 BlackSpider MailControl - <a href=3D"http://www.blackspider.com">www.black=
spider.com</a><br><br><br>-------------------------------------------------=
------
<br>This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX se=
arch engine that makes<br>searching your log files as easy as surfing the&n=
bsp;&nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!
<br><a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;o=
p=3Dclick">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3D=
click</a><br>_______________________________________________<br>Bluez-devel=
 mailing list
<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</=
a>
<br></blockquote></div><br>

------=_Part_21758_29654475.1134240958420--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
