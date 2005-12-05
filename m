Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43948373.9080606@masaka.cs.ohiou.edu>
From: Jim Wyllie <jwyllie@masaka.cs.ohiou.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------080104080207010702060602"
Subject: [Bluez-devel] hcitool feature patch
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
Date: Mon, 05 Dec 2005 13:14:11 -0500

This is a multi-part message in MIME format.
--------------080104080207010702060602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I had to write a program which changed the flush timeout for a Bluetooth 
connection.  I integrated it into my version of hcitool since that 
seemed the appropriate place for it.  The patch applies to hcitool in 
bluez-utils 2.22, and adds the 'ftmo' option (for flush timeout).  Let 
me know if you want me to make any changes.

Jim Wyllie
IRG Lab
Ohio University

--------------080104080207010702060602
Content-Type: text/plain;
 name="hcitool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcitool.patch"

966a967,1089
> /* Alter connection timeout (for all connections, unfortunately) */
> 
> static struct option ftmo_options[] = {
> 	{ "help",	0, 0, 'h' },
> 	{ "tmout",	1, 0, 't' },
> 	{ 0, 0, 0, 0 }
> };
> 
> static char *ftmo_help =
> 	"Usage:\n"
> 	"\tftmo --tmout=value bdaddr\n"
> 	"Sets the flush timeout value to 0.625msec * value for bdaddr\n"
> 	"Will change reliability for all connections from microcontroller\n";
> 
> static void cmd_ftmo(int dev_id, int argc, char **argv)
> {
> 	int err = 0, dd, opt, timeout;
> 	struct hci_conn_info_req *cr = 0;
> 	struct hci_request rq = { 0 };
> 	bdaddr_t *ba;
> 
> 	struct {
> 		uint16_t handle;
> 		uint16_t flush_timeout;
> 	} cmd_param;
> 
> 	struct {
> 		uint8_t  status;
> 		uint16_t handle;
> 	} cmd_response;
> 
> 	for_each_opt(opt, ftmo_options, NULL) {
> 		switch (opt) {
> 
> 		case 't':
> 			timeout = atoi( optarg );
> 
> 			if( timeout < 0) {
> 				printf("Must be 1 or greater, or 0 for no timeout\n");
> 				printf(ftmo_help);
> 			}
> 
> 			break;
> 			
> 		default:
> 			printf(ftmo_help);
> 			return;
> 		}
> 	}
> 
> 	argc -= optind;
> 	argv += optind;
> 
> 	if (argc < 1) {
> 		printf(ftmo_help);
> 		return;
> 	}
> 
> 	ba = (bdaddr_t *)malloc( sizeof( bdaddr_t ) );
> 	str2ba(argv[0], ba);
> 
> 	if (dev_id < 0) {
> 		dev_id = hci_get_route(ba);
> 		if (dev_id < 0) {
> 			perror("Error in obtaining route to device\n");
> 			return;
> 		}
> 	}
> 
> 	// find the connection handle to the specified bluetooth device
> 	cr = (struct hci_conn_info_req*) malloc(
> 	sizeof(struct hci_conn_info_req) + 
> 	sizeof(struct hci_conn_info));
> 	
> 	bacpy( &cr->bdaddr, ba );
> 	
> 	cr->type = ACL_LINK;
> 	
> 	dd = hci_open_dev( dev_id );
> 
> 	if( dd < 0 ) {
> 		err = dd;
> 		goto cleanup;
> 	}
> 
> 	err = ioctl(dd, HCIGETCONNINFO, (unsigned long) cr );
> 
> 	if( err ) {
> 		fprintf(stderr, "Could not get connection handle, is one established yet?\n");
> 		goto cleanup;
> 	}
> 
> 	// build a command packet to send to the bluetooth microcontroller
> 	cmd_param.handle = cr->conn_info->handle;
> 	cmd_param.flush_timeout = htobs(timeout);
> 	rq.ogf = OGF_HOST_CTL;
> 	rq.ocf = 0x28;
> 	rq.cparam = &cmd_param;
> 	rq.clen = sizeof(cmd_param);
> 	rq.rparam = &cmd_response;
> 	rq.rlen = sizeof(cmd_response);
> 	rq.event = EVT_CMD_COMPLETE;
> 
> 	// send the command and wait for the response
> 	err = hci_send_req( dd, &rq, 0 );
> 
> 	if( err ) {
> 		perror("Could not send request to the microcontroller");
> 		goto cleanup;
> 	}
> 
> 	if( cmd_response.status ) {
> 		err = -1;
> 		errno = bt_error(cmd_response.status);
> 	}
> 
> 	cleanup:
> 		free(cr);
> 		if( dd >= 0) 
> 		close(dd);
> 		return;
> }
> 
2055a2179
> 	{ "ftmo",   cmd_ftmo,   "Modify microcontroller flush timeout" },

--------------080104080207010702060602--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
