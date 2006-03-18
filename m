Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <441C3CAB.5030806@silicom.fr>
From: Fabien Chevalier - <fchevalier@silicom.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------070900040007010609090800"
Subject: [Bluez-devel] Kernel panic with SCO socket - Debian kernel 2.6.15-8
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
Date: Sat, 18 Mar 2006 18:00:27 +0100

This is a multi-part message in MIME format.
--------------070900040007010609090800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi all,

I'm currently playing with a bluetooth dongle and a Motorola HS810 headset.

I wrote a sample program that mimics the establishment of a Headset 
Profile like connection.
For now it just waits for user input, then sends the content of a PCM 
file over the SCO socket.

The thing basically works... exect after 1or 2 minutes playback, the 
program suddenly exits.
Then i just have a few seconds left and *bang* . Kernel Panic :-(

The issue is 100% reproductible on my configuration :-(.

I attached the source of the program that makes my Linux crash... would 
eventually anybody have any idea of what goes wrong ??

Tip : here is the command line i use to start this program:
./hsplay 00:07:A4:4D:02:14 1 fallen-8kHz.wav 0

I also noticed that it crashes a lot faster when last parameter is 0...

Cheers,

Fabien



--------------070900040007010609090800
Content-Type: text/x-csrc;
 name="hsplay.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hsplay.c"

#include <getopt.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <errno.h>
#include <regex.h>
#include <ctype.h>

#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/poll.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sco.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

static int rfcomm_connect(bdaddr_t * dst, uint8_t channel)
{
	struct sockaddr_rc addr;
	int s;

	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, dst);
	addr.rc_channel = channel;
	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(s);
		return -1;
	}

	return s;
}

static int sco_connect(bdaddr_t * dst, uint16_t * handle,
		       uint16_t * mtu)
{
	struct sockaddr_sco addr;
	struct sco_conninfo conn;
	struct sco_options opts;
	int s;
	unsigned int size;

	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)) < 0) {
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.sco_family = AF_BLUETOOTH;
	bacpy(&addr.sco_bdaddr, dst);
	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(s);
		return -1;
	}

	size = sizeof(conn);
	if (getsockopt(s, SOL_SCO, SCO_CONNINFO, &conn, &size) < 0) {
		close(s);
		return -1;
	}

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

#define PKT_SIZE 48

int main(int argc, char **argv)
{
	bdaddr_t remote;
	int rfcomm_socket;
	int sco_socket;
	char buff[256];
	int res;
	char *pcm_filename;
	int pcm_fd;
	int channel;
	int delay;

	if(argc != 5) {
		printf("usage: hsplay bdaddr rfcomm_channel pcm_file delay\n");		
		printf("bdaddr = headet bd address\n");
		printf("rfcomm_channel = rfcomm channel used for headset control\n");		
		printf("pcm_file = 8OOHz, 16 bits signed PCM file te read\n");		
		printf("delay = between two sco packets, 1500 usually works great\n");		
		exit(1);
	}
	
	str2ba(argv[1], &remote);
	channel = atoi(argv[2]);
	pcm_filename = argv[3];
	delay = atoi(argv[4]);	
	
	rfcomm_socket = rfcomm_connect(&remote, channel);
	assert(rfcomm_socket != -1);
	res = write(rfcomm_socket, "RING", 4); 	
	assert(res == 4);
	memset(buff, 0, sizeof(buff));
	printf("RFCOMM control channel opened, waiting for HS button push\n");
	res = read(rfcomm_socket, buff, sizeof(buff));
	assert(res > 0);
	printf("Recv: %s\n", buff);
	sco_socket = sco_connect(&remote, 0, 0);
	assert(res > 0);
	printf("SCO connected.\n");

	pcm_fd = open(pcm_filename, 0);
	assert(pcm_fd > 0);
	lseek(pcm_fd, 44, SEEK_SET);
	while((res = read(pcm_fd, buff, PKT_SIZE)) == PKT_SIZE)
	{
		res = send(sco_socket, buff, PKT_SIZE, 0);
		if(res <= 0) {
			perror("write");
			exit(1);
		}
		if(delay > 0) {
			usleep(delay);
		}
	}	
	return 0;
}

--------------070900040007010609090800--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
