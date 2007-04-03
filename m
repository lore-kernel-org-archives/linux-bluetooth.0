Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0704030340s45fd640eka08ae3769b781c33@mail.gmail.com>
Date: Tue, 3 Apr 2007 11:40:58 +0100
From: "Meenakshi Seeballack" <meena2010@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] L2CAP sockets, SDP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1508818638=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1508818638==
Content-Type: multipart/alternative;
	boundary="----=_Part_4575_25091685.1175596858485"

------=_Part_4575_25091685.1175596858485
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I have tried to understand how to open an L2CAP socket, and have used the
BlueZ API. This is what I have got so far:
/*
 * l2cap_listen(l2cap_channel)
 * Use this channel as a listening post
 */
static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int lm,
int backlog)
{
    struct sockaddr_l2 addr;
    struct l2cap_options opts;
    int sk;

    /* allocate a free socket */
    if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
        return -1;

    /* open connection to remote device */
    memset(&addr, 0, sizeof(addr));
    addr.l2_family = AF_BLUETOOTH;
    bacpy(&addr.l2_bdaddr, bdaddr); /* update source address of socket */
    addr.l2_psm = htobs(psm);

    /* bind socket to newly formed socket */
    if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
        perror("ERROR: Could not bind socket");
        close(sk);
        return -1;
    }

    setsockopt(sk, SOL_L2CAP, L2CAP_LM, &lm, sizeof(lm));

    memset(&opts, 0, sizeof(opts));
    opts.imtu = HIDP_DEFAULT_MTU;
    opts.omtu = HIDP_DEFAULT_MTU;
    opts.flush_to = 0xffff;

    setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts));

    /* backlog: specifies the number of unaccepted connection
     * that the system will allow before refusing new connections
     */
    if (listen(sk, backlog) < 0) {
        close(sk);
        return -1;
    }

    return sk;
}

/*
 * l2cap_connect_req()
 * Establishes connection with specific socket
 * Request to establish connection from remote
 * communication partner.
 * Such a socket has to have been previously created
 * by an application with the command listen.
 */
static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm)
{
    struct sockaddr_l2 addr;
    struct l2cap_options opts;
    int sk;

    /* socket allocation */
    if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
        perror("ERROR: Could not create socket");
        return -1;

    memset(&addr, 0, sizeof(addr));
    addr.l2_family  = AF_BLUETOOTH;
    bacpy(&addr.l2_bdaddr, src); /*update source address of socket */

    /* binds socket to psm */
    if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
        close(sk);
        return -1;
    }

    memset(&opts, 0, sizeof(opts));
    opts.imtu = HIDP_DEFAULT_MTU;
    opts.omtu = HIDP_DEFAULT_MTU;
    opts.flush_to = 0xffff;

    setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts));

    memset(&addr, 0, sizeof(addr));
    addr.l2_family  = AF_BLUETOOTH;
    bacpy(&addr.l2_bdaddr, dst);
    addr.l2_psm = htobs(psm);

    if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
        close(sk);
        return -1;
    }

    return sk;
}

/*
 * l2cap_accept()
 * (Permits incoming connection)
 * Blocks and accepts incoming connection
 * Function switches from BT_LISTEN to BT_CONNECTED
 */
static int l2cap_accept(int sk, bdaddr_t *bdaddr)
{
    struct sockaddr_l2 addr;
    socklen_t addrlen;
    int nsk;

    memset(&addr, 0, sizeof(addr));
    addrlen = sizeof(addr);

    // accept one connection
    if ((nsk = accept(sk, (struct sockaddr *) &addr, &addrlen)) < 0)
        return -1;

    if (bdaddr)
        bacpy(bdaddr, &addr.l2_bdaddr);

    return nsk;
}
--------------------
I am eventually aiming to register the mouse HID events, and send it via the
L2CAP socket to "control" another bluetooth-enabled PC.
How do I use an SDP service in conjunction with the existing L2CAP code? How
do I use the control channel (L2CAP_PSM_HIDP_CTRL 0x11) and the interrupt
channel (L2CAP_PSM_HIDP_INTR 0x13)
I think the control channel is used by SDP for signalling, (device
discovery); the interrupt channel is used for data transfer (service
discovery)
Thanks in advance for any help!

------=_Part_4575_25091685.1175596858485
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>I have tried to understand how to open an L2CAP socket, and have used the BlueZ API. This is what I have got so far:<br>/*<br>&nbsp;* l2cap_listen(l2cap_channel)<br>&nbsp;* Use this channel as a listening post<br>&nbsp;*/<br>static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int lm, int backlog)
<br>{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;<br>&nbsp;&nbsp;&nbsp; struct l2cap_options opts;<br>&nbsp;&nbsp;&nbsp; int sk;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; /* allocate a free socket */<br>&nbsp;&nbsp;&nbsp; if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;
<br><br>&nbsp;&nbsp;&nbsp; /* open connection to remote device */<br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addr.l2_family = AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, bdaddr); /* update source address of socket */<br>&nbsp;&nbsp;&nbsp; addr.l2_psm
 = htobs(psm);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; /* bind socket to newly formed socket */<br>&nbsp;&nbsp;&nbsp; if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror(&quot;ERROR: Could not bind socket&quot;);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_LM, &amp;lm, sizeof(lm));<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;opts, 0, sizeof(opts));<br>&nbsp;&nbsp;&nbsp; opts.imtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp; opts.omtu = HIDP_DEFAULT_MTU;
<br>&nbsp;&nbsp;&nbsp; opts.flush_to = 0xffff;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; /* backlog: specifies the number of unaccepted connection<br>&nbsp;&nbsp;&nbsp; &nbsp;* that the system will allow before refusing new connections
<br>&nbsp;&nbsp;&nbsp; &nbsp;*/<br>&nbsp;&nbsp;&nbsp; if (listen(sk, backlog) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; return sk;<br>}<br><br>/*<br>&nbsp;* l2cap_connect_req()<br>&nbsp;* Establishes connection with specific socket<br>
&nbsp;* Request to establish connection from remote<br>&nbsp;* communication partner.<br>&nbsp;* Such a socket has to have been previously created <br>&nbsp;* by an application with the command listen.<br>&nbsp;*/<br>static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm)
<br>{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;<br>&nbsp;&nbsp;&nbsp; struct l2cap_options opts;<br>&nbsp;&nbsp;&nbsp; int sk;<br><br>&nbsp;&nbsp;&nbsp; /* socket allocation */<br>&nbsp;&nbsp;&nbsp; if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror(&quot;ERROR: Could not create socket&quot;);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addr.l2_family&nbsp; = AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, src); /*update source address of socket */<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; /* binds socket to psm */
<br>&nbsp;&nbsp;&nbsp; if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;opts, 0, sizeof(opts));<br>&nbsp;&nbsp;&nbsp; opts.imtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp; opts.omtu
 = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp; opts.flush_to = 0xffff;<br><br>&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addr.l2_family&nbsp; = AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, dst);
<br>&nbsp;&nbsp;&nbsp; addr.l2_psm = htobs(psm);<br><br>&nbsp;&nbsp;&nbsp; if (connect(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; return sk;<br>}<br><br>/* <br>&nbsp;* l2cap_accept()
<br>&nbsp;* (Permits incoming connection)<br>&nbsp;* Blocks and accepts incoming connection<br>&nbsp;* Function switches from BT_LISTEN to BT_CONNECTED<br>&nbsp;*/<br>static int l2cap_accept(int sk, bdaddr_t *bdaddr)<br>{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;
<br>&nbsp;&nbsp;&nbsp; socklen_t addrlen;<br>&nbsp;&nbsp;&nbsp; int nsk;<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addrlen = sizeof(addr);<br><br>&nbsp;&nbsp;&nbsp; // accept one connection<br>&nbsp;&nbsp;&nbsp; if ((nsk = accept(sk, (struct sockaddr *) &amp;addr, &amp;addrlen)) &lt; 0)
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br><br>&nbsp;&nbsp;&nbsp; if (bdaddr)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bacpy(bdaddr, &amp;addr.l2_bdaddr);<br><br>&nbsp;&nbsp;&nbsp; return nsk;<br>}<br>--------------------<br>I am eventually aiming to register the mouse HID events, and send it
via the L2CAP socket to &quot;control&quot; another bluetooth-enabled PC.<br>How do I use an SDP service in conjunction with the existing L2CAP code? How do I use the control channel (L2CAP_PSM_HIDP_CTRL 0x11) and the interrupt channel (L2CAP_PSM_HIDP_INTR 0x13)
<br>I think the control channel is used by SDP for signalling, (device discovery); the interrupt channel is used for data transfer (service discovery)<br>Thanks in advance for any help!<br><br>

------=_Part_4575_25091685.1175596858485--


--===============1508818638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1508818638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1508818638==--
