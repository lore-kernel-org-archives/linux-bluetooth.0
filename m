Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 19 Oct 2006 12:30:17 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5MuNFdTrK5H0iTA"
Message-Id: <200610191230.17623.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] Headset Audio Gateway profile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_5MuNFdTrK5H0iTA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I noticed support for Handsfree AG profile in sdptool, but no Headset profile.  
This patch adds support for headset AG.

-Denis

--Boundary-00=_5MuNFdTrK5H0iTA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="headset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="headset.patch"

*** /home/dkenzior/work/utils/tools/sdptool.c	2006-10-18 16:19:45.000000000 +1000
--- sdptool.c	2006-09-05 16:10:39.000000000 +1000
***************
*** 1590,1595 ****
--- 1587,1657 ----
  	return ret;
  }
  
+ static int add_headset_ag(sdp_session_t *session, svc_info_t *si)
+ {
+ 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+ 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
+ 	sdp_profile_desc_t profile;
+ 	sdp_list_t *aproto, *proto[2];
+ 	sdp_record_t record;
+ 	uint8_t u8 = si->channel ? si->channel : 10;
+ 	uint16_t u16 = 0x17;
+ 	sdp_data_t *channel, *features;
+ 	uint8_t netid = si->network ? si->network : 0x01; // ???? profile document
+ 	sdp_data_t *network = sdp_data_alloc(SDP_UINT8, &netid);
+ 	int ret = 0;
+ 
+ 	memset(&record, 0, sizeof(sdp_record_t));
+ 	record.handle = si->handle;
+ 
+ 	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+ 	root = sdp_list_append(0, &root_uuid);
+ 	sdp_set_browse_groups(&record, root);
+ 
+ 	sdp_uuid16_create(&svclass_uuid, HEADSET_AGW_SVCLASS_ID);
+ 	svclass_id = sdp_list_append(0, &svclass_uuid);
+ 	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+ 	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+ 	sdp_set_service_classes(&record, svclass_id);
+ 
+ 	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
+ 	profile.version = 0x0100;
+ 	pfseq = sdp_list_append(0, &profile);
+ 	sdp_set_profile_descs(&record, pfseq);
+ 
+ 	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+ 	proto[0] = sdp_list_append(0, &l2cap_uuid);
+ 	apseq = sdp_list_append(0, proto[0]);
+ 
+ 	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+ 	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+ 	channel = sdp_data_alloc(SDP_UINT8, &u8);
+ 	proto[1] = sdp_list_append(proto[1], channel);
+ 	apseq = sdp_list_append(apseq, proto[1]);
+ 
+ 	aproto = sdp_list_append(0, apseq);
+ 	sdp_set_access_protos(&record, aproto);
+ 
+ 	sdp_set_info_attr(&record, "Voice Gateway", 0, 0);
+ 
+ 	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
+ 		printf("Service Record registration failed\n");
+ 		ret = -1;
+ 		goto end;
+ 	}
+ 
+ 	printf("Headset AG service registered\n");
+ 
+ end:
+ 	sdp_data_free(channel);
+ 	sdp_list_free(proto[0], 0);
+ 	sdp_list_free(proto[1], 0);
+ 	sdp_list_free(apseq, 0);
+ 	sdp_list_free(aproto, 0);
+ 
+ 	return ret;
+ }
+ 
  static int add_simaccess(sdp_session_t *session, svc_info_t *si)
  {
  	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
***************
*** 3105,3110 ****
--- 3167,3173 ----
  	{ "PRINT",	DIRECT_PRINTING_SVCLASS_ID,	add_directprint	},
  
  	{ "HS",		HEADSET_SVCLASS_ID,		add_headset	},
+         { "HSAG", 	HEADSET_AGW_SVCLASS_ID,		add_headset_ag  },
  	{ "HF",		HANDSFREE_SVCLASS_ID,		add_handsfree	},
  	{ "HFAG",	HANDSFREE_AGW_SVCLASS_ID,	add_handsfree_ag},
  	{ "SAP",	SAP_SVCLASS_ID,			add_simaccess	},

--Boundary-00=_5MuNFdTrK5H0iTA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_5MuNFdTrK5H0iTA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_5MuNFdTrK5H0iTA--
