Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A74FE0.6020006@suche.org>
From: =?ISO-8859-1?Q?Thomas_Lu=DFnig?= <bluez@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	<20041123033429.132bf84b.henryk@ploetzli.ch>	<41A2B331.4010001@xmission.com>	<20041123070621.50569968.henryk@ploetzli.ch>	<41A3471C.4000602@xmission.com> <20041123203836.046fb4f4.henryk@ploetzli.ch> <41A3ACE2.4030501@xmission.com>
In-Reply-To: <41A3ACE2.4030501@xmission.com>
Content-Type: multipart/mixed;
 boundary="------------000106080702040304000902"
Subject: [Bluez-devel] BT-Sco
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
Date: Fri, 26 Nov 2004 16:46:40 +0100

This is a multi-part message in MIME format.
--------------000106080702040304000902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
here is an optimized version of btsco.c it es rewriten for Linux only.
Is does not need libbluetooth or libasound.
It is event driven but currently use fixed MAC

Any idea's are welcomed.

Compile:

gcc test.c -o test


Cu Thomas

--------------000106080702040304000902
Content-Type: image/x-xbitmap;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

#define _GNU_SOURCE
#include <signal.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sound/btsco.h>
#include <sound/asound.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sco.h>

int open_sound(int *card) {{{
	char file[128];
	int devie;
	int akt_card;
	*card = -1;
	for (akt_card=0;akt_card<4;akt_card++) {
		int card_fd;
		int version;
		struct sndrv_ctl_card_info card_info;
		struct sndrv_hwdep_info hw_info;
		int device;
		snprintf(file,128,"/dev/snd/controlC%i", akt_card);
		if (-1 == (card_fd = open(file, O_RDWR))) return -1;
		if (0 != ioctl(card_fd, SNDRV_CTL_IOCTL_PVERSION		, &version  )) goto next;
		if (0 != ioctl(card_fd, SNDRV_CTL_IOCTL_CARD_INFO		, &card_info)) goto next;
		if (0 != ioctl(card_fd, SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE	, &device   )) goto next;
		do {
			if (0 != strncmp(card_info.driver, "Bluetooth SCO", 13)) goto next;
			if (-1 == device) goto next;
			hw_info.device = device;
			if (0 != ioctl(card_fd, SNDRV_CTL_IOCTL_HWDEP_INFO              , &hw_info  )) goto next;
/*			
			printf("Version %x\n", version);
			printf("Card.ID         %i\n", card_info.id);
			printf("Card.Driver     %s\n", card_info.driver);
			printf("Card.Name       %s\n", card_info.name);
			printf("Card.Longname   %s\n", card_info.longname);
			printf("Card.Mixername  %s\n", card_info.mixername);
			printf("Card.Components %s\n", card_info.components);
			printf("Next device %i\n", device);
			printf("HW.Device       %u\n", hw_info.device);
			printf("HW.Card         %u\n", hw_info.card  );
			printf("HW.ID           %s\n", hw_info.id    );
			printf("HW.Name         %s\n", hw_info.name  );
			printf("HW.interface    %i\n", hw_info.iface );
*/			
			if (SNDRV_HWDEP_IFACE_BT_SCO == hw_info.iface) {
				close(card_fd);
				card_fd = -1;
				snprintf(file, 128, "/udev/snd/hwC%iD%i", (*card = hw_info.card), device);
				return open(file, O_RDWR);
				}
			if (0 != ioctl(card_fd, SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE	, &device   )) goto next;
			} while(device != -1);
next:		if (card_fd != -1) close(card_fd);
		}
	return -1;
	}}}

#define USE_SIGNAL      (SIGRTMIN+6)

struct sSound {
	int dsp;
	int ctr;
	int sco;
	int rfc;
	bdaddr_t ag;
	bdaddr_t hs;
	int speaker;
	};
struct sSound SND;

int async(int fd) {{{
	int   opt = 1;
	pid_t pid = getpid();
	if ( 0 != fcntl (fd, F_SETOWN ,  pid      ));// return -1 ; //Exit("fcntl(F_SETOWN) != 0");
//	if (-1 == ioctl (fd, SIOCSPGRP, &pid      ));// return -1 ; //Exit("ioctl(SIOCSPGRP) =>");
	if (-1 == ioctl (fd, FIOASYNC , &opt      ));// return -1 ; //Exit("ioctl(FIOASYNC) =>");
	if ( 0 != fcntl (fd, F_SETSIG , USE_SIGNAL));// return -1 ; //Exit("fcntl(F_SETSIG) != 0");
	return 0;
	}}}

static int rfcomm_connect(bdaddr_t * src, bdaddr_t * dst, uint8_t channel) {{{
	struct sockaddr_rc addr;
	int s;
	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) { return -1; }
	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, src);
	addr.rc_channel = 0;
	if (bind(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) { close(s); return -1; }
	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, dst);
	addr.rc_channel = channel;
	if (connect(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) { close(s); return -1; }
	return s;
	}}}
static int sco_connect   (bdaddr_t * src, bdaddr_t * dst) {{{
	struct sockaddr_sco addr;
	int s;
	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)) < 0) { return -1; }
	memset(&addr, 0, sizeof(addr));
	addr.sco_family = AF_BLUETOOTH;
	bacpy(&addr.sco_bdaddr, src);
	if (bind(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) { close(s); return -1; }
	memset(&addr, 0, sizeof(addr));
	addr.sco_family = AF_BLUETOOTH;
	bacpy(&addr.sco_bdaddr, dst);
	if (connect(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) { close(s); return -1; }
	return s;
	}}}
void handler(int sig, siginfo_t *si, void *data) {{{
	char buf[128];
	int akt_fd;
	akt_fd = si->si_fd;
	if (SND.rfc == akt_fd) {
		int len = read(akt_fd, buf, 128);
		write(akt_fd, "\r\nOK\r\n", 6);
		buf[len] = 0;
		if (0 == strcmp("AT+CKPD=200\r", buf)) {{{
			if (SND.sco == -1) {
				SND.sco = sco_connect(&SND.ag, &SND.hs);
				printf("SCO connect\n");
				}
			else	{
				close(SND.sco);
				SND.sco = -1;
				printf("SCO disconnect\n");
				}
			if (SND.ctr != -1 && SND.sco != -1) ioctl(SND.ctr,SNDRV_BT_SCO_IOCTL_SET_SCO_SOCKET, SND.sco);
			return;
			}}}
		if (0 == strncmp("AT+VGS=", buf, 7)) {
			SND.speaker = atoi(buf+7);;
			printf("Speaker Volume %i\n", SND.speaker);
			return;
			}
		printf("RFCOMM < %s\n", buf);
		return;
		}
	printf("Event on %i\n", akt_fd);
	}}}

int run = 30;
void sig_term(int sig) {
	run = 0;
	}

void init(void) {{{
	struct sigaction	sa;
	sa.sa_sigaction = handler;
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = SA_SIGINFO;
	sigaction(USE_SIGNAL, &sa, NULL);

	memset(&sa, 0, sizeof(sa));
	sa.sa_flags = SA_NOCLDSTOP;
	sa.sa_handler = sig_term;
	sigaction(SIGTERM, &sa, NULL);
	sigaction(SIGINT , &sa, NULL);
	sa.sa_handler = SIG_IGN;
	sigaction(SIGCHLD, &sa, NULL);
	sigaction(SIGPIPE, &sa, NULL);

	
//	sigset_t sigset;
//	sigemptyset (&sigset);
//	sigaddset   (&sigset, USE_SIGNAL);
//	sigprocmask (SIG_BLOCK, &sigset, NULL); 
	}}}

int main() {
	init();
	int card;
	SND.rfc = -1;
	SND.sco = -1;
	SND.ctr = -1;
	SND.dsp = -1;
	bdaddr_t bt_local;
	bdaddr_t bt_head;
	SND.ag.b[0]=0x4A; SND.ag.b[1]=0x1F; SND.ag.b[2]=0x81; SND.ag.b[3]=0x61; SND.ag.b[4]=0x04; SND.ag.b[5]=0x00;
	SND.hs.b[0]=0xD2; SND.hs.b[1]=0x0F; SND.hs.b[2]=0x0A; SND.hs.b[3]=0x44; SND.hs.b[4]=0x0D; SND.hs.b[5]=0x00;
	SND.ctr = open_sound(&card);
	ioctl(SND.ctr,SNDRV_BT_SCO_IOCTL_SET_SCO_SOCKET,-1);
	char buf[8];
	SND.rfc = rfcomm_connect(&SND.ag, &SND.hs, 1);
	if (SND.rfc == -1) {
		printf("No Connection\n");
		exit(0);
		}
	printf("Start\n");
	async(SND.rfc);
	while (run>0) {
		sleep(10);
		run--;
		}
exit: 	printf("Ende\n");
	if (SND.sco != -1) {
		if (SND.ctr != -1) ioctl(SND.ctr,SNDRV_BT_SCO_IOCTL_SET_SCO_SOCKET,-1);
		close (SND.sco);
		}
	if (SND.dsp != -1) close(SND.dsp);
	if (SND.ctr != -1) close(SND.ctr);
	if (SND.rfc != -1) close(SND.rfc);
	return 0;
	}

--------------000106080702040304000902--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
