Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <453114A0.50503@vasmac.com>
Date: Sat, 14 Oct 2006 12:47:28 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr>	<452E99E8.6070406@vasmac.com>	<452FBC82.1080901@free.fr>	<452FDC44.90803@vasmac.com>
	<45310A24.1000604@free.fr>
In-Reply-To: <45310A24.1000604@free.fr>
Content-Type: multipart/mixed; boundary="------------090602000602030909070308"
Subject: Re: [Bluez-devel] [PATCH] Updated sco flow control feature
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
--------------090602000602030909070308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fabien Chevalier wrote:
> Hi Jose,
>
> Please see my comments below.
>
>   
>> Hi Fabien,
>>
>> So your issue is supporting synchronous channels on the UART
>> interface. 
>>     
>
> Well, i would be better if this flow control issue was solved once and 
> for all, for all kind of interfaces :-)
>
> I think it's best to enable synchronous flow control.
>
> Do you know if this feature is supported by bt controllers on the UART 
> interface?
>
> Cheers,
>
> Fabien
>   
Hi Fabien,

It's my understanding from reading the IEEE spec that Bluetooth
compliant devices with UART interface must support synchronous
flow control if they support SCO channels. But I have no experience
with such devices. Has anyone else used such a device?

Attached is a small patch to hci_core.c and hci_usb.c that make the
SCO flow control work. This seems to work well for one SCO. I've
also included a modified hstest.c from bluez-utils/test.

For UART interfaces and possibly for multiple SCO, maybe some
additional changes are required. One issue is that only one queue
is used to communicate with the hci driver. It would be much better
if the synchronous traffic had a separate queue; this guarantees that
the driver can easily access the next SCO packet to transmit.

Jose


--------------090602000602030909070308
Content-Type: text/x-patch;
 name="sco-flow-control.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sco-flow-control.diff"

diff -rU 6 linux.source.2.6.15-orig/drivers/bluetooth/hci_usb.c linux.source.2.6.15/drivers/bluetooth/hci_usb.c
--- linux.source.2.6.15-orig/drivers/bluetooth/hci_usb.c	2006-05-02 01:01:55.000000000 -0400
+++ linux.source.2.6.15/drivers/bluetooth/hci_usb.c	2006-10-14 10:43:59.000000000 -0400
@@ -771,23 +771,49 @@
 			_urb->type, err);
 
 unlock:
 	read_unlock(&husb->completion_lock);
 }
 
+static inline int __sco_notify(struct hci_dev *hdev, void *handlep)
+{
+	struct sk_buff *skb;
+	unsigned char *p;
+	static const unsigned char data[] = {0x13, 0x05, 0x01, 0x00, 0x00, 0x01, 0x00};
+
+	skb = bt_skb_alloc(sizeof data, GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("%s no memory for the packet", hdev->name);
+		return -ENOMEM;
+	}
+	skb->dev = (void *) hdev;
+
+	BT_DBG("sco_notify handle: %x", *((__le16 *) handlep));
+	/* add handle to data */
+	p = skb_put(skb, sizeof(data));
+	memcpy(p, data, sizeof(data));
+	memcpy(p+3, handlep, sizeof(__le16));
+
+	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	hci_recv_frame(skb);
+	return 0;
+}
+
 static void hci_usb_tx_complete(struct urb *urb, struct pt_regs *regs)
 {
 	struct _urb *_urb = container_of(urb, struct _urb, urb);
 	struct hci_usb *husb = (void *) urb->context;
 	struct hci_dev *hdev = husb->hdev;
 
 	BT_DBG("%s urb %p status %d flags %x", hdev->name, urb,
 			urb->status, urb->transfer_flags);
 
 	atomic_dec(__pending_tx(husb, _urb->type));
 
+	if (_urb->type == HCI_SCODATA_PKT)
+		__sco_notify(hdev, ((struct sk_buff *)_urb->priv)->data);
 	urb->transfer_buffer = NULL;
 	kfree_skb((struct sk_buff *) _urb->priv);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return;
 
diff -rU 6 linux.source.2.6.15-orig/net/bluetooth/hci_core.c linux.source.2.6.15/net/bluetooth/hci_core.c
--- linux.source.2.6.15-orig/net/bluetooth/hci_core.c	2006-10-14 10:30:52.000000000 -0400
+++ linux.source.2.6.15/net/bluetooth/hci_core.c	2006-10-14 10:44:18.000000000 -0400
@@ -1242,14 +1242,13 @@
 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
 
 			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
+			hdev->sco_cnt--;
 		}
 	}
 }
 
 static void hci_tx_task(unsigned long arg)
 {

--------------090602000602030909070308
Content-Type: text/x-csrc;
 name="hstest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hstest.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2002-2006  Marcel Holtmann <marcel@holtmann.org>
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
	socklen_t size;
	int s;
	struct linger l;

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

	l.l_onoff = 1;
	l.l_linger = 5;
	setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof l);

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

static void usage(void)
{
	printf("Usage:\n"
		"\thstest play   <file> <bdaddr> [channel]\n"
		"\thstest record <file> <bdaddr> [channel]\n");
}

#define PLAY	1
#define RECORD	2

int main(int argc, char *argv[])
{
	struct sigaction sa;

	fd_set rfds, wfds, efds;
	struct timeval timeout;
	unsigned char buf[2048], *p;
	int maxfd, sel, rlen, wlen;

	bdaddr_t local;
	bdaddr_t bdaddr;
	uint8_t channel;

	char *filename;
	mode_t filemode;
	int err, mode = 0;
	int dd, rd, sd, fd;
	uint16_t sco_handle, sco_mtu, vs;
	int stream = 0;

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
	} else {
		usage();
		exit(-1);
	}

	filename = argv[2];

	hci_devba(0, &local);
#if 0
	dd = hci_open_dev(0);
	hci_read_voice_setting(dd, &vs, 1000);
	vs = htobs(vs);
	fprintf(stderr, "Voice setting: 0x%04x\n", vs);
	close(dd);
	if (vs != 0x0060) {
		fprintf(stderr, "The voice setting must be 0x0060\n");
		//return -1;
	}
#endif
	if (strcmp(filename, "-") == 0) {
		switch (mode) {
		case PLAY:
			fd = 0;
			break;
		case RECORD:
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

	if ((rd = rfcomm_connect(&local, &bdaddr, channel)) < 0) {
		perror("Can't connect RFCOMM channel");
		return -1;
	}

	fprintf(stderr, "RFCOMM channel connected\n");

	if ((sd = sco_connect(&local, &bdaddr, &sco_handle, &sco_mtu)) < 0) {
		perror("Can't connect SCO audio channel");
		close(rd);
		return -1;
	}

	sco_mtu = 48;
	fprintf(stderr, "SCO audio channel connected (handle %d, mtu %d)\n", sco_handle, sco_mtu);

	if (mode == RECORD)
		err = write(rd, "RING\r\n", 6);

	maxfd = (rd > sd) ? rd : sd;

	while (!terminate) {

		FD_ZERO(&rfds);
		FD_ZERO(&wfds);
		FD_ZERO(&efds);
		FD_SET(rd, &rfds);
		if (stream) {
			if (mode == RECORD)
				FD_SET(sd, &rfds);
			else
				FD_SET(sd, &wfds);
		}
		FD_SET(rd, &efds);
		FD_SET(sd, &efds);

		timeout.tv_sec = 0;
		timeout.tv_usec = 1000000;

		if ((sel = select(maxfd + 1, &rfds, &wfds, &efds, &timeout)) > 0) {

			/* communications errors */
			if (FD_ISSET(sd, &efds)) {
				fprintf(stderr, "SCO error\n");
				break;
			}
			if (FD_ISSET(rd, &efds)) {
				fprintf(stderr, "RFCOMM error\n");
				break;
			}

			/* RFCOMM channel */
			if (FD_ISSET(rd, &rfds)) {
				rlen = read(rd, buf, sizeof(buf));
				if (rlen > 0) {
					if (strcmp((char*)buf,"AT+CKPD=200\r") == 0) {
						stream = 1;
						fprintf(stderr, "SCO started\n");
					}
					if (rlen < sizeof(buf))
						buf[rlen++] = '\n';
					fwrite(buf, 1, rlen, stderr);
					wlen = write(rd, "OK\r\n", 4);
				}
			}

			/* play samples */
			if (FD_ISSET(sd, &wfds)) {
				rlen = read(fd, buf, sco_mtu);
				if (rlen <= 0) {
					if (rlen < 0)
						perror("Unable to read file");
					break;
				}

				wlen = 0; 
				p = buf;
				while (rlen > sco_mtu) {
					wlen = write(sd, p, sco_mtu);
					rlen -= sco_mtu;
					p += sco_mtu;
				}
				wlen = write(sd, p, rlen);
			}

			/* record samples */
			if (FD_ISSET(sd, &rfds)) {
				rlen = read(sd, buf, sizeof(buf));
				if (rlen > 0)
					wlen = write(fd, buf, rlen);
			}

		}

	}

	close(fd);

	close(sd);
	sleep(1);
	close(rd);

	return 0;
}

--------------090602000602030909070308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------090602000602030909070308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090602000602030909070308--
