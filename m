Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41ADAC67.10706@suche.org>
From: "suche.org" <admin@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <200412010839.06669.mailsp@sebastian-eichner.de> <200412010943.33419.mail@sebastian-eichner.de> <1101894192.18840.44.camel@pegasus> <200412011224.29191.mail@sebastian-eichner.de>
In-Reply-To: <200412011224.29191.mail@sebastian-eichner.de>
Content-Type: multipart/mixed;
 boundary="------------080802000707030505010201"
Subject: [Bluez-devel] BTsco
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
Date: Wed, 01 Dec 2004 12:35:03 +0100

This is a multi-part message in MIME format.
--------------080802000707030505010201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
i hope this time it is better c style.
It use now an record with is created for each headset.
Also it now better handle the exit routine.
Capable of multiple headsets.

Why  libm, libdl and libpthread are linked ?

Cu Thomas

--------------080802000707030505010201
Content-Type: text/plain;
 name="btsco.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="btsco.c"

/*
 *  Userspace management of snd-bt-sco
 *
 *  Copyright (c) 2003 by Jonathan Paisley <jp@dcs.gla.ac.uk>
 * 
 *  Daemon enhancements (c) 2004 by Lars Grunewaldt <lgw@dark-reality.de>
 *
 *  Based on sb16_csp/cspctl.c and hstest.c from bluez-utils/test.
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */

#include <getopt.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <errno.h>

#include <sys/wait.h>
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

#include <alsa/asoundlib.h>

#define SNDRV_BT_SCO_IOCTL_SET_SCO_SOCKET _IOW ('H', 0x10, int)

#ifndef SND_HWDEP_IFACE_EMUX_WAVETABLE
#define SND_HWDEP_IFACE_EMUX_WAVETABLE (SND_HWDEP_IFACE_USX2Y + 1)
#endif

#ifndef SND_HWDEP_IFACE_BLUETOOTH
#define SND_HWDEP_IFACE_BLUETOOTH (SND_HWDEP_IFACE_EMUX_WAVETABLE + 1)
#endif

#ifndef SNDRV_HWDEP_IFACE_BT_SCO
#define SNDRV_HWDEP_IFACE_BT_SCO (SND_HWDEP_IFACE_BLUETOOTH + 1)
#endif

static volatile int terminate = 0;

static void sig_term(int sig)
{
	terminate = 1;
}

static int rfcomm_connect(bdaddr_t * src, bdaddr_t * dst, uint8_t channel)
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
	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(s);
		return -1;
	}

	return s;
} 

static int sco_connect(bdaddr_t * src, bdaddr_t * dst, uint16_t * handle,
		       uint16_t * mtu)
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

static void error(const char *fmt, ...)
{ 
	va_list va;

	va_start(va, fmt);
	fprintf(stderr, "Error: ");
	vfprintf(stderr, fmt, va);
	fprintf(stderr, "\n");
	va_end(va);
} 

static int bt_sco_set_fd(snd_hwdep_t * handle, int sco_fd)
{ 
	if (snd_hwdep_ioctl
	    (handle, SNDRV_BT_SCO_IOCTL_SET_SCO_SOCKET, (void *)sco_fd) < 0) {
		error("unable to set fd");
		return 1;
	}
	return 0;
} 

int find_hwdep_device(int *cardP, int *devP)
{
	snd_ctl_t *ctl_handle;
	snd_ctl_card_info_t *card_info;
	snd_hwdep_info_t *hwdep_info;

	int card;
	int dev;
	int err;
	char card_id[32];

	ctl_handle = NULL;

	snd_ctl_card_info_alloca(&card_info);
	snd_hwdep_info_alloca(&hwdep_info);

	for (card = 0; card < 7; card++) {
		*cardP = card;

		if (ctl_handle) {
			snd_ctl_close(ctl_handle);
			ctl_handle = NULL;
		}
		// Get control handle for selected card
		sprintf(card_id, "hw:%i", card);
		if ((err = snd_ctl_open(&ctl_handle, card_id, 0)) < 0) {
			error("control open (%s): %s", card_id,
			      snd_strerror(err));
			return -1;
		}
		// Read control hardware info from card
		if ((err = snd_ctl_card_info(ctl_handle, card_info)) < 0) {
			error("control hardware info (%s): %s", card_id,
			      snd_strerror(err));
			continue;
		}
		//if (strcmp(snd_ctl_card_info_get_driver(card_info),"BT SCO (d)"))
		//    continue;
		dev = -1;
		err = 1;
		while (1) {
			int if_type;
			if (snd_ctl_hwdep_next_device(ctl_handle, &dev) < 0)
				error("hwdep next device (%s): %s",
				      card_id, snd_strerror(err));
			if (dev < 0) 
				break;
			snd_hwdep_info_set_device(hwdep_info, dev);
			if (snd_ctl_hwdep_info(ctl_handle, hwdep_info) < 0) {
				if (err != -ENOENT)
					error
					    ("control hwdep info (%s): %s",
					     card_id, snd_strerror(err));
				continue;
			}
			if_type = snd_hwdep_info_get_iface(hwdep_info);
			if (if_type == SNDRV_HWDEP_IFACE_BT_SCO || if_type==12) {
				snd_ctl_close(ctl_handle);
				*devP = dev;
				return 0;
			}
		}
	}
	if (ctl_handle)
		snd_ctl_close(ctl_handle);

	return -1;
}

static void usage(void)
{
	printf("Usage:\n" "\tbtsco <bdaddr> [channel]\n");
}

int detect_channel(bdaddr_t * bdaddr)
{
	uuid_t group;
	bdaddr_t interface;
	sdp_list_t *attrid, *search, *seq, *next;
	uint32_t range = 0x0000ffff;
	sdp_session_t *sess;
	int channel = 2;
	int searchresult;

	bacpy(&interface, BDADDR_ANY);

	sdp_uuid16_create(&group, 0x1108);
	sess = sdp_connect(&interface, bdaddr, SDP_RETRY_IF_BUSY);
	if (!sess) {
		printf
		    ("Failed to connect to SDP server: %s\nAssuming channel %d\n",
		     strerror(errno), channel);
		return channel;
	}

	attrid = sdp_list_append(0, &range);
	search = sdp_list_append(0, &group);
	searchresult =
	    sdp_service_search_attr_req(sess, search, SDP_ATTR_REQ_RANGE,
					attrid, &seq);
	sdp_list_free(attrid, 0);
	sdp_list_free(search, 0);

	if (searchresult) {
		printf("Service Search failed: %s\nAssuming channel %d\n",
		       strerror(errno), channel);
		sdp_close(sess);
		return channel;
	}

	for (; seq; seq = next) {
		sdp_record_t *rec = (sdp_record_t *) seq->data;
		sdp_list_t *list = 0;
		if (sdp_get_access_protos(rec, &list) == 0) {
			channel = sdp_get_proto_port(list, RFCOMM_UUID);
		}
		next = seq->next;
		free(seq);
		sdp_record_free(rec);
	}

	sdp_close(sess);
	return channel;
}

struct s_headset {
	bdaddr_t local;
	bdaddr_t bdaddr;
	uint8_t channel;
	int rfcomm_fd;
	int sco_fd;
	snd_hwdep_t *handle;
	int volumes[2];
	int last_volumes[2];
	struct s_headset *next;
	};

struct s_headset  b_headset;
struct s_headset *first = NULL;

int headset_button(struct s_headset *headset)
{ 
	uint16_t sco_handle, sco_mtu;

	if (headset == NULL)
		return 0;
	if (headset->sco_fd != -1) {
		/* close bt_sco audio handle */
		bt_sco_set_fd(headset->handle, -1);
		/* disconnect SCO stream */
		close(headset->sco_fd);
		headset->sco_fd = -1;
		fprintf(stderr, "disconnected SCO channel\n");
		return 1;
	}
	fprintf(stderr, "opened hwdep\n");
	/* connect sco stream */
	if ((headset->sco_fd = sco_connect(&headset->local, &headset->bdaddr, &sco_handle, &sco_mtu)) < 0) {
		perror ("Can't connect SCO audio channel\n");
		return 1;
	}
	fprintf(stderr, "connected SCO channel\n");
	//      write(rd, "RING\r\n", 6);
	printf ("Setting sco fd\n"); 
	bt_sco_set_fd (headset->handle, headset->sco_fd);
	printf ("Done setting sco fd\n"); 
	return 1;
} 

struct s_headset *headset_new  (void)
{ 
	struct s_headset *headset;
	headset = malloc (sizeof(struct s_headset));
	if (headset == NULL)
		return NULL;
	headset->sco_fd = -1;
	headset->rfcomm_fd = -1;
	headset->handle = NULL;
	headset->last_volumes[0] = 0;
	headset->last_volumes[1] = 0;
	headset->next = first;
	first = headset;
	return headset;
} 

int headset_volume_fromcard (struct s_headset *headset)
{ 
	int len;
	char line[100];

	len = snd_hwdep_read(headset->handle, headset->volumes, sizeof(headset->volumes));
	if (len != sizeof(headset->volumes)) 
		return 0;
	printf ("volume speaker: %d mic: %d\n", headset->volumes[0], headset->volumes[1]);
	if (headset->volumes[0] != headset->last_volumes[0]) {
		sprintf(line, "+VGS=%d\r", headset->volumes[0]);
		write(headset->rfcomm_fd, line, strlen(line));
		headset->last_volumes[0] = headset->last_volumes[0];
	}
	if (headset->volumes[1] != headset->last_volumes[1]) {
		sprintf(line, "+VGM=%d\r", headset->volumes[1]);
		write(headset->rfcomm_fd, line, strlen(line));
		headset->last_volumes[1] = headset->last_volumes[1];
	}
	return 1;
} 

int headset_speaker (struct s_headset *headset)
{ 
	fprintf(stderr, "Sending up speaker change %d\n", headset->volumes[0]);
	snd_hwdep_write(headset->handle, headset->volumes, sizeof (headset->volumes));
	return 1;
} 

int headset_micro   (struct s_headset *headset)
{ 
	fprintf(stderr, "Sending up microphone change %d\n", headset->volumes[1]);
	snd_hwdep_write(headset->handle, headset->volumes, sizeof (headset->volumes));
	return 1;
} 

int headset_from_bt (struct s_headset *headset)
{ 
	unsigned char buf[2048];
	int rlen;
	int opdone;
	
	opdone = 0;
	rlen = read(headset->rfcomm_fd, buf, sizeof(buf) - 1);
	if (rlen <= 0)
		return 0;
	buf [rlen] = 0;
	fprintf(stderr, "recieved %s\n", buf);
	if (strstr(buf, "AT+BVRA="   )) opdone = headset_button(headset);
	else if (strstr(buf, "AT+CKPD=200")) opdone = headset_button(headset);
	else if (strstr(buf, "AT+CHUP"    )) opdone = headset_button(headset);
	else if (strstr(buf, "AT+CIND=?"  )) opdone = headset_button(headset);
	else if (sscanf (buf, "AT+VGS=%d", &headset->volumes[0]) == 1) opdone = headset_speaker (headset);
	else if (sscanf (buf, "AT+VGM=%d", &headset->volumes[1]) == 1) opdone = headset_micro   (headset);
	if (opdone == 1)
		/* tell them we recieved */
		write(headset->rfcomm_fd, "\r\nOK\r\n", 6);
	else	write(headset->rfcomm_fd, "\r\nERROR\r\n", 9);
	return 1;
} 

void headset_destroy(struct s_headset *headset)
{
	if (headset == NULL)
		return;
	if (headset->sco_fd != -1) {
		bt_sco_set_fd(headset->handle, -1);
		close(headset->sco_fd);
	}

	sleep(1);
	if (headset->rfcomm_fd != -1) 
		close(headset->rfcomm_fd);
	if (headset->handle != NULL) 
		snd_hwdep_close(headset->handle);
	headset->sco_fd = -1;
	headset->rfcomm_fd = -1;
	headset->handle = NULL;
}

void cleanup(void)
{ 
	struct s_headset *akt_headset;
	akt_headset = first;
	while (akt_headset != NULL) {
		struct s_headset *next = akt_headset->next;
		headset_destroy(akt_headset);
		akt_headset = next;
		}
} 

int check_bt_voice(int dev)
{
	int dd;
	uint16_t vs;
	/* check voice settings. in this version we only support mu-law */
	dd = hci_open_dev(dev);
	hci_read_voice_setting(dd, &vs, 1000);
	vs = htobs(vs);
	fprintf(stderr, "Voice setting: 0x%04x\n", vs);
	close(dd);
	/*
	   MU_LAW
	   if (vs != 0x0140) {
	   fprintf(stderr, "The voice setting must be 0x0140\n");
	   return -1;
	   }
	 */

	// 16bit
	if (vs != 0x060) {
		fprintf(stderr, "The voice setting must be 0x060\n");
		return -1;
	}
	return 0;
}

int main(int argc, char *argv[])
{
	int dev;
	int card;
	struct sigaction sa;

	int rlen;
	int bt_dev = 0;

	struct pollfd pfds[16];

	int err;

	char hwdep_name[16];
	struct s_headset *akt_headset;
	
	atexit(cleanup);
	
	/* detect the audio device */
	if (find_hwdep_device(&card, &dev)) {
		error("Can't find device. Bail");
		return 1;
	}
	printf("Device is %d:%d\n", card, dev);
	sprintf(hwdep_name, "hw:%i,%i", card, dev);S

	if (check_bt_voice(bt_dev))
		return -1;


	/* find bdaddr */
	switch (argc) {
	case 2:
		akt_headset = headset_new();
		hci_devba(bt_dev, &akt_headset->local);
		str2ba(argv[1], &akt_headset->bdaddr);
		akt_headset->channel = detect_channel(&akt_headset->bdaddr);
		/* open hwdep on audio device */
		if ((err = snd_hwdep_open(&akt_headset->handle, hwdep_name, O_RDWR)) < 0) {
			error("btsco open (%i-%i): %s\n", card, dev, snd_strerror(err));
			return -1;
		}
		break;
	case 3:
		akt_headset = headset_new();
		hci_devba(bt_dev, &akt_headset->local);
		str2ba(argv[1], &akt_headset->bdaddr);
		akt_headset->channel = atoi(argv[2]);
		/* open hwdep on audio device */
		if ((err = snd_hwdep_open(&akt_headset->handle, hwdep_name, O_RDWR)) < 0) {
			error("btsco open (%i-%i): %s\n", card, dev, snd_strerror(err));
			return -1;
		}
		break;
	default:
		usage();
		exit(-1);
	}

	/* setup sigterm handler. we must make sure to do a clean disconnect */
	memset(&sa, 0, sizeof(sa));
	sa.sa_flags = SA_NOCLDSTOP;
	sa.sa_handler = sig_term;
	sigaction(SIGTERM, &sa, NULL);
	sigaction(SIGINT, &sa, NULL);

	sa.sa_handler = SIG_IGN;
	sigaction(SIGCHLD, &sa, NULL);
	sigaction(SIGPIPE, &sa, NULL);

	/* we are not yet connected */
	while (!terminate) {
		short revents;
		int nfds;
		nfds = 0;
		/* set up data polling description */
		for (akt_headset = first; akt_headset != NULL; akt_headset = akt_headset->next) { 
			if (akt_headset->rfcomm_fd == -1)
			{
				/* connect rfcomm control channel */
				if ((akt_headset->rfcomm_fd = rfcomm_connect(
						&akt_headset->local, 
						&akt_headset->bdaddr, 
						akt_headset->channel)) < 0) 
					fprintf(stderr, "Can't connect RFCOMM channel");
				else	fprintf(stderr, "RFCOMM channel %i connected\n", akt_headset->channel);
			}
			if (akt_headset->rfcomm_fd != -1)
			{
				pfds[nfds].fd = akt_headset->rfcomm_fd;
				pfds[nfds++].events = POLLIN;
			}
			if (akt_headset->handle != NULL)
			{
				/* polling data from hwdep interface */
				nfds += snd_hwdep_poll_descriptors(akt_headset->handle, &pfds[nfds], 1);
			}
		} 
		/*printf("outer loop\n"); */
		if (nfds == 0) {
			sleep(3);
			continue;
		}
		if (poll(pfds, nfds, 1000) <= 0) 
			continue;

		for (akt_headset = first; akt_headset != NULL; akt_headset = akt_headset->next) {
			int j;
			for (j=0; j<nfds; j++) {
				if (pfds[j].fd == akt_headset->rfcomm_fd) {
					if (pfds[j].revents & POLLIN) headset_from_bt (akt_headset);
					continue;
				}
#ifdef TEST
				if (pfds[j].fd == akt_headset->sco_fd) {
					/* Just for testing; handled by kernel driver */
					fd_set rfds;
					if (0 && FD_ISSET(akt_headset->sco_fd, &rfds)) {
						int i;
						unsigned char buf[2048];
						memset(buf, 0, sizeof(buf));
						rlen = read(akt_headset->sco_fd, buf, sizeof(buf));
						write(akt_headset->sco_fd, buf, rlen);
						i++;
						if (i % 15 == 0) printf("rlen: %d\n", rlen);
					}
					continue;
				}
#endif
				/* Volume polling (sound card) */
				if (!snd_hwdep_poll_descriptors_revents (akt_headset->handle, &pfds[j], 1, &revents) && revents & POLLIN) 
					headset_volume_fromcard (akt_headset);
			}
		}
	}
	return 0;
}

--------------080802000707030505010201
Content-Type: text/plain;
 name="btsco.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="btsco.c.diff"

Index: btsco.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/btsco.c,v
retrieving revision 1.11
diff -r1.11 btsco.c
66,68d65
< #define NOT_CONNECTED 0
< #define CONNECTED 1
< 
77c74
< {
---
> { 
104c101
< }
---
> } 
108c105
< {
---
> { 
153c150
< }
---
> } 
156c153
< {
---
> { 
164c161
< }
---
> } 
167c164
< {
---
> { 
174c171
< }
---
> } 
214d210
< 
217a214
> 			int if_type;
221c218
< 			if (dev < 0)
---
> 			if (dev < 0) 
231,232c228,229
< 			if (snd_hwdep_info_get_iface(hwdep_info) ==
< 			    SNDRV_HWDEP_IFACE_BT_SCO) {
---
> 			if_type = snd_hwdep_info_get_iface(hwdep_info);
> 			if (if_type == SNDRV_HWDEP_IFACE_BT_SCO || if_type==12) {
301,313c298
< int main(int argc, char *argv[])
< {
< 	int dev;
< 	int card;
< 
< 	struct sigaction sa;
< 
< 	fd_set rfds;
< 	//struct timeval timeout;
< 	unsigned char buf[2048];
< 	//int sel, rlen, wlen;
< 	int rlen, wlen;
< 
---
> struct s_headset {
317,337c302,303
< 
< 	//char *filename;
< 	//mode_t filemode;
< 	//int mode = 0;
< 	int dd;
< 	int rd;			// rfcomm handle
< 	int sd;			//sco handle
< 	uint16_t sco_handle, sco_mtu, vs;
< 	char line[100];
< 	int volumes[2], last_volumes[2];
< 	int opdone;
< 
< 	// sco_mode is our running mode. 0 => not connect, 1 => connected
< 	// see NOT_CONNECTED,CONNECTED :)
< 	int sco_mode;
< 
< 	struct pollfd pfds[10];
< 	int nfds;
< 
< 	int i, err;
< 
---
> 	int rfcomm_fd;
> 	int sco_fd;
339,343c305,331
< 	char hwdep_name[16];
< 
< 	/* detect the audio device */
< 	if (find_hwdep_device(&card, &dev)) {
< 		error("Can't find device. Bail");
---
> 	int volumes[2];
> 	int last_volumes[2];
> 	struct s_headset *next;
> 	};
> 
> struct s_headset  b_headset;
> struct s_headset *first = NULL;
> 
> int headset_button(struct s_headset *headset)
> { 
> 	uint16_t sco_handle, sco_mtu;
> 
> 	if (headset == NULL)
> 		return 0;
> 	if (headset->sco_fd != -1) {
> 		/* close bt_sco audio handle */
> 		bt_sco_set_fd(headset->handle, -1);
> 		/* disconnect SCO stream */
> 		close(headset->sco_fd);
> 		headset->sco_fd = -1;
> 		fprintf(stderr, "disconnected SCO channel\n");
> 		return 1;
> 	}
> 	fprintf(stderr, "opened hwdep\n");
> 	/* connect sco stream */
> 	if ((headset->sco_fd = sco_connect(&headset->local, &headset->bdaddr, &sco_handle, &sco_mtu)) < 0) {
> 		perror ("Can't connect SCO audio channel\n");
345a334,361
> 	fprintf(stderr, "connected SCO channel\n");
> 	//      write(rd, "RING\r\n", 6);
> 	printf ("Setting sco fd\n"); 
> 	bt_sco_set_fd (headset->handle, headset->sco_fd);
> 	printf ("Done setting sco fd\n"); 
> 	return 1;
> } 
> 
> struct s_headset *headset_new  (void)
> { 
> 	struct s_headset *headset;
> 	headset = malloc (sizeof(struct s_headset));
> 	if (headset == NULL)
> 		return NULL;
> 	headset->sco_fd = -1;
> 	headset->rfcomm_fd = -1;
> 	headset->handle = NULL;
> 	headset->last_volumes[0] = 0;
> 	headset->last_volumes[1] = 0;
> 	headset->next = first;
> 	first = headset;
> 	return headset;
> } 
> 
> int headset_volume_fromcard (struct s_headset *headset)
> { 
> 	int len;
> 	char line[100];
347c363,392
< 	printf("Device is %d:%d\n", card, dev);
---
> 	len = snd_hwdep_read(headset->handle, headset->volumes, sizeof(headset->volumes));
> 	if (len != sizeof(headset->volumes)) 
> 		return 0;
> 	printf ("volume speaker: %d mic: %d\n", headset->volumes[0], headset->volumes[1]);
> 	if (headset->volumes[0] != headset->last_volumes[0]) {
> 		sprintf(line, "+VGS=%d\r", headset->volumes[0]);
> 		write(headset->rfcomm_fd, line, strlen(line));
> 		headset->last_volumes[0] = headset->last_volumes[0];
> 	}
> 	if (headset->volumes[1] != headset->last_volumes[1]) {
> 		sprintf(line, "+VGM=%d\r", headset->volumes[1]);
> 		write(headset->rfcomm_fd, line, strlen(line));
> 		headset->last_volumes[1] = headset->last_volumes[1];
> 	}
> 	return 1;
> } 
> 
> int headset_speaker (struct s_headset *headset)
> { 
> 	fprintf(stderr, "Sending up speaker change %d\n", headset->volumes[0]);
> 	snd_hwdep_write(headset->handle, headset->volumes, sizeof (headset->volumes));
> 	return 1;
> } 
> 
> int headset_micro   (struct s_headset *headset)
> { 
> 	fprintf(stderr, "Sending up microphone change %d\n", headset->volumes[1]);
> 	snd_hwdep_write(headset->handle, headset->volumes, sizeof (headset->volumes));
> 	return 1;
> } 
349c394,417
< 	sprintf(hwdep_name, "hw:%i,%i", card, dev);
---
> int headset_from_bt (struct s_headset *headset)
> { 
> 	unsigned char buf[2048];
> 	int rlen;
> 	int opdone;
> 	
> 	opdone = 0;
> 	rlen = read(headset->rfcomm_fd, buf, sizeof(buf) - 1);
> 	if (rlen <= 0)
> 		return 0;
> 	buf [rlen] = 0;
> 	fprintf(stderr, "recieved %s\n", buf);
> 	if (strstr(buf, "AT+BVRA="   )) opdone = headset_button(headset);
> 	else if (strstr(buf, "AT+CKPD=200")) opdone = headset_button(headset);
> 	else if (strstr(buf, "AT+CHUP"    )) opdone = headset_button(headset);
> 	else if (strstr(buf, "AT+CIND=?"  )) opdone = headset_button(headset);
> 	else if (sscanf (buf, "AT+VGS=%d", &headset->volumes[0]) == 1) opdone = headset_speaker (headset);
> 	else if (sscanf (buf, "AT+VGM=%d", &headset->volumes[1]) == 1) opdone = headset_micro   (headset);
> 	if (opdone == 1)
> 		/* tell them we recieved */
> 		write(headset->rfcomm_fd, "\r\nOK\r\n", 6);
> 	else	write(headset->rfcomm_fd, "\r\nERROR\r\n", 9);
> 	return 1;
> } 
351,354c419,425
< 	/* open hwdep on audio device */
< 	if ((err = snd_hwdep_open(&handle, hwdep_name, O_RDWR)) < 0) {
< 		error("btsco open (%i-%i): %s\n", card, dev, snd_strerror(err));
< 		return -1;
---
> void headset_destroy(struct s_headset *headset)
> {
> 	if (headset == NULL)
> 		return;
> 	if (headset->sco_fd != -1) {
> 		bt_sco_set_fd(headset->handle, -1);
> 		close(headset->sco_fd);
357,361c428,436
< 	if (argc > 3) {
< 		printf("Clearing fd\n");
< 		bt_sco_set_fd(handle, 1);
< 		return 1;
< 	}
---
> 	sleep(1);
> 	if (headset->rfcomm_fd != -1) 
> 		close(headset->rfcomm_fd);
> 	if (headset->handle != NULL) 
> 		snd_hwdep_close(headset->handle);
> 	headset->sco_fd = -1;
> 	headset->rfcomm_fd = -1;
> 	headset->handle = NULL;
> }
363,376c438,447
< 	/* find bdaddr */
< 	switch (argc) {
< 	case 2:
< 		str2ba(argv[1], &bdaddr);
< 		channel = detect_channel(&bdaddr);
< 		break;
< 	case 3:
< 		str2ba(argv[1], &bdaddr);
< 		channel = atoi(argv[2]);
< 		break;
< 	default:
< 		usage();
< 		exit(-1);
< 	}
---
> void cleanup(void)
> { 
> 	struct s_headset *akt_headset;
> 	akt_headset = first;
> 	while (akt_headset != NULL) {
> 		struct s_headset *next = akt_headset->next;
> 		headset_destroy(akt_headset);
> 		akt_headset = next;
> 		}
> } 
377a449,452
> int check_bt_voice(int dev)
> {
> 	int dd;
> 	uint16_t vs;
379,380c454
< 	hci_devba(0, &local);
< 	dd = hci_open_dev(0);
---
> 	dd = hci_open_dev(dev);
397a472,532
> 	return 0;
> }
> 
> int main(int argc, char *argv[])
> {
> 	int dev;
> 	int card;
> 	struct sigaction sa;
> 
> 	int rlen;
> 	int bt_dev = 0;
> 
> 	struct pollfd pfds[16];
> 
> 	int err;
> 
> 	char hwdep_name[16];
> 	struct s_headset *akt_headset;
> 	
> 	atexit(cleanup);
> 	
> 	/* detect the audio device */
> 	if (find_hwdep_device(&card, &dev)) {
> 		error("Can't find device. Bail");
> 		return 1;
> 	}
> 	printf("Device is %d:%d\n", card, dev);
> 	sprintf(hwdep_name, "hw:%i,%i", card, dev);S
> 
> 	if (check_bt_voice(bt_dev))
> 		return -1;
> 
> 
> 	/* find bdaddr */
> 	switch (argc) {
> 	case 2:
> 		akt_headset = headset_new();
> 		hci_devba(bt_dev, &akt_headset->local);
> 		str2ba(argv[1], &akt_headset->bdaddr);
> 		akt_headset->channel = detect_channel(&akt_headset->bdaddr);
> 		/* open hwdep on audio device */
> 		if ((err = snd_hwdep_open(&akt_headset->handle, hwdep_name, O_RDWR)) < 0) {
> 			error("btsco open (%i-%i): %s\n", card, dev, snd_strerror(err));
> 			return -1;
> 		}
> 		break;
> 	case 3:
> 		akt_headset = headset_new();
> 		hci_devba(bt_dev, &akt_headset->local);
> 		str2ba(argv[1], &akt_headset->bdaddr);
> 		akt_headset->channel = atoi(argv[2]);
> 		/* open hwdep on audio device */
> 		if ((err = snd_hwdep_open(&akt_headset->handle, hwdep_name, O_RDWR)) < 0) {
> 			error("btsco open (%i-%i): %s\n", card, dev, snd_strerror(err));
> 			return -1;
> 		}
> 		break;
> 	default:
> 		usage();
> 		exit(-1);
> 	}
410,435d544
< 	/* connect rfcomm control channel */
< 	if ((rd = rfcomm_connect(&local, &bdaddr, channel)) < 0) {
< 		perror("Can't connect RFCOMM channel");
< 		return -1;
< 	}
< 
< 	fprintf(stderr, "RFCOMM channel %i connected\n", channel);
< 
< 	i = 0;
< 
< 	/* set up data polling description */
< 	nfds = 0;
< 
< 	/* polling data from rfcomm */
< 	pfds[nfds].fd = rd;
< 	pfds[nfds++].events = POLLIN;
< 
< 	// polling data from command line - unused now
< //      pfds[nfds].fd = 0;
< //      pfds[nfds++].events = POLLIN;
< 
< 	/* polling data from hwdep interface */
< 	nfds += snd_hwdep_poll_descriptors(handle, &pfds[nfds], 1);
< 
< 	last_volumes[0] = last_volumes[1] = 0;
< 
437,438d545
< 	sco_mode = NOT_CONNECTED;
< 	sd = -1;
439a547,572
> 		short revents;
> 		int nfds;
> 		nfds = 0;
> 		/* set up data polling description */
> 		for (akt_headset = first; akt_headset != NULL; akt_headset = akt_headset->next) { 
> 			if (akt_headset->rfcomm_fd == -1)
> 			{
> 				/* connect rfcomm control channel */
> 				if ((akt_headset->rfcomm_fd = rfcomm_connect(
> 						&akt_headset->local, 
> 						&akt_headset->bdaddr, 
> 						akt_headset->channel)) < 0) 
> 					fprintf(stderr, "Can't connect RFCOMM channel");
> 				else	fprintf(stderr, "RFCOMM channel %i connected\n", akt_headset->channel);
> 			}
> 			if (akt_headset->rfcomm_fd != -1)
> 			{
> 				pfds[nfds].fd = akt_headset->rfcomm_fd;
> 				pfds[nfds++].events = POLLIN;
> 			}
> 			if (akt_headset->handle != NULL)
> 			{
> 				/* polling data from hwdep interface */
> 				nfds += snd_hwdep_poll_descriptors(akt_headset->handle, &pfds[nfds], 1);
> 			}
> 		} 
441,444c574,579
< 		opdone = 0;
< 
< 		if (poll(pfds, nfds, 1000) > 0) {
< 			short revents;
---
> 		if (nfds == 0) {
> 			sleep(3);
> 			continue;
> 		}
> 		if (poll(pfds, nfds, 1000) <= 0) 
> 			continue;
446,472c581,586
< 			/*printf("inner loop\n"); */
< 			/* Volume polling (sound card) */
< 			if (!snd_hwdep_poll_descriptors_revents
< 			    (handle, &pfds[nfds - 1], 1, &revents)
< 			    && revents & POLLIN) {
< 				int len;
< 
< 				len =
< 				    snd_hwdep_read(handle, volumes,
< 						   sizeof(volumes));
< 				if (len == sizeof(volumes)) {
< 					printf
< 					    ("speaker volume: %d mic volume: %d\n",
< 					     volumes[0], volumes[1]);
< 					if (volumes[0] != last_volumes[0]) {
< 						sprintf(line, "+VGS=%d\r",
< 							volumes[0]);
< 						write(rd, line, strlen(line));
< 					}
< 					if (volumes[1] != last_volumes[1]) {
< 						sprintf(line, "+VGM=%d\r",
< 							volumes[1]);
< 						write(rd, line, strlen(line));
< 					}
< 					memcpy(last_volumes, volumes,
< 					       sizeof(volumes));
< 					opdone = 1;
---
> 		for (akt_headset = first; akt_headset != NULL; akt_headset = akt_headset->next) {
> 			int j;
> 			for (j=0; j<nfds; j++) {
> 				if (pfds[j].fd == akt_headset->rfcomm_fd) {
> 					if (pfds[j].revents & POLLIN) headset_from_bt (akt_headset);
> 					continue;
474,548c588,599
< 			}
< 			// control transmission events for volume and channel control
< 			if (pfds[0].revents & POLLIN) {
< 				memset(buf, 0, sizeof(buf));
< 				rlen = read(rd, buf, sizeof(buf) - 1);
< 				if (rlen > 0) {
< 					fprintf(stderr, "recieved %s\n", buf);
< 					/* tell them we recieved */
< 					wlen = write(rd, "\r\nOK\r\n", 6);
< 
< 					if (strstr(buf, "AT+BVRA=")
< 					    || strstr(buf, "AT+CKPD=200")
< 					    || strstr(buf, "AT+CHUP")
< 					    || strstr(buf, "AT+CIND=?")) {
< 						/* mini state machine: handle connect/disconnect */
< 						switch (sco_mode) {
< 						case NOT_CONNECTED:
< 							fprintf(stderr,
< 								"opened hwdep\n");
< 							/* connect sco stream */
< 							if ((sd =
< 							     sco_connect(&local,
< 									 &bdaddr,
< 									 &sco_handle,
< 									 &sco_mtu))
< 							    < 0) {
< 
< 								perror
< 								    ("Can't connect SCO audio channel\n");
< 							} else {
< 								fprintf(stderr,
< 									"connected SCO channel\n");
< 								//      write(rd, "RING\r\n", 6);
< 								printf
< 								    ("Setting sco fd\n");
< 								bt_sco_set_fd
< 								    (handle,
< 								     sd);
< 
< 								printf
< 								    ("Done setting sco fd\n");
< 								sco_mode =
< 								    CONNECTED;
< 							}
< 
< 							opdone = 1;
< 							break;
< 						case CONNECTED:
< 							/* close bt_sco audio handle */
< 							bt_sco_set_fd(handle,
< 								      -1);
< 							/* disconnect SCO stream */
< 							close(sd);
< 							fprintf(stderr,
< 								"disconnected SCO channel\n");
< 
< 							sco_mode =
< 							    NOT_CONNECTED;
< 
< 							opdone = 1;
< 							break;
< 						}
< 					}
< 
< 					if (sscanf
< 					    (buf, "AT+VGS=%d",
< 					     &volumes[0]) == 1) {
< 						fprintf(stderr,
< 							"Sending up speaker change %d\n",
< 							volumes[0]);
< 						snd_hwdep_write(handle,
< 								volumes,
< 								sizeof
< 								(volumes));
< 						opdone = 1;
---
> #ifdef TEST
> 				if (pfds[j].fd == akt_headset->sco_fd) {
> 					/* Just for testing; handled by kernel driver */
> 					fd_set rfds;
> 					if (0 && FD_ISSET(akt_headset->sco_fd, &rfds)) {
> 						int i;
> 						unsigned char buf[2048];
> 						memset(buf, 0, sizeof(buf));
> 						rlen = read(akt_headset->sco_fd, buf, sizeof(buf));
> 						write(akt_headset->sco_fd, buf, rlen);
> 						i++;
> 						if (i % 15 == 0) printf("rlen: %d\n", rlen);
550,576c601
< 					if (sscanf
< 					    (buf, "AT+VGM=%d",
< 					     &volumes[1]) == 1) {
< 						fprintf(stderr,
< 							"Sending up microphone change %d\n",
< 							volumes[1]);
< 						snd_hwdep_write(handle,
< 								volumes,
< 								sizeof
< 								(volumes));
< 						opdone = 1;
< 
< 					}
< 				}
< 			}
< 
< 			/* Just for testing; handled by kernel driver */
< 
< 			if (0 && FD_ISSET(sd, &rfds)) {
< 				memset(buf, 0, sizeof(buf));
< 				rlen = read(sd, buf, sizeof(buf));
< 				write(sd, buf, rlen);
< 
< 				i++;
< 
< 				if (i % 15 == 0) {
< 					printf("rlen: %d\n", rlen);
---
> 					continue;
577a603,606
> #endif
> 				/* Volume polling (sound card) */
> 				if (!snd_hwdep_poll_descriptors_revents (akt_headset->handle, &pfds[j], 1, &revents) && revents & POLLIN) 
> 					headset_volume_fromcard (akt_headset);
580,581d608
< 		if (!opdone)
< 			sleep(1);
583,595d609
< 
< 	if (sco_mode == CONNECTED) {
< 		close(sd);
< 
< 		bt_sco_set_fd(handle, -1);
< 
< 	}
< 
< 	sleep(1);
< 	close(rd);
< 
< 	snd_hwdep_close(handle);
< 

--------------080802000707030505010201--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
