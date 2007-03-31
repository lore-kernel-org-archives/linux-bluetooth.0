Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0703310624h7db4f1d1n689ea1ed2062b382@mail.gmail.com>
Date: Sat, 31 Mar 2007 14:24:43 +0100
From: "Meenakshi Seeballack" <meena2010@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] BlueZ, testing socket
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0155468197=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0155468197==
Content-Type: multipart/alternative;
	boundary="----=_Part_59080_30798263.1175347483125"

------=_Part_59080_30798263.1175347483125
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
This code below connects to the server socket and selects the protocol to be
used (L2CAP), opens the socket for that protocol, creates a bluetooth
address object and sets its port to the PSM and binds the socket to this
address, tells the sockets to listen for incoming connections, creates a
blank socket and pass it to the listening socket through accept (When this
call completes the socket passed in a parameter is now fully connected and
can be used to send and receive data)

QUESTION: How do I test this socket works? I want to send a messge like
"Hello World". Please help...anyone

#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <malloc.h>
#include <syslog.h>
#include <signal.h >
#include <getopt.h>
#include <sys/poll.h>
#include <sys/ioctl.h>
#include <sys/socket.h>

#include <linux/input.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/l2cap.h>
#include <bluetooth/sdp.h>
#include <bluetooth/hidp.h>

/*
 * l2cap_listen(l2cap_channel)
 *
 * Searches all sockets listening to the L2CAP protocol,
 * Checks for a socket waiting for an incoming connection
 * request.
 * Ensures that there is not already a connection
 * with the source address of the requesting Bluetooth device.
 *
 *    Use this channel as a listening post. This will
 *    result in calls to:
 *
 *        proto->newconn(upper, laddr, raddr)
 *
 *    for incoming connections matching the psm and local
 *    address of the channel
 *
 *    The upper layer should create and return a new channel.
 *
 *    This channel cannot be used for anything else subsequent to this call
 */
static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int lm,
int backlog)
{
    struct sockaddr_l2 addr;
    struct l2cap_options opts;
    int sk;

    // create socket
    if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
        return -1;

    /* open connection to remote device */
    memset(&addr, 0, sizeof(addr));
    addr.l2_family = AF_BLUETOOTH;
    bacpy(&addr.l2_bdaddr, bdaddr); /* update source address of socket */
    addr.l2_psm = htobs(psm);

    // associate local address with socket
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

    // socket allocation
    if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
        perror("ERROR: Could not create socket");
        return -1;

    memset(&addr, 0, sizeof(addr));
    addr.l2_family  = AF_BLUETOOTH;
    bacpy(&addr.l2_bdaddr, src); /*update source address of socket */

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
 * Permits incoming connection
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

------=_Part_59080_30798263.1175347483125
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br>This code below connects to the server socket and selects
the protocol to be used (L2CAP), opens the socket for that protocol,
creates a bluetooth address object and sets its port to the PSM and
binds the socket to this address, tells the sockets to listen for
incoming connections, creates a blank socket and pass it to the
listening socket through accept (When this call completes the socket
passed in a parameter is now fully connected and can be used to send
and receive data) <br><br style="text-decoration: underline;"><span style="font-weight: bold; text-decoration: underline;">QUESTION: How do I test this socket works? I want to send a messge like &quot;Hello World&quot;. Please help...anyone
</span><br style="font-weight: bold;"><br style="font-weight: bold;">
#include &lt;stdio.h&gt;<br>#include &lt;errno.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;malloc.h&gt;<br>#include &lt;syslog.h&gt;<br>#include &lt;signal.h

&gt;<br>#include &lt;getopt.h&gt;<br>#include &lt;sys/poll.h&gt;<br>#include &lt;sys/ioctl.h&gt;<br>#include &lt;sys/socket.h&gt;<br><br>#include &lt;linux/input.h&gt;<br><br>#include &lt;bluetooth/bluetooth.h&gt;<br>#include &lt;bluetooth/hci.h&gt;
<br>#include &lt;bluetooth/hci_lib.h&gt;<br>#include &lt;bluetooth/l2cap.h&gt;<br>#include &lt;bluetooth/sdp.h&gt;<br>#include &lt;bluetooth/hidp.h&gt;<br><br>/*<br>&nbsp;* l2cap_listen(l2cap_channel)<br>&nbsp;* <br>&nbsp;* Searches all sockets listening to the L2CAP protocol, 
<br>&nbsp;* Checks for a socket waiting for an incoming connection <br>&nbsp;* request. <br>&nbsp;* Ensures that there is not already a connection <br>&nbsp;* with the source address of the requesting Bluetooth device.<br>&nbsp;*<br>&nbsp;*&nbsp;&nbsp;&nbsp; Use this channel as a listening post. This will
<br>&nbsp;*&nbsp;&nbsp;&nbsp; result in calls to:<br>&nbsp;*<br>&nbsp;*&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; proto-&gt;newconn(upper, laddr, raddr)<br>&nbsp;*<br>&nbsp;*&nbsp;&nbsp;&nbsp; for incoming connections matching the psm and local <br>&nbsp;*&nbsp;&nbsp;&nbsp; address of the channel<br>&nbsp;*<br>&nbsp;*&nbsp;&nbsp;&nbsp; The upper layer should create and return a new channel.
<br>&nbsp;*<br>&nbsp;*&nbsp;&nbsp;&nbsp; This channel cannot be used for anything else subsequent to this call<br>&nbsp;*/<br>static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int lm, int backlog)<br>{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;
<br>&nbsp;&nbsp;&nbsp; struct l2cap_options opts;<br>&nbsp;&nbsp;&nbsp; int sk;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; // create socket<br>&nbsp;&nbsp;&nbsp; if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br><br>&nbsp;&nbsp;&nbsp; /* open connection to remote device */
<br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addr.l2_family = AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, bdaddr); /* update source address of socket */<br>&nbsp;&nbsp;&nbsp; addr.l2_psm = htobs(psm);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; // associate local address with socket
<br>&nbsp;&nbsp;&nbsp; if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror(&quot;ERROR: Could not bind socket&quot;);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_LM, &amp;lm, sizeof(lm));
<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;opts, 0, sizeof(opts));<br>&nbsp;&nbsp;&nbsp; opts.imtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp; opts.omtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp; opts.flush_to = 0xffff;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));
<br><br>&nbsp;&nbsp;&nbsp; if (listen(sk, backlog) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; return sk;<br>}<br><br>/*<br>&nbsp;* l2cap_connect_req()<br>&nbsp;* Establishes connection with specific socket<br>&nbsp;* Request to establish connection from remote
<br>&nbsp;* communication partner.<br>&nbsp;* Such a socket has to have been previously created <br>&nbsp;* by an application with the command listen.<br>&nbsp;*/<br>static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm)
<br>
{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;<br>&nbsp;&nbsp;&nbsp; struct l2cap_options opts;<br>&nbsp;&nbsp;&nbsp; int sk;<br><br>&nbsp;&nbsp;&nbsp; // socket allocation<br>&nbsp;&nbsp;&nbsp; if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror(&quot;ERROR: Could not create socket&quot;);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addr.l2_family&nbsp; = AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, src); /*update source address of socket */<br><br>&nbsp;&nbsp;&nbsp; if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;opts, 0, sizeof(opts));<br>&nbsp;&nbsp;&nbsp; opts.imtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp; opts.omtu = HIDP_DEFAULT_MTU;<br>&nbsp;&nbsp;&nbsp; opts.flush_to = 0xffff;<br><br>&nbsp;&nbsp;&nbsp; setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &amp;opts, sizeof(opts));
<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addr.l2_family&nbsp; = AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp; bacpy(&amp;addr.l2_bdaddr, dst);<br>&nbsp;&nbsp;&nbsp; addr.l2_psm = htobs(psm);<br><br>&nbsp;&nbsp;&nbsp; if (connect(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(sk);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; return sk;<br>}<br><br>/* <br>&nbsp;* l2cap_accept()<br>&nbsp;* Permits incoming connection<br>&nbsp;* Function switches from BT_LISTEN to BT_CONNECTED<br>&nbsp;*/<br>static int l2cap_accept(int sk, bdaddr_t *bdaddr)
<br>{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_l2 addr;<br>&nbsp;&nbsp;&nbsp; socklen_t addrlen;<br>&nbsp;&nbsp;&nbsp; int nsk;<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(addr));<br>&nbsp;&nbsp;&nbsp; addrlen = sizeof(addr);<br><br>&nbsp;&nbsp;&nbsp; // accept one connection<br>&nbsp;&nbsp;&nbsp; if ((nsk = accept(sk, (struct sockaddr *) &amp;addr, &amp;addrlen)) &lt; 0)
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br><br>&nbsp;&nbsp;&nbsp; if (bdaddr)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bacpy(bdaddr, &amp;addr.l2_bdaddr);<br><br>&nbsp;&nbsp;&nbsp; return nsk;<br>}

------=_Part_59080_30798263.1175347483125--


--===============0155468197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0155468197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0155468197==--
