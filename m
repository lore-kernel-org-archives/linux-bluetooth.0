Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] sdp: Fix sdp_get_profile_descs for Mac Os X Lion
Date: Mon, 19 Mar 2012 15:04:07 +0100
Message-Id: <1332165847-12703-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mac OS X 10.7.3 publishes the following SDP record for HFP Gateway.
      record #2
          aid 0x0000 (SrvRecHndl)
             uint 0x10003
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x2 > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0006 (LangBaseAttrIDList)
             < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0009 (BTProfileDescList)
             < uuid-16 0x111e (Handsfree) uint 0x105 >
          aid 0x0100 (SrvName)
             str "Hands Free Audio Gateway"
          aid 0x0301 (SuppDataStoresList)
             uint 0x0
          aid 0x0311 (SuppFeatures)
             uint 0x0

BlueZ do not read correctly the version number of the profile.
The patch fixes this.

>From my understanding, the SDP profile descriptor is a list. The for
loop in sdp_get_profile_desc iterates that list.  Until now, bluez
expected a collection of either uuid or lists with a uuid and a
version number. This can be represented as follow:
list=(uuid, uuid, (uuid, version))

The patch fixes the situation where the profile descriptor list
contains a uuid AND a version number both on the root level and not
enclosed in a sublist. If the next item after uuid is uint16, then
this is the version number. This can be represented as follow:
list=(uuid, uuid, version, uuid, (uuid, version))

Note that core v4.0 spec. states that the Profile Descriptor
list is a data sequence of profile descriptors. Each profile descriptor
is a data sequence whose first element is a UUID and second element is
a version number. This can be represented as follow:
list=((uuid, version), (uuid, version))
---
 lib/sdp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 57f630a..97c0a08 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2064,7 +2064,12 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 		uint16_t version = 0x100;
 
 		if (SDP_IS_UUID(seq->dtd)) {
+			sdp_data_t *next = seq->next;
 			uuid = &seq->val.uuid;
+			if (next && next->dtd == SDP_UINT16) {
+				version = next->val.uint16;
+				seq = next;
+			}
 		} else if (SDP_IS_SEQ(seq->dtd)) {
 			sdp_data_t *puuid = seq->val.dataseq;
 			sdp_data_t *pVnum = seq->val.dataseq->next;
-- 
1.7.5.4

