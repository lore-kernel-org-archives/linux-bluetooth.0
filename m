Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced0502230228296ac5e7@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net, sebastian.roth@esk.fhg.de
Subject: Re: [Bluez-users] Re: Can't able to send data in both direction
In-Reply-To: <cvhkqf$2b0$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_48_32773339.1109154533065"
References: <7aa80ced0502222239dd01830@mail.gmail.com>
	 <cvh9lh$2b0$1@sea.gmane.org>
	 <7aa80ced05022223273b5bba4c@mail.gmail.com>
	 <cvhkqf$2b0$2@sea.gmane.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 23 Feb 2005 15:58:53 +0530

------=_Part_48_32773339.1109154533065
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sebastian,
                  The same program works for CSR dongle. I derived the
function from l2test.c
Regards
Mohan


On Wed, 23 Feb 2005 11:14:06 +0100, Sebastian Roth
<sebastian.roth@esk.fhg.de> wrote:
> Hi,
> 
> >     When the sending program runs on the SiW dongle PC , HCI dump is
> > not displaying any thing and it is giving the following error.
>  >
> > Error message on the sending side:
> >
> > [root@localhost ]# ./senddata
> >
> > L2CAP socket opened successfully.
> >
> > Can't connect: No route to host (113)
> I have no clue why this happens. Please post the sourcecode of your
> application.
> 
> > Can't send data.
> > : Bad file descriptor
> This happens because it can't connect.
> No connection, not able to send data!
> 
> Maybe there is a problem in the program. Or the needed kernel modules
> are not loaded (just a guess).
> # lsmod | grep -e l2cap -e rfcomm
> 
> Best regards,
> Sebastian
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_48_32773339.1109154533065
Content-Type: text/x-c; name="recvdata.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="recvdata.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2000-2001  Qualcomm Incorporated
 *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
 *  Copyright (C) 2002-2005  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation;
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIG=
HTS.
 *  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR A=
NY
 *  CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES=
=20
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN=
=20
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF=
=20
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,=20
 *  COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS=20
 *  SOFTWARE IS DISCLAIMED.
 *
 *
 *  $Id: l2test.c,v 1.16 2005/01/11 21:42:38 holtmann Exp $
 */

=09=09=09/*Bluetooth Receive program*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <ctype.h>
#include <unistd.h>
#include <stdlib.h>
#include <syslog.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/l2cap.h>


static unsigned char *buf;

/* Default mtu */
static int imtu =3D 672;
static int omtu =3D 0;

/* Default data size */
static long data_size =3D 672;

/* Default addr and psm */
static bdaddr_t bdaddr;
static unsigned short psm =3D 10;


static int master =3D 0;
static int auth =3D 0;
static int encrypt =3D 0;
static int secure =3D 0;
static int socktype =3D SOCK_SEQPACKET;

static int linger =3D 0;
static int reliable =3D 0;


unsigned char packet[256];
unsigned char sbuf[256]=3D{'a','b','c','d','e','f',0x7c,'g',0x7c,'i'};

unsigned char formpacket(unsigned char device, unsigned char len );
void send_data(int);


static void hexdump(unsigned char *s, unsigned long l)
{
=09unsigned long i;
=09unsigned char j,k;
=09unsigned char temp=3D0x00;

=09/*for(i=3D0;i<l;i++)
=09{
=09=09printf("\r\n0x");
=09=09printf("%x",s[i]);
=09}
=09printf("\r\n");*/
=09
=09for(i=3D0;i<l;i++)
=09{
=09=09if((s[i]=3D=3D 0x7C)) =09//&& (s[i+1] !=3D 0x7C))
=09=09{
=09=09=09temp=3Dtemp ^ s[i];
=09=09=09temp=3Dtemp ^ s[i+1];
=09=09=09temp=3Dtemp ^ s[i+2];
=09=09=09
=09=09=09for(k=3Di;k<(i+s[i+2]);k++)
=09=09=09=09temp=3Dtemp ^ s[k+3];

=09=09=09=09=09
=09=09=09=09if(s[s[i+2]+3]=3D=3Dtemp)
=09=09=09=09=09printf("\nPacket recevied correctly\n");
=09=09=09=09else
=09=09=09=09{
=09=09=09=09=09printf("\nPacket corrupted\n");
=09=09=09=09=09return;
=09=09=09=09}

=09=09=09=09
=09=09=09if(s[i+1]=3D=3D0x01)
=09=09=09{
=09=09=09=09printf("\nKeyboard data packet\n");
=09=09=09=09printf("\nNo. of bytes in Keyboard packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09=09=09
=09=09=09if(s[i+1]=3D=3D0x02)
=09=09=09{
=09=09=09=09printf("\nMouse data packet\n");
=09=09=09=09printf("\nNo. of bytes in Mouse packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09=09
=09=09=09if(s[i+1]=3D=3D0x03)
=09=09=09{
=09=09=09=09printf("\nFinger print data packet\n");
=09=09=09=09printf("\nNo. of bytes in Finger print packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09=09
=09=09=09if(s[i+1]=3D=3D0x04)
=09=09=09{
=09=09=09=09printf("\nControl packet\n");
=09=09=09=09printf("\nNo. of bytes in Control packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09break;
=09=09}
=09}
=09=09=09

=09


}

static void dump_mode(int s)
{
=09int len;
=09int opt, optl;
=09
=09

=09printf("\r\nReceiving ...\r\n");

=09while (1) {
=09=09fd_set rset;

=09=09FD_ZERO(&rset);
=09=09FD_SET(s, &rset);

=09=09if (select(s + 1, &rset, NULL, NULL, NULL) < 0)
=09=09=09return;

=09=09if (!FD_ISSET(s, &rset))
=09=09=09continue;

=09=09len =3D read(s, buf, data_size);
=09=09if (len <=3D 0) {
=09=09=09if (len < 0) {=09bacpy(&bdaddr, BDADDR_ANY);

=09=09=09=09if (reliable && (errno =3D=3D ECOMM)) {
=09=09=09=09=09printf("\r\nL2CAP Error ECOMM - clearing error and continuin=
g.\r\n");
=09=09=09=09=09optl =3D sizeof(opt);
=09=09=09=09=09if (getsockopt(s, SOL_SOCKET, SO_ERROR, &opt, &optl ) < 0) {=
 // Clear error
=09=09=09=09=09=09printf("\r\nCouldn't getsockopt(SO_ERROR): %s (%d)\r\n",
=09=09=09=09=09=09=09strerror(errno), errno);
=09=09=09=09=09=09return;
=09=09=09=09=09}
=09=09=09=09=09continue;
=09=09=09=09} else {
=09=09=09=09=09printf("\r\nRead error: %s(%d)\n", strerror(errno), errno);
=09=09=09=09}
=09=09=09}
=09=09//=09return;
=09=09=09break;
=09=09//=09continue;
=09=09}
=09=09else if(len > 0)
=09=09{=09=09=09
=09=09=09printf("\nRecevied %d bytes\n", len);
=09=09static int omtu =3D 0;
=09hexdump(buf,len);
=09=09}
=09
=09
=09}
}

static void do_listen(void)
{
=09struct sockaddr_l2 loc_addr, rem_addr;
=09struct l2cap_options opts;
=09int s, s1, opt;
=09char ba[18];

=09if ((s =3D socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP)) < 0) {
=09=09printf("\nCan't create socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09loc_addr.l2_family =3D AF_BLUETOOTH;
=09bacpy(&loc_addr.l2_bdaddr, &bdaddr);
=09loc_addr.l2_psm =3D htobs(psm);
=09
=09if (bind(s, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {
=09=09printf("\nCan't bind socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09/* Set link mode */
=09opt =3D 0;
=09if (reliable)
=09=09opt |=3D L2CAP_LM_RELIABLE;
=09if (master)
=09=09opt |=3D L2CAP_LM_MASTER;
=09if (auth)
=09=09opt |=3D L2CAP_LM_AUTH;
=09if (encrypt)
=09=09opt |=3D L2CAP_LM_ENCRYPT;
=09if (secure)
=09=09opt |=3D L2CAP_LM_SECURE;

=09if (setsockopt(s, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
=09=09printf("\nCan't set L2CAP link mode: %s (%d)\n", strerror(errno), err=
no);
=09=09exit(1);
=09}

=09/* Get default options */
=09opt =3D sizeof(opts);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09printf("\nCan't get default L2CAP options: %s (%d)\n", strerror(errno=
), errno);
=09=09exit(1);
=09}

=09/* Set new options */
=09opts.imtu =3D imtu;
=09if (setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
=09=09printf("\nCan't set L2CAP options: %s (%d)\n", strerror(errno), errno=
);
=09=09exit(1);
=09}

/*=09if (socktype =3D=3D SOCK_DGRAM) {
=09=09handler(s);
=09=09return;
=09}*/

=09if (listen(s, 10)) {
=09=09printf("\nCan not listen on the socket: %s (%d)\n", strerror(errno), =
errno);
=09=09exit(1);
=09}

=09printf("\nWaiting for connection on psm %d ...\n", psm);

=09while(1) {
=09=09opt =3D sizeof(rem_addr);
=09=09if ((s1 =3D accept(s, (struct sockaddr *) &rem_addr, &opt)) < 0) {
=09=09=09printf("\nAccept failed: %s (%d)\n", strerror(errno), errno);
=09=09=09exit(1);
=09=09}

=09=09opt =3D sizeof(opts);
=09=09if (getsockopt(s1, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09=09printf("\nCan't get L2CAP options: %s (%d)\n", strerror(errno), er=
rno);
=09=09=09exit(1);
=09=09}

=09=09ba2str(&rem_addr.l2_bdaddr, ba);
=09=09printf("\nConnect from %s [imtu %d, omtu %d, flush_to %d]\n",ba, opts=
.imtu, opts.omtu, opts.flush_to);

=09=09/* Enable SO_LINGER */
=09=09if (linger) {
=09=09=09struct linger l =3D { .l_onoff =3D 1, .l_linger =3D linger };
=09=09=09if (setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
=09=09=09=09printf("\nCan't enable SO_LINGER: %s (%d)\n",
=09=09=09=09=09strerror(errno), errno);
=09=09=09=09exit(1);
=09=09=09}
=09=09}

=09
=09=09
=09=09dump_mode(s1);
=09=09close(s1);

=09=09printf("\nDisconnect: %m\n");
=09}
}



// Sending part at the receving end

unsigned char formpacket(unsigned char device, unsigned char len )
{
=09unsigned char temp=3D0x00;
=09unsigned char i,j,pdlen;
=09
=09packet[0]=3D0x7c;
=09switch(device)
=09{
=09=09case 1:
=09=09=09packet[1]=3D0x01;
=09=09=09break;
=09=09case 2:
=09=09=09packet[1]=3D0x02;
=09=09=09break;
=09=09case 3:
=09=09=09packet[1]=3D0x03;
=09=09=09break;
=09=09case 4:
=09=09=09packet[1]=3D0x04;
=09=09=09break;
=09}
=09=09
=09pdlen=3Dlen;
=09for(i=3D3,j=3D0;j<len;i++,j++)
=09{
=09=09/*if(buf[j]=3D=3D0x7c)
=09=09{
=09=09=09packet[i]=3D0x7c;
=09=09=09packet[++i]=3Dbuf[j];
=09=09=09pdlen++;=09=09=09
=09=09}
=09=09else*/
=09=09=09packet[i]=3Dsbuf[j];
=09=09
=09}
=09
=09packet[2]=3Dpdlen;

=09temp=3Dtemp ^ packet[0];
=09temp=3Dtemp ^ packet[1];
=09temp=3Dtemp ^ packet[2];
=09for(i=3D0;i<pdlen;i++)
=09=09temp=3Dtemp ^ packet[i+3];

=09packet[pdlen+3]=3Dtemp;
=09
=09return pdlen;=09
=09
}

void send_data(int s)
{
=09size_t datlen;
=09int i,nb;
=09datlen=3Dformpacket(0x04,0x0a);

=09if ((nb=3Dsend(s,&packet[0],(datlen+4),MSG_DONTWAIT))< 0)
=09=09=09perror("\nCan't send data.\n");
=09else
=09{
=09=09=09printf("\nNo. of bytes sent=3D%d\n",nb);
=09=09=09printf("\nPacket:\n");
=09=09=09for(i=3D0;i<datlen+4;i++)
=09=09=09=09printf(" %x ",packet[i]);=09
=09=09=09=09printf("\n\n");

=09=09=09//return 0;
=09}
}=09



static int remote_connect(char *svr)
{
=09struct sockaddr_l2 rem_addr, loc_addr;
=09struct l2cap_options opts;
=09struct l2cap_conninfo conn;
=09int s, opt;

=09if ((s =3D socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP)) < 0) {
=09=09printf("\nCan't create socket: %s (%d)\n", strerror(errno), errno);
=09=09return -1;
=09}
=09else=20
=09=09printf("\nL2CAP socket opened successfully.\n");


=09memset(&loc_addr, 0, sizeof(loc_addr));
=09loc_addr.l2_family =3D AF_BLUETOOTH;
=09bacpy(&loc_addr.l2_bdaddr, &bdaddr);
=09if (bind(s, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {
=09=09printf("\nCan't bind socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09/* Get default options */
=09memset(&opts, 0, sizeof(opts));
=09opt =3D sizeof(opts);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09printf("\nCan't get default L2CAP options: %s (%d)\n", strerror(errno=
), errno);
=09=09return -1;=09
=09}

=09/* Set new options */
=09opts.omtu =3D omtu;
=09opts.imtu =3D imtu;
=09if (setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
=09=09printf("\nCan't set L2CAP options: %s (%d)\n", strerror(errno), errno=
);
=09=09return -1;
=09}

=09/* Enable SO_LINGER */
=09if (linger) {
=09=09struct linger l =3D { .l_onoff =3D 1, .l_linger =3D linger };
=09=09if (setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
=09=09=09printf("\nCan't enable SO_LINGER: %s (%d)\n",
=09=09=09=09strerror(errno), errno);
=09=09=09return -1;
=09=09}
=09}

=09/* Set link mode */
=09opt =3D 0;
=09if (reliable)
=09=09opt |=3D L2CAP_LM_RELIABLE;

=09if (setsockopt(s, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
=09=09printf("\nCan't set L2CAP link mode: %s (%d)\n", strerror(errno), err=
no);
=09=09exit(1);
=09}

=09memset(&rem_addr, 0, sizeof(rem_addr));
=09rem_addr.l2_family =3D AF_BLUETOOTH;
=09str2ba(svr, &rem_addr.l2_bdaddr);
=09rem_addr.l2_psm =3D htobs(psm);
=09if (connect(s, (struct sockaddr *) &rem_addr, sizeof(rem_addr)) < 0 ) {
=09=09printf("\nCan't connect: %s (%d)\n", strerror(errno), errno);
=09=09close(s);
=09=09return -1;
=09}

=09memset(&opts, 0, sizeof(opts));
=09opt =3D sizeof(opts);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09printf("\nCan't get L2CAP options: %s (%d)\n", strerror(errno), errno=
);
=09=09close(s);
=09=09return -1;
=09}

=09memset(&conn, 0, sizeof(conn));
=09opt =3D sizeof(conn);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_CONNINFO, &conn, &opt) < 0) {
=09=09printf("\nCan't get L2CAP connection information: %s (%d)\n", strerro=
r(errno), errno);
=09=09close(s);
=09=09return -1;
=09}

=09printf("\nConnected [imtu %d, omtu %d, flush_to %d, mode %d, handle %d, =
class 0x%02x%02x%02x]\n",
=09=09opts.imtu, opts.omtu, opts.flush_to, opts.mode, conn.hci_handle,
=09=09conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);

=09return s;
}





int main(void)
{

=09int fd;
=09bacpy(&bdaddr, BDADDR_ANY);

=09if (!(buf =3D malloc(data_size))) {
=09=09perror("Can't allocate data buffer");
=09=09exit(1);
=09}

=09do_listen();
//=09fd=3Dremote_connect("01:5A:4B:20:07:DB");
//=09send_data(fd);

=09return 0;
}

------=_Part_48_32773339.1109154533065
Content-Type: text/x-c; name="senddata.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="senddata.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2000-2001  Qualcomm Incorporated
 *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
 *  Copyright (C) 2002-2005  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation;
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIG=
HTS.
 *  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR A=
NY
 *  CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES=
=20
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN=
=20
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF=
=20
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,=20
 *  COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS=20
 *  SOFTWARE IS DISCLAIMED.
 *
 *
 *  $Id: l2test.c,v 1.16 2005/01/11 21:42:38 holtmann Exp $
 */
                                                                           =
                          =20

=09=09=09/*Send program*/
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>

#include <sys/ioctl.h>
#include <fcntl.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/l2cap.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/l2cap.h>
#include <errno.h>
#include "csr.h"


unsigned char packet[256];
unsigned char buf[256]=3D{'a','b','c','d','e','f',0x7c,'g',0x7c,'i'};

static unsigned char *rbuf;


static int master =3D 0;
static int auth =3D 0;
static int encrypt =3D 0;
static int secure =3D 0;

static int reliable =3D 0;
static int socktype =3D SOCK_SEQPACKET;

/* Default mtu */
static int imtu =3D 672;
static int omtu =3D 0;
static int linger =3D 0;


/* Default data size */
static long data_size =3D 672;

/* Default addr and psm */
static bdaddr_t bdaddr;
static unsigned short psm =3D 10;


//const char str[18]=3D"00:0B:0D:33:DA:F9";


void dump_mode(int);
static int listen_connection(void);
void accept_connection(int);
static void do_listen(void);





unsigned char formpacket(unsigned char device, unsigned char len )
{
=09unsigned char temp=3D0x00;
=09unsigned char i,j,pdlen;
=09
=09packet[0]=3D0x7c;
=09switch(device)
=09{
=09=09case 1:
=09=09=09packet[1]=3D0x01;
=09=09=09break;
=09=09case 2:
=09=09=09packet[1]=3D0x02;
=09=09=09break;
=09=09case 3:
=09=09=09packet[1]=3D0x03;
=09=09=09break;
=09=09case 4:
=09=09=09packet[1]=3D0x04;
=09=09=09break;
=09}
=09=09
=09pdlen=3Dlen;
=09for(i=3D3,j=3D0;j<len;i++,j++)
=09{
=09=09/*if(buf[j]=3D=3D0x7c)
=09=09{
=09=09=09packet[i]=3D0x7c;
=09=09=09packet[++i]=3Dbuf[j];
=09=09=09pdlen++;=09=09=09
=09=09}
=09=09else*/
=09=09=09packet[i]=3Dbuf[j];
=09=09
=09}
=09
=09packet[2]=3Dpdlen;

=09temp=3Dtemp ^ packet[0];
=09temp=3Dtemp ^ packet[1];
=09temp=3Dtemp ^ packet[2];
=09for(i=3D0;i<pdlen;i++)
=09=09temp=3Dtemp ^ packet[i+3];

=09packet[pdlen+3]=3Dtemp;
=09
=09return pdlen;=09
=09
}

void send_data(int s)
{
=09size_t datlen;
=09int i,nb;
=09datlen=3Dformpacket(0x01,0x0a);

=09if ((nb=3Dsend(s,&packet[0],(datlen+4),MSG_DONTWAIT))< 0)
=09=09=09perror("\nCan't send data.\n");
=09else
=09{
=09=09=09printf("\nNo. of bytes sent=3D%d\n",nb);
=09=09=09printf("\nPacket:\n");
=09=09=09for(i=3D0;i<datlen+4;i++)
=09=09=09=09printf(" %x ",packet[i]);=09
=09=09=09=09printf("\n\n");

=09=09=09//return 0;
=09}
}=09

static int remote_connect(char *svr)
{
=09struct sockaddr_l2 rem_addr, loc_addr;
=09struct l2cap_options opts;
=09struct l2cap_conninfo conn;
=09int s, opt;

=09if ((s =3D socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP)) < 0) {
=09=09printf("\nCan't create socket: %s (%d)\n", strerror(errno), errno);
=09=09return -1;
=09}
=09else=20
=09=09printf("\nL2CAP socket opened successfully.\n");


=09memset(&loc_addr, 0, sizeof(loc_addr));
=09loc_addr.l2_family =3D AF_BLUETOOTH;
=09bacpy(&loc_addr.l2_bdaddr, &bdaddr);
=09if (bind(s, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {
=09=09printf("\nCan't bind socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09/* Get default options */
=09memset(&opts, 0, sizeof(opts));
=09opt =3D sizeof(opts);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09printf("\nCan't get default L2CAP options: %s (%d)\n", strerror(errno=
), errno);
=09=09return -1;=09
=09}

=09/* Set new options */
=09opts.omtu =3D omtu;
=09opts.imtu =3D imtu;
=09if (setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
=09=09printf("\nCan't set L2CAP options: %s (%d)\n", strerror(errno), errno=
);
=09=09return -1;
=09}

=09/* Enable SO_LINGER */
=09if (linger) {
=09=09struct linger l =3D { .l_onoff =3D 1, .l_linger =3D linger };
=09=09if (setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
=09=09=09printf("\nCan't enable SO_LINGER: %s (%d)\n",
=09=09=09=09strerror(errno), errno);
=09=09=09return -1;
=09=09}
=09}

=09/* Set link mode */
=09opt =3D 0;
=09if (reliable)
=09=09opt |=3D L2CAP_LM_RELIABLE;

=09if (setsockopt(s, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
=09=09printf("\nCan't set L2CAP link mode: %s (%d)\n", strerror(errno), err=
no);
=09=09exit(1);
=09}

=09memset(&rem_addr, 0, sizeof(rem_addr));
=09rem_addr.l2_family =3D AF_BLUETOOTH;
=09str2ba(svr, &rem_addr.l2_bdaddr);
=09rem_addr.l2_psm =3D htobs(psm);
=09if (connect(s, (struct sockaddr *) &rem_addr, sizeof(rem_addr)) < 0 ) {
=09=09printf("\nCan't connect: %s (%d)\n", strerror(errno), errno);
=09=09close(s);
=09=09return -1;
=09}

=09memset(&opts, 0, sizeof(opts));
=09opt =3D sizeof(opts);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09printf("\nCan't get L2CAP options: %s (%d)\n", strerror(errno), errno=
);
=09=09close(s);
=09=09return -1;
=09}

=09memset(&conn, 0, sizeof(conn));
=09opt =3D sizeof(conn);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_CONNINFO, &conn, &opt) < 0) {
=09=09printf("\nCan't get L2CAP connection information: %s (%d)\n", strerro=
r(errno), errno);
=09=09close(s);
=09=09return -1;
=09}

=09printf("\nConnected [imtu %d, omtu %d, flush_to %d, mode %d, handle %d, =
class 0x%02x%02x%02x]\n",
=09=09opts.imtu, opts.omtu, opts.flush_to, opts.mode, conn.hci_handle,
=09=09conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);

=09return s;
}

// Recevie part at the sending end

#if 0
static int listen_connection(void)
{
=09struct sockaddr_l2 loc_addr, rem_addr;
=09struct l2cap_options opts;
=09int s, s1, opt;
=09char ba[18];

=09
=09bacpy(&bdaddr, BDADDR_ANY);


=09if ((s =3D socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP)) < 0) {
=09=09printf("\nCan't create socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09loc_addr.l2_family =3D AF_BLUETOOTH;
=09bacpy(&loc_addr.l2_bdaddr, &bdaddr);
=09loc_addr.l2_psm =3D htobs(psm);
=09
=09if (bind(s, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {
=09=09printf("\nCan't bind socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09/* Set link mode */
=09opt =3D 0;
=09if (reliable)
=09=09opt |=3D L2CAP_LM_RELIABLE;
=09if (master)
=09=09opt |=3D L2CAP_LM_MASTER;
=09if (auth)
=09=09opt |=3D L2CAP_LM_AUTH;
=09if (encrypt)
=09=09opt |=3D L2CAP_LM_ENCRYPT;
=09if (secure)
=09=09opt |=3D L2CAP_LM_SECURE;

=09if (setsockopt(s, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
=09=09printf("\nCan't set L2CAP link mode: %s (%d)\n", strerror(errno), err=
no);
=09=09exit(1);
=09}

=09/* Get default options */
=09opt =3D sizeof(opts);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09printf("\nCan't get default L2CAP options: %s (%d)\n", strerror(errno=
), errno);
=09=09exit(1);
=09}

=09/* Set new options */
=09opts.imtu =3D imtu;
=09if (setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
=09=09printf("\nCan't set L2CAP options: %s (%d)\n", strerror(errno), errno=
);
=09=09exit(1);
=09}

=09=09
=09return s;

}


void accept_connection(int s)
{
=09struct sockaddr_l2 loc_addr, rem_addr;
=09struct l2cap_options opts;
=09int s1, opt;
=09char ba[18];

=09=09if (listen(s, 10)) {
=09=09printf("\nCan not listen on the socket: %s (%d)\n", strerror(errno), =
errno);
=09=09exit(1);
=09=09}

=09=09printf("\nWaiting for connection on psm %d ...\n", psm);
=09

=09=09while(1) {
=09=09opt =3D sizeof(rem_addr);
=09=09if ((s1 =3D accept(s, (struct sockaddr *) &rem_addr, &opt)) < 0) {
=09=09=09printf("\nAccept failed: %s (%d)\n", strerror(errno), errno);
=09=09=09exit(1);
=09=09}

=09=09opt =3D sizeof(opts);
=09=09if (getsockopt(s1, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09=09printf("\nCan't get L2CAP options: %s (%d)\n", strerror(errno), er=
rno);
=09=09=09exit(1);
=09=09}

=09=09ba2str(&rem_addr.l2_bdaddr, ba);
=09=09printf("\nConnect from %s [imtu %d, omtu %d, flush_to %d]\n",ba, opts=
.imtu, opts.omtu, opts.flush_to);

=09=09/* Enable SO_LINGER */
=09=09if (linger) {
=09=09=09struct linger l =3D { .l_onoff =3D 1, .l_linger =3D linger };
=09=09=09if (setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
=09=09=09=09printf("\nCan't enable SO_LINGER: %s (%d)\n",
=09=09=09=09=09strerror(errno), errno);
=09=09=09=09exit(1);
=09=09=09}
=09=09}

=09
=09=09
=09=09dump_mode(s1);
=09=09close(s1);

=09=09printf("\nDisconnect: %m\n");
=09}
}
#endif

static void do_listen(void)
{
=09struct sockaddr_l2 loc_addr, rem_addr;
=09struct l2cap_options opts;
=09int s, s1, opt;
=09char ba[18];

=09if ((s =3D socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP)) < 0) {
=09=09printf("\nCan't create socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09loc_addr.l2_family =3D AF_BLUETOOTH;
=09bacpy(&loc_addr.l2_bdaddr, &bdaddr);
=09loc_addr.l2_psm =3D htobs(psm);
=09
=09if (bind(s, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {
=09=09printf("\nCan't bind socket: %s (%d)\n", strerror(errno), errno);
=09=09exit(1);
=09}

=09/* Set link mode */
=09opt =3D 0;
=09if (reliable)
=09=09opt |=3D L2CAP_LM_RELIABLE;
=09if (master)
=09=09opt |=3D L2CAP_LM_MASTER;
=09if (auth)
=09=09opt |=3D L2CAP_LM_AUTH;
=09if (encrypt)
=09=09opt |=3D L2CAP_LM_ENCRYPT;
=09if (secure)
=09=09opt |=3D L2CAP_LM_SECURE;

=09if (setsockopt(s, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
=09=09printf("\nCan't set L2CAP link mode: %s (%d)\n", strerror(errno), err=
no);
=09=09exit(1);
=09}

=09/* Get default options */
=09opt =3D sizeof(opts);
=09if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09printf("\nCan't get default L2CAP options: %s (%d)\n", strerror(errno=
), errno);
=09=09exit(1);
=09}

=09/* Set new options */
=09opts.imtu =3D imtu;
=09if (setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
=09=09printf("\nCan't set L2CAP options: %s (%d)\n", strerror(errno), errno=
);
=09=09exit(1);
=09}

/*=09if (socktype =3D=3D SOCK_DGRAM) {
=09=09handler(s);
=09=09return;
=09}*/

=09if (listen(s, 10)) {
=09=09printf("\nCan not listen on the socket: %s (%d)\n", strerror(errno), =
errno);
=09=09exit(1);
=09}

=09printf("\nWaiting for connection on psm %d ...\n", psm);

=09while(1) {
=09=09opt =3D sizeof(rem_addr);
=09=09if ((s1 =3D accept(s, (struct sockaddr *) &rem_addr, &opt)) < 0) {
=09=09=09printf("\nAccept failed: %s (%d)\n", strerror(errno), errno);
=09=09=09exit(1);
=09=09}

=09=09opt =3D sizeof(opts);
=09=09if (getsockopt(s1, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
=09=09=09printf("\nCan't get L2CAP options: %s (%d)\n", strerror(errno), er=
rno);
=09=09=09exit(1);
=09=09}

=09=09ba2str(&rem_addr.l2_bdaddr, ba);
=09=09printf("\nConnect from %s [imtu %d, omtu %d, flush_to %d]\n",ba, opts=
.imtu, opts.omtu, opts.flush_to);

=09=09/* Enable SO_LINGER */
=09=09if (linger) {
=09=09=09struct linger l =3D { .l_onoff =3D 1, .l_linger =3D linger };
=09=09=09if (setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
=09=09=09=09printf("\nCan't enable SO_LINGER: %s (%d)\n",
=09=09=09=09=09strerror(errno), errno);
=09=09=09=09exit(1);
=09=09=09}
=09=09}

=09
=09=09
=09=09dump_mode(s1);
=09=09close(s1);

=09=09printf("\nDisconnect: %m\n");
=09}
}



static void hexdump(unsigned char *s, unsigned long l)
{
=09unsigned long i;
=09unsigned char j,k;
=09unsigned char temp=3D0x00;

=09/*for(i=3D0;i<l;i++)
=09{
=09=09printf("\r\n0x");
=09=09printf("%x",s[i]);
=09}
=09printf("\r\n");*/
=09
=09for(i=3D0;i<l;i++)
=09{
=09=09if((s[i]=3D=3D 0x7C)) =09//&& (s[i+1] !=3D 0x7C))
=09=09{
=09=09=09temp=3Dtemp ^ s[i];
=09=09=09temp=3Dtemp ^ s[i+1];
=09=09=09temp=3Dtemp ^ s[i+2];
=09=09=09
=09=09=09for(k=3Di;k<(i+s[i+2]);k++)
=09=09=09=09temp=3Dtemp ^ s[k+3];

=09=09=09=09=09
=09=09=09=09if(s[s[i+2]+3]=3D=3Dtemp)
=09=09=09=09=09printf("\nPacket recevied correctly\n");
=09=09=09=09else
=09=09=09=09{
=09=09=09=09=09printf("\nPacket corrupted\n");
=09=09=09=09=09return;
=09=09=09=09}

=09=09=09=09
=09=09=09if(s[i+1]=3D=3D0x01)
=09=09=09{
=09=09=09=09printf("\nKeyboard data packet\n");
=09=09=09=09printf("\nNo. of bytes in Keyboard packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09=09=09
=09=09=09if(s[i+1]=3D=3D0x02)
=09=09=09{
=09=09=09=09printf("\nMouse data packet\n");
=09=09=09=09printf("\nNo. of bytes in Mouse packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09=09
=09=09=09if(s[i+1]=3D=3D0x03)
=09=09=09{
=09=09=09=09printf("\nFinger print data packet\n");
=09=09=09=09printf("\nNo. of bytes in Finger print packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09=09
=09=09=09if(s[i+1]=3D=3D0x04)
=09=09=09{
=09=09=09=09printf("\nControl packet\n");
=09=09=09=09printf("\nNo. of bytes in Control packet:%x\n",s[2]);
=09=09=09=09for(j=3D3;j<(s[i+2]+3);j++)
=09=09=09=09=09printf(" %x ",s[j]);
=09=09=09}
=09=09break;
=09=09}
=09}
=09=09=09

=09


}


void dump_mode(int s)
{
=09int len;
=09int opt, optl;


=09printf("\r\nReceiving ...\r\n");

=09while (1) {
=09=09fd_set rset;

=09=09FD_ZERO(&rset);
=09=09FD_SET(s, &rset);

=09=09if (select(s + 1, &rset, NULL, NULL, NULL) < 0)
=09=09=09return;

=09=09if (!FD_ISSET(s, &rset))
=09=09=09continue;

=09=09len =3D read(s, rbuf, data_size);
=09=09printf("\nRecevied %d bytes\n", len);

=09=09if (len <=3D 0) {
=09=09=09if (len < 0) {
=09=09=09=09if (reliable && (errno =3D=3D ECOMM)) {
=09=09=09=09=09printf("\r\nL2CAP Error ECOMM - clearing error and continuin=
g.\r\n");
=09=09=09=09=09optl =3D sizeof(opt);
=09=09=09=09=09if (getsockopt(s, SOL_SOCKET, SO_ERROR, &opt, &optl ) < 0) {=
 // Clear error
=09=09=09=09=09=09printf("\r\nCouldn't getsockopt(SO_ERROR): %s (%d)\r\n",
=09=09=09=09=09=09=09strerror(errno), errno);
=09=09=09=09=09=09return;
=09=09=09=09=09}
=09=09=09=09=09continue;
=09=09=09=09} else {
=09=09=09=09=09printf("\r\nRead error: %s(%d)\n", strerror(errno), errno);
=09=09=09=09}
=09=09=09}
=09=09//=09return;
=09=09=09break;
=09=09//=09continue;
=09=09}
=09//=09else if(len > 0)
=09=09{=09=09=09
=09=09=09printf("\nRecevied %d bytes\n", len);
=09=09=09hexdump(rbuf,len);
=09=09}
=09}
=09close(s);
}


int main(void)
{
=09int fd;
=09fd=3Dremote_connect("00:0B:0D:33:DA:F9");
=09send_data(fd);
=09//fd=3Dlisten_connection();
=09//accept_connection(fd);
//=09do_listen();
=09
=09

}




------=_Part_48_32773339.1109154533065--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
