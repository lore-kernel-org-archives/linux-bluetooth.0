Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/3] Support hardcoded Nintendo Wii Remote pins
Date: Sat,  2 Apr 2011 21:51:03 +0200
Message-Id: <1301773863-16297-4-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1301773863-16297-1-git-send-email-dh.herrmann@googlemail.com>
References: <1301773863-16297-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The Nintendo Wii Remote requires the destination bluetooth address
as pincode. This changes the pin handling by skipping the agent
module and sending an hardcoded pin if the target device is a
Nintendo Wii Remote.
---
 src/event.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/src/event.c b/src/event.c
index 91343d4..ec05e95 100644
--- a/src/event.c
+++ b/src/event.c
@@ -129,6 +129,24 @@ fail:
 	error("Sending PIN code reply failed: %s (%d)", strerror(-err), -err);
 }
 
+static int get_pin(bdaddr_t *sba, bdaddr_t *dba, char *pinbuf)
+{
+	uint16_t vendor, product;
+	char src_addr[18], dst_addr[18];
+
+	ba2str(sba, src_addr);
+	ba2str(dba, dst_addr);
+	if (0 == read_device_id(src_addr, dst_addr, NULL, &vendor, &product, NULL)) {
+		/* Nintendo Wii Remote uses destination address as PIN */
+		if (vendor == 0x057e && product == 0x0306) {
+			memcpy(pinbuf, dba, 6);
+			return 6;
+		}
+	}
+
+	return read_pin_code(sba, dba, pinbuf);
+}
+
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
 {
 	struct btd_adapter *adapter;
@@ -140,7 +158,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
 		return -ENODEV;
 
 	memset(pin, 0, sizeof(pin));
-	pinlen = read_pin_code(sba, dba, pin);
+	pinlen = get_pin(sba, dba, pin);
 	if (pinlen > 0) {
 		btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
 		return 0;
-- 
1.7.4.2
