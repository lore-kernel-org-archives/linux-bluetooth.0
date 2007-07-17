Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 17 Jul 2007 11:24:05 +0100
From: Andrea Bittau <a.bittau@cs.ucl.ac.uk>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070717102405.GA43800@shorty.sorbonet.org>
Mime-Version: 1.0
Subject: [Bluez-devel] csrsniff.c replacement
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I wrote a tool for CSR sniffing a while back.  I recently noticed that
csrsniff.c exists in hcidump but it does not do much.  Would it be
possible to replace it with my tool instead?  The code is not polished
but works and I just wanted to send it to you guys "as is" in order to
see your reaction or see if you are interested at all.

Let me know, thanks.

---

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2007  Andrea Bittau <a.bittau@cs.ucl.ac.uk>
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
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 *
 * To see if everything works:
 * ./csrsniff -d hci0 -t
 * You should get an incrementing number (the clock of the dongle).
 *
 * 1) To stop sniffing:
 * ./csrsniff -d hci0 -s
 *
 * 2) To set the dongle's packet filter (i.e. which packets to receive):
 * ./csrsniff -d hci0 -f 7 [receive all packet types]
 * 
 * 3) To start sniffing:
 * ./csrsniff -d hci0 -S mac:addr:of:master@00:00:00:00:00:00
 *
 * To dump sniffed data in a file that hcidump understands:
 * ./csrsniff -d hci0 -e -w bla.cap
 * [hcidump -r bla.cap]
 *
 * The dongle's clock needs to be synchronized with that of the master.  To
 * maintain synchronization, you might want to perform steps 1--3 periodically
 * (e.g. every minute).
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <err.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <assert.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

/* bluetooth defines */
#define TYPE_DV		8

#define LMP_IN_RAND	8
#define LMP_COMB_KEY	9
#define LMP_AU_RAND	11
#define LMP_SRES	12
#define LMP_TID_MASK	1
#define LMP_OP1_SHIFT	1

#define LLID_FRAG	1
#define LLID_START	(1 << 1)
#define LLID_LMP	(LLID_START|LLID_FRAG)

/* CSR sniffer packet defines */
#define VER_BC2	0xE
#define VER_BC4	0xF

#define STATUS_HDR_ERROR	(1 << 2)
#define STATUS_CRC_ERROR	((1 << 1) | STATUS_HDR_ERROR)
#define STATUS_UNSUPPORTED	((1 << 3) | 1)

#define CP_CLOCK_MASK	0xFFFFFFF
#define CP_SLAVE_MASK	0x2
#define CP_STATUS_SHIFT	28
#define CP_TYPE_SHIFT	3
#define CP_TYPE_MASK	0xF
#define CP_ADDR_MASK	7

#define CP_LEN_LLID_SHIFT	2
#define CP_LEN_LLID_MASK	3
#define CP_LEN_ARQN_MASK	1
#define CP_LEN_SEQN_MASK	(1 << 1)
#define CP_LEN_FLOW		(1 << 4)
#define CP_LEN_SHIFT		5

/* CSR sniffer command defines */
#define FRAG_FIRST      (1 << 6)
#define FRAG_LAST       (1 << 7)
#define CHAN_DEBUG	20

#define CMD_START	0x30
#define CMD_STOP	0x32
#define CMD_FILTER	0x33
#define CMD_TIMER	0x34

#define FILTER_DATA		1
#define FILTER_SCO		(1 << 1)
#define FILTER_NULL_POLL	(1 << 2)

/* misc defines */
#define MAX_TYPES 16

#define GOT_IN_RAND	(1 << 1)
#define GOT_COMB1	(1 << 2)
#define GOT_COMB2	(1 << 3)
#define GOT_AU_RAND1	(1 << 4)
#define GOT_SRES1	(1 << 5)
#define GOT_AU_RAND2	(1 << 6)
#define GOT_SRES2	(1 << 7)

#define	__packed __attribute__((__packed__))

struct dbg_packet {
	uint8_t 	dp_type;
	uint16_t	dp_unknown1;
	uint16_t	dp_unknown2;
	uint8_t		dp_data[19];
} __packed;

struct start_packet {
	uint8_t		sp_master_rev[6];
	uint32_t	sp_unknown;
	uint8_t		sp_slave_rev[6];
} __packed;

struct csr_packet {
	uint8_t		cp_ver;
	uint32_t	cp_clock;
	uint8_t		cp_hdr0;
	uint16_t	cp_len;
	uint32_t	cp_timer;
	uint8_t		cp_chan;
	uint8_t		cp_seq;
} __packed;

struct csr_packet_bc4 {
	struct csr_packet	cp_fp;
	uint8_t			cp_decrypted;
} __packed;

struct hcidump_hdr {
        uint16_t        len;
        uint8_t         in;
        uint8_t         pad;
        uint32_t        ts_sec;
        uint32_t        ts_usec;
} __attribute__ ((packed));

struct state {
	int	s_fd;
	int	s_buf[1024];
	int	s_len;
	int	s_llid;
	int	s_master;
	int	s_ignore[MAX_TYPES];
	int	s_dump;
	int	s_ignore_zero;
	int	s_type;
	uint8_t	s_pin;
	uint8_t	s_pin_data[7][16];
	int	s_pin_master;
} _state;

static struct state *get_state(void)
{
	return &_state;
}

static void send_debug(struct state *s, struct dbg_packet *dp, void *rp,
		       int rplen)
{
	unsigned char cp[254];
	struct hci_request rq;
	unsigned char *p = cp;

	memset(&rq, 0, sizeof(rq));
	memset(cp, 0, sizeof(cp));

	/* payload descriptor */
        *p++ = FRAG_FIRST | FRAG_LAST | CHAN_DEBUG;
	memcpy(p, dp, sizeof(*dp));
	p += sizeof(*dp);

        rq.ogf    = OGF_VENDOR_CMD;
        rq.ocf    = 0x00;
        rq.event  = EVT_VENDOR;
        rq.cparam = cp;
        rq.clen   = p - cp;
        rq.rparam = rp;
        rq.rlen   = rplen;

	if (hci_send_req(s->s_fd, &rq, 2000) < 0)
		err(1, "hci_send_req()");
}

static void send_debug_no_rp(struct state *s, struct dbg_packet *dp)
{
	unsigned char rp[254];

	send_debug(s, dp, rp, sizeof(rp));
}

static unsigned int get_timer(struct state *s)
{
	unsigned char rp[254];
	struct dbg_packet pkt;

	memset(rp, 0, sizeof(rp));
	memset(&pkt, 0, sizeof(pkt));

	pkt.dp_type = CMD_TIMER;

	send_debug(s, &pkt, rp, sizeof(rp));

	return *((unsigned int*) &rp[2]);
}

static void set_filter(struct state *s, unsigned char val)
{
	struct dbg_packet pkt;

	memset(&pkt, 0, sizeof(pkt));

	pkt.dp_type	= CMD_FILTER;
	pkt.dp_data[0]	= val;

	send_debug_no_rp(s, &pkt);
}

static void sniff_stop(struct state *s)
{
	struct dbg_packet pkt;

	memset(&pkt, 0, sizeof(pkt));

	pkt.dp_type = CMD_STOP;

	send_debug_no_rp(s, &pkt);
}

static void sniff_start(struct state *s, unsigned char *master,
			unsigned char *slave)
{
	struct dbg_packet pkt;
	struct start_packet *sp = (struct start_packet*) &pkt.dp_data;
	int i;

	memset(&pkt, 0, sizeof(pkt));
	pkt.dp_type = CMD_START;

	for (i = 5; i >= 0; i--)
		sp->sp_master_rev[i] = *master++;

	for (i = 5; i >= 0; i--)
		sp->sp_slave_rev[i] = *slave++;

	send_debug_no_rp(s, &pkt);
}

static void usage(char *p)
{
	printf(	"Usage: %s <opts>\n"
		"-h\thelp\n"
		"-d\t<dev>\n"
		"-t\ttimer\n"
		"-f\t<filter>\n"
		"-s\tstop\n"
		"-S\t<master@slave>\n"
		"-e\tsniff\n"
		"-i\t<ignore type>\n"
		"-z\tignore zero legnth packets\n"
		"-p\town pin\n"
		, p);
	exit(1);
}

static void str2mac(unsigned char* dst, char* mac)
{
        unsigned int macf[6];
        int i;

        if( sscanf(mac, "%x:%x:%x:%x:%x:%x",
                   &macf[0], &macf[1], &macf[2],
                   &macf[3], &macf[4], &macf[5]) != 6) {

                   printf("can't parse mac %s\n", mac);
                   exit(1);
        }

        for (i = 0; i < 6; i++)
                *dst++ = (unsigned char) macf[i];
}

static void parse_macs(char *str, unsigned char *master, unsigned char *slave)
{
	char *div;

	div = strchr(str, '@');
	if (!div)
		errx(1, "bad macs");
	*div++ = 0;

	str2mac(master, str);
	str2mac(slave, div);
}

static void hexdump(void *buf, int len)
{
	unsigned char *p = buf;

	while (len--)
		printf("%.2X ", *p++);
	printf("\n");
}

static void process_l2cap(struct state *s, void *buf, int len)
{
	struct hcidump_hdr dh;
	uint8_t type = HCI_ACLDATA_PKT;
	hci_acl_hdr acl;
	int totlen = sizeof(type) + sizeof(acl) + len;

	printf("L2CAP: ");
	hexdump(buf, len);

	if (s->s_dump == -1)
		return;

	memset(&dh, 0, sizeof(dh));
	dh.len		= totlen;
	dh.in		= 1;
	dh.ts_sec	= 0;
	dh.ts_usec	= 0;
	if (write(s->s_dump, &dh, sizeof(dh)) != sizeof(dh))
		err(1, "write()");

	if (write(s->s_dump, &type, sizeof(type)) != sizeof(type))
		err(1, "write()");
	memset(&acl, 0, sizeof(acl));
	acl.dlen	= len;
	acl.handle	= acl_handle_pack(0, s->s_llid);
	if (write(s->s_dump, &acl, sizeof(acl)) != sizeof(acl))
		err(1, "write()");

	if (write(s->s_dump, buf, len) != len)
		err(1, "write()");
}

static void do_pin(struct state *s, int op, void *buf, int len)
{
	int i, j;

	switch (op) {
	case LMP_IN_RAND:
		s->s_pin = 1 | GOT_IN_RAND;
		s->s_pin_master = s->s_master;
		memcpy(s->s_pin_data[0], buf, len);
		break;

	case LMP_COMB_KEY:
		if (!(s->s_pin & GOT_IN_RAND))
			return;

		if (s->s_master == s->s_pin_master) {
			memcpy(s->s_pin_data[1], buf, len);
			s->s_pin |= GOT_COMB1;
		} else {
			memcpy(s->s_pin_data[2], buf, len);
			s->s_pin |= GOT_COMB2;
		}
		break;

	case LMP_AU_RAND:
		if ((!(s->s_pin & GOT_COMB1))
		    || (!(s->s_pin & GOT_COMB2)))
			return;

		if (s->s_master == s->s_pin_master) {
			memcpy(s->s_pin_data[3], buf, len);
			s->s_pin |= GOT_AU_RAND1;
		} else {
			memcpy(s->s_pin_data[4], buf, len);
			s->s_pin |= GOT_AU_RAND2;
		}
		break;

	case LMP_SRES:
		if (s->s_master != s->s_pin_master) {
			if (!(s->s_pin & GOT_AU_RAND1))
				return;
			memcpy(s->s_pin_data[6], buf, len);
			s->s_pin |= GOT_SRES1;
		} else {
			if (!(s->s_pin & GOT_AU_RAND2))
				return;
			memcpy(s->s_pin_data[5], buf, len);
			s->s_pin |= GOT_SRES2;
		}
		break;

	default:
		return;
	}

	if (s->s_pin != 0xFF)
		return;

	printf("btpincrack Go ");
	if (s->s_pin_master)
		printf("<master> <slave> ");
	else
		printf("<slave> <master> ");

	for (i = 0;  i < 7; i++) {
		int len = i >= 5 ? 4 : 16; 

		for (j = 0; j < len; j++)
			printf("%.2x", s->s_pin_data[i][j]);
		
		printf(" ");
	}
	printf("\n");
	s->s_pin = 1;
}

static void process_lmp(struct state *s, void *buf, int len)
{
	uint8_t *data = buf;
	int op1, op2 = -1;
	int tid;

	op1 = *data++;
	len--;
	assert(len >= 0);
	tid = op1 & LMP_TID_MASK;
	op1 >>= LMP_OP1_SHIFT;

	if (op1 >= 124 && op1 <= 127) {
		op2 = *data++;
		len--;
		assert(len >= 0);
	}

	printf("LMP Tid %d Op1 %d", tid, op1);
	if (op2 != -1)
		printf(" Op2 %d", op2);

	printf(": ");
	hexdump(data, len);

	if (s->s_pin)
		do_pin(s, op1, data, len);
}

static void process_dv(struct state *s, void *buf, int len)
{
	printf("DV: ");
	hexdump(buf, len);
}

static void process_payload(struct state *s, void *buf, int len)
{
	switch (s->s_type) {
	case TYPE_DV:
		process_dv(s, buf, len);
		return;
	}

	if (s->s_llid == LLID_LMP)
		process_lmp(s, buf, len);
	else
		process_l2cap(s, buf, len);
}

static void process_csr(struct state *s, void *buf, int len)
{
	struct csr_packet *fp = buf;
	int type = (fp->cp_hdr0 >> CP_TYPE_SHIFT) & CP_TYPE_MASK;
	int plen = fp->cp_len >> CP_LEN_SHIFT;
	uint8_t *start = (uint8_t*) fp;
	int status = fp->cp_hdr0 & CP_ADDR_MASK;
	int i;
	int hlen;

	switch (fp->cp_ver) {
	case VER_BC2:
		hlen = sizeof(struct csr_packet);
		break;

	case VER_BC4:
		hlen = sizeof(struct csr_packet_bc4);
		break;

	default:
		printf("Unknown ver 0x%.2X\n", fp->cp_ver);
		abort();
		break;
	}
	start += hlen;

	for (i = 0; i < MAX_TYPES; i++) {
		if (s->s_ignore[i] == type)
			return; /* XXX check for appended packets */
	}
	if (s->s_ignore_zero && plen == 0)
		return;

	s->s_llid	= (fp->cp_len >> CP_LEN_LLID_SHIFT) & CP_LEN_LLID_MASK;
	s->s_master	= !(fp->cp_clock & CP_SLAVE_MASK);
	s->s_type	= type;
	printf("V 0x%.2X Ch %.2d %c Clk 0x%.7X Status 0x%.1X Hdr0 0x%.2X"
	       " [type: %d addr: %d] LLID %d Len %d",
	       fp->cp_ver, fp->cp_chan, s->s_master ? 'M' : 'S',
	       fp->cp_clock & CP_CLOCK_MASK,
	       fp->cp_clock >> CP_STATUS_SHIFT, fp->cp_hdr0,
	       type, status, s->s_llid, plen);

	len -= hlen;
	assert(len >= 0);
	assert(len >= plen);

	if (plen) {
		printf(" ");
		process_payload(s, start, plen);
	} else
		printf("\n");

	/* firmware seems to append fragments */
	len -= plen;
	assert(len >= 0);
	if (len)
		process_csr(s, start+plen, len);
}

static void process(struct state *s, void *buf, int len)
{
	uint8_t *type = buf;
	hci_acl_hdr *acl;

	if (*type != HCI_ACLDATA_PKT) {
		printf("Unknown type: %d\n", *type);
		return;
	}

	acl = (hci_acl_hdr*) (type+1);
	assert(acl->dlen == (len - sizeof(*acl) - 1));
	process_csr(s, acl+1, acl->dlen);
}

static void sniff(struct state *s)
{
        struct hci_filter flt;

        hci_filter_clear(&flt);
        hci_filter_all_ptypes(&flt);
        hci_filter_all_events(&flt);
        if (setsockopt(s->s_fd, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0)
		err(1, "Can't set filter - setsockopt()");

	while (1) {
		s->s_len = read(s->s_fd, s->s_buf, sizeof(s->s_buf));
		if (s->s_len == -1)
			err(1, "read()");

		process(s, s->s_buf, s->s_len);
	}
}

int main(int argc, char *argv[])
{
	int dev;
	int ch;
	char *device = NULL;
	int timer = 0;
	int filter = 0, flt = 0;
	char *start = NULL;
	int stop = 0;
	int snif = 0;
	struct state *s;
	int i;
	char *dump = NULL;

	s = get_state();
	memset(s, 0, sizeof(*s));
	for (i = 0; i < MAX_TYPES; i++)
		s->s_ignore[i] = -1;
	s->s_dump = -1;

	while ((ch = getopt(argc, argv, "hd:tf:sS:ei:w:zp")) != -1) {
		switch (ch) {
		case 'z':
			s->s_ignore_zero = 1;
			break;

		case 'd':
			device = optarg;
			break;

		case 't':
			timer = 1;
			break;

		case 'f':
			filter = 1;
			flt = atoi(optarg);
			break;

		case 's':
			stop = 1;
			break;

		case 'S':
			start = optarg;
			break;

		case 'i':
			for (i = 0; i < MAX_TYPES; i++) {
				int type = atoi(optarg);

				if (s->s_ignore[i] == -1
				    || s->s_ignore[i] == type) {
					s->s_ignore[i] = type;
					break;
				}
			}
			break;

		case 'e':
			snif = 1;
			break;

		case 'w':
			dump = optarg;
			break;

		case 'p':
			s->s_pin = 1;
			break;

		case 'h':
		default:
			usage(argv[0]);
		}
	}

	if (dump) {
		s->s_dump = open(dump, O_APPEND | O_WRONLY | O_CREAT, 0644);
		if (s->s_dump == -1)
			err(1, "dump file - open()");
	}

	if (!device)
		errx(1, "Specify device");

	/* open */
	if ((dev = hci_devid(device)) < 0)
		err(1, "hci_devid()");

	if ((s->s_fd = hci_open_dev(dev)) < 0)
		err(1, "hci_devid()");

	/* do stuff */
	if (timer)
		printf("Timer %x\n", get_timer(s));

	if (filter)
		set_filter(s, flt);

	if (stop)
		sniff_stop(s);

	if (start) {
		unsigned char slave[6], master[6];

		parse_macs(start, master, slave);
		sniff_start(s, master, slave);
	}

	if (snif)
		sniff(s);

	hci_close_dev(s->s_fd);
	if (s->s_dump != -1)
		close(s->s_dump);

	exit(0);
}

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
