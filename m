Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0704030510q3f0e271ej2a94e270f35475eb@mail.gmail.com>
Date: Tue, 3 Apr 2007 09:10:44 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ddea76ce0704030340s45fd640eka08ae3769b781c33@mail.gmail.com>
MIME-Version: 1.0
References: <ddea76ce0704030340s45fd640eka08ae3769b781c33@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 4/3/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
> Hello,
> I have tried to understand how to open an L2CAP socket, and have used the
> BlueZ API. This is what I have got so far:
> /*
>  * l2cap_listen(l2cap_channel)
>  * Use this channel as a listening post
>  */
> static int l2cap_listen(const bdaddr_t *bdaddr, unsigned short psm, int lm,
> int backlog)
> {
>     struct sockaddr_l2 addr;
>     struct l2cap_options opts;
>     int sk;
>
>     /* allocate a free socket */
>     if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
>         return -1;
>
>     /* open connection to remote device */
>     memset(&addr, 0, sizeof(addr));
>     addr.l2_family = AF_BLUETOOTH;
>     bacpy(&addr.l2_bdaddr, bdaddr); /* update source address of socket */
>     addr.l2_psm = htobs(psm);
>
>     /* bind socket to newly formed socket */
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
>     /* backlog: specifies the number of unaccepted connection
>      * that the system will allow before refusing new connections
>      */
>     if (listen(sk, backlog) < 0) {
>         close(sk);
>         return -1;
>     }
>
>     return sk;
> }
>
> /*
>  * l2cap_connect_req()
>  * Establishes connection with specific socket
>   * Request to establish connection from remote
>  * communication partner.
>  * Such a socket has to have been previously created
>  * by an application with the command listen.
>  */
> static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm)
> {
>     struct sockaddr_l2 addr;
>     struct l2cap_options opts;
>     int sk;
>
>     /* socket allocation */
>     if ((sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
>         perror("ERROR: Could not create socket");
>         return -1;
>
>     memset(&addr, 0, sizeof(addr));
>     addr.l2_family  = AF_BLUETOOTH;
>     bacpy(&addr.l2_bdaddr, src); /*update source address of socket */
>
>     /* binds socket to psm */
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
>  * l2cap_accept()
>  * (Permits incoming connection)
>  * Blocks and accepts incoming connection
>  * Function switches from BT_LISTEN to BT_CONNECTED
>  */
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
> --------------------
> I am eventually aiming to register the mouse HID events, and send it via the
> L2CAP socket to "control" another bluetooth-enabled PC.
> How do I use an SDP service in conjunction with the existing L2CAP code? How
> do I use the control channel (L2CAP_PSM_HIDP_CTRL 0x11) and the interrupt
> channel (L2CAP_PSM_HIDP_INTR 0x13)
> I think the control channel is used by SDP for signalling, (device
> discovery); the interrupt channel is used for data transfer (service
> discovery)
> Thanks in advance for any help!
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

Hi Meenakshi,

Check the D-Bus Input service implementation: utils/input
It contains the code that you want.

BR,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
