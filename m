Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <403B08B4.1000602@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] sdp patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 24 Feb 2004 09:17:56 +0100

Hi,
in my quest to turn my computer into a handsfree device, I may propose
the following patch to sdp:


diff -ur sdp-cvs/include/sdp.h sdp/include/sdp.h
--- sdp-cvs/include/sdp.h       Tue Jun 10 18:51:07 2003
+++ sdp/include/sdp.h   Tue Feb 24 09:12:27 2004
@@ -94,6 +94,8 @@
  #define GN_SVCLASS_ID                          0x1117
  #define IMAGING_SVCLASS_ID             0x111a
  #define IMAGING_RESPONDER_SVCLASS_ID   0x111b
+#define HANDSFREE_SVCLASS_ID            0x111e
+#define HANDSFREE_AUDIO_GW_SVCLASS_ID   0x111f
  #define HID_SVCLASS_ID                 0x1124
  #define CIP_SVCLASS_ID                 0x1128
  #define PNP_INFO_SVCLASS_ID            0x1200
@@ -123,6 +125,7 @@
  #define GN_PROFILE_ID                          0x1117
  #define IMAGING_PROFILE_ID             0x111a
  #define IMAGING_RESPONDER_PROFILE_ID   0x111b
+#define HANDSFREE_PROFILE_ID            0x111e
  #define HID_PROFILE_ID                 0x1124
  #define CIP_PROFILE_ID                 0x1128

@@ -160,6 +163,8 @@
  #define SDP_ATTR_MAX_NET_ACCESSRATE     0x030C
  #define SDP_ATTR_IP4_SUBNET            0x030D
  #define SDP_ATTR_IP6_SUBNET            0x030E
+#define SDP_SUPPORTED_FEATURES          0x0311
+

  /*
   * These identifiers are based on the SDP spec stating that
--- sdp-cvs/tools/listattr.c    Fri Sep 19 17:04:22 2003
+++ sdp/tools/listattr.c        Mon Feb 23 16:13:14 2004
@@ -209,6 +209,8 @@
    { 0x1118, "DirectPrinting (BPP)", NULL, 0 },
    { 0x1119, "ReferencePrinting (BPP)", NULL, 0 },
    /* ... */
+  { 0x111e, "Handsfree", NULL, 0 },
+  { 0x111f, "HandsfreeAudioGateway", NULL, 0 },
    { 0x1120, "DirectPrintingReferenceObjectsService (BPP)", NULL, 0 },
    { 0x1121, "ReflectedUI (BPP)", NULL, 0 },
    { 0x1122, "BasicPrinting (BPP)", NULL, 0 },
Only in sdp/tools: listattr.o
Only in sdp/tools: sdptool
diff -ur sdp-cvs/tools/sdptool.c sdp/tools/sdptool.c
--- sdp-cvs/tools/sdptool.c     Sun Jul 27 20:15:22 2003
+++ sdp/tools/sdptool.c Mon Feb 23 16:40:22 2004
@@ -438,6 +438,68 @@
         return ret;
  }

+static int add_hf(sdp_session_t *session, svc_info_t *si)
+{
+       sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+       uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfco=
mm_uuid,feat_uuid;
+       sdp_profile_desc_t profile;
+       sdp_list_t *aproto, *proto[2];
+       sdp_record_t record;
+       uint8_t u8 =3D si->channel? si->channel: 3;
+       uint16_t u16 =3D 0x31;
+       sdp_data_t *channel, *features;
+       int ret =3D 0;
+
+       memset((void *)&record, 0, sizeof(sdp_record_t));
+       record.handle =3D 0xffffffff;
+       sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+       root =3D sdp_list_append(0, &root_uuid);
+       sdp_set_browse_groups(&record, root);
+
+       sdp_uuid16_create(&svclass_uuid, HANDSFREE_SVCLASS_ID);
+       svclass_id =3D sdp_list_append(0, &svclass_uuid);
+       sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+       svclass_id =3D sdp_list_append(svclass_id, &ga_svclass_uuid);
+       sdp_set_service_classes(&record, svclass_id);
+
+       sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
+       profile.version =3D 0x0101;
+       pfseq =3D sdp_list_append(0, &profile);
+       sdp_set_profile_descs(&record, pfseq);
+
+       sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+       proto[0] =3D sdp_list_append(0, &l2cap_uuid);
+       apseq =3D sdp_list_append(0, proto[0]);
+
+       sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+       proto[1] =3D sdp_list_append(0, &rfcomm_uuid);
+       channel =3D sdp_data_alloc(SDP_UINT8, &u8);
+       proto[1] =3D sdp_list_append(proto[1], channel);
+       apseq =3D sdp_list_append(apseq, proto[1]);
+
+       features =3D sdp_data_alloc(SDP_UINT16, &u16);
+       sdp_attr_add(&record, SDP_SUPPORTED_FEATURES, features);
+
+       aproto =3D sdp_list_append(0, apseq);
+       sdp_set_access_protos(&record, aproto);
+
+       sdp_set_info_attr(&record, "", 0, 0);
+
+       if (0 > sdp_record_register(session, &record, SDP_RECORD_PERSIST)=
) {
+               printf("Service Record registration failed\n");
+               ret =3D -1;
+               goto end;
+       }
+       printf("Handsfree service registered\n");
+end:
+       sdp_data_free(channel);
+       sdp_list_free(proto[0], 0);
+       sdp_list_free(proto[1], 0);
+       sdp_list_free(apseq, 0);
+       sdp_list_free(aproto, 0);
+       return ret;
+}
+
  static int add_fax(sdp_session_t *session, svc_info_t *si)
  {
         sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -848,6 +910,8 @@
         { "HID",   HID_SVCLASS_ID,            add_hid   },
         { "CIP",   CIP_SVCLASS_ID,            add_cip   },
         { "CTP",   CORDLESS_TELEPHONY_SVCLASS_ID, add_ctp },
+       { "HF",   HANDSFREE_SVCLASS_ID, add_hf },

         { 0 }
  };

BTW, no, I still don't get audio data (although the device connects the s=
co
channel)
Simon

--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=C3=BCr Pervasive Computing, Johannes Kepler Universit=C3=A4t L=
inz
Altenberger Stra=C3=9Fe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/








-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
