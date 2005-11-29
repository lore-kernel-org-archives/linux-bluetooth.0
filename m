Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438C8EDE.1010309@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------070004070102020900090000"
Subject: [Bluez-devel] avrcp start
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
Date: Tue, 29 Nov 2005 10:24:46 -0700

This is a multi-part message in MIME format.
--------------070004070102020900090000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I've started an avrcp receiver in the btsco cvs.

I hope it doesn't seem like a case of extreme laziness to put the sdp
stuff in sdptool. I suppose I should get serious and put it in my app
too. Did I write the patch right with regard to protocol names, etc?

Also, is there a separate UUID for AVRCP? I only found AVCTP UUID
definitions, but it seems like PID in the AVCTP header needs to indicate
AVRCP specifically.

With the changes above, I got my headset to connect but it seems to put
in the value "0e11" for the pid in the first AVRCP packet I got out of it.

Brad

--------------070004070102020900090000
Content-Type: text/x-patch;
 name="sdptool-avrcp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdptool-avrcp.patch"

Index: tools/sdptool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/sdptool.c,v
retrieving revision 1.35
diff -u -r1.35 sdptool.c
--- tools/sdptool.c	16 Sep 2005 04:18:46 -0000	1.35
+++ tools/sdptool.c	29 Nov 2005 17:16:38 -0000
@@ -2052,6 +2052,65 @@
 	return ret;
 }
 
+static int add_avrcp(sdp_session_t *session, svc_info_t *si)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap, avdtp, a2snk;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t record;
+	sdp_data_t *psm, *version;
+	uint16_t lp = 0x0019, ver = 0x0100;
+	int ret = 0;
+
+	memset((void *)&record, 0, sizeof(sdp_record_t));
+	record.handle = 0xffffffff;
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(&record, root);
+
+	sdp_uuid16_create(&a2snk, AV_REMOTE_TARGET_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &a2snk);
+	sdp_set_service_classes(&record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_TARGET_PROFILE_ID);
+	profile[0].version = 0x0100;
+	pfseq = sdp_list_append(0, &profile[0]);
+	sdp_set_profile_descs(&record, pfseq);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&avdtp, AVDTP_UUID);
+	proto[1] = sdp_list_append(0, &avdtp);
+	version = sdp_data_alloc(SDP_UINT16, &ver);
+	proto[1] = sdp_list_append(proto[1], version);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(&record, aproto);
+
+	sdp_set_info_attr(&record, "AVRCP TG", 0, 0);
+
+	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
+		printf("Service Record registration failed\n");
+		ret = -1;
+		goto done;
+	}
+
+	printf("AVRCP service registered\n");
+
+done:
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(aproto, 0);
+	return ret;
+}
+
 static unsigned char syncml_uuid[] = {	0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x10, 0x00,
 					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x02 };
 
@@ -2350,6 +2409,8 @@
 	{ "A2SRC",	AUDIO_SOURCE_SVCLASS_ID,	add_a2source	},
 	{ "A2SNK",	AUDIO_SINK_SVCLASS_ID,		add_a2sink	},
 
+	{ "AVRCP",      AV_REMOTE_TARGET_SVCLASS_ID,    add_avrcp       },
+
 	{ "SYNCML",	0,				add_syncml,	syncml_uuid	},
 	{ "ACTIVESYNC",	0,				add_activesync,	async_uuid	},
 	{ "HOTSYNC",	0,				add_hotsync,	hotsync_uuid	},

--------------070004070102020900090000--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
