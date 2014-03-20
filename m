Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 59/62] lib: Use get_unaligned() instead of bt_get_unaligned()
Date: Thu, 20 Mar 2014 11:43:24 -0300
Message-Id: <1395326607-27068-60-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 4a67a89..d55b88f 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -381,27 +381,27 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 		d->unitSize += sizeof(int8_t);
 		break;
 	case SDP_UINT16:
-		d->val.uint16 = bt_get_unaligned((uint16_t *) value);
+		d->val.uint16 = get_unaligned((uint16_t *) value);
 		d->unitSize += sizeof(uint16_t);
 		break;
 	case SDP_INT16:
-		d->val.int16 = bt_get_unaligned((int16_t *) value);
+		d->val.int16 = get_unaligned((int16_t *) value);
 		d->unitSize += sizeof(int16_t);
 		break;
 	case SDP_UINT32:
-		d->val.uint32 = bt_get_unaligned((uint32_t *) value);
+		d->val.uint32 = get_unaligned((uint32_t *) value);
 		d->unitSize += sizeof(uint32_t);
 		break;
 	case SDP_INT32:
-		d->val.int32 = bt_get_unaligned((int32_t *) value);
+		d->val.int32 = get_unaligned((int32_t *) value);
 		d->unitSize += sizeof(int32_t);
 		break;
 	case SDP_INT64:
-		d->val.int64 = bt_get_unaligned((int64_t *) value);
+		d->val.int64 = get_unaligned((int64_t *) value);
 		d->unitSize += sizeof(int64_t);
 		break;
 	case SDP_UINT64:
-		d->val.uint64 = bt_get_unaligned((uint64_t *) value);
+		d->val.uint64 = get_unaligned((uint64_t *) value);
 		d->unitSize += sizeof(uint64_t);
 		break;
 	case SDP_UINT128:
@@ -413,11 +413,11 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 		d->unitSize += sizeof(uint128_t);
 		break;
 	case SDP_UUID16:
-		sdp_uuid16_create(&d->val.uuid, bt_get_unaligned((uint16_t *) value));
+		sdp_uuid16_create(&d->val.uuid, get_unaligned((uint16_t *) value));
 		d->unitSize += sizeof(uint16_t);
 		break;
 	case SDP_UUID32:
-		sdp_uuid32_create(&d->val.uuid, bt_get_unaligned((uint32_t *) value));
+		sdp_uuid32_create(&d->val.uuid, get_unaligned((uint32_t *) value));
 		d->unitSize += sizeof(uint32_t);
 		break;
 	case SDP_UUID128:
-- 
1.8.3.1

