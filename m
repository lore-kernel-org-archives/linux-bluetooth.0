Return-Path: <cyrus@holtmann.org>
Message-ID: <53164D5B.3030903@gmx.net>
Date: Tue, 04 Mar 2014 22:02:03 +0000
From: Benjamin Adler <benadler@gmx.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Receiving data in BLE non-connectable undirected advertisements
References: <5310A4A9.2000907@gmx.net> <D7B9B661-DFF0-4AB7-8CAD-F2ACC8FDDBE8@holtmann.org> <531446EA.6020701@gmx.net> <A2B9E0B0-27CE-45EC-A4E8-FB630C17DA14@holtmann.org>
In-Reply-To: <A2B9E0B0-27CE-45EC-A4E8-FB630C17DA14@holtmann.org>
Content-Type: multipart/mixed;
 boundary="------------000409050901010807010503"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000409050901010807010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel,

On 03.03.2014 15:28, Marcel Holtmann wrote:
> maybe you need to just read the HCI part of the Bluetooth Core specification. The tools/ibeacon.c is a perfect example on how to get started with HCI commands. You just need to figure out on how to do scanning instead of advertising.

during the last days, I fought through those 2600 pages, and I think I 
now have a rough idea how things might work. The source of my 
lescanner.c is attached, and it doesn't work yet. My questions are:

- why do you open urandom, but never use it?

- searching for the reason of "Failed to open HCI user channel", I found 
a commit log from you, saying that the HCI user channel means exclusive 
access to the device, so I'll have to disable e.g. bluetoothd. Is that a 
limitation inherent to bluetooth, or just to bluez? Is there a way to 
process those advertisements and still use bluetoothd, e.g. for skype?

- in bt_hci_register(), what is the "bt_hci_destroy_func_t destroy" 
parameter used for? It seems it's always null when used in the examples?

  - I was hoping that line 134 would cause advertising_report_callback() 
to be called when advertisements are received. Unfortunately, that's not 
the case, nothing happens. What am I missing?

  - I'm also confused by how those btle advertisements are handled, they 
seem to be a subevent/subtype of a generic btle event. How can I process 
this correctly in advertising_report_callback()?

I'd be grateful if you could give me some hints to some of these questions.

Cheers,
ben

output from lescanner:

# ./tools/lescanner
Low Energy Passive Non-Connectable Undirected Advertisement Scanner 5.15
Registering for command-complete-events...
Registering for advertising-events...
Lets see whether we can provoke an error...
Setting bt event-mask...
Setting bt le event-mask...
Setting bt le scan parameters...
Enabling le scan...
check_error_callback: succeeded
check_error_callback: succeeded
check_error_callback: succeeded
check_error_callback: succeeded



--------------000409050901010807010503
Content-Type: text/x-csrc;
 name="lescanner.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lescanner.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2011-2012  Intel Corporation
 *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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

#include <ctype.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
#include <sys/ioctl.h>
#include <sys/socket.h>

#include "monitor/mainloop.h"
#include "monitor/bt.h"
#include "src/shared/util.h"
#include "src/shared/hci.h"

static int urandom_fd;
static struct bt_hci *hci_dev;

static void shutdown_timeout(int id, void *user_data)
{
	fprintf(stdout, "shutdown_timeout()\n");
	mainloop_remove_timeout(id);

	mainloop_quit();
}

static void shutdown_complete(const void *data, uint8_t size, void *user_data)
{
	fprintf(stdout, "shutdown_complete()\n");
	unsigned int id = PTR_TO_UINT(user_data);

	shutdown_timeout(id, NULL);
}

static void shutdown_device(void)
{
	fprintf(stdout, "shutdown_device()\n");
	uint8_t enable = 0x00;
	unsigned int id;

	bt_hci_flush(hci_dev);

	id = mainloop_add_timeout(5, shutdown_timeout, NULL, NULL);

	bt_hci_send(hci_dev, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1, NULL, NULL, NULL);

	bt_hci_send(hci_dev, BT_HCI_CMD_RESET, NULL, 0, shutdown_complete, UINT_TO_PTR(id), NULL);
}

static void check_error_callback(const void *data, uint8_t size, void *user_data)
{
	uint8_t status = *((uint8_t *) data);

	if (status) {
		fprintf(stderr, "check_error_callback: error occurred, status is %d\n", status);
		shutdown_device();
		return;
	} else {
	  fprintf(stdout, "check_error_callback: succeeded\n");
	}
}

static void advertising_report_callback(const void *data, uint8_t size, void *user_data)
{
	const struct bt_hci_evt_le_adv_report *report_adv = data;
	fprintf(stdout, "Received %d reports, event-type %d.\n", report_adv->num_reports, report_adv->event_type);
}

static void command_complete_callback(const void *data, uint8_t size, void *user_data)
{
	const struct bt_hci_evt_cmd_complete *report_cmd_complete = data;
	fprintf(stdout, "command_complete, ncmd %d, opcode %d.\n", report_cmd_complete->ncmd, report_cmd_complete->opcode);
}

static void local_features_callback(const void *data, uint8_t size, void *user_data)
{
	const struct bt_hci_rsp_read_local_features *rsp = data;

	if (rsp->status) {
		fprintf(stderr, "Failed to read local features\n");
		shutdown_device();
		return;
	}

	if (!(rsp->features[4] & 0x40)) {
		fprintf(stderr, "Controller without Low Energy support\n");
		shutdown_device();
		return;
	}

	//bt_hci_send(hci_dev, BT_HCI_CMD_LE_READ_ADV_TX_POWER, NULL, 0, adv_tx_power_callback, NULL, NULL);

	// Register for command_complete events
	fprintf(stdout, "Registering for command-complete-events...\n");
	bt_hci_register(hci_dev,
			BT_HCI_EVT_CMD_COMPLETE,
			command_complete_callback, //bt_hci_callback_func_t callback,
			NULL, //void *user_data,
			NULL //bt_hci_destroy_func_t destroy TODO: ask what this does?
		       );
	
	// Register for advertising events
	fprintf(stdout, "Registering for advertising-events...\n");
	bt_hci_register(hci_dev,
			BT_HCI_EVT_LE_META_EVENT, // 0x3e is LE META Event, subevent code is 0x02 BT_HCI_EVT_LE_ADV_REPORT ??
			advertising_report_callback, //bt_hci_callback_func_t callback,
			NULL, //void *user_data,
			NULL //bt_hci_destroy_func_t destroy TODO: ask what this does?
		       );
	
	fprintf(stdout, "Lets see whether we can provoke an error...\n");
	bt_hci_register(hci_dev,
			0xff, // 0xff seems to be undefined
			advertising_report_callback, //bt_hci_callback_func_t callback,
			NULL, //void *user_data,
			NULL //bt_hci_destroy_func_t destroy TODO: ask what this does?
		       );

	// #define BT_HCI_CMD_SET_EVENT_MASK 0x0c01
	// struct bt_hci_cmd_set_event_mask {
	// uint8_t mask[8];
	// } __attribute__ ((packed));
	
	struct bt_hci_cmd_set_event_mask event_mask;
	memset(&event_mask, 0, sizeof(event_mask));
	event_mask.mask[0] = 0x20; // receive LE meta events
	// There is no BT_HCI_RSP_SET_EVENT_MASK, so we only check for errors in the callback
	fprintf(stdout, "Setting bt event-mask...\n");
	bt_hci_send(hci_dev, BT_HCI_CMD_SET_EVENT_MASK, &event_mask, sizeof(event_mask), check_error_callback, NULL, NULL);

	// #define BT_HCI_CMD_LE_SET_EVENT_MASK 0x2001
	// struct bt_hci_cmd_le_set_event_mask {
	// uint8_t mask[8];
	// } __attribute__ ((packed));

	struct bt_hci_cmd_le_set_event_mask event_mask_le;
	memset(&event_mask_le, 0, sizeof(event_mask_le));
	event_mask_le.mask[7] = 0x2; // receive only le_advertising_reports
	// There is no BT_HCI_RSP_LE_SET_EVENT_MASK, so we only check for errors in the callback
	fprintf(stdout, "Setting bt le event-mask...\n");
	bt_hci_send(hci_dev, BT_HCI_CMD_LE_SET_EVENT_MASK, &event_mask_le, sizeof(event_mask_le), check_error_callback, NULL, NULL);
	
	// #define BT_HCI_CMD_LE_SET_SCAN_PARAMETERS 0x200b
	// struct bt_hci_cmd_le_set_scan_parameters {
	// uint8_t type;
	// uint16_t interval;
	// uint16_t window;
	// uint8_t own_addr_type;
	// uint8_t filter_policy;
	// } __attribute__ ((packed));
	
	struct bt_hci_cmd_le_set_scan_parameters scan_parameters;
	memset(&scan_parameters, 0, sizeof(scan_parameters));
	scan_parameters.type = 0; // bt-core-spec 4.1, pdf-page 1255: passive scanning
	scan_parameters.interval = 0x0100; // Interval of minimum 0x10 is 16 * 0.625msec => 10 msec. Interval of maximum 0x4000 is 16384 * 0.625msec => 10240msec
	scan_parameters.window = 0x0100; // window, must be less than or equal to interval
	scan_parameters.own_addr_type = 0x0; // // bt-core-spec 4.1, pdf-page 1256: public address
	scan_parameters.filter_policy = 0x0; // // bt-core-spec 4.1, pdf-page 1256: accept all advertisements, not just from whitelist
	// There is no BT_HCI_RSP_LE_SET_SCAN_PARAMETERS, so we only check for errors in the callback
	fprintf(stdout, "Setting bt le scan parameters...\n");
	bt_hci_send(hci_dev, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS, &scan_parameters, sizeof(scan_parameters), check_error_callback, NULL, NULL);

	/* This is non-le scanning, so we try without first
	// #define BT_HCI_CMD_WRITE_SCAN_ENABLE 0x0c1a
	// struct bt_hci_cmd_write_scan_enable {
	// uint8_t enable;
	// } __attribute__ ((packed));
	
	struct bt_hci_cmd_write_scan_enable scan_enable;
	memset(&scan_enable, 0, sizeof(bt_hci_cmd_write_scan_enable));
	scan_enable.enable = 1; // enable!
	// There is no BT_HCI_RSP_WRITE_SCAN_ENABLE, so we only check for errors in the callback
	bt_hci_send(hci_dev, BT_HCI_CMD_WRITE_SCAN_ENABLE, &scan_enable, sizeof(bt_hci_cmd_write_scan_enable), check_error_callback, NULL, NULL);
	*/
	
	// #define BT_HCI_CMD_LE_SET_SCAN_ENABLE 0x200c
	// struct bt_hci_cmd_le_set_scan_enable {
	// uint8_t enable;
	// uint8_t filter_dup;
	// } __attribute__ ((packed));

	struct bt_hci_cmd_le_set_scan_enable scan_enable_le;
	memset(&scan_enable_le, 0, sizeof(scan_enable_le));
	scan_enable_le.enable = 1; // enable!
	scan_enable_le.filter_dup = 0; // do not filter out duplicates
	// There is no BT_HCI_RSP_LE_SET_SCAN_ENABLE, so we only check for errors in the callback
	fprintf(stdout, "Enabling le scan...\n");
	bt_hci_send(hci_dev, BT_HCI_CMD_LE_SET_SCAN_ENABLE, &scan_enable_le, sizeof(scan_enable_le), check_error_callback, NULL, NULL);
}


static void start_scanning(void)
{
	bt_hci_send(hci_dev, BT_HCI_CMD_RESET, NULL, 0, NULL, NULL, NULL);

#warning: bt-core-spec says not to issue commands while reset-in-progress?
	bt_hci_send(hci_dev, BT_HCI_CMD_READ_LOCAL_FEATURES, NULL, 0, local_features_callback, NULL, NULL);
}

static void signal_callback(int signum, void *user_data)
{
	static bool terminated = false;

	switch (signum) {
	case SIGINT:
	case SIGTERM:
		if (!terminated) {
			shutdown_device();
			terminated = true;
		}
		break;
	}
}

static void usage(void)
{
	printf("lescanner - Low Energy Passive Non-Connectable Undirected Advertisement Scanner\n"
		"Usage:\n");
	printf("\tlescanner [options]\n");
	printf("Options:\n"
		"\t-i, --index <num>      Use specified controller\n"
		"\t-h, --help             Show help options\n");
}

static const struct option main_options[] = {
	{ "index",   required_argument, NULL, 'i' },
	{ "version", no_argument,       NULL, 'v' },
	{ "help",    no_argument,       NULL, 'h' },
	{ }
};

int main(int argc, char *argv[])
{
	uint16_t index = 0;
	const char *str;
	sigset_t mask;
	int exit_status;

	for (;;) {
		int opt;

		opt = getopt_long(argc, argv, "i:vh", main_options, NULL);
		if (opt < 0)
			break;

		switch (opt) {
		case 'i':
			if (strlen(optarg) > 3 && !strncmp(optarg, "hci", 3))
				str = optarg + 3;
			else
				str = optarg;
			if (!isdigit(*str)) {
				usage();
				return EXIT_FAILURE;
			}
			index = atoi(str);
			break;
		case 'v':
			printf("%s\n", VERSION);
			return EXIT_SUCCESS;
		case 'h':
			usage();
			return EXIT_SUCCESS;
		default:
			return EXIT_FAILURE;
		}
	}

	if (argc - optind > 0) {
		fprintf(stderr, "Invalid command line parameters\n");
		return EXIT_FAILURE;
	}

	urandom_fd = open("/dev/urandom", O_RDONLY);
	if (urandom_fd < 0) {
		fprintf(stderr, "Failed to open /dev/urandom device\n");
		return EXIT_FAILURE;
	}

	mainloop_init();

	sigemptyset(&mask);
	sigaddset(&mask, SIGINT);
	sigaddset(&mask, SIGTERM);

	mainloop_set_signal(&mask, signal_callback, NULL, NULL);

	printf("Low Energy Passive Non-Connectable Undirected Advertisement Scanner %s\n", VERSION);

	hci_dev = bt_hci_new_user_channel(index);
	if (!hci_dev) {
		fprintf(stderr, "Failed to open HCI user channel\n");
		exit_status = EXIT_FAILURE;
		goto done;
	}

	start_scanning();

	exit_status = mainloop_run();

	bt_hci_unref(hci_dev);

done:
	close(urandom_fd);

	return exit_status;
}

--------------000409050901010807010503--
