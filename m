Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Message-Id: <1061810955.972.100.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] New SDP client library
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 25 Aug 2003 13:29:09 +0200
Content-Type: multipart/mixed; boundary="=-oy+S8oOyVSwp2B1oGrnZ"


--=-oy+S8oOyVSwp2B1oGrnZ
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Folks,

in the last two months I have done much work with the current SDP
implementation. The library is full featured and works fine for me in
all situations, but the programming interface is a mess. It is not easy
to get the service name or the number of the RFCOMM channel. You have to
play with internal SDP lists, pointer of pointer stuff and static
assigned UUID's. Since I already have rewritten most of the HCI part
from scratch for the new Bluetooth library, so I decided to also build a
new client SDP libary from scratch. I took me one day to get a first
draft of a working version and I am positiv astonished how easy it can
be.

While coding the new library I came to the conclusion that we need two
interfaces to SDP. A simple one for basic tasks like getting service
name and needed protocol information and a second full featured API
which can do everything according to spec. For the simple API I made
some assumptions to achieve a simple interface:

	1) The simple API can only deal with UUID16
	2) A request can only contain one UUID
	3) It always requests the full range of attributes
	4) It returns only a predefined number of attributes
	5) No function return dynamic allocated memory/lists

Both interfaces share two common functions, which are needed for SDP
connection creation and clearing. These functions are also present in
the current library, but I named the datatype sdp_t instead of
sdp_session_t to keep it short:

	sdp_t *sdp_connect(...);
	int sdp_close(sdp_t *sdp);

The simple API only contains three additional functions which reflects
the three request PDU's of the SDP specification:

	int sdp_service_search(sdp_t *sdp, ...);
	int sdp_service_attribute(sdp_t *sdp, ...);
	int sdp_service_search_attribute(sdp_t *sdp, ...);

All data exchange is done through the sdp_record_t datatype, a uint32_t
for the record handle and/or a UUID16 for the service class. I attached
the complete sdp.h file with all definitions of the new simple interface
to this email. And here is a little client programing example, which
gets all serial port profile records:

	sdp_t *sdp;
	sdp_record_t records[6];
	int i, num

	sdp = sdp_connect(BDADDR_ANY, bdaddr, 0);

	num = sdp_service_search_attribute(sdp, SDP_SERIAL_PORT, records, 6);

	for (i = 0; i < num; i++)
		printf("Service: %s\n", records[i].name);

	sdp_close(sdp);

The simple interface will have of course a lot of limitations, but these
can all be eliminated by using the full interface if needed. I tested
the new version with all my devices on my desktop and it works flawless.

The internal code of the library and also the full featured interface
depends only on the datatype sdp_data_t. This struct can represent the
complete SDP data definitions. No additional lists or other helper
structs are needed. It is easy to decode and encode this datatype to the
SDP binary representation and the full featured interface uses it also
for input of the UUID lists and the attribute ranges. At the moment this
part of the implementation contains only the code which is needed to
make the simple interface working.

I will now clean up the internal stuff a little bit and then place it
into the libs2 CVS instead of the "old" one. Comments?

Regards

Marcel


--=-oy+S8oOyVSwp2B1oGrnZ
Content-Disposition: attachment; filename=sdp.h
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c-header; NAME=sdp.h; CHARSET=ISO-8859-15

/*
 *
 *  Bluetooth library for the offical Linux Bluetooth protocol stack
 *
 *  Copyright (C) 2002-2003  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
 *
 *
 *  $Id: sdp.h,v 1.3 2003/07/25 21:45:52 holtmann Exp $
 */

#ifndef __SDP_H
#define __SDP_H

#ifdef __cplusplus
extern "C" {
#endif

#define SDP_SDP						0x0001
#define SDP_UDP						0x0002
#define SDP_RFCOMM					0x0003
#define SDP_TCP						0x0004
#define SDP_TCS_BIN					0x0005
#define SDP_TCS_AT					0x0006
#define SDP_OBEX					0x0008
#define SDP_IP						0x0009
#define SDP_FTP						0x000a
#define SDP_HTTP					0x000c
#define SDP_WSP						0x000e
#define SDP_BNEP					0x000f
#define SDP_UPNP					0x0010
#define SDP_HIDP					0x0011
#define SDP_HARDCOPY_CONTROL_CHANNEL			0x0012
#define SDP_HARDCOPY_DATA_CHANNEL			0x0014
#define SDP_HARDCOPY_NOTIFICATION			0x0016
#define SDP_AVCTP					0x0017
#define SDP_AVDTP					0x0019
#define SDP_CMTP					0x001b
#define SDP_UDI_C_PLANE					0x001d
#define SDP_L2CAP					0x0100

#define SDP_SERVICE_DISCOVERY_SERVER_SERVICE_CLASS_ID	0x1000
#define SDP_BROWSE_GROUP_DESCRIPTOR_SERVICE_CLASS_ID	0x1001
#define SDP_PUBLIC_BROWSE_GROUP				0x1002

#define SDP_SERIAL_PORT					0x1101
#define SDP_LAN_ACCESS_USING_PPP			0x1102
#define SDP_DIALUP_NETWORKING				0x1103
#define SDP_IRMC_SYNC					0x1104
#define SDP_OBEX_OBJECT_PUSH				0x1105
#define SDP_OBEX_FILE_TRANSFER				0x1106
#define SDP_IRMC_SYNC_COMMAND				0x1107
#define SDP_HEADSET					0x1108
#define SDP_CORDLESS_TELEPHONY				0x1109
#define SDP_AUDIO_SOURCE				0x110a
#define SDP_AUDIO_SINK					0x110b
#define SDP_AV_REMOTE_CONTROL_TARGET			0x110c
#define SDP_ADVANCED_AUDIO_DISTRIBUTION			0x110d
#define SDP_AV_REMOTE_CONTROL				0x110e
#define SDP_VIDEO_CONFERENCING				0x110f
#define SDP_INTERCOM					0x1110
#define SDP_FAX						0x1111
#define SDP_HEADSET_AUDIO_GATEWAY			0x1112
#define SDP_WAP						0x1113
#define SDP_WAP_CLIENT					0x1114
#define SDP_PANU					0x1115
#define SDP_NAP						0x1116
#define SDP_GN						0x1117
#define SDP_DIRECT_PRINTING				0x1118
#define SDP_REFERENCE_PRINTING				0x1119
#define SDP_IMAGING					0x111a
#define SDP_IMAGING_RESPONDER				0x111b
#define SDP_IMAGING_AUTOMATIC_ARCHIVE			0x111c
#define SDP_IMAGING_REFERENCED_OBJECTS			0x111d
#define SDP_HANDSFREE					0x111e
#define SDP_HANDSFREE_AUDIO_GATEWAY			0x111f
#define SDP_DIRECT_PRINTING_REFERENCE_OBJECTS_SERVICE	0x1120
#define SDP_REFLECTED_UI				0x1121
#define SDP_BASIC_PRINTING				0x1122
#define SDP_PRINTING_STATUS				0x1123
#define SDP_HUMAN_INTERFACE_DEVICE_SERVICE		0x1124
#define SDP_HARDCOPY_CABLE_REPLACEMENT			0x1125
#define SDP_HCR_PRINT					0x1126
#define SDP_HCR_SCAN					0x1127
#define SDP_COMMON_ISDN_ACCESS				0x1128
#define SDP_VIDEO_CONFERENCING_GW			0x1129
#define SDP_UDI_MT					0x112a
#define SDP_UDI_TA					0x112b
#define SDP_AUDIO_VIDEO					0x112c
#define SDP_SIM_ACCESS					0x112d

#define SDP_PNP_INFORMATION				0x1200
#define SDP_GENERIC_NETWORKING				0x1201
#define SDP_GENERIC_FILE_TRANSFER			0x1202
#define SDP_GENERIC_AUDIO				0x1203
#define SDP_GENERIC_TELEPHONY				0x1204
#define SDP_UPNP_SERVICE				0x1205
#define SDP_UPNP_IP_SERVICE				0x1206

#define SDP_ESDP_UPNP_IP_PAN				0x1300
#define SDP_ESDP_UPNP_IP_LAP				0x1301
#define SDP_ESDP_UPNP_L2CAP				0x1301

typedef uint16_t uuid16_t;

char *sdp_uuid16tostr(uuid16_t uuid);

typedef struct {
	uint32_t handle;
	uuid16_t class;
	struct {
		uuid16_t uuid;
		uint16_t psm;
		uint8_t channel;
	} proto[2];
	char name[248];
} sdp_record_t;

typedef struct {
	int sock;
	unsigned long flags;
	uint8_t pid;
	uint16_t tid;
} sdp_t;

sdp_t *sdp_connect(const bdaddr_t *src, const bdaddr_t *dst, unsigned long =
flags);
int sdp_close(sdp_t *sdp);

int sdp_service_search(sdp_t *sdp, uuid16_t uuid, uint32_t *handles, uint16=
_t count);
int sdp_service_attribute(sdp_t *sdp, uint32_t handle, sdp_record_t *record=
);
int sdp_service_search_attribute(sdp_t *sdp, uuid16_t uuid, sdp_record_t *r=
ecords, uint16_t count);

#ifdef __cplusplus
}
#endif

#endif /* __SDP_H */

--=-oy+S8oOyVSwp2B1oGrnZ--
