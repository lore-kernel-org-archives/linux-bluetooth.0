Return-Path: <cyrus@holtmann.org>
Message-ID: <5396BCBC.2050009@remote-exploit.org>
Date: Tue, 10 Jun 2014 10:07:24 +0200
From: "mmo@remote-exploit.org" <mmo@remote-exploit.org>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Patch for bccmd
Content-Type: multipart/mixed;
 boundary="------------000406040709090400080809"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000406040709090400080809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi List,

i recently had the issue that i was required to interact with a bluecore
based device with a non-default vendorid and productid via usb. Plesae
find a small patch to introduce two new parameters. If the parameters
are omitted, the default value of 0x0a12 0x0001 will be used.

Greetings

Max Moser


--------------000406040709090400080809
Content-Type: text/x-diff;
 name="patch_bccmd_vendorid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch_bccmd_vendorid.diff"

diff -r ../orig/bluez-4.99/tools/bccmd.c tools/bccmd.c
62c62
< static inline int transport_open(int transport, char *device, speed_t bcsp_rate)
---
> static inline int transport_open(int transport, char *device, speed_t bcsp_rate, uint16_t vendorid, uint16_t productid)
69c69
< 		return csr_open_usb(device);
---
> 		return csr_open_usb(device, vendorid, productid);
1096a1097,1098
> 		"\t-p <productid>     Select the productid for usb devices (default 0x0001)\n"
> 		"\t-v <vendorid>      Select the vendorid for usb devices (default 0x0a12)\n"
1125a1128,1129
> 	{ "productid", 1, 0, 'p'},
> 	{ "vendorid", 1, 0, 'v'},
1132a1137,1139
> 	uint16_t vendorid = 0x0a12; // default vendorid
> 	uint16_t productid = 0x0001; // default productid
> 
1136c1143
< 	while ((opt=getopt_long(argc, argv, "+t:d:i:b:h", main_options, NULL)) != EOF) {
---
> 	while ((opt=getopt_long(argc, argv, "+t:d:i:b:p:v:h", main_options, NULL)) != EOF) {
1193a1201,1218
> 		case 'p':
> 			if (!strncasecmp(optarg, "0x", 2)){
> 			 productid = strtol(optarg, NULL, 16);
> 			}
> 			else{
> 			 printf("Please provide the productid in hex representation, eg. 0x0001\n");
> 			 exit(1);
> 			}
> 			break;
> 		case 'v':
> 			if (!strncasecmp(optarg, "0x", 2)){
> 			 vendorid = strtol(optarg, NULL, 16);
> 			}
> 			else{
> 			 printf("Please provide the productid in hex representation, eg. 0x0a12\n");
> 			 exit(1);
> 			}
> 			break;
1202,1204c1227
< 	argv += optind;
< 	optind = 0;
< 
---
> 	argv += optind; optind = 0; 
1210c1233
< 	if (transport_open(transport, device, bcsp_rate) < 0)
---
> 	if (transport_open(transport, device, bcsp_rate, vendorid, productid) < 0)

diff -r ../orig/bluez-4.99/tools/csr.h tools/csr.h
518c518
< int csr_open_usb(char *device);
---
> int csr_open_usb(char *device, uint16_t vendorid, uint16_t productid);

diff -r ../orig/bluez-4.99/tools/csr_usb.c tools/csr_usb.c
58c58
< int csr_open_usb(char *device)
---
> int csr_open_usb(char *device, uint16_t vendorid, uint16_t productid)
73,74c73,74
< 			if (dev->descriptor.idVendor != 0x0a12 ||
< 					dev->descriptor.idProduct != 0x0001)
---
> 			if (dev->descriptor.idVendor != vendorid ||
> 					dev->descriptor.idProduct != productid)
76c76
< 
---
> 			

--------------000406040709090400080809--
