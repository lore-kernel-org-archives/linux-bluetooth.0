Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Detecting RSSI without connecting
References: <qszactrj3c5.fsf@timepilot.gpcc.itd.umich.edu>
	<1099960170.29330.43.camel@pegasus>
	<qszu0rfnfil.fsf@mspacman.gpcc.itd.umich.edu>
	<1101413321.6465.6.camel@pegasus>
	<qszzn10q72i.fsf@timepilot.gpcc.itd.umich.edu>
	<1101792690.7562.54.camel@pegasus>
	<qsz653ndf21.fsf@asteroids.gpcc.itd.umich.edu>
From: Scott W Gifford <gifford@umich.edu>
In-Reply-To: <qsz653ndf21.fsf@asteroids.gpcc.itd.umich.edu> (Scott W.
 Gifford's message of "Tue, 30 Nov 2004 01:30:30 -0500")
Message-ID: <qszmzwxv8n3.fsf@mspacman.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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
Date: Wed, 01 Dec 2004 19:36:16 -0500

--=-=-=

Scott W Gifford <gifford@umich.edu> writes:

[...]

> Ah, this program:
>
>     http://article.gmane.org/gmane.linux.bluez.user/1191
>
> looks like a great place to start.  I'll hack at it for a bit over the
> next few days and post an update.

I got something working to my satisfaction.  I've attached it as a
plain text file, for comment and as another example.

----ScottG.


--=-=-=
Content-Type: text/x-c-program
Content-Disposition: inline; filename=btscan.c

/*
 *
 *  Repeatedly scan with RSSI
 *
 *  Copyright (C) 2004  Scott Gifford <gifford@umich.edu>
 *  Copyright (C) 2003  Marcel Holtmann <marcel@holtmann.org>
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
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <signal.h>
#include <sys/poll.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <time.h>
#include <getopt.h>
#include <limits.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

int debug = 0;

#define POLL_TIMEOUT 11000
#define MAX_DELAY    2000

void usage(char *name)
{
  fprintf(stderr,"Usage: %s [-i hci-if]\n",name);
  exit(2);
}

static volatile sig_atomic_t __io_canceled = 0;

static void sig_hup(int sig)
{
  return;
}

static void sig_term(int sig)
{
  __io_canceled = 1;
}

static void show_inquiry_result(bdaddr_t *bdaddr, int rssi)
{
  char addr[18];

  ba2str(bdaddr, addr);
  printf("%18s: ", addr);

  if (rssi == INT_MIN)
    printf("%4c\n",'?');
  else
    printf("%4d\n",rssi);

  fflush(stdout);
}

static void inquiry_result(int dd, unsigned char *buf, int len)
{
  inquiry_info *info;
  uint8_t num;
  int i;

  num = buf[0];
  if (debug) fprintf(stderr,"inquiry_result:\tnum %d\n", num);

  for (i = 0; i < num; i++) {
    info = (void *) buf + (sizeof(*info) * i) + 1;
    show_inquiry_result(&info->bdaddr, INT_MIN);
  }
}

static void inquiry_result_with_rssi(int dd, unsigned char *buf, int len)
{
  inquiry_info_with_rssi *info;
  uint8_t num;
  int i;

  num = buf[0];
  if (debug) fprintf(stderr,"inquiry_result_with_rssi:\tnum %d\n", num);

  for (i = 0; i < num; i++) {
    info = (void *) buf + (sizeof(*info) * i) + 1;
    show_inquiry_result(&info->bdaddr, info->rssi);
  }
}


/* Try to active RSSI on inquiry, but if it doesn't work oh well. */
static void activate_rssi(int dd)
{
  write_inquiry_mode_cp cp;
  int err;

  cp.mode = 1;
  err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE, WRITE_INQUIRY_MODE_RP_SIZE, &cp);
  if (debug) fprintf(stderr,"activate_rssi: err=%d\n",err);
  /* No other error checking, since this may fail and we don't care. */
}


static void begin_inquiry(int dd)
{
  inquiry_cp cp;
  int err;

  if (debug) fprintf(stderr,"begin_inquiry: starting\n");
  memset (&cp, 0, sizeof(cp));
  cp.lap[2] = 0x9e;
  cp.lap[1] = 0x8b;
  cp.lap[0] = 0x33;
  cp.num_rsp = 0;
  cp.length = 0x30;

  err = hci_send_cmd (dd, OGF_LINK_CTL, OCF_INQUIRY,
		      INQUIRY_CP_SIZE, &cp);
  if (err < 0)
  {
    fprintf(stderr,"Error #%d beginning inquiry\n",err);
    exit(1);
  }
}

static void cancel_inquiry(int dd)
{
  int err;

  err = hci_send_cmd (dd, OGF_LINK_CTL, OCF_INQUIRY_CANCEL,
		      0, NULL);
  if (debug) fprintf(stderr,"cancel_inquiry: err=%d\n",err);
  /* No other error checking, because what would we do? */
}

int main(int argc, char *argv[])
{
  unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
  hci_event_hdr *hdr;
  struct hci_filter flt;
  struct sigaction sa;
  struct pollfd p;
  int dd = -1, dev = 0, len;
  int errflg = 0;
  int c;
  extern char *optarg;
  extern int optind;
	
  /* Process command-line options */
  while ((c = getopt(argc, argv, "i:")) != EOF)
  {
    switch(c)
    {
      case 'i':
        if ((dev = hci_devid(optarg)) < 0)
        {
          fprintf(stderr,"Invalid device '%s': %s\n",optarg,strerror(errno));
          exit(1);
        }
        break;
      case '?':
        errflg++;
        break;
    }
  }

  if (errflg)
    usage(argv[0]);
	
  /* Open the Bluetooth device */
  dd = hci_open_dev(dev);
  if (dd < 0) {
    perror("Can't open HCI device");
    exit(1);
  }

  /* Set up an event filter; we only care about inquiry-related
   *  events.
   */
  hci_filter_clear(&flt);
  hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
  hci_filter_set_event(EVT_INQUIRY_RESULT, &flt);
  hci_filter_set_event(EVT_INQUIRY_RESULT, &flt);
  hci_filter_set_event(EVT_INQUIRY_RESULT_WITH_RSSI, &flt);
  hci_filter_set_event(EVT_INQUIRY_COMPLETE, &flt);
  if (setsockopt(dd, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
    perror("Can't set HCI filter");
    exit(1);
  }

  /* Set up signal handlers */
  memset(&sa, 0, sizeof(sa));
  sa.sa_flags   = SA_NOCLDSTOP;
  sa.sa_handler = SIG_IGN;
  sigaction(SIGCHLD, &sa, NULL);
  sigaction(SIGPIPE, &sa, NULL);

  sa.sa_handler = sig_term;
  sigaction(SIGTERM, &sa, NULL);
  sigaction(SIGINT,  &sa, NULL);

  sa.sa_handler = sig_hup;
  sigaction(SIGHUP, &sa, NULL);

  /* Set up the random number generator, for random delays for
   * scan.  This tries to avoid multiple machines running this
   * software from starting at the same time and flooding the
   * network at the same time.
   */

  srand(time(NULL) ^ getpid());

  /* Request RSSI if available, then start the first inquiry. */
  activate_rssi(dd);
  usleep(rand() % MAX_DELAY);
  begin_inquiry(dd);

  /* Now poll for events until a signal tells is to cancel. */
  p.fd = dd;
  p.events = POLLIN | POLLERR | POLLHUP;
  while (!__io_canceled) {
    p.revents = 0;
    if (debug) fprintf(stderr,"Polling...\n");
    if (poll(&p, 1, POLL_TIMEOUT) > 0) {
      len = read(dd, buf, sizeof(buf));
      if (len < 0)
        continue;
      else if (len == 0)
        break; /* EOF */

      hdr = (void *) (buf + 1);
      ptr = buf + (1 + HCI_EVENT_HDR_SIZE);
      len -= (1 + HCI_EVENT_HDR_SIZE);
      if (debug) fprintf(stderr,"Got event!  Type is %d\n",hdr->evt);

      switch (hdr->evt) {

        case EVT_INQUIRY_RESULT:
          inquiry_result(dd, ptr, len);
          break;

        case EVT_INQUIRY_RESULT_WITH_RSSI:
          inquiry_result_with_rssi(dd, ptr, len);
          break;

        case EVT_INQUIRY_COMPLETE:
          /* Inquiry is finished, wait a random time
           * then start another. 
           */

          if (debug) fprintf(stderr,"Inquiry complete\n");
          usleep(rand() % MAX_DELAY);
          begin_inquiry(dd);
          break;
      }
    }
  }

  if (debug) fprintf(stderr,"Program finished.\n");

  cancel_inquiry(dd);
	
  if (hci_close_dev(dd) < 0) {
    perror("Can't close HCI device");
    exit(1);
  }

  return 0;
}

--=-=-=--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
