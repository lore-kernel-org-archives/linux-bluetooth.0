Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <94e407f00602120058o147272a0je15daf044d3b6047@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Can't discover device
In-Reply-To: <1139734129.4292.4.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12722_31581322.1139734682700"
References: <94e407f00602120041s3f64513dm642715738db38d10@mail.gmail.com>
	 <1139734129.4292.4.camel@localhost>
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
Date: Sun, 12 Feb 2006 16:58:02 +0800

------=_Part_12722_31581322.1139734682700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel

The computer that cannot be discovered does NOT have ISCAN and PSCAN
running. I checked hcid.conf, its set to enable. How do I make sure its
running?

Regards
Arpit

On 2/12/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arpit,
>
> > I'm running two computers on Fedora Core 4. Both have one USB
> > bluetooth adaptor connected to them.
> >
> > The problem is from one computer if I do a hcitool scan, I can see the
> > other computer but from the other computer, if I do a hcitool scan I
> > don't see anything.
> >
> > Any idea on what could be wrong here?
>
> check if PSCAN (page scan) and ISCAN (inquiry scan) is activated on both
> sides.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_12722_31581322.1139734682700
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel<br>
<br>
The computer that cannot be discovered does NOT have ISCAN and PSCAN
running. I checked hcid.conf, its set to enable. How do I make sure its
running?<br>
<br>
Regards<br>
Arpit<br><br><div><span class=3D"gmail_quote">On 2/12/06, <b class=3D"gmail=
_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org"=
>marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
Hi Arpit,<br><br>&gt; I'm running two computers on Fedora Core 4. Both have=
 one USB<br>&gt; bluetooth adaptor connected to them.<br>&gt;<br>&gt; The p=
roblem is from one computer if I do a hcitool scan, I can see the<br>&gt; o=
ther computer but from the other computer, if I do a hcitool scan I
<br>&gt; don't see anything.<br>&gt;<br>&gt; Any idea on what could be wron=
g here?<br><br>check if PSCAN (page scan) and ISCAN (inquiry scan) is activ=
ated on both<br>sides.<br><br>Regards<br><br>Marcel<br><br><br><br><br>
-------------------------------------------------------<br>This SF.net emai=
l is sponsored by: Splunk Inc. Do you grep through log files<br>for problem=
s?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search engine that mak=
es<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;=
&nbsp;DOWNLOAD SPLUNK!
<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D103432&a=
mp;bid=3D230486&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=3Dlnk=
&amp;kid=3D103432&amp;bid=3D230486&amp;dat=3D121642</a><br>________________=
_______________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_12722_31581322.1139734682700--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
