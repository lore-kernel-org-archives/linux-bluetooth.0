Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <be976db60611291454h19238287s4254b3690d0c47af@mail.gmail.com>
Date: Wed, 29 Nov 2006 14:54:38 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0611291259350.1191@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<1164536005.25914.8.camel@aeonflux.holtmann.net>
	<002801c7125f$7197b7f0$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0611281118300.29749@redbean.intranet.gw-instruments.de>
	<000701c712dc$8e44ff20$3978f052@kayleigh>
	<Pine.LNX.4.63.0611281215240.29749@redbean.intranet.gw-instruments.de>
	<001201c712e9$3ae9cfb0$3978f052@kayleigh>
	<Pine.LNX.4.63.0611291259350.1191@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] Master / Slave question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0091698677=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0091698677==
Content-Type: multipart/alternative;
	boundary="----=_Part_54369_17481376.1164840878368"

------=_Part_54369_17481376.1164840878368
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I read/heard somewhere that newer silicons that supports automatic
master/slave role switch creates problems in the HCI layer and connections
could get dropped if you have a BT radio that supports that auto-switching.

Can someone confirm or discredit this?


On 11/29/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>
>
> Salut Oli,
>
> > > For a server application like yours I would suggest to use the role
> > > switch feature in a more relaxed way. So, once a connection comes in
> try
> > > to do a role switch. If it succeed it is fine and you're able to
> accept an
> > > additional connection. If it fails you're out of resources but at
> least
> > > can service the current connection.
> > >
> > > However, if I understand it right you can not set this behaviour in
> > > hcid.conf. You have to implement it in your application.
> >
> > What do you mean by implementing this in my application ? Is it
> > possible to manually deal with this in my server application ? Would you
> > have a location with examples ?
> >
> Actualy, the only sample I'm aware of for such things is hcid. I've not
> checked how it handles the case when lm master is set and the remote
> device rejects the role switch. From the documentation I assume it will
> cancel the connection, but this may be wrong.
> Marcel ??
> If it just ignores a rejected role switch and keeps the connection you
> have the behaviour I outlined above.
> If it cancel the connection may be the easiest way is to modify hcid.
>
> Peter
>
>
> |       Peter Wippich                   Voice: +49 30 46776411          |
> |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> |       D-13355 Berlin  / Germany                                       |
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_54369_17481376.1164840878368
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>I read/heard somewhere that newer silicons that supports automatic master/slave role switch creates problems in the HCI layer and connections could get dropped if you have a BT radio that supports that auto-switching.<br>
<br>Can someone confirm or discredit this?<br><br><br><div><span class="gmail_quote">On 11/29/06, <b class="gmail_sendername">Peter Wippich</b> &lt;<a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Salut Oli,<br><br>&gt; &gt; For a server application like yours I would suggest to use the role
<br>&gt; &gt; switch feature in a more relaxed way. So, once a connection comes in try<br>&gt; &gt; to do a role switch. If it succeed it is fine and you're able to accept an<br>&gt; &gt; additional connection. If it fails you're out of resources but at least
<br>&gt; &gt; can service the current connection.<br>&gt; &gt;<br>&gt; &gt; However, if I understand it right you can not set this behaviour in<br>&gt; &gt; hcid.conf. You have to implement it in your application.<br>&gt;
<br>&gt; What do you mean by implementing this in my application ? Is it<br>&gt; possible to manually deal with this in my server application ? Would you<br>&gt; have a location with examples ?<br>&gt;<br>Actualy, the only sample I'm aware of for such things is hcid. I've not
<br>checked how it handles the case when lm master is set and the remote<br>device rejects the role switch. From the documentation I assume it will<br>cancel the connection, but this may be wrong.<br>Marcel ??<br>If it just ignores a rejected role switch and keeps the connection you
<br>have the behaviour I outlined above.<br>If it cancel the connection may be the easiest way is to modify hcid.<br><br>Peter<br><br><br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Peter Wippich&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Voice: +49 30 46776411&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G&amp;W Instruments GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fax:&nbsp;&nbsp; +49 30 46776419&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gustav-Meyer-Allee 25, Geb. 12&nbsp;&nbsp;Email: <a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&nbsp;&nbsp; |<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-13355 Berlin&nbsp;&nbsp;/ Germany&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br><br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_54369_17481376.1164840878368--


--===============0091698677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0091698677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0091698677==--
