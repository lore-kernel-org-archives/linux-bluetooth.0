Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050629163820.10206.qmail@web30711.mail.mud.yahoo.com>
From: Olivier Randriamanana <olivier_randria@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Odd inquiry scan result
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
Date: Wed, 29 Jun 2005 09:38:19 -0700 (PDT)

Hi,

I'm trying to understand how to send HCI commands (my
final goal is to put my device in periodic
inquiry...). For the moment, using hcitool.c as an
example, I issue a HCI_Read_Inquiry_Scan_Activity
command to the device.

I zero the read_inq_activity_rp structure, and send
the command. No error it seems, as the Command
Complete event is received, and here is the hex dump
of received data:
> HCI Event: 0x0e plen 8
  01 1D 0C 12 00 00 00 00

However my read_inq_activity_rp structure is not
changed. I would have expected it to have the default
values (as read from the spec). 
I can't figure out what I'm getting wrong, could
someone please provide a hint???

Regards, 
Olivier


Code:
#include <stdio.h>
#include <stdlib.h>

#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

void hex_dump(char *pref, int width, unsigned char
*buf, int len);
void send_cmd(int dev_id, uint16_t ocf,uint8_t ogf /*,
int argc, char **argv*/);

int main(int argc, char* argv[])
{
  printf("%s:\n",argv[0]);

  send_cmd(0,OCF_PERIODIC_INQUIRY,OGF_HOST_CTL);

  return 0;
}

void send_cmd(int dev_id, uint16_t uocf,uint8_t uogf
/*, int argc, char **argv*/)
{
  char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
  struct hci_filter flt;
  hci_event_hdr *hdr;
  int i, opt, len, dd;
  read_inq_activity_rp rp;
  read_inq_activity_rp* prp;
  
  uint16_t ocf = OCF_READ_INQ_ACTIVITY;
  uint8_t ogf  = OGF_HOST_CTL;
  
  
  printf("%s: OGF %d OCF %d dev_id
%d\n",__FUNCTION__,ogf,ocf,dev_id);
  dd = hci_open_dev(dev_id);
  if (dd < 0) {
    perror("Device open failed");
    exit(EXIT_FAILURE);
  }
  
  
  /* Setup filter */
  hci_filter_clear(&flt);
  
  hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
  hci_filter_all_events(&flt);
  
  if (setsockopt(dd, SOL_HCI, HCI_FILTER, &flt,
sizeof(flt)) < 0) {
    perror("HCI filter setup failed");
    exit(EXIT_FAILURE);
  }
  prp = &rp;
  prp->status = 0;
  prp->interval = 0;
  prp->window = 0;
  
  len = READ_INQ_ACTIVITY_RP_SIZE;
  ptr = &rp;
  printf("< HCI Command: ogf 0x%02x, ocf 0x%04x, plen
%d (sizeof %d)\n", ogf, ocf, len,sizeof(rp));
  
  if (hci_send_cmd(dd, ogf, ocf, len, ptr /*buf*/) <
0) {
    perror("Send failed");
    exit(EXIT_FAILURE);
  }
  printf("rp.status %d, interval %d, window %d\n",
	       prp->status,
	 prp->interval,
	 prp->window);
  
  len = read(dd, buf, sizeof(buf));
  if (len < 0) {
    perror("Read failed");
		exit(EXIT_FAILURE);
  }
  
  hdr = (void *)(buf + 1);
  ptr = buf + (1 + HCI_EVENT_HDR_SIZE);
  len -= (1 + HCI_EVENT_HDR_SIZE);
  
  printf("> HCI Event: 0x%02x plen %d\n", hdr->evt,
hdr->plen);
  
  hex_dump("  ", 20, ptr, len); fflush(stdout);
  printf("rp.status %d, interval %d, window %d\n",
	 prp->status,
	 prp->interval,
	 prp->window);
  prp = ptr;
  printf("rp.status %d, interval %d, window %d\n",
	 prp->status,
	 prp->interval,
	 prp->window);
  hci_close_dev(dd);
}

void hex_dump(char *pref, int width, unsigned char
*buf, int len)
{
	register int i,n;

	for (i = 0, n = 1; i < len; i++, n++) {
		if (n == 1)
			printf("%s", pref);
		printf("%2.2X ", buf[i]);
		if (n == width) {
			printf("\n");
			n = 0;
		}
	}
	if (i && n!=1)
		printf("\n");
}


--
Olivier


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
