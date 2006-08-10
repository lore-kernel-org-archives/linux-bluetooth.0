Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 10 Aug 2006 18:38:27 +0530
Message-ID: <004b01c6bc7e$11d83100$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_004C_01C6BCAC.2B906D00"
Subject: [Bluez-devel] HCRP Printer Application
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_004C_01C6BCAC.2B906D00
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Please find attached the source code for an application written on the =
BlueZ Stack that will emulate an HCRP Printer.
The source code is divided into three files (main.c, sdp.c and hcrp.c).

It is actually based on the HCRP Client application written by you that =
is present in the bluez-util-x.x/cups folder.

I am not an expert in writing Makefiles, so can you please write one for =
it?

To test it, I just compiled it as follows:
gcc -o printer main.c sdp.c hcrp.c -lbluetooth

Usage:
=3D=3D=3D=3D=3D=3D
./printer ctrl_psm data_psm

Where ctrl_psm is the l2cap psm for the Control channel and data_psm is =
the l2cap psm for the Data channel. (As you know that PSM values for =
control channel and data channel is dynamic in HCRP).

I would be grateful if you could add this application in the next =
release of bluez-utils.

Also, now since there are both HCRP Client and Printer present, you may =
have to create separate folders for them inside cups/
My suggestion would be to go for cups/client and cups/printer.

Please let me know in case of any clarification.

Thanks.

Regards,
Mayank

------=_NextPart_000_004C_01C6BCAC.2B906D00
Content-Type: application/octet-stream;
	name="hcrp.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hcrp.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Hardcopy Cable Replacement Profile (HCRP) Printer Application=20
 *
 *  Copyright (C) 2006  Mayank Batra <mayank.batra@st.com>,
 *                      STMicroelectronics Ltd.
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/l2cap.h>

#include <netinet/in.h>

#define BUFS 2048

#define HCRP_PDU_CREDIT_GRANT		0x0001
#define HCRP_PDU_CREDIT_REQUEST		0x0002
#define HCRP_PDU_GET_LPT_STATUS		0x0005

#define HCRP_STATUS_FEATURE_UNSUPPORTED	0x0000
#define HCRP_STATUS_SUCCESS		0x0001
#define HCRP_STATUS_CREDIT_SYNC_ERROR	0x0002
#define HCRP_STATUS_GENERIC_FAILURE	0xffff

int rcvd_credits =3D 0;
int granted_credits =3D 0;

static volatile sig_atomic_t __io_canceled =3D 0;

struct hcrp_pdu_hdr {
	uint16_t pid;
	uint16_t tid;
	uint16_t plen;
} __attribute__ ((packed));
#define HCRP_PDU_HDR_SIZE 6

struct hcrp_credit_grant_cp {
	uint32_t credit;
} __attribute__ ((packed));
#define HCRP_CREDIT_GRANT_CP_SIZE 4

struct hcrp_credit_grant_rp {
	uint16_t status;
} __attribute__ ((packed));
#define HCRP_CREDIT_GRANT_RP_SIZE 2

struct hcrp_credit_request_rp {
	uint16_t status;
	uint32_t credit;
} __attribute__ ((packed));
#define HCRP_CREDIT_REQUEST_RP_SIZE 6

struct hcrp_get_lpt_status_rp {
	uint16_t status;
	uint8_t  lpt_status;
} __attribute__ ((packed));
#define HCRP_GET_LPT_STATUS_RP_SIZE 3

#if 0
static void dump_packet(void *, int);
#endif

static void sig_term(int sig)
{
	__io_canceled =3D 1;
}

static int hcrp_credit_grant_response(int sk, struct hcrp_pdu_hdr *hdr, =
struct hcrp_credit_grant_cp *cp)
{
	struct hcrp_pdu_hdr hdr_rp;
	struct hcrp_credit_grant_rp rp;
	unsigned char buf[128];

	rcvd_credits +=3D cp->credit;

	hdr_rp.pid =3D htons(HCRP_PDU_CREDIT_GRANT);
	hdr_rp.tid =3D hdr->tid;
	hdr_rp.plen =3D htons(HCRP_CREDIT_GRANT_RP_SIZE);
	rp.status =3D htons(HCRP_STATUS_SUCCESS);
	memcpy(buf, &hdr_rp, HCRP_PDU_HDR_SIZE);
	memcpy(buf + HCRP_PDU_HDR_SIZE, &rp, HCRP_CREDIT_GRANT_RP_SIZE);
	write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_GRANT_RP_SIZE);
}

static void hcrp_credit_request_response(int sk, struct hcrp_pdu_hdr =
*hdr)
{
	struct hcrp_pdu_hdr hdr_rp;
	struct hcrp_credit_request_rp rp;
	unsigned char buf[128];

	hdr_rp.pid =3D htons(HCRP_PDU_CREDIT_REQUEST);
	hdr_rp.tid =3D hdr->tid;
	hdr_rp.plen =3D htons(HCRP_CREDIT_REQUEST_RP_SIZE);
	rp.status =3D htons(HCRP_STATUS_SUCCESS);
	rp.credit =3D 0xFFFF0000;	/* 64KB of credits seem OK */
	memcpy(buf, &hdr_rp, HCRP_PDU_HDR_SIZE);
	memcpy(buf + HCRP_PDU_HDR_SIZE, &rp, HCRP_CREDIT_REQUEST_RP_SIZE);
	write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_REQUEST_RP_SIZE);

	granted_credits +=3D 0x0000FFFF;
}

static void hcrp_get_lpt_status_response(int sk, struct hcrp_pdu_hdr =
*hdr)
{
	struct hcrp_pdu_hdr hdr_rp;
	struct hcrp_get_lpt_status_rp rp;
	unsigned char buf[128];

	hdr_rp.pid =3D htons(HCRP_PDU_GET_LPT_STATUS);
	hdr_rp.tid =3D hdr->tid;
	hdr_rp.plen =3D htons(HCRP_GET_LPT_STATUS_RP_SIZE);
	rp.status =3D htons(HCRP_STATUS_SUCCESS);
	rp.lpt_status =3D 0x18; /* Selected, No Error */
	memcpy(buf, &hdr_rp, HCRP_PDU_HDR_SIZE);
	memcpy(buf + HCRP_PDU_HDR_SIZE, &rp, HCRP_GET_LPT_STATUS_RP_SIZE);
	/* dump_packet(buf, HCRP_PDU_HDR_SIZE + HCRP_GET_LPT_STATUS_RP_SIZE); =
*/
	write(sk,buf, HCRP_PDU_HDR_SIZE + HCRP_GET_LPT_STATUS_RP_SIZE);
}

static void hcrp_send_error_response(int sk, struct hcrp_pdu_hdr *hdr)
{
	struct hcrp_pdu_hdr hdr_rp;
	/*	This struct contains only status
	*	So thought reusing it rather than writing=20
	*	a 'new' error response struct
	*/
	struct hcrp_credit_grant_rp rp;
	unsigned char buf[128];

	hdr_rp.pid =3D hdr->pid;
	hdr_rp.tid =3D hdr->tid;
	hdr_rp.plen =3D htons(0x02);
	rp.status =3D htons(HCRP_STATUS_GENERIC_FAILURE);
	memcpy(buf, &hdr_rp, HCRP_PDU_HDR_SIZE);
	memcpy(buf + HCRP_PDU_HDR_SIZE, &rp, HCRP_CREDIT_GRANT_RP_SIZE);
	write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_GRANT_RP_SIZE);
}

static void hcrp_send_credit_sync_error_response(int sk, struct =
hcrp_pdu_hdr *hdr)
{
	struct hcrp_pdu_hdr hdr_rp;
	/* Again some reuse */
	struct hcrp_credit_grant_rp rp;
	unsigned char buf[128];

	hdr_rp.pid =3D hdr->pid;
	hdr_rp.tid =3D hdr->tid;
	hdr_rp.plen =3D htons(0x02);
	rp.status =3D htons(HCRP_STATUS_CREDIT_SYNC_ERROR);
	memcpy(buf, &hdr_rp, HCRP_PDU_HDR_SIZE);
	memcpy(buf + HCRP_PDU_HDR_SIZE, &rp, HCRP_CREDIT_GRANT_RP_SIZE);
	write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_GRANT_RP_SIZE);
}
#if 0
static void dump_packet(void *p, int size)
{
	uint8_t *c =3D (uint8_t *)p;
	while(size-- > 0)
		fprintf(stderr, "%02x  ", *c++);
	fprintf(stderr, "\n");
}
#endif

int hcrp_receive_prints(bdaddr_t *src, bdaddr_t *dst, unsigned short =
ctrl_psm, unsigned short data_psm)
{
	struct sockaddr_l2 addr;
	struct l2cap_options opts;
	unsigned char buf[BUFS];
	socklen_t addrlen;
	struct sigaction sa;
	int opt;
	int i, ctrl_sk, data_sk, sk1, sk2, mtu, size;
	fd_set readfds;
	struct hcrp_pdu_hdr *hdr;
	struct hcrp_credit_grant_cp *cp;

	if ((sk1 =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) =
{
		perror("ERROR: Can't create socket");
		return 1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.l2_family =3D AF_BLUETOOTH;
	bacpy(&addr.l2_bdaddr, src);
	addr.l2_psm=3Dhtobs(ctrl_psm);

	if (bind(sk1, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		perror("ERROR: Can't bind socket");
		close(sk1);
		return 1;
	}

	if(listen(sk1,5)<0) {
		perror("ERROR: Can't listen");
		close(sk1);
		return 1;
	}
=09
	memset(&addr, 0, sizeof(addr));
	addrlen =3D sizeof(addr);

	if ((ctrl_sk =3D accept(sk1, (struct sockaddr *) &addr, &addrlen)) < 0) =
{
		perror("ERROR: Can't accept");
		close(sk1);
		return 1;
	}

	opt =3D sizeof(opts);
	if (getsockopt(ctrl_sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
		fprintf(stderr, "Can't get L2CAP options. %s(%d)\n",
						strerror(errno), errno);
		close(ctrl_sk);
		close(sk1);
		return 1;
	}

	fprintf(stderr, "Connected on control channel [imtu %d, omtu %d, =
flush_to %d]\n",
					opts.imtu, opts.omtu, opts.flush_to);

	if ((sk2 =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) =
{
		perror("ERROR: Can't create socket");
		close(ctrl_sk);
		close(sk1);
		return 1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.l2_family =3D AF_BLUETOOTH;
	bacpy(&addr.l2_bdaddr, src);
	addr.l2_psm=3Dhtobs(data_psm);

	if (bind(sk2, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		perror("ERROR: Can't bind socket");
		close(sk2);
		close(ctrl_sk);
		close(sk1);
		return 1;
	}

	if(listen(sk2,5)<0) {
		perror("ERROR: Can't listen");
		close(sk2);
		close(ctrl_sk);
		close(sk1);
		return 1;
	}

	memset(&addr, 0, sizeof(addr));
	addrlen =3D sizeof(addr);

	if ((data_sk =3D accept(sk2, (struct sockaddr *) &addr, &addrlen)) < 0) =
{
		perror("ERROR: Can't accept");
		close(sk2);
		close(ctrl_sk);
		close(sk1);
		return 1;
	}

	if (getsockopt(data_sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
		perror("ERROR: Can't get socket options");
		close(data_sk);
		close(ctrl_sk);
		close(sk1);
		close(sk2);
		return 1;
	}

	mtu =3D opts.omtu;

	fprintf(stderr, "Connected on data channel [imtu %d, omtu %d, flush_to =
%d]\n",
					opts.imtu, opts.omtu, opts.flush_to);

	/*	Both control and data channels connected=20
	 *	No printing can take place till the client
	 *	requests for credits
	 */

	/* Handle SIGTERM and SIGINT */
	sa.sa_handler =3D sig_term;
	sigaction(SIGTERM, &sa, NULL);
	sigaction(SIGINT,  &sa, NULL);

	FD_ZERO(&readfds);
	FD_SET(data_sk, &readfds);
	FD_SET(ctrl_sk, &readfds);

	while(!__io_canceled) {
		FD_ZERO(&readfds);
		FD_SET(data_sk, &readfds);
		FD_SET(ctrl_sk, &readfds);
		int ready =3D select(FD_SETSIZE, &readfds, 0, 0, 0);
		if(ready =3D=3D 0)
			continue;
		if(ready =3D=3D -1 && errno !=3D EINTR)
			break;
		if(FD_ISSET(ctrl_sk, &readfds)) {
			/* Read an HCRP Control Channel Packet */
			size =3D BUFS;
			size =3D read(ctrl_sk, &buf, BUFS);

			if(size =3D=3D -1) {
				perror("Read error on control channel");
			}

			if(size =3D=3D 0 || size =3D=3D -1) {
				/* control channel was closed or some error occured
				* time to cleanup
				*/
				close(ctrl_sk);
				close(data_sk);
				break;
			}

			/* Parse the header */
			hdr =3D (struct hcrp_pdu_hdr*)&buf;

			/* dump_packet(buf, size); */

			switch(htons(hdr->pid)) {
			case HCRP_PDU_CREDIT_GRANT:
				cp =3D (struct hcrp_credit_grant_cp*)((&buf)+HCRP_PDU_HDR_SIZE);
				hcrp_credit_grant_response(ctrl_sk, hdr, cp);
				break;
			case HCRP_PDU_CREDIT_REQUEST:
				hcrp_credit_request_response(ctrl_sk, hdr);
				break;
			case HCRP_PDU_GET_LPT_STATUS:
				hcrp_get_lpt_status_response(ctrl_sk, hdr);
				break;
			default:
				fprintf(stderr, "unsupported signalling command: %x\n",=20
					hdr->pid);
				hcrp_send_error_response(ctrl_sk, hdr);
				break;
			}
		}
		if(FD_ISSET(data_sk, &readfds)) {
			/* Does the client has enough credits for the print? */
			size =3D BUFS;
			size =3D read(data_sk, &buf, BUFS);
			hdr =3D (struct hcrp_pdu_hdr*)&buf;
			if(size > granted_credits) {
				/* Not enough credits
				 * Send a credit sync error response */
				hcrp_send_credit_sync_error_response(ctrl_sk, hdr);
				/* No need to break from the while loop */
			}
			else {
				fprintf(stderr, "Printing %d  bytes %d credits remaining\n", size, =
granted_credits); /* who cares for the actual print! */
				granted_credits -=3D size;
			}
		}
	}

	close(data_sk);
	close(ctrl_sk);
	close(sk1);
	close(sk2);

	return 0;
}

------=_NextPart_000_004C_01C6BCAC.2B906D00
Content-Type: application/octet-stream;
	name="main.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="main.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Hardcopy Cable Replacement Profile (HCRP) Printer Application
 *=20
 *  Copyright (C) 2006  Mayank Batra <mayank.batra@st.com>,
 *                      STMicroelectronics Ltd.
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

extern int sdp_register_hcrp(sdp_session_t *sdp, unsigned short =
ctrl_psm, unsigned short data_psm);
extern int sdp_unregister_hcrp(sdp_session_t *sdp);
extern int hcrp_receive_prints(bdaddr_t *src, bdaddr_t *dst, unsigned =
short ctrl_psm, unsigned short data_psm);

/*
 *  Usage: ./hcrp_printer ctrl_psm data_psm
 *
 */

int main(int argc, char *argv[])
{
	sdp_session_t *session;
	unsigned short ctrl_psm, data_psm;
	int err;

	/* Make sure status messages are not buffered */
	setbuf(stderr, NULL);

	/* Ignore SIGPIPE signals */
#ifdef HAVE_SIGSET
	sigset(SIGPIPE, SIG_IGN);
#elif defined(HAVE_SIGACTION)
	memset(&action, 0, sizeof(action));
	action.sa_handler =3D SIG_IGN;
	sigaction(SIGPIPE, &action, NULL);
#else
	signal(SIGPIPE, SIG_IGN);
#endif /* HAVE_SIGSET */

	if(argc !=3D 3) {
		puts("Usage: hcrp_printer ctrl_psm data_psm");
		return 0;
	}

	ctrl_psm =3D atoi(argv[1]);
	data_psm =3D atoi(argv[2]);

	session =3D sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
	if (!session) {
		fprintf(stderr, "ERROR: Can't open Bluetooth connection\n");
		return 1;
	}

	err =3D sdp_register_hcrp(session, ctrl_psm, data_psm);

	if (err) {
		fprintf(stderr, "ERROR: Can't register sdp record\n");
		return 1;
	}

	err =3D hcrp_receive_prints(BDADDR_ANY, BDADDR_LOCAL, ctrl_psm, =
data_psm);

	if (!err)
		fprintf(stderr, "INFO: Ready to print\n");

	err =3D sdp_unregister_hcrp(session);

	if(err) {
		fprintf(stderr, "ERROR: Can't unregister HCRP Printer Service\n");
		return 1;
	}
	else {
		fprintf(stderr, "HCRP Printer service unregistered\n");
	}
	sdp_close(session);

	return err;
}

------=_NextPart_000_004C_01C6BCAC.2B906D00
Content-Type: application/octet-stream;
	name="sdp.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sdp.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Hardcopy Cable Replacement Profile (HCRP) Printer Application
 *
 *  Copyright (C) 2006  Mayank Batra <mayank.batra@st.com>,
 *                      STMicroelectronics Ltd.
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <signal.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

static bdaddr_t src_addr =3D *BDADDR_ANY;
static sdp_record_t record;

int sdp_register_hcrp(sdp_session_t *session, unsigned short ctrl_psm, =
unsigned short data_psm)
{
	sdp_list_t *svclass_id, *apseq, *root, *addapseq;
	uuid_t root_uuid, hcrp, l2cap, hcrp_ctrl, hcrp_data;
	sdp_list_t *aproto, *proto[2], *addaproto, *addproto[2];
	sdp_data_t *psm;
	uint16_t lp_ctrl =3D ctrl_psm, lp_data =3D data_psm;
	int ret =3D 0;

	memset(&record, 0, sizeof(sdp_record_t));
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root =3D sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(&record, root);

	sdp_uuid16_create(&hcrp, HCR_PRINT_SVCLASS_ID);
	svclass_id =3D sdp_list_append(0, &hcrp);
	sdp_set_service_classes(&record, svclass_id);

	sdp_uuid16_create(&l2cap, L2CAP_UUID);
 	proto[0] =3D sdp_list_append(0, &l2cap);
 	psm =3D sdp_data_alloc(SDP_UINT16, &lp_ctrl);
 	proto[0] =3D sdp_list_append(proto[0], psm);
	sdp_uuid16_create(&hcrp_ctrl, HCRP_CTRL_UUID);
	proto[1] =3D sdp_list_append(0, &hcrp_ctrl);
	apseq =3D sdp_list_append(0, proto[0]);
	apseq =3D sdp_list_append(apseq, proto[1]);
	aproto =3D sdp_list_append(0, apseq);
	sdp_set_access_protos(&record, aproto);
	sdp_data_free(psm);

	addproto[0] =3D sdp_list_append(0, &l2cap);
	psm =3D sdp_data_alloc(SDP_UINT16, &lp_data);
	addproto[0] =3D sdp_list_append(addproto[0], psm);
	sdp_uuid16_create(&hcrp_data, HCRP_DATA_UUID);
	addproto[1] =3D sdp_list_append(0, &hcrp_data);
	addapseq =3D sdp_list_append(0, addproto[0]);
	addapseq =3D sdp_list_append(addapseq, addproto[1]);
	addaproto =3D sdp_list_append(0, addapseq);
	sdp_set_add_access_protos(&record, addaproto);
	sdp_set_info_attr(&record, "HCRP Printer", 0, 0);

	if(sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
		printf("Service Record Registration failed\n");
		ret =3D -1;
		goto done;
	}
	printf("HCRP Printer Service Registered\n");
done:
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(addproto[0], 0);
	sdp_list_free(addproto[1], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(addapseq, 0);
	sdp_list_free(aproto, 0);
	sdp_list_free(addaproto, 0);

	return ret;

}

int sdp_unregister_hcrp(sdp_session_t *session)
{
	return( sdp_record_unregister(session, &record));
}

------=_NextPart_000_004C_01C6BCAC.2B906D00
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_NextPart_000_004C_01C6BCAC.2B906D00
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_004C_01C6BCAC.2B906D00--
