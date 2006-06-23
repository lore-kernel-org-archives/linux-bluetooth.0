Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606222124t1fc03326w5c6995b4b37f3b76@mail.gmail.com>
Date: Fri, 23 Jun 2006 09:54:26 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150999928.13991.60.camel@localhost>
MIME-Version: 1.0
References: <44867199.2000409@mail.utexas.edu>
	<1149803817.4219.61.camel@localhost>
	<448A4385.4020809@mail.utexas.edu>
	<1149986039.5358.25.camel@aeonflux.holtmann.net>
	<4490C0F1.1090704@mail.utexas.edu>
	<1150874298.3950.15.camel@localhost>
	<449A297B.7010009@mail.utexas.edu>
	<1150959999.13991.9.camel@localhost>
	<d23110170606220734t5765d71aiae468fc768d6fc31@mail.gmail.com>
	<1150999928.13991.60.camel@localhost>
Subject: Re: [Bluez-devel] Latest 2.6.16-mh1 patch.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1480733841=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1480733841==
Content-Type: multipart/alternative;
	boundary="----=_Part_63702_33538446.1151036666378"

------=_Part_63702_33538446.1151036666378
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

On 6/22/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Ulisses,
>
> > > this seems that you have to wait for the link supervision timeout on
> the
> > > host side. Play a little bit with it. If you turn off the Bluetooth
> chip
> >
> > Which reminds me of one thing I read in the specification: the
> > sniff_max_interval must be less than the link supervision timeout
> > parameter. I can't say for sure we are taking care of this. Marcel?
>
> the upcoming Lisbon specification will take care of the missing
> possibility to see a changed link supervision timeout.




What kind of feature is it?
Is it a new event or something that host will receive when the link
supervision timeout changes?

Regards,
Mayank

------=_Part_63702_33538446.1151036666378
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>
<div><span class="gmail_quote">On 6/22/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Ulisses,<br><br>&gt; &gt; this seems that you have to wait for the link supervision timeout on the<br>&gt; &gt; host side. Play a little bit with it. If you turn off the Bluetooth chip
<br>&gt;<br>&gt; Which reminds me of one thing I read in the specification: the<br>&gt; sniff_max_interval must be less than the link supervision timeout<br>&gt; parameter. I can't say for sure we are taking care of this. Marcel?
<br><br>the upcoming Lisbon specification will take care of the missing<br>possibility to see a changed link supervision timeout. </blockquote>
<div>&nbsp;</div>
<div>&nbsp;</div><br>
<div>What kind of feature is it?</div>
<div>Is it a new event or something that host will receive when the link supervision timeout changes?</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div></div>

------=_Part_63702_33538446.1151036666378--


--===============1480733841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1480733841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1480733841==--
