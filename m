Return-Path: <cyrus@holtmann.org>
Message-ID: <4D385855.2050709@iam.unibe.ch>
Date: Thu, 20 Jan 2011 16:44:21 +0100
From: =?ISO-8859-15?Q?Ulrich_B=FCrgi?= <buergi@iam.unibe.ch>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Problem with inquiry result with rssi
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

I'm encountering a strange behavior regarding inquiry results. I'm 
working on a C program, which has a method called 'scanner_start'. This 
method performs an inquiry and reports the corresponding addresses and 
RSSI values of all results.
When I just call this method and do nothing else, it works as intended. 
However, if I do anything prior to that, I only get 'normal' inquiry 
results without RSSI.

As example, this works:
/* do nothing here */
scanner_start();
/* do something here */

whereas this fails:
/* do nothing here */
int i;
scanner_start();
/* do something here */

Below is the complete source code needed to reproduce this behavior.

I cannot really imagine, how an unused declaration can have an impact on 
the inquiry results. Does anybody have a clue, how this could be?

Thank you,
Ulrich

--

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <sys/ioctl.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

static void print_result(bdaddr_t *bdaddr, char has_rssi, int rssi)
{
	char addr[18];

	ba2str(bdaddr, addr);

	printf("%17s", addr);
	if(has_rssi)
		printf(" RSSI:%d", rssi);
	else
		printf(" RSSI:n/a");
	printf("\n");
	fflush(NULL);
}


static void scanner_start()
{
	int dev_id, sock = 0;
	struct hci_filter flt;
	inquiry_cp cp;
	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
	hci_event_hdr *hdr;
	char canceled = 0;
	inquiry_info_with_rssi *info_rssi;
	inquiry_info *info;
	int results, i, len;
	struct pollfd p;

	dev_id = hci_get_route(NULL);
	sock = hci_open_dev( dev_id );
	if (dev_id < 0 || sock < 0) {
		perror("Can't open socket");
		return;
	}

	hci_filter_clear(&flt);
	hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
	hci_filter_set_event(EVT_INQUIRY_RESULT, &flt);
	hci_filter_set_event(EVT_INQUIRY_RESULT_WITH_RSSI, &flt);
	hci_filter_set_event(EVT_INQUIRY_COMPLETE, &flt);
	if (setsockopt(sock, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
		perror("Can't set HCI filter");
		return;
	}

	if (hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE, 
WRITE_INQUIRY_MODE_RP_SIZE, &cp) < 0) {
		perror("Can't set inquiry mode");
		return;
	}

	memset (&cp, 0, sizeof(cp));
	cp.lap[2] = 0x9e;
	cp.lap[1] = 0x8b;
	cp.lap[0] = 0x33;
	cp.num_rsp = 0;
	cp.length = 0x30;

	printf("Starting inquiry with RSSI...\n");

	if (hci_send_cmd (sock, OGF_LINK_CTL, OCF_INQUIRY, INQUIRY_CP_SIZE, 
&cp) < 0) {
		perror("Can't start inquiry");
		return;
	}

	p.fd = sock;
	p.events = POLLIN | POLLERR | POLLHUP;

	while(!canceled) {
		p.revents = 0;

		/* poll the BT device for an event */
		if (poll(&p, 1, -1) > 0) {
			len = read(sock, buf, sizeof(buf));

			if (len < 0)
				continue;
			else if (len == 0)
				break;

			hdr = (void *) (buf + 1);
			ptr = buf + (1 + HCI_EVENT_HDR_SIZE);

			results = ptr[0];

			switch (hdr->evt) {
				case EVT_INQUIRY_RESULT:
					for (i = 0; i < results; i++) {
						info = (void *)ptr + (sizeof(*info) * i) + 1;
						print_result(&info->bdaddr, 0, 0);
					}
					break;

				case EVT_INQUIRY_RESULT_WITH_RSSI:
					for (i = 0; i < results; i++) {
						info_rssi = (void *)ptr + (sizeof(*info_rssi) * i) + 1;
						print_result(&info_rssi->bdaddr, 1, info_rssi->rssi);
					}
					break;

				case EVT_INQUIRY_COMPLETE:
					canceled = 1;
					break;
			}
		}
	}
	close(sock);
}

int main(int argc, char **argv)
{
	//int i; /* causes inq. result to have no rssi value */
	scanner_start();
	return 0;
}
