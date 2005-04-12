Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <425BEB6E.4080500@palmsource.com>
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------090503080704080006090309"
Subject: [Bluez-devel] RFComm doesn't disconnect in server mode
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
Date: Tue, 12 Apr 2005 17:38:22 +0200

This is a multi-part message in MIME format.
--------------090503080704080006090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am working on headset profile implementation. In server mode, the 
headset (Jabra BT200) connects fine, but once my program close the 
RFComm socket, the ACL link is still up, until I stop the headset.

I get in console :
     fdanis:> ./hstest server - 00:07:A4:05:B6:DA
     Server RFCOMM socket 3 listen on RFComm 2
     RFComm connected
     AT+CKPD=200
     RFComm disconnected
     fdanis:>

Here are the last traces I got before stopping headset :
     > HCI Event: Mode Change (0x14) plen 6
       0000: 00 29 00 02 00 08                                 .)....
     < ACL data: handle 0x0029 flags 0x02 dlen 8
         L2CAP(d): cid 0x0042 len 4 [psm 3]
           RFCOMM(s): DISC: cr 0 dlci 4 pf 1 ilen 0 fcs 0x16
     > HCI Event: Number of Completed Packets (0x13) plen 5
       0000: 01 29 00 01 00                                    .)...
     > ACL data: handle 0x0029 flags 0x02 dlen 8
         L2CAP(d): cid 0x0041 len 4 [psm 3]
           RFCOMM(s): UA: cr 0 dlci 4 pf 1 ilen 0 fcs 0x3c

Maybe a RFCOMM DISC frame on the DLCI 0 is missing.

After, disconnecting headset :
     > HCI Event: Mode Change (0x14) plen 6
       0000: 00 29 00 00 00 00                                 .)....
     > HCI Event: Disconn Complete (0x05) plen 4
       0000: 00 29 00 08                                       .)..

I attached changes I do to hstest to exercise it, and HCI dump.
I used SUSE 9.2 with kernel 2.6.8-24.5.
I certainly made something wrong, but I don't no what.

Regards

Fred

-----------------------------------------------



--------------090503080704080006090309
Content-Type: text/plain;
 name="hci-dump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hci-dump.txt"

HCIDump - HCI packet analyzer ver 1.11
device: hci1 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: da b6 05 a4 07 00 0c 04 20 01                     ........ .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: da b6 05 a4 07 00 01                              .......
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: da b6 05 a4 07 00                                 ......
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: da b6 05 a4 07 00 f1 1b 51 e3 a2 ea 97 8d 29 1f   ........Q.....).
  0010: da f8 9c ee a3 f0                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 da b6 05 a4 07 00                     ..........
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 da b6 05 a4 07 00 01 01                  .).........
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                       )...
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: da b6 05 a4 07 00 01                              .......
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 29 00                                 ....).
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 29 00 18 cc                                       )...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 29 00 18 cc                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 48 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1112 (AG)
          max 0x28
          cont 00 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          tot 0x1 cur 0x1 hndl 0x10006
          cont 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          hndl 0x10006
          max 0x26
          aid(s) 0x0004 (ProtocolDescList)
          cont 00 
< ACL data: handle 0x0029 flags 0x02 dlen 31
    L2CAP(d): cid 0x0041 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          cnt 0x13
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x2 > >

          cont 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0042
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 132 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x0000 clen 4
    MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
    MTU 132 
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 4 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 0
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0042 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 4 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96 
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0042 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0042 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0042 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 33
> ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 20
    L2CAP(d): cid 0x0041 len 16 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 12 fcs 0x65 
      0000: 41 54 2b 43 4b 50 44 3d 32 30 30 0d               AT+CKPD=200.
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0042 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 0 ilen 4 fcs 0xbf 
      0000: 4f 4b 0d 0a                                       OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 29 00 02 00 08                                 .)....
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 4 pf 1 ilen 0 fcs 0x16 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 4 pf 1 ilen 0 fcs 0x3c 


--------------090503080704080006090309
Content-Type: text/plain;
 name="hstest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hstest.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2002-2004  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation;
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
 *  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
 *  CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
 *  COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
 *  SOFTWARE IS DISCLAIMED.
 *
 *
 *  $Id: hstest.c,v 1.6 2004/12/25 17:43:20 holtmann Exp $
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <termios.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sco.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

static volatile int terminate = 0;

static void sig_term(int sig) {
	terminate = 1;
}

static int rfcomm_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t channel)
{
	struct sockaddr_rc addr;
	int s;

	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, src);
	addr.rc_channel = 0;
	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(s);
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, dst);
	addr.rc_channel = channel;
	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0 ){
		close(s);
		return -1;
	}

	return s;
}

static int sco_connect(bdaddr_t *src, bdaddr_t *dst, uint16_t *handle, uint16_t *mtu)
{
	struct sockaddr_sco addr;
	struct sco_conninfo conn;
	struct sco_options opts;
	int s, size;

	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)) < 0) {
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.sco_family = AF_BLUETOOTH;
	bacpy(&addr.sco_bdaddr, src);

	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(s);
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.sco_family = AF_BLUETOOTH;
	bacpy(&addr.sco_bdaddr, dst);

	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0 ){
		close(s);
		return -1;
	}

	memset(&conn, 0, sizeof(conn));
	size = sizeof(conn);

	if (getsockopt(s, SOL_SCO, SCO_CONNINFO, &conn, &size) < 0) {
		close(s);
		return -1;
	}

	memset(&opts, 0, sizeof(opts));
	size = sizeof(opts);

	if (getsockopt(s, SOL_SCO, SCO_OPTIONS, &opts, &size) < 0) {
		close(s);
		return -1;
	}

	if (handle)
		*handle = conn.hci_handle;

	if (mtu)
		*mtu = opts.mtu;

	return s;
}

#define PLAY	1
#define RECORD	2
#define SERVER	3

static int client(bdaddr_t bdaddr, uint8_t channel, int fd, int mode)
{
	fd_set rfds;
	struct timeval timeout;
	unsigned char buf[2048], *p;
	int maxfd, sel, rlen, wlen;

	int rd, sd;
	uint16_t sco_handle, sco_mtu, vs;

	if ((rd = rfcomm_connect(BDADDR_ANY, &bdaddr, channel)) < 0) {
		perror("Can't connect RFCOMM channel");
		return -1;
	}

	fprintf(stderr, "RFCOMM channel connected\n");

	if ((sd = sco_connect(BDADDR_ANY, &bdaddr, &sco_handle, &sco_mtu)) < 0) {
		perror("Can't connect SCO audio channel");
		close(rd);
		return -1;
	}

	fprintf(stderr, "SCO audio channel connected (handle %d, mtu %d)\n", sco_handle, sco_mtu);

	if (mode == RECORD)
		write(rd, "RING\r\n", 6);

	maxfd = (rd > sd) ? rd : sd;

	while (!terminate) {

		FD_ZERO(&rfds);
		FD_SET(rd, &rfds);
		FD_SET(sd, &rfds);

		timeout.tv_sec = 0;
		timeout.tv_usec = 10000;

		if ((sel = select(maxfd + 1, &rfds, NULL, NULL, &timeout)) > 0) {

			if (FD_ISSET(rd, &rfds)) {
				memset(buf, 0, sizeof(buf));
				rlen = read(rd, buf, sizeof(buf));
				if (rlen > 0) {
					fprintf(stderr, "%s\n", buf);
					wlen = write(rd, "OK\r\n", 4);
				}
			}

			if (FD_ISSET(sd, &rfds)) {
				memset(buf, 0, sizeof(buf));
				rlen = read(sd, buf, sizeof(buf));
				if (rlen > 0)
					switch (mode) {
					case PLAY:
						rlen = read(fd, buf, rlen);

						wlen = 0; 
						p = buf;
						while (rlen > sco_mtu) {
						        wlen += write(sd, p, sco_mtu);
						        rlen -= sco_mtu;
						        p += sco_mtu;
						}
						wlen += write(sd, p, rlen);
						break;
					case RECORD:
						wlen = write(fd, buf, rlen);
						break;
					default:
						break;
					}
			}

		}

	}

	close(sd);
	sleep(5);
	close(rd);

	return 0;
}

static int server(int fd)
{
	int rsd, rd;
	struct sockaddr_rc addr;
	socklen_t addrlen;
	sdp_session_t *sdpSession;
	sdp_record_t *recordP;
	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
	uuid_t root_uuid, l2cap, rfcomm, svcuuid;
	sdp_profile_desc_t sdp_profile[1];
	sdp_list_t *proto[2];
	fd_set rfds;
	struct timeval timeout;
	int maxfd, sel, rlen, wlen;
	unsigned char buf[2048];
	int error;

	// Create incoming RFComm socket
	rsd = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
	if (rsd < 0)
	{
		perror("ERROR failed to create socket");
		return -1;
	}

	/* Bind to local address */
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, BDADDR_ANY);
	addr.rc_channel = 0;

	if (bind(rsd, (struct sockaddr *) &addr, sizeof(addr)) < 0)
	{
		perror("ERROR Server RFCOMM binding error");
		close(rsd);
		return -1;
	}

	/* Listen for connections */
	if (listen(rsd, 1))
	{
		perror("ERROR Server RFCOMM listen error");
		close(rsd);
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addrlen = sizeof(addr);
	if (getsockname(rsd, (struct sockaddr *) &addr, &addrlen) < 0)
	{
		perror("ERROR Server RFCOMM getsockname error");
		close(rsd);
		return -1;
	}

	fprintf(stderr, "Server RFCOMM socket %lu listen on RFComm %lu\n", (unsigned long) rsd, (unsigned long) addr.rc_channel);

	// Prepare SDP record
	sdpSession = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
	if (!sdpSession)
	{
		perror("ERROR Can not start SDP session");
		return -1;
	}

	recordP = sdp_record_alloc();
	if (!recordP)
	{
		perror("ERROR Allocate for service description failed");
		return -1;
	}

	// Add to Public Browse Group
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(NULL, &root_uuid);
	sdp_set_browse_groups(recordP, root);

	// Set Protocol descriptors
	sdp_uuid16_create(&l2cap, L2CAP_UUID);
	proto[0] = sdp_list_append(NULL, &l2cap);
	apseq = sdp_list_append(NULL, proto[0]);

	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
	proto[1] = sdp_list_append(NULL, &rfcomm);
	proto[1] = sdp_list_append(proto[1], sdp_data_alloc(SDP_UINT8, &addr.rc_channel));
	apseq = sdp_list_append(apseq, proto[1]);

	aproto = sdp_list_append(NULL, apseq);
	sdp_set_access_protos(recordP, aproto);

	// Set service class
	sdp_uuid16_create(&svcuuid, HEADSET_AGW_SVCLASS_ID);
	svclass = sdp_list_append(NULL, &svcuuid);
	sdp_uuid16_create(&svcuuid, GENERIC_AUDIO_SVCLASS_ID);
	svclass = sdp_list_append(svclass, &svcuuid);
	sdp_set_service_classes(recordP, svclass);

	// Set profile descriptor
	sdp_uuid16_create(&sdp_profile[0].uuid, HEADSET_AGW_PROFILE_ID);
	sdp_profile[0].version = 0x0100;
	pfseq = sdp_list_append(NULL, &sdp_profile[0]);
	sdp_set_profile_descs(recordP, pfseq);

	sdp_set_info_attr(recordP, "Voice gateway", NULL, NULL);

	// Advertise SDP record
	error = sdp_record_register(sdpSession, recordP, 0);
	if (error)
	{
		perror("ERROR Unable to advertise service");
		sdp_record_free(recordP);
		recordP = NULL;
		return -1;
	}

	while (!terminate)
	{
		FD_ZERO(&rfds);
		FD_SET(rsd, &rfds);

		timeout.tv_sec = 0;
		timeout.tv_usec = 10000;

		if ((sel = select(rsd + 1, &rfds, NULL, NULL, &timeout)) > 0)
		{
			if (FD_ISSET(rsd, &rfds))
			{
				if ((rd = accept(rsd, (struct sockaddr *) &addr, &addrlen)) < 0)
				{
					perror("ERROR accept failed");
					break;
				}

				fprintf(stderr, "RFComm connected\n");

				while (!terminate)
				{
					FD_ZERO(&rfds);
					FD_SET(rd, &rfds);
					
					timeout.tv_sec = 0;
					timeout.tv_usec = 10000;
					
					if ((sel = select(rd + 1, &rfds, NULL, NULL, &timeout)) > 0)
					{
						if (FD_ISSET(rd, &rfds))
						{
							memset(buf, 0, sizeof(buf));
							rlen = read(rd, buf, sizeof(buf));
							if (rlen > 0)
							{
								fprintf(stderr, "%s\n", buf);
								wlen = write(rd, "OK\r\n", 4);
							}
						}
					}
				}
				
				fprintf(stderr, "RFComm disconnected\n");

				sleep(5);
				close(rd);
			}
		}
	}

	sleep(5);
	close(rsd);

	sdp_record_unregister(sdpSession, recordP);
	sdp_close(sdpSession);
}

static void usage(void)
{
	printf("Usage:\n"
		"\thstest play   <file> <bdaddr> [channel]\n"
		"\thstest record <file> <bdaddr> [channel]\n"
		"\thstest server <file> <bdaddr> [channel]\n");
}

int main(int argc, char *argv[])
{
	struct sigaction sa;

	bdaddr_t local;
	bdaddr_t bdaddr;
	uint8_t channel;

	char *filename;
	mode_t filemode;
	int mode = 0;
	int dd, fd;

	switch (argc) {
	case 4:
		str2ba(argv[3], &bdaddr);
		channel = 6;
		break;
	case 5:
		str2ba(argv[3], &bdaddr);
		channel = atoi(argv[4]);
		break;
	default:
		usage();
		exit(-1);
	}

	if (strncmp(argv[1], "play", 4) == 0) {
		mode = PLAY;
		filemode = O_RDONLY;
	} else if (strncmp(argv[1], "rec", 3) == 0) {
		mode = RECORD;
		filemode = O_WRONLY | O_CREAT | O_TRUNC;
	} else if (strncmp(argv[1], "serv", 4) == 0) {
		mode = SERVER;
		filemode = O_WRONLY | O_CREAT | O_TRUNC;
	} else {
		usage();
		exit(-1);
	}

	filename = argv[2];

/*	hci_devba(0, &local);
	dd = hci_open_dev(0);
	hci_read_voice_setting(dd, &vs, 1000);
	vs = htobs(vs);
	fprintf(stderr, "Voice setting: 0x%04x\n", vs);
	close(dd);
/*	if (vs != 0x0060) {
		fprintf(stderr, "The voice setting must be 0x0060\n");
		return -1;
	}
*/
	if (strcmp(filename, "-") == 0) {
		switch (mode) {
		case PLAY:
			fd = 0;
			break;
		case RECORD:
		case SERVER:
			fd = 1;
			break;
		default:
			return -1;
		}
	} else {
		if ((fd = open(filename, filemode)) < 0) {
			perror("Can't open input/output file");
			return -1;
		}
	}

	memset(&sa, 0, sizeof(sa));
	sa.sa_flags = SA_NOCLDSTOP;
	sa.sa_handler = sig_term;
	sigaction(SIGTERM, &sa, NULL);
	sigaction(SIGINT,  &sa, NULL);

	sa.sa_handler = SIG_IGN;
	sigaction(SIGCHLD, &sa, NULL);
	sigaction(SIGPIPE, &sa, NULL);

	if (mode == SERVER)
		server(fd);
	else
		client(bdaddr, channel, fd, mode);

	close(fd);

	return 0;
}


--------------090503080704080006090309--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
