Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH] Fix SPP connection to wrong uuid
Date: Wed, 26 Nov 2014 22:10:27 +0530
Message-id: <1417020027-28570-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote device registers multiple SPP UUID, then during service search to
connect to a particular uuid, remoted device returns all the registered SPP
record. But currently this case is not handled and it will take channel
from the first record and eventually it connects to the wrong uuid

    < ACL data: handle 12 flags 0x00 dlen 24
        L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
        pat uuid-16 0x1101 (SP)
        max 65535
        aid(s) 0x0000 - 0xffff
        cont 00
    > ACL data: handle 12 flags 0x02 dlen 355
        L2CAP(d): cid 0x0040 len 351 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x15a
        count 343
        record #0
          aid 0x0000 (SrvRecHndl)
            uint 0x1000b
          aid 0x0001 (SrvClassIDList)
            < uuid-128 aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa >
          aid 0x0004 (ProtocolDescList)
            < < uuid-16 0x0100 (L2CAP) > <
            uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          aid 0x0005 (BrwGrpList)
            < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0006 (LangBaseAttrIDList)
            < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0009 (BTProfileDescList)
            < < uuid-16 0x1101 (SP) uint 0x100 > >
          aid 0x0100 (SrvName)
            str "Serial Proxy"
          aid 0x0101 (SrvDesc)
            str "Serial Proxy"
       record #1
          aid 0x0000 (SrvRecHndl)
            uint 0x1000c
          aid 0x0001 (SrvClassIDList)
            < uuid-128 bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb >
          aid 0x0004 (ProtocolDescList)
            < < uuid-16 0x0100 (L2CAP) > <
            uuid-16 0x0003 (RFCOMM) uint 0x2 > >
          aid 0x0005 (BrwGrpList)
            < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0006 (LangBaseAttrIDList)
            < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0009 (BTProfileDescList)
            < < uuid-16 0x1101 (SP) uint 0x100 > >
          aid 0x0100 (SrvName)
            str "Serial Proxy"
          aid 0x0101 (SrvDesc)
            str "Serial Proxy"
       record #2
          aid 0x0000 (SrvRecHndl)
            uint 0x1000d
          aid 0x0001 (SrvClassIDList)
            < uuid-16 0x1101 (SP) >
          aid 0x0004 (ProtocolDescList)
            < < uuid-16 0x0100 (L2CAP) > <
            uuid-16 0x0003 (RFCOMM) uint 0x3 > >
          aid 0x0005 (BrwGrpList)
            < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0006 (LangBaseAttrIDList)
            < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0009 (BTProfileDescList)
            < < uuid-16 0x1101 (SP) uint 0x100 > >
          aid 0x0100 (SrvName)
            str "Serial Proxy"
          aid 0x0101 (SrvDesc)
            str "Serial Proxy"
          cont 00

This patch iterates through the record list, finds the record with the uuid
and get the channel from that
---
 src/profile.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 637ff71..46ec6b9 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1554,6 +1554,31 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		sdp_record_t *rec = r->data;
 		sdp_list_t *protos;
 		int port;
+		char *profile_uuid;
+		sdp_list_t *svcclass = NULL;
+
+		if (sdp_get_service_classes(rec, &svcclass) < 0)
+			continue;
+
+		if (svcclass == NULL) {
+			DBG("Skipping record with no service classes");
+			continue;
+		}
+
+		profile_uuid = bt_uuid2string(svcclass->data);
+		if (!profile_uuid) {
+			sdp_list_free(svcclass, free);
+			continue;
+		}
+
+		sdp_list_free(svcclass, free);
+
+		if (g_strcmp0(profile_uuid, ext->remote_uuid) != 0) {
+			free(profile_uuid);
+			continue;
+		}
+
+		free(profile_uuid);
 
 		if (sdp_get_access_protos(rec, &protos) < 0) {
 			error("Unable to get proto list from %s record",
-- 
1.7.9.5

