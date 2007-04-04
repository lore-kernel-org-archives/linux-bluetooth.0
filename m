Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0704040030n5153bb4fw57a62db6894fb99@mail.gmail.com>
Date: Wed, 4 Apr 2007 08:30:32 +0100
From: "Meenakshi Seeballack" <meena2010@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-devel] L2CAP sockets, SDP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0114168273=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0114168273==
Content-Type: multipart/alternative;
	boundary="----=_Part_20601_5211418.1175671832962"

------=_Part_20601_5211418.1175671832962
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, I did not think I needed to use D-Bus with SDP and L2CAP.
Would someone please provide me more information on how the SDP sends data
with L2CAP as the transport layer?
Or point me to a direction where I can find the information?
Thanks in advance
Meena
---------------------------------------------

On 03/04/07, bluez-devel-request@lists.sourceforge.net <
bluez-devel-request@lists.sourceforge.net> wrote:
>
> Send Bluez-devel mailing list submissions to
>         bluez-devel@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.sourceforge.net/lists/listinfo/bluez-devel
> or, via email, send a message with subject or body 'help' to
>         bluez-devel-request@lists.sourceforge.net
>
> You can reach the person managing the list at
>         bluez-devel-owner@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bluez-devel digest..."
>
>
> Today's Topics:
>
>    1. Re: L2CAP sockets, SDP (Claudio Takahasi)
>    2. Re: problems with getting Plan tronics M1000 to pair on
>       Ubuntu system (Brad Midgley)
>    3. Re: RemoteNameRequested signal during discovery patch
>       (Marcel Holtmann)
>    4. used (chips)
>    5. Re: new sco flowcontrol patch (Brad Midgley)
>    6. Re: new sco flowcontrol patch (Marcel Holtmann)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 3 Apr 2007 09:10:44 -0300
> From: "Claudio Takahasi" <cktakahasi@gmail.com>
> Subject: Re: [Bluez-devel] L2CAP sockets, SDP
> To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
> Message-ID:
>         <e1effdeb0704030510q3f0e271ej2a94e270f35475eb@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> On 4/3/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
> > Hello,
> > I have tried to understand how to open an L2CAP socket, and have used
> the
> > BlueZ API. This is what I have got so far:
> > /*
> >  * l2cap_listen(l2cap_channel)
> >  * Use this channel as a listening post
> >  */
> > static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int
> lm,
> > int backlog)
> > {
> >     struct sockaddr_l2 addr;
> >     struct l2cap_options opts;
> >     int sk;
> >
> >     /* allocate a free socket */
> >     if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
> >         return -1;
> >
> >     /* open connection to remote device */
> >     memset(&addr, 0, sizeof(addr));
> >     addr.l2_family = AF_BLUETOOTH;
> >     bacpy(&addr.l2_bdaddr, bdaddr); /* update source address of socket
> */
> >     addr.l2_psm = htobs(psm);
> >
> >     /* bind socket to newly formed socket */
> >     if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> >         perror("ERROR: Could not bind socket");
> >         close(sk);
> >         return -1;
> >     }
> >
> >     setsockopt(sk, SOL_L2CAP, L2CAP_LM, &lm, sizeof(lm));
> >
> >     memset(&opts, 0, sizeof(opts));
> >     opts.imtu = HIDP_DEFAULT_MTU;
> >     opts.omtu = HIDP_DEFAULT_MTU;
> >     opts.flush_to = 0xffff;
> >
> >     setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts));
> >
> >     /* backlog: specifies the number of unaccepted connection
> >      * that the system will allow before refusing new connections
> >      */
> >     if (listen(sk, backlog) < 0) {
> >         close(sk);
> >         return -1;
> >     }
> >
> >     return sk;
> > }
> >
> > /*
> >  * l2cap_connect_req()
> >  * Establishes connection with specific socket
> >   * Request to establish connection from remote
> >  * communication partner.
> >  * Such a socket has to have been previously created
> >  * by an application with the command listen.
> >  */
> > static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short
> psm)
> > {
> >     struct sockaddr_l2 addr;
> >     struct l2cap_options opts;
> >     int sk;
> >
> >     /* socket allocation */
> >     if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
> >         perror("ERROR: Could not create socket");
> >         return -1;
> >
> >     memset(&addr, 0, sizeof(addr));
> >     addr.l2_family  = AF_BLUETOOTH;
> >     bacpy(&addr.l2_bdaddr, src); /*update source address of socket */
> >
> >     /* binds socket to psm */
> >     if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> >         close(sk);
> >         return -1;
> >     }
> >
> >     memset(&opts, 0, sizeof(opts));
> >     opts.imtu = HIDP_DEFAULT_MTU;
> >     opts.omtu = HIDP_DEFAULT_MTU;
> >     opts.flush_to = 0xffff;
> >
> >     setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts));
> >
> >     memset(&addr, 0, sizeof(addr));
> >     addr.l2_family  = AF_BLUETOOTH;
> >     bacpy(&addr.l2_bdaddr, dst);
> >     addr.l2_psm = htobs(psm);
> >
> >     if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> >         close(sk);
> >         return -1;
> >     }
> >
> >     return sk;
> > }
> >
> > /*
> >  * l2cap_accept()
> >  * (Permits incoming connection)
> >  * Blocks and accepts incoming connection
> >  * Function switches from BT_LISTEN to BT_CONNECTED
> >  */
> > static int l2cap_accept(int sk, bdaddr_t *bdaddr)
> > {
> >     struct sockaddr_l2 addr;
> >     socklen_t addrlen;
> >     int nsk;
> >
> >     memset(&addr, 0, sizeof(addr));
> >     addrlen = sizeof(addr);
> >
> >     // accept one connection
> >     if ((nsk = accept(sk, (struct sockaddr *) &addr, &addrlen)) < 0)
> >         return -1;
> >
> >     if (bdaddr)
> >         bacpy(bdaddr, &addr.l2_bdaddr);
> >
> >     return nsk;
> > }
> > --------------------
> > I am eventually aiming to register the mouse HID events, and send it via
> the
> > L2CAP socket to "control" another bluetooth-enabled PC.
> > How do I use an SDP service in conjunction with the existing L2CAP code?
> How
> > do I use the control channel (L2CAP_PSM_HIDP_CTRL 0x11) and the
> interrupt
> > channel (L2CAP_PSM_HIDP_INTR 0x13)
> > I think the control channel is used by SDP for signalling, (device
> > discovery); the interrupt channel is used for data transfer (service
> > discovery)
> > Thanks in advance for any help!
> >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
>
> Hi Meenakshi,
>
> Check the D-Bus Input service implementation: utils/input
> It contains the code that you want.
>
> BR,
> Claudio.
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 03 Apr 2007 11:21:34 -0600
> From: Brad Midgley <bmidgley@xmission.com>
> Subject: Re: [Bluez-devel] problems with getting Plan tronics M1000 to
>         pair on Ubuntu system
> To: BlueZ development <bluez-devel@lists.sourceforge.net>
> Message-ID: <46128D1E.2050609@xmission.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Brett
>
> > I tried pairing and then tried a connect - do I have a PIN issue?
>
> i got something similar when bluez-passkey-gnome needed to be installed
>
> brad
>
>
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 03 Apr 2007 21:05:56 +0200
> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: [Bluez-devel] RemoteNameRequested signal during discovery
>         patch
> To: BlueZ development <bluez-devel@lists.sourceforge.net>
> Message-ID: <1175627156.5815.402.camel@violet>
> Content-Type: text/plain
>
> Hi Johan,
>
> > > > A new version of the patch.
> > > > Are you okay with it ?
> > >
> > > the patch looks okay to me. However I prefer if Claudio or Johan can
> > > have an additional look.
> >
> > Looks good to me.
>
> feel free to commit it to the CVS then.
>
> Regards
>
> Marcel
>
>
>
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 3 Apr 2007 21:16:43 -0000
> From: "chips" <Jul@pbpfab.com>
> Subject: [Bluez-devel] used
> To: bluez-devel@lists.sourceforge.net
> Message-ID: <001201c77635$61395500$86572f97@davide10>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Choices multiple, mak management service kms activates. Conflict vistaiam
> school students.
> Comments seis office, you need read.
> Help, links by xpearlier, for pcsshared computer. Megatest fastest, modems
> revealed gps navigation, get from no.
> Word priced hungery crap, anonymous sucksdidnt say blue.
> Connecting computers going online. Thread subject author algo, de,
> slackware hay una que. Someone bringing their home, installing leaving
> again.
> Re newest greg mar kentucky sorta looked.
> Officially than, chips awful stick check. Certainly looks, set put.
> Students finally gone mad beyond bull shit apart high?
> Hunter blogs linux amp, open source news! Able as welland pieces? Tito,
> sites sport finance music.
> Wed, feb previous, message, messages.
> Groups direct phone, connection.
> Vbulletin copyright jelsoft scheduled. Hmmm wonder willhmmm, big higher
> normal reinstall rates like. Used anything another call moment able as.
> Worth trouble sysprep xml file hard.
> Its world server macs.
> Imminent arrival business enterprise, additions, dropped nasty little.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: not available
> Type: image/gif
> Size: 4634 bytes
> Desc: not available
>
> ------------------------------
>
> Message: 5
> Date: Tue, 03 Apr 2007 15:04:29 -0600
> From: Brad Midgley <bmidgley@xmission.com>
> Subject: Re: [Bluez-devel] new sco flowcontrol patch
> To: BlueZ development <bluez-devel@lists.sourceforge.net>
> Message-ID: <4612C15D.2080900@xmission.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Marcel
>
> > And why do we have to do "c->tx_timer.function = hci_sco_tx_timer" over
> > and over again. Isn't it enough if we set the timer function once after
> > init of the timer.
>
> should this happen directly inside hci_conn.c or through something like
> a notification?
>
> To use it in hci_conn I'd want to move the definition of the function
> there too but that may not be the right fit.
>
> Brad
>
>
>
>
>
>
> ------------------------------
>
> Message: 6
> Date: Tue, 03 Apr 2007 23:08:47 +0200
> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: [Bluez-devel] new sco flowcontrol patch
> To: BlueZ development <bluez-devel@lists.sourceforge.net>
> Message-ID: <1175634527.5815.409.camel@violet>
> Content-Type: text/plain
>
> Hi Brad,
>
> > > And why do we have to do "c->tx_timer.function = hci_sco_tx_timer"
> over
> > > and over again. Isn't it enough if we set the timer function once
> after
> > > init of the timer.
> >
> > should this happen directly inside hci_conn.c or through something like
> > a notification?
> >
> > To use it in hci_conn I'd want to move the definition of the function
> > there too but that may not be the right fit.
>
> actually hci_sco_tx_timer() should be in hci_conn.c. There is no need to
> put that into hci_core.c and make this so complex.
>
> Regards
>
> Marcel
>
>
>
>
>
> ------------------------------
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> ------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
> End of Bluez-devel Digest, Vol 12, Issue 9
> ******************************************
>

------=_Part_20601_5211418.1175671832962
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, I did not think I needed to use D-Bus with SDP and L2CAP.<br>Would someone please provide me more information on how the SDP sends data with L2CAP as the transport layer?<br>Or point me to a direction where I can find the information?
<br>Thanks in advance<br>Meena<br>---------------------------------------------<br><br><div><span class="gmail_quote">On 03/04/07, <b class="gmail_sendername"><a href="mailto:bluez-devel-request@lists.sourceforge.net">bluez-devel-request@lists.sourceforge.net
</a></b> &lt;<a href="mailto:bluez-devel-request@lists.sourceforge.net">bluez-devel-request@lists.sourceforge.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Send Bluez-devel mailing list submissions to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a><br><br>To subscribe or unsubscribe via the World Wide Web, visit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>or, via email, send a message with subject or body &#39;help&#39; to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel-request@lists.sourceforge.net">
bluez-devel-request@lists.sourceforge.net</a><br><br>You can reach the person managing the list at<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel-owner@lists.sourceforge.net">bluez-devel-owner@lists.sourceforge.net</a><br><br>When replying, please edit your Subject line so it is more specific
<br>than &quot;Re: Contents of Bluez-devel digest...&quot;<br><br><br>Today&#39;s Topics:<br><br>&nbsp;&nbsp; 1. Re: L2CAP sockets, SDP (Claudio Takahasi)<br>&nbsp;&nbsp; 2. Re: problems with getting Plan tronics M1000 to pair on<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu system (Brad Midgley)
<br>&nbsp;&nbsp; 3. Re: RemoteNameRequested signal during discovery patch<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Marcel Holtmann)<br>&nbsp;&nbsp; 4. used (chips)<br>&nbsp;&nbsp; 5. Re: new sco flowcontrol patch (Brad Midgley)<br>&nbsp;&nbsp; 6. Re: new sco flowcontrol patch (Marcel Holtmann)
<br><br><br>----------------------------------------------------------------------<br><br>Message: 1<br>Date: Tue, 3 Apr 2007 09:10:44 -0300<br>From: &quot;Claudio Takahasi&quot; &lt;<a href="mailto:cktakahasi@gmail.com">
cktakahasi@gmail.com</a>&gt;<br>Subject: Re: [Bluez-devel] L2CAP sockets, SDP<br>To: &quot;BlueZ development&quot; &lt;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:e1effdeb0704030510q3f0e271ej2a94e270f35475eb@mail.gmail.com">e1effdeb0704030510q3f0e271ej2a94e270f35475eb@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=ISO-8859-1; format=flowed
<br><br>On 4/3/07, Meenakshi Seeballack &lt;<a href="mailto:meena2010@gmail.com">meena2010@gmail.com</a>&gt; wrote:<br>&gt; Hello,<br>&gt; I have tried to understand how to open an L2CAP socket, and have used the<br>&gt; BlueZ API. This is what I have got so far:
<br>&gt; /*<br>&gt;&nbsp;&nbsp;* l2cap_listen(l2cap_channel)<br>&gt;&nbsp;&nbsp;* Use this channel as a listening post<br>&gt;&nbsp;&nbsp;*/<br>&gt; static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int lm,<br>&gt; int backlog)<br>&gt; {
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct l2cap_options opts;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int sk;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate a free socket */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* open connection to remote device */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; addr.l2_family = AF_BLUETOOTH;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, bdaddr); /* update source address of socket */
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; addr.l2_psm = htobs(psm);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* bind socket to newly formed socket */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror(&quot;ERROR: Could not bind socket&quot;);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(sk);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_LM, &amp;lm, sizeof(lm));<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;opts, 0, sizeof(opts));<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; opts.imtu
 = HIDP_DEFAULT_MTU;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; opts.omtu = HIDP_DEFAULT_MTU;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; opts.flush_to = 0xffff;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* backlog: specifies the number of unaccepted connection
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* that the system will allow before refusing new connections<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (listen(sk, backlog) &lt; 0) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(sk);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return sk;
<br>&gt; }<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* l2cap_connect_req()<br>&gt;&nbsp;&nbsp;* Establishes connection with specific socket<br>&gt;&nbsp;&nbsp; * Request to establish connection from remote<br>&gt;&nbsp;&nbsp;* communication partner.<br>&gt;&nbsp;&nbsp;* Such a socket has to have been previously created
<br>&gt;&nbsp;&nbsp;* by an application with the command listen.<br>&gt;&nbsp;&nbsp;*/<br>&gt; static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct l2cap_options opts;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int sk;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* socket allocation */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror(&quot;ERROR: Could not create socket&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; addr.l2_family&nbsp;&nbsp;= AF_BLUETOOTH;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, src); /*update source address of socket */<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* binds socket to psm */
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(sk);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;opts, 0, sizeof(opts));<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; opts.imtu
 = HIDP_DEFAULT_MTU;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; opts.omtu = HIDP_DEFAULT_MTU;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; opts.flush_to = 0xffff;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; addr.l2_family&nbsp;&nbsp;= AF_BLUETOOTH;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, dst);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; addr.l2_psm = htobs(psm);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (connect(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(sk);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return sk;<br>&gt; }<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* l2cap_accept()<br>&gt;&nbsp;&nbsp;* (Permits incoming connection)<br>&gt;&nbsp;&nbsp;* Blocks and accepts incoming connection
<br>&gt;&nbsp;&nbsp;* Function switches from BT_LISTEN to BT_CONNECTED<br>&gt;&nbsp;&nbsp;*/<br>&gt; static int l2cap_accept(int sk, bdaddr_t *bdaddr)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; socklen_t addrlen;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int nsk;
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; addrlen = sizeof(addr);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; // accept one connection<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if ((nsk = accept(sk, (struct sockaddr *) &amp;addr, &amp;addrlen)) &lt; 0)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (bdaddr)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bacpy(bdaddr, &amp;addr.l2_bdaddr);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return nsk;<br>&gt; }<br>&gt; --------------------<br>&gt; I am eventually aiming to register the mouse HID events, and send it via the
<br>&gt; L2CAP socket to &quot;control&quot; another bluetooth-enabled PC.<br>&gt; How do I use an SDP service in conjunction with the existing L2CAP code? How<br>&gt; do I use the control channel (L2CAP_PSM_HIDP_CTRL 0x11) and the interrupt
<br>&gt; channel (L2CAP_PSM_HIDP_INTR 0x13)<br>&gt; I think the control channel is used by SDP for signalling, (device<br>&gt; discovery); the interrupt channel is used for data transfer (service<br>&gt; discovery)<br>&gt; Thanks in advance for any help!
<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>&gt; _______________________________________________<br>&gt; Bluez-devel mailing list<br>&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt;<br>&gt;<br><br>Hi Meenakshi,<br><br>Check the D-Bus Input service implementation: utils/input<br>It contains the code that you want.<br><br>BR,<br>Claudio.
<br>--<br>---------------------------------------------------------<br>Claudio Takahasi<br>Instituto Nokia de Tecnologia - INdT<br><br><br><br>------------------------------<br><br>Message: 2<br>Date: Tue, 03 Apr 2007 11:21:34 -0600
<br>From: Brad Midgley &lt;<a href="mailto:bmidgley@xmission.com">bmidgley@xmission.com</a>&gt;<br>Subject: Re: [Bluez-devel] problems with getting Plan tronics M1000 to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pair on Ubuntu system<br>To: BlueZ development &lt;
<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a href="mailto:46128D1E.2050609@xmission.com">46128D1E.2050609@xmission.com</a>&gt;<br>Content-Type: text/plain; charset=ISO-8859-1; format=flowed
<br><br>Brett<br><br>&gt; I tried pairing and then tried a connect - do I have a PIN issue?<br><br>i got something similar when bluez-passkey-gnome needed to be installed<br><br>brad<br><br><br><br><br>------------------------------
<br><br>Message: 3<br>Date: Tue, 03 Apr 2007 21:05:56 +0200<br>From: Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;<br>Subject: Re: [Bluez-devel] RemoteNameRequested signal during discovery
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;patch<br>To: BlueZ development &lt;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;1175627156.5815.402.camel@violet&gt;<br>Content-Type: text/plain
<br><br>Hi Johan,<br><br>&gt; &gt; &gt; A new version of the patch.<br>&gt; &gt; &gt; Are you okay with it ?<br>&gt; &gt;<br>&gt; &gt; the patch looks okay to me. However I prefer if Claudio or Johan can<br>&gt; &gt; have an additional look.
<br>&gt;<br>&gt; Looks good to me.<br><br>feel free to commit it to the CVS then.<br><br>Regards<br><br>Marcel<br><br><br><br><br><br>------------------------------<br><br>Message: 4<br>Date: Tue, 3 Apr 2007 21:16:43 -0000
<br>From: &quot;chips&quot; &lt;<a href="mailto:Jul@pbpfab.com">Jul@pbpfab.com</a>&gt;<br>Subject: [Bluez-devel] used<br>To: <a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a><br>Message-ID: &lt;
001201c77635$61395500$86572f97@davide10&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br><br>Choices multiple, mak management service kms activates. Conflict vistaiam school students.<br>Comments seis office, you need read.
<br>Help, links by xpearlier, for pcsshared computer. Megatest fastest, modems revealed gps navigation, get from no.<br>Word priced hungery crap, anonymous sucksdidnt say blue.<br>Connecting computers going online. Thread subject author algo, de, slackware hay una que. Someone bringing their home, installing leaving again.
<br>Re newest greg mar kentucky sorta looked.<br>Officially than, chips awful stick check. Certainly looks, set put. Students finally gone mad beyond bull shit apart high?<br>Hunter blogs linux amp, open source news! Able as welland pieces? Tito, sites sport finance music.
<br>Wed, feb previous, message, messages.<br>Groups direct phone, connection.<br>Vbulletin copyright jelsoft scheduled. Hmmm wonder willhmmm, big higher normal reinstall rates like. Used anything another call moment able as.
<br>Worth trouble sysprep xml file hard.<br>Its world server macs.<br>Imminent arrival business enterprise, additions, dropped nasty little.<br>-------------- next part --------------<br>An HTML attachment was scrubbed...
<br>-------------- next part --------------<br>A non-text attachment was scrubbed...<br>Name: not available<br>Type: image/gif<br>Size: 4634 bytes<br>Desc: not available<br><br>------------------------------<br><br>Message: 5
<br>Date: Tue, 03 Apr 2007 15:04:29 -0600<br>From: Brad Midgley &lt;<a href="mailto:bmidgley@xmission.com">bmidgley@xmission.com</a>&gt;<br>Subject: Re: [Bluez-devel] new sco flowcontrol patch<br>To: BlueZ development &lt;
<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a href="mailto:4612C15D.2080900@xmission.com">4612C15D.2080900@xmission.com</a>&gt;<br>Content-Type: text/plain; charset=ISO-8859-1; format=flowed
<br><br>Marcel<br><br>&gt; And why do we have to do &quot;c-&gt;tx_timer.function = hci_sco_tx_timer&quot; over<br>&gt; and over again. Isn&#39;t it enough if we set the timer function once after<br>&gt; init of the timer.
<br><br>should this happen directly inside hci_conn.c or through something like<br>a notification?<br><br>To use it in hci_conn I&#39;d want to move the definition of the function<br>there too but that may not be the right fit.
<br><br>Brad<br><br><br><br><br><br><br>------------------------------<br><br>Message: 6<br>Date: Tue, 03 Apr 2007 23:08:47 +0200<br>From: Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;
<br>Subject: Re: [Bluez-devel] new sco flowcontrol patch<br>To: BlueZ development &lt;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;1175634527.5815.409.camel@violet
&gt;<br>Content-Type: text/plain<br><br>Hi Brad,<br><br>&gt; &gt; And why do we have to do &quot;c-&gt;tx_timer.function = hci_sco_tx_timer&quot; over<br>&gt; &gt; and over again. Isn&#39;t it enough if we set the timer function once after
<br>&gt; &gt; init of the timer.<br>&gt;<br>&gt; should this happen directly inside hci_conn.c or through something like<br>&gt; a notification?<br>&gt;<br>&gt; To use it in hci_conn I&#39;d want to move the definition of the function
<br>&gt; there too but that may not be the right fit.<br><br>actually hci_sco_tx_timer() should be in hci_conn.c. There is no need to<br>put that into hci_core.c and make this so complex.<br><br>Regards<br><br>Marcel<br><br>
<br><br><br><br>------------------------------<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br><br>------------------------------<br><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br><br>End of Bluez-devel Digest, Vol 12, Issue 9<br>******************************************
<br></blockquote></div><br>

------=_Part_20601_5211418.1175671832962--


--===============0114168273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0114168273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0114168273==--
