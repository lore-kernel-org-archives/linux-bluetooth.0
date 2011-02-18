Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 04/14] Convert UUID128 value to host order when extracting SDP data
Date: Fri, 18 Feb 2011 20:29:23 -0200
Message-Id: <1298068173-16518-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index af50a16..d5f8984 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1031,11 +1031,16 @@ int sdp_uuid_extract(const uint8_t *p, int bufsize, uuid_t *uuid, int *scanned)
 		*scanned += sizeof(uint32_t);
 		p += sizeof(uint32_t);
 	} else {
+		uint128_t n128, h128;
+
 		if (bufsize < (int) sizeof(uint128_t)) {
 			SDPERR("Not enough room for 128-bit UUID");
 			return -1;
 		}
-		sdp_uuid128_create(uuid, p);
+
+		memcpy(&n128, p, sizeof(uint128_t));
+		ntoh128(&n128, &h128);
+		sdp_uuid128_create(uuid, &h128);
 		*scanned += sizeof(uint128_t);
 		p += sizeof(uint128_t);
 	}
-- 
1.7.4.1

