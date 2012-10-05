Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] device: Don't use device_get_addr_type to access device address type
Date: Fri, 5 Oct 2012 14:54:36 +0200
Message-ID: <1349441679-18557-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
References: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use struct btd_device directly to access bdaddr_type member.

---
 src/device.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index b2285dd..1615747 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1529,7 +1529,6 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	struct btd_device *device = req->device;
 	sdp_list_t *seq;
 	char srcaddr[18], dstaddr[18];
-	uint8_t dst_type;
 
 	ba2str(adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
@@ -1594,9 +1593,7 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 			continue;
 		}
 
-		dst_type = device_get_addr_type(device);
-
-		store_record(srcaddr, dstaddr, dst_type, rec);
+		store_record(srcaddr, dstaddr, device->bdaddr_type, rec);
 
 		/* Copy record */
 		req->records = sdp_list_append(req->records,
-- 
1.7.9.5

