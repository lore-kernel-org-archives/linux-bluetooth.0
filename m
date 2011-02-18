Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 08/14] Change UUID128 host order on SDP PDU generation function
Date: Fri, 18 Feb 2011 20:29:27 -0200
Message-Id: <1298068173-16518-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Converts from host to network order UUID128 values when generating
the SDP pdu. Before to send through the network, SDP 128 values
need to be converted to network order.
---
 lib/sdp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 75154e9..2846585 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -897,7 +897,8 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 		src = (unsigned char *) &u32;
 		break;
 	case SDP_UUID128:
-		src = (unsigned char *) &d->val.uuid.value.uuid128;
+		hton128(&d->val.uuid.value.uuid128, &u128);
+		src = (unsigned char *) &u128;
 		break;
 	default:
 		break;
-- 
1.7.4.1

