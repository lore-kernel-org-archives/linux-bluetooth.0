Return-Path: <rob.davis@virgin.net>
Message-ID: <401830B2.5070407@virgin.net>
Date: Wed, 28 Jan 2004 21:59:14 +0000
From: Rob Davis <rob.davis@virgin.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] epox-presenter
References: <4017F953.1090108@virgin.net> <1075314868.26729.34.camel@pegasus>
In-Reply-To: <1075314868.26729.34.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------050800050808000004070901"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050800050808000004070901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

>Hi Rob,
>
>  
>
>>I've just picked up one of these devices, and was quite happy to see it 
>>supported under linux, and even working with remote X windows..
>>
>>However, I was wondering if there was a way of slowing or speeding up 
>>the speed of the mouse point, and getting the extra buttons working like 
>>a wheel mouse, like in windoze?
>>    
>>
>
>the code is quite self-explanatory and very simple. So go ahead and send
>me a patch for your features.
>  
>
Okay, my first ever C hack...

Implemented three functions, back button triggers mouse button 4, next 
button triggers mouse button 5, fn button triggers a keyboard alt + tab, 
which changes window focus in kde, and probably gnome.

I have also reduced the speed of the pointer from 12 to 4, which I am 
much happier with as I have a hope of landing on the correct window.

Sorry, I'm not sure how to do patch, but the file is small...

All the best - Rob

--------------050800050808000004070901
Content-Type: text/plain;
 name="main.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="main.c"

/*
 *
 *  EPoX Bluetooth Presenter software (BT-PM01B)
 *
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
#include <stdlib.h>
#include <getopt.h>
#include <signal.h>
#include <sys/poll.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

#include <X11/Xlib.h>
#include <X11/extensions/XTest.h>
#include <X11/keysym.h>
#include <math.h>


static void func(Display *display)
{
	XTestGrabControl(display, True);
        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Alt_L),
        True, CurrentTime );
        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Tab),
        True, CurrentTime );	
        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Tab),
        False, CurrentTime );
        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Alt_L),
        False, CurrentTime );
	XTestGrabControl(display, False);
	XFlush(display);
}


static void back(Display *display)
{


}

static void next(Display *display)
{
 
}

static void button(Display *display, unsigned int button, Bool is_press)
{
	XTestGrabControl(display, True);
	XTestFakeButtonEvent(display, button, is_press, CurrentTime);
	XTestGrabControl(display, False);
	XFlush(display);
}

static void move(Display *display, unsigned int direction)
{
	double angle;
	int x, y;

	angle = (direction * 22.5) * 3.1415926 / 180;
	x = (int) (sin(angle) * 4);
	y = (int) (cos(angle) * -4);

	XTestGrabControl(display, True);
	XTestFakeRelativeMotionEvent(display, x, y, CurrentTime);
	XTestGrabControl(display, False);
	XFlush(display);
}

static void decode_event(Display *display, unsigned char event)
{
	switch (event) {
	case 48:
		func(display); break;

/* Next two cases are to implement mouse buttons 4 and 5.
   ZAxisMapping must be defined in XF86Config for the CorePointer
   Unline Button 1 and 3, no unpress case is generated, so we sleep for
   a tenth of a second before turning the button off. - Rob Davis
*/

       	case 55:
	        button(display, 4, True);
		sleep(0.1);
	        button(display, 4, False); break;
	case 56:
                button(display, 5, True);
		sleep(0.1);
        	button(display, 5, False); break;		
	case 53:
		button(display, 1, True); break;
	case 121:
		button(display, 1, False); break;
	case 113:
		break;
	case 54:
		button(display, 3, True); break;
	case 120:
		button(display, 3, False); break;
	case 112:
		break;	

	case 51:
		move(display, 0); break;
	case 97:
		move(display, 1); break;
	case 65:
		move(display, 2); break;
	case 98:
		move(display, 3); break;
	case 50:
		move(display, 4); break;
	case 99:
		move(display, 5); break;
	case 67:
		move(display, 6); break;
	case 101:
		move(display, 7); break;
	case 52:
		move(display, 8); break;
	case 100:
		move(display, 9); break;
	case 66:
		move(display, 10); break;
	case 102:
		move(display, 11); break;
	case 49:
		move(display, 12); break;
	case 103:
		move(display, 13); break;
	case 57:
		move(display, 14); break;
	case 104:
		move(display, 15); break;
	case 69:
		break;
	default:
		printf("Unknown event code %d\n", event);
		break;
	}
}


static int get_channel(bdaddr_t *src, bdaddr_t *dst, uint8_t *channel)
{
	sdp_session_t *s;
	sdp_list_t *srch, *attrs, *rsp;
	uuid_t svclass;
	uint16_t attr;
	int err;

	if (!(s = sdp_connect(src, dst, 0)))
		return -1;

	sdp_uuid16_create(&svclass, SERIAL_PORT_SVCLASS_ID);
	srch = sdp_list_append(NULL, &svclass);

	attr = SDP_ATTR_PROTO_DESC_LIST;
	attrs = sdp_list_append(NULL, &attr);

	err = sdp_service_search_attr_req(s, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);

	sdp_close(s);

	if (err)
		return 0;

	for (; rsp; rsp = rsp->next) {
		sdp_record_t *rec = (sdp_record_t *) rsp->data;
		sdp_list_t *protos;

		if (!sdp_get_access_protos(rec, &protos)) {
			uint8_t ch = sdp_get_proto_port(protos, RFCOMM_UUID);
			if (ch > 0) {
				*channel = ch;
				return 1;
			}
		}
	}

	return 0;
}

static int search_device(bdaddr_t *src, bdaddr_t *dst)
{
	inquiry_info *info = NULL;
	char bda[18];
	int i, dev_id, num_rsp, length, flags;
	uint8_t class[3];

	ba2str(src, bda);
	dev_id = hci_devid(bda);
	if (dev_id < 0) {
		dev_id = hci_get_route(NULL);
		hci_devba(dev_id, src);
	}

	length  = 8;	/* ~10 seconds */
	num_rsp = 0;
	flags   = IREQ_CACHE_FLUSH;

	printf("Searching ...\n");

	num_rsp = hci_inquiry(dev_id, length, num_rsp, NULL, &info, flags);

	for (i = 0; i < num_rsp; i++) {
		memcpy(class, (info+i)->dev_class, 3);
		if (class[0] == 0x00 && class[1] == 0x40 && class[2] == 0x00) {
			bacpy(dst, &(info+i)->bdaddr);
			ba2str(dst, bda);

			free(info);
			return 1;
		}
	}

	free(info);
	printf("No devices in range or visible\n");

	return 0;
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

static void usage(void)
{
	printf("EPoX Bluetooth Presenter software version %s\n\n", VERSION);

	printf("Usage:\n"
		"\tepox-presenter [options] [bdaddr]\n"
		"\n");

	printf("Options:\n"
		"\t-i [hciX|bdaddr]   Local HCI device or BD Address\n"
		"\t-h, --help         Display help\n"
		"\n");
}

static struct option main_options[] = {
	{ "help",	0, 0, 'h' },
	{ "device",	1, 0, 'i' },
	{ 0, 0, 0, 0 }
};

int main(int argc, char *argv[])
{
	Display *display;
	int eventbase, errorbase, majorver, minorver;
	unsigned char buf[16];
	struct sigaction sa;
	struct pollfd p;
	struct sockaddr_rc addr;
	char bda[18];
	bdaddr_t src, dst;
	uint8_t channel;
	int i, opt, sk, len;

	bacpy(&src, BDADDR_ANY);

	while ((opt = getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
		switch(opt) {
		case 'i':
			if (!strncmp(optarg, "hci", 3))
				hci_devba(atoi(optarg + 3), &src);
			else
				str2ba(optarg, &src);
			break;
		case 'h':
			usage();
			exit(0);
		default:
			exit(0);
		}
	}

	argc -= optind;
	argv += optind;
	optind = 0;

	if (argc < 1) {
		if (!search_device(&src, &dst))
			exit(0);
	} else
		str2ba(argv[0], &dst);

	if (argc < 2) {
		if (!get_channel(&src, &dst, &channel))
			channel = 1;
	} else
		channel = atoi(argv[1]);

	if ((display = XOpenDisplay(XDisplayName(NULL))) == NULL) {
		perror("Can't connect to X display");
		exit(1);
	}

	if (!XTestQueryExtension(display, &eventbase, &errorbase, &majorver, &minorver)) {
		perror("Can't find XTest support");
		exit(1);
	}

	if ((sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		perror("Can't create socket");
		exit(1);
	}

	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, &src);
	addr.rc_channel = 0;

	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		perror("Can't bind socket");
		close(sk);
		exit(1);
	}

	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, &dst);
	addr.rc_channel = channel;

	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		perror("Can't connect socket");
		close(sk);
		exit(1);
	}

	ba2str(&dst, bda);
	printf("Connected to %s on channel %d\n", bda, channel);
	printf("Press CTRL-C for hangup\n");

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

	p.fd = sk;
	p.events = POLLIN | POLLERR | POLLHUP;

	while (!__io_canceled) {
		p.revents = 0;
		if (poll(&p, 1, 100) < 1)
			continue;

		len = read(sk, buf, sizeof(buf));
		if (len < 0)
			break;

		for (i = 0; i < len; i++)
			decode_event(display, buf[i]);
	}

	printf("Disconnected\n");

	close(sk);

	return 0;
}

--------------050800050808000004070901--
