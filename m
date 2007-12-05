Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 5 Dec 2007 16:01:03 +1000
References: <20071204232538.GA23003@wavehammer.waldi.eu.org>
In-Reply-To: <20071204232538.GA23003@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f6jVHMG0NkninEL"
Message-Id: <200712051601.03309.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] Possible Race condition in Rfcomm TTY
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_f6jVHMG0NkninEL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

I think there is a race condition in the RFCOMM Socket -> TTY adaptation.  
Basically whenever a client device connects and starts sending data right 
away, the serial port will not receive it.

To see what I mean:

run 'rfcomm -r listen 0 15' on a server.

and run a simple test app that sends data right after connecting (one 
attached).

Once connection has been established, run 'cat /dev/rfcomm0' 

Using my Suse 10.2 desktop with kernel 2.6.18.8 and Neo with kernel 2.6.22.5 
(Nov 26 snapshot), about 95% of the time the initial data sent never shows up 
on the serial port.  If I reverse the roles, the desktop usually gets the 
initial chunk of data.  This inconsistency makes it hard to implement 
something like the DUN or Handsfree services where clients very frequently 
send data right away.

Looking at the kernel code it seems that the data is copied into the socket 
buf or into the serial buf from the rfcomm_recv_data.  It also seems that 
rfcomm_dev_add never copies what is in the socket buffer to what is in the 
serial buffer.  It would seem that rfomm_dev_add should also copy any pending 
data from a socket read buffer to the serial port read buffer whenever doing 
the conversion.  Or is there something else going on here?

-Denis


--Boundary-00=_f6jVHMG0NkninEL
Content-Type: text/x-csrc;
  charset="utf-8";
  name="rfc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfc.c"

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

static void usage(void)
{
	printf("Usage:\n"
		"\trfc <bdaddr> [channel]\n");
}

int main(int argc, char *argv[])
{
	struct sigaction sa;

	fd_set rfds;
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

	switch (argc) {
	case 2:
		str2ba(argv[1], &bdaddr);
		channel = 6;
		break;
	case 3:
		str2ba(argv[1], &bdaddr);
		channel = atoi(argv[2]);
		break;
	default:
		usage();
		exit(-1);
	}

	hci_devba(0, &local);
	
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

	fprintf(stderr, "Sending BRSF\n");
	write(rd, "AT+BRSF=24\r\n", 12);

	while (!terminate) {
		FD_ZERO(&rfds);
		FD_SET(rd, &rfds);
		FD_SET(fileno(stdin), &rfds);

		timeout.tv_sec = 0;
		timeout.tv_usec = 10000;

		if ((sel = select(rd + 1, &rfds, NULL, NULL, &timeout)) > 0) {
			if (FD_ISSET(rd, &rfds)) {
				memset(buf, 0, sizeof(buf));
				rlen = read(rd, buf, sizeof(buf));
				if (rlen > 0) {
					fprintf(stderr, "%s\n", buf);
				} else {
					break;
				}				
			}
			
			if (FD_ISSET(fileno(stdin), &rfds)) {
				memset(buf, 0, sizeof(buf));
				rlen = read(fileno(stdin), buf, sizeof(buf));
				if (rlen > 0) {
					fprintf(stderr, "Sending->%s", buf);
					wlen = write(rd, buf, rlen);
				}
				else {
					break;
				}
			}
		}
	}

	close(rd);

	return 0;
}

--Boundary-00=_f6jVHMG0NkninEL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--Boundary-00=_f6jVHMG0NkninEL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_f6jVHMG0NkninEL--
