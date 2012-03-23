Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 08/26] Bluetooth: A2MP: Define A2MP status codes
Date: Fri, 23 Mar 2012 18:13:48 +0200
Message-Id: <1332519246-16656-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

A2MP status codes copied from Bluez patch sent by Peter Krystad
<pkrystad@codeaurora.org>.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 6e6202a..c99c375 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -103,6 +103,16 @@ struct a2mp_physlink_rsp {
 	__u8	status;
 } __packed;
 
+/* A2MP response status */
+#define A2MP_STATUS_SUCCESS			0x00
+#define A2MP_STATUS_INVALID_CTRL_ID		0x01
+#define A2MP_STATUS_UNABLE_START_LINK_CREATION	0x02
+#define A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS	0x02
+#define A2MP_STATUS_COLLISION_OCCURED		0x03
+#define A2MP_STATUS_DISCONN_REQ_RECVD		0x04
+#define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
+#define A2MP_STATUS_SECURITY_VIOLATION		0x06
+
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 
-- 
1.7.9.1

