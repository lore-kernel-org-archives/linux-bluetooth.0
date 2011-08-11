Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Add AVRCP-Metadata 1.3 Processing
Date: Thu, 11 Aug 2011 09:16:47 -0500
Cc: lucas.demarchi@profusion.mobi, luiz.dentz@gmail.com,
	david_stockwell@att.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108110916.48072.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add AVRCP-Metadata 1.3 Processing

Metadata is transferred using Vendor Dependent messages
with the Company ID set to that of the Bluetooth SIG:
0x001958.

Includes:
* Provides for fragmentation over AVCTP, both incoming and
  outgoing, when message size exceeds MTU.
  Necessary for AVRCP v1.4 (metadata browsing).
* Improved layering between AVRCP Metadata, AVRCP, and AVCTP
  for clarity and -- I hope -- easier enhancement.
* Support for following PDUs:
  - GET_CAPABILITIES
  - GET_ELEMENT_ATTRS
  - REGISTER_NOTIFICATION
  - GET_PLAY_STATUS
  - INFORM_CT_BATTERY_STATUS
* Support for following Notifications/Events:
  - PLAYBACK_STATUS_CHANGED
  - TRACK_CHANGED
  - TRACK_REACHED_END
  - TRACK_REACHED_START
  - PLAYBACK_POSITION_CHANGED
  - BATTERY_STATUS_CHANGED
* The following read-only Properties
  - Battery (status)
  - MTU (debug: will probably delete)
  - PlayInterval (notifies TG of desired play pos updates)
  - Version (version of AVRCP: 1.3)
* Implemented method: ChangeTrack (TG signals to CT that
  track has changed, plus stores metadata: Title,
  Artist, Album, Track Duration, etc.)
* Implemented method: ChangePlayback (play status of
  track on TG).
* New signal: GetPlayStatus(void), for use by CT that does
  not use asynchronous Notifications.

Signed-off-by: David Stockwell <dstockwell@frequency-one.com>
---
 audio/control.c | 1863 
++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 1715 insertions(+), 148 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 472cab2..33b2f4b 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -34,6 +34,7 @@
 #include <signal.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/uio.h>
 #include <fcntl.h>
 #include <netinet/in.h>
 
@@ -206,6 +207,14 @@
 #define	EVENT_UIDS_CHANGED			0x0C
 #define	EVENT_VOLUME_CHANGED			0x0D
 
+/* AVRCP Play Statuses */
+#define AVRCP_STATUS_STOPPED	0x00
+#define AVRCP_STATUS_PLAYING	0x01
+#define AVRCP_STATUS_PAUSED	0x02
+#define AVRCP_STATUS_FWD_SEEK	0x03
+#define AVRCP_STATUS_REV_SEEK	0x04
+#define AVRCP_STATUS_ERROR	0xFF
+
 /* BT-SIG defined Company ID for Metadata */
 #define BTSIG_COMPANY_ID	0x001958
 
@@ -229,6 +238,16 @@ struct avctp_header {
 } __attribute__ ((packed));
 #define AVCTP_HEADER_LENGTH 3
 
+struct avctp_header_first {
+	uint8_t ipid:1;
+	uint8_t cr:1;
+	uint8_t packet_type:2;
+	uint8_t transaction:4;
+	uint8_t packets;
+	uint16_t pid;
+} __attribute__ ((packed));
+#define AVCTP_HEADER_FIRST_LENGTH 4
+
 struct avrcp_header {
 	uint8_t ctype:4;
 	uint8_t _hdr0:4;
@@ -238,16 +257,6 @@ struct avrcp_header {
 } __attribute__ ((packed));
 #define AVRCP_HEADER_LENGTH 3
 
-struct avrcp_spec_avc_pdu {
-	uint8_t company_id[3];
-	uint8_t pdu_id;
-	uint8_t packet_type:2;
-	uint8_t rsvd:6;
-	uint16_t params_len;
-	uint8_t params[0];
-} __attribute__ ((packed));
-#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
-
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 struct avctp_header {
@@ -259,6 +268,16 @@ struct avctp_header {
 } __attribute__ ((packed));
 #define AVCTP_HEADER_LENGTH 3
 
+struct avctp_header_first {
+	uint8_t transaction:4;
+	uint8_t packet_type:2;
+	uint8_t cr:1;
+	uint8_t ipid:1;
+	uint8_t packets;
+	uint16_t pid;
+} __attribute__ ((packed));
+#define AVCTP_HEADER_FIRST_LENGTH 4
+
 struct avrcp_header {
 	uint8_t _hdr0:4;
 	uint8_t ctype:4;
@@ -268,16 +287,6 @@ struct avrcp_header {
 } __attribute__ ((packed));
 #define AVRCP_HEADER_LENGTH 3
 
-struct avrcp_spec_avc_pdu {
-	uint8_t company_id[3];
-	uint8_t pdu_id;
-	uint8_t rsvd:6;
-	uint8_t packet_type:2;
-	uint16_t params_len;
-	uint8_t params[0];
-} __attribute__ ((packed));
-#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
-
 #else
 #error "Unknown byte order"
 #endif
@@ -312,7 +321,7 @@ struct	avrcp_passthru {
 	struct avrcp_header	hdr;
 	uint8_t		key:7;
 	uint8_t		key_state:1;
-	uint8_t		op_len;	/* =length(company_id+op_data) */
+	uint8_t		op_len; /* =length(company_id+op_data) */
 	uint8_t		company_id[3];
 	uint8_t		op_data[];
 } __attribute__ ((packed));
@@ -355,7 +364,7 @@ struct	avrcp_passthru {
 	struct avrcp_header	hdr;
 	uint8_t		key_state:1;
 	uint8_t		key:7;
-	uint8_t		op_len;	/* =length(company_id+op_data) */
+	uint8_t		op_len; /* =length(company_id+op_data) */
 	uint8_t		company_id[3];
 	uint8_t		op_data[];
 } __attribute__ ((packed));
@@ -387,17 +396,83 @@ struct avctp_server {
 	uint32_t ct_record_id;
 };
 
+#define META_ATTR_TITLE 1
+#define META_ATTR_ARTIST 2
+#define META_ATTR_ALBUM 3
+#define META_ATTR_TRKNUM 4
+#define META_ATTR_TTLTRK 5
+#define META_ATTR_GENRE 6
+#define META_ATTR_TIME 7
+#define META_ATTR_MAX 7
+
+struct meta_elem {
+	uint8_t	*elem;
+	uint16_t elem_len;
+	uint16_t charset;
+};
+
+struct meta_elem_hdr {
+	uint32_t attr_id;
+	uint16_t charset;
+	uint16_t attr_len;
+	uint8_t  value[];
+} __attribute__ ((packed));
+
 struct control {
 	struct audio_device *dev;
 
 	avctp_state_t state;
+/*
+ *	The following transaction counter is incremented when sending
+ *	AVCTP messages
+ */
+	uint8_t	transaction;
+/*
+ *	Store role of this unit in conversation with other object
+ */
+	uint8_t role;			/* property (r/w) */
+/*
+ *	Version of AVRCP Supported
+ */
+	uint16_t version;		/* property (rw) */
+/*
+ *	Buffer allocated for receiving AVCTP packets for Commands
+ *	and Responses.
+ */
+	uint8_t *recv_buf;
+	int	recv_buf_size;
+	int	recv_buf_pos;
+	int	recv_pkts;
+	int	recv_trans_id;
+
+/*	Capabilities: Company IDs and Events Supported/Subscribed */
+
+	uint32_t cap_company_ids[16];	/* property (rw) */
+	uint8_t  cap_events[16];	/* property (rw) */
+	uint8_t  sub_events[16];
+
+/*	Track Metadata */
+
+	uint64_t trk_uuid;
+	struct meta_elem trk_elem[META_ATTR_MAX+1];
+
+/*	Play Status */
+
+	uint8_t  play_state;
+	uint32_t play_pos;
+	uint32_t play_length;
+	uint32_t play_intvl;
+
+/*	CT attributes */
+	uint8_t  ct_battery;
+	uint16_t ct_charset;
 
 	int uinput;
 
 	GIOChannel *io;
-	guint io_id;
+	guint      io_id;
 
-	uint16_t mtu;
+	uint16_t   mtu;			/* property (ro) */
 
 	gboolean target;
 
@@ -496,7 +571,7 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -552,6 +627,21 @@ static sdp_record_t *avrcp_tg_record(void)
 }
 
 /**
+ *	@brief	set_company_id: Three-byte Company_ID to AVRCP message
+ *
+ *	AVRCP uses three-byte company_ids, which must be moved from
+ *	internal form to BT/network big-endian order.
+ */
+static void set_company_id(unsigned char *cid, int company_id)
+{
+	int cid_idx;
+	for (cid_idx = 2; cid_idx >= 0; --cid_idx) {
+		*(cid+cid_idx) = company_id & 0xFF;
+		company_id >>= 8;
+	}
+}
+
+/**
  *	@brief	get_company_id: Three-byte Company_ID from AVRCP message
  *
  *	AVRCP uses three-byte company_ids, which must be converted from
@@ -590,12 +680,12 @@ static void send_key(int fd, uint16_t key, int pressed)
 }
 
 /**
- *	@brief: handle_panel_passthrough: Handles AVRCP 1.0+ PASSTHROUGH command.
+ *	@brief: handle_panel_passthrough: Handles AVRCP 1.0+ PASSTHROUGH.
  *
  *	Original version only passed the keystroke to uinput.
  *
- *	Added a Passthrough signal, with the key state AND the optional
- *	following company_id and vendor-unique message.
+ *	Added a Passthrough signal, with the key state and optional
+ *	company_id and vendor-unique message.
  */
 
 static void handle_panel_passthrough(struct control *control,
@@ -698,15 +788,6 @@ static void handle_panel_passthrough(struct control 
*control,
 		DBG("AVRCP: unknown button 0x%02X %s", avrcp->key, status);
 }
 
-/* handle vendordep pdu inside an avctp packet */
-static int handle_vendordep_pdu(struct control *control,
-					struct avrcp_header *avrcp,
-					int operand_count)
-{
-	avrcp->ctype = CTYPE_NOT_IMPLEMENTED;
-	return AVRCP_HEADER_LENGTH;
-}
-
 static void avctp_disconnected(struct audio_device *dev)
 {
 	struct control *control = dev->control;
@@ -762,8 +843,8 @@ static void avctp_set_state(struct control *control, 
avctp_state_t new_state)
 					AUDIO_CONTROL_INTERFACE,
 					"Disconnected", DBUS_TYPE_INVALID);
 		emit_property_changed(dev->conn, dev->path,
-					AUDIO_CONTROL_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &value);
+				      AUDIO_CONTROL_INTERFACE, "Connected",
+			DBUS_TYPE_BOOLEAN, &value);
 
 		if (!audio_device_is_active(dev, NULL))
 			audio_device_set_authorized(dev, FALSE);
@@ -779,8 +860,8 @@ static void avctp_set_state(struct control *control, 
avctp_state_t new_state)
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_INVALID);
 		emit_property_changed(control->dev->conn, control->dev->path,
-				AUDIO_CONTROL_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &value);
+				      AUDIO_CONTROL_INTERFACE, "Connected",
+			DBUS_TYPE_BOOLEAN, &value);
 		break;
 	default:
 		error("Invalid AVCTP state %d", new_state);
@@ -795,109 +876,1144 @@ static void avctp_set_state(struct control *control, 
avctp_state_t new_state)
 	}
 }
 
-static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
+/**
+ *	@brief	avrcp_write: Called to transmit AVRCP command or response.
+ *
+ *	This function writes/sends the AVRCP message created from various
+ *	functions, wrapping it in one or more AVCTP messages.
+ *
+ *	If a message is too long to be "written" in a single packet, message
+ *	is broken into multiple packets and sent a packet at a time.
+ *
+ *	For efficiency, the AVCTP header for each packet is constructed
+ *	separately, and prepended to the avrcp message, or its fragments,
+ *	using writev.
+ *
+ *	For the AV/C control channel, AVRCP messages must not be larger
+ *	than 512 bytes. However, unless metadata is ridiculously large,
+ *	this limit should never be hit.  Therefore, there really is no
+ *	need for AVRCP-level fragmentation.
+ */
+
+static int avrcp_write(struct control *control,
+		       struct avrcp_header *avrcp, int avrcp_length)
+{
+	struct iovec buffers[2];
+	uint8_t avctp_buff[4]; /* struct avctp_header_first */
+	int socket = g_io_channel_unix_get_fd(control->io);
+	int write_length;
+
+	memset(&avctp_buff, 0, sizeof(avctp_buff));
+
+	DBG("AVRCP Write ctype %u, %i bytes.  AVCTP MTU: %i", avrcp->ctype,
+		avrcp_length, control->mtu);
+
+	if (avrcp_length+sizeof(struct avctp_header) <= control->mtu) {
+		struct avctp_header *avctp =
+					(struct avctp_header *) &avctp_buff;
+		avctp->ipid = 0;
+		if (avrcp->ctype >= CTYPE_NOT_IMPLEMENTED)
+			avctp->cr = AVCTP_RESPONSE;
+		else
+			avctp->cr = AVCTP_COMMAND;
+
+		avctp->transaction = ++(control->transaction);
+		avctp->packet_type = AVCTP_PACKET_SINGLE;
+		avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+
+		buffers[0].iov_base = (void *) avctp;
+		buffers[0].iov_len = sizeof(*avctp);
+		buffers[1].iov_base = (void *) avrcp;
+		buffers[1].iov_len = avrcp_length;
+
+		write_length = writev(socket, buffers, 2);
+		if (write_length < 0)
+			return -errno;
+
+		DBG("AVRCP wrote %i bytes.", write_length);
+
+		return write_length;
+/*
+ *	Fragment AVRCP messages longer than AVCTP MTU
+ */
+	} else {
+		int packet_length = 0;
+		int avrcp_offset = 0;
+		int avctp_packets = 0;
+		struct avctp_header_first *avctp =
+				(struct avctp_header_first *) &avctp_buff;
+
+		/*  Count number of MTU-sized fragments */
+
+		DBG("AVRCP fragmented write, %u bytes.", avrcp_length);
+		avctp_packets = 1;
+		avrcp_offset = avrcp_length - control->mtu +
+				sizeof(struct avctp_header_first);
+		while (avrcp_offset > 0) {
+			++avctp_packets;
+			avrcp_offset -= (control->mtu - 1);
+		}
+
+		/* Send first fragment */
+
+		avctp->packets = avctp_packets;
+		avctp->ipid = 0;
+		if (avrcp->ctype >= CTYPE_NOT_IMPLEMENTED) {
+			avctp->cr = AVCTP_RESPONSE;
+		} else {
+			avctp->cr = AVCTP_COMMAND;
+			control->transaction++;
+		}
+		avctp->transaction = control->transaction;
+		avctp->packet_type = AVCTP_PACKET_FIRST;
+		avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+
+		buffers[0].iov_base = (void *) avctp;
+		buffers[0].iov_len = sizeof(*avctp);
+		buffers[1].iov_base = (void *) avrcp;
+		buffers[1].iov_len = control->mtu-sizeof(*avctp);
+
+		packet_length = writev(socket, buffers, 2);
+		if (packet_length < 0)
+			return -errno;
+		avrcp_offset = buffers[1].iov_len;
+
+		/* Send second to n-1 fragments */
+
+		while ((avrcp_length-avrcp_offset) > (control->mtu-1)) {
+			avctp->packet_type = AVCTP_PACKET_CONTINUE;
+			buffers[0].iov_base = (void *) avctp;
+			buffers[0].iov_len = 1;
+			buffers[1].iov_base = (void *) avrcp+avrcp_offset;
+			buffers[1].iov_len = control->mtu - 1;
+
+			packet_length = writev(socket, buffers, 2);
+			if (packet_length < 0)
+				return -errno;
+			avrcp_offset += buffers[1].iov_len;
+		}
+
+		/* Send final fragment */
+
+		avctp->packet_type = AVCTP_PACKET_END;
+		buffers[0].iov_base = (void *) avctp;
+		buffers[0].iov_len = 1;
+		buffers[1].iov_base = (void *) avrcp + avrcp_offset;
+		buffers[1].iov_len = avrcp_length - avrcp_offset;
+
+		packet_length = writev(socket, buffers, 2);
+		if (packet_length < 0)
+			return -errno;
+		write_length = avrcp_offset + buffers[1].iov_len;
+	}
+	return write_length;
+}
+
+/**
+ *	@brief	register_notification
+ *
+ *	Confirm CT's notification request in response to the
+ *	Register Notification subscription request from the CT.
+ */
+static int register_notification(struct control *control,
+			      struct avrcp_vendor_dep *avrcp,
+			      int avrcp_length,
+			      uint8_t event_id)
+{
+	struct avrcp_vendor_dep *avrcp_resp;
+	int avrcp_resp_len = sizeof(struct avrcp_vendor_dep) + 11;
+	int write_length = 0;
+
+	avrcp_resp =
+		(struct avrcp_vendor_dep *) g_malloc0(avrcp_resp_len);
+
+	avrcp_resp->hdr.ctype = CTYPE_INTERIM;
+	avrcp_resp->hdr.subunit_id = avrcp->hdr.subunit_id;
+	avrcp_resp->hdr.subunit_type = avrcp->hdr.subunit_type;
+	avrcp_resp->hdr.opcode = avrcp->hdr.opcode;
+	set_company_id((uint8_t *)&avrcp_resp->company_id, BTSIG_COMPANY_ID);
+
+	avrcp_resp->pdu_id = avrcp->pdu_id;
+	avrcp_resp->packet_type = AVCTP_PACKET_SINGLE;
+	avrcp_resp->pdu_data[0] = event_id;
+	avrcp_resp_len = 1;
+
+	switch (event_id) {
+	case EVENT_PLAYBACK_STATUS_CHANGED: {
+		avrcp_resp->pdu_data[1] = control->play_state;
+		avrcp_resp_len++;
+		break;
+	}
+	case EVENT_TRACK_CHANGED: {
+		struct {
+			uint32_t hi;
+			uint32_t lo;
+		} track_id;
+		track_id.hi = htonl(control->trk_uuid >> 32);
+		track_id.lo = htonl(control->trk_uuid & 0xFFFFFFFF);
+		memcpy((void *) &avrcp_resp->pdu_data[1],
+			(void *) &track_id, 8);
+		avrcp_resp_len += 8;
+		break;
+	}
+	case EVENT_TRACK_REACHED_END: {
+		break;
+	}
+	case EVENT_TRACK_REACHED_START: {
+		break;
+	}
+	case EVENT_PLAYBACK_POS_CHANGED: {
+		/*
+		* Registering Event Track Position Changed:
+		* capture and save the notification interval (in seconds).
+		*/
+		uint32_t interval;
+		memcpy((void *) &interval,
+			(void *) &avrcp->pdu_data[1], 4);
+		control->play_intvl = ntohl(interval);
+
+		interval = htonl(control->play_pos);
+		memcpy((void *) &avrcp->pdu_data[1],
+			(void *) &interval, 4);
+		avrcp_resp_len += 4;
+		break;
+	}
+	case EVENT_BATT_STATUS_CHANGED: {
+		avrcp_resp->pdu_data[1] = control->ct_battery;
+		avrcp_resp_len++;
+		break;
+	}
+	case EVENT_SYSTEM_STATUS_CHANGED: {
+		avrcp_resp->pdu_data[1] = 0;
+		avrcp_resp_len++;
+		break;
+	}
+	case EVENT_PLAYER_APP_SETTING_CHANGED: {
+		avrcp_resp->pdu_data[1] = 0;
+		avrcp_resp_len++;
+		break;
+	}
+	default:
+		break;
+	}
+	avrcp_resp->length = htons(avrcp_resp_len);
+	avrcp_resp_len += sizeof(struct avrcp_vendor_dep);
+
+	write_length = avrcp_write(control,
+				   (struct avrcp_header *) avrcp_resp,
+				   avrcp_resp_len);
+
+	control->sub_events[event_id] = TRUE;
+
+	g_free(avrcp_resp);
+	return write_length;
+}
+
+/**
+ *	@brief	handle_pdu_get_companies
+ *
+ *	PDU_GET_CAPABILITIES to get list of Company_IDs supported.
+ */
+static int handle_pdu_get_companies(struct control *control,
+				    struct avrcp_vendor_dep *avrcp,
+				    int avrcp_length)
+{
+	struct avrcp_vendor_dep *avrcp_resp;
+	int i;
+	int write_length;
+	int avrcp_resp_len =
+	sizeof(struct avrcp_vendor_dep) + 2;
+	int company_id_count = 0;
+	while (control->cap_company_ids[company_id_count] > 0) {
+		avrcp_resp_len += 3;
+		company_id_count++;
+	}
+
+	avrcp_resp = (struct avrcp_vendor_dep *) g_malloc0(avrcp_resp_len);
+
+	avrcp_resp->hdr.ctype = CTYPE_STABLE;
+	avrcp_resp->hdr.subunit_id = avrcp->hdr.subunit_id;
+	avrcp_resp->hdr.subunit_type = avrcp->hdr.subunit_type;
+	avrcp_resp->hdr.opcode = avrcp->hdr.opcode;
+	set_company_id((uint8_t *) &avrcp_resp->company_id, BTSIG_COMPANY_ID);
+
+	avrcp_resp->pdu_id = avrcp->pdu_id;
+	avrcp_resp->packet_type = AVCTP_PACKET_SINGLE;
+	avrcp_resp->length = htons(avrcp_resp_len -
+				sizeof(struct avrcp_vendor_dep));
+	avrcp_resp->pdu_data[0] = 0x02;
+	avrcp_resp->pdu_data[1] = company_id_count;
+
+	for (i = 0; i < company_id_count; ++i) {
+		set_company_id(avrcp_resp->pdu_data + 2 + 3 * i,
+				control->cap_company_ids[i]);
+	};
+
+	write_length = avrcp_write(control,
+				   (struct avrcp_header *) avrcp_resp,
+				   avrcp_resp_len);
+	g_free(avrcp_resp);
+	return write_length;
+}
+
+/**
+ *	@brief	handle_pdu_get_events
+ *
+ *	PDU_GET_CAPABILITIES to get list of Notification Events supported.
+ */
+static int handle_pdu_get_events(struct control *control,
+				 struct avrcp_vendor_dep *avrcp,
+				 int avrcp_length)
+{
+	struct avrcp_vendor_dep *avrcp_resp;
+	int write_length;
+	int i = 0, i_out = 0;
+	int event_count = 0;
+	int avrcp_resp_len;
+
+	for (i = EVENT_PLAYBACK_STATUS_CHANGED;
+	     i <= 15; ++i) {
+		if (control->cap_events[i] > 0) {
+			avrcp_resp_len++;
+			event_count++;
+		}
+	     }
+
+	     avrcp_resp_len =
+	     sizeof(struct avrcp_vendor_dep) + 2 +
+	     (event_count);
+	avrcp_resp =
+	(struct avrcp_vendor_dep *)
+	g_malloc0(avrcp_resp_len);
+
+	avrcp_resp->hdr.ctype = CTYPE_STABLE;
+	avrcp_resp->hdr.subunit_id =
+	avrcp->hdr.subunit_id;
+	avrcp_resp->hdr.subunit_type =
+	avrcp->hdr.subunit_type;
+	avrcp_resp->hdr.opcode = avrcp->hdr.opcode;
+	set_company_id(
+		(uint8_t *)&avrcp_resp->company_id,
+		       BTSIG_COMPANY_ID);
+
+	avrcp_resp->pdu_id = avrcp->pdu_id;
+	avrcp_resp->packet_type = AVCTP_PACKET_SINGLE;
+	avrcp_resp->length =
+	htons(avrcp_resp_len -
+	sizeof(struct avrcp_vendor_dep));
+	avrcp_resp->pdu_data[0] = 0x03;
+	avrcp_resp->pdu_data[1] = event_count;
+
+	for (i = EVENT_PLAYBACK_STATUS_CHANGED;
+	     i <= 15; ++i) {
+		if (control->cap_events[i] > 0) {
+			avrcp_resp->pdu_data[2 + i_out] = i;
+			i_out++;
+		}
+	     }
+
+	     write_length = avrcp_write(control,
+					(struct avrcp_header *) avrcp_resp,
+					avrcp_resp_len);
+	     g_free(avrcp_resp);
+	     return write_length;
+}
+
+/**
+ *	@brief	handle_pdu_reg_notify
+ *
+ *	PDU_REGISTER_NOTIFICATION to register CT for asynchronous notifications.
+ */
+static int handle_pdu_reg_notify(struct control *control,
+				struct avrcp_vendor_dep *avrcp,
+				int avrcp_length)
+{
+	int write_length;
+
+	if (avrcp->hdr.ctype != CTYPE_NOTIFY) {
+		DBG("RegisterNotification: expected "
+		"CTYPE_NOTIFY, received: 0x%02X",
+      avrcp->hdr.ctype);
+		avrcp->hdr.ctype = CTYPE_REJECTED;
+		return avrcp_write(control,
+				   (struct avrcp_header *) avrcp,
+				   sizeof(struct avrcp_header *));
+	}
+
+	if (!control->cap_events[avrcp->pdu_data[0]]) {
+		DBG("RegisterNotification: requested "
+		"event 0x%02X not supported",
+      avrcp->pdu_data[0]);
+		avrcp->hdr.ctype = CTYPE_NOT_IMPLEMENTED;
+		return avrcp_write(control,
+				   (struct avrcp_header *) avrcp,
+				   sizeof(struct avrcp_header *));
+	}
+
+	/* Add current Event to Subscribed Event list. */
+
+	write_length = register_notification(control, avrcp, avrcp_length,
+					     avrcp->pdu_data[0]);
+	if (write_length < 0)
+		return write_length;
+
+	if (avrcp->pdu_data[0] ==
+		EVENT_PLAYBACK_POS_CHANGED) {
+		emit_property_changed(control->dev->conn,
+				      control->dev->path,
+			AUDIO_CONTROL_INTERFACE,
+			"PlayInterval",
+			DBUS_TYPE_UINT32,
+			&control->play_intvl);
+		}
+		return write_length;
+}
+
+/**
+ *	@brief	handle_pdu_get_attrs
+ *
+ *	PDU_GET_ELEMENT_ATTRS to respond with Metadata to CT.
+ */
+static int handle_pdu_get_attrs(struct control *control,
+				 struct avrcp_vendor_dep *avrcp,
+				 int avrcp_length)
+{
+	struct avrcp_vendor_dep *avrcp_resp;
+	int i = 0;
+	uint8_t *pelem;
+	int write_length;
+	int elem_length = 0, avrcp_resp_len = 0;
+
+	if (avrcp->hdr.ctype != CTYPE_STATUS) {
+		DBG("GetElementAttrs: expected CTYPE_STATUS, "
+		"received: 0x%02X", avrcp->hdr.ctype);
+		avrcp->hdr.ctype = CTYPE_REJECTED;
+		return avrcp_write(control,
+				   (struct avrcp_header *) avrcp,
+				   sizeof(struct avrcp_header));
+	}
+
+	/* Parse the list of requested elements,
+	 * calculate the total size of the metadata. */
+
+	DBG("GetElementAttrs received, %d requested",
+	    avrcp->pdu_data[8]);
+	for (i = 0; i < avrcp->pdu_data[8]; ++i) {
+		uint32_t elem_id;
+
+		memcpy(&elem_id, &(avrcp->pdu_data[9 + 4 * i]), 4);
+		elem_id = ntohl(elem_id);
+		DBG("GetElementAttr %d requested", elem_id);
+		if (elem_id > 0 && elem_id <= META_ATTR_MAX) {
+			if (control->trk_elem[elem_id].elem) {
+				elem_length +=
+					sizeof(struct meta_elem_hdr) +
+					control->trk_elem[elem_id].elem_len;
+				DBG("GetElementAttr %d, %d bytes", elem_id,
+					control->trk_elem[elem_id].elem_len);
+			} else {
+				elem_length += sizeof(struct meta_elem_hdr);
+				DBG("GetElementAttr %d: no data", elem_id);
+			}
+		} else {
+			/* Reject the GetElements call as invalid */
+		}
+	}
+	avrcp_resp_len = elem_length + sizeof(struct avrcp_vendor_dep) + 1;
+	DBG("GetElementAttr %d bytes, total %d bytes", elem_length,
+							avrcp_resp_len);
+
+	/*	Allocate a buffer for the metadata, plus the AVRCP header */
+
+	avrcp_resp = (struct avrcp_vendor_dep *) g_malloc0(avrcp_resp_len);
+
+	avrcp_resp->hdr.ctype = CTYPE_STABLE;
+	avrcp_resp->hdr.subunit_id = avrcp->hdr.subunit_id;
+	avrcp_resp->hdr.subunit_type = avrcp->hdr.subunit_type;
+	avrcp_resp->hdr.opcode = avrcp->hdr.opcode;
+	set_company_id((uint8_t *)&avrcp_resp->company_id, BTSIG_COMPANY_ID);
+	avrcp_resp->pdu_id = avrcp->pdu_id;
+	avrcp_resp->length = htons(elem_length);
+	avrcp_resp->pdu_data[0] = avrcp->pdu_data[8];
+
+	/*	Parse the list of requested elements,
+	 *	copy the metadata into the response */
+
+	pelem = (uint8_t *) avrcp_resp + sizeof(struct avrcp_vendor_dep) + 1;
+	for (i = 0; i < avrcp->pdu_data[8]; ++i) {
+		uint32_t elem_id;
+		struct meta_elem_hdr elem;
+
+		memcpy(&elem_id, &(avrcp->pdu_data[9 + 4 * i]), 4);
+		elem_id = ntohl(elem_id);
+
+		elem.attr_id = htonl(elem_id);
+		elem.attr_len = htons(control->trk_elem[elem_id].elem_len);
+		elem.charset = htons(control->trk_elem[elem_id].charset);
+
+		memcpy((void *) pelem, (void *) &elem,
+		       sizeof(struct meta_elem_hdr));
+		pelem += sizeof(struct meta_elem_hdr);
+
+		memcpy((void *) pelem,
+		       (void *) control->trk_elem[elem_id].elem,
+		       control->trk_elem[elem_id].elem_len);
+		pelem += control->trk_elem[elem_id].elem_len;
+	}
+
+	write_length = avrcp_write(control,
+				   (struct avrcp_header *) avrcp_resp,
+				   avrcp_resp_len);
+	g_free(avrcp_resp);
+	return write_length;
+}
+
+/**
+ *	@brief	handle_pdu_play_stat
+ *
+ *	PDU_GET_PLAY_STATUS to respond with Track Status to CT.
+ */
+static int handle_pdu_play_stat(struct control *control,
+				struct avrcp_vendor_dep *avrcp,
+				int avrcp_length)
+{
+	struct avrcp_vendor_dep *avrcp_resp;
+	int write_length;
+	int avrcp_resp_len = 0;
+
+	if (avrcp->hdr.ctype != CTYPE_STATUS) {
+		DBG("GetPlayStatus: expected CTYPE_STATUS, received: 0x%02X",
+						avrcp->hdr.ctype);
+		avrcp->hdr.ctype = CTYPE_REJECTED;
+		return avrcp_write(control,
+				   (struct avrcp_header *) avrcp,
+				   sizeof(struct avrcp_header));
+	}
+
+	/*	GetPlayStatus has no parameters. */
+
+	DBG("GetPlayStatus received");
+
+	g_dbus_emit_signal(control->dev->conn,
+			   control->dev->path,
+		    AUDIO_CONTROL_INTERFACE,
+		    "GetPlayStatus",
+		    DBUS_TYPE_INVALID);
+
+	/*	Allocate a buffer for the response, including AVRCP header */
+
+	avrcp_resp_len = sizeof(struct avrcp_vendor_dep) + 9;
+	avrcp_resp = (struct avrcp_vendor_dep *) g_malloc0(avrcp_resp_len);
+
+	avrcp_resp->hdr.ctype = CTYPE_STABLE;
+	avrcp_resp->hdr.subunit_id = avrcp->hdr.subunit_id;
+	avrcp_resp->hdr.subunit_type = avrcp->hdr.subunit_type;
+	avrcp_resp->hdr.opcode = avrcp->hdr.opcode;
+	set_company_id((uint8_t *) &avrcp_resp->company_id, BTSIG_COMPANY_ID);
+	avrcp_resp->pdu_id = avrcp->pdu_id;
+	avrcp_resp->length = htons(9);
+	memcpy(&avrcp_resp->pdu_data[0], &control->play_length, 4);
+	memcpy(&avrcp_resp->pdu_data[4], &control->play_pos, 4);
+	avrcp_resp->pdu_data[8] = control->play_state;
+
+	write_length = avrcp_write(control,
+				   (struct avrcp_header *) avrcp_resp,
+				   avrcp_resp_len);
+	g_free(avrcp_resp);
+	return write_length;
+}
+
+/**
+ *	@brief	handle_pdu_battery_stat
+ *
+ *	PDU_INFORM_CT_BATTERY_STAT to receive battery state from CT.
+ */
+static int handle_pdu_battery_stat(struct control *control,
+				   struct avrcp_vendor_dep *avrcp,
+				   int avrcp_length)
+{
+	if (avrcp->hdr.ctype != CTYPE_CONTROL) {
+		DBG("BatteryStatus: expected CTYPE_CONTROL, "
+				"received: 0x%02X", avrcp->hdr.ctype);
+		avrcp->hdr.ctype = CTYPE_REJECTED;
+		return avrcp_write(control, (struct avrcp_header *) avrcp,
+				   sizeof(struct avrcp_header));
+	}
+
+	/* BatteryStatus has one parameter:
+	 * store in control and emit property. */
+
+	DBG("BatteryStatus received");
+	if (control->ct_battery != avrcp->pdu_data[0]) {
+		control->ct_battery = avrcp->pdu_data[0];
+		emit_property_changed(control->dev->conn, control->dev->path,
+				      AUDIO_CONTROL_INTERFACE, "Battery",
+				      DBUS_TYPE_BYTE, &control->ct_battery);
+	}
+	/* Response is shorter...just reuse it. */
+
+	avrcp->hdr.ctype = CTYPE_STABLE;
+	avrcp->length = 0;
+
+	return avrcp_write(control, (struct avrcp_header *) avrcp,
+			   sizeof(struct avrcp_vendor_dep));
+}
+
+/**
+ *	@brief	handle_avrcp_meta_cmd
+ *
+ *	When this function is called, we already know we have a valid
+ *	AVRCP Metadata command.  From this point, we branch based on the PDU.
+ */
+static int handle_avrcp_meta_cmd(struct control *control,
+				 struct avrcp_vendor_dep *avrcp,
+				 int avrcp_length)
+{
+	switch (avrcp->pdu_id) {
+	case PDU_GET_CAPABILITIES:
+		if (avrcp->hdr.ctype != CTYPE_STATUS) {
+			DBG("GetCapabilities: expected CTYPE_STATUS, "
+				"received: 0x%02X", avrcp->hdr.ctype);
+			avrcp->hdr.ctype = CTYPE_REJECTED;
+			return avrcp_write(control,
+				(struct avrcp_header *) avrcp,
+				sizeof(struct avrcp_header *));
+		}
+		if (avrcp->pdu_data[0] == 0x02) {
+			return handle_pdu_get_companies(control,
+							avrcp, avrcp_length);
+		} else if (avrcp->pdu_data[0] == 0x03) {
+			return handle_pdu_get_events(control,
+						     avrcp, avrcp_length);
+		}
+
+		/* No other capabilities supported in AVRCP spec */
+
+		avrcp->hdr.ctype = CTYPE_REJECTED;
+		return avrcp_write(control,
+				   (struct avrcp_header *) avrcp,
+				   avrcp_length);
+
+	case PDU_REGISTER_NOTIFICATION:
+		return handle_pdu_reg_notify(control, avrcp, avrcp_length);
+
+	case PDU_GET_ELEMENT_ATTRS:
+		return handle_pdu_get_attrs(control, avrcp, avrcp_length);
+
+	case PDU_GET_PLAY_STATUS:
+		return handle_pdu_play_stat(control, avrcp, avrcp_length);
+
+	case PDU_INFORM_CT_BATTERY_STAT:
+		return handle_pdu_battery_stat(control, avrcp, avrcp_length);
+
+	case PDU_INFORM_DISPLAYABLE_CHAR_SET:
+
+	case PDU_LIST_PLAYER_APP_SETTING_ATTRS:
+	case PDU_LIST_PLAYER_APP_SETTING_VALS:
+
+	case PDU_GET_CURR_PLAYER_APP_SETTING_VALUE:
+	case PDU_SET_PLAYER_APP_SETTING_VALUE:
+
+		avrcp->hdr.ctype = CTYPE_NOT_IMPLEMENTED;
+		return avrcp_write(control,
+			(struct avrcp_header *) avrcp, avrcp_length);
+
+	/*
+		* Following cases are not implemented:
+		* Unless metadata is allowed to be unlimited, there is
+		* no case where an AVRCP packet will exceed AVC Control
+		* Channel MTU (512 bytes).
+		*/
+	case PDU_REGISTER_CONTINUING_RESPONSE:
+	case PDU_ABORT_CONTINUING_RESPONSE:
+		avrcp->hdr.ctype = CTYPE_NOT_IMPLEMENTED;
+		return avrcp_write(control,
+			(struct avrcp_header *) avrcp, avrcp_length);
+	/*
+		*	The following are all AVRCP 1.4+ PDUs.
+		*/
+	case PDU_GET_PLAYER_APP_SETTING_ATTR_TEXT:
+	case PDU_GET_PLAYER_APP_SETTING_VALUE_TEXT:
+	case PDU_SET_ABSOLUTE_VOLUME:
+	case PDU_SET_ADDRESSED_PLAYER:
+	case PDU_SET_BROWSED_PLAYER:
+	case PDU_GET_FOLDER_ITEMS:
+	case PDU_CHANGE_PATH:
+	case PDU_GET_ITEM_ATTRS:
+	case PDU_PLAY_ITEM:
+	case PDU_SEARCH:
+	case PDU_ADD_TO_NOW_PLAYING:
+		avrcp->hdr.ctype = CTYPE_NOT_IMPLEMENTED;
+		return avrcp_write(control,
+			(struct avrcp_header *) avrcp, avrcp_length);
+
+	default: /* invalid PDU */
+		avrcp->hdr.ctype = CTYPE_REJECTED;
+		return avrcp_write(control,
+			(struct avrcp_header *) avrcp, avrcp_length);
+	}
+}
+
+/**
+ *	@brief	handle_avrcp_meta_resp
+ *
+ *	When this function is called, we have a response
+ *	to our previous AVRCP Metadata command.  Branch based on the PDU.
+ *
+ *	Only used with the BlueZ as CT case (unimplemented).
+ */
+static int handle_avrcp_meta_resp(struct control *control,
+				   struct avrcp_vendor_dep *avrcp,
+				   int avrcp_length)
+{
+/*
+ *	Operating as TG, there is little reason for handling Metadata responses.
+ */
+	DBG("STUB: handle_avrcp_meta_resp");
+	return 0;
+}
+
+/**
+ *	@brief	handle_avrcp_message: Parse (assembled) AVRCP message.
+ *
+ *	This function returns the AVRCP message, which is usually contained in
+ *	a single AVCTP packet.
+ *
+ *	If multiple AVCTP packets are needed to transmit a single AVRCP message
+ *	(very short MTU), the packets are reassembled in the lower layer and
+ *	presented to this layer as a whole message.
+ */
+static int handle_avrcp_message(struct control *control,
+		struct avrcp_header *avrcp, int avrcp_length, int trans_id) {
+
+	DBG("AVRCP %p, length %d, transid %u", avrcp, avrcp_length, trans_id);
+/*
+ *	There are two fundamental cases, AVRCP messages received as Commands,
+ *	and Responses to messages sent from this system.
+ */
+	if (avrcp->ctype < CTYPE_NOT_IMPLEMENTED) {
+		DBG("AVRCP COMMAND 0x%01X, subunit_type 0x%02X, "
+			"subunit_id 0x%01X, opcode 0x%02X, length %d",
+			avrcp->ctype, avrcp->subunit_type, avrcp->subunit_id,
+			avrcp->opcode, avrcp_length);
+
+		switch (avrcp->opcode) {
+		case OP_UNITINFO: {
+			struct avrcp_unitinfo *uin =
+					(struct avrcp_unitinfo *) avrcp;
+			if (avrcp->ctype != CTYPE_STATUS) {
+				error("OP_UNITINFO received, ctype expected: "
+					"0x%02X, actual: 0x%02X",
+					CTYPE_STATUS, avrcp->ctype);
+				avrcp->ctype = CTYPE_REJECTED;
+				return avrcp_write(control,
+						   avrcp, avrcp_length);
+			}
+
+			uin->ext_code = 0x07;
+			uin->unit_type = SUBUNIT_PANEL;
+			uin->unit = 0;
+			set_company_id((uint8_t *) &uin->company_id,
+				       BTSIG_COMPANY_ID);
+
+			avrcp->ctype = CTYPE_STABLE;
+			return avrcp_write(control, avrcp,
+					   sizeof(struct avrcp_unitinfo));
+		}
+		case OP_SUBUNITINFO: {
+			struct avrcp_subunitinfo *suin =
+					(struct avrcp_subunitinfo *) avrcp;
+			if (avrcp->ctype != CTYPE_STATUS) {
+				error("OP_SUBUNITINFO received, ctype "
+					"expected: 0x%02X, actual: 0x%02X",
+					CTYPE_STATUS, avrcp->ctype);
+				avrcp->ctype = CTYPE_REJECTED;
+				return avrcp_write(control,
+						   avrcp, avrcp_length);
+			}
+
+			if (suin->page == 0) {
+				suin->subunit[0].subunit_type = SUBUNIT_PANEL;
+				suin->subunit[0].subunit_id_max = 0;
+			};
+			avrcp->ctype = CTYPE_STABLE;
+			return avrcp_write(control, avrcp,
+					   sizeof(struct avrcp_subunitinfo));
+		}
+		case OP_PASSTHROUGH: {
+			struct avrcp_passthru *pass =
+					(struct avrcp_passthru *) avrcp;
+			if (avrcp->ctype != CTYPE_CONTROL) {
+				error("OP_PASSTHROUGH received, ctype "
+					"expected: 0x%02x, actual: 0x%02X",
+					CTYPE_CONTROL, avrcp->ctype);
+				avrcp->ctype = CTYPE_REJECTED;
+				return avrcp_write(control,
+						   avrcp, avrcp_length);
+			}
+			if (avrcp->subunit_type != SUBUNIT_PANEL) {
+				error("OP_PASSTHROUGH received, not directed "
+					"to PANEL: 0x%02X",
+					avrcp->subunit_type);
+				avrcp->ctype = CTYPE_REJECTED;
+				return avrcp_write(control,
+						   avrcp, avrcp_length);
+			}
+
+			handle_panel_passthrough(control,
+					(struct avrcp_passthru *) avrcp,
+								avrcp_length);
+
+			avrcp->ctype = CTYPE_ACCEPTED;
+			pass->op_len = 0;
+			return avrcp_write(control, avrcp,
+				offsetof(struct avrcp_passthru, company_id));
+		}
+		case OP_VENDOR_DEPENDENT: {
+			struct avrcp_vendor_dep *vend =
+					(struct avrcp_vendor_dep *) avrcp;
+			DBG("OP_VENDOR_DEPENDENT received, ctype 0x%02X",
+								avrcp->ctype);
+
+			/* If Version supported is not 1.3 or greater,
+			 * reject this call. */
+
+			if (get_company_id((uint8_t *) &vend->company_id) ==
+							BTSIG_COMPANY_ID) {
+				if (control->version >= 0x0103) {
+					return handle_avrcp_meta_cmd(control,
+								vend,
+								avrcp_length);
+				} else {
+					avrcp->ctype = CTYPE_REJECTED;
+					return avrcp_write(control,
+							   avrcp, avrcp_length);
+				}
+			}
+
+			/* FIXME: If not a standard Metadata VD message,
+			 * need to pass to the App as is via signal. */
+
+			avrcp->ctype = CTYPE_REJECTED;
+			return avrcp_write(control, avrcp, avrcp_length);
+		}
+		default:
+			DBG("Unknown opcode received: 0x%02X, ctype: 0x%02X",
+						avrcp->opcode, avrcp->ctype);
+			avrcp->ctype = CTYPE_REJECTED;
+			return avrcp_write(control, avrcp, avrcp_length);
+		}
+
+	/* Handle AVRCP message Responses to our Command messages */
+
+	} else {
+		DBG("AVRCP RESPONSE 0x%01X, subunit_type 0x%02X, "
+			"subunit_id 0x%01X, opcode 0x%02X, length %d",
+			avrcp->ctype, avrcp->subunit_type, avrcp->subunit_id,
+			avrcp->opcode, avrcp_length);
+
+		switch (avrcp->opcode) {
+		case OP_UNITINFO:
+			if (avrcp->ctype != CTYPE_STABLE)
+				error("OP_UNITINFO response, ctype expected: "
+						"0x%02X, actual: 0x%02X",
+						CTYPE_STABLE, avrcp->ctype);
+			break;
+
+		case OP_SUBUNITINFO:
+			if (avrcp->ctype != CTYPE_STABLE)
+				error("OP_SUBUNITINFO response, ctype "
+					"expected: 0x%02X, actual: 0x%02X",
+					CTYPE_STABLE, avrcp->ctype);
+			break;
+
+		case OP_PASSTHROUGH:
+			if (avrcp->ctype != CTYPE_ACCEPTED)
+				error("OP_PASSTHROUGH response, ctype "
+					"expected: 0x%02x, actual: 0x%02X",
+					CTYPE_ACCEPTED, avrcp->ctype);
+
+			if (avrcp->subunit_type != SUBUNIT_PANEL)
+				error("OP_PASSTHROUGH response, not directed "
+						"to PANEL: 0x%02X",
+						avrcp->subunit_type);
+			break;
+
+		case OP_VENDOR_DEPENDENT: {
+			struct avrcp_vendor_dep *vend =
+					(struct avrcp_vendor_dep *) avrcp;
+			DBG("OP_VENDOR_DEPENDENT response, ctype 0x%02x",
+								avrcp->ctype);
+			/*
+			 * FIXME: If Version supported is not 1.3 or greater,
+			 * reject this call.
+			 */
+			if (get_company_id((uint8_t *) &vend->company_id) ==
+							BTSIG_COMPANY_ID)
+				return handle_avrcp_meta_resp(control,
+							      vend,
+							      avrcp_length);
+			/*
+			* FIXME: If not a standard BT-SIG Metadata VD
+			* message, pass to the App as-is via a TBD signal.
+			*/
+			break;
+		}
+
+		default:
+			error("Unknown opcode response: 0x%02X, ctype: "
+					"0x%02X", avrcp->opcode,
+					avrcp->ctype);
+			return -1;
+		}
+		return 0;
+	}
+	return -1;
+}
+
+/**
+ *	@brief	avctp_packet_failed: Support function for avctp_packet_cb
+ *
+ *	Called to deal with unrecoverable receive/send errors when receiving
+ *	and responding to received AVCTP packets.
+ */
+static gboolean avctp_packet_failed(struct control *control)
+{
+	DBG("AVCTP session %p got disconnected", control);
+	avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
+	return FALSE;
+}
+
+/**
+ *	@brief	avctp_packet_reject: Support function for avctp_packet_cb
+ *
+ *	Called when rejecting an invalid AVCTP packet, primarily with an
+ *	PID other than AV_REMOTE_SVCLASS_ID.
+ */
+static gboolean avctp_packet_reject(struct control *control,
+			struct avctp_header *avctp, int packet_size)
+{
+	int ret;
+	int socket = g_io_channel_unix_get_fd(control->io);
+
+	ret = write(socket, (uint8_t *) avctp, packet_size);
+	if (ret != packet_size)
+		return avctp_packet_failed(control);
+
+	return TRUE;
+}
+
+/**
+ *	@brief	avctp_packet_cb: Message received from "other" device.
+ *
+ *	This function returns the AVCTP message, (soon) reassembles any
+ *	fragmented packets, then peels out the AVRCP message and presents
+ *	it to avrcp_message_cb.
+ *
+ *	This layering of received message handling should prove easier
+ *	to understand and debug (for future maintainers) than handling
+ *	all in the same callback function.
+ */
+static gboolean avctp_packet_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct control *control = data;
-	unsigned char buf[1024], *operands;
+	struct iovec buffers[2];
+	uint8_t buf[1024];
 	struct avctp_header *avctp;
 	struct avrcp_header *avrcp;
-	int ret, packet_size, operand_count, sock;
+	int ret, packet_size, socket;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
-		goto failed;
+		return avctp_packet_failed(control);
+
+	socket = g_io_channel_unix_get_fd(control->io);
+	avctp = (struct avctp_header *) buf;
+
+	/*
+	 * If not fragmented
+	 */
+	if (!control->recv_buf) {
+		ret = read(socket, buf, sizeof(buf));
+		if (ret <= 0)
+			return avctp_packet_failed(control);
+	} else {
 
-	sock = g_io_channel_unix_get_fd(control->io);
+		buffers[0].iov_base = (void *) avctp;
+		buffers[0].iov_len = 1;
+		buffers[1].iov_base = (void *) control->recv_buf +
+						control->recv_buf_pos;
+		buffers[1].iov_len = control->mtu - 1;
 
-	ret = read(sock, buf, sizeof(buf));
-	if (ret <= 0)
-		goto failed;
+		ret = readv(socket, buffers, 2);
+		if (ret <= 0)
+			return avctp_packet_failed(control);
+	}
 
 	DBG("Got %d bytes of data for AVCTP session %p", ret, control);
 
 	if ((unsigned int) ret < sizeof(struct avctp_header)) {
-		error("Too small AVCTP packet");
-		goto failed;
+		error("AVCTP packet too small");
+		return avctp_packet_failed(control);
 	}
 
 	packet_size = ret;
 
-	avctp = (struct avctp_header *) buf;
+	DBG("AVCTP %p, transaction %u, packet type %u, C/R %u, IPID %u, "
+			"PID 0x%04X", avctp,
+			avctp->transaction, avctp->packet_type,
+			avctp->cr, avctp->ipid, ntohs(avctp->pid));
+
+	if (avctp->packet_type == AVCTP_PACKET_SINGLE) {
+		if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
+			avctp->ipid = 1;
+			avctp->cr = AVCTP_RESPONSE;
+			packet_size = sizeof(struct avctp_header);
+			return avctp_packet_reject(control,
+						   avctp, packet_size);
+		}
 
-	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
+		if ((packet_size-sizeof(struct avctp_header)) <
+					sizeof(struct avrcp_header)) {
+			error("AVCTP single packet too small for "
+						"AVRCP header");
+			return avctp_packet_failed(control);
+		}
+		avrcp = (struct avrcp_header *) ((void *) avctp +
+					sizeof(struct avctp_header));
+		DBG("AVRCP %p: ctype %u, subunit id %u, subunit type %u, "
+			"opcode %u",
+			avrcp, avrcp->ctype, avrcp->subunit_id,
+			avrcp->subunit_type, avrcp->opcode);
+	} else if (avctp->packet_type == AVCTP_PACKET_FIRST) {
+		struct avctp_header_first *avctpf =
+					(struct avctp_header_first *) avctp;
+		if (avctpf->pid != htons(AV_REMOTE_SVCLASS_ID)) {
+			avctpf->ipid = 1;
+			avctpf->cr = AVCTP_RESPONSE;
+			packet_size = sizeof(struct avctp_header_first);
+			return avctp_packet_reject(control,
+						   avctp, packet_size);
+		}
+		if ((packet_size-sizeof(struct avctp_header_first)) <
+			sizeof(struct avrcp_header)) {
+			error("AVCTP first packet too small for AVRCP header");
+			return avctp_packet_failed(control);
+		}
+		avrcp = (struct avrcp_header *) ((void *) avctpf +
+					sizeof(struct avctp_header_first));
+		DBG("AVRCP %p: ctype %u, subunit id %u, subunit type %u, "
+			"opcode %u",
+			avrcp, avrcp->ctype, avrcp->subunit_id,
+			avrcp->subunit_type, avrcp->opcode);
+	}
+
+	/* Make sure the AVCTP cr matches the AVRCP ctype */
+
+	if (avctp->packet_type == AVCTP_PACKET_SINGLE ||
+		avctp->packet_type == AVCTP_PACKET_FIRST) {
+		if (!avctp->cr && avrcp->ctype >= CTYPE_NOT_IMPLEMENTED) {
+			error("AVRCP Response code 0x%02X received "
+				"in AVCTP Command packet", avrcp->ctype);
+			avctp->cr = AVCTP_RESPONSE;
+			avrcp->ctype = CTYPE_REJECTED;
+			/* Fragmented Packet in Progress := FALSE */
+			packet_size = sizeof(struct avrcp_header);
+			return avctp_packet_reject(control,
+						   avctp, packet_size);
+
+
+		} else if (avctp->cr && avrcp->ctype < CTYPE_NOT_IMPLEMENTED) {
+			error("AVRCP Command code 0x%02X received "
+				"in AVCTP Response packet", avrcp->ctype);
+			avctp->cr = AVCTP_RESPONSE;
+			avrcp->ctype = CTYPE_REJECTED;
+			packet_size = sizeof(struct avrcp_header);
+			/* Fragmented Packet in Progress := FALSE */
+			return avctp_packet_reject(control,
+						   avctp, packet_size);
+		}
+	}
+
+	switch (avctp->packet_type) {
+	case AVCTP_PACKET_SINGLE: {
+		DBG("AVCTP transaction %u, pk type %u, C/R %u, IPID %u, "
 			"PID 0x%04X",
 			avctp->transaction, avctp->packet_type,
 			avctp->cr, avctp->ipid, ntohs(avctp->pid));
+		avrcp = (struct avrcp_header *)
+					(buf + sizeof(struct avctp_header));
+		packet_size -= sizeof(struct avctp_header);
 
-	ret -= sizeof(struct avctp_header);
-	if ((unsigned int) ret < sizeof(struct avrcp_header)) {
-		error("Too small AVRCP packet");
-		goto failed;
-	}
+		/* If (Fragmented Packet in Progress),
+		 * Single packet acceptable only if Passthrough */
 
-	avrcp = (struct avrcp_header *) (buf + sizeof(struct avctp_header));
+		return handle_avrcp_message(control,
+					    avrcp, packet_size,
+					    avctp->transaction);
+		break;
+	}
+	case AVCTP_PACKET_FIRST: {
+		struct avctp_header_first *avctpf =
+					(struct avctp_header_first *) avctp;
+		DBG("AVCTP transaction %u, pk type %u, C/R %u, IPID %u, "
+			"PID 0x%04X, packets %d",
+			avctpf->transaction, avctpf->packet_type,
+			avctpf->cr, avctpf->ipid, ntohs(avctpf->pid),
+			avctpf->packets);
+		packet_size -= sizeof(struct avctp_header_first);
+		control->recv_trans_id = avctpf->transaction;
+		control->recv_pkts = avctpf->packets - 1;
+		control->recv_buf = g_malloc(control->recv_pkts * packet_size);
+		control->recv_buf_pos = 0;
+
+		/* Copy first part of AVRCP message to recv_buf */
+
+		memcpy(control->recv_buf,
+		       buf + sizeof(struct avctp_header_first), packet_size);
+
+		/* Fragmented Packet in Progress := TRUE */
+
+		control->recv_buf_pos = packet_size;
+		break;
+	}
+	case AVCTP_PACKET_CONTINUE: {
+		/* IF NOT fragmented packet in progress, REJECT */
 
-	operands = buf + sizeof(struct avctp_header) + sizeof(struct 
avrcp_header);
-	operand_count = ret - sizeof(struct avrcp_header);
+		/* IF received trans_ID does not match first, REJECT */
 
-	DBG("AVRCP %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
-			"opcode 0x%02X, %d operands",
-			avctp->cr ? "response" : "command",
-			avrcp->ctype, avrcp->subunit_type, avrcp->subunit_id,
-			avrcp->opcode, operand_count);
-
-	if (avctp->packet_type != AVCTP_PACKET_SINGLE) {
-		avctp->cr = AVCTP_RESPONSE;
-		avrcp->ctype = CTYPE_NOT_IMPLEMENTED;
-	} else if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
-		avctp->ipid = 1;
-		avctp->cr = AVCTP_RESPONSE;
-		packet_size = sizeof(*avctp);
-	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->ctype == CTYPE_CONTROL &&
-			avrcp->subunit_type == SUBUNIT_PANEL &&
-			avrcp->opcode == OP_PASSTHROUGH) {
-		handle_panel_passthrough(control,
-					 (struct avrcp_passthru *) avrcp, ret);
-		avctp->cr = AVCTP_RESPONSE;
-		avrcp->ctype = CTYPE_ACCEPTED;
-	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->ctype == CTYPE_STATUS &&
-			(avrcp->opcode == OP_UNITINFO
-			|| avrcp->opcode == OP_SUBUNITINFO)) {
-		avctp->cr = AVCTP_RESPONSE;
-		avrcp->ctype = CTYPE_STABLE;
-		/* The first operand should be 0x07 for the UNITINFO response.
-		 * Neither AVRCP (section 22.1, page 117) nor AVC Digital
-		 * Interface Command Set (section 9.2.1, page 45) specs
-		 * explain this value but both use it */
-		if (operand_count >= 1 && avrcp->opcode == OP_UNITINFO)
-			operands[0] = 0x07;
-		if (operand_count >= 2)
-			operands[1] = SUBUNIT_PANEL << 3;
-		DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
-				"OP_UNITINFO" : "OP_SUBUNITINFO");
-	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->opcode == OP_VENDORDEP) {
-		int r_size;
-		operand_count -= 3;
-		avctp->cr = AVCTP_RESPONSE;
-		r_size = handle_vendordep_pdu(control, avrcp, operand_count);
-		packet_size = AVCTP_HEADER_LENGTH + r_size;
-	} else {
-		avctp->cr = AVCTP_RESPONSE;
-		avrcp->ctype = CTYPE_REJECTED;
+		DBG("AVCTP transaction %u, pk type %u, C/R %u, IPID %u",
+			avctp->transaction, avctp->packet_type,
+			avctp->cr, avctp->ipid);
+		control->recv_pkts--;
+		control->recv_buf_pos = 0;
+		break;
 	}
-	ret = write(sock, buf, packet_size);
-	if (ret != packet_size)
-		goto failed;
+	case AVCTP_PACKET_END: {
+		/* IF NOT fragmented packet in progress, REJECT */
 
+		DBG("AVCTP transaction %u, pk type %u, C/R %u, "
+			"IPID %u",
+			avctp->transaction, avctp->packet_type,
+			avctp->cr, avctp->ipid);
+		avrcp = (struct avrcp_header *) control->recv_buf;
+		control->recv_pkts--;
+		control->recv_buf_size =
+				control->recv_buf_pos + packet_size;
+		control->recv_buf_pos = 0;
+
+		/* Fragmented Packet in Progress := FALSE */
+		/* call avrcp_message_cb */
+
+		return handle_avrcp_message(control,
+					avrcp, packet_size,
+					avctp->transaction);
+		break;
+	}
+	default:
+		break;
+	}
 	return TRUE;
-
-failed:
-	DBG("AVCTP session %p got disconnected", control);
-	avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-	return FALSE;
 }
 
 static int uinput_create(char *name)
@@ -1011,10 +2127,15 @@ static void avctp_connect_cb(GIOChannel *chan, GError 
*err, gpointer data)
 	init_uinput(control);
 
 	avctp_set_state(control, AVCTP_STATE_CONNECTED);
+	if (control->mtu != imtu) {
+		emit_property_changed(control->dev->conn, control->dev->path,
+				      AUDIO_CONTROL_INTERFACE, "MTU",
+				      DBUS_TYPE_UINT16, &imtu);
+	}
 	control->mtu = imtu;
 	control->io_id = g_io_add_watch(chan,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) control_cb, control);
+				(GIOFunc) avctp_packet_cb, control);
 }
 
 static void auth_cb(DBusError *derr, void *user_data)
@@ -1088,7 +2209,7 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer 
data)
 		goto drop;
 
 	control->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							control_cb, control);
+						avctp_packet_cb, control);
 	return;
 
 drop:
@@ -1261,6 +2382,413 @@ void avrcp_unregister(const bdaddr_t *src)
 	connection = NULL;
 }
 
+/**
+ *	@brief	send_notification
+ *
+ *	Called to send a notification response, triggered by a
+ *	ChangeTrack or ChangePlayback method call from the TG.
+ */
+static int send_notification(struct control *control,
+				       uint8_t event_id)
+{
+	struct avrcp_vendor_dep *avrcp;
+	int avrcp_length, write_length;
+	DBG("Send Notification: %d", event_id);
+	/*
+	 * If the event is not supported or not subscribed,
+	 * there is nothing to do.
+	 */
+	if (!control->cap_events[event_id] || !control->sub_events[event_id])
+		return 1;
+
+	avrcp_length = sizeof(struct avrcp_vendor_dep) + 11;
+	avrcp = (struct avrcp_vendor_dep *) g_malloc0(avrcp_length);
+
+	avrcp->hdr.ctype = CTYPE_CHANGED;
+	avrcp->hdr.subunit_id = 0x07;
+	avrcp->hdr.subunit_type = SUBUNIT_PANEL;
+	avrcp->hdr.opcode = OP_VENDOR_DEPENDENT;
+	set_company_id((uint8_t *)&avrcp->company_id, BTSIG_COMPANY_ID);
+
+	avrcp->pdu_id = PDU_REGISTER_NOTIFICATION;
+	avrcp->packet_type = AVCTP_PACKET_SINGLE;
+	avrcp->pdu_data[0] = event_id;
+	avrcp_length = 1;
+
+	switch (event_id) {
+	case EVENT_PLAYBACK_STATUS_CHANGED: {
+		avrcp->pdu_data[1] = control->play_state;
+		avrcp_length++;
+		break;
+	}
+	case EVENT_TRACK_CHANGED: {
+		struct {
+			uint32_t hi;
+			uint32_t lo;
+		} track_id;
+		track_id.hi = htonl(control->trk_uuid >> 32);
+		track_id.lo = htonl(control->trk_uuid & 0xFFFFFFFF);
+		memcpy((void *) &avrcp->pdu_data[1],
+			(void *) &track_id, 8);
+		avrcp_length += 8;
+		break;
+	}
+	case EVENT_TRACK_REACHED_END: {
+		break;
+	}
+	case EVENT_TRACK_REACHED_START: {
+		break;
+	}
+	case EVENT_PLAYBACK_POS_CHANGED: {
+		/*
+			* Registering Event Track Position Changed:
+			* capture and save the notification interval
+			* (in seconds).
+			*/
+		uint32_t interval = htonl(control->play_pos);
+		memcpy((void *) &avrcp->pdu_data[1],
+			(void *) &interval, 4);
+		avrcp_length += 4;
+		break;
+	}
+	case EVENT_BATT_STATUS_CHANGED: {
+		avrcp->pdu_data[1] = control->ct_battery;
+		avrcp_length++;
+		break;
+	}
+	case EVENT_SYSTEM_STATUS_CHANGED: {
+		avrcp->pdu_data[1] = 0;
+		avrcp_length++;
+		break;
+	}
+	case EVENT_PLAYER_APP_SETTING_CHANGED: {
+		avrcp->pdu_data[1] = 0;
+		avrcp_length++;
+		break;
+	}
+	default:
+		break;
+	}
+	avrcp->length = htons(avrcp_length);
+	avrcp_length += sizeof(struct avrcp_vendor_dep);
+
+	write_length = avrcp_write(control,
+				   (struct avrcp_header *) avrcp,
+				   avrcp_length);
+
+	control->sub_events[event_id] = FALSE;
+
+	g_free(avrcp);
+	return write_length;
+}
+
+/**
+ *	@brief: parse_track_properties
+ *
+ *	Iterates through the dict parameter to ChangeTrack storing
+ *	metadata elements into Strings for convenience in sending
+ *	on to CT.
+ */
+static int parse_track_properties(DBusMessageIter *props,
+				  struct control *control,
+				  uint64_t tmp_trkid)
+{
+	const char *tmp_title, *tmp_artist, *tmp_album, *tmp_genre;
+	dbus_int32_t tmp_trknum = -1, tmp_numtrks = -1, tmp_trkdur = -1;
+	gboolean has_title = FALSE;
+
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		DBG("Key %s returned", key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "Title") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &tmp_title);
+			DBG("%s %s returned", key, tmp_title);
+			has_title = TRUE;
+		} else if (strcasecmp(key, "Artist") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &tmp_artist);
+			DBG("%s %s returned", key, tmp_artist);
+		} else if (strcasecmp(key, "Album") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &tmp_album);
+			DBG("%s %s returned", key, tmp_album);
+		} else if (strcasecmp(key, "Genre") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &tmp_genre);
+			DBG("%s %s returned", key, tmp_genre);
+		} else if (strcasecmp(key, "TrackNumber") == 0) {
+			if (var != DBUS_TYPE_INT32)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &tmp_trknum);
+			DBG("%s %d returned", key, tmp_trknum);
+		} else if (strcasecmp(key, "NumberOfTracks") == 0) {
+			if (var != DBUS_TYPE_INT32)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &tmp_numtrks);
+			DBG("%s %d returned", key, tmp_numtrks);
+		} else if (strcasecmp(key, "TrackDuration") == 0) {
+			if (var != DBUS_TYPE_INT32)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &tmp_trkdur);
+			DBG("%s %d returned", key, tmp_trkdur);
+		}
+		dbus_message_iter_next(props);
+	}
+
+	if (!tmp_title)
+		return -EINVAL;
+
+	/* Clear the previous Track-ID and Metadata from the Control block. */
+
+	if (control->trk_elem[META_ATTR_TITLE].elem)
+		g_free(control->trk_elem[META_ATTR_TITLE].elem);
+	control->trk_elem[META_ATTR_TITLE].elem_len = 0;
+
+	if (control->trk_elem[META_ATTR_ARTIST].elem)
+		g_free(control->trk_elem[META_ATTR_ARTIST].elem);
+	control->trk_elem[META_ATTR_ARTIST].elem_len = 0;
+
+	if (control->trk_elem[META_ATTR_ALBUM].elem)
+		g_free(control->trk_elem[META_ATTR_ALBUM].elem);
+	control->trk_elem[META_ATTR_ALBUM].elem_len = 0;
+
+	if (control->trk_elem[META_ATTR_GENRE].elem)
+		g_free(control->trk_elem[META_ATTR_GENRE].elem);
+	control->trk_elem[META_ATTR_GENRE].elem_len = 0;
+
+	if (control->trk_elem[META_ATTR_TRKNUM].elem)
+		g_free(control->trk_elem[META_ATTR_TRKNUM].elem);
+	control->trk_elem[META_ATTR_TRKNUM].elem_len = 0;
+
+	if (control->trk_elem[META_ATTR_TTLTRK].elem)
+		g_free(control->trk_elem[META_ATTR_TTLTRK].elem);
+	control->trk_elem[META_ATTR_TTLTRK].elem_len = 0;
+
+	if (control->trk_elem[META_ATTR_TIME].elem)
+		g_free(control->trk_elem[META_ATTR_TIME].elem);
+	control->trk_elem[META_ATTR_TIME].elem_len = 0;
+
+	/* Move the retrieved Track-ID and Metadata to the Control block. */
+
+	control->trk_uuid = tmp_trkid;
+
+	control->trk_elem[META_ATTR_TITLE].elem =
+					(uint8_t *) g_strdup(tmp_title);
+	control->trk_elem[META_ATTR_TITLE].elem_len =
+					strlen(tmp_title);
+	control->trk_elem[META_ATTR_TITLE].charset =
+					control->ct_charset;
+
+	if (tmp_artist) {
+		control->trk_elem[META_ATTR_ARTIST].elem =
+					(uint8_t *) g_strdup(tmp_artist);
+		control->trk_elem[META_ATTR_ARTIST].elem_len =
+					strlen(tmp_artist);
+		control->trk_elem[META_ATTR_ARTIST].charset =
+					control->ct_charset;
+	}
+
+	if (tmp_album) {
+		control->trk_elem[META_ATTR_ALBUM].elem =
+					(uint8_t *) g_strdup(tmp_album);
+		control->trk_elem[META_ATTR_ALBUM].elem_len =
+					strlen(tmp_album);
+		control->trk_elem[META_ATTR_ALBUM].charset =
+					control->ct_charset;
+	}
+
+	if (tmp_genre) {
+		control->trk_elem[META_ATTR_GENRE].elem =
+					(uint8_t *) g_strdup(tmp_genre);
+		control->trk_elem[META_ATTR_GENRE].elem_len =
+					strlen(tmp_genre);
+		control->trk_elem[META_ATTR_GENRE].charset =
+					control->ct_charset;
+	}
+
+	if (tmp_trknum >= 0) {
+		control->trk_elem[META_ATTR_TRKNUM].elem =
+			(uint8_t *) g_strdup_printf("%d", tmp_trknum);
+		control->trk_elem[META_ATTR_TRKNUM].elem_len =
+			strlen((const char *)
+				control->trk_elem[META_ATTR_TRKNUM].elem);
+		control->trk_elem[META_ATTR_TRKNUM].charset =
+				control->ct_charset;
+	}
+
+	if (tmp_numtrks >= 0) {
+		control->trk_elem[META_ATTR_TTLTRK].elem =
+			(uint8_t *) g_strdup_printf("%d", tmp_numtrks);
+		control->trk_elem[META_ATTR_TTLTRK].elem_len =
+			strlen((const char *)
+				control->trk_elem[META_ATTR_TTLTRK].elem);
+		control->trk_elem[META_ATTR_TTLTRK].charset =
+				control->ct_charset;
+	}
+
+	if (tmp_trkdur >= 0) {
+		control->trk_elem[META_ATTR_TIME].elem =
+			(uint8_t *) g_strdup_printf("%d", tmp_trkdur);
+		control->trk_elem[META_ATTR_TIME].elem_len =
+			strlen((const char *)
+				control->trk_elem[META_ATTR_TIME].elem);
+		control->trk_elem[META_ATTR_TIME].charset =
+				control->ct_charset;
+	}
+
+	return 0;
+}
+
+/**
+ *	@brief: control_change_track
+ *
+ *	Implements ChangeTrack method
+ */
+static DBusMessage *control_change_track(DBusConnection *conn,
+						DBusMessage *msg,
+						void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	int write_length;
+
+	DBusMessageIter args, props;
+	uint64_t tmp_trkid, prev_trkid;
+
+	DBG("Change Track received");
+
+	prev_trkid = control->trk_uuid;
+
+	dbus_message_iter_init(msg, &args);
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_UINT64)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_get_basic(&args, &tmp_trkid);
+	dbus_message_iter_next(&args);
+
+#if __WORDSIZE == 32
+	DBG("Track ID: 0x%llx", tmp_trkid);
+#else
+	DBG("Track ID: 0x%lx", tmp_trkid);
+#endif
+
+	/* Recurse to fetch the a{sv} Hash Table */
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	if (parse_track_properties(&props, control, tmp_trkid) < 0)
+		return btd_error_invalid_args(msg);
+
+	/* Notify CT of any events triggered by change-of-track */
+
+	if (prev_trkid != (uint64_t) -1) {
+
+		if (control->play_pos == control->play_length) {
+			write_length = send_notification(control,
+						EVENT_TRACK_REACHED_END);
+			if (write_length < 0)
+				return btd_error_failed(msg,
+						strerror(-write_length));
+		}
+
+		control->play_state = AVRCP_STATUS_STOPPED;
+		write_length = send_notification(control,
+					EVENT_PLAYBACK_STATUS_CHANGED);
+		if (write_length < 0)
+			return btd_error_failed(msg, strerror(-write_length));
+	}
+
+	write_length = send_notification(control, EVENT_TRACK_CHANGED);
+	if (write_length < 0)
+		return btd_error_failed(msg, strerror(-write_length));
+
+	write_length = send_notification(control, EVENT_TRACK_REACHED_START);
+	if (write_length < 0)
+		return btd_error_failed(msg, strerror(-write_length));
+
+	return dbus_message_new_method_return(msg);
+}
+
+/**
+ *	@brief: control_change_playback
+ *
+ *	Implements ChangePlayback method
+ */
+static DBusMessage *control_change_playback(DBusConnection *conn,
+					 DBusMessage *msg,
+					 void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	int write_length;
+
+	DBusMessageIter args, props, value;
+	const char *key;
+
+	dbus_message_iter_init(msg, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_get_basic(&args, &key);
+	dbus_message_iter_next(&args);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_recurse(&props, &value);
+	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_INT32)
+		return btd_error_invalid_args(msg);
+
+	if (strcasecmp(key, "playing") == 0) {
+		dbus_message_iter_get_basic(&value, &control->play_pos);
+		control->play_state = AVRCP_STATUS_PLAYING;
+	} else if (strcasecmp(key, "stopped") == 0) {
+		control->play_state = AVRCP_STATUS_STOPPED;
+	} else if (strcasecmp(key, "paused") == 0) {
+		control->play_state = AVRCP_STATUS_PAUSED;
+	} else if (strcasecmp(key, "forward-seek") == 0) {
+		dbus_message_iter_get_basic(&value, &control->play_pos);
+		control->play_state = AVRCP_STATUS_FWD_SEEK;
+	} else if (strcasecmp(key, "reverse-seek") == 0) {
+		dbus_message_iter_get_basic(&value, &control->play_pos);
+		control->play_state = AVRCP_STATUS_REV_SEEK;
+	} else if (strcasecmp(key, "at-start") == 0) {
+		control->play_pos = 0;
+		control->play_state = AVRCP_STATUS_STOPPED;
+	} else if (strcasecmp(key, "at-end") == 0) {
+		control->play_pos = control->play_length;
+		control->play_state = AVRCP_STATUS_STOPPED;
+	} else if (strcasecmp(key, "error") == 0) {
+		control->play_state = AVRCP_STATUS_ERROR;
+	} else {
+		return btd_error_invalid_args(msg);
+	}
+
+	write_length = send_notification(control,
+					 EVENT_PLAYBACK_STATUS_CHANGED);
+	if (write_length < 0)
+		return btd_error_failed(msg, strerror(-write_length));
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *control_is_connected(DBusConnection *conn,
 						DBusMessage *msg,
 						void *data)
@@ -1282,38 +2810,36 @@ static DBusMessage 
*control_is_connected(DBusConnection *conn,
 	return reply;
 }
 
-static int avctp_send_passthrough(struct control *control, uint8_t op)
+static int avrcp_send_passthrough(struct control *control, uint8_t op)
 {
-	unsigned char buf[AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH + 2];
-	struct avctp_header *avctp = (void *) buf;
-	struct avrcp_header *avrcp = (void *) &buf[AVCTP_HEADER_LENGTH];
-	uint8_t *operands = &buf[AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH];
-	int sk = g_io_channel_unix_get_fd(control->io);
-	static uint8_t transaction = 0;
+	uint8_t buf[sizeof(struct avrcp_passthru)];
+	struct avrcp_passthru *avrcp = (void *) &buf;
+	/* Do not send anything beyond op length (zero) */
+	int avrcp_length = offsetof(struct avrcp_passthru, company_id);
+	int err;
 
 	memset(buf, 0, sizeof(buf));
 
-	avctp->transaction = transaction++;
-	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = AVCTP_COMMAND;
-	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
-
-	avrcp->ctype = CTYPE_CONTROL;
-	avrcp->subunit_type = SUBUNIT_PANEL;
-	avrcp->opcode = OP_PASSTHROUGH;
+	avrcp->hdr.ctype = CTYPE_CONTROL;
+	avrcp->hdr.subunit_type = SUBUNIT_PANEL;
+	avrcp->hdr.opcode = OP_PASSTHROUGH;
 
-	operands[0] = op & 0x7f;
-	operands[1] = 0;
+	avrcp->key = op;
+	avrcp->key_state = 0;
+	avrcp->op_len = 0;
 
-	if (write(sk, buf, sizeof(buf)) < 0)
-		return -errno;
+	err = avrcp_write(control,
+			  (struct avrcp_header *) avrcp, avrcp_length);
+	if (err < 0)
+		return err;
 
 	/* Button release */
-	avctp->transaction = transaction++;
-	operands[0] |= 0x80;
+	avrcp->key_state = 1;
 
-	if (write(sk, buf, sizeof(buf)) < 0)
-		return -errno;
+	err = avrcp_write(control,
+			  (struct avrcp_header *) avrcp, avrcp_length);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
@@ -1331,7 +2857,7 @@ static DBusMessage *volume_up(DBusConnection *conn, 
DBusMessage *msg,
 	if (!control->target)
 		return btd_error_not_supported(msg);
 
-	err = avctp_send_passthrough(control, VOL_UP_OP);
+	err = avrcp_send_passthrough(control, VOL_UP_OP);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -1351,7 +2877,7 @@ static DBusMessage *volume_down(DBusConnection *conn, 
DBusMessage *msg,
 	if (!control->target)
 		return btd_error_not_supported(msg);
 
-	err = avctp_send_passthrough(control, VOL_DOWN_OP);
+	err = avrcp_send_passthrough(control, VOL_DOWN_OP);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -1362,10 +2888,12 @@ static DBusMessage 
*control_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
+	struct control *control = device->control;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	gboolean value;
+	char *version;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1378,29 +2906,45 @@ static DBusMessage 
*control_get_properties(DBusConnection *conn,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
+	/* Battery */
+	dict_append_entry(&dict, "Battery", DBUS_TYPE_BYTE,
+			  &control->ct_battery);
 	/* Connected */
 	value = (device->control->state == AVCTP_STATE_CONNECTED);
 	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
+	/* MTU */
+	dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &control->mtu);
+	/* PlayInterval */
+	dict_append_entry(&dict, "PlayInterval", DBUS_TYPE_UINT32,
+			  &control->play_intvl);
+	/* Version */
+	version = g_strdup_printf("%d.%d", control->version / 256,
+				  control->version % 256);
+	dict_append_entry(&dict, "Version", DBUS_TYPE_STRING, &version);
 
 	dbus_message_iter_close_container(&iter, &dict);
+	g_free(version);
 
 	return reply;
 }
 
 static GDBusMethodTable control_methods[] = {
 	{ "IsConnected",	"",	"b",	control_is_connected,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
+					G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "GetProperties",	"",	"a{sv}",control_get_properties },
 	{ "VolumeUp",		"",	"",	volume_up },
 	{ "VolumeDown",		"",	"",	volume_down },
+	{ "ChangeTrack",	"ta{sv}", "",	control_change_track },
+	{ "ChangePlayback",	"si",	"",	control_change_playback },
 	{ NULL, NULL, NULL, NULL }
 };
 
 static GDBusSignalTable control_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
-	{ "PropertyChanged",		"sv"	},
-	{ "Passthrough",		"ybis"	},
+	{ "Connected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
+	{ "Disconnected",	"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
+	{ "PropertyChanged",	"sv"	},
+	{ "GetPlayStatus",	""	},
+	{ "Passthrough",	"ybis"	},
 	{ NULL, NULL }
 };
 
@@ -1451,6 +2995,29 @@ struct control *control_init(struct audio_device *dev, 
uint16_t uuid16)
 	control->state = AVCTP_STATE_DISCONNECTED;
 	control->uinput = -1;
 
+	/*
+	 * FIXME: Initialize Company IDs, Event Capabilities from
+	 * gbl_ default settings, to be set from audio.conf.
+	 */
+
+	control->role = 1; /* TG */
+	control->ct_battery = 0;
+	control->ct_charset = 0x6A;	/* UTF-8 */
+
+	control->version = 0x0103;	/* AVRCP v1.3 */
+
+	control->cap_company_ids[0] = BTSIG_COMPANY_ID;
+
+	control->cap_events[EVENT_PLAYBACK_STATUS_CHANGED] = TRUE;
+	control->cap_events[EVENT_TRACK_CHANGED] = TRUE;
+	control->cap_events[EVENT_TRACK_REACHED_END] = TRUE;
+	control->cap_events[EVENT_TRACK_REACHED_START] = TRUE;
+	control->cap_events[EVENT_PLAYBACK_POS_CHANGED] = TRUE;
+
+	control->play_state = AVRCP_STATUS_STOPPED;
+	control->trk_uuid = (uint64_t) -1;
+	control->play_pos = (uint32_t) -1;
+
 	if (uuid16 == AV_REMOTE_TARGET_SVCLASS_ID)
 		control->target = TRUE;
 
-- 
1.7.4.4

