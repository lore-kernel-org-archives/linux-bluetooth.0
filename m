Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 10/19] sdpd-request: Fix passing zero instead of NULL
Date: Thu, 12 Apr 2012 20:33:01 +0530
Message-id: <1334243001-17016-11-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-request.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index ff00df7..93acb24 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -748,7 +748,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 			cstate_size = sdp_set_cstate_pdu(buf, &newState);
 		} else {
 			if (buf->data_size == 0)
-				sdp_append_to_buf(buf, 0, 0);
+				sdp_append_to_buf(buf, NULL, 0);
 			cstate_size = sdp_set_cstate_pdu(buf, NULL);
 		}
 	}
-- 
1.7.4.1

