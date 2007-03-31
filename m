Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0703310829x2ce192d0n90941caff1091232@mail.gmail.com>
Date: Sat, 31 Mar 2007 16:29:04 +0100
From: "Meenakshi Seeballack" <meena2010@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <mailman.15025.1175347933.5558.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
References: <mailman.15025.1175347933.5558.bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 11, Issue 20
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0335602308=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0335602308==
Content-Type: multipart/alternative;
	boundary="----=_Part_60024_12654588.1175354944690"

------=_Part_60024_12654588.1175354944690
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Marcel,
Thanks for your reply. I have looked at the l2test.c, and the send method
which enables writing to the socket that has been opened.
Would you know of live examples for l2cap socket programming, like useful
websites or documents?
Once I figure out how to use the mouse report descriptor, I would need to
use the send method for the mouse events that would be sent via Bluetooth.
I am sorry if I am being dense but I am new to socket programming,
Bluetooth, and the HID profile, but I am trying to understand this world.
Thanks and regards,
Meena
--------------------------------

On 31/03/07, bluez-users-request@lists.sourceforge.net <
bluez-users-request@lists.sourceforge.net> wrote:
>
> Send Bluez-users mailing list submissions to
>         bluez-users@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.sourceforge.net/lists/listinfo/bluez-users
> or, via email, send a message with subject or body 'help' to
>         bluez-users-request@lists.sourceforge.net
>
> You can reach the person managing the list at
>         bluez-users-owner@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bluez-users digest..."
>
>
> Today's Topics:
>
>    1. BlueZ API, HID profile, socket programming (Meenakshi Seeballack)
>    2. Multithread Service Discovery (Robert Rawlins)
>    3. Re: Multithread Service Discovery (Malte Steiner)
>    4. Logitech diNovo Desktop: keyboard keys and Mouse  buttons
>       (Christoph Burger-Scheidlin)
>    5. BlueZ, testing socket (Meenakshi Seeballack)
>    6. Re: BlueZ, testing socket (Marcel Holtmann)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 30 Mar 2007 17:43:11 +0100
> From: "Meenakshi Seeballack" <meena2010@gmail.com>
> Subject: [Bluez-users] BlueZ API, HID profile, socket programming
> To: bluez-users@lists.sourceforge.net
> Message-ID:
>         <ddea76ce0703300943u2911c2c0p8f1680d4a12c8210@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> hello all,
> I am developing for the Nokia 770 - the idea is to use the PDA as a mouse
> to
> control another bluetooth-enabled PC.
> At this point I have opened a socket via L2CAP (Logical Link Control and
> Adaptation Protocol). How do I test if the socket is working?
> I am sorry if this is a stupid question but I am new to linux,C and socket
> programming :(
> Thanks in advance for the help
> Meena
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 2
> Date: Fri, 30 Mar 2007 19:33:46 +0000
> From: Robert Rawlins <robert_rawlins@hotmail.com>
> Subject: [Bluez-users] Multithread Service Discovery
> To: <bluez-users@lists.sourceforge.net>
> Message-ID: <BAY124-W15053C673FC32A41B2AF00F0630@phx.gbl>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hello Chaps,
>
> I'm currently running a C program for service discovery on a list of
> devices. The function loops through the list elements and performs an SDP
> enquiry on each device and returns the results to the screen, but I'm
> finding that if i get a slow device in the list it can hold things up a
> little, and in general it would be fantastic to hit all the devices with an
> enquiry simultaneously.
>
> What's the best method for multithreading this procedure to perform a
> discovery on several devices at once?, is this even possible? I'd appreciate
> any suggestions of tales of previous experiences,
>
> Thanks again,
>
> Rob
> _________________________________________________________________
> Try Live.com - your fast, personalized homepage with all the things you
> care about in one place.
> http://www.live.com/getstarted
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 3
> Date: Fri, 30 Mar 2007 21:45:49 +0200
> From: Malte Steiner <steiner@mobileart.org>
> Subject: Re: [Bluez-users] Multithread Service Discovery
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID: <1175283949.5851.3.camel@localhost>
> Content-Type: text/plain
>
> Am Freitag, den 30.03.2007, 19:33 +0000 schrieb Robert Rawlins:
> > Hello Chaps,
> >
> > I'm currently running a C program for service discovery on a list of
> > devices. The function loops through the list elements and performs an
> > SDP enquiry on each device and returns the results to the screen, but
> > I'm finding that if i get a slow device in the list it can hold things
> > up a little, and in general it would be fantastic to hit all the
> > devices with an enquiry simultaneously.
>
> Multithreading is possible, I use the OpenThreads library to do so for
> the same reasons. Attention, OpenThreads is OO and C++ so you might look
> for another solution like pthreads.
>
> Cheers,
>
> Malte
>
>
>
>
> ------------------------------
>
> Message: 4
> Date: Fri, 30 Mar 2007 23:17:37 +0100
> From: Christoph Burger-Scheidlin <andersin@freenet.de>
> Subject: [Bluez-users] Logitech diNovo Desktop: keyboard keys and
>         Mouse   buttons
> To: bluez-users@lists.sourceforge.net
> Message-ID: <200703302317.37908.andersin@freenet.de>
> Content-Type: text/plain;  charset="us-ascii"
>
> Hello all,
>
> I have a logitech diNovo desktop and connect it directly to my bluetooth
> adapter in my laptop. I noticed that the F11, F12 and the Refresh button
> do
> not work and are not reported by xev. However, hciconfig shows an increase
> in
> the RX bytes and acl counters. Does this mean that the keyboard transmits
> data to the computer? I want to find out if the keyboard is transmitting a
> keycode, can someone point me to some resources that tell me how to listen
> in
> on the traffic.
>
> I have a similar issue with the mouse buttons, i.e. that they report the
> same
> buttons to xev and an evtest program. I want to figure out how to see what
> the mouse is actually reporting.
>
> Thanks you,
>
> Christoph Burger-Scheidlin
>
>
>
> ------------------------------
>
> Message: 5
> Date: Sat, 31 Mar 2007 14:24:43 +0100
> From: "Meenakshi Seeballack" <meena2010@gmail.com>
> Subject: [Bluez-users] BlueZ, testing socket
> To: bluez-users@lists.sourceforge.net
> Message-ID:
>         <ddea76ce0703310624h7db4f1d1n689ea1ed2062b382@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi all,
> This code below connects to the server socket and selects the protocol to
> be
> used (L2CAP), opens the socket for that protocol, creates a bluetooth
> address object and sets its port to the PSM and binds the socket to this
> address, tells the sockets to listen for incoming connections, creates a
> blank socket and pass it to the listening socket through accept (When this
> call completes the socket passed in a parameter is now fully connected and
> can be used to send and receive data)
>
> QUESTION: How do I test this socket works? I want to send a messge like
> "Hello World". Please help...anyone
>
> #include <stdio.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <malloc.h>
> #include <syslog.h>
> #include <signal.h >
> #include <getopt.h>
> #include <sys/poll.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
>
> #include <linux/input.h>
>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> #include <bluetooth/l2cap.h>
> #include <bluetooth/sdp.h>
> #include <bluetooth/hidp.h>
>
> /*
> * l2cap_listen(l2cap_channel)
> *
> * Searches all sockets listening to the L2CAP protocol,
> * Checks for a socket waiting for an incoming connection
> * request.
> * Ensures that there is not already a connection
> * with the source address of the requesting Bluetooth device.
> *
> *    Use this channel as a listening post. This will
> *    result in calls to:
> *
> *        proto->newconn(upper, laddr, raddr)
> *
> *    for incoming connections matching the psm and local
> *    address of the channel
> *
> *    The upper layer should create and return a new channel.
> *
> *    This channel cannot be used for anything else subsequent to this call
> */
> static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int
> lm,
> int backlog)
> {
>     struct sockaddr_l2 addr;
>     struct l2cap_options opts;
>     int sk;
>
>     // create socket
>     if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
>         return -1;
>
>     /* open connection to remote device */
>     memset(&addr, 0, sizeof(addr));
>     addr.l2_family = AF_BLUETOOTH;
>     bacpy(&addr.l2_bdaddr, bdaddr); /* update source address of socket */
>     addr.l2_psm = htobs(psm);
>
>     // associate local address with socket
>     if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>         perror("ERROR: Could not bind socket");
>         close(sk);
>         return -1;
>     }
>
>     setsockopt(sk, SOL_L2CAP, L2CAP_LM, &lm, sizeof(lm));
>
>     memset(&opts, 0, sizeof(opts));
>     opts.imtu = HIDP_DEFAULT_MTU;
>     opts.omtu = HIDP_DEFAULT_MTU;
>     opts.flush_to = 0xffff;
>
>     setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts));
>
>     if (listen(sk, backlog) < 0) {
>         close(sk);
>         return -1;
>     }
>
>     return sk;
> }
>
> /*
> * l2cap_connect_req()
> * Establishes connection with specific socket
> * Request to establish connection from remote
> * communication partner.
> * Such a socket has to have been previously created
> * by an application with the command listen.
> */
> static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm)
> {
>     struct sockaddr_l2 addr;
>     struct l2cap_options opts;
>     int sk;
>
>     // socket allocation
>     if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
>         perror("ERROR: Could not create socket");
>         return -1;
>
>     memset(&addr, 0, sizeof(addr));
>     addr.l2_family  = AF_BLUETOOTH;
>     bacpy(&addr.l2_bdaddr, src); /*update source address of socket */
>
>     if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>         close(sk);
>         return -1;
>     }
>
>     memset(&opts, 0, sizeof(opts));
>     opts.imtu = HIDP_DEFAULT_MTU;
>     opts.omtu = HIDP_DEFAULT_MTU;
>     opts.flush_to = 0xffff;
>
>     setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts));
>
>     memset(&addr, 0, sizeof(addr));
>     addr.l2_family  = AF_BLUETOOTH;
>     bacpy(&addr.l2_bdaddr, dst);
>     addr.l2_psm = htobs(psm);
>
>     if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>         close(sk);
>         return -1;
>     }
>
>     return sk;
> }
>
> /*
> * l2cap_accept()
> * Permits incoming connection
> * Function switches from BT_LISTEN to BT_CONNECTED
> */
> static int l2cap_accept(int sk, bdaddr_t *bdaddr)
> {
>     struct sockaddr_l2 addr;
>     socklen_t addrlen;
>     int nsk;
>
>     memset(&addr, 0, sizeof(addr));
>     addrlen = sizeof(addr);
>
>     // accept one connection
>     if ((nsk = accept(sk, (struct sockaddr *) &addr, &addrlen)) < 0)
>         return -1;
>
>     if (bdaddr)
>         bacpy(bdaddr, &addr.l2_bdaddr);
>
>     return nsk;
> }
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 6
> Date: Sat, 31 Mar 2007 15:32:05 +0200
> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: [Bluez-users] BlueZ, testing socket
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID: <1175347925.5815.236.camel@violet>
> Content-Type: text/plain
>
> Hi Meenakshi,
>
> > This code below connects to the server socket and selects the protocol
> > to be used (L2CAP), opens the socket for that protocol, creates a
> > bluetooth address object and sets its port to the PSM and binds the
> > socket to this address, tells the sockets to listen for incoming
> > connections, creates a blank socket and pass it to the listening
> > socket through accept (When this call completes the socket passed in a
> > parameter is now fully connected and can be used to send and receive
> > data)
> >
> > QUESTION: How do I test this socket works? I want to send a messge
> > like "Hello World". Please help...anyone
>
> you should have a look at l2test.c and rctest.c from bluez-utils.
> However the simple answer is to use read() and write() on that specific
> socket descriptor.
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
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> End of Bluez-users Digest, Vol 11, Issue 20
> *******************************************
>

------=_Part_60024_12654588.1175354944690
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Marcel,<br>Thanks for your reply. I have looked at the l2test.c, and the send method which enables writing to the socket that has been opened.<br>Would you know of live examples for l2cap socket programming, like useful websites or documents?
<br>Once I figure out how to use the mouse report descriptor, I would need to use the send method for the mouse events that would be sent via Bluetooth.<br>I am sorry if I am being dense but I am new to socket programming, Bluetooth, and the HID profile, but I am trying to understand this world.
<br>Thanks and regards,<br>Meena<br>--------------------------------<br><br><div><span class="gmail_quote">On 31/03/07, <b class="gmail_sendername"><a href="mailto:bluez-users-request@lists.sourceforge.net">bluez-users-request@lists.sourceforge.net
</a></b> &lt;<a href="mailto:bluez-users-request@lists.sourceforge.net">bluez-users-request@lists.sourceforge.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Send Bluez-users mailing list submissions to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br><br>To subscribe or unsubscribe via the World Wide Web, visit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>or, via email, send a message with subject or body &#39;help&#39; to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-users-request@lists.sourceforge.net">
bluez-users-request@lists.sourceforge.net</a><br><br>You can reach the person managing the list at<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-users-owner@lists.sourceforge.net">bluez-users-owner@lists.sourceforge.net</a><br><br>When replying, please edit your Subject line so it is more specific
<br>than &quot;Re: Contents of Bluez-users digest...&quot;<br><br><br>Today&#39;s Topics:<br><br>&nbsp;&nbsp; 1. BlueZ API, HID profile, socket programming (Meenakshi Seeballack)<br>&nbsp;&nbsp; 2. Multithread Service Discovery (Robert Rawlins)
<br>&nbsp;&nbsp; 3. Re: Multithread Service Discovery (Malte Steiner)<br>&nbsp;&nbsp; 4. Logitech diNovo Desktop: keyboard keys and Mouse&nbsp;&nbsp;buttons<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Christoph Burger-Scheidlin)<br>&nbsp;&nbsp; 5. BlueZ, testing socket (Meenakshi Seeballack)<br>
&nbsp;&nbsp; 6. Re: BlueZ, testing socket (Marcel Holtmann)<br><br><br>----------------------------------------------------------------------<br><br>Message: 1<br>Date: Fri, 30 Mar 2007 17:43:11 +0100<br>From: &quot;Meenakshi Seeballack&quot; &lt;
<a href="mailto:meena2010@gmail.com">meena2010@gmail.com</a>&gt;<br>Subject: [Bluez-users] BlueZ API, HID profile, socket programming<br>To: <a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net
</a><br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:ddea76ce0703300943u2911c2c0p8f1680d4a12c8210@mail.gmail.com">ddea76ce0703300943u2911c2c0p8f1680d4a12c8210@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;
<br><br>hello all,<br>I am developing for the Nokia 770 - the idea is to use the PDA as a mouse to<br>control another bluetooth-enabled PC.<br>At this point I have opened a socket via L2CAP (Logical Link Control and<br>Adaptation Protocol). How do I test if the socket is working?
<br>I am sorry if this is a stupid question but I am new to linux,C and socket<br>programming :(<br>Thanks in advance for the help<br>Meena<br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br>
<br>------------------------------<br><br>Message: 2<br>Date: Fri, 30 Mar 2007 19:33:46 +0000<br>From: Robert Rawlins &lt;<a href="mailto:robert_rawlins@hotmail.com">robert_rawlins@hotmail.com</a>&gt;<br>Subject: [Bluez-users] Multithread Service Discovery
<br>To: &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a href="mailto:BAY124-W15053C673FC32A41B2AF00F0630@phx.gbl">BAY124-W15053C673FC32A41B2AF00F0630@phx.gbl
</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br><br>Hello Chaps,<br><br>I&#39;m currently running a C program for service discovery on a list of devices. The function loops through the list elements and performs an SDP enquiry on each device and returns the results to the screen, but I&#39;m finding that if i get a slow device in the list it can hold things up a little, and in general it would be fantastic to hit all the devices with an enquiry simultaneously.
<br><br>What&#39;s the best method for multithreading this procedure to perform a discovery on several devices at once?, is this even possible? I&#39;d appreciate any suggestions of tales of previous experiences,<br><br>Thanks again,
<br><br>Rob<br>_________________________________________________________________<br>Try <a href="http://Live.com">Live.com</a> - your fast, personalized homepage with all the things you care about in one place.<br><a href="http://www.live.com/getstarted">
http://www.live.com/getstarted</a><br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br><br>------------------------------<br><br>Message: 3<br>Date: Fri, 30 Mar 2007 21:45:49 +0200<br>From: Malte Steiner &lt;
<a href="mailto:steiner@mobileart.org">steiner@mobileart.org</a>&gt;<br>Subject: Re: [Bluez-users] Multithread Service Discovery<br>To: BlueZ users &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net
</a>&gt;<br>Message-ID: &lt;1175283949.5851.3.camel@localhost&gt;<br>Content-Type: text/plain<br><br>Am Freitag, den 30.03.2007, 19:33 +0000 schrieb Robert Rawlins:<br>&gt; Hello Chaps,<br>&gt;<br>&gt; I&#39;m currently running a C program for service discovery on a list of
<br>&gt; devices. The function loops through the list elements and performs an<br>&gt; SDP enquiry on each device and returns the results to the screen, but<br>&gt; I&#39;m finding that if i get a slow device in the list it can hold things
<br>&gt; up a little, and in general it would be fantastic to hit all the<br>&gt; devices with an enquiry simultaneously.<br><br>Multithreading is possible, I use the OpenThreads library to do so for<br>the same reasons. Attention, OpenThreads is OO and C++ so you might look
<br>for another solution like pthreads.<br><br>Cheers,<br><br>Malte<br><br><br><br><br>------------------------------<br><br>Message: 4<br>Date: Fri, 30 Mar 2007 23:17:37 +0100<br>From: Christoph Burger-Scheidlin &lt;<a href="mailto:andersin@freenet.de">
andersin@freenet.de</a>&gt;<br>Subject: [Bluez-users] Logitech diNovo Desktop: keyboard keys and<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mouse&nbsp;&nbsp; buttons<br>To: <a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br>
Message-ID: &lt;<a href="mailto:200703302317.37908.andersin@freenet.de">200703302317.37908.andersin@freenet.de</a>&gt;<br>Content-Type: text/plain;&nbsp;&nbsp;charset=&quot;us-ascii&quot;<br><br>Hello all,<br><br>I have a logitech diNovo desktop and connect it directly to my bluetooth
<br>adapter in my laptop. I noticed that the F11, F12 and the Refresh button do<br>not work and are not reported by xev. However, hciconfig shows an increase in<br>the RX bytes and acl counters. Does this mean that the keyboard transmits
<br>data to the computer? I want to find out if the keyboard is transmitting a<br>keycode, can someone point me to some resources that tell me how to listen in<br>on the traffic.<br><br>I have a similar issue with the mouse buttons, 
i.e. that they report the same<br>buttons to xev and an evtest program. I want to figure out how to see what<br>the mouse is actually reporting.<br><br>Thanks you,<br><br>Christoph Burger-Scheidlin<br><br><br><br>------------------------------
<br><br>Message: 5<br>Date: Sat, 31 Mar 2007 14:24:43 +0100<br>From: &quot;Meenakshi Seeballack&quot; &lt;<a href="mailto:meena2010@gmail.com">meena2010@gmail.com</a>&gt;<br>Subject: [Bluez-users] BlueZ, testing socket<br>
To: <a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:ddea76ce0703310624h7db4f1d1n689ea1ed2062b382@mail.gmail.com">ddea76ce0703310624h7db4f1d1n689ea1ed2062b382@mail.gmail.com
</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br><br>Hi all,<br>This code below connects to the server socket and selects the protocol to be<br>used (L2CAP), opens the socket for that protocol, creates a bluetooth
<br>address object and sets its port to the PSM and binds the socket to this<br>address, tells the sockets to listen for incoming connections, creates a<br>blank socket and pass it to the listening socket through accept (When this
<br>call completes the socket passed in a parameter is now fully connected and<br>can be used to send and receive data)<br><br>QUESTION: How do I test this socket works? I want to send a messge like<br>&quot;Hello World&quot;. Please help...anyone
<br><br>#include &lt;stdio.h&gt;<br>#include &lt;errno.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;malloc.h&gt;<br>#include &lt;syslog.h&gt;<br>#include &lt;
signal.h &gt;<br>#include &lt;getopt.h&gt;<br>#include &lt;sys/poll.h&gt;<br>#include &lt;sys/ioctl.h&gt;<br>#include &lt;sys/socket.h&gt;<br><br>#include &lt;linux/input.h&gt;<br><br>#include &lt;bluetooth/bluetooth.h&gt;
<br>#include &lt;bluetooth/hci.h&gt;<br>#include &lt;bluetooth/hci_lib.h&gt;<br>#include &lt;bluetooth/l2cap.h&gt;<br>#include &lt;bluetooth/sdp.h&gt;<br>#include &lt;bluetooth/hidp.h&gt;<br><br>/*<br> * l2cap_listen(l2cap_channel)
<br> *<br> * Searches all sockets listening to the L2CAP protocol,<br> * Checks for a socket waiting for an incoming connection<br> * request.<br> * Ensures that there is not already a connection<br> * with the source address of the requesting Bluetooth device.
<br> *<br> *&nbsp;&nbsp;&nbsp;&nbsp;Use this channel as a listening post. This will<br> *&nbsp;&nbsp;&nbsp;&nbsp;result in calls to:<br> *<br> *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;proto-&gt;newconn(upper, laddr, raddr)<br> *<br> *&nbsp;&nbsp;&nbsp;&nbsp;for incoming connections matching the psm and local<br>
 *&nbsp;&nbsp;&nbsp;&nbsp;address of the channel<br> *<br> *&nbsp;&nbsp;&nbsp;&nbsp;The upper layer should create and return a new channel.<br> *<br> *&nbsp;&nbsp;&nbsp;&nbsp;This channel cannot be used for anything else subsequent to this call<br> */<br>static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int lm,
<br>int backlog)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;struct sockaddr_l2 addr;<br>&nbsp;&nbsp;&nbsp;&nbsp;struct l2cap_options opts;<br>&nbsp;&nbsp;&nbsp;&nbsp;int sk;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;// create socket<br>&nbsp;&nbsp;&nbsp;&nbsp;if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;/* open connection to remote device */<br>&nbsp;&nbsp;&nbsp;&nbsp;memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp;&nbsp;addr.l2_family = AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp;&nbsp;bacpy(&amp;addr.l2_bdaddr, bdaddr); /* update source address of socket */<br>&nbsp;&nbsp;&nbsp;&nbsp;addr.l2_psm
 = htobs(psm);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;// associate local address with socket<br>&nbsp;&nbsp;&nbsp;&nbsp;if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;ERROR: Could not bind socket&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(sk);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;setsockopt(sk, SOL_L2CAP, L2CAP_LM, &amp;lm, sizeof(lm));<br><br>&nbsp;&nbsp;&nbsp;&nbsp;memset(&amp;opts, 0, sizeof(opts));<br>&nbsp;&nbsp;&nbsp;&nbsp;opts.imtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp;&nbsp;opts.omtu = HIDP_DEFAULT_MTU;
<br>&nbsp;&nbsp;&nbsp;&nbsp;opts.flush_to = 0xffff;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if (listen(sk, backlog) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(sk);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;return sk;
<br>}<br><br>/*<br> * l2cap_connect_req()<br> * Establishes connection with specific socket<br> * Request to establish connection from remote<br> * communication partner.<br> * Such a socket has to have been previously created
<br> * by an application with the command listen.<br> */<br>static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;struct sockaddr_l2 addr;<br>&nbsp;&nbsp;&nbsp;&nbsp;struct l2cap_options opts;<br>&nbsp;&nbsp;&nbsp;&nbsp;int sk;<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;// socket allocation<br>&nbsp;&nbsp;&nbsp;&nbsp;if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;ERROR: Could not create socket&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;memset(&amp;addr, 0, sizeof(addr));
<br>&nbsp;&nbsp;&nbsp;&nbsp;addr.l2_family&nbsp;&nbsp;= AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp;&nbsp;bacpy(&amp;addr.l2_bdaddr, src); /*update source address of socket */<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(sk);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;memset(&amp;opts, 0, sizeof(opts));<br>&nbsp;&nbsp;&nbsp;&nbsp;opts.imtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp;&nbsp;opts.omtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp;&nbsp;opts.flush_to = 0xffff;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp;&nbsp;addr.l2_family&nbsp;&nbsp;= AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp;&nbsp;bacpy(&amp;addr.l2_bdaddr, dst);<br>&nbsp;&nbsp;&nbsp;&nbsp;addr.l2_psm = htobs(psm);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if (connect(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(sk);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;return sk;<br>}<br><br>/*<br> * l2cap_accept()<br> * Permits incoming connection<br> * Function switches from BT_LISTEN to BT_CONNECTED<br> */<br>static int l2cap_accept(int sk, bdaddr_t *bdaddr)
<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;struct sockaddr_l2 addr;<br>&nbsp;&nbsp;&nbsp;&nbsp;socklen_t addrlen;<br>&nbsp;&nbsp;&nbsp;&nbsp;int nsk;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp;&nbsp;addrlen = sizeof(addr);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;// accept one connection<br>&nbsp;&nbsp;&nbsp;&nbsp;if ((nsk = accept(sk, (struct sockaddr *) &amp;addr, &amp;addrlen)) &lt; 0)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if (bdaddr)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bacpy(bdaddr, &amp;addr.l2_bdaddr);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;return nsk;<br>}<br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br><br>------------------------------
<br><br>Message: 6<br>Date: Sat, 31 Mar 2007 15:32:05 +0200<br>From: Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;<br>Subject: Re: [Bluez-users] BlueZ, testing socket<br>To: BlueZ users &lt;
<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;1175347925.5815.236.camel@violet&gt;<br>Content-Type: text/plain<br><br>Hi Meenakshi,<br><br>&gt; This code below connects to the server socket and selects the protocol
<br>&gt; to be used (L2CAP), opens the socket for that protocol, creates a<br>&gt; bluetooth address object and sets its port to the PSM and binds the<br>&gt; socket to this address, tells the sockets to listen for incoming
<br>&gt; connections, creates a blank socket and pass it to the listening<br>&gt; socket through accept (When this call completes the socket passed in a<br>&gt; parameter is now fully connected and can be used to send and receive
<br>&gt; data)<br>&gt;<br>&gt; QUESTION: How do I test this socket works? I want to send a messge<br>&gt; like &quot;Hello World&quot;. Please help...anyone<br><br>you should have a look at l2test.c and rctest.c from bluez-utils.
<br>However the simple answer is to use read() and write() on that specific<br>socket descriptor.<br><br>Regards<br><br>Marcel<br><br><br><br><br><br>------------------------------<br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br>
<a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br><br>------------------------------<br><br>
_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br><br>End of Bluez-users Digest, Vol 11, Issue 20<br>*******************************************<br></blockquote></div><br>

------=_Part_60024_12654588.1175354944690--


--===============0335602308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0335602308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0335602308==--
