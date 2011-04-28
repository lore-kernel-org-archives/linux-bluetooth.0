Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 1/2] Add secure param to Mgmt PIN Code Request Event
Date: Thu, 28 Apr 2011 12:50:46 +0200
Message-ID: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update mgmt interface with secure param in pin code request event
which is part of secure pin requirement implementation.
---
 doc/mgmt-api.txt |    1 +
 lib/mgmt.h       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 925b5ad..45f6a64 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -482,6 +482,7 @@ PIN Code Request Event
 Event Code		0x000E
 Controller Index:	<controller id>
 Event Parameters	Address (6 Octets)
+			Secure (1 Octet)
 
 
 User Confirmation Request Event
diff --git a/lib/mgmt.h b/lib/mgmt.h
index f45321c..b1f71ee 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -259,6 +259,7 @@ struct mgmt_ev_connect_failed {
 #define MGMT_EV_PIN_CODE_REQUEST	0x000E
 struct mgmt_ev_pin_code_request {
 	bdaddr_t bdaddr;
+	uint8_t secure;
 } __packed;
 
 #define MGMT_EV_USER_CONFIRM_REQUEST	0x000F
-- 
1.7.1

