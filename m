Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50608231355x7039baax7a28868d8e99ee1@mail.gmail.com>
Date: Wed, 23 Aug 2006 17:55:14 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <c49421c50608231349v55a0a6a3ibf8a80e1937a6d@mail.gmail.com>
MIME-Version: 1.0
References: <c49421c50608161305l2785e2bdvbadde3fefeddbaa0@mail.gmail.com>
	<1155769355.4075.88.camel@aeonflux.holtmann.net>
	<c49421c50608231349v55a0a6a3ibf8a80e1937a6d@mail.gmail.com>
Subject: Re: [Bluez-users] pand problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1949105554=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1949105554==
Content-Type: multipart/alternative;
	boundary="----=_Part_52841_10671720.1156366514006"

------=_Part_52841_10671720.1156366514006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some more details about the problem:

Well, first I start both hosts. In the server one, I load the bnep module
and start the pand daemon as NAP. In the client side, I type "hcitool cc
......" with the address of the server. The connection goes fine. Then I
request a pan connection with "pand -c ......" and everything goes fine ok.

At this moment, I kill the pand processes on both client and server, and
disconnect them by typing "hcitool dc ...." the server address in the client
host. Now I repeat the whole process for connecting  the hosts, and the pand
connection is no more stablished.

Loreno

On 8/23/06, Loreno Oliveira <lorenooliveira@gmail.com> wrote:
>
> Hi Marcel,
>
> here are the dumps of both client and server hosts in two situations: pand
> connects successfuly and the problem I'm experiencing.
>
> I've read the dumps and could not determine what can be going wrong. Do
> you have any hint?
>
> Thanks in advance!
>
> Loreno
>
>
> On 8/16/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Loreno,
> >
> > > I'm getting troubles with pand. On the server side I start the pand
> > > daemon in the NAP role. On the client side I try to connect to the
> > > server using:
> > >
> > > # pand -c xx:xx:xx:xx:xx:xx
> > >
> > > The command returns exit value 0 and no error/warning message is
> > > printed on screen, but when I type:
> > >
> > > # pand -l
> > >
> > > there is no output.
> > >
> > > Does anybody knows what is going wrong here??
> >
> > run "hcidump -X -V" as root to see what happens.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services,
> > security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
>

------=_Part_52841_10671720.1156366514006
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some more details about the problem:<br><br>Well, first I start both hosts. In the server one, I load the bnep module and start the pand daemon as NAP. In the client side, I type &quot;hcitool cc ......&quot; with the address of the server. The connection goes fine. Then I request a pan connection with &quot;pand -c ......&quot; and everything goes fine ok. 
<br><br>At this moment, I kill the pand processes on both client and server, and disconnect them by typing &quot;hcitool dc ....&quot; the server address in the client host. Now I repeat the whole process for connecting&nbsp; the hosts, and the pand connection is no more stablished.
<br><br>Loreno<br><br><div><span class="gmail_quote">On 8/23/06, <b class="gmail_sendername">Loreno Oliveira</b> &lt;<a href="mailto:lorenooliveira@gmail.com">lorenooliveira@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Hi Marcel,<br><br>here are the dumps of both client and server hosts in two situations: pand connects successfuly and the problem I'm experiencing.<br><br>I've read the dumps and could not determine what can be going wrong. Do you have any hint?
<br><br>Thanks in advance!<br></div><div><span class="sg"><br>Loreno</span></div><div><span class="e" id="q_10d3ccb99260f060_2"><br><br><div><span class="gmail_quote">On 8/16/06, <b class="gmail_sendername">Marcel Holtmann
</b> &lt;<a href="mailto:marcel@holtmann.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Loreno,<br><br>&gt; I'm getting troubles with pand. On the server side I start the pand<br>

&gt; daemon in the NAP role. On the client side I try to connect to the<br>&gt; server using:<br>&gt;<br>&gt; # pand -c xx:xx:xx:xx:xx:xx<br>&gt;<br>&gt; The command returns exit value 0 and no error/warning message is<br>

&gt; printed on screen, but when I type:<br>&gt;<br>&gt; # pand -l<br>&gt;<br>&gt; there is no output.<br>&gt;<br>&gt; Does anybody knows what is going wrong here??<br><br>run &quot;hcidump -X -V&quot; as root to see what happens.
<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

</span></div><br clear="all"></blockquote></div><br>

------=_Part_52841_10671720.1156366514006--


--===============1949105554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1949105554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1949105554==--
